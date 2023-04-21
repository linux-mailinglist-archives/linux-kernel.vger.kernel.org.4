Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5026EA739
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjDUJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDUJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:38:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061829ED9;
        Fri, 21 Apr 2023 02:38:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec816d64afso6486954e87.1;
        Fri, 21 Apr 2023 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682069902; x=1684661902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+puYzROBtSGvQ+bB1lDEXoa3ZhtBvmdV2BDyw8+XGDI=;
        b=kDA0siLwuDxBz7jmiKRO6O5bcpU/j9MIy81WG1OJXhrQz440tOwWGjSuyfdn+IcMDL
         ynakRNHY9D3w4cuO2ERLCUxGOj9ZdBlZsASI1kthkFr1Ak0cfS6MkO55lxMoslcQBxe1
         NIAaGFnwoR++8WMhAz6OOv7fAAHwYAT7DDqrqqJiPZIhQj9rI1dSwWMocSPC1jvfxG8K
         gkKlb4rXhzN8b045zgtUDakfB4CAmTYCorjbUgfxHiILnuMjeZqIelN+wM5JM5teqVtm
         V+Dr9+GgWrbC+Lqaxts2EhTnn8iLX1FUsWCjthqID8UUj2tPzC3o4Cnsk1P8CIhqeGUe
         BuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682069902; x=1684661902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+puYzROBtSGvQ+bB1lDEXoa3ZhtBvmdV2BDyw8+XGDI=;
        b=aCBfCYd4Sffusz3ptRp2be7mjSl66djDI72MVP3XAzg4kueB/lkFgpsu92994aFOdA
         izJ6KZ3k5hPuMbat5QX2pnocDFDocC8Ny68TXMN5tZYki5DKoKVnf+O12eHR9hE0t3RP
         QlhPvmERg9MxXAMzYXkQtkAhaN18Ymr2d7mQ8En2laXKtc+zGsEasmUZXWjmAoyWJPWe
         H+tBuR3uf+861TomwdByNq/HDRRWIX1j6jiWdy8atSpKJ5qxli3pnGUNW3dpzBspfab3
         ejiVJrrroBIeReWngPyzjwm9cCRkFkb2Fz9YS/TBcwJ0bTOmO+eJLyQSQzo2pr6WVD6i
         G+EQ==
X-Gm-Message-State: AAQBX9exdZgFfr9A/efAmtbceVB1+Yx4hc8PxS1MaHtCCc2ifc01/j1Y
        2nX0+d7Sw/T/gOlEof0qSja0BX/yIlw=
X-Google-Smtp-Source: AKy350amIvjk2h7dze+LRP9A5Hz0YQ28O13F49yYY6qSZgJNu7w8kPRzsn96xcY/8HVF1zsHHoMRXA==
X-Received: by 2002:a05:6512:1081:b0:4ec:9d13:9d09 with SMTP id j1-20020a056512108100b004ec9d139d09mr2729509lfg.34.1682069902230;
        Fri, 21 Apr 2023 02:38:22 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512048300b004ebae99cc1dsm497134lfq.159.2023.04.21.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:38:21 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:38:16 +0300
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
Subject: [PATCH v1 1/3] dt-bindings: iio: light: ROHM BU27008
Message-ID: <30daff0d94cd4d05de0194808ab9a6984caf78dc.1682067567.git.mazziesaccount@gmail.com>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A7z/K2sA5slhMnG3"
Content-Disposition: inline
In-Reply-To: <cover.1682067567.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A7z/K2sA5slhMnG3
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
---
 .../bindings/iio/light/rohm-bu27008.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu2700=
8.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
new file mode 100644
index 000000000000..d942c2817680
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/bu27008.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27008 color sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
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

--A7z/K2sA5slhMnG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRCWYgACgkQeFA3/03a
ocV94Qf/e1GtM0XXcFQvt69AZKaPENSQSPdnatWY6bNvTQnTLud33tmuh3l743ex
RmzNZtpOPZ2fuBffUaU9E2uUKjJzEtnuK7Sg+1Cw0T1G2DXPLLZsErY6PHLUx+y5
a5GUJn3FrXcdM5Lud9KU+KB3rO2lANjjH7xKoBVqsfoX2wqVBGMv/aeuRIPGNWxU
jOveSvxWTCyzwZb7p1jR0y/Jhf2ePveDZl3ya7oMu+LshlH7l8ei524tzUcpZlti
Kcme77TKumS0fW5KNzP6PrHx1fFyraD7HppjpPwUHY9rcFapn11p+1Cjioan9fLf
aGm1qT5xoDab9/u1vDLvWxc+bwmkoA==
=sipe
-----END PGP SIGNATURE-----

--A7z/K2sA5slhMnG3--
