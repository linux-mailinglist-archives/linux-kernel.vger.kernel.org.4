Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC11C64881F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLISAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLIR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:59:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B30A387E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:59:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so8212882lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f22vZCjXybDI16EXekXa2UBySgDksyt2VSWTc/dPnDU=;
        b=KREhYnoePYN4orZ39eONxq3E8mSCU/zQFges9mjBszy9iwCGX1ZXqFGaYTfjE8KNWq
         GnbMWK91HSsX8IalnxIx41GuyCpVATG0U7oSMxXCkMyyZW16KTTKrb9oeWt9ZnJPv+EQ
         hLokxIzo1JKTf35rrcGPwktCrRNhLfhIKpr9tkZw+c673FPBnyLAeisPiDPRuYN6Z2SJ
         Ovy+t5FmhGhX0fXh+2xF3huOxUtjIe5oTGehlXTtoVUvL4FGryF62bDjfSJCKKEb63Fe
         NGqV9r87jpMEvQXfkhtL9eLr5iO3HBF6ipMIg/gYK9I8US20Jie75eUEbbhMpz7guj32
         7WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f22vZCjXybDI16EXekXa2UBySgDksyt2VSWTc/dPnDU=;
        b=yfil6BfqQ2yNIsEJPgVf0ZXXat5Qo0ZGPfGSk4NS7S8KiiXrMjvCc1aS0y0599d52i
         8/tHYpRzWMG7s/rfI2Mh2TksRBPgm1adOSco8ssDAXEz9+OHFqTETnXWG6hUAliom/dN
         E2wuwqIRVTxzVji1guue8wACjZLVJFcFB6Y0DUgyHgsfsU664b3P1J+pbKcXscUlpLGZ
         LltLNpL61DPpoDKWUPIayFdinRM9W+qtn4AZacd953GGpvWRYbMZa+PHOBsNoHFo0FLI
         k2yvqpuSuHDy7NdDgayFnu/m7mJzTEgg1x7MclwvDKS1kmGd7/lZrf+lma9WYLNZaypa
         Hi1g==
X-Gm-Message-State: ANoB5pkAwb7Nq0pb3Sn1xMm07fznkAlzQLFCX0byOf7rI2giTWMejSKn
        ROoPxZXvrCLMU63PhrUXzWEsYA==
X-Google-Smtp-Source: AA0mqf706m4/EPthaGELVyDiMAmsOzNdN2ihBoRYFH9rN1tRPkIS/dT9wEdG+K0RroRv6jFflRAp0g==
X-Received: by 2002:a05:6512:90c:b0:4b5:2cf4:cc1d with SMTP id e12-20020a056512090c00b004b52cf4cc1dmr1585358lft.68.1670608794982;
        Fri, 09 Dec 2022 09:59:54 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k16-20020a0565123d9000b004b577877286sm350380lfv.50.2022.12.09.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:59:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: adi,adau7002: Convert to DT schema
Date:   Fri,  9 Dec 2022 18:59:46 +0100
Message-Id: <20221209175947.335319-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Convert the Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
bindings to DT schema.  During the conversion, add properties already
used by DTS (sc7180-trogdor-coachz.dts) and Linux driver:
1. wakeup-delay-ms,
2. sound-dai-cells (via referencing dai-common.yaml).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/adi,adau7002.txt           | 19 ---------
 .../bindings/sound/adi,adau7002.yaml          | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,adau7002.txt b/Documentation/devicetree/bindings/sound/adi,adau7002.txt
deleted file mode 100644
index f144ee1abf85..000000000000
--- a/Documentation/devicetree/bindings/sound/adi,adau7002.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
-
-Required properties:
-
- - compatible: Must be "adi,adau7002"
-
-Optional properties:
-
- - IOVDD-supply: Phandle and specifier for the power supply providing the IOVDD
-	supply as covered in Documentation/devicetree/bindings/regulator/regulator.txt
-
-	If this property is not present it is assumed that the supply pin is
-	hardwired to always on.
-
-Example:
-	adau7002: pdm-to-i2s {
-		compatible = "adi,adau7002";
-		IOVDD-supply = <&supply>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/adi,adau7002.yaml b/Documentation/devicetree/bindings/sound/adi,adau7002.yaml
new file mode 100644
index 000000000000..fcca0fde7d86
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau7002.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,adau7002.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: adi,adau7002
+
+  IOVDD-supply:
+    description:
+      IOVDD power supply, if skipped then it is assumed that the supply pin is
+      hardwired to always on.
+
+  wakeup-delay-ms:
+    description:
+      Delay after power up needed for device to settle.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    audio-codec {
+        compatible = "adi,adau7002";
+        IOVDD-supply = <&pp1800_l15a>;
+        #sound-dai-cells = <0>;
+        wakeup-delay-ms = <80>;
+    };
-- 
2.34.1

