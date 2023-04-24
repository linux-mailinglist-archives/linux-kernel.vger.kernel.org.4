Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401696ECC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjDXNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjDXNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:08:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E13A94;
        Mon, 24 Apr 2023 06:08:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4efd6e26585so2571593e87.1;
        Mon, 24 Apr 2023 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682341682; x=1684933682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6femOnySKNTiqjlHMDrxwe74ekz6pLAJiaQJ5/km8I=;
        b=DsBIs1MU4P+VNHqd6N6xMaAtkrzAcuPgpkeeVNuI3+jEmi8Gc0ZIAxqIQM4e3wgT8B
         vD/tam9+dfkf3s0lGCcfKedqKaY7AdmDxG1zG+aGAEmzpomvaFRzWCYsiDkpuhuSVX5H
         dk7ma2AjL7Zg47DtL4zuXkgyFDDSEscH2xNnerSZwRyTOTSwQcV0vgkNLrg1cgTqg+f7
         K39R0WPxQjbgjTXpA5Jbp3LcwVfRTkJSz7/nQT9emJ48KL6VBTzbkz2Dk4yhV5oUIC8J
         q71KwpOFArC4ku8QApFEO2xEmFECZqFNasSdCagqTR08iWTy8sPVYVscNg16uWxtDrip
         a3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341682; x=1684933682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6femOnySKNTiqjlHMDrxwe74ekz6pLAJiaQJ5/km8I=;
        b=hTakThds0GI+f/7xPavWF4JkUDm5lmOJAQGWeS/EWktFCEv+1+TE7Uc61a8WWu4RPY
         /e0vHJp86/2DdcsovtOU73/2gTIkMjh2Kd5mq1gsPDEbhF2Y+CCbD+p/0MB/n07m2xWa
         ovulHAIbDbX26ECwAHmTN7Y4bOe0trFqambqutIWif44rft2W3kvba42Zi/Z+XBLJBdz
         PrbZVIYI/eTsjllIVjdp0SXNXC9w992L0aaaDkfZZ+jXmDJf/JHminYe/22jwwRFekUq
         TQhyffZcC/EuAO98vtyQ8KbHz6MpVVk4jEXUFPl6tB7+hIcg2gSTovjaUH05jEAjTA6+
         AIkg==
X-Gm-Message-State: AAQBX9czuoUWQKAt3IdrBZjvdb9Ef8v0KY7Oi1es5nLyhmQt0FqI7H+y
        pvrUpodPOxq+3wQKziGrtzE=
X-Google-Smtp-Source: AKy350YCIhYP0e1sJomsjp+MuMCtrER9Ozxgi5VyH7aJXE1FyQuYCDkvE+Wrv2mF5oi7q4Nth5Bs6g==
X-Received: by 2002:a19:f611:0:b0:4ef:d3f3:c421 with SMTP id x17-20020a19f611000000b004efd3f3c421mr2617436lfe.4.1682341682550;
        Mon, 24 Apr 2023 06:08:02 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id p15-20020ac246cf000000b004d8546456c6sm1651913lfo.195.2023.04.24.06.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:08:01 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:07:58 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: iio: light: ROHM BU27008
Message-ID: <c05272fdd607c45d352008f9d01fc44b9b8f50cc.1682340947.git.mazziesaccount@gmail.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eQ1QSQkWWvAGy3fT"
Content-Disposition: inline
In-Reply-To: <cover.1682340947.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eQ1QSQkWWvAGy3fT
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
Revision history:
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

--eQ1QSQkWWvAGy3fT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRGfy4ACgkQeFA3/03a
ocWtbAgAtdJKk1L7K5vQ+BbqtRExoYxcQMW9b/4txxP7elXDEcJNVrh9S+9MZxM9
7SgDamCH+DBpErDIQavyDtSd+QCmvVrpBMiPGItc7ipIaqtVbRBgLl9kEcUY5Bri
7wFBoMofWoaqOzHN48fnFZ3uwPQlsp3b6jBb5IeciCodLASKH4zwsxB3QQ9l1O1u
eRXTBLwK6aje8ZNJ3aphMgOD3u9vAm3n8feM9Ta/BxDvRlI3WZOf17+jb1ECEo5S
a8mJ7+lKg8xC9NUTlMCJU6KLmYXwBLIExZOba2TJXbxg+zUaiBsrA58uEsSSB+xj
Z8xndlbcBrVlQQq4MF/ATpW0deHavg==
=cBYC
-----END PGP SIGNATURE-----

--eQ1QSQkWWvAGy3fT--
