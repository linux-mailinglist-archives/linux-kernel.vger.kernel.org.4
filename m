Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661A06D857C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjDESBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDESBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:01:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9AA5BA9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:01:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso38098070pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680717706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75waTPmE449vmTwTKzJNA/Q/Fgjny/ageb8PalU7Nbg=;
        b=XSAfgzL/n2sc6f/aB0tqEvBb2ICpGzs0ODajpoFxqtO1OfDg6IhIOWU2KVA9lpJgAZ
         qHvP0+0S5RRGpcUudhh+s5kG+y2dSkpyGASIMq8Bmd0lBkQ+BwSQtL3Dske7tABYj2UF
         0spTdKCQMSwx4pLfT+YnVnhmGXQVRwTQYc79B0zvkhWpjQFFhi8Ck9bB8uPHmhlbIv+h
         30nbKZEgIlA+OGdhABt0Map+fqWlrJqnGhiztstUxDrBBUCvfYt78uCfAq8VtoU3ICKc
         ADkC8F7kljihzAZiIvPNtB+NtfVFh066/HIpQ6OYsgnqSKtAslCc+qLCnA3zPWjtB1BK
         xVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75waTPmE449vmTwTKzJNA/Q/Fgjny/ageb8PalU7Nbg=;
        b=qq5+vf45OnH+J+kDgrniCpkLfSUYP4inhF2NtDm3rNONiSVqpsHN0GSMLxf7sczEy+
         Ou0BVokCX9KXwCEuxeZZN9RJvfeyh8UjPO/itXzWWPyyxFP2tdrAM7ZuxVKZJM/NIF6s
         0V2SKpil02UeZcE8EseX/BvXX6ahdWH9a/+dX8MrXrAwKZnEnBoACbp6tda7gQ3/uBNm
         d4FHfmz/YFOVymEQjzBJt1VrkPBik1C5Q3+QBtsO+g9vc9F/qCcEUSrm5EbsPqiIjeCV
         PLvNpRwF49x4KND5FEr8my1LFQGYe9V7LmcsUfRN2xHrpGaSp9sAzeb+Py1hpGQGR2t+
         bf6w==
X-Gm-Message-State: AAQBX9eGCy404NUbqKu1qMDOxtNArf+Tg7eM0OX66P6Sfl6HXuvSXG1x
        /GlNko+vP7lyqOPpuOH4VpNcFw==
X-Google-Smtp-Source: AKy350Z8CUgZCFnbEgg9v2OHHpWYWd22mvzU0SHVyTPD74r9IiqlS2c6UZEDHSTFdHFmRKAeh0Vgbw==
X-Received: by 2002:a17:90a:1042:b0:237:3dfb:9095 with SMTP id y2-20020a17090a104200b002373dfb9095mr7768981pjd.6.1680717706444;
        Wed, 05 Apr 2023 11:01:46 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c807:a26a:a179:b5ec])
        by smtp.gmail.com with ESMTPSA id gd6-20020a17090b0fc600b00227223c58ecsm1678869pjb.42.2023.04.05.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:01:46 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:01:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Message-ID: <20230405180143.GD3812912@p14s>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 05:46:50PM +0200, Arnaud Pouliquen wrote:
> The hold boot can be managed by the SCMI controller as a reset.
> If the "hold_boot" reset is defined in the device tree, use it.
> Else use the syscon controller directly to access to the register.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 34 ++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 4be651e734ee..6b0d8f30a5c7 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -78,6 +78,7 @@ struct stm32_mbox {
>  
>  struct stm32_rproc {
>  	struct reset_control *rst;
> +	struct reset_control *hold_boot_rst;
>  	struct stm32_syscon hold_boot;
>  	struct stm32_syscon pdds;
>  	struct stm32_syscon m4_state;
> @@ -398,6 +399,14 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
>  	struct stm32_syscon hold_boot = ddata->hold_boot;
>  	int val, err;
>  
> +	if (ddata->hold_boot_rst) {
> +		/* Use the SCMI reset controller */
> +		if (!hold)
> +			return reset_control_deassert(ddata->hold_boot_rst);
> +		else
> +			return reset_control_assert(ddata->hold_boot_rst);
> +	}
> +
>  	val = hold ? HOLD_BOOT : RELEASE_BOOT;
>  
>  	err = regmap_update_bits(hold_boot.map, hold_boot.reg,
> @@ -693,16 +702,29 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
>  		dev_info(dev, "wdg irq registered\n");
>  	}
>  
> -	ddata->rst = devm_reset_control_get_by_index(dev, 0);
> +	ddata->rst = devm_reset_control_get(dev, "mcu_rst");

Peng is correct - newer kernels won't be able to boot with older DT.

>  	if (IS_ERR(ddata->rst))
>  		return dev_err_probe(dev, PTR_ERR(ddata->rst),
>  				     "failed to get mcu_reset\n");
>  
> -	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
> -				     &ddata->hold_boot);
> -	if (err) {
> -		dev_err(dev, "failed to get hold boot\n");
> -		return err;
> +	ddata->hold_boot_rst = devm_reset_control_get(dev, "hold_boot");
> +	if (IS_ERR(ddata->hold_boot_rst)) {
> +		if (PTR_ERR(ddata->hold_boot_rst) == -EPROBE_DEFER)
> +			return PTR_ERR(ddata->hold_boot_rst);
> +		ddata->hold_boot_rst = NULL;
> +	}
> +
> +	if (!ddata->hold_boot_rst) {

Why another if() statement?  The code below should be in the above if()...

This patchset is surprizingly confusing for its size.  I suggest paying
attention to the changelogs and adding comments in the code.

Thanks,
Mathieu

> +		/*
> +		 * If the hold boot is not managed by the SCMI reset controller,
> +		 * manage it through the syscon controller
> +		 */
> +		err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
> +					     &ddata->hold_boot);
> +		if (err) {
> +			dev_err(dev, "failed to get hold boot\n");
> +			return err;
> +		}
>  	}
>  
>  	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
> -- 
> 2.25.1
> 
