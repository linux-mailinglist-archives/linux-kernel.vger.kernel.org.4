Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A41656380
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiLZOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiLZOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:40:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB06326FD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:40:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4862026wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7banWwwsmEhAMwd0p3G6LQxECLa8EIArIFBDYxp31o=;
        b=aPp+OM7ftQtqw14kw8eA3Ms6xjUNhh8ZjCovsAGt/40twj+IRZ2oR1Fc2ajU14H04K
         dEdRjGA7VDunNy9eRNEcndV1I4bG+MUvKaRvKQr1oHZjCNQg3a/xPuhZVLB5ieDqnQ4b
         kURIvvF1UdwsjpMrgsjUXqs3hzrEzCppmeapqQA+ImrKSzluEPLXNAPdPIY2rdRPF2e1
         qJq+dCxvDcmfJ2FhGyIYXwl0nmOm9tX7R04dTLKasTXYS4rQ1JfCRANZpdEfxXnCrAHv
         whxV1RRJv/w7RpKreA7k0BRVVU724OGeKomCr9DdyhamykMJCCLO1l/UeduHFJyS2Ogt
         IzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7banWwwsmEhAMwd0p3G6LQxECLa8EIArIFBDYxp31o=;
        b=WPohB1WQI8QFQVKuQLoAqcSBpxLNubUApqmRIMw1O7KwsMDOklYTcv4JhDEa636GNe
         moMxvURf2NxqCAVBjiX13aGXoHwEOozs/mXiHlF6Snq7Vn0aYC3hnD8SS1DQvYuH4h5c
         7VYPaBsZzqm3wCtKvah8IV4lpW75bnTTxKwXaTYzGZyjAi4Y9OwTYb2JFPZeVPGD8kRe
         RPJ/5PgtDlNTsanJhkGiui3vCMObIwsbwKCzrEfV0T1ovfvLxoZNkR5JNoa9L6U/hrp1
         jD0MBzo2Ks7NYo7z3PnwNGpfeGXqOghK+77DCb87VgskPmMwSL//mIao5ro413RX8V0O
         kbww==
X-Gm-Message-State: AFqh2krBPiNlh7e2qm5SHH+i2ETbhMMPl8gsaO+9rw34mQua2+mYJWuJ
        HgCoWQmxZ4kTlzM7Uj0/OTFaBw==
X-Google-Smtp-Source: AMrXdXs6i70OhGSFwD07vpY1ro/80Je1H1z07HjRWJ3uCwyM0u1K0XbjEUnA6aH+vjWTW8Yug7GY4w==
X-Received: by 2002:a7b:cb8a:0:b0:3d2:7e0:3d51 with SMTP id m10-20020a7bcb8a000000b003d207e03d51mr13618711wmi.17.1672065650373;
        Mon, 26 Dec 2022 06:40:50 -0800 (PST)
Received: from alba.. ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003d34faca949sm13903316wms.39.2022.12.26.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:40:50 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     arnd@arndb.de, richard@nod.at, miquel.raynal@bootlin.com
Cc:     krzysztof.kozlowski+dt@linaro.org, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, pratyush@kernel.org,
        michael@walle.cc, Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] MAINTAINERS: Update email of Tudor Ambarus
Date:   Mon, 26 Dec 2022 16:40:43 +0200
Message-Id: <20221226144043.367706-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8599; i=tudor.ambarus@linaro.org; h=from:subject; bh=rQ7JAyf0SzqzcLVYCKY8oxA4DPU6SxO+OeZVNsenqjQ=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBjqbJjR4dDIC5ityHfZOLSdiECWzrPx4apGu5KX/9+ vkpXhAKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCY6myYwAKCRBLVU9HpY0U6QKUB/ 9Y3w+DilyYY6atyMIFqDQGmDuUFEqXpYh7MYH3uoxf6Hek3drgBFQdORyUygpiYAZWc+B7uU2urwqL Vfwrk/T/WIpau+PVTSF8OxL5WYPVqE4abWSsLXY63QjwBfGnQfQ77BeTIpEVM5o1yW3i8vG0d2L/zZ vg722o9itrPuJucHTSSKveCVO8tUiVP2nMoz7X5RCHksfNOdH+IQ3/ql7wajkMbFDMYX9TmPFH4dVj vTk8raRYPhF/z3iZpmvTD5q7npVT/D9e58YYJNKHr61mqsF5VNWECO0MwZc20sWitk7Bp2T1ojKOuE EtqQS4Imkxwn8yReIoYzUOil3/KDOv
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

My professional email will change and the microchip one will bounce after
mid-november of 2022.

Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
author mentions, and add an entry in the .mailmap file.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: rebase on top of v6.2-rc1, collect Acked-by tags.

 .mailmap                                               |  1 +
 .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
 .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
 .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
 .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
 MAINTAINERS                                            | 10 +++++-----
 drivers/crypto/atmel-ecc.c                             |  4 ++--
 drivers/crypto/atmel-i2c.c                             |  4 ++--
 drivers/crypto/atmel-i2c.h                             |  2 +-
 10 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index ccba4cf0d893..562f70d3b6a5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -422,6 +422,7 @@ Tony Luck <tony.luck@intel.com>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
+Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
 Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 0ccaab16dc61..0b7383b3106b 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 5163c51b4547..ee2ffb034325 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Secure Hash Algorithm (SHA) HW cryptographic accelerator
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
index fcc5adf03cad..3d6ed24b1b00 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic accelerator
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 4dd973e341e6..6c57dd6c3a36 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel SPI device
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index 1d493add4053..b0d99bc10535 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Quad Serial Peripheral Interface (QSPI)
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..8fa9386559f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13620,7 +13620,7 @@ F:	arch/microblaze/
 
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	dmaengine@vger.kernel.org
 S:	Supported
@@ -13665,7 +13665,7 @@ F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
 F:	drivers/media/platform/microchip/microchip-csi2dc.c
 
 MICROCHIP ECC DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
@@ -13762,7 +13762,7 @@ S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
 MICROCHIP NAND DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -13814,7 +13814,7 @@ S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
 MICROCHIP SPI DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
@@ -19664,7 +19664,7 @@ F:	drivers/clk/spear/
 F:	drivers/pinctrl/spear/
 
 SPI NOR SUBSYSTEM
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 M:	Pratyush Yadav <pratyush@kernel.org>
 R:	Michael Walle <michael@walle.cc>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 53100fb9b07b..12205e2b53b4 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -3,7 +3,7 @@
  * Microchip / Atmel ECC (I2C) driver.
  *
  * Copyright (c) 2017, Microchip Technology Inc.
- * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
+ * Author: Tudor Ambarus
  */
 
 #include <linux/delay.h>
@@ -411,6 +411,6 @@ static void __exit atmel_ecc_exit(void)
 module_init(atmel_ecc_init);
 module_exit(atmel_ecc_exit);
 
-MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
+MODULE_AUTHOR("Tudor Ambarus");
 MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 81ce09bedda8..55bff1e13142 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -3,7 +3,7 @@
  * Microchip / Atmel ECC (I2C) driver.
  *
  * Copyright (c) 2017, Microchip Technology Inc.
- * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
+ * Author: Tudor Ambarus
  */
 
 #include <linux/bitrev.h>
@@ -390,6 +390,6 @@ static void __exit atmel_i2c_exit(void)
 module_init(atmel_i2c_init);
 module_exit(atmel_i2c_exit);
 
-MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
+MODULE_AUTHOR("Tudor Ambarus");
 MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index 48929efe2a5b..35f7857a7f7c 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017, Microchip Technology Inc.
- * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
+ * Author: Tudor Ambarus
  */
 
 #ifndef __ATMEL_I2C_H__
-- 
2.34.1

