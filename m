Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9262E345
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiKQRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKQRiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:38:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C85B4A0;
        Thu, 17 Nov 2022 09:38:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F997621DA;
        Thu, 17 Nov 2022 17:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DD5C43146;
        Thu, 17 Nov 2022 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668706710;
        bh=ggzU7u09LLXVEK7H5l5kNbttSfGBUQn5Cxm4kEPkMfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmuGE7JFr7IjWILXQCZeb2lBDp74W9L+9YxV1e7r7255dfY3x0X2qs9KtjDVA3ODP
         X4uI2I2QOxv9r/syqNuwuRjxW2IkO6HhLB/s/57+hxyiMng9e5YSia/UgnetGIs2IH
         Sbo/kLlFM9FpjbEy7MB/dFedwW2ORawWPZgmCUrFx/6iAw0LkOXZ0w8iGDTVsKyTGw
         rI7OTpz/AcS+eZi9ZjtYlxXPDfCBpruK7I/Gijk1Vi8X/gXjL3O9GEX1OfvHStjqqW
         IQJLmNOQOkA1uPJvzaUSK/e2h/TpW3jUmeQmk/KOh7NA/Rvn7Igs2Rcl9/1nxYZhoN
         rCuvrWMTuIDqw==
Date:   Thu, 17 Nov 2022 17:38:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y3Zxkt3OSPQc46Q2@spud>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117164950.cssukd63fywzuwua@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:49:50PM +0100, Uwe Kleine-König wrote:
> Hello Conor,

Hello Uwe,

> On Thu, Nov 10, 2022 at 09:35:12AM +0000, Conor Dooley wrote:
> > [...]
> > +
> > +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				 bool enable, u64 period)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
> > +	u8 channel_enable, reg_offset, shift;
> > +
> > +	/*
> > +	 * There are two adjacent 8 bit control regs, the lower reg controls
> > +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> > +	 * and if so, offset by the bus width.
> > +	 */
> > +	reg_offset = MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> > +	shift = pwm->hwpwm & 7;
> > +
> > +	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
> > +	channel_enable &= ~(1 << shift);
> > +	channel_enable |= (enable << shift);
> > +
> > +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> > +	mchp_core_pwm->channel_enabled &= ~BIT(pwm->hwpwm);
> > +	mchp_core_pwm->channel_enabled |= enable << pwm->hwpwm;
> > +
> > +	/*
> > +	 * Notify the block to update the waveform from the shadow registers.
> > +	 * The updated values will not appear on the bus until they have been
> > +	 * applied to the waveform at the beginning of the next period. We must
> > +	 * write these registers and wait for them to be applied before
> > +	 * considering the channel enabled.
> > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > +	 */
> > +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > +		u64 delay;
> > +
> > +		delay = div_u64(period, 1000u) ? : 1u;
> > +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > +		usleep_range(delay, delay * 2);
> > +	}
> 
> In some cases the delay could be prevented. e.g. when going from one
> disabled state to another. If you don't want to complicate the driver
> here, maybe point it out in a comment at least?

Maybe this is my naivity talking, but I'd rather wait. Is there not the
chance that we re-enter pwm_apply() before the update has actually gone
through?
IIRC, but I'll have to confirm it, when the "shadow registers" are
enabled reads show the values that the hardware is using rather than the
values that are queued in the shadow registers. I'd rather avoid that
sort of mess and always sleep.

Now that I think of it, the reason I moved to unconditionally sleeping
was that if I turned on the PWM debugging it'd get tripped up. When it
tried to read the state, it got the old one rather than what'd just been
written.

Pasting my comment from above:
> > +	/*
> > +	 * Notify the block to update the waveform from the shadow registers.
> > +	 * The updated values will not appear on the bus until they have been

By "bus" in this statement, I meant on the AXI/AHB etc bus that the IP
core is connected to the CPUs on rather than the output. Perhaps my
wording of the comment could be improved and replace the word "bus" with
some wording containing "CPU" instead. "The updated values will not
appear to the CPU until" maybe.

I can also add some words relating to unconditionally sleeping w.r.t to
disabled states.

> > +	 * applied to the waveform at the beginning of the next period. We must
> > +	 * write these registers and wait for them to be applied before
> > +	 * considering the channel enabled.
> > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > +	 */

> It's not well defined if pwm_apply should only return when the new
> setting is actually active. (e.g. mxs doesn't wait)
> So I wonder: Are there any hardware restrictions between setting the
> SYNC_UPD flag and modifying the registers for duty and period? (I assume
> writing a new duty and period might then result in a glitch if the
> period just ends between the two writes.) Can you check if the hardware
> waits on such a completion, e.g. by reading that register?

Not entirely sure by what you mean: "waits on such a completion".
The hardware updates the registers at the first end-of-period after
SYNC_UPD is set. Don't write the bit, nothing happens. From the docs:

> > A shadow register holds all values and writes them when the SYNC_UPDATE
> > register is set to 1. In other words, for all channel synchronous
> > updates, write a "1" to the SYNC_UPDATE register after writing to all
> > the channel registers.

The docs also say:
> > SYNC_UPDATE: When this bit is set to "1" and SHADOW_REG_EN
> > is selected, all POSEDGE and NEGEDGE registers are updated
> > synchronously. Synchronous updates to the PWM waveform occur only
> > when SHADOW_REG_EN is asserted and SYNC_UPDATE is set to “1”.
> >
> > When this bit is set to "0", all the POSEDGE and NEGEDGE registers
> > are updated asynchronously

The second statement is at best vague (if the this bit in "when this
bit" refers to the bit in SHADOW_REG_EN) or contradictory at worse.
I suspect it's the former meaning, as shadow registers are a per-channel
thing. I suppose I have to go get some docs changed, **sigh**. It
doesn't make all that much sense to me, SHADOW_REG_EN is a RTL parameter
not a register that can be accessed from the AXI interface.

Anyways, back to the topic at hand.. if you were to do the following
(in really pseudocode form..):
	write(SYNC_UPD)
	write(period)
	<end-of-period>
	write(duty)

Then the duty cycle would not get updated, ever. At least, per doc
comment #1 & my "experimental" data. The RTL is rather dumb, since
AFAICT, this is meant to be cheap to implement in FPGA fabric.
Hence the default core configuration option is no shadow registers
& just immediately updates the output, waveform glitches be damned.

Hopefully that all helps?

> > +}
> > +
> > [...]
> > +
> > +static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				      const struct pwm_state *state)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
> > +	struct pwm_state current_state = pwm->state;
> 
> You're doing a copy of pwm->state just to use one of the members to pass
> it to mchp_core_pwm_enable.

Fallout from refactoring I assume. I'll drop it.

> > +	bool period_locked;
> > +	u64 duty_steps, clk_rate;
> 
> I think using unsigned long for clk_rate would be beneficial. The
> comparison against NSEC_PER_SEC might get cheaper (depending on how
> clever the compiler is), and calling mchp_core_pwm_calc_period
> should get cheaper, too. (At least on 32 bit archs.)

Sure.

> > +	u16 prescale;
> > +	u8 period_steps;
> > +
> > +	if (!state->enabled) {
> > +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * If clk_rate is too big, the following multiplication might overflow.
> > +	 * However this is implausible, as the fabric of current FPGAs cannot
> > +	 * provide clocks at a rate high enough.
> > +	 */
> > +	clk_rate = clk_get_rate(mchp_core_pwm->clk);
> > +	if (clk_rate >= NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	mchp_core_pwm_calc_period(state, clk_rate, &prescale, &period_steps);
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
> > +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> > +	}
> > +
> > +	duty_steps = mchp_core_pwm_calc_duty(state, clk_rate, prescale, period_steps);
> > +
> > +	/*
> > +	 * Because the period is per channel, it is possible that the requested
> > +	 * duty cycle is longer than the period, in which case cap it to the
> > +	 * period, IOW a 100% duty cycle.
> > +	 */
> > +	if (duty_steps > period_steps)
> > +		duty_steps = period_steps + 1;
> > +
> > +	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
> > +
> > +	mchp_core_pwm_enable(chip, pwm, true, state->period);
> 
> Don't you need to pass the previously configured period here?

Yeah, should be current_state. Thanks.

Conor.

