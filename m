Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006006F5749
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjECLlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:41:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4C46B8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:41:00 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5FA9B6603137;
        Wed,  3 May 2023 12:40:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683114059;
        bh=n9OmOmneeX6wqBjDmlr0Zvo9uXocS0m84dAmWMG3fxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VTOSfAHSQ938Nxqe8G8CggzhRoBUh97H4KzW+xbvFP8uvmlpFcAcVv7FRm5/wT7WK
         l1sn/IvkaCsIOD0gC52q6jcKbUTcmjeJZsfY47YcxacT+w2xTStsjR/SUsZlHEVCZ7
         JM+bGimVVcxw1ENIIgXxZIMqPLMhvYVSo98q35Vnm2/kIKI8OR8nPLfVCaWEGrwZN/
         LPg89L2F4Xc1ovybZnSD4v/G9JplLgMrulrSrIfkmkEqb/iUdDU1rDk+nXbkAKKV0j
         fv0D2Hkb0oxanx2C3ioa6IsMKIJXrWE0iw66O9aU8ki7sI1IHewmJuUjlYamSjloUm
         whcG+q2QVpU3w==
Message-ID: <6439bf4e-979e-889e-c97d-e7b1dd94b4f1@collabora.com>
Date:   Wed, 3 May 2023 13:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PM / devfreq: mtk-cci: refactor error handling of probe
 and remove
Content-Language: en-US
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
References: <20230503092742.19404-1-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230503092742.19404-1-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/23 11:27, jia-wei.chang ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> To refactor the regulator/clk handlers so it can follow the way of "Free
> the Last Thing Style".
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Fixes: 86d231b1db1b ("PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver")
> ---
>   drivers/devfreq/mtk-cci-devfreq.c | 47 ++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> index e5458ada5197..d2f743774147 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -294,14 +294,14 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
>   	if (IS_ERR(drv->sram_reg)) {
>   		ret = PTR_ERR(drv->sram_reg);
>   		if (ret == -EPROBE_DEFER)
> -			goto out_free_resources;
> +			goto out_disable_proc_reg;
>   
>   		drv->sram_reg = NULL;
>   	} else {
>   		ret = regulator_enable(drv->sram_reg);
>   		if (ret) {
>   			dev_err(dev, "failed to enable sram regulator\n");
> -			goto out_free_resources;
> +			goto out_disable_proc_reg;
>   		}
>   	}
>   
> @@ -316,12 +316,16 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
>   
>   	ret = clk_prepare_enable(drv->cci_clk);
>   	if (ret)
> -		goto out_free_resources;
> +		goto out_disable_sram_reg;
> +
> +	ret = clk_prepare_enable(drv->inter_clk);

Adding a clk_prepare_enable() call for a clock must be done in a separate commit.
Besides, there shouldn't be any need to do that, as when you call clk_set_parent()
(done in mtk_ccifreq_target()) on a clock that has flag CLK_OPS_PARENT_ENABLE, the
clk core will automatically call clk_core_prepare_enable() on the new parent.

If you're facing a bug for which the parent is not getting enabled, the solution
is to add CLK_OPS_PARENT_ENABLE to the interested clock.

Regards,
Angelo

