Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54286016D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJQTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJQTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:01:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2712733CA;
        Mon, 17 Oct 2022 12:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9684FB8129F;
        Mon, 17 Oct 2022 19:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24629C433C1;
        Mon, 17 Oct 2022 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666033306;
        bh=PSZUuFivGvt+IE+bPLkNcfzVVIH07xVNyt++2+Gn45E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZ9D79IlAMH8eZQvHL0dHGSO+qH7npF2+PzfA1+QJ6AA7nHidCy0aBhfcG1BQ1rBx
         GVPRbUm5WVij6f4d/iWyXblU7EERT55L9gqIMgI2Nztb6wil65xLh8CBgvsYgemIui
         KiLHfof3dJ4qu3RbYWdFcrudTRoOq+wTdTvqZcd/1RU22OJ0txqF733xUXZ4M3q/rE
         nHoQCT6+8VaMV9ePd8HILd8tQ8cNjsrZgynOWtkclYkGHIOpftso5tsJU9MiW7ebia
         cEGA0XoAUjyYbSre4ySDWGK8x+KX0wt6Kgc2kzNVv9D+ultLrBvK/rh5obPuXkizNP
         8R77x6LHOZDOQ==
Date:   Mon, 17 Oct 2022 14:01:43 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] drivers: thermal: tsens: Add support for combined
 interrupt
Message-ID: <20221017190143.7fjwrlud6hamu3yr@builder.lan>
References: <20220818220245.338396-1-robimarko@gmail.com>
 <20220818220245.338396-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818220245.338396-2-robimarko@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:02:42AM +0200, Robert Marko wrote:
> Despite using tsens v2.3 IP, IPQ8074 and IPQ6018 only have one IRQ for
> signaling both up/low and critical trips.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v7:
> * Rebase to apply on next-20220818
> 
> Changes in v6:
> * Check critical IRQ handler return, simplify up/low return
> ---
>  drivers/thermal/qcom/tsens-8960.c |  1 +
>  drivers/thermal/qcom/tsens-v0_1.c |  1 +
>  drivers/thermal/qcom/tsens-v1.c   |  1 +
>  drivers/thermal/qcom/tsens-v2.c   |  1 +
>  drivers/thermal/qcom/tsens.c      | 38 ++++++++++++++++++++++++++-----
>  drivers/thermal/qcom/tsens.h      |  2 ++
>  6 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 67c1748cdf73..ee584e5b07e5 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -269,6 +269,7 @@ static const struct tsens_ops ops_8960 = {
>  static struct tsens_features tsens_8960_feat = {
>  	.ver_major	= VER_0,
>  	.crit_int	= 0,
> +	.combo_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 0,
>  	.max_sensors	= 11,
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..6effb822bf3c 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -539,6 +539,7 @@ static int calibrate_9607(struct tsens_priv *priv)
>  static struct tsens_features tsens_v0_1_feat = {
>  	.ver_major	= VER_0_1,
>  	.crit_int	= 0,
> +	.combo_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
>  	.max_sensors	= 11,
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 573e261ccca7..a4f561a6e582 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -302,6 +302,7 @@ static int calibrate_8976(struct tsens_priv *priv)
>  static struct tsens_features tsens_v1_feat = {
>  	.ver_major	= VER_1_X,
>  	.crit_int	= 0,
> +	.combo_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
>  	.max_sensors	= 11,
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b..129cdb247381 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -31,6 +31,7 @@
>  static struct tsens_features tsens_v2_feat = {
>  	.ver_major	= VER_2_X,
>  	.crit_int	= 1,
> +	.combo_int	= 0,
>  	.adc		= 0,
>  	.srot_split	= 1,
>  	.max_sensors	= 16,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b1b10005fb28..816769af8813 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -532,6 +532,27 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +/**
> + * tsens_combined_irq_thread - Threaded interrupt handler for combined interrupts

This should have () after the function name. Perhaps Daniel could add
that as he picks the patch?

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> + * @irq: irq number
> + * @data: tsens controller private data
> + *
> + * Handle the combined interrupt as if it were 2 separate interrupts, so call the
> + * critical handler first and then the up/low one.
> + *
> + * Return: IRQ_HANDLED
> + */
> +static irqreturn_t tsens_combined_irq_thread(int irq, void *data)
> +{
> +	irqreturn_t ret;
> +
> +	ret = tsens_critical_irq_thread(irq, data);
> +	if (ret != IRQ_HANDLED)
> +		return ret;
> +
> +	return tsens_irq_thread(irq, data);
> +}
> +
>  static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
>  {
>  	struct tsens_sensor *s = tz->devdata;
> @@ -1071,13 +1092,18 @@ static int tsens_register(struct tsens_priv *priv)
>  				   tsens_mC_to_hw(priv->sensor, 0));
>  	}
>  
> -	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> -	if (ret < 0)
> -		return ret;
> +	if (priv->feat->combo_int) {
> +		ret = tsens_register_irq(priv, "combined",
> +					 tsens_combined_irq_thread);
> +	} else {
> +		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> +		if (ret < 0)
> +			return ret;
>  
> -	if (priv->feat->crit_int)
> -		ret = tsens_register_irq(priv, "critical",
> -					 tsens_critical_irq_thread);
> +		if (priv->feat->crit_int)
> +			ret = tsens_register_irq(priv, "critical",
> +						 tsens_critical_irq_thread);
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index ba05c8233356..1678c5e9e60b 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -493,6 +493,7 @@ enum regfield_ids {
>   * struct tsens_features - Features supported by the IP
>   * @ver_major: Major number of IP version
>   * @crit_int: does the IP support critical interrupts?
> + * @combo_int: does the IP use one IRQ for up, low and critical thresholds?
>   * @adc:      do the sensors only output adc code (instead of temperature)?
>   * @srot_split: does the IP neatly splits the register space into SROT and TM,
>   *              with SROT only being available to secure boot firmware?
> @@ -502,6 +503,7 @@ enum regfield_ids {
>  struct tsens_features {
>  	unsigned int ver_major;
>  	unsigned int crit_int:1;
> +	unsigned int combo_int:1;
>  	unsigned int adc:1;
>  	unsigned int srot_split:1;
>  	unsigned int has_watchdog:1;
> -- 
> 2.37.2
> 
