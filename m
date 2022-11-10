Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA7624620
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKJPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKJPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:39:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437AE2AE12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:39:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9ej-0004YY-5L; Thu, 10 Nov 2022 16:39:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9eh-003TqO-3L; Thu, 10 Nov 2022 16:39:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot9eh-00FfwP-Cs; Thu, 10 Nov 2022 16:39:51 +0100
Date:   Thu, 10 Nov 2022 16:39:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v6 07/10] pwm: dwc: make timer clock configurable
Message-ID: <20221110153951.vcxatcfk5pl2vyz5@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-8-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6c6hcjkhlfswnpj"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-8-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r6c6hcjkhlfswnpj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 20, 2022 at 04:16:07PM +0100, Ben Dooks wrote:
> Add a configurable clock base rate for the pwm as when being built
> for non-PCI the block may be sourced from an internal clock.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v6:
>  - removed DWC_CLK_PERIOD_NS as it is now not needed
> v4:
>  - moved earlier before the of changes to make the of changes one patch
> v2:
>   - removed the ifdef and merged the other clock patch in here
> ---
>  drivers/pwm/pwm-dwc-pci.c |  1 +
>  drivers/pwm/pwm-dwc.c     | 10 ++++++----
>  drivers/pwm/pwm-dwc.h     |  3 ++-
>  3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
> index 2213d0e7f3c8..949423e368f9 100644
> --- a/drivers/pwm/pwm-dwc-pci.c
> +++ b/drivers/pwm/pwm-dwc-pci.c
> @@ -20,6 +20,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/clk.h>
> =20
>  #include "pwm-dwc.h"
> =20

I assume this is only needed because pwm-dwc.h now uses struct clk.
Maybe just add

	struct clk;

to the pwm-dwc.h instead of this hunk?

> [...]
> diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
> index 68f98eb76152..dc451cb2eff5 100644
> --- a/drivers/pwm/pwm-dwc.h
> +++ b/drivers/pwm/pwm-dwc.h
> @@ -22,7 +22,6 @@
>  #define DWC_TIMERS_COMP_VERSION	0xac
> =20
>  #define DWC_TIMERS_TOTAL	8
> -#define DWC_CLK_PERIOD_NS	10
> =20
>  /* Timer Control Register */
>  #define DWC_TIM_CTRL_EN		BIT(0)
> @@ -41,6 +40,8 @@ struct dwc_pwm_ctx {
>  struct dwc_pwm {
>  	struct pwm_chip chip;
>  	void __iomem *base;
> +	struct clk *clk;

This is unsed, please add it in the patch that makes use of it.

> +	unsigned int clk_ns;
>  	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>  };
>  #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r6c6hcjkhlfswnpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtG0QACgkQwfwUeK3K
7AnSUQf9Hbf2+S7Vrf9NVbC3OqCWgomiwgcDc7O86nD6efoK7pnup5JbRmIpKdT5
VDbMjK57nsfn+p0zsn5MVu7X6MW1QKi5dU5aEYNVaTpnJT8lFiB/RGrQgaD11TPS
FZy/Hqgk13fAbeYYTy8q+vR5NRzRgFMmZ2W+qVbhY5Dc+jg+m7NolWGgoy9buWMq
ZOsiIo8VV+PkN3+EzjRfm0hhUFwZTBH7UKFrSs36pFReWmeHfM4eqZtsgA/eUDph
pt2H8Yd34PybIJJX+qRKan6g4XxZlSWd2xNwYFwUQ2eUBwMVWXlED1nZCjWgXR0R
zlNDdW3AU0puY7JVpPt7Gk8MqvvZKg==
=2U+q
-----END PGP SIGNATURE-----

--r6c6hcjkhlfswnpj--
