Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2A6C599C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCVWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545B28E64;
        Wed, 22 Mar 2023 15:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55E1621CA;
        Wed, 22 Mar 2023 22:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BB2C433D2;
        Wed, 22 Mar 2023 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679525384;
        bh=yvElztryIE4+jC42pUMbrSDuyuT0kahcEDOY+HjSwcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6VD4pqX39vo3VQvEA9jW8sj/FhLzmZ61O9nSQr9L/+30c/4NbVeX0dZytF38vHYf
         WfzaWUxf6Z/UGdAI0xR9rSJ2kubUHzKlHtR5U2e5rdbHaHWCmtUhdRA6oZMTYvtBHz
         fbwN2xXZk5zrxx+JTOxYTxeUHW3xJJ0zgvtlaDoLocxocMLSClPE8wYWbZTzUOO5J0
         dkEO8fV31ymMlMC8+VhxWdFEsOYQOjTMGwph6dWf6064uv04KxZj863s2vDOnoa4wT
         vKRB8OXy6b9d8Q9Eo7tyR9zLRM+xkb14CI+Si9qLH6dnxUHlFU/pkCPRX1dedFGBiE
         EnqW26V7bg+Rg==
Date:   Wed, 22 Mar 2023 22:49:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v14 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <48c7dbdc-04a2-42de-964f-fd86cf070797@spud>
References: <20230306094858.1614819-1-conor.dooley@microchip.com>
 <20230306094858.1614819-2-conor.dooley@microchip.com>
 <20230322105536.kgt3ffowefqlg6eu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vC/iEQs36o7KPCrh"
Content-Disposition: inline
In-Reply-To: <20230322105536.kgt3ffowefqlg6eu@pengutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vC/iEQs36o7KPCrh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 11:55:36AM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Mar 06, 2023 at 09:48:58AM +0000, Conor Dooley wrote:
> > Add a driver that supports the Microchip FPGA "soft" PWM IP core.

> > +static void mchp_core_pwm_calc_period(const struct pwm_state *state, u=
nsigned long clk_rate,
> > +				      u16 *prescale, u16 *period_steps)
> > +{
> > +	u64 tmp;
> > +
> > +	/*
> > +	 * Calculate the period cycles and prescale values.
> > +	 * The registers are each 8 bits wide & multiplied to compute the per=
iod
> > +	 * using the formula:
> > +	 *           (prescale + 1) * (period_steps + 1)
> > +	 * period =3D -------------------------------------
> > +	 *                      clk_rate
> > +	 * so the maximum period that can be generated is 0x10000 times the
> > +	 * period of the input clock.
> > +	 * However, due to the design of the "hardware", it is not possible to
> > +	 * attain a 100% duty cycle if the full range of period_steps is used.
> > +	 * Therefore period_steps is restricted to 0xFE and the maximum multi=
ple
> > +	 * of the clock period attainable is 0xFF00.
> > +	 */
> > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> > +
> > +	/*
> > +	 * The hardware adds one to the register value, so decrement by one to
> > +	 * account for the offset
> > +	 */
> > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > +
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * The optimal value for prescale can be calculated using the maximum
> > +	 * permitted value of period_steps, 0xff.
>=20
> I had to think about that one for a while. The maximal value for
> (period_steps + 1) is 0xff with the reasoning above?! That's also what
> the code uses.

I've become really disenfranchised with these register/variable names.
I feel like just changing them to disconnect the variables used for
calculation from the register names a little, so that the "is there a +1
needed here or not" stuff becomes a little clearer.
It always makes sense to be when I am in an "I respun the patch today"
mode, but by the time we're in the review stage I get muddled.
God forbid I have to look at this in 10 years time.

That said, there is a bit of a mistake here. The comment two above says
"Therefore period_steps is restricted to 0xFE" when I'm capping things
off. Some inaccuracies have probably snuck in during the various
respins, and I think the comment above is "correct" but misleading, as
it muddies the waters about variable versus register names.

> Also as the comment is written here, it's wrong (or misleading)
> depending on the semantic of "optimal". If you want to achive
>=20
> 	(prescale + 1) * (period_steps + 1) <=3D 64009
>=20
> you should pick prescale =3D=3D period_steps =3D=3D 252 to get optimally =
near
> 64009.
> However the idea is to pick a set of values with period_steps being big
> to allow a finegrained selection for the duty cycle, right?

Correct. I'll update the comments with an explanation as to what the
objective is, rather than just referring to it as "optimal".

> Consider
>=20
> 	clk_rate =3D 1000000
> 	period =3D 64009000
>=20
> then your code gives:
>=20
>               period * clk_rate
> 	tmp =3D ----------------- =3D 64009
>                 NSEC_PER_SEC
>=20
> and so *prescale =3D 251 and *period_steps =3D 253.=20
>=20
> Wasn't the intention to pick *prescale =3D 250 and then
> *period_steps =3D 255?
>=20
> Depending on your semantics of "optimal", either (252, 252) or (250,
> 255) is better than (251, 253). I think that means you shouldn't ignore
> the -1?
>=20
> One thing I think is strange is that with clk_rate =3D 1000001 and your
> algorithm we get:
>=20
> requested period =3D 1274998 ns -> real period =3D 1269998.73000127  (pre=
scale =3D 4, period_steps =3D 253)
> requested period =3D 1274999 ns -> real period =3D 1271998.728001272 (pre=
scale =3D 5, period_steps =3D 211)
>=20
> while 1271998.728001272 would be a better match for a request with
> period =3D 1274998 than 1269998.73000127.
>=20
> I spend too much time to think about that now. I'm unsure if this is
> because the -1 is missing, or if there is a bug in the idea to pick a
> small prescale to allow a big period_steps value (in combination with
> the request to pick the biggest possible period).
>=20
> Hmm, maybe you understand that better than me? I'll have to think about
> it.

I'll have to think about it too, I'll clear a space among the todo-lists
on my whiteboard tomorrow or Friday and get back to you...

>=20
> > +	 *
> > +	 *             period * clk_rate
> > +	 * prescale =3D ------------------- - 1
> > +	 *            NSEC_PER_SEC * 0xff
> > +	 *
> > +	 * However, we are purely interested in the integer upper bound of th=
is
> > +	 * calculation, so ignore the subtraction & rely on the truncation do=
ne
> > +	 * by the division.
> > +	 *
> > +	 *  period * clk_rate
> > +	 * ------------------- was precomputed as `tmp`
> > +	 *    NSEC_PER_SEC
> > +	 *
> > +	 * period_steps is then computed using the result:
> > +	 *                      period * clk_rate
> > +	 * period_steps =3D ----------------------------- - 1
> > +	 *                NSEC_PER_SEC * (prescale + 1)
> > +	 */
> > +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> > +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
> > +}
> > +
> > [..]
> > +static int mchp_core_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm;
> > +	struct resource *regs;
> > +
> > +	mchp_core_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GF=
P_KERNEL);
> > +	if (!mchp_core_pwm)
> > +		return -ENOMEM;
> > +
> > +	mchp_core_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, =
0, &regs);
> > +	if (IS_ERR(mchp_core_pwm->base))
> > +		return PTR_ERR(mchp_core_pwm->base);
> > +
> > +	mchp_core_pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(mchp_core_pwm->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_core_pwm->clk),
> > +				     "failed to get PWM clock\n");
> > +
> > +	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-ma=
sk",
> > +				 &mchp_core_pwm->sync_update_mask))
> > +		mchp_core_pwm->sync_update_mask =3D 0;
> > +
> > +	mutex_init(&mchp_core_pwm->lock);
> > +
> > +	mchp_core_pwm->chip.dev =3D &pdev->dev;
> > +	mchp_core_pwm->chip.ops =3D &mchp_core_pwm_ops;
> > +	mchp_core_pwm->chip.npwm =3D 16;
> > +
> > +	mchp_core_pwm->channel_enabled =3D readb_relaxed(mchp_core_pwm->base =
+ MCHPCOREPWM_EN(0));
> > +	mchp_core_pwm->channel_enabled |=3D
> > +		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(1)) << 8;
> > +
> > +	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
>=20
> This one is just for the case where there is an unapplied configuration
> in the registers, right?

No, this is me realising that I had a misconception about how that
register works. You write the bit once, and it enables the mode for
channels that have been configured that way at synthesis-time, rather
than how I somehow thought it worked which was as a "flush" from the
shadow registers into the "real" ones.

>=20
> > +	mchp_core_pwm->update_timestamp =3D ktime_get();
> > +
> > +	return devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
>=20
> An error message if devm_pwmchip_add() fails would be nice.

Sure, can do!

Thanks,
Conor.

--vC/iEQs36o7KPCrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBuGBAAKCRB4tDGHoIJi
0lQEAQCuDds9BF1YtJl7C7phnqB7yEQE6A0sv0dp441JRtgO7gEA8kAGdVEQ706u
UldTBcE0gdP6obq+YYDpU0H6kE8OVgA=
=2xlc
-----END PGP SIGNATURE-----

--vC/iEQs36o7KPCrh--
