Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4E72DF25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjFMKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbjFMKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:20:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771031996;
        Tue, 13 Jun 2023 03:19:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so5629039e87.0;
        Tue, 13 Jun 2023 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651594; x=1689243594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ea+jMsMQ/htkjKLyTsdd7SMmdtpqccg73G5Yjc+Wabg=;
        b=WqSWnZPGE2rZnf/HFs6LcaRUDQZQU6r3o2NT0UveUZ58G+2A3EecxeeSmHmc9dOJF0
         2ESIxKKnz0kloDiDveyFERofJQtI9+fOm7u/quPhv9q5aTj0mLMQP7LYN3IPJULSK/kp
         tRUH7uWVXlX/1jibwqiRadQFA57y15XIAEERcgj2KmpHDoIAkVHzw8m23HKm69mtjQyK
         BXDS/jao/9riLj13/atKBfkq8ro74seu+pIOTMdddDPZ4CTLPtTi/mM22aG3ck6I0xBK
         4bAky6uhT8dLpehzRfgxM4+CN0YVvMg92HBp7u9XB73yiYAklrTQ+6LYGQOYSF+U8jVK
         2rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651594; x=1689243594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea+jMsMQ/htkjKLyTsdd7SMmdtpqccg73G5Yjc+Wabg=;
        b=NqjptMNLMncmOI8yVYhzeAZdMu4DY2eg8Pmg45wrh/DaNo8Sh7dttljU1NZTzgwN+F
         EA5x5Qc9D56ks/5npzzEr5sCoq0jiqUWsK4FOcSvtRrbWuC1QLXslbypkGakvf0Q0FF3
         uwhHzVONRF59m1smRg9LcnZAh64XAdWbdV2Zl06LRK6co0E9QmoxeMOMTMH+w4JbSU2q
         uKudkRNmqtXNg6TiSDkfWaKKm1RGYCZcbR+CWKIrd0mXYmPzptPEMuGbj+1j9l04tc+E
         wuBHWgj3yBOdRLWIyyZCxdS5r3pmLTIu7fVoahF020e04A/o837v+a2/pm8YJcQLveQj
         jBJg==
X-Gm-Message-State: AC+VfDxcwOnbOY9JSWO0r7gv/OOts+VNNNhxj7pMLVq4kFDC54uxH9LT
        lzD1dXSRux7qnrsxbmh9ZSw=
X-Google-Smtp-Source: ACHHUZ7KugAREAncyLDx0G7YLkWa5nDS7KoMFYgkfVRpzT++2fUm0JqFQ+1k5Vanj/zv++iUsUyPbA==
X-Received: by 2002:a19:7104:0:b0:4f6:3000:4d5a with SMTP id m4-20020a197104000000b004f630004d5amr4530707lfc.38.1686651593412;
        Tue, 13 Jun 2023 03:19:53 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24463000000b004f381a71f26sm1734715lfl.46.2023.06.13.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:19:52 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:19:49 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: ROHM BU27010 RGBC + flickering sensor
Message-ID: <98e0b6fba7ff7515b541a517296d5b89dc73ce5b.1686651445.git.mazziesaccount@gmail.com>
References: <cover.1686650184.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WmYTfxGs9jNxBRbv"
Content-Disposition: inline
In-Reply-To: <cover.1686650184.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WmYTfxGs9jNxBRbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
IR and flickering detection) with five configurable channels. Red, green
and flickering detection being always available and two out of the rest
three (blue, clear, IR) can be selected to be simultaneously measured.
Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
and tablet PCs.

Add binding document for ROHM BU27010.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/light/rohm,bu27010.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
new file mode 100644
index 000000000000..2bde9d2f1def
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27010 color sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
+  IR and flickering detection) with five configurable channels. Red, green
+  and flickering detection being always available and two out of the rest
+  three (blue, clear, IR) can be selected to be simultaneously measured.
+  Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
+  and tablet PCs.
+
+properties:
+  compatible:
+    const: rohm,bu27010
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
+        compatible =3D "rohm,bu27010";
+        reg =3D <0x38>;
+      };
+    };
+
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

--WmYTfxGs9jNxBRbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSIQrkACgkQeFA3/03a
ocVBHAf/S6NOXltJJc4vDappg6HVyiJvKbPZRUax4mmP0cdOTVfEy3ldC+WmxI5z
3/JRXuPU3DUgR6NLZGhV30Ms2xBBm0pY4Cy7XYLXdBlVLHAohDyPYwQpd9/DDd3X
fL9PU+Fur+3tEWNMHNv7DcYfmI8pQenizwZG/h737Ymfe7oxSxogkt6846TM7TFH
swX7a9nqy6apb5vNGfslIutSMs7sxN4HLtV6/ymz41dPkI1Vf/XkAtS5TcXTVu7c
WJGDV+8AhCRlrjvwC2FhgOwfupbSYO4sy5lUUGVJGgNMl7qWBOwA51Dj2LwJEWyj
1vcpjx5NKMQlecfWWQ1CV/DRHbI6XQ==
=j9Jf
-----END PGP SIGNATURE-----

--WmYTfxGs9jNxBRbv--
