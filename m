Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238F68FE15
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjBIDp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjBIDpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:45:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466CE4EDA;
        Wed,  8 Feb 2023 19:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6F96B81FED;
        Thu,  9 Feb 2023 03:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D3DC433EF;
        Thu,  9 Feb 2023 03:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675914350;
        bh=SgaZeBovg+cJiTGR96CRC/f9213cSmpP7QQslM0XFOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ban8km4gYbC2F3wZAIAvSVaX0ylttF8Di1P3hCjQYRZguzANEMQIwaOC5pqm8SD81
         dFm51ZwBfk5PPQ5b3YbOb38XAQB4jaKRytkPvkZGHqDtl7oxvzeVXPMBLy16U/KA1B
         KI2g6WO//a4T9lT+xYMMgYa7VHU0ULhy6m93IyvQM7062ainbKBXwmqJDR68SaipwT
         nriHhZQtN4W1L/1YvW86YYbneT2sm+dGb0z4FQSNyvOAoEboM/fnK12gHfe6KO7XVS
         kI573NQVN6Ld8BGEaVvky05j54ilSSM4KpwJBLPTuhy20CjPe5P+jle0BWv2rKEQD0
         G2drXWbfHUvXg==
Date:   Wed, 8 Feb 2023 19:48:01 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/2] pinctrl: qcom: Add support for i2c specific pull
 feature
Message-ID: <20230209034801.owvldpyfbeerfj6x@ripper>
References: <20230208081836.984673-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208081836.984673-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:18:35AM +0200, Abel Vesa wrote:
> Add support for the new i2c_pull property introduced for SM8550 setting
> a I2C specific pull mode on I2C able pins. Add the bit to the SM8550
> specific driver while at it.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v2 of this specific patch is here:
> https://lore.kernel.org/all/20221123152001.694546-4-abel.vesa@linaro.org/
> 
> Changes since v2:
>  * This time, this patch is sent separate w.r.t. SM8550 pinctrl driver
>  * The qcom,i2c-pull is dropped, bias-pull-up with value is used instead
>  * Default value for i2c pull up is 2.2kOhms and since SM8550 is the
>    first one to use it, we hard code it for now
>  * changed the authorship as the implementation looks entirely different now
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c    | 7 +++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h    | 1 +
>  drivers/pinctrl/qcom/pinctrl-sm8550.c | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 5142c363480a..510c964dd0f5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -310,6 +310,8 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
>  	case PIN_CONFIG_BIAS_PULL_UP:
>  		*bit = g->pull_bit;
>  		*mask = 3;
> +		if (g->i2c_pull_bit)
> +			*mask |= BIT(g->i2c_pull_bit) >> *bit;
>  		break;
>  	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>  		*bit = g->od_bit;
> @@ -336,6 +338,7 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
>  #define MSM_KEEPER		2
>  #define MSM_PULL_UP_NO_KEEPER	2
>  #define MSM_PULL_UP		3
> +#define MSM_I2C_STRONG_PULL_UP	2200
>  
>  static unsigned msm_regval_to_drive(u32 val)
>  {
> @@ -387,6 +390,8 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
>  	case PIN_CONFIG_BIAS_PULL_UP:
>  		if (pctrl->soc->pull_no_keeper)
>  			arg = arg == MSM_PULL_UP_NO_KEEPER;
> +		else if (arg & BIT(g->i2c_pull_bit))
> +			arg = MSM_I2C_STRONG_PULL_UP;
>  		else
>  			arg = arg == MSM_PULL_UP;
>  		if (!arg)
> @@ -467,6 +472,8 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
>  		case PIN_CONFIG_BIAS_PULL_UP:
>  			if (pctrl->soc->pull_no_keeper)
>  				arg = MSM_PULL_UP_NO_KEEPER;
> +			else if (g->i2c_pull_bit && arg > 1)

I would prefer that we do arg == MSM_I2C_STRONG_PULL_UP, primarily to
improve the symmetry with the getter, but also just to ensure that
someone accidentally writing bias-pull-up = <1>; gets less of a
surprise.

Looks good otherwise.

Thanks,
Bjorn

> +				arg = BIT(g->i2c_pull_bit) | MSM_PULL_UP;
>  			else
>  				arg = MSM_PULL_UP;
>  			break;
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 05a1209bf9ae..985eceda2517 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -80,6 +80,7 @@ struct msm_pingroup {
>  
>  	unsigned pull_bit:5;
>  	unsigned drv_bit:5;
> +	unsigned i2c_pull_bit:5;
>  
>  	unsigned od_bit:5;
>  	unsigned egpio_enable:5;
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
> index 0b7db7d4054a..c9d038098f2c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm8550.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
> @@ -47,6 +47,7 @@
>  		.mux_bit = 2,			\
>  		.pull_bit = 0,			\
>  		.drv_bit = 6,			\
> +		.i2c_pull_bit = 13,		\
>  		.egpio_enable = 12,		\
>  		.egpio_present = 11,		\
>  		.oe_bit = 9,			\
> -- 
> 2.34.1
> 
