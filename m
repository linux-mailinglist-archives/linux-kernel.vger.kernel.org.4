Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42E06DD86A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDKK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDKK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:56:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE12D57
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:56:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmBfC-0002Nf-UW; Tue, 11 Apr 2023 12:55:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmBfA-00ATxI-QQ; Tue, 11 Apr 2023 12:55:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmBf9-00CGCc-V2; Tue, 11 Apr 2023 12:55:47 +0200
Date:   Tue, 11 Apr 2023 12:55:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v16 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
 <20230411-bronzing-crust-d302408a1259@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isiq27cyft363uqx"
Content-Disposition: inline
In-Reply-To: <20230411-bronzing-crust-d302408a1259@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--isiq27cyft363uqx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Tue, Apr 11, 2023 at 09:56:34AM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 509 +++++++++++++++++++++++++++++++
>  3 files changed, 520 insertions(+)
>  create mode 100644 drivers/pwm/pwm-microchip-core.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..f42756a014ed 100644
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
> index 000000000000..0a69ec376c51
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * corePWM driver for Microchip "soft" FPGA IP cores.
> + *
> + * Copyright (c) 2021-2023 Microchip Corporation. All rights reserved.
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

You only write once to the sync update register (i.e. during probe). So
that register specifies that a period should be completed before a new
setting becomes active, right? Even with sync update this is still racy,
right?

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
> + *   If the duty cycle is 0%, and the requested period is less than the
> + *   available period resolution, this will manifest as a ~100% waveform=
 (with
> + *   some output glitches) rather than 50%.

The last paragraph refers to negedge =3D 0, posedge =3D 0 and period_steps =
=3D
0?

> + * - The PWM period is set for the whole IP block not per channel. The d=
river
> + *   will only change the period if no other PWM output is enabled.
> + */

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
> +	 * applied to the waveform at the beginning of the next period.
> +	 * This is a NO-OP if the channel does not have shadow registers.
> +	 */

The code doesn't match the comment. I think that is a relict from the
times when we thought that a trigger was necessary to update the
operating settings from the shadow registers?

> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm))
> +		mchp_core_pwm->update_timestamp =3D ktime_add_ns(ktime_get(), period);
> +}
> +
> +static void mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_chip=
 *mchp_core_pwm,
> +					       unsigned int channel)
> +{
> +	/*
> +	 * If a shadow register is used for this PWM channel, and iff there is
> +	 * a pending update to the waveform, we must wait for it to be applied
> +	 * before attempting to read its state. Reading the registers yields
> +	 * the currently implemented settings & the new ones are only readable
> +	 * once the current period has ended.
> +	 */
> +
> +	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
> +		ktime_t current_time =3D ktime_get();
> +		s64 remaining_ns;
> +		u32 delay_us;
> +
> +		remaining_ns =3D ktime_to_ns(ktime_sub(mchp_core_pwm->update_timestamp,
> +						     current_time));
> +
> +		/*
> +		 * If the update has gone through, don't bother waiting for
> +		 * obvious reasons. Otherwise wait around for an appropriate
> +		 * amount of time for the update to go through.
> +		 */
> +		if (remaining_ns <=3D 0)
> +			return;
> +
> +		delay_us =3D DIV_ROUND_UP_ULL(remaining_ns, NSEC_PER_USEC);
> +		fsleep(delay_us);
> +	}

There is no way to query the hardware if there is still an update
pending, right? Maybe that's possible implicitly by memoizing the
expected read value? For me the current approach is fine enough though.
This can be addressed in the future if needed.

> +static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 cl=
k_rate,
> +				   u8 prescale, u8 period_steps)
> +{
> +	u64 duty_steps, tmp;
> +
> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 */
> +	tmp =3D (prescale + 1) * NSEC_PER_SEC;
> +	duty_steps =3D mul_u64_u64_div_u64(state->duty_cycle, clk_rate, tmp);
> +
> +	return duty_steps;
> +}
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     const struct pwm_state *state, u64 duty_steps,
> +				     u16 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 posedge, negedge;
> +	u8 first_edge =3D 0, second_edge =3D duty_steps;
> +
> +	/*
> +	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> +	 * so that's an unsuitable setting to model duty_steps =3D 0.
> +	 * In that case set the unwanted edge to a value that never
> +	 * triggers.
> +	 */
> +	if (duty_steps =3D=3D 0)
> +		first_edge =3D period_steps + 1;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		negedge =3D first_edge;
> +		posedge =3D second_edge;
> +	} else {
> +		posedge =3D first_edge;
> +		negedge =3D second_edge;
> +	}
> +
> +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->=
hwpwm));
> +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->=
hwpwm));

Is this racy with sync update implemented in the firmware? A comment
about how the sync update is implemented would be good.

> +}
> +
> +static int mchp_core_pwm_calc_period(const struct pwm_state *state, unsi=
gned long clk_rate,
> +				     u16 *prescale, u16 *period_steps)
> +{
> +	u64 tmp;
> +	u32 remainder;
> +
> +	/*
> +	 * Calculate the period cycles and prescale values.
> +	 * The registers are each 8 bits wide & multiplied to compute the period
> +	 * using the formula:
> +	 *           (prescale + 1) * (period_steps + 1)
> +	 * period =3D -------------------------------------
> +	 *                      clk_rate
> +	 * so the maximum period that can be generated is 0x10000 times the
> +	 * period of the input clock.
> +	 * However, due to the design of the "hardware", it is not possible to
> +	 * attain a 100% duty cycle if the full range of period_steps is used.
> +	 * Therefore period_steps is restricted to 0xfe and the maximum multiple
> +	 * of the clock period attainable is (0xff + 1) * (0xfe + 1) =3D 0xff00
> +	 *
> +	 * The prescale and period_steps registers operate similarly to
> +	 * CLK_DIVIDER_ONE_BASED, where the value used by the hardware is that
> +	 * in the register plus one.
> +	 * It's therefore not possible to set a period lower than 1/clk_rate, so
> +	 * if tmp is 0, abort. Without aborting, we will set a period that is
> +	 * greater than that requested and, more importantly, will trigger the
> +	 * neg-/pos-edge issue described in the limitations.
> +	 */
> +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> +	if (!tmp)
> +		return -EINVAL;
> +
> +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX;
> +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX;
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * There are multiple strategies that could be used to choose the
> +	 * prescale & period_steps values.
> +	 * Here the idea is to pick values so that the selection of duty cycles
> +	 * is as finegrain as possible.
> +	 * This "optimal" value for prescale can be calculated using the maximum
> +	 * permitted value of period_steps, 0xfe.
> +	 *
> +	 *                period * clk_rate
> +	 * prescale =3D ------------------------- - 1
> +	 *            NSEC_PER_SEC * (0xfe + 1)
> +	 *
> +	 * However, we are purely interested in the integer upper bound of this
> +	 * calculation, so this division should be rounded up before subtracting
> +	 * 1
> +	 *
> +	 *  period * clk_rate
> +	 * ------------------- was precomputed as `tmp`
> +	 *    NSEC_PER_SEC
> +	 */
> +	*prescale =3D DIV64_U64_ROUND_UP(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX + 1)=
 - 1;

If state->period * clk_rate is 765000000001 you get tmp =3D 765 and then
*prescale =3D 2. However roundup(765000000001 / (1000000000 * 255)) - 1 is
3. The problem here is that you're rounding down in the calculation of
tmp. Of course this is constructed because 765000000001 is prime, but
I'm sure you get the point :-)

Also we know that tmp is < 0xff00, so we don't need a 64 bit division
here.

> +	/*
> +	 * Because 0xff is not a permitted value some error will seep into the
> +	 * calculation of prescale as prescale grows. Specifically, this error
> +	 * occurs where the remainder of the prescale calculation is less than
> +	 * prescale.
> +	 * For small values of prescale, only a handful of values will need
> +	 * correction, but overall this applies to almost half of the valid
> +	 * values for tmp.
> +	 *
> +	 * To keep the algorithm's decision making consistent, this case is
> +	 * checked for and the simple solution is to, in these cases,
> +	 * decrement prescale and check that the resulting value of period_steps
> +	 * is valid.
> +	 *
> +	 * period_steps can be computed from prescale:
> +	 *                      period * clk_rate
> +	 * period_steps =3D ----------------------------- - 1
> +	 *                NSEC_PER_SEC * (prescale + 1)
> +	 *
> +	 */
> +	div_u64_rem(tmp, (MCHPCOREPWM_PERIOD_STEPS_MAX + 1), &remainder);
> +	if (remainder < *prescale) {
> +		u16 smaller_prescale =3D *prescale - 1;
> +
> +		*period_steps =3D div_u64(tmp, smaller_prescale + 1) - 1;
> +		if (*period_steps < 255) {
> +			*prescale =3D smaller_prescale;
> +
> +			return 0;
> +		}
> +	}

I don't understand that part. It triggers for tmp =3D 511. So you prefer

	prescale =3D 1
	period_steps =3D 254

yielding period =3D 510 / clkrate over

	prescale =3D 2
	period_steps =3D 170

yielding 513 / clkrate. I wonder why. Alsot tmp =3D 511 is the only value
where this triggers. There is a mistake somewhere (maybe on my side).

> +	*period_steps =3D div_u64(tmp, *prescale + 1);
> +	if (*period_steps)
> +		*period_steps -=3D 1;
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--isiq27cyft363uqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ1PLIACgkQj4D7WH0S
/k5Xcgf9FT3tkfQsGg+xBd+hzd9VO8BsTBBnmX5ODSsUv/v+vh4IOAhnV8b5HFau
KoS6xb5RjEdatx5HV0ppkTQZ0ZcWwlJzmS8PYk4h+ulO0GADVoIZCdnMgsACRwS1
IrY9ypO+VK9Bu4NhUCV1yDKT8fMw+hUBHaPpFqShofvUWbQhDLup6ubPO5oy3+XZ
3R3cLVPkBPfTp+l95YQOvTkMd81vStD11W5M+6XPsc9ogtAR57aHw9/9rfx+Worf
9TaLYWPKn8y/AZ62dEsqudFSQ1Rv0yHJg+SaoQ5p8H/KYJCw7YXNjtvVkIfUJgJI
OybSN8jvVXjzFvV/nPEjxZQwDf/yUw==
=jNxm
-----END PGP SIGNATURE-----

--isiq27cyft363uqx--
