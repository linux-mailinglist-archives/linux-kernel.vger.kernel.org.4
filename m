Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1063EA0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLAG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLAG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:58:15 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014CC4B9A6;
        Wed, 30 Nov 2022 22:58:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so1137580lfk.0;
        Wed, 30 Nov 2022 22:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHk4ubp9Ca3KujkAW0PO2oU0zwiL+OQVBVrVMDS+Mno=;
        b=OZH8XOvhleFajWJqbCwM2m8XZEAsCFhIkykNg3JiaCM+PNgFxQ5QRNmX2twuE5aDNX
         G7tFa8SoGtoTXeJx4oRx4OlKjbUtOBX7pzAcIhEqdzBjcOU3F63Rfkicd2Q2p0gIzodQ
         o+NVwpxLnQWEyYOBpiFH5YESk4+2Zp+SUjZsCIFWDkS0ImhxNDuAiqMbLhZIUrmO3Fyj
         LiHE3GbzQbrfOB39LBiyh0jgf0lN2jHtBtUW9r1exbC5U8Q/AwmD9kYUaRETf0z1Zzsg
         K5MxFPFaR1OLl8I8I1DazxqwG/4cM6NvL9ngTX3KDCZDNF2n7J3mvmDDRrpXB3LYSA3R
         8S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHk4ubp9Ca3KujkAW0PO2oU0zwiL+OQVBVrVMDS+Mno=;
        b=ijFaSV2fQulf2SZXSKpYq/SV1gO3WXfNqjo6Uyso6waQ0TPNCfhdf8yFUdk6ZGIxQU
         GkgFYrS4CeNQqhwoTphU/WoNaVhYKsHJ3HrOHK0BWcl9o8pmyTkGspJ5ienDRZ75VBJ7
         gGyTkDXcvVP9UITUGYRkxxVqIF6vs+GoF9FFJkc0J9+t0S1OkJOgUMybitE5/k2Cat0f
         jjP5F6w2KXXiG6eg0r5fcOk/wJghWFWUnsYxEbRBKaMS5cdjJfSGfEJRKj8IlXcY1YjM
         tMIL5YJCSuAN0tC+b3jNGe6EFdXAd+N0Pk18HaUFRPrY4WRcfa4UqXMffL+kNLJyn6kB
         QpVQ==
X-Gm-Message-State: ANoB5plr04DcwKDlw1LqRBhfIhvw7OZPRekT0z0ya2y0ydV+KtqY5q5g
        72BOjJbH5C62DfwyLWn6Jj8=
X-Google-Smtp-Source: AA0mqf7rZYRuKDlBpo9tnOcKFzExqESQgx/4FnXkIR4qz+SE0pcKPX0QOsr7z8F3HMwBfWDbqRVHvA==
X-Received: by 2002:a19:6a0c:0:b0:4b4:c67:1e8a with SMTP id u12-20020a196a0c000000b004b40c671e8amr20702475lfu.126.1669877892125;
        Wed, 30 Nov 2022 22:58:12 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id m20-20020a056512359400b00492d064e8f8sm541094lfr.263.2022.11.30.22.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 22:58:11 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:57:52 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix maintainer email for a few ROHM ICs
Message-ID: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2josFjUH3kiM3YoD"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2josFjUH3kiM3YoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The email backend used by ROHM keeps labeling patches as spam. This can
result to missing the patches.

Switch my mail address from a company mail to a personal one.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I did this a while ago for my email addresses at the MAINTAINERS. Forgot
the dt-bindings and doing the conversion for bindings now.
---
 Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml   | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml     | 2 +-
 .../devicetree/bindings/power/supply/rohm,bd99954.yaml          | 2 +-
 .../devicetree/bindings/regulator/rohm,bd71815-regulator.yaml   | 2 +-
 .../devicetree/bindings/regulator/rohm,bd71828-regulator.yaml   | 2 +-
 .../devicetree/bindings/regulator/rohm,bd71837-regulator.yaml   | 2 +-
 .../devicetree/bindings/regulator/rohm,bd71847-regulator.yaml   | 2 +-
 .../devicetree/bindings/regulator/rohm,bd9576-regulator.yaml    | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml =
b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
index 86a37c92b834..d48c404c848e 100644
--- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71828 Power Management Integrated Circuit LED driver
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   This module is part of the ROHM BD71828 MFD device. For more details
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
index fbface720678..7cda8adc178e 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71815 Power Management Integrated Circuit bindings
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   BD71815AGW is a single-chip power management ICs for battery-powered
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 8380166d176c..c13730aa34d9 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71828 Power Management Integrated Circuit bindings
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   BD71828GW is a single-chip power management IC for battery-powered porta=
ble
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
index 3bfdd33702ad..3ab8dcf0e8f1 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71837 Power Management Integrated Circuit bindings
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   BD71837MWV is programmable Power Management ICs for powering single-core,
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index 5d531051a153..8ed4390bb43f 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71847 and BD71850 Power Management Integrated Circuit bindin=
gs
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   BD71847AMWV and BD71850MWV are programmable Power Management ICs for pow=
ering
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml b/=
Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
index 6483860da955..e1ebea9ad5da 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD9576MUF and BD9573MUF Power Management Integrated Circuit bi=
ndings
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   BD9576MUF and BD9573MUF are power management ICs primarily intended for
diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.ya=
ml b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
index 24b06957b4ca..6a0756e33eb8 100644
--- a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD99954 Battery charger
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
   - Markus Laine <markus.laine@fi.rohmeurope.com>
   - Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
=20
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regula=
tor.yaml
index d61e8675f067..027fab3dc181 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.ya=
ml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.ya=
ml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71815 Power Management Integrated Circuit regulators
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   This module is part of the ROHM BD718215 MFD device. For more details
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regula=
tor.yaml
index 5ce587fff961..3cbe3b76ccee 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.ya=
ml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.ya=
ml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71828 Power Management Integrated Circuit regulators
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   This module is part of the ROHM BD71828 MFD device. For more details
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regula=
tor.yaml
index 1941b36cf1ef..ab842817d847 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.ya=
ml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.ya=
ml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71837 Power Management Integrated Circuit regulators
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   List of regulators provided by this controller. BD71837 regulators node
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regula=
tor.yaml
index a1b806373853..65fc3d15f693 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.ya=
ml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.ya=
ml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD71847 and BD71850 Power Management Integrated Circuit regula=
tors
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   List of regulators provided by this controller. BD71847 regulators node
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regula=
tor.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulato=
r.yaml
index 7cb74cc8c5d9..1e41168a4980 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ROHM BD9576 and BD9573 Power Management Integrated Circuit regulato=
rs
=20
 maintainers:
-  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
   This module is part of the ROHM BD9576 MFD device. For more details

base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
--=20
2.38.1


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

--2josFjUH3kiM3YoD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmOIUGIACgkQeFA3/03a
ocWX1ggAn7iYEYQUsB1aEk8w52fSQkaebQqwHDFPNUMQCQpoPJTRVsMG/BXLd3Hu
vXffwrSx26kVHiGM+8lhkZVTSHKDBcVMJp2yhhVr824vHtGmP0wIULlX+v8xmlpM
jL5Nj4U4oj4gBtkOYdr4pdETzUyQVe1Kez97ncqAQ/AhMsCswjCAkIcUwfRgr7pP
nCJWDLdU4skM6xZFFeg0CM1dwWkFiD+4iYzQ/dVZhpNjYXAdV5en/JT1a/wUTPP4
MMdZ9DV/A3tNmrXuwu4J5r8ozpSKISHoj70jIKSqCuCYS6NiIzM8bBkjHp5QEruU
Ndqku6m3Xfo27EUow04N0asO0y2wHQ==
=5EM4
-----END PGP SIGNATURE-----

--2josFjUH3kiM3YoD--
