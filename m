Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2797F6C45A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCVJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCVJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:07:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DC35DED0;
        Wed, 22 Mar 2023 02:06:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j11so22393413lfg.13;
        Wed, 22 Mar 2023 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpWtvat+StkevPGW04xskQmSfJfNqkv5jWGii5E8uF0=;
        b=YfSl6X/7MTipHzbnUsuKvYUBl0H04OevP2JE87g4LqCGpZa4wNQxyxAvNzqN6IWl3T
         fQ7xhiFM7rspuV/sm08o83nn8UCv4kP8SybTGri1Tg/VPpH/kV0aGEVvhEGTFkiyoFaA
         fU+Y4SQ6IqWL+r73n0kietkjxtcRtXl4g4VLHkk/ugovfzvfh3mb8Mp5GS8br/Yqrx3p
         VHI/X/soDd7KnEGX4TSq5MYH4vrBgXCY+a7+59zIzW1R2+jtAbFARYdLbxuYRCaYL7Up
         MoNfIxt84K3m9psgpt5I8/IlkunEtep0XKWU/VJRS1i/T7Wbq2EK+CzcvdZhbJMT5lXI
         YHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpWtvat+StkevPGW04xskQmSfJfNqkv5jWGii5E8uF0=;
        b=OkWKgM7pCokh1dtlO+CKlhldn5Ew7N4ji+QjVxvKAjJCIQ26g0gErka9ZUz3ZS/Jx2
         Yuhufdo9h1a9l/jD/PH9UjbkQ0DdBY3llWt0cS3iA5n+LcbLQncyMd/Lwqrbp11qF68X
         svzn5xPY0uQj1ZLOwwSQFR4iRnpBX/zH3wSaIMGH6GhO3BAOf82GYA9g5Eo26nBjlCyi
         yRXDZ9Mzwpo/TuWakZLkn58mmJppLLWyq5vuhlTXljbQpQpMJfG0+DmPmNr8v8pdvLXH
         E1QDNDiYdSm+rg2P6Z0AuYN1LwmO6HTQroSayWwzE/SxtccKQ1Nha9t4HVllKCLEnR/H
         awIw==
X-Gm-Message-State: AO0yUKUzQC+fLgjY5ZeUi5hwdXKngWzn2afQQ54nLivryyRg/3I9A+nA
        RmhvY1brT4s3rCeNPEfhl3I=
X-Google-Smtp-Source: AK7set88h3N0lgvPjjQ+WgtggFRrM5WBWQsWiVJatIohyOMMXuTuQNor1i2IAM2PWJScHdb0CMB9lg==
X-Received: by 2002:ac2:4311:0:b0:4ea:5902:5af1 with SMTP id l17-20020ac24311000000b004ea59025af1mr2052906lfh.52.1679476005886;
        Wed, 22 Mar 2023 02:06:45 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25688000000b004d863fa8681sm2508837lfr.173.2023.03.22.02.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:06:45 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:06:41 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <bdd9777201a0020d2323eb1c1d227bec4c42c288.1679474247.git.mazziesaccount@gmail.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ToGBjmqm3dH+Kd5t"
Content-Disposition: inline
In-Reply-To: <cover.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ToGBjmqm3dH+Kd5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
capable of detecting a very wide range of illuminance. Typical application
is adjusting LCD and backlight power of TVs and mobile phones.

Add dt-bindings.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v2 =3D>
- No changes

Changes since RFCv1 =3D> v2
- Fix binding file name and id by using comma instead of a hyphen to
  separate the vendor and part names.
---
 .../bindings/iio/light/rohm,bu27034.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
new file mode 100644
index 000000000000..30a109a1bf3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27034 ambient light sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diod=
es
+  capable of detecting a very wide range of illuminance. Typical applicati=
on
+  is adjusting LCD and backlight power of TVs and mobile phones.
+  https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bu=
27034nuc-e.pdf
+
+properties:
+  compatible:
+    const: rohm,bu27034
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      light-sensor@38 {
+        compatible =3D "rohm,bu27034";
+        reg =3D <0x38>;
+        vdd-supply =3D <&vdd>;
+      };
+    };
+
+...
--=20
2.39.2


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

--ToGBjmqm3dH+Kd5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQaxSEACgkQeFA3/03a
ocWVRAf+OCAVMObrWWFqMqABE8bc1VJKH5QUklI3LqQUgBRaNZdW96PIjfRlfByW
zHxZaeU/zSHvvLJ+afXxxZK3wv4LjKPuTmNpfglB3UrF13D5IN3DOCEIxO72PRw7
3qFJgnYhc3UkAivXVZKjqDM7ipb5LWK46AFtUQmRCktpLGt8xrv7xd6/y+OfvkaG
9c46rlanFsdAJS6KwKXnAQgAHirNopykjgCk1nRYGPeiEf5f0120MkseZaILEs0N
vqivJrXHmYjm+voo6bcvs074qObQEA+T0FayDOB3t8aeTqwhvlfSwmJMmCF2L4tC
2BKTkUOV+MnlrijP5kcWHCSxOUejNA==
=NQtp
-----END PGP SIGNATURE-----

--ToGBjmqm3dH+Kd5t--
