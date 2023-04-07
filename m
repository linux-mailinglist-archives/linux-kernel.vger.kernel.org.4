Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113586DAAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbjDGJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbjDGJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:09:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE411B9;
        Fri,  7 Apr 2023 02:09:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01E4C66031A4;
        Fri,  7 Apr 2023 10:09:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680858548;
        bh=OmRy3BTQJvyb7zaP08nHY6cTSKkLTpfgKTbifvNowaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jWw5BRxZILBXoMZf7owsL+geF1AUYnERBWyPL16Egb/i+Fio0DceOh4s50wEo5NMi
         61Pm2tpXsy3V5i4rbsoN67yrlhjliUiaYqj+0rfhH8FNM0WWApeg4WK3s6QYrAVNk6
         l07me0YDQuPhZ10eePPk7p61G9Avm0Rn2w4t23VpJV794uLsAml8DMuRFP/rzJF3QV
         whw2GNMrlr48TfA7jhlbL6lJHTt1JdwXDEI98rNAML6NOMMcZt+lZb2/RWcMMJXev9
         pVd6HNdDIYazyCvsvBnRYV9M/GX1pyzz7Ap2ZhWrrwqVKKxT4yYU+XzWCP28NDt8VR
         XPfHYsqdE9vtQ==
Message-ID: <0d4162ea-e161-5afd-8b27-92f8e53b52aa@collabora.com>
Date:   Fri, 7 Apr 2023 11:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/7] usb: mtu3: fix kernel panic at qmu transfer done
 irq handler
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20230407082937.14558-1-chunfeng.yun@mediatek.com>
 <20230407082937.14558-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230407082937.14558-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/23 10:29, Chunfeng Yun ha scritto:
> When handle qmu transfer irq, it will unlock @mtu->lock before give back
> request, if another thread handle disconnect event at the same time, and
> try to disable ep, it may lock @mtu->lock and free qmu ring, then qmu
> irq hanlder may get a NULL gpd, avoid the KE by checking gpd's value before
> handling it.
> 
> e.g.
> qmu done irq on cpu0                 thread running on cpu1
> 
> qmu_done_tx()
>    handle gpd [0]
>      mtu3_requ_complete()        mtu3_gadget_ep_disable()
>        unlock @mtu->lock
>          give back request         lock @mtu->lock
>                                      mtu3_ep_disable()
>                                        mtu3_gpd_ring_free()
>                                     unlock @mtu->lock
>        lock @mtu->lock
>      get next gpd [1]
> 
> [1]: goto [0] to handle next gpd, and next gpd may be NULL.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

NACK. You still miss the Fixes tag.

Regards,
Angelo

