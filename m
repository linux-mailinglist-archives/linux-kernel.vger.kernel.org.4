Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5DD6C4855
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCVKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCVKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:55:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463C5ADFB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:55:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pew83-0006bt-Ej; Wed, 22 Mar 2023 11:55:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pew81-005tlY-O8; Wed, 22 Mar 2023 11:55:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pew81-0071jo-4S; Wed, 22 Mar 2023 11:55:37 +0100
Date:   Wed, 22 Mar 2023 11:55:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v14 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230322105536.kgt3ffowefqlg6eu@pengutronix.de>
References: <20230306094858.1614819-1-conor.dooley@microchip.com>
 <20230306094858.1614819-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mmhscijbxkb5z243"
Content-Disposition: inline
In-Reply-To: <20230306094858.1614819-2-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mmhscijbxkb5z243
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 06, 2023 at 09:48:58AM +0000, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 441 +++++++++++++++++++++++++++++++
>  3 files changed, 452 insertions(+)
>  create mode 100644 drivers/pwm/pwm-microchip-core.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a22..f42756a014ed4 100644
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
> index 7bf1a29f02b84..a65625359ece4 100644
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
> index 0000000000000..a2a2e28f39031
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,441 @@
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
> +	struct mutex lock; /* protects the shared period */
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
> +		fsleep(delay_us);
> +	}
> +}
> +
> +static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 cl=
k_rate,
> +				   u8 prescale, u8 period_steps)
> +{
> +	u64 duty_steps, tmp;
> +	u16 prescale_val =3D PREG_TO_VAL(prescale);
> +
> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 */
> +	tmp =3D prescale_val * NSEC_PER_SEC;
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
> +		first_edge =3D PREG_TO_VAL(period_steps);
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
> +}
> +
> +static void mchp_core_pwm_calc_period(const struct pwm_state *state, uns=
igned long clk_rate,
> +				      u16 *prescale, u16 *period_steps)
> +{
> +	u64 tmp;
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
> +	/*
> +	 * The optimal value for prescale can be calculated using the maximum
> +	 * permitted value of period_steps, 0xff.

I had to think about that one for a while. The maximal value for
(period_steps + 1) is 0xff with the reasoning above?! That's also what
the code uses.

Also as the comment is written here, it's wrong (or misleading)
depending on the semantic of "optimal". If you want to achive

	(prescale + 1) * (period_steps + 1) <=3D 64009

you should pick prescale =3D=3D period_steps =3D=3D 252 to get optimally ne=
ar
64009.
However the idea is to pick a set of values with period_steps being big
to allow a finegrained selection for the duty cycle, right?

Consider

	clk_rate =3D 1000000
	period =3D 64009000

then your code gives:

              period * clk_rate
	tmp =3D ----------------- =3D 64009
                NSEC_PER_SEC

and so *prescale =3D 251 and *period_steps =3D 253.=20

Wasn't the intention to pick *prescale =3D 250 and then
*period_steps =3D 255?

Depending on your semantics of "optimal", either (252, 252) or (250,
255) is better than (251, 253). I think that means you shouldn't ignore
the -1?

One thing I think is strange is that with clk_rate =3D 1000001 and your
algorithm we get:

requested period =3D 1274998 ns -> real period =3D 1269998.73000127  (presc=
ale =3D 4, period_steps =3D 253)
requested period =3D 1274999 ns -> real period =3D 1271998.728001272 (presc=
ale =3D 5, period_steps =3D 211)

while 1271998.728001272 would be a better match for a request with
period =3D 1274998 than 1269998.73000127.

I spend too much time to think about that now. I'm unsure if this is
because the -1 is missing, or if there is a bug in the idea to pick a
small prescale to allow a big period_steps value (in combination with
the request to pick the biggest possible period).

Hmm, maybe you understand that better than me? I'll have to think about
it.

> +	 *
> +	 *             period * clk_rate
> +	 * prescale =3D ------------------- - 1
> +	 *            NSEC_PER_SEC * 0xff
> +	 *
> +	 * However, we are purely interested in the integer upper bound of this
> +	 * calculation, so ignore the subtraction & rely on the truncation done
> +	 * by the division.
> +	 *
> +	 *  period * clk_rate
> +	 * ------------------- was precomputed as `tmp`
> +	 *    NSEC_PER_SEC
> +	 *
> +	 * period_steps is then computed using the result:
> +	 *                      period * clk_rate
> +	 * period_steps =3D ----------------------------- - 1
> +	 *                NSEC_PER_SEC * (prescale + 1)
> +	 */
> +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
> +}
> +
> [..]
> +static int mchp_core_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm;
> +	struct resource *regs;
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
> +	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);

This one is just for the case where there is an unapplied configuration
in the registers, right?

> +	mchp_core_pwm->update_timestamp =3D ktime_get();
> +
> +	return devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);

An error message if devm_pwmchip_add() fails would be nice.

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
> --=20
> 2.39.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mmhscijbxkb5z243
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQa3qgACgkQj4D7WH0S
/k5h0wf+LRmJ9L8E7RG7zG6jTanu0IITqBLi4p78ZkXfwhnjs2h+8MoLsT5eRSIe
Ipr77XBS0H9hvbnh+nu7EeKqLlZdCV6/l81bm1k8Gkrsb9kpHpnPtOADaH4gELy4
S2mGPFvJj7OvQb6UzDKebsvqNQYK1EQVljntp2B08mym+owrVmkkiwA44NO12+u3
7G1vx/VnwPExZx5vNocR2S20xfwCds4K9GT10RZg16TYXq6pHtFGfP5AA2gS3tp/
EhSLiMg08ct3pQS6FKmCgmL6/n+3KKaYso7lGYQfDWfC0DnEICe9tDlPUv3eE17x
Dspm0ICuuigdEksKS2BqAxZd1KkY2A==
=+TlG
-----END PGP SIGNATURE-----

--mmhscijbxkb5z243--
