Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0A6FA784
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjEHKbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjEHKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:31:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BD424A82;
        Mon,  8 May 2023 03:31:01 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac831bb762so41743221fa.3;
        Mon, 08 May 2023 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683541859; x=1686133859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93zNbjTNcKrAok96MTG4gq6AZxzn5Y2OQkYSIPAljnY=;
        b=RpUvQcm1Ym5kIE/Z0PQkqx3+jc7frv3FSAxUv6tCSCM2ugZIZy9A2Hcj38XmfAn6tb
         2Idw4rsXNnNESuTjgMZsQUj1C6E97zBQaNaJVcbwUvJNBlXFmN7UcLp3fE0Da/xSkqGG
         Z/mwhVUPUCy4Il7EFmRP/v1TouGxhv1SJ4veZ24IIgUxRx21GkzoSMBqX2zKey3eT8du
         dBdcsRhmH4w8Mx8xRsfC1VC9MpxV54rgUtf4DhhB85S/dlZs5NeuuBOiO0i4KDCqdzBa
         zFa1v/1SLWuOo10qAMUjQ5h4xAWE7c/BOynzuMshWodbVoa32r8NUvoGx/N77Gq69wQC
         7C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541859; x=1686133859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93zNbjTNcKrAok96MTG4gq6AZxzn5Y2OQkYSIPAljnY=;
        b=V/Q7X/ZZd5bQYWe6a0U25J1wOq1NnTVouWdssf8eUi4r5ZLBouqVc4NS7iNPEqQIZ0
         4+qi+miaIRJeytQUoj86zbEu9cmqt08VPzAVymnB5SJ4E1qhLnZioGQoTPAUtSxATMnU
         DETuWAa4MU0hw2j82jzfU751tMicUPcBOwGa5GBRnZhj0y3fpmFoaeH0o6xxzaaHGJWT
         xIuR6HYqUIC1viVmtrGey4iXlBE4uZXhunmUb2AoqunY4OKC9NJ+ITFMSqPXzXNpIz+1
         ld29xa7d+XvruvYRoUW1Udm2qZxelTgb+iUzJLdUekZGk+FMVCMG5UTeCZ+GZZiPGSo6
         uy9w==
X-Gm-Message-State: AC+VfDwQwlfex8ZzuaHlJZtAQWKC0cYEmGLxVONvShZeb5WjpIlX+fvF
        1fAxPozrt0pX/j7OrKMR/As=
X-Google-Smtp-Source: ACHHUZ5mnKbJoCiZ5FJ8NANBQGVFL/hqZQ4lSK4Gceo/UNOgi3EwJa2Uu8FN/Q6urGdLFOv21ee0uA==
X-Received: by 2002:a2e:9008:0:b0:2ad:f8d:dea with SMTP id h8-20020a2e9008000000b002ad0f8d0deamr1840679ljg.11.1683541859282;
        Mon, 08 May 2023 03:30:59 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id b23-20020a2e8497000000b002a7853b9339sm1133053ljh.119.2023.05.08.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:30:58 -0700 (PDT)
Date:   Mon, 8 May 2023 13:30:55 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: iio: light: ROHM BU27008
Message-ID: <f24196e11ee73511312b629daa20c7d783d8bf6c.1683541225.git.mazziesaccount@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1L/NjY7a/ToVr2HB"
Content-Disposition: inline
In-Reply-To: <cover.1683541225.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1L/NjY7a/ToVr2HB
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
2.40.1


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

--1L/NjY7a/ToVr2HB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRYz18ACgkQeFA3/03a
ocVBYggApkZeXQ8JWJ+5z/52k15uc9Y2lflACQcUQJ4s8vyNg6gUjrXyy3gd8x/C
pVes+xhjfQ74sSzPnByGmMK5dgcsYnLJRDTAjtGiRu6ru813TpuXtlgCAfT6EUzB
qS3bxg/79zzoYQQGNUCIX/9jUoeanvUhb7iJ+odUIIj9uhz35Xmn6NxMf6qOBhIX
QwkPGhUhWh0B756PaGnkGoQs2esp0CEB8mwF7QPlORxUedwhB1+scvNFqwoWL4P5
LooeYgOdx5niP9saWiWW9IyykfpufDGZLqsGhmBs9QnpNe0wCn1OW2aOP/T1z8Si
rGJBUGgZnhdiB9jRm2EB/1YVdiYhDA==
=N3C9
-----END PGP SIGNATURE-----

--1L/NjY7a/ToVr2HB--
