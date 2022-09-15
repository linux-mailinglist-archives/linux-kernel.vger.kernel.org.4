Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607F35B9531
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIOHYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIOHYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:24:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA3AD4C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:24:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYjEh-0003lM-8q; Thu, 15 Sep 2022 09:24:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYjEh-000qeX-Ud; Thu, 15 Sep 2022 09:24:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYjEf-00128o-Sw; Thu, 15 Sep 2022 09:24:33 +0200
Date:   Thu, 15 Sep 2022 09:24:30 +0200
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
Subject: Re: [RFC v4 08/10] pwm: dwc: add of/platform support
Message-ID: <20220915072430.bhpwk6iyqmyz6oie@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-9-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7io5skmzn7fvbmsl"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-9-ben.dooks@sifive.com>
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


--7io5skmzn7fvbmsl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 16, 2022 at 10:14:52PM +0100, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v4:
>  - split the of code out of the core
>  - moved the compile test code earlier
>  - fixed review comments
>   - used NS_PER_SEC
>   - use devm_clk_get_enabled
> v3:
>  - changed compatible name
> ---
>  drivers/pwm/Kconfig      |  9 +++++
>  drivers/pwm/Makefile     |  1 +
>  drivers/pwm/pwm-dwc-of.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 drivers/pwm/pwm-dwc-of.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a9f1c554db2b..f1735653365f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -192,6 +192,15 @@ config PWM_DWC_PCI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-dwc-pci.
> =20
> +config PWM_DWC_OF
> +	tristate "DesignWare PWM Controller (OF bus)

There is a missing " which results in:

	drivers/pwm/Kconfig:196:warning: multi-line strings not supported

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7io5skmzn7fvbmsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMi0ywACgkQwfwUeK3K
7Amt2Qf/UgDMTUQkV2JPLj6sSbtjBfGpE4BRk4aFmN/Sstpx2l5KBA4ZR90CFXTF
aK1cvyWxkX+lKS1J+SJGvClDbepo9UKlfQOJFKnE0fU8d1eBW7aDTXyP4RYChgSz
b6AN2/GpxdexrNRRbc+AIX7dKKO8EQxqViRAoMet6fGz9kdNyn/S5DOfi6daiPxV
UJv4Udb0mq5z5X9N9O1Ijvj+wUxiV05OLooj+hR4roAVW4mKfVgy50bdF+8V13aN
LkcN3ohPzlEWHWT8ytbRZu+Mkyu38vAQHg+zZauA1qMXRXkohaPv6BDcMSR0LqSL
faOPXyRq9AVP9QI92VWPteeApW4qBA==
=eMUG
-----END PGP SIGNATURE-----

--7io5skmzn7fvbmsl--
