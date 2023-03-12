Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF436B6799
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCLPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCLPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:42:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4A457C8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:42:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbNpx-0004iu-Dx; Sun, 12 Mar 2023 16:42:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbNpv-003eWq-3a; Sun, 12 Mar 2023 16:42:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbNpu-004Jch-3M; Sun, 12 Mar 2023 16:42:14 +0100
Date:   Sun, 12 Mar 2023 16:42:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Message-ID: <20230312154210.ovm54x2qtcv7fp7r@pengutronix.de>
References: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzhk73rozkcsmxbj"
Content-Disposition: inline
In-Reply-To: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
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


--dzhk73rozkcsmxbj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 12, 2023 at 02:51:19PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
>   drivers/pwm/pwm-rcar.c:252:34: error: =E2=80=98rcar_pwm_of_table=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hmm, I wonder what else is required here to trigger that warning. On
amd64 I also disabled CONFIG_MODULES as otherwise rcar_pwm_of_table is
used by

	MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);

With that I have:

	uwe@taurus:~/work/kbuild/amd64$ make drivers/pwm/pwm-rcar.o=20
	  GEN     Makefile
	  CALL    /home/uwe/gsrc/linux/scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  CC      drivers/pwm/pwm-rcar.o
	uwe@taurus:~/work/kbuild/amd64$ make drivers/pwm/pwm-rcar.i
	  GEN     Makefile
	  CALL    /home/uwe/gsrc/linux/scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  CPP     drivers/pwm/pwm-rcar.i
	uwe@taurus:~/work/kbuild/amd64$ grep rcar_pwm_of_table drivers/pwm/pwm-rca=
r.i
	static const struct of_device_id rcar_pwm_of_table[] =3D {

=2E.. some time later ...

ah, you also need W=3D1 to get that warning because of

	# These warnings generated too much noise in a regular build.
	# Use make W=3D1 to enable them (see scripts/Makefile.extrawarn)
	KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
	KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)

in the toplevel Makefile.

I guess that explains why there is no previous report by one of the
build bots about this issue.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dzhk73rozkcsmxbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQN8s4ACgkQwfwUeK3K
7AmBVgf7BWzGBbyB5eY9U2UaqiiAl/c9xENIkpkw2tYuoglHWE09cMrY/hlqK09q
vcHFteBiC+YSGAU7zSFi32vQlMtsKfryHrjIviXMzpBIFoILcElV2F+YsLz9hjj7
eq1q3DWTzmpQRGSi931BW1CnCTuVg63WwxEUPXyN25CijA/jnsiiiZUIMmxqcCso
KAai0pDUEn+K2KCxU3Tl89cghJu3Ov7J5teDsbqwlmkpywi3Uc7EblFTnjI5Cb6x
6GHENVTVp2R6Tignc+6O8V8ne1DEdBkMmZp19Cf+g1bdWNWBjvYOFmcaJdYHqPTX
bfpswuOSYEJEHycPG8AcCJls5KbKpg==
=7TYH
-----END PGP SIGNATURE-----

--dzhk73rozkcsmxbj--
