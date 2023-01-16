Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9466CA11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjAPQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjAPQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:58:28 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D852D169
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:41:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w2so5964528pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG5Z7UyOv9nDx7PpcOmd5IbWHp6hcPBWG/SaQG/G+NI=;
        b=vKlLgFAdOFcE4WamrW446HrFXsG0uIpk5hys2Zv3jMYR6fJszsJDjhV/7pbExQGmEI
         zL0IOX8HSNVJm06DA5mZX1L3tkygl01hdjY2AMcadLaih4dc6Ijy1ZLFDNFu9YBxNlSd
         l2RfFuyPH5403hwglzxL5XGZxJFCHavES0IUaFHKur8xe5+hTTtT0/UIKZ0PIR3bEJqO
         cqziEqvWrT7+pTVQGRFa7uZNYxiXy5zu5C+wYvEgYD2cD3nrtHf/HGMW+u0dDyePxDuJ
         m0ybuEC23f9smMt2FuHBBIaCKVmLW961Wf4mrWFWuSQCFi7g9kLgPp10sLC9NIvZhBtJ
         Gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG5Z7UyOv9nDx7PpcOmd5IbWHp6hcPBWG/SaQG/G+NI=;
        b=lxUUkWx/alCPfhjbCv9g+wrQpPJMgTFwCBCaQQmXHvFzcKGMUtZm8g4RanD+cZqV6s
         zq3G8Glx6It2nBZJ6tTtHyxDu8G4ZdmEzUk9GgBeac7NQ8t1h6uGCSlWADqLoNgb2CLX
         ePqRxsFkLnBZqbfC4JFS2C1s0d4RBaiwHYtDM0UDbBYq8iEiSzQqDc8yW60M/k7iBtS9
         eSF63GvbL4An7hBhSykR5fT8Gg9PnF5lA6MfSfWD8+dU113eHn1VSHH/PeGA0OsoKD+x
         D+nStpbmZ5Uak9v6DSLrvHOEP/mWO214W5oAdYTyd2PCDTa4fgxVnZy+zf+qKs0NGspp
         +kFA==
X-Gm-Message-State: AFqh2kqnJ+4KcwuvDAc/aY+h+ibp7MVSbUalRH2VWRyGD0xvLCt6XBG2
        46lQCJ3ECh1LHQFag94NhWi3Hg==
X-Google-Smtp-Source: AMrXdXvSRxPjwDi9NpAu9nugcV3BcPVIj7KrTNA5WZ9sqB6LZvGtUsesG++Uwp6os52z1Z5ww/ZE2w==
X-Received: by 2002:a05:6a00:4512:b0:577:8bae:29a7 with SMTP id cw18-20020a056a00451200b005778bae29a7mr131906pfb.33.1673887275192;
        Mon, 16 Jan 2023 08:41:15 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:32ab:eb7f:cea:1014])
        by smtp.gmail.com with ESMTPSA id i3-20020a056a00004300b00581013fcbe1sm2747014pfk.159.2023.01.16.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:41:14 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:41:12 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, hnagalla@ti.com,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com
Subject: Re: [PATCH v5 2/2] remoteproc: k3-r5: Use separate compatible string
 for TI AM62 SoC family
Message-ID: <20230116164112.GA3242647@p14s>
References: <20221227145216.1524-1-devarsht@ti.com>
 <20221227145216.1524-3-devarsht@ti.com>
 <20230110183505.GA2741090@p14s>
 <92afeb82-8b62-b771-ac27-1a21574c2204@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92afeb82-8b62-b771-ac27-1a21574c2204@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:58:55AM +0530, Devarsh Thakkar wrote:
> Hi Mathieu,
> 
> Thanks for the review.
> 
> On 11/01/23 00:05, Mathieu Poirier wrote:
> > On Tue, Dec 27, 2022 at 08:22:16PM +0530, Devarsh Thakkar wrote:
> >> AM62 and AM62A SoCs use single core R5F which is a new scenario
> >> different than the one being used with CLUSTER_MODE_SINGLECPU
> >> which is for utilizing a single core from a set of cores available
> >> in R5F cluster present in the SoC.
> >>
> >> To support this single core scenario map it with
> >> newly defined CLUSTER_MODE_NONE and use it when
> >> compatible is set to ti,am62-r5fss.
> >>
> >> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >> ---
> >> V2: Fix indentation and ordering issues as per review comments
> >> V3: Change CLUSTER_MODE_NONE value to -1
> >> V4: No change
> >> V5: No change (fixing typo in email address)
> >> ---
> >>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 57 ++++++++++++++++++------
> >>  1 file changed, 44 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> index 0481926c6975..127f1f68e592 100644
> >> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> @@ -74,9 +74,11 @@ struct k3_r5_mem {
> >>   *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
> >>   *   LockStep mode   : AM65x, J721E and J7200 SoCs
> >>   *   Single-CPU mode : AM64x SoCs only
> >> + *   None            : AM62x, AM62A SoCs
> >>   */
> >>  enum cluster_mode {
> >> -	CLUSTER_MODE_SPLIT = 0,
> >> +	CLUSTER_MODE_NONE = -1,
> > 
> > s/CLUSTER_MODE_NONE/CLUSTER_MODE_ONECORE
> > 
> > And add it after CLUSTER_MODE_SINGLECPU
> Ok, i will then add it in dt-bindings too.
> > 
> >> +	CLUSTER_MODE_SPLIT,
> >>  	CLUSTER_MODE_LOCKSTEP,
> >>  	CLUSTER_MODE_SINGLECPU,
> >>  };
> >> @@ -86,11 +88,13 @@ enum cluster_mode {
> >>   * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
> >>   * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
> >>   * @single_cpu_mode: flag to denote if SoC/IP supports Single-CPU mode
> >> + * @is_single_core: flag to denote if SoC/IP has only single core R5
> >>   */
> >>  struct k3_r5_soc_data {
> >>  	bool tcm_is_double;
> >>  	bool tcm_ecc_autoinit;
> >>  	bool single_cpu_mode;
> >> +	bool is_single_core;
> >>  };
> >>  
> >>  /**
> >> @@ -838,7 +842,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
> >>  
> >>  	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> >>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> >> -	    cluster->mode == CLUSTER_MODE_SINGLECPU) {
> >> +	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> >> +	    cluster->mode == CLUSTER_MODE_NONE) {
> >>  		core = core0;
> >>  	} else {
> >>  		core = kproc->core;
> >> @@ -853,7 +858,7 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
> >>  		boot_vec, cfg, ctrl, stat);
> >>  
> >>  	/* check if only Single-CPU mode is supported on applicable SoCs */
> >> -	if (cluster->soc_data->single_cpu_mode) {
> >> +	if (cluster->soc_data->single_cpu_mode || cluster->soc_data->is_single_core) {
> > 
> > Everywhere other than k3_r5_probe(), cluster->mode should be used.  Otherwise it
> > is wildly confusing and error prone.  Please resend this set with an extra
> > preamble patch that fixes this.
> I agree wherever possible we should do that but some places in the code we are
> overriding and fine-tuning the cluster-mode value based on firmware configs
> For e.g. here we are overriding the user selected cluster mode from split mode
> to single cpu mode if firmware says so and SoC supports single cpu mode.

Overriding cluster->mode happens after this and as such, there is no reason why
it can't be used in the if() clause.  Moreover, reading your V6, this part is
completely omitted.  Omission? Bug? Feature?

> > 
> >>  		single_cpu =
> >>  			!!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
> >>  		if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
> >> @@ -1074,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
> >>  
> >>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> >>  	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> >> +	    cluster->mode == CLUSTER_MODE_NONE ||
> >>  	    !cluster->soc_data->tcm_is_double)
> >>  		return;
> >>  
> >> @@ -1147,7 +1153,9 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >>  	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
> >>  	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
> >>  	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
> >> -	if (cluster->soc_data->single_cpu_mode) {
> >> +	if (cluster->soc_data->is_single_core) {
> >> +		mode = CLUSTER_MODE_NONE;
> >> +	} else if (cluster->soc_data->single_cpu_mode) {
> >>  		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
> >>  				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
> > 
> > Same comment as above.
> Here also we are overriding user selected cluster mode based on firmware
> returned config value and soc data.

Same comment as above.

> > 
> >>  	} else {
> >> @@ -1271,7 +1279,8 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
> >>  
> >>  		/* create only one rproc in lockstep mode or single-cpu mode */
> >>  		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> >> -		    cluster->mode == CLUSTER_MODE_SINGLECPU)
> >> +		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> >> +		    cluster->mode == CLUSTER_MODE_NONE)
> >>  			break;
> >>  	}
> >>  
> >> @@ -1704,21 +1713,32 @@ static int k3_r5_probe(struct platform_device *pdev)
> >>  	 * default to most common efuse configurations - Split-mode on AM64x
> >>  	 * and LockStep-mode on all others
> >>  	 */
> > 
> > The above comment needs to be adjusted.
> Will do.
> 
> Regards,
> Devarsh
> > 
> > Thanks,
> > Mathieu
> > 
> >> -	cluster->mode = data->single_cpu_mode ?
> >> +	if (!data->is_single_core)
> >> +		cluster->mode = data->single_cpu_mode ?
> >>  				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
> >> +	else
> >> +		cluster->mode = CLUSTER_MODE_NONE;
> >> +
> >>  	cluster->soc_data = data;
> >>  	INIT_LIST_HEAD(&cluster->cores);
> >>  
> >> -	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> >> -	if (ret < 0 && ret != -EINVAL) {
> >> -		dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n",
> >> -			ret);
> >> -		return ret;
> >> +	if (!data->is_single_core) {
> >> +		ret = of_property_read_s32(np, "ti,cluster-mode", &cluster->mode);
> >> +		if (ret < 0 && ret != -EINVAL) {
> >> +			dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n", ret);
> >> +			return ret;
> >> +		}
> >>  	}
> >>  
> >>  	num_cores = of_get_available_child_count(np);
> >> -	if (num_cores != 2) {
> >> -		dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
> >> +	if (num_cores != 2 && !data->is_single_core) {
> >> +		dev_err(dev, "MCU cluster requires both R5F cores to be enabled but num_cores is set to = %d\n",
> >> +			num_cores);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	if (num_cores != 1 && data->is_single_core) {
> >> +		dev_err(dev, "SoC supports only single core R5 but num_cores is set to %d\n",
> >>  			num_cores);
> >>  		return -ENODEV;
> >>  	}
> >> @@ -1760,18 +1780,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
> >>  	.tcm_is_double = false,
> >>  	.tcm_ecc_autoinit = false,
> >>  	.single_cpu_mode = false,
> >> +	.is_single_core = false,
> >>  };
> >>  
> >>  static const struct k3_r5_soc_data j7200_j721s2_soc_data = {
> >>  	.tcm_is_double = true,
> >>  	.tcm_ecc_autoinit = true,
> >>  	.single_cpu_mode = false,
> >> +	.is_single_core = false,
> >>  };
> >>  
> >>  static const struct k3_r5_soc_data am64_soc_data = {
> >>  	.tcm_is_double = true,
> >>  	.tcm_ecc_autoinit = true,
> >>  	.single_cpu_mode = true,
> >> +	.is_single_core = false,
> >> +};
> >> +
> >> +static const struct k3_r5_soc_data am62_soc_data = {
> >> +	.tcm_is_double = false,
> >> +	.tcm_ecc_autoinit = true,
> >> +	.single_cpu_mode = false,
> >> +	.is_single_core = true,
> >>  };
> >>  
> >>  static const struct of_device_id k3_r5_of_match[] = {
> >> @@ -1779,6 +1809,7 @@ static const struct of_device_id k3_r5_of_match[] = {
> >>  	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
> >>  	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
> >>  	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
> >> +	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
> >>  	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
> >>  	{ /* sentinel */ },
> >>  };
> >> -- 
> >> 2.17.1
> >>
