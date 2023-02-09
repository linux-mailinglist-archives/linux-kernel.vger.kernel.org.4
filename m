Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4B6909C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBINVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBINVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:21:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C33F2D7B;
        Thu,  9 Feb 2023 05:21:18 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9573E66020C1;
        Thu,  9 Feb 2023 13:21:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675948877;
        bh=5Zwggcv6csLJeI2CM8HO2R5FA3YxEaWsL1q4vCEhuE0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hYhiRmHYAPd4d++aa+z/MEHxnotplT6a/+agw00/QYjepIBe6j5kw6oAh2pPo0bym
         jLJw4RkfPzQYgH97L6EXpWlOevTIZfCZEBFjij+/p3Ev9Dr66zzK3GFJDil3A7R4gi
         yv7vcLhkZi+a7nRYKzSfiL+7kfQPdwLjPH3s/FJC38QhvkGGdbrOCmF7J17GeZwsjU
         QTtX+Y9u0POfvOJA9cTiPuwJdnr4qV21XRtPZG4+X9Xsir+DuyzK9OIDD/Xy3Whxm5
         eAF/BAcPY9rXuR4cCBTT1gt2+XAWp2rgETMK/JTA/iLiAWwQnrOCZnoTBC4wfyvoj4
         Ho/Z7ZroHXuXg==
Message-ID: <14602081-c361-70e2-afd1-4f5dad8e2869@collabora.com>
Date:   Thu, 9 Feb 2023 14:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] media: platform: mtk-mdp3: Add missing check and free
 for ida_alloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, mchehab@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        daoyuan.huang@mediatek.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230209092502.34300-1-jiasheng@iscas.ac.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209092502.34300-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 10:25, Jiasheng Jiang ha scritto:
> Add the check for the return value of the ida_alloc in order to avoid
> NULL pointer dereference.
> Moreover, free allocated "ctx->id" if mdp_m2m_open fails later in order
> to avoid memory leak.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Fix the goto label.
> 
> v1 -> v2:
> 
> 1. Fix the check for the ida_alloc.
> ---
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
> index 5f74ea3b7a52..a2d204e90aa4 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
> @@ -567,6 +567,11 @@ static int mdp_m2m_open(struct file *file)
>   	}
>   
>   	ctx->id = ida_alloc(&mdp->mdp_ida, GFP_KERNEL);
> +	if (ctx->id < 0) {

There's one main not-so-minor issue here: ctx->id is u32.
Unsigned types cannot evaluate less than zero: they're .. unsigned!

There's your fix:
	ret = ida_alloc ...
	if (ret)
		....
	ctx->id = ret;


Enjoy.

Regards,
Angelo

