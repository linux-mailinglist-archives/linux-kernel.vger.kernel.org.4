Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8C715C30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjE3KrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjE3Kqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:46:53 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A25110;
        Tue, 30 May 2023 03:46:51 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8290B1C0D20; Tue, 30 May 2023 12:46:50 +0200 (CEST)
Date:   Tue, 30 May 2023 12:46:49 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        l.sanfilippo@kunbus.com, jarkko@kernel.org
Subject: Wrong/strange TPM patches was Re: [PATCH 6.1 000/119] 6.1.31-rc1
 review
Message-ID: <ZHXUGdFMIcB5HL8s@duo.ucw.cz>
References: <20230528190835.386670951@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r+EjDeRDCk4IF0FL"
Content-Disposition: inline
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r+EjDeRDCk4IF0FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     tpm, tpm_tis: Avoid cache incoherency in test for interrupts

Description on this one is wrong/confused. There's no cache problem in
the code. Plus test_bit and friend already use bit number, so

-       bool itpm =3D priv->flags & TPM_TIS_ITPM_WORKAROUND;
+       bool itpm =3D test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);

@@ -87,6 +87,7 @@ enum tpm_tis_flags {
        TPM_TIS_ITPM_WORKAROUND         =3D BIT(0),
        TPM_TIS_INVALID_STATUS          =3D BIT(1),
        TPM_TIS_DEFAULT_CANCELLATION    =3D BIT(2),
+       TPM_TIS_IRQ_TESTED              =3D BIT(3),
 };

this enum needs to go from BIT() to raw numbers.

You can just do return tpm_pm_resume();

> Jarkko Sakkinen <jarkko@kernel.org>
>     tpm: Prevent hwrng from activating during resume

@@ -429,6 +431,14 @@ int tpm_pm_resume(struct device *dev)
        if (chip =3D=3D NULL)
                return -ENODEV;
=20
+       chip->flags &=3D ~TPM_CHIP_FLAG_SUSPENDED;
+
+       /*
+        * Guarantee that SUSPENDED is written last, so that hwrng does not
+        * activate before the chip has been fully resumed.
+        */
+       wmb();
+
        return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);

This code is confused. First, either you don't need memory barriers
here, or you need real locking. Second, if you want to guarantee flags
are written last, you need to put the barrier before the
assignment. (But ... get rid of that confusion, first).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--r+EjDeRDCk4IF0FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZHXUGQAKCRAw5/Bqldv6
8vR3AJ4nYbfXozM6RjMtZmKWdj4QU5PQEwCfY+5LyyJ/Ps5vEN0Kd3dHPkF55gM=
=wiN5
-----END PGP SIGNATURE-----

--r+EjDeRDCk4IF0FL--
