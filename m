Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C046D855C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjDERzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjDERzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:55:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A55589
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:55:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n14so19288387plc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680717321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6KxPEHCGj+2Fji8JCae/W+Ck9cYGQv+bw6pf7dJ+WQ=;
        b=arzRhxzpaOtE/mwpFQDvfgOMalpHYcWt2AqgaokR5CNeTe/o5aWB42B3PC4D84dsIS
         c7uohGH5qf8nmsgoqTHDiFATmD0LWZeE1aFAif3R93vmMGEVQ7T8euXHEVnjt3KJI9Xj
         ElHl8WL9iSa0jERmPDsM96edNA+Nmfi8vnIAyQZBT4kQJydFivxCphfD87qoykZOiD4r
         C51rpD7JwBD39R+tUfEUfgRDlgbyb+r/aL2+MMpQCRsTvPkKipfcqhLb2HxPsVBlMTa3
         t+s6YBg0yyJcTghEkERK0mHTIHaIFLc+mHWZExYVzFc8H6JgykpL0bBybpk4qVS9IeZ4
         FPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6KxPEHCGj+2Fji8JCae/W+Ck9cYGQv+bw6pf7dJ+WQ=;
        b=YIU2AnnKLYlO60MggQhl71FnzcdFDyiQ8kEWBcqeqIHEBVfyJ04wXiGK7gNi+aIfRb
         EjfkORl0xedSr+QznpFTquaMTOO5sPNmOGPofUVp+qY8w0XpwSUz0057dXW315WEagXs
         uUu4Ew++TBfGmnJZZb790YYCVaTMf8V6CmHMBUxJdHjqsKBl9beccctcQLuXqxIhpcD4
         9QhCNyJEmYOyla0a2glOFV2aWC2SRZphaDOa8CA5x8hwFP4E/trmiVcY5V4F9x3Glk11
         Ea1USfwWjMsuZjIJWo5hH3gjrTfTKBin/iZeH14o8ncY2CfKkh/8kpZEzy1EklZlxeMf
         GS5Q==
X-Gm-Message-State: AAQBX9d5dTqBvxpUj1UkjxeFta9A7MWecTSYvroLEWrOeqk/77VmIfHc
        8bThpxjXiMCpHkTftTs1YjwMYA==
X-Google-Smtp-Source: AKy350YETHBPS77VZrV0ie2wH9Ou5p0HR+/EmUhx9BAxw/aJ3bY42nyI0GxFakCeEFVsua5Zxms/wg==
X-Received: by 2002:a17:903:2946:b0:19d:138b:7c4a with SMTP id li6-20020a170903294600b0019d138b7c4amr6601037plb.3.1680717321492;
        Wed, 05 Apr 2023 10:55:21 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c807:a26a:a179:b5ec])
        by smtp.gmail.com with ESMTPSA id s37-20020a63ff65000000b0050f7208b4bcsm9536794pgk.89.2023.04.05.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:55:21 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:55:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] remoteproc: stm32: Clean-up the management of the
 hold boot by SMC call
Message-ID: <20230405175518.GC3812912@p14s>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331154651.3107173-4-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Fri, Mar 31, 2023 at 05:46:49PM +0200, Arnaud Pouliquen wrote:
> There are two ways to manage the Cortex-M4 hold boot:
> - by Linux thanks to a sys config controller
> - by the secure context when the hold boot is protected.
> Since the introduction of the SCMI server, the use of the SMC call

What SCMI server?  Does this means stm32 is now able to use SCMI to manage the
remote processor hold boot?  If so, that is what I should find in this
changelog.  Otherwise this changelog needs to be re-written. 

> is deprecated. If the trust zone is activated, the management of the
> hold boot must be done by the secure context thanks to a SCMI reset
> controller.
> 
> This patch cleans-up the code related to the SMC call, replaced by
> the SCMI server.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 34 ++------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 7d782ed9e589..4be651e734ee 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -5,7 +5,6 @@
>   *          Fabien Dessenne <fabien.dessenne@st.com> for STMicroelectronics.
>   */
>  
> -#include <linux/arm-smccc.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -88,7 +87,6 @@ struct stm32_rproc {
>  	struct stm32_rproc_mem *rmems;
>  	struct stm32_mbox mb[MBOX_NB_MBX];
>  	struct workqueue_struct *workqueue;
> -	bool secured_soc;
>  	void __iomem *rsc_va;
>  };
>  
> @@ -398,20 +396,12 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
>  {
>  	struct stm32_rproc *ddata = rproc->priv;
>  	struct stm32_syscon hold_boot = ddata->hold_boot;
> -	struct arm_smccc_res smc_res;
>  	int val, err;
>  
>  	val = hold ? HOLD_BOOT : RELEASE_BOOT;
>  
> -	if (IS_ENABLED(CONFIG_HAVE_ARM_SMCCC) && ddata->secured_soc) {
> -		arm_smccc_smc(STM32_SMC_RCC, STM32_SMC_REG_WRITE,
> -			      hold_boot.reg, val, 0, 0, 0, 0, &smc_res);
> -		err = smc_res.a0;
> -	} else {
> -		err = regmap_update_bits(hold_boot.map, hold_boot.reg,
> -					 hold_boot.mask, val);
> -	}
> -
> +	err = regmap_update_bits(hold_boot.map, hold_boot.reg,
> +				 hold_boot.mask, val);
>  	if (err)
>  		dev_err(&rproc->dev, "failed to set hold boot\n");
>  
> @@ -680,8 +670,6 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	struct stm32_syscon tz;
> -	unsigned int tzen;
>  	int err, irq;
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -710,24 +698,6 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
>  		return dev_err_probe(dev, PTR_ERR(ddata->rst),
>  				     "failed to get mcu_reset\n");
>  
> -	/*
> -	 * if platform is secured the hold boot bit must be written by
> -	 * smc call and read normally.
> -	 * if not secure the hold boot bit could be read/write normally
> -	 */
> -	err = stm32_rproc_get_syscon(np, "st,syscfg-tz", &tz);
> -	if (err) {
> -		dev_err(dev, "failed to get tz syscfg\n");
> -		return err;
> -	}

If I was to do a bisect here, I would not be able to boot boards that have a
trustzone.  Add the new functionality and then remove the old one.

> -
> -	err = regmap_read(tz.map, tz.reg, &tzen);
> -	if (err) {
> -		dev_err(dev, "failed to read tzen\n");
> -		return err;
> -	}
> -	ddata->secured_soc = tzen & tz.mask;
> -
>  	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
>  				     &ddata->hold_boot);
>  	if (err) {
> -- 
> 2.25.1
> 
