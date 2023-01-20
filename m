Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711A67553B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjATNGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjATNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:06:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B5BCE06;
        Fri, 20 Jan 2023 05:06:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CADAD660230B;
        Fri, 20 Jan 2023 13:06:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674219991;
        bh=Q5x2AtmYaA0fgZ4jp//x0TyHgSicTqhcPO5/1kpTO4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CmsJPrUv5BhTSOordLZ4nQ1PesnxSdh3BQ4Tu+d2hpQH1h+WV91YkA6dN6CN6eAgf
         0rvZ9f1X+ipOJxujYxzItFTDlYCNpXgg0T6hZmeJvicxv6PpGtNcd9C9h6usKmc5Gq
         5CBJfki6cEB7oME4uujjbuFfyB3hPI0RXkP99B+muAlS89oXR44/yKpPfgBBmiViqp
         lwkYeV451Gxe9rMSgKxUz607+/Cp03e/CXrPVPH2/UwfuVU0Iwu6/6XsEuKjUDoFx/
         0gb+Ly6vVbLvv1/Irxx5ZRSY7/MpGLi0+H28PxHT9HAVOgZJzs+5Tpn84yqvb4acVQ
         PvB1JjTj93S5g==
Message-ID: <4d277d1e-f06a-07ad-f2c3-f910880a40d7@collabora.com>
Date:   Fri, 20 Jan 2023 14:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] usb: mtu3: fix the failure of qmu stop
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Min Guo <min.guo@mediatek.com>
References: <20230119033322.21426-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230119033322.21426-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/01/23 04:33, Chunfeng Yun ha scritto:
> This happens when do stress test of uvc stream on/off which will
> enable/disable endpoints. uvc has four tx requests, and may disable
> endpoint between queue tx requests as following:
>      enable ep --> start qmu
>      queue tx request0
>      queue tx request1
>      queue tx request2 --> resume qmu
>      disable ep --> stop qmu may fail [1]
>      queue tx request3 --> will resume qmu, may cause qmu can't work
>                            when enable ep next time [2]
> 
> [1]: when the tx fifo has some data to transmit, and
>      try to stop qmu (stop ep) meanwhile resume qmu (queue tx request),
>      it may cause stop qmu timeout, then can be fixed by flushing fifo
>      when stop qmu.
> [2]: it resumes qmu again, shall stop qmu again.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reported-by: Min Guo <min.guo@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


