Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40872B22C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjFKOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjFKOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17B10CF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7f4819256so24999895e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492232; x=1689084232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffPBlAj1+1XHbbG8ux/mThYwqkSCxXqYmL1NmIDot1g=;
        b=j+NCiXNleciI9NeL2kkyGHDX1HndsDa+Pengp6as+6HIpyDXins5MfKcBngJNdUWDK
         JR6I+QYNr/AqJZ7ly3fSUcAeti65KI2ErVtVoaUtqvXRZ5HKr71/5W9BifG/65Zvq9Ua
         mvburv30OhBirqC8I14PYF0ZPWxxsKULIaiErrvjY1zG6B47aFmFvVgF2KTTA+s0hMS1
         CsQRgO4Cq1pEN5BPMjQG9/rjTL0o5aYhEBkiGCPMY+1WOP4KuumrdDq7U7nljbZDz0PH
         TlEZs0EE/W7aaw+2TBUURdWUewaH9DgTuXG626rFR/bjor7Cx7h8vPuYPE+gsKhjMa7K
         O+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492232; x=1689084232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffPBlAj1+1XHbbG8ux/mThYwqkSCxXqYmL1NmIDot1g=;
        b=h+UNsl2l2qesKFpaPs6JVti0BoxvenWzzdgXLtefod3Msv+TxiCpC7xxcoIAKGBynq
         AwYY1P2h7IygRUSSD4rMi8kNgUsBa55zs53XCnmiC/+HexGlDbaSJDqFcI9SdHuWoL8b
         8EiTgOZegx2PDERIfalSEekGt0EypkPXQqyV+zVUhJE1XMEJtiTMD18lhAl9NDDFbKKk
         IlmUXOmJFmKTAb61XePG9DM9ujXitEAQqs9sX4Gngnxmj9f6z8iTpl6Qa5cWB3swewPc
         R3CCpedDxHFcJpQsJAWAEfyQZliFzTtCRA02QCd/KhH8MqL+ap0MT7KojY82AQoH1Xze
         EzAw==
X-Gm-Message-State: AC+VfDzITCgGrY0eHYlt0Fwo/gObIx6JtORfelZp7l26AlE8g6nrfY1K
        EQLhNzi7A41m14elrh2blLBPXQ==
X-Google-Smtp-Source: ACHHUZ4wpXA3JyhcbA2eK3TGz5fffIDKzuEXyvYzb9v1XhCucmCj+/XkeJPoZdlkzh73/Gu0TG4RRw==
X-Received: by 2002:a05:600c:2190:b0:3f7:395a:c9fa with SMTP id e16-20020a05600c219000b003f7395ac9famr5198158wme.4.1686492232538;
        Sun, 11 Jun 2023 07:03:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/26] dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
Date:   Sun, 11 Jun 2023 15:03:11 +0100
Message-Id: <20230611140330.154222-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Convert the Rockchip OTP memory bindings to dt-schema.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/rockchip,otp.yaml          | 82 +++++++++++++++++++
 .../bindings/nvmem/rockchip-otp.txt           | 25 ------
 2 files changed, 82 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
new file mode 100644
index 000000000000..4cd425ae2823
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/rockchip,otp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip internal OTP (One Time Programmable) memory
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-otp
+      - rockchip,rk3308-otp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: otp
+      - const: apb_pclk
+      - const: phy
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: phy
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        otp: efuse@ff290000 {
+            compatible = "rockchip,px30-otp";
+            reg = <0x0 0xff290000 0x0 0x4000>;
+            clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
+                     <&cru PCLK_OTP_PHY>;
+            clock-names = "otp", "apb_pclk", "phy";
+            resets = <&cru SRST_OTP_PHY>;
+            reset-names = "phy";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            cpu_id: id@7 {
+                reg = <0x07 0x10>;
+            };
+
+            cpu_leakage: cpu-leakage@17 {
+                reg = <0x17 0x1>;
+            };
+
+            performance: performance@1e {
+                reg = <0x1e 0x1>;
+                bits = <4 3>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt b/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
deleted file mode 100644
index 40f649f7c2e5..000000000000
--- a/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Rockchip internal OTP (One Time Programmable) memory device tree bindings
-
-Required properties:
-- compatible: Should be one of the following.
-  - "rockchip,px30-otp" - for PX30 SoCs.
-  - "rockchip,rk3308-otp" - for RK3308 SoCs.
-- reg: Should contain the registers location and size
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Should be "otp", "apb_pclk" and "phy".
-- resets: Must contain an entry for each entry in reset-names.
-  See ../../reset/reset.txt for details.
-- reset-names: Should be "phy".
-
-See nvmem.txt for more information.
-
-Example:
-	otp: otp@ff290000 {
-		compatible = "rockchip,px30-otp";
-		reg = <0x0 0xff290000 0x0 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
-			 <&cru PCLK_OTP_PHY>;
-		clock-names = "otp", "apb_pclk", "phy";
-	};
-- 
2.25.1

