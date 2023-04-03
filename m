Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C06D446D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjDCMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjDCMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:31:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB435B8;
        Mon,  3 Apr 2023 05:31:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 038ED66016BD;
        Mon,  3 Apr 2023 13:31:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680525097;
        bh=l+NahqCV5ZhkT4tyT9GA3FDFBy/pGstED610HeL/KXo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k91McU1K0wK3+baND3f+VfuBqfhpMzFOQZoiGKSqRZjmI6Gl+7yTxoJIqt4yTiF5X
         HpnfunaFLgsN+3jAVGqUUMhLS+9T5OMNEkzwNz3yNbGTgn9Io1slDD+T3fIGN3RP80
         wOTl/Tt711P+VpT4xhyvUPtkR5GJktuHYzIDDj2QmS1WWPfh/5P32pVg0BbUahZJj8
         6IlafPaJum3vE1iKh3Z6XQiv77EWoyT2oSPThNNPiZxdXtnOzubYUBMYqwx2b+UjAE
         TUXd+FH50NAyGat7laeysyriCTGuNAdqK72z+UkVOGhb8KFOgQeAYEPVFupOU1+WfN
         bZul8W2NG1d4g==
Message-ID: <1cfde490-40a4-c83b-3bd5-c9baeba5187d@collabora.com>
Date:   Mon, 3 Apr 2023 14:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/7] usb: mtu3: fix KE at qmu transfer done irq handler
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
 <20230403025230.25035-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403025230.25035-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 04:52, Chunfeng Yun ha scritto:
> When handle qmu transfer irq, it will unlock @mtu->lock before give back
> request, if another thread hanlde disconnect event at the same time, and
> try to disable ep, it may lock @mtu->lock and free qmu ring, then qmu
> irq hanlder may get a NULL gpd, avoid the KE by checking gpd's value before

KE == Kernel Error? I think you wanted to say KP == Kernel Panic instead.

Also, s/hanlder/handler/g.

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

This is a fix and needs a Fixes tag.

Regards,
Angelo


