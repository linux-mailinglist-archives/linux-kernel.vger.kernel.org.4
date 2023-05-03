Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2956F5537
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjECJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjECJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:49:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BE49F2;
        Wed,  3 May 2023 02:48:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so50384831fa.2;
        Wed, 03 May 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107314; x=1685699314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DLhXL1SHK8zjmrz0XD00qubJN9V0QxBZCbEYgZPK2o=;
        b=HLQOpM+rJzcwbDmpuDNqG5rzSuWW7jIZwCve4iigYnrIBJsoJ2FsEHmt/h5PXG6ULB
         Wzd67qv/u56PgnhDX78QirqbzzfAemCtt0bIJYIPCHu2v78qrEknAjeSnyHpXCL1g1wS
         +0G/AvsfAJej/Pw3h1fn7M3bXLO6Qg606NxhijItefX7kpj+RRItKCtmwq3EMbm1DP24
         wnuaXoKznrlC2gkNYxmQk36TG48tHBSbzUF3eFC/DDqAFRTv0tCRjt6mGeBeJUwIv0ij
         /4PB4uUBLImApFv6spGad+mP8OMyKVNxpwt49fh3jrVSdOZfBkynNbs2tz+6rDv94x5U
         ZhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107314; x=1685699314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DLhXL1SHK8zjmrz0XD00qubJN9V0QxBZCbEYgZPK2o=;
        b=M3cwZ1/QjjUQYlmvZzVBAykxjhtR97BvliMbSMuWD8q+vLN/IkYu0dmtPZ0mq1LWAm
         QXGNJ/1tPN0T0rkFSHTtRf5kntBBApUxSZBFzrdO9j9B2OQx35Q1X0W1NtZiKG/U14/b
         IvLhv3eLOxN/IgpUUIMbxeAmT6uTut3hV/W1wdMmj53TVLutJJJh8Wg9BMppDa1bemg7
         DzrZI4BHlh0T+ZDVx1wOGIG3HYGBSHFhZhcXY8OMKaYJDnUPUbdLDuiVKXa76+KD4PUQ
         zeqseDihwyGmvo12bh4BKK78nmhSqwQb7gTcc0qikpVvoWR0VtV81w4aEW0i5HzQsfnG
         XJRA==
X-Gm-Message-State: AC+VfDzth3dAyp7c7qfAvG5WocJK8/mZFJia6o4uWvT16byLJ7o0VnIa
        dT2FHFmU6sP7NxmbXOwkN5Q=
X-Google-Smtp-Source: ACHHUZ555FDNwTrzYDDuzf8DHHczi7B/PTIMCc4taiw7yHHBp/E7LSvlYo67kkCCSg+vjyETJH4Gfg==
X-Received: by 2002:ac2:414b:0:b0:4e8:3fca:4927 with SMTP id c11-20020ac2414b000000b004e83fca4927mr665829lfi.58.1683107313768;
        Wed, 03 May 2023 02:48:33 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l14-20020ac2554e000000b004dda76fad5asm5877868lfk.218.2023.05.03.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:48:33 -0700 (PDT)
Date:   Wed, 3 May 2023 12:48:29 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: iio: light: ROHM BU27008
Message-ID: <1fe50acb5223a2f1d882951697911f190391d546.1683105758.git.mazziesaccount@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ojlY+SCRNoXtnTjn"
Content-Disposition: inline
In-Reply-To: <cover.1683105758.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ojlY+SCRNoXtnTjn
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

--ojlY+SCRNoXtnTjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRSLe0ACgkQeFA3/03a
ocW9MAf9FyAINt2z25PTVVWG2amRPpNVvSUUQWfDjMssQYgoSlSnRemkyf2YQOGz
08j51CQYRX1lf1R4RUxnUAxYjJ0b07Lu5P/0Zk8wyLy0O1AgYCUHuoCbFSFzBMPV
y8cE8rbfhgUTQdWrMCUXraP/6LXNWVPYg0muR4cJzjaUi8fwgBkr7lzY4HDOhU6r
qPrgCLHPdsUZfoNGzYqULQa1JI3ttkGqO9+3+XNxg35kUVP+BvopyWLZt52AgMaA
uIWFEF1aYMTvGnCS7BuJL34EDrpM3H+Q/shqh8urwiVorX5LswSGH5UDOBXOQqHo
enysVh/kRm19AX38EbHlNqwul/QPrQ==
=Koi1
-----END PGP SIGNATURE-----

--ojlY+SCRNoXtnTjn--
