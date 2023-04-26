Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB36EEFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbjDZIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:07:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03AB1993;
        Wed, 26 Apr 2023 01:07:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8dd1489b0so65082921fa.3;
        Wed, 26 Apr 2023 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496452; x=1685088452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yssv3P2DrAoOPk41LdEXWeC4Pr2ddQEWhBOO6bbwtPs=;
        b=H9KGVGDTsUVvOvmemzmLJL+6TTOPnYBNs0J8c2vD4we64VDLrlFF4Zmf9Bun6Mo32b
         J1/PcqdfxYyOXKhnzO2Tp//kuYiT+XA28MPs72tJEiXfg2YAtpBo6unF3jL3ikgQw9rB
         JwpwWtEZj85tuLKObuTDZ8m8INadztLYM7sUwkgCYEZJaXCs0ONji25LH/9bq+M9Y7h6
         8AgjIJ2IlOpZ+3bel/ej4vUwpxqo8X5bbEIZcSvBhcSnQsbXPI+CiriuuVrdrdZAsNXZ
         WVE7k0I/Ff2dmNA5+AxRYjIY+6NJO3mBtfffnCsc8GFMg03l4o+ob+SXjvb0wyBhX4pZ
         b9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496452; x=1685088452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yssv3P2DrAoOPk41LdEXWeC4Pr2ddQEWhBOO6bbwtPs=;
        b=k6UDNon64ZS121iL3cj7Aek/3Xt3GMrVG6c2u0PY4Yc4ZpcbeC2kH76M0+s5k74LnE
         yMfJZn/4T8G4kDfwwA5VgmLlWvoWwaOy5GCDqCJmZ5PO2iJO4wqqJNVkQW1jgIDZWcA2
         LMLL7XulSskRS3JelXpJDq+6uL+JuPEkqDvl6AQUX4phq4mZ9KiPcChyaLg0FzWlwj8d
         tTAq7MazCnmyZPziFRZxmHXhNmF1IyhmgR0oUkfYmzXIkGnxSdWyYdOuVaMxjLIBiVpC
         fqWfxbC3CJ/hFJlgUsPyESQSQyQfiCvm9yX0ToJo4fyPZLeDJYjRY3CaRgoc+QJYEsKg
         fq0g==
X-Gm-Message-State: AAQBX9dm44/UNe+jfxuDxbnUPyqrRlljN3SFVUZQ4ot793YrdWnSF8QL
        2/NX6wbaUYDfo3ntrm66rRU=
X-Google-Smtp-Source: AKy350Y36NzrqqY6T008oWsFu+U7lCHlNArWcmmJKgUhDMAHf1pN8jKL3/r7E1QK7GGAsG8/38CHdQ==
X-Received: by 2002:a2e:8210:0:b0:2a6:1681:81e0 with SMTP id w16-20020a2e8210000000b002a6168181e0mr4097295ljg.2.1682496451680;
        Wed, 26 Apr 2023 01:07:31 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id t23-20020a2e9d17000000b002aa43e06a65sm1913713lji.16.2023.04.26.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:07:31 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:07:27 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: iio: light: ROHM BU27008
Message-ID: <16be2f3bbf44506e6e6754ad900ef8c289f07bc7.1682495921.git.mazziesaccount@gmail.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KKJS4C9luDmR691h"
Content-Disposition: inline
In-Reply-To: <cover.1682495921.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KKJS4C9luDmR691h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
and IR) with four configurable channels. Red and green being always
available and two out of the rest three (blue, clear, IR) can be
selected to be simultaneously measured. Typical application is adjusting
LCD backlight of TVs, mobile phones and tablet PCs.

Add BU27008 dt-bindings.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
Revision history:
v2 =3D> No changes

v1 =3D> v2:
- fix binding file name
- fix binding id
- drop unnecessary '|' from description
---
 .../bindings/iio/light/rohm,bu27008.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
new file mode 100644
index 000000000000..4f66fd47b016
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27008.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27008 color sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
+  and IR) with four configurable channels. Red and green being always
+  available and two out of the rest three (blue, clear, IR) can be
+  selected to be simultaneously measured. Typical application is adjusting
+  LCD backlight of TVs, mobile phones and tablet PCs.
+
+properties:
+  compatible:
+    const: rohm,bu27008
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+        compatible =3D "rohm,bu27008";
+        reg =3D <0x38>;
+      };
+    };
+
+...
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

--KKJS4C9luDmR691h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRI278ACgkQeFA3/03a
ocUkQwf9HasJWud08mznI14w7zhqtumhv0wq1JH1GyaXm7vxwmyzPT34enI+Jtzn
WhBb1DOYe/JTldnLN8awyutz74ThagzPbeeI/g4fu0PpDITLYWYC5gB3NyHepsL0
Jsd6oMy5ehIxpxapfxodY0bdLsdxsjuAOxFRb91Mid1/Xc6+v50OFU+1bCSOXo40
kDXn1uWn82VbfN9wss1Bcb3gYrtkHLg8aflxQbTvaZ4RE5b9Ybwmx8Sebr+TJiV+
QrMz/xqh4vMhtA2zt//ROKD0iJ1BtEwxzNoIZ1lMmFyMNiTsLX42ipuFMnSJS+nd
tzcR14P/uv8z8u3onchl6x9VpFa7jw==
=sh7A
-----END PGP SIGNATURE-----

--KKJS4C9luDmR691h--
