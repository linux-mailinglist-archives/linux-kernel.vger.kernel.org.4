Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4485B9526
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIOHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIOHWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:22:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9138B2DD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:22:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYjC9-0003VR-O8; Thu, 15 Sep 2022 09:21:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYjC9-000qe9-Qn; Thu, 15 Sep 2022 09:21:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYjC7-00128B-Jj; Thu, 15 Sep 2022 09:21:55 +0200
Date:   Thu, 15 Sep 2022 09:21:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220915072152.y346csakn7wetpz5@pengutronix.de>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s27i4bbymvcnc6ny"
Content-Disposition: inline
In-Reply-To: <20220824091215.141577-4-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s27i4bbymvcnc6ny
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 24, 2022 at 10:12:14AM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 402 +++++++++++++++++++++++++++++++
>  3 files changed, 413 insertions(+)
>  create mode 100644 drivers/pwm/pwm-microchip-core.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..e4de8c02c3c0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -393,6 +393,16 @@ config PWM_MEDIATEK
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-mediatek.
> =20
> +config PWM_MICROCHIP_CORE
> +	tristate "Microchip corePWM PWM support"
> +	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> +	depends on HAS_IOMEM && OF
> +	help
> +	  PWM driver for Microchip FPGA soft IP core.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-microchip-core.
> +
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
>  	depends on ARCH_MXS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..a65625359ece 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
> +obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip=
-core.c
> new file mode 100644
> index 000000000000..4ec2f1fce600
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * corePWM driver for Microchip "soft" FPGA IP cores.
> + *
> + * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + * Documentation:
> + * https://www.microsemi.com/document-portal/doc_download/1245275-corepw=
m-hb
> + *
> + * Limitations:
> + * - If the IP block is configured without "shadow registers", all regis=
ter
> + *   writes will take effect immediately, causing glitches on the output.
> + *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" reg=
ister
> + *   notifies the core that it needs to update the registers defining the
> + *   waveform from the contents of the "shadow registers".
> + * - The IP block has no concept of a duty cycle, only rising/falling ed=
ges of
> + *   the waveform. Unfortunately, if the rising & falling edges register=
s have
> + *   the same value written to them the IP block will do whichever of a =
rising
> + *   or a falling edge is possible. I.E. a 50% waveform at twice the req=
uested
> + *   period. Therefore to get a 0% waveform, the output is set the max h=
igh/low
> + *   time depending on polarity.
> + * - The PWM period is set for the whole IP block not per channel. The d=
river
> + *   will only change the period if no other PWM output is enabled.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define PREG_TO_VAL(PREG) ((PREG) + 1)
> +
> +#define MCHPCOREPWM_PRESCALE_MAX	0x100
> +#define MCHPCOREPWM_PERIOD_STEPS_MAX	0xff
> +#define MCHPCOREPWM_PERIOD_MAX		0xff00
> +
> +#define MCHPCOREPWM_PRESCALE	0x00
> +#define MCHPCOREPWM_PERIOD	0x04
> +#define MCHPCOREPWM_EN(i)	(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
> +#define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0=
x88 */
> +#define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0=
x8c */
> +#define MCHPCOREPWM_SYNC_UPD	0xe4
> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct mutex lock; /* protect the shared period */
> +	void __iomem *base;
> +	u32 sync_update_mask;
> +	u16 channel_enabled;
> +};
> +
> +static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chi=
p *chip)
> +{
> +	return container_of(chip, struct mchp_core_pwm_chip, chip);
> +}
> +
> +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 bool enable, u64 period)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 channel_enable, reg_offset, shift;
> +
> +	/*
> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> +	 * and if so, offset by the bus width.
> +	 */
> +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> +	shift =3D pwm->hwpwm & 7;
> +
> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> +	channel_enable &=3D ~(1 << shift);
> +	channel_enable |=3D (enable << shift);
> +
> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> +	mchp_core_pwm->channel_enabled &=3D ~BIT(pwm->hwpwm);
> +	mchp_core_pwm->channel_enabled |=3D enable << pwm->hwpwm;
> +
> +	/*
> +	 * Notify the block to update the waveform from the shadow registers.
> +	 * The updated values will not appear on the bus until they have been
> +	 * applied to the waveform at the beginning of the next period. We must
> +	 * write these registers and wait for them to be applied before
> +	 * considering the channel enabled.
> +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> +	 */
> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> +		u64 delay;
> +
> +		delay =3D div_u64(period, 1000u) ? : 1u;
> +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> +		usleep_range(delay, delay * 2);
> +	}
> +}
> +
> +static u64 mchp_core_pwm_calc_duty(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   const struct pwm_state *state, u8 prescale, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 duty_steps, tmp;
> +	u16 prescale_val =3D PREG_TO_VAL(prescale);
> +
> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 */
> +	duty_steps =3D state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
> +	tmp =3D prescale_val * NSEC_PER_SEC;
> +	return div64_u64(duty_steps, tmp);
> +}
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     const struct pwm_state *state, u64 duty_steps, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 posedge, negedge;
> +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);
> +
> +	/*
> +	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> +	 * so that's an unsuitable setting to model duty_steps =3D 0.
> +	 * In that case set the unwanted edge to a value that never
> +	 * triggers.
> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		negedge =3D !duty_steps ? period_steps_val : 0u;
> +		posedge =3D duty_steps;
> +	} else {
> +		posedge =3D !duty_steps ? period_steps_val : 0u;
> +		negedge =3D duty_steps;
> +	}
> +
> +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->=
hwpwm));
> +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->=
hwpwm));
> +}
> +
> +static int mchp_core_pwm_calc_period(struct pwm_chip *chip, const struct=
 pwm_state *state,
> +				     u8 *prescale, u8 *period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 tmp, clk_rate;
> +
> +	/*
> +	 * Calculate the period cycles and prescale values.
> +	 * The registers are each 8 bits wide & multiplied to compute the period
> +	 * using the formula:
> +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> +	 * so the maximum period that can be generated is 0x10000 times the
> +	 * period of the input clock.
> +	 * However, due to the design of the "hardware", it is not possible to
> +	 * attain a 100% duty cycle if the full range of period_steps is used.
> +	 * Therefore period_steps is restricted to 0xFE and the maximum multiple
> +	 * of the clock period attainable is 0xFF00.
> +	 */
> +	clk_rate =3D clk_get_rate(mchp_core_pwm->clk);
> +
> +	/*
> +	 * If clk_rate is too big, the following multiplication might overflow.
> +	 * However this is implausible, as the fabric of current FPGAs cannot
> +	 * provide clocks at a rate high enough.
> +	 */
> +	if (clk_rate >=3D NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * The hardware adds one to the register value, so decrement by one to
> +	 * account for the offset
> +	 */
> +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> +		return 0;
> +	}
> +
> +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
> +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
> +
> +	return 0;
> +}
> +
> +static inline void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip =
*mchp_core_pwm,
> +					      u8 prescale, u8 period_steps)
> +{
> +	writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> +}
> +
> +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	struct pwm_state current_state =3D pwm->state;
> +	bool period_locked;
> +	u64 duty_steps;
> +	u16 prescale;
> +	u8 period_steps;
> +	int ret;
> +
> +	mutex_lock(&mchp_core_pwm->lock);
> +
> +	if (!state->enabled) {
> +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> +		mutex_unlock(&mchp_core_pwm->lock);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If the only thing that has changed is the duty cycle or the polarity,
> +	 * we can shortcut the calculations and just compute/apply the new duty
> +	 * cycle pos & neg edges
> +	 * As all the channels share the same period, do not allow it to be
> +	 * changed if any other channels are enabled.
> +	 * If the period is locked, it may not be possible to use a period
> +	 * less than that requested. In that case, we just abort.
> +	 */
> +	period_locked =3D mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
> +
> +	if (period_locked) {
> +		u16 hw_prescale;
> +		u8 hw_period_steps;
> +
> +		mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);

Huh, if (u8 *)&prescale works depends on endianness.

> +		hw_prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCA=
LE);
> +		hw_period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PE=
RIOD);
> +
> +		if ((period_steps + 1) * (prescale + 1) <
> +		    (hw_period_steps + 1) * (hw_prescale + 1)) {
> +			mutex_unlock(&mchp_core_pwm->lock);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * It is possible that something could have set the period_steps

My German feel for the English language says s/could have/has/
> +		 * register to 0xff, which would prevent us from setting a 100%

For my understanding: It would also prevent a 0% relative duty, right?

> +		 * duty cycle, as explained in the mchp_core_pwm_calc_period()

s/duty/relative duty/; s/the //

> +		 * above.
> +		 * The period is locked and we cannot change this, so we abort.
> +		 */
> +		if (period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX) {

Don't you need to check hw_period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX
here?

> +			mutex_unlock(&mchp_core_pwm->lock);
> +			return -EINVAL;
> +		}
> +
> +		prescale =3D hw_prescale;
> +		period_steps =3D hw_period_steps;
> +	} else if (!current_state.enabled || current_state.period !=3D state->p=
eriod) {
> +		ret =3D mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &perio=
d_steps);

ret is only used in this block, so the declaration can go into here,
too.

> +		if (ret) {
> +			mutex_unlock(&mchp_core_pwm->lock);
> +			return ret;
> +		}
> +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> +	} else {
> +		prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +		period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIO=
D);
> +		/*
> +		 * As above, it is possible that something could have set the
> +		 * period_steps register to 0xff, which would prevent us from
> +		 * setting a 100% duty cycle, as explained above.
> +		 * As the period is not locked, we are free to fix this.
> +		 */

Are you sure this is safe? I think it isn't. Consider:

	pwm_apply_state(mypwm, { .duty =3D 0, .period =3D A, .enabled =3D true, });
	pwm_apply_state(mypwm, { .duty =3D 0, .period =3D B, .enabled =3D false, }=
);
	pwm_apply_state(mypwm, { .duty =3D 0, .period =3D B, .enabled =3D true, });

Then you have in the third call prescale and period_steps still
corresponding to A because you didn't update these registers in the 2nd
call as you exited early.

> +		if (period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX) {
> +			period_steps -=3D 1;
> +			mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> +		}
> +	}
> +
> +	duty_steps =3D mchp_core_pwm_calc_duty(chip, pwm, state, prescale, peri=
od_steps);
> +
> +	/*
> +	 * Because the period is per channel, it is possible that the requested
> +	 * duty cycle is longer than the period, in which case cap it to the
> +	 * period, IOW a 100% duty cycle.
> +	 */
> +	if (duty_steps > period_steps)
> +		duty_steps =3D period_steps + 1;
> +
> +	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
> +
> +	mchp_core_pwm_enable(chip, pwm, true, state->period);
> +
> +	mutex_unlock(&mchp_core_pwm->lock);
> +
> +	return 0;

Locking could be a bit simplified by doing:

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-c=
ore.c
index 4ec2f1fce600..d1578d73818f 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -197,8 +197,8 @@ static inline void mchp_core_pwm_apply_period(struct mc=
hp_core_pwm_chip *mchp_co
 	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
 }
=20
-static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
-			       const struct pwm_state *state)
+static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
+				      const struct pwm_state *state)
 {
 	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
 	struct pwm_state current_state =3D pwm->state;
@@ -208,11 +208,8 @@ static int mchp_core_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
 	u8 period_steps;
 	int ret;
=20
-	mutex_lock(&mchp_core_pwm->lock);
-
 	if (!state->enabled) {
 		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
-		mutex_unlock(&mchp_core_pwm->lock);
 		return 0;
 	}
=20
@@ -236,10 +233,8 @@ static int mchp_core_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
 		hw_period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERI=
OD);
=20
 		if ((period_steps + 1) * (prescale + 1) <
-		    (hw_period_steps + 1) * (hw_prescale + 1)) {
+		    (hw_period_steps + 1) * (hw_prescale + 1))
-			mutex_unlock(&mchp_core_pwm->lock);
 			return -EINVAL;
-		}
=20
 		/*
 		 * It is possible that something could have set the period_steps
@@ -248,19 +243,16 @@ static int mchp_core_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
 		 * above.
 		 * The period is locked and we cannot change this, so we abort.
 		 */
-		if (period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX) {
+		if (period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX)
-			mutex_unlock(&mchp_core_pwm->lock);
 			return -EINVAL;
-		}
=20
 		prescale =3D hw_prescale;
 		period_steps =3D hw_period_steps;
 	} else if (!current_state.enabled || current_state.period !=3D state->per=
iod) {
 		ret =3D mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_=
steps);
-		if (ret) {
+		if (ret)
-			mutex_unlock(&mchp_core_pwm->lock);
 			return ret;
-		}
+
 		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
 	} else {
 		prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
@@ -292,11 +284,24 @@ static int mchp_core_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
=20
 	mchp_core_pwm_enable(chip, pwm, true, state->period);
=20
-	mutex_unlock(&mchp_core_pwm->lock);
-
 	return 0;
 }
=20
+static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
+			       const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
+	int ret;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	ret =3D mchp_core_pwm_apply_locked(chip, pwm, state);
+
+	mutex_unlock(&mchp_core_pwm->lock);
+
+	return ret;
+}
+
 static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
 				    struct pwm_state *state)
 {

The diffstat is negative, so maybe that's subjective.

> +}
> +
> +static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u16 prescale;
> +	u8 period_steps, duty_steps, posedge, negedge;
> +
> +	mutex_lock(&mchp_core_pwm->lock);
> +
> +	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	prescale =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPW=
M_PRESCALE));
> +
> +	period_steps =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCO=
REPWM_PERIOD));
> +	state->period =3D period_steps * prescale * NSEC_PER_SEC;

This is broken on 32 bit archs (here: arm):

$ cat test.c
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	uint8_t period_steps =3D atoi(argv[1]);
	uint16_t prescale =3D atoi(argv[2]);
	uint64_t period;

	period =3D period_steps * prescale * 1000000000L;

	printf("period_steps =3D %" PRIu8 "\n", period_steps);
	printf("prescale =3D %" PRIu16 "\n", prescale);
	printf("period =3D %" PRIu64 "\n", period);

	return 0;
}

$ make test
cc     test.c   -o test

$ ./test 255 65535
period_steps =3D 255
prescale =3D 65535
period =3D 18446744073018591744

The problem is that the result of 16711425 * 1000000000L isn't affected
by the type of period and so it's promoted to L which isn't big enough
to hold 16711425000000000 where longs are only 32 bit wide.

> +	state->period =3D DIV64_U64_ROUND_UP(state->period, clk_get_rate(mchp_c=
ore_pwm->clk));
> +
> +	posedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm=
->hwpwm));
> +	negedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm=
->hwpwm));
> +
> +	if ((negedge =3D=3D posedge) && state->enabled) {

Why do you need that state->enabled?

> +		state->duty_cycle =3D state->period;
> +		state->period *=3D 2;
> +	} else {
> +		duty_steps =3D abs((s16)posedge - (s16)negedge);
> +		state->duty_cycle =3D duty_steps * prescale * NSEC_PER_SEC;
> +		state->duty_cycle =3D DIV64_U64_ROUND_UP(state->duty_cycle,
> +						       clk_get_rate(mchp_core_pwm->clk));

Micro optimisation: Call clk_get_rate() only once.

> +	}
> +
> +	state->polarity =3D negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POL=
ARITY_NORMAL;
> +
> +	mutex_unlock(&mchp_core_pwm->lock);

You could release the lock a bit earlier.

> +}
> +
> +static const struct pwm_ops mchp_core_pwm_ops =3D {
> +	.apply =3D mchp_core_pwm_apply,
> +	.get_state =3D mchp_core_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id mchp_core_of_match[] =3D {
> +	{
> +		.compatible =3D "microchip,corepwm-rtl-v4",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mchp_core_of_match);
> +
> +static int mchp_core_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mchp_core_pwm_chip *mchp_pwm;
> +	struct resource *regs;
> +	int ret;
> +
> +	mchp_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*mchp_pwm), GFP_KERNEL);
> +	if (!mchp_pwm)
> +		return -ENOMEM;
> +
> +	mchp_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &reg=
s);
> +	if (IS_ERR(mchp_pwm->base))
> +		return PTR_ERR(mchp_pwm->base);
> +
> +	mchp_pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(mchp_pwm->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_pwm->clk),
> +				     "failed to get PWM clock\n");
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask=
",
> +				 &mchp_pwm->sync_update_mask))
> +		mchp_pwm->sync_update_mask =3D 0u;

That u suffix is unusual. I'd drop it.

> +	mutex_init(&mchp_pwm->lock);
> +
> +	mchp_pwm->chip.dev =3D &pdev->dev;
> +	mchp_pwm->chip.ops =3D &mchp_core_pwm_ops;
> +	mchp_pwm->chip.npwm =3D 16;
> +
> +	mchp_pwm->channel_enabled =3D readb_relaxed(mchp_pwm->base + MCHPCOREPW=
M_EN(0));
> +	mchp_pwm->channel_enabled |=3D readb_relaxed(mchp_pwm->base + MCHPCOREP=
WM_EN(1)) << 8;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &mchp_pwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mchp_core_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "mchp-core-pwm",
> +		.of_match_table =3D mchp_core_of_match,
> +	},
> +	.probe =3D mchp_core_pwm_probe,
> +};
> +module_platform_driver(mchp_core_pwm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s27i4bbymvcnc6ny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMi0o0ACgkQwfwUeK3K
7AmHigf+OK4CW6QoqlGQwB5uR+EuBJa9T5NQZ2GdzZubRGJIVfgSFf3AnfLpxSlk
dNXLb+uEC5W08WChw/Oyr5iL+MbzLogJqTghekMps6regvVANE/Ia9VgKJ45DTU/
dCgE9HqnpmbkqvP3aLhnXAZrDXYxu6hZu3EEdTvISr5OpnrDplnN+gxlncVYyjhI
5aUQcjrKxmrgrp4b4Mn/64pQ1NuwITl6WOknI6yh4osWY/UPBhzRn8sUKENcwg47
Znd/NIpni/dLsA5KaFjcOEAcYC8RWqHBU+b6lmuYhaBONAdaKGLY2lbne7tw5Syf
eHvH4pEEHKJPxHaNkB4Sm6O9W4qiKw==
=bTyK
-----END PGP SIGNATURE-----

--s27i4bbymvcnc6ny--
