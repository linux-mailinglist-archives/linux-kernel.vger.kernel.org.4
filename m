Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AF691776
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjBJECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjBJECG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:02:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B598660B8E;
        Thu,  9 Feb 2023 20:02:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17AAFB82396;
        Fri, 10 Feb 2023 04:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18FFC433EF;
        Fri, 10 Feb 2023 04:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676001721;
        bh=PmNwnbNknRwLI6KUeRE+5nDROEsCrGy3TV9ClZIRnlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R53H3rCzCa6VP51iNX3a4+1f/joG5/WpVEem4Sgy3KbpHUtzcLjapYeeGgJRcKXMK
         iZDheOcuPN/sbVAfi0xEIsKr8SbRn+sxaU9RwWDCd/mfkgeE8PF/eVikU+cLvC0ikd
         sn1ngWRfGw7IxynXh7E4Py82tPIezxlwgyI9tJK+wOL8U8H+nbKmoCub5rjrH693jk
         7T5NvdNF8hWVOxJqjuOU9jtnX1Fg471CXNM4A3rf0o/HeVYUtWK1X6gK0zcXYrYTzW
         dwIc4m7x32p1BbiNu1GBFC0mP8/m2UUtLFgF7LPRIMxxWH/YqgzbHIQx5+KF1OgM2x
         8wnDkYK9xQZuA==
Date:   Thu, 9 Feb 2023 20:04:11 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/2] pinctrl: qcom: Add support for i2c specific pull
 feature
Message-ID: <20230210040411.rccrp5wnov5l7nly@ripper>
References: <20230209074510.4153294-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209074510.4153294-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:45:09AM +0200, Abel Vesa wrote:
> Add support for the new i2c_pull property introduced for SM8550 setting
> a I2C specific pull mode on I2C able pins. Add the bit to the SM8550
> specific driver while at it.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
> 
> The v3 of this specific patch is here:
> https://lore.kernel.org/all/20230208081836.984673-1-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * changed the condition in msm_config_group_set to "arg == MSM_I2C_STRONG_PULL_UP"
>    as Bjorn suggested
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
> index 5142c363480a..a69f93e74435 100644
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
> +			else if (g->i2c_pull_bit && arg == MSM_I2C_STRONG_PULL_UP)
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
