Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8160E59C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiJZQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiJZQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:43:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776EA50B90
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:43:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f22so10334645qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofHed6JKbGC+4Jz+O/EarTAHvckHPCUIcHhSeApLDCY=;
        b=aLHFjwdPYnXhsOuoVkL22zMxztdJ1NzDk0d67uV+NhvXrrXlj+xPGlsIblK1BxbOFM
         elBxoi2cdqe/RbXw3Iyg9+QptTvx757noY2zmvA7X/I7CVBVddCMN63snWzPgge2D/RC
         vwrBTEGuKKXinBTMXBekKcHx2BknBzrunN6LdsFUhfZk9zpKKy8K6/T/GmW5LLkf/92d
         iCHa8iJwdx5dj8++qiim2LwLWdl16iieAqESA4YFhIhsEP3ZKRTMtukqnxwJMXh3zKlP
         TKtt6DN8TQD3d3ygdGXH9rVzHAMYfPyCJ2quWIbjdvwXku30KgDYT5k0oRZVQbJyoUYW
         FS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofHed6JKbGC+4Jz+O/EarTAHvckHPCUIcHhSeApLDCY=;
        b=sf9BIxMGpSEVPI3nkgQ/qru4OKQc52HNGqtTdZiIxfpfQz+xx5YS9NanYiNVyG4bLq
         sru45pkRTeFgcHEduozfsuiiAEgNmGAOfXOYjebD54MfyRHdDkjbh4dNUj1Hw1bg7uZC
         4NEV1aKhv1gCmjzR5ZossK7NAbayJn0WgW1Y3XGhYHRgCSkUvNGXwPKd3jnoDnWz02bG
         M0ZhDTjEOvbxzZa8rV0UPqDl+2GoGywvBRpYC+D3Rf1eASBzFnqaoLoWszXOoypVghYe
         Wbdr0mORhthgSRrHZ3M5DAtRLDfcM+IZ/Y9lZ7DcoSkQx7ojfY0qYqmoBLjaquJ9VXJf
         TQkQ==
X-Gm-Message-State: ACrzQf01x68VTKhcL6jjuLAnTdRtCpLKt03soNhe0dQl/UIHMCGoxIuk
        k/gEIN3W17H3FFpv7rnj9pWlo9A89kBDQQ==
X-Google-Smtp-Source: AMsMyM5KNhaj6JZ7ZYNxNOyH6EoB9XYMvL1EJLKX69PWjefo7oe7gE8B4IZyuqNQbcJWtRMDiq7wdw==
X-Received: by 2002:ac8:5b93:0:b0:39b:1a8f:bbbc with SMTP id a19-20020ac85b93000000b0039b1a8fbbbcmr37258513qta.477.1666802601182;
        Wed, 26 Oct 2022 09:43:21 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id j6-20020a37c246000000b006eed47a1a1esm3989938qkm.134.2022.10.26.09.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:43:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: slimbus: convert bus description to DT schema
Date:   Wed, 26 Oct 2022 12:43:13 -0400
Message-Id: <20221026164315.39038-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026164315.39038-1-krzysztof.kozlowski@linaro.org>
References: <20221026164315.39038-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the SLIMbus bus description bindings to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/slimbus/bus.txt       | 60 ------------
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  2 -
 .../bindings/slimbus/slim-qcom-ctrl.txt       |  3 -
 .../devicetree/bindings/slimbus/slimbus.yaml  | 95 +++++++++++++++++++
 4 files changed, 95 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml

diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
deleted file mode 100644
index bbe871f82a8b..000000000000
--- a/Documentation/devicetree/bindings/slimbus/bus.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-SLIM(Serial Low Power Interchip Media Bus) bus
-
-SLIMbus is a 2-wire bus, and is used to communicate with peripheral
-components like audio-codec.
-
-Required property for SLIMbus controller node:
-- compatible	- name of SLIMbus controller
-
-Child nodes:
-Every SLIMbus controller node can contain zero or more child nodes
-representing slave devices on the bus. Every SLIMbus slave device is
-uniquely determined by the enumeration address containing 4 fields:
-Manufacturer ID, Product code, Device index, and Instance value for
-the device.
-If child node is not present and it is instantiated after device
-discovery (slave device reporting itself present).
-
-In some cases it may be necessary to describe non-probeable device
-details such as non-standard ways of powering up a device. In
-such cases, child nodes for those devices will be present as
-slaves of the SLIMbus controller, as detailed below.
-
-Required property for SLIMbus child node if it is present:
-- reg		- Should be ('Device index', 'Instance ID') from SLIMbus
-		  Enumeration  Address.
-		  Device Index Uniquely identifies multiple Devices within
-		  a single Component.
-		  Instance ID Is for the cases where multiple Devices of the
-		  same type or Class are attached to the bus.
-
-- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
-	 	  Product Code, shall be in lower case hexadecimal with leading
-		  zeroes suppressed
-
-Optional property for SLIMbus child node if it is present:
-- slim-ifc-dev	- Should be phandle to SLIMBus Interface device.
-		  Required for devices which deal with streams.
-
-SLIMbus example for Qualcomm's slimbus manager component:
-
-	slim@28080000 {
-		compatible = "qcom,apq8064-slim", "qcom,slim";
-		reg = <0x28080000 0x2000>,
-		interrupts = <0 33 0>;
-		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
-		clock-names = "iface", "core";
-		#address-cells = <2>;
-		#size-cell = <0>;
-
-		codec_ifd: ifd@0,0{
-			compatible = "slim217,60";
-			reg = <0 0>;
-		};
-
-		codec: wcd9310@1,0{
-			compatible = "slim217,60";
-			reg = <1 0>;
-			slim-ifc-dev  = <&codec_ifd>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
index e94a2ad3a710..7c3d9eb6af5d 100644
--- a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -5,8 +5,6 @@ with SLIMBus slaves directly over the bus using messaging interface and
 communicating with master component residing on ADSP for bandwidth and
 data-channel management
 
-Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
-
 - compatible:
 	Usage: required
 	Value type: <stringlist>
diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
index 922dcb8ff24a..6d955e129f90 100644
--- a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
+++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
@@ -4,9 +4,6 @@ master component.
 
 Required properties:
 
- - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
- - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
-
  - reg : Offset and length of the register region(s) for the device
  - reg-names : Register region name(s) referenced in reg above
 	 Required register resource entries are:
diff --git a/Documentation/devicetree/bindings/slimbus/slimbus.yaml b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
new file mode 100644
index 000000000000..22513fb7c59a
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/slimbus/slimbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SLIM (Serial Low Power Interchip Media) bus
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  SLIMbus is a 2-wire bus, and is used to communicate with peripheral
+  components like audio-codec.
+
+properties:
+  $nodename:
+    pattern: "^slim(@.*|-[0-9a-f])*$"
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^.*@[0-9a-f]+,[0-9a-f]+$":
+    type: object
+    description: |
+      Every SLIMbus controller node can contain zero or more child nodes
+      representing slave devices on the bus. Every SLIMbus slave device is
+      uniquely determined by the enumeration address containing 4 fields::
+      Manufacturer ID, Product code, Device index, and Instance value for the
+      device.
+
+      If child node is not present and it is instantiated after device
+      discovery (slave device reporting itself present).
+
+      In some cases it may be necessary to describe non-probeable device
+      details such as non-standard ways of powering up a device. In such cases,
+      child nodes for those devices will be present as slaves of the SLIMbus
+      controller.
+
+    properties:
+      compatible:
+        pattern: "^slim[0-9a-f]+,[0-9a-f]+$"
+
+      reg:
+        maxItems: 1
+        description: |
+          Pair of (device index, instande ID), where::
+           - Device index, which uniquely identifies multiple devices within a
+             single component.
+           - Instance ID, can be used for the cases where multiple devices of
+             the same type or class are attached to the bus.
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: true
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+    #include <dt-bindings/clock/qcom,lcc-msm8960.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        slim@28080000 {
+            compatible = "qcom,apq8064-slim", "qcom,slim";
+            reg = <0x28080000 0x2000>, <0x80207c 4>;
+            reg-names = "ctrl", "slew";
+            interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+            clock-names = "iface", "core";
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            audio-codec@1,0 {
+                compatible = "slim217,60";
+                reg = <1 0>;
+            };
+        };
+    };
-- 
2.34.1

