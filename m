Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E8A664F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjAJWtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjAJWsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:48:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311BC63D16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:48:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFNPe-0008Us-H1; Tue, 10 Jan 2023 23:48:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFNPd-005AeB-P3; Tue, 10 Jan 2023 23:48:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFNPc-00Boq1-SE; Tue, 10 Jan 2023 23:48:08 +0100
Date:   Tue, 10 Jan 2023 23:48:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="akz7byn3rrusukjo"
Content-Disposition: inline
In-Reply-To: <20221221112912.147210-2-conor@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--akz7byn3rrusukjo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Wed, Dec 21, 2022 at 11:29:12AM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 436 +++++++++++++++++++++++++++++++
>  3 files changed, 447 insertions(+)
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
> index 000000000000..047fa708b9fc
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,436 @@
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
> +#include <linux/ktime.h>
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
> +#define MCHPCOREPWM_TIMEOUT_MS	100u
> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct mutex lock; /* protect the shared period */
> +	ktime_t update_timestamp;
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
> +	 * applied to the waveform at the beginning of the next period.
> +	 * This is a NO-OP if the channel does not have shadow registers.
> +	 */
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
> +		if ((delay_us / 1000) > MAX_UDELAY_MS)
> +			msleep(delay_us / 1000 + 1);

Is this better than

	msleep(DIV_ROUND_UP(delay_us, 1000);

? Also I wonder about your usage of MAX_UDELAY_MS. This is about
udelay() but you're using usleep_range()?

> +		else
> +			usleep_range(delay_us, delay_us * 2);

I wonder if there isn't a function that implements something like

	wait_until(mchp_core_pwm->update_timestamp);

which would be a bit nicer than doing this by hand. Maybe fsleep()?

> +	}
> +}
> +
> +[...]
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     const struct pwm_state *state, u64 duty_steps,
> +				     u8 period_steps)
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

IMHO

		negedge =3D duty_steps ? 0 : period_steps_val;

is a bit easier to parse.

> +		posedge =3D duty_steps;
> +	} else {
> +		posedge =3D !duty_steps ? period_steps_val : 0u;
> +		negedge =3D duty_steps;
> +	}

The following code is equivalent:

	u8 first_edge =3D 0, second_edge =3D duty_steps;

	/*
	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
	 * so that's an unsuitable setting to model duty_steps =3D 0.
	 * In that case set the unwanted edge to a value that never
	 * triggers.
	 */
	if (duty_steps =3D=3D 0)
		first_edge =3D period_steps_val;

	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
		negedge =3D first_edge;
		posedge =3D second_edge;
	} else {
		posedge =3D first_edge;
		negedge =3D second_edge;
	}

I'm not sure if it's easier to understand. What do you think?

> +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->=
hwpwm));
> +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->=
hwpwm));
> +}
> +
> +static void mchp_core_pwm_calc_period(const struct pwm_state *state, uns=
igned long clk_rate,
> +				      u16 *prescale, u8 *period_steps)
> +{
> +	u64 tmp;
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
> +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * The hardware adds one to the register value, so decrement by one to
> +	 * account for the offset
> +	 */
> +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> +
> +		return;
> +	}
> +
> +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
> +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;

This looks wrong, but I didn't think long about that. Did we discuss
this already and/or are you sure this is correct?

(We have:
	          (prescale + 1) * (period_steps + 1)
	period =3D ------------------------------------
	                       clk_rate

You calculate
	            period * clk_rate
	prescale =3D -------------------
	           NSEC_PER_SEC * 0xff

	                     period * clk_rate
	period_steps =3D ----------------------------- - 1
	               NSEC_PER_SEC * (prescale + 1)

assuming exact arithmetic putting these into the above equation we get:


    period * clk_rate                period * clk_rate
  (------------------- + 1) * (-----------------------------) / clk_rate
   NSEC_PER_SEC * 0xff         NSEC_PER_SEC * (prescale + 1)

and then substituting prescale this doesn't resolve to period, does it?
Correct me if I'm wrong.)

> +}
> +
> +static inline void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip =
*mchp_core_pwm,
> +					      u8 prescale, u8 period_steps)
> +{
> +	writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> +}

There is only one caller for this two-line function. I suggest to unroll it?

> [...]
> +static int mchp_core_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm;
> +	struct resource *regs;
> +	int ret;
> +
> +	mchp_core_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_=
KERNEL);
> +	if (!mchp_core_pwm)
> +		return -ENOMEM;
> +
> +	mchp_core_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, 0,=
 &regs);
> +	if (IS_ERR(mchp_core_pwm->base))
> +		return PTR_ERR(mchp_core_pwm->base);
> +
> +	mchp_core_pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(mchp_core_pwm->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_core_pwm->clk),
> +				     "failed to get PWM clock\n");
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask=
",
> +				 &mchp_core_pwm->sync_update_mask))
> +		mchp_core_pwm->sync_update_mask =3D 0;
> +
> +	mutex_init(&mchp_core_pwm->lock);
> +
> +	mchp_core_pwm->chip.dev =3D &pdev->dev;
> +	mchp_core_pwm->chip.ops =3D &mchp_core_pwm_ops;
> +	mchp_core_pwm->chip.npwm =3D 16;
> +
> +	mchp_core_pwm->channel_enabled =3D readb_relaxed(mchp_core_pwm->base + =
MCHPCOREPWM_EN(0));
> +	mchp_core_pwm->channel_enabled |=3D
> +		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(1)) << 8;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	/*
> +	 * Enabled synchronous update for channels with shadow registers
> +	 * enabled. For channels without shadow registers, this has no effect
> +	 * at all so is unconditionally enabled.
> +	 */
> +	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> +	mchp_core_pwm->update_timestamp =3D ktime_get();

This needs to be done before devm_pwmchip_add().

> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--akz7byn3rrusukjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO96yIACgkQwfwUeK3K
7AmvLgf/Rx4A4wm13oIwezZ/QnWCTqkwO1qA+UUIr1VMXoHhaxf4T/ldigKYZCCz
M8IamtZ8/0+vi6SXq3Xeet0wu9Ql0POlAKG4gE2Cxce3TY+h3jOdLjZHk/KTEleD
IQaeljrodmoW/k6FqaaHAddYMjrISo6G4qk8mCHbGBB0TDxuuySkOvSfYgmfChnW
v9xSpRtmgnsf5/iyhucHRA0RqT21CCZKix/fmLELsyCk7EKetoAjjMaMYqY3BKTk
YrmmhKPHyeGtOlpSPMcmVH0rUyI5rHvQn9JwT/xD9NiSLZiGtxJ+fxb97A4B7E5N
eJpanb+/GkgfhHDK05dsF7Vxe4WPsA==
=f/8o
-----END PGP SIGNATURE-----

--akz7byn3rrusukjo--
