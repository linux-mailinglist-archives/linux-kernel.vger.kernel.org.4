Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506AE6D87A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjDEUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDEUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:03:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB7198D;
        Wed,  5 Apr 2023 13:03:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so38404800pjl.4;
        Wed, 05 Apr 2023 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680725028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47jcjFBV2Bf2A+zp4VCowtO0VoXUDpf6jywhaI3b9P0=;
        b=hn5nvYZlCGOAOIdPKry5XznwJu9mcOIFNVRVPxQyYPWVIwoWUtktRh92Gcd2Ljwxrt
         +oRDXTiDdt3rS9XUqrgZrL8ZrDnzRZhq/lJ54iOb4LNIwpN1Li9iiGSgw1d8Ps8Rkn4u
         Jweotuv+VumA6vpcnvL1p/UsYZ7VbuMOTilL3Db0pWVKA3gU4sN8Z1mD8s20N/SfWqi+
         JT2FF+E7MhpuaGIhydfUKTh9n1q7S8G6hkaLVx+lzI9OBNcHOg7sJBXMHleczMdDkQJ0
         OoK0Q4Gf2giCezf14j+e7QPHYzV0sRZzkxKjIptHUA2lwN4LKxknCrn+CFPkq0PvK0D9
         st7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47jcjFBV2Bf2A+zp4VCowtO0VoXUDpf6jywhaI3b9P0=;
        b=EQwA2US/XPwt7SeWRRvGK3NjMECewDxjFAZE4Dl039LI/hcJzx2ozuJu+KuPPaF+Gv
         1wQ/nrCY25sE+HP7ka4FoX+Z3IY5lpYxH+T4axLMxxES7EjQErgqJUwF+zhhMZzd/CH3
         yn1XbAfM7C1qH4bjYvXzfoHDZ7AkMefMOdA+WJjOmIt6JQN5VGSkXCUWbdq47bX3UYSF
         Ft3ttGixk/47cPXeUJkcuyc23OOEFgAT2hbAA8XvTIOHKkhEmuahapG+AQJjuZg0LvYY
         CODHaQpQ5b7WVeiL3UPtpfSbeqC+hSB9dpqcrrxQyBXuBhR1An2Qyh0lTspY7GWzzeCP
         LcmA==
X-Gm-Message-State: AAQBX9epYgZWTLke4MupWg58XLTGhuXvAqMuRYJsRxGg3qy7TYj8RkIK
        aSTD6NMYGuRKSU10LWFUksc=
X-Google-Smtp-Source: AKy350bH9quWl48CyBEK2jXmqe17A0UwrjOLuRyrTJSkFzz6IW+pfSpvPUEigQ04BONESA8FYnRsWQ==
X-Received: by 2002:a17:90b:1b4a:b0:241:b90:4a1c with SMTP id nv10-20020a17090b1b4a00b002410b904a1cmr7863663pjb.44.1680725027654;
        Wed, 05 Apr 2023 13:03:47 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:84b8:1620:d3a4:f59c])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090aea0700b00240dee12285sm1761903pjy.34.2023.04.05.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:03:47 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8904: Convert to dtschema
Date:   Thu,  6 Apr 2023 01:33:41 +0530
Message-Id: <20230405200341.4911-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the WM8904 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 66 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8904.txt      | 33 ----------
 2 files changed, 66 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
new file mode 100644
index 000000000000..78d76c1c1326
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8904 audio CODEC
+
+description: |
+  Pins on the device (for linking into audio routes):
+      * IN1L
+      * IN1R
+      * IN2L
+      * IN2R
+      * IN3L
+      * IN3R
+      * HPOUTL
+      * HPOUTR
+      * LINEOUTL
+      * LINEOUTR
+      * MICBIAS
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - wlf,wm8904
+      - wlf,wm8912
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "wlf,wm8904";
+            reg = <0x1a>;
+            clocks = <&pck0>;
+            clock-names = "mclk";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
deleted file mode 100644
index 66bf261423b9..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8904.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-WM8904 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-  - compatible: "wlf,wm8904" or "wlf,wm8912"
-  - reg: the I2C address of the device.
-  - clock-names: "mclk"
-  - clocks: reference to
-    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
-
-Pins on the device (for linking into audio routes):
-
-  * IN1L
-  * IN1R
-  * IN2L
-  * IN2R
-  * IN3L
-  * IN3R
-  * HPOUTL
-  * HPOUTR
-  * LINEOUTL
-  * LINEOUTR
-  * MICBIAS
-
-Examples:
-
-codec: wm8904@1a {
-	compatible = "wlf,wm8904";
-	reg = <0x1a>;
-	clocks = <&pck0>;
-	clock-names = "mclk";
-};
-- 
2.34.1

