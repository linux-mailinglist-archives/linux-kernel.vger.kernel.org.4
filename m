Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7EC62E7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiKQWFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbiKQWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:04:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0777C469;
        Thu, 17 Nov 2022 14:03:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E85FA62290;
        Thu, 17 Nov 2022 22:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0C6C433C1;
        Thu, 17 Nov 2022 22:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668722597;
        bh=zxGAvysgvDa0F1r7JtPcsHQ+BRG06zOKEyrd7h90Erk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7Vp0nm/RovxRpyyC3S8m26a/4LNQCFXKVe7vfEmwT6sVFVVYFSRTiW6rvAMFXJE+
         wHtn1/B25UNQSTQLG9hHYtRQzBdMZLKkBGbJENDn5y8aX7TR9zCuXwx6J4H7ufRJen
         k00gAu/IVzZ92Q7VBFvlelzZZPMH9g6FFSGfKvnorUffpVSWeDIdIWkHxNFCYkzEWP
         li3Rkvjr+h6X9fX8zmymnO+Wld31ejV6ZpoGF6+trBws/xW79gCkowwuiIeoRmn+qy
         0SkBnSqxM76RmRgimTDgH3anklH0F9TpOPmw/Sr2OD+8uUSKvzXVEs3vwXKt0fM4qY
         KvaoM9++19kRw==
Date:   Thu, 17 Nov 2022 22:03:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y3avobkvYK3ydKTS@spud>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
 <20221117210433.n5j7upqqksld42mu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117210433.n5j7upqqksld42mu@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:04:33PM +0100, Uwe Kleine-König wrote:
> On Thu, Nov 17, 2022 at 05:38:26PM +0000, Conor Dooley wrote:
> > On Thu, Nov 17, 2022 at 05:49:50PM +0100, Uwe Kleine-König wrote:
> > > Hello Conor,
> > 
> > Hello Uwe,
> > 
> > > On Thu, Nov 10, 2022 at 09:35:12AM +0000, Conor Dooley wrote:
> > > > [...]
> > > > +
> > > > +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +				 bool enable, u64 period)
> > > > +{
> > > > +	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
> > > > +	u8 channel_enable, reg_offset, shift;
> > > > +
> > > > +	/*
> > > > +	 * There are two adjacent 8 bit control regs, the lower reg controls
> > > > +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> > > > +	 * and if so, offset by the bus width.
> > > > +	 */
> > > > +	reg_offset = MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> > > > +	shift = pwm->hwpwm & 7;
> > > > +
> > > > +	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
> > > > +	channel_enable &= ~(1 << shift);
> > > > +	channel_enable |= (enable << shift);
> > > > +
> > > > +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> > > > +	mchp_core_pwm->channel_enabled &= ~BIT(pwm->hwpwm);
> > > > +	mchp_core_pwm->channel_enabled |= enable << pwm->hwpwm;
> > > > +
> > > > +	/*
> > > > +	 * Notify the block to update the waveform from the shadow registers.
> > > > +	 * The updated values will not appear on the bus until they have been
> > > > +	 * applied to the waveform at the beginning of the next period. We must
> > > > +	 * write these registers and wait for them to be applied before
> > > > +	 * considering the channel enabled.
> > > > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > > > +	 */
> > > > +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > > +		u64 delay;
> > > > +
> > > > +		delay = div_u64(period, 1000u) ? : 1u;
> > > > +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > > > +		usleep_range(delay, delay * 2);
> > > > +	}
> > > 
> > > In some cases the delay could be prevented. e.g. when going from one
> > > disabled state to another. If you don't want to complicate the driver
> > > here, maybe point it out in a comment at least?
> > 
> > Maybe this is my naivity talking, but I'd rather wait. Is there not the
> > chance that we re-enter pwm_apply() before the update has actually gone
> > through?
> 
> My idea was to do something like that:
> 
> 	int mchp_core_pwm_apply(....)
> 	{
> 		if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> 			/*
> 			 * We're still waiting for an update, don't
> 			 * interfer until it's completed.
> 			 */
> 			while (readl_relaxed(mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD)) {
> 				cpu_relax();
> 				if (waited_unreasonably_long())
> 					return -ETIMEOUT;
> 			}
> 		}
> 
> 		update_period_and_duty(...);
> 		return 0;
> 	}
> 
> This way you don't have to wait at all if the calls to pwm_apply() are
> infrequent. Of course this only works this way, if you can determine if
> there is a pending update.

Ah I think I get what you mean now about waiting for completion &
reading the bit. I don't know off the top of my head if that bit is
readable. Docs say that they're R/W but I don't know if that means that
an AXI read works or if the value is actually readable. I'll try
something like this if I can.

> From a simplicity POV always waiting is fine. But if you consider
> periods of say 5s, letting a call to pwm_apply() do a sleep between 5
> and 10 seconds at the end is quite long and blocks the caller
> considerably.

Yeah, I know. At the end of the day, you're the one familiar with what
PWM consumers expect. If things go the wait-but-maybe-exit-early
direction I think I'll add something to the limitations to cover that.

> > IIRC, but I'll have to confirm it, when the "shadow registers" are
> > enabled reads show the values that the hardware is using rather than the
> > values that are queued in the shadow registers. I'd rather avoid that
> > sort of mess and always sleep.
> > 
> > Now that I think of it, the reason I moved to unconditionally sleeping
> > was that if I turned on the PWM debugging it'd get tripped up. When it
> > tried to read the state, it got the old one rather than what'd just been
> > written.
> > 
> > Pasting my comment from above:
> > > > +	/*
> > > > +	 * Notify the block to update the waveform from the shadow registers.
> > > > +	 * The updated values will not appear on the bus until they have been
> > 
> > By "bus" in this statement, I meant on the AXI/AHB etc bus that the IP
> > core is connected to the CPUs on rather than the output. Perhaps my
> > wording of the comment could be improved and replace the word "bus" with
> > some wording containing "CPU" instead. "The updated values will not
> > appear to the CPU until" maybe.
> 
> I'd write: Reading the registers yields the currently implemented
> settings, the new ones are only readable once the current period ended.

Cool, will use that so.

> > I can also add some words relating to unconditionally sleeping w.r.t to
> > disabled states.
> > 
> > > > +	 * applied to the waveform at the beginning of the next period. We must
> > > > +	 * write these registers and wait for them to be applied before
> > > > +	 * considering the channel enabled.
> > > > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > > > +	 */
> > 
> > > It's not well defined if pwm_apply should only return when the new
> > > setting is actually active. (e.g. mxs doesn't wait)
> > > So I wonder: Are there any hardware restrictions between setting the
> > > SYNC_UPD flag and modifying the registers for duty and period? (I assume
> > > writing a new duty and period might then result in a glitch if the
> > > period just ends between the two writes.) Can you check if the hardware
> > > waits on such a completion, e.g. by reading that register?
> > 
> > Not entirely sure by what you mean: "waits on such a completion".
> 
> I wanted to say that it's okish to return from .apply() without the
> sleep and so return to the caller before the requested setting appears
> on the output. At least your driver wouldn't be the first to do it that
> way.

I'd be more comfortable with it if the readable registers didn't hold
the old value. 

> > The hardware updates the registers at the first end-of-period after
> > SYNC_UPD is set. Don't write the bit, nothing happens. From the docs:
> > 
> > > > A shadow register holds all values and writes them when the SYNC_UPDATE
> > > > register is set to 1. In other words, for all channel synchronous
> > > > updates, write a "1" to the SYNC_UPDATE register after writing to all
> > > > the channel registers.
> > 
> > The docs also say:
> > > > SYNC_UPDATE: When this bit is set to "1" and SHADOW_REG_EN
> > > > is selected, all POSEDGE and NEGEDGE registers are updated
> > > > synchronously. Synchronous updates to the PWM waveform occur only
> > > > when SHADOW_REG_EN is asserted and SYNC_UPDATE is set to “1”.
> > > >
> > > > When this bit is set to "0", all the POSEDGE and NEGEDGE registers
> > > > are updated asynchronously
> > 
> > The second statement is at best vague (if the this bit in "when this
> > bit" refers to the bit in SHADOW_REG_EN) or contradictory at worse.
> > I suspect it's the former meaning, as shadow registers are a per-channel
> > thing. I suppose I have to go get some docs changed, **sigh**. It
> > doesn't make all that much sense to me, SHADOW_REG_EN is a RTL parameter
> > not a register that can be accessed from the AXI interface.
> > 
> > Anyways, back to the topic at hand.. if you were to do the following
> > (in really pseudocode form..):
> > 	write(SYNC_UPD)
> > 	write(period)
> > 	<end-of-period>
> > 	write(duty)
> > 
> > Then the duty cycle would not get updated, ever. At least, per doc
> > comment #1 & my "experimental" data. The RTL is rather dumb, since
> > AFAICT, this is meant to be cheap to implement in FPGA fabric.
> > Hence the default core configuration option is no shadow registers
> > & just immediately updates the output, waveform glitches be damned.
> > 
> > Hopefully that all helps?
> 
> I already understood it that way. I hope I was able to clarify my
> thoughts above.

Yeah, I think you did!

Thanks again,
Conor.

