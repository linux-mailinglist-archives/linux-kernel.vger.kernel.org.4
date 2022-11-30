Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9516463D24A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiK3JoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiK3JoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:44:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE81F2C6;
        Wed, 30 Nov 2022 01:44:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 020AF6602B56;
        Wed, 30 Nov 2022 09:44:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669801444;
        bh=iSy5K/9Oym2Y4hj48BtEydq7EQhDRhCIlMJ13ol2HcQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O6HbZJ0E3KV/fMjZlggLp/zWf0hhywnQr/KM/2tOStuGzLOyhKWV5AxnP6gkUVUeH
         artscZj5VJihiL/Yk4882Rd3ljZCUKKLvTK04oZIAxyE75d7NBrdhO1KIHz2f76xRM
         InuLBBqjLTmNPvEXMebONWzupbO8F50Y3BMzMXy+BPlYM15GzhOYvwHRi61YUkRLgh
         1akurVnLaTFDtmVqTwHDXzUQovTunZ/1vEdGTp8vCBkWZX6SoEUbPgdY1URigKTWd9
         lP5NPuYc1Ppt5ZUtlGYRDxSV+leTN+BNnx9Meu2Ya0YcW5VHIyZkQ7MCvWdbEz/7CT
         dieCBt3MtTXXA==
Message-ID: <fc7ac761-eb81-347b-1c51-cdc9c786ee5b@collabora.com>
Date:   Wed, 30 Nov 2022 10:44:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] media: platform: mtk-mdp3: Fix return value check in
 mdp_probe()
Content-Language: en-US
To:     Qiheng Lin <linqiheng@huawei.com>, mchehab@kernel.org,
        matthias.bgg@gmail.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221130081312.35523-1-linqiheng@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221130081312.35523-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/11/22 09:13, Qiheng Lin ha scritto:
> In case of error, the function mtk_mutex_get()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> index c413e59d4286..7a2d992dd842 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> @@ -207,8 +207,8 @@ static int mdp_probe(struct platform_device *pdev)
>   	}
>   	for (i = 0; i < MDP_PIPE_MAX; i++) {
>   		mdp->mdp_mutex[i] = mtk_mutex_get(&mm_pdev->dev);
> -		if (!mdp->mdp_mutex[i]) {
> -			ret = -ENODEV;
> +		if (IS_ERR(mdp->mdp_mutex[i])) {
> +			ret = PTR_ERR(mdp->mdp_mutex[i]);
>   			goto err_return;
>   		}
>   	}
> 

That's true, and I fully agree.
While you're at it, can you also fix the err_return case?

if (mdp)
	for ...
		if (!IS_ERR_OR_NULL(mdp->mdp_mutex[i]))
			mtk_mutex_put(...)


Thanks,
Angelo
