Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5E6BEDDF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCQQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCQQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:18:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AEF399FE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:18:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so5754133pjh.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679069880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsRR/3AQTZ/QykMe7M1Imcd2WzQ3vb7NKZfryc9crHU=;
        b=fALdD9ME0RaR9ePBbCcnEqStY3dh5EBgpYHwhpBg33lo/iIGHjIIYD883U2aWS/8y8
         Tumv15bCu+465dAhTEtl7BAktlwxniV4cgUQwIQyCSh/zhtCNx7dCHm9bOj9+sS+oLik
         0a5Pm2iEQ0BaGhAttwOSn0U6OCXTOJ3LAsDG4JX1JjydUXjKQ1fWeEf42WFDHCMDqi8J
         91jwq/NKeBKHJz9I+pbZgOIyTh6uQ0h0AX9147/qj3EzAWE3X8TNH4sqhuI5nSwLLuwy
         fGJO39qwg7WJB/Puv39EQCN88yNN5g/wKW7ZQNJLMrQSfGp55qy3pf2ymv9nqGp9Y68C
         COnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsRR/3AQTZ/QykMe7M1Imcd2WzQ3vb7NKZfryc9crHU=;
        b=brm+a3su/rQacsU5ODJ7gjsc6HQDtmuxDYrQ+WGOOSkyaUQ+6Y4tDP0oZOfO4PLHtQ
         xBuLUl6AYCCtSDIJvGogjVPf0nYhjwqEr6d+CFQFPr5cYR0U03MhsjsvFrUF9kkiOZZG
         TOww2UOoNfC/Vu3nvzkHTu4iHtJ0PJuD7Kq1qnkw/Gcv7COJk0zYLCMSODMcSUm5kUPn
         Yhf9RlmB8OCWurvT0ZUvKOenAud+DLIA58057KevL7stUnsDJ+585n8hWrR1pHQ2EGme
         fgD7hrkc0dFmr/bZRr7LkD++DbovEylXKyaIV8vw7R20AS3ZJAsgdEeEefmEnNQqPjhM
         yJ8w==
X-Gm-Message-State: AO0yUKWH81pCuRYzzEzOxYnw6xMgR12TClxYDzZveyALH+2/SWl9yEt6
        LyoOy3fAIs7t1LIVTIqvZt6JCJSCuTCRHTN0j4E=
X-Google-Smtp-Source: AK7set9kY4kJ6xSWnJYHcqPqgXu78Ngmgb2P3QDtQt4NNZZTjaLqLJYgphdza1zezLqWhWNB0Z1d9g==
X-Received: by 2002:a17:902:e544:b0:1a1:7899:f009 with SMTP id n4-20020a170902e54400b001a17899f009mr3531722plf.17.1679069880613;
        Fri, 17 Mar 2023 09:18:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4b12:d774:9f68:68cf])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001a064cff3c5sm1751337plp.43.2023.03.17.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:18:00 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:17:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, hnagalla@ti.com,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, rogerq@kernel.org
Subject: Re: [PATCH v7 3/3] remoteproc: k3-r5: Use separate compatible string
 for TI AM62x SoC family
Message-ID: <20230317161757.GA2471094@p14s>
References: <20230310162544.3468365-1-devarsht@ti.com>
 <20230310162544.3468365-4-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310162544.3468365-4-devarsht@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:55:44PM +0530, Devarsh Thakkar wrote:
> AM62 and AM62A SoCs use single core R5F which is a new scenario
> different than the one being used with CLUSTER_MODE_SINGLECPU which is
> for utilizing a single core from a set of cores available in R5F cluster
> present in the SoC.
> 
> To support this single core scenario map it with newly defined
> CLUSTER_MODE_SINGLECORE and use it when compatible is set to
> ti,am62-r5fss.
> 
> Also set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE config for
> CLUSTER_MODE_SINGLECORE too as it is required by R5 core when it is
> being as general purpose core instead of device manager.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> - Fix indentation and ordering issues as per review comments
> V3:
> - Change CLUSTER_MODE_NONE value to -1
> V4:
> - No change
> V5:
> - No change (fixing typo in email address)
> V6:
>    - Use CLUSTER_MODE_SINGLECORE for AM62x
>    - Set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE for single core.
> V7:
>    - Simplify and rebase on top of base commit "[PATCH v7] remoteproc: k3-r5: Simplify cluster
>      mode setting"
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 59 +++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index c2ec0f432921..df32f6bc4325 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -71,14 +71,16 @@ struct k3_r5_mem {
>  /*
>   * All cluster mode values are not applicable on all SoCs. The following
>   * are the modes supported on various SoCs:
> - *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
> - *   LockStep mode   : AM65x, J721E and J7200 SoCs
> - *   Single-CPU mode : AM64x SoCs only
> + *   Split mode       : AM65x, J721E, J7200 and AM64x SoCs
> + *   LockStep mode    : AM65x, J721E and J7200 SoCs
> + *   Single-CPU mode  : AM64x SoCs only
> + *   Single-Core mode : AM62x, AM62A SoCs
>   */
>  enum cluster_mode {
>  	CLUSTER_MODE_SPLIT = 0,
>  	CLUSTER_MODE_LOCKSTEP,
>  	CLUSTER_MODE_SINGLECPU,
> +	CLUSTER_MODE_SINGLECORE
>  };
>  
>  /**
> @@ -86,11 +88,13 @@ enum cluster_mode {
>   * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
>   * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
>   * @single_cpu_mode: flag to denote if SoC/IP supports Single-CPU mode
> + * @is_single_core: flag to denote if SoC/IP has only single core R5
>   */
>  struct k3_r5_soc_data {
>  	bool tcm_is_double;
>  	bool tcm_ecc_autoinit;
>  	bool single_cpu_mode;
> +	bool is_single_core;
>  };
>  
>  /**
> @@ -838,7 +842,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  
>  	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -	    cluster->mode == CLUSTER_MODE_SINGLECPU) {
> +	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +	    cluster->mode == CLUSTER_MODE_SINGLECORE) {
>  		core = core0;
>  	} else {
>  		core = kproc->core;
> @@ -877,7 +882,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  		 * with the bit configured, so program it only on
>  		 * permitted cores
>  		 */
> -		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
> +		if (cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		    cluster->mode == CLUSTER_MODE_SINGLECORE) {
>  			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
>  		} else {
>  			/*
> @@ -1069,6 +1075,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>  
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>  	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +	    cluster->mode == CLUSTER_MODE_SINGLECORE ||
>  	    !cluster->soc_data->tcm_is_double)
>  		return;
>  
> @@ -1145,6 +1152,8 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  	if (cluster->soc_data->single_cpu_mode) {
>  		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
>  				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
> +	} else if (cluster->soc_data->is_single_core) {
> +		mode = CLUSTER_MODE_SINGLECORE;

I have commented twice on this before - whether it is soc_data->single_cpu_mode or
soc_data->is_single_core, I don't want to see them used elsewhere than in a
single function.  Either in probe() or another function, use them once to set
cluster->mode and never again.  

I will silently drop any other patchset that doesn't address this.

>  	} else {
>  		mode = cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP ?
>  				CLUSTER_MODE_LOCKSTEP : CLUSTER_MODE_SPLIT;
> @@ -1264,9 +1273,12 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  			goto err_add;
>  		}
>  
> -		/* create only one rproc in lockstep mode or single-cpu mode */
> +		/* create only one rproc in lockstep, single-cpu or
> +		 * single core mode
> +		 */
>  		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -		    cluster->mode == CLUSTER_MODE_SINGLECPU)
> +		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>  			break;
>  	}
>  
> @@ -1709,19 +1721,33 @@ static int k3_r5_probe(struct platform_device *pdev)
>  		/*
>  		 * default to most common efuse configurations - Split-mode on AM64x
>  		 * and LockStep-mode on all others
> +		 * default to most common efuse configurations -
> +		 * Split-mode on AM64x
> +		 * Single core on AM62x
> +		 * LockStep-mode on all others
>  		 */
> -		cluster->mode = data->single_cpu_mode ?
> +		if (!data->is_single_core)
> +			cluster->mode = data->single_cpu_mode ?
>  					CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
> +		else
> +			cluster->mode = CLUSTER_MODE_SINGLECORE;
>  	}
>  
> -	if (cluster->mode == CLUSTER_MODE_SINGLECPU && !data->single_cpu_mode) {
> +	if  ((cluster->mode == CLUSTER_MODE_SINGLECPU && !data->single_cpu_mode) ||
> +	     (cluster->mode == CLUSTER_MODE_SINGLECORE && !data->is_single_core)) {
>  		dev_err(dev, "Cluster mode = %d is not supported on this SoC\n", cluster->mode);
>  		return -EINVAL;
>  	}
>  
>  	num_cores = of_get_available_child_count(np);
> -	if (num_cores != 2) {
> -		dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
> +	if (num_cores != 2 && !data->is_single_core) {
> +		dev_err(dev, "MCU cluster requires both R5F cores to be enabled but num_cores is set to = %d\n",
> +			num_cores);
> +		return -ENODEV;
> +	}
> +
> +	if (num_cores != 1 && data->is_single_core) {
> +		dev_err(dev, "SoC supports only single core R5 but num_cores is set to %d\n",
>  			num_cores);
>  		return -ENODEV;
>  	}
> @@ -1763,18 +1789,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
>  	.tcm_is_double = false,
>  	.tcm_ecc_autoinit = false,
>  	.single_cpu_mode = false,
> +	.is_single_core = false,
>  };
>  
>  static const struct k3_r5_soc_data j7200_j721s2_soc_data = {
>  	.tcm_is_double = true,
>  	.tcm_ecc_autoinit = true,
>  	.single_cpu_mode = false,
> +	.is_single_core = false,
>  };
>  
>  static const struct k3_r5_soc_data am64_soc_data = {
>  	.tcm_is_double = true,
>  	.tcm_ecc_autoinit = true,
>  	.single_cpu_mode = true,
> +	.is_single_core = false,
> +};
> +
> +static const struct k3_r5_soc_data am62_soc_data = {
> +	.tcm_is_double = false,
> +	.tcm_ecc_autoinit = true,
> +	.single_cpu_mode = false,
> +	.is_single_core = true,
>  };
>  
>  static const struct of_device_id k3_r5_of_match[] = {
> @@ -1782,6 +1818,7 @@ static const struct of_device_id k3_r5_of_match[] = {
>  	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
>  	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
>  	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
> +	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
>  	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
>  	{ /* sentinel */ },
>  };
> -- 
> 2.34.1
> 
