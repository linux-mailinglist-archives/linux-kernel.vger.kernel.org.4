Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97574621BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKHScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKHScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:32:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBFF5B857;
        Tue,  8 Nov 2022 10:32:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36DCF6172D;
        Tue,  8 Nov 2022 18:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF60C433D6;
        Tue,  8 Nov 2022 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667932359;
        bh=icGd5GPv/GdZwBY/786e7bQnWud2lRKv3P3CCjaRWwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/QCsyZVFIsh05wFYGWDM5HvOPRftrE/fzPySxFQ1QLZO5vPvCQzLjemwA6U40rDN
         6eRue9wigTFnq1mnUKNWvYJbTvuPk5+oxl7fu1l41VXw54zXZ58d/ohmgRHKXllanJ
         rsHfhvV4RwTTky8/LlBWWA+b0PMg0Mm7Z2JsJTtkq+6WLSSNaYFTbuRM2lndXwwaqk
         VCZCJ/Bedf3tFCCzc0auvYy3jA7hvxazGUvCG+KnFEECTFdx5GZ6YEKT4OYmeqk+bE
         2P8ZsA4FJPAsOmqkUFhsx4XuDXmIX+yllRNvCE1ec0m5bEwsatB7mpn8brQXTLgUN2
         609wVqoWlAMSQ==
Date:   Tue, 8 Nov 2022 18:32:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <Y2qgw2wAezkHSgg5@spud>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
 <20221007113512.91501-4-conor.dooley@microchip.com>
 <20221108155041.t4oppot5wy77jzgd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108155041.t4oppot5wy77jzgd@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:50:41PM +0100, Uwe Kleine-König wrote:
> Hello,

Hello! Thanks for the review Uwe :)

> On Fri, Oct 07, 2022 at 12:35:12PM +0100, Conor Dooley wrote:

> > +static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				      const struct pwm_state *state)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
> > +	struct pwm_state current_state = pwm->state;
> > +	bool period_locked;
> > +	u64 duty_steps;
> > +	u16 prescale;
> > +	u8 period_steps;
> > +
> > +	if (!state->enabled) {
> > +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * If the only thing that has changed is the duty cycle or the polarity,
> > +	 * we can shortcut the calculations and just compute/apply the new duty
> > +	 * cycle pos & neg edges
> > +	 * As all the channels share the same period, do not allow it to be
> > +	 * changed if any other channels are enabled.
> > +	 * If the period is locked, it may not be possible to use a period
> > +	 * less than that requested. In that case, we just abort.
> > +	 */
> > +	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
> > +
> > +	if (period_locked) {
> > +		u16 hw_prescale;
> > +		u8 hw_period_steps;
> > +
> > +		mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
> > +		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> > +		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> > +
> > +		if ((period_steps + 1) * (prescale + 1) <
> > +		    (hw_period_steps + 1) * (hw_prescale + 1))
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * It is possible that something could have set the period_steps
> > +		 * register to 0xff, which would prevent us from setting a 100%
> > +		 * or 0% relative duty cycle, as explained above in
> > +		 * mchp_core_pwm_calc_period().
> > +		 * The period is locked and we cannot change this, so we abort.
> > +		 */
> > +		if (hw_period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX)
> > +			return -EINVAL;
> > +
> > +		prescale = hw_prescale;
> > +		period_steps = hw_period_steps;
> > +	} else {
> > +		int ret;
> > +
> > +		ret = mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
> > +		if (ret)
> > +			return ret;
> > +
> > +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> > +	}
> > +
> > +	duty_steps = mchp_core_pwm_calc_duty(chip, pwm, state, prescale, period_steps);
> 
> Both mchp_core_pwm_calc_period and mchp_core_pwm_calc_duty call
> clk_get_rate(), I suggest call this only once and pass the rate to these
> two functions.

Sure. I think the signatures of both of those functions could be reduced
in the process which would be nice.

> Both branches of the if above start with calling
> mchp_core_pwm_calc_period, this could be simplified, too.

	ret = mchp_core_pwm_calc_period(chip, state, &prescale, &period_steps);
	if (ret)
		return ret;

	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);

	if (period_locked) {
		u16 hw_prescale;
		u8 hw_period_steps;

		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);

		if ((period_steps + 1) * (prescale + 1) <
		    (hw_period_steps + 1) * (hw_prescale + 1))
			return -EINVAL;

		/*
		 * It is possible that something could have set the period_steps
		 * register to 0xff, which would prevent us from setting a 100%
		 * or 0% relative duty cycle, as explained above in
		 * mchp_core_pwm_calc_period().
		 * The period is locked and we cannot change this, so we abort.
		 */
		if (hw_period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX)
			return -EINVAL;

		prescale = hw_prescale;
		period_steps = hw_period_steps;
	} else {
		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
	}

	duty_steps = mchp_core_pwm_calc_duty(chip, pwm, state, prescale, period_steps);

I'll aim for something like the (absolutely untested) above then when I
respin.

> (Hmm, in
> exactly one of them you check the return code, wouldn't that be sensible
> for both callers?)

Been messing with rust a bit of late, I love the #[must_use] attribute.
Looks to be an oversight since it's only going to return an error if the
clock rate exceeds what the FPGA is actually capable of.

Thanks again,
Conor.

