Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB576F1164
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbjD1Fof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345054AbjD1Foc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:44:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC81FFD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:44:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso9929111e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682660669; x=1685252669;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdFOkuyeOsCZP4PB+45YQAigeUh2LG5bvPMZJ0Xjgy0=;
        b=DghPtID5qL4NQeCzJZVnN0MpDYNBJyQwV+8N/bJ48sJw3Aam+YJOh887TpZ46ljz3d
         d8LomQ86PkjxuyIFtUpT9toZ9tM2+OgARtygoL+U6FXeiVXim/wz1NoWSMLp2lEPMizx
         7DBykvruNU3+LCphiviwo/15yAtYnJjaHGfq31GYqxX96l2zHUCV4cm0jlc0g1HfnJZT
         zxMwaBSKvOiuPX6n4JOv45rDZ+unQaBOh/ehCphytysM3OVp8iW4O6zmfUUrcan6zFQE
         TVCWAGWzaB3F9eTJfk5wkx8kQrA39MrJyiH/WJy75N8GsBwCH5Ksipq/7g2qu1fg0v2T
         c41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682660669; x=1685252669;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdFOkuyeOsCZP4PB+45YQAigeUh2LG5bvPMZJ0Xjgy0=;
        b=beEVu+zfKnMC0jWOPh+G3Oo+pOxCwLEaNljJOAS0KTCADmn2ia4YDr+EaSw2d24rlg
         arR/hQyUzuVJvIoAIj3VpYi01SUiPKWDfZA9W+83+oM6OOECk2CrXwVE+bZ6iY+LCipC
         qBnfz4FdPo3JlOQYulJdrg8YGQKXh1veAwAXQFyZcXQXDrDXCXjzcyENK+o+6fQ+90yx
         bPpuAURtI9GUzVpaFEgUqKzUFQIoWuKv5IrDbySe58DalAtqKE/hPn+AxvI9K4V3vW3h
         DhhzD0lsDxv4izqq3z5bg04JhNy3r6nSyW7Gq4Y/u9mrnTcBnG1dRcRNdxKqn94No4Vh
         YFyg==
X-Gm-Message-State: AC+VfDxi8cmF3p1Q38j62g36G94DAtgmb3dRz9wfXp8SmBcpUvyD4Kiv
        NzF48zqlERt/VEnxu0zpKFk=
X-Google-Smtp-Source: ACHHUZ4pFzx5eIOXqbbRxLDupUN9cm+egjQqMUWPw6BITp7K0odvMTK+xyZyD9t2aB/pAS0gim4gwQ==
X-Received: by 2002:a19:7005:0:b0:4ed:d2be:37e5 with SMTP id h5-20020a197005000000b004edd2be37e5mr1135259lfc.7.1682660669191;
        Thu, 27 Apr 2023 22:44:29 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm3200930lfq.155.2023.04.27.22.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 22:44:28 -0700 (PDT)
Date:   Fri, 28 Apr 2023 08:44:06 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] regmap: force update_bits() to write to HW when reg is
 volatile
Message-ID: <ZEtdJtlbmDCvZuAc@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9KXBuhG5gqSbtwfE"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9KXBuhG5gqSbtwfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In many cases the volatile registers are expected to be written to
regardless of the existing value (because, the value of a volatile
register can't be trusted to stay the same during RMW cycle). In fact, it
is questionable if the volatile registers and regmap_update_bits()
conceptually make sense without device specific map->reg_update_bits.

Yet, there are devices where some register contains a 'fixed part' and a
'volatile part'. For example the ROHM BU27008 RGBC sensor has a register
with part-ID (fixed) and a reset bit which, should be written to no matter
what the cached value is - and which is cleared by hardware. In such case
using regmap_update_bits() with this register marked volatile kind of
makes sense. Doing a RMW-cycle is Ok as the static part of the register
can be read. The other option is to hard-code the static part in driver.
This can hit to problems though. For example the fixed part-ID may
actually change, should the driver ever support a variant with different
part ID.

In such case the read + modify could be done by caller, and caller could
then use regmap_write() directly.

However, there may be some similar use-cases already in-tree - potentially
not even noticing that the write might never get in HW when using
regmap_update_bits() with volatile registers if the force_write was not
used here. Thus, set the force_write here even though it may cause some
performance penalty. Still, it's probably easier to optimize the sepcial
cases with performance critical volatile registers than spot all the
errors caused by writes to volatile registers not reaching the HW (once in
a blue moon when tmp =3D=3D orig).

Force writes to hardware when regmap_update_bits() is used with volatile
registers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

This change is inspired by the fact that I've now done the same mistake
_many_ times. I've defined a special register (usually a register with a
reset bit, but there were some clear-on-write registers as well) as
volatile to guarantee that writes are always going to hardware
regardless the existing register value. (To either always trigger the
operation like a reset in the hardware, or by knowing that the value
that has been previously written may be changed by the hardware). Later
I've happily used regmap_update_bits() to change the specific bit (to
clear specific bit or to trigger specific operation) forgetting the fact
that the regmap_update_bits() do not force write to hardware.
Unfortunately, these bugs can be hard to spot as it may be that it is a
rare case where read value is same than the value being written making
issues to occur only once in a blue moon. I am afraid I am not the only
one making this mistake, although I may be the only one who seems to be
unable to learn this :/

This patch intends to 'fix' this by making the volatile regs to be
always written to - even when regmap_update_bits() is used. I am not
100% sure this is "the right thing to do". (I obviously think it might
be, else I wouldn't be sending this patch). Maybe we should just
warn_once() when volatile registers are accessed using
regmap_update_bits() instead? Or perhaps some perl wizard could cook-up
a checkpatch improvement which could check this when checkpatch is ran?

In any case, it'd be great to have some way of help avoiding these
bugs...

This patch has received only very minimal testing and all further
testing would be appreciated!

---
 drivers/base/regmap/regmap.c | 72 ++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d2a54eb0efd9..dd2f71b576b7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -3234,25 +3234,65 @@ static int _regmap_update_bits(struct regmap *map, =
unsigned int reg,
 	if (change)
 		*change =3D false;
=20
-	if (regmap_volatile(map, reg) && map->reg_update_bits) {
-		reg +=3D map->reg_base;
-		reg >>=3D map->format.reg_downshift;
-		ret =3D map->reg_update_bits(map->bus_context, reg, mask, val);
-		if (ret =3D=3D 0 && change)
-			*change =3D true;
-	} else {
-		ret =3D _regmap_read(map, reg, &orig);
-		if (ret !=3D 0)
-			return ret;
-
-		tmp =3D orig & ~mask;
-		tmp |=3D val & mask;
-
-		if (force_write || (tmp !=3D orig)) {
-			ret =3D _regmap_write(map, reg, tmp);
+	if (regmap_volatile(map, reg)) {
+		if (map->reg_update_bits) {
+			reg +=3D map->reg_base;
+			reg >>=3D map->format.reg_downshift;
+			ret =3D map->reg_update_bits(map->bus_context, reg, mask, val);
 			if (ret =3D=3D 0 && change)
 				*change =3D true;
+
+			return ret;
 		}
+		/*
+		 * In many cases the volatile registers are expected to be
+		 * written to regardless of the existing value (because, the
+		 * value of a volatile register can't be trusted to stay the
+		 * same during RMW cycle). In fact, it is questionable if the
+		 * volatile registers and regmap_update_bits() conceptually
+		 * make sense without device specific map->reg_update_bits.
+		 *
+		 * Yet, there are devices where some register contains a
+		 * 'fixed part' and a 'volatile part'. For example the ROHM
+		 * BU27008 RGBC sensor has a register with part-ID (fixed) and
+		 * a reset bit which, should be written to no matter what the
+		 * cached value is - and which is cleared by hardware. In such
+		 * case using regmap_update_bits() with this register marked
+		 * volatile kind of makes sense. Doing a RMW-cycle is Ok as the
+		 * static part of the register can be read. The other option
+		 * is to hard-code the static part in driver. This can hit
+		 * to problems though. For example the fixed part-ID may
+		 * actually change, should the driver ever support a variant
+		 * with different part ID.
+		 *
+		 * In such case the read + modify could be done by caller, and
+		 * caller could then use regmap_write() directly.
+		 *
+		 * However, there may be some similar use-cases already in-tree
+		 * - potentially not even noticing that the write might never
+		 * get in HW when using regmap_update_bits() with volatile
+		 * registers if the force_write was not used here. Thus, set
+		 * the force_write here even though it may cause some
+		 * performance penalty. Still, it's probably easier to optimize
+		 * the sepcial cases with performance critical volatile
+		 * registers than spot all the errors caused by writes to
+		 * volatile registers not reaching the HW (once in a blue moon
+		 * when tmp =3D=3D orig).
+		 */
+		force_write =3D true;
+	}
+
+	ret =3D _regmap_read(map, reg, &orig);
+	if (ret !=3D 0)
+		return ret;
+
+	tmp =3D orig & ~mask;
+	tmp |=3D val & mask;
+
+	if (force_write || (tmp !=3D orig)) {
+		ret =3D _regmap_write(map, reg, tmp);
+		if (ret =3D=3D 0 && change)
+			*change =3D true;
 	}
=20
 	return ret;

base-commit: eeac8ede17557680855031c6f305ece2378af326
--=20
2.40.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--9KXBuhG5gqSbtwfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRLXRoACgkQeFA3/03a
ocUfAgf+NYeJhYXYq3JtfxRmV6ljIemQqqbs/8B8ajiJggq1XFpQH8STc5uDelj2
LUk1WNhH5WceJv/b/18J0YHwK/5Q+mrKNCsP6K3H0rThG1kZ3DliazhVfzNvOcdO
INupXWA/V+4m7h8vrXME7VctF6lSlTAc/9/Vwi+LIlxpACkXFqoJ3mD+ACG+vjur
qZZrd4L2MYi6yShNVpSTAh1zK8hjvmDMOlybtOoIT34yRkUktzTmHqzmFfVKRK2k
FPtpsNXV8LAA+GfYMWWAfAnKszKxleHEqZenfzwWMFHRzMP9a+jY4aTL7kshTeCC
fh/JSn8s4dDoNI/FWqmOZiwgw8d2Xw==
=l6V5
-----END PGP SIGNATURE-----

--9KXBuhG5gqSbtwfE--
