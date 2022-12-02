Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4F64026A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiLBInJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiLBInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:43:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B945EDE;
        Fri,  2 Dec 2022 00:43:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0970461FCD;
        Fri,  2 Dec 2022 08:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3080C433D6;
        Fri,  2 Dec 2022 08:43:00 +0000 (UTC)
Message-ID: <4f4b9ff6-73e3-a8b3-1d1c-e1d0a0b9b38c@xs4all.nl>
Date:   Fri, 2 Dec 2022 09:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] media: platform: mtk-mdp3: Fix return value check in
 mdp_probe()
Content-Language: en-US
To:     Qiheng Lin <linqiheng@huawei.com>, mchehab@kernel.org,
        matthias.bgg@gmail.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221201023505.48015-1-linqiheng@huawei.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221201023505.48015-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiheng,

Can you rebase on top of the latest staging tree? (https://git.linuxtv.org/media_stage.git/)

This patch no longer applies.

Thanks!

	Hans

On 01/12/2022 03:35, Qiheng Lin wrote:
> In case of error, the function mtk_mutex_get()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
> And also fix the err_return case.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
> 
> v2:
>  - Add fix the err_return case.
> 
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> index c413e59d4286..48f3e32fe54e 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> @@ -207,8 +207,8 @@ static int mdp_probe(struct platform_device *pdev)
>  	}
>  	for (i = 0; i < MDP_PIPE_MAX; i++) {
>  		mdp->mdp_mutex[i] = mtk_mutex_get(&mm_pdev->dev);
> -		if (!mdp->mdp_mutex[i]) {
> -			ret = -ENODEV;
> +		if (IS_ERR(mdp->mdp_mutex[i])) {
> +			ret = PTR_ERR(mdp->mdp_mutex[i]);
>  			goto err_return;
>  		}
>  	}
> @@ -288,9 +288,10 @@ static int mdp_probe(struct platform_device *pdev)
>  err_deinit_comp:
>  	mdp_comp_destroy(mdp);
>  err_return:
> -	for (i = 0; i < MDP_PIPE_MAX; i++)
> -		if (mdp)
> -			mtk_mutex_put(mdp->mdp_mutex[i]);
> +	if (mdp)
> +		for (i = 0; i < MDP_PIPE_MAX; i++)
> +			if (!IS_ERR_OR_NULL(mdp->mdp_mutex[i]))
> +				mtk_mutex_put(mdp->mdp_mutex[i]);
>  	kfree(mdp);
>  	dev_dbg(dev, "Errno %d\n", ret);
>  	return ret;

