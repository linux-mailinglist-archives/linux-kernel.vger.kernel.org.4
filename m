Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE1B706504
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjEQKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:20:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2322A35A8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:20:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzEGm-0001Nd-Hf; Wed, 17 May 2023 12:20:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzEGl-000opd-MS; Wed, 17 May 2023 12:20:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzEGk-005JDj-UP; Wed, 17 May 2023 12:20:30 +0200
Date:   Wed, 17 May 2023 12:20:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v17 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230517102030.b4nyo2dmpfl7v7fk@pengutronix.de>
References: <20230421-neurology-trapezoid-b4fa29923a23@wendy>
 <20230421-sleek-bottom-88b867f56609@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qa5qm3wv35pmobau"
Content-Disposition: inline
In-Reply-To: <20230421-sleek-bottom-88b867f56609@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qa5qm3wv35pmobau
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

I found one remaining issue:

On Fri, Apr 21, 2023 at 10:27:09AM +0100, Conor Dooley wrote:
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

If prescale > 4 this overflows on 32bit archs, doesn't it?
(I think prescale + 1 is promoted to unsigned int, then the
multiplication is done and only then the range is extended to u64.

> +	duty_steps =3D mul_u64_u64_div_u64(state->duty_cycle, clk_rate, tmp);
> +
> +	return duty_steps;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qa5qm3wv35pmobau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRkqm4ACgkQj4D7WH0S
/k6E4Af9GpPg42BTohU1ij/TFyI2WSTeDS3OHXIV92tExb/HLhS7FSfKT6abkvKE
ypK/1B9fnczOdqCjkkU1EetSh+RpLL7D9iQTmpbVKiH6RNP4yzpluiURsYPs/FkX
l13ixd0Twqfdm/YJC+I9bMxZMkSH/nQfz211qQXxdFDQ7gluRdNllcz0FZzx9goT
naOJE1VjjAqzXEpcuSojE7ghI/ZG8zQihqmYgSRQV88rQoqupN7u69vvAKS/ji9g
StJ3wFnLC3l5flUPz1ye32ZtXO/l7f7dewi+IpkDpcM54EY765Jiu4Mw53MTGUWm
1b8HNXWdrt2LqRG9/l/0pUd6nJAJkQ==
=4RDi
-----END PGP SIGNATURE-----

--qa5qm3wv35pmobau--
