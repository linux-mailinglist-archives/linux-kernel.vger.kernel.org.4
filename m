Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A267CBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjAZNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjAZNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E2D5DC3F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l8so1089968wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8aVTxzWn1UixQJuXT/p8bVFkzgfvSz7e0kUvSVzVNM=;
        b=vfa+Wv47xDD5N44ame85qOABQIuhcW5F6QP8QrJVUDCzOXjS7fnancY0ojaFM+x14O
         ANOMRqi1TIMikABYJ+TzRiJH8wbYr70H3w7so0uKeJqCWH4UKZOo/PYzC3Bfdko07C+Y
         I9DL1//vT7BKAu0l/1uVrCV7rpolV7Qc8TMig+WFJRqEWekWrfmhDU6Bu4g4NL1LPq66
         G7g4gGn5F98htr4u1IP17rTn85Ur4VrAUzIWDm15Dz5X9WxIQVzepoSb5BEaFwZktDBW
         9qDx94sRBMvLKSQMcvGi1hBvqLSxJzUChalshlngotbOZwQnQRLq0F5prQaFZfbkptXJ
         2NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8aVTxzWn1UixQJuXT/p8bVFkzgfvSz7e0kUvSVzVNM=;
        b=SkpRa5WXPKsd+puEDIUMiy8a0ACH31EsGQIW26DwcsdPd+pAkjoF5qYjzi+qqXXjfL
         PLhNDGJ1pcOj48v9Igl9u9mjEOJajT7wwksH3BNowK02bJ9bq7/Z66Pl2EH4Z8NYFfxA
         TIs6zYqNf//4sar0QQj4p1K9E2OxeX1cI7jgNf+lv+wV3QZ/vBqG54dOA7y5ZwNSVf6l
         nIxZYP6HhxN1qF0Bg5VY3HooR4sJR/fBlFDPxng4KYnqaMlq2qayzd1wlVy21fBByBSB
         y2arox1j3lxFYrHhEbHAzut2mg8Uj9VQoQEC56wYUCdhCxVwYA5x4XBPNmE+YJqLteiC
         j+WA==
X-Gm-Message-State: AFqh2kpZLRhECdIs+N4G1Rd2cjjF9xDit3XVQUaoX/y2aF8iYW2zExra
        FphVDuNNQ2anmwhwvGMbZrvImQ==
X-Google-Smtp-Source: AMrXdXtzde+unOWbFn9P6rtGSe12ZvQaPKTxAXxHHcUapQ+Y63I46+FycM+w1q/FD9AFNMEClsL8Vg==
X-Received: by 2002:a05:600c:43d3:b0:3da:fbcd:cdd2 with SMTP id f19-20020a05600c43d300b003dafbcdcdd2mr35942889wmn.9.1674738860450;
        Thu, 26 Jan 2023 05:14:20 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c26d200b003da28dfdedcsm1719804wmv.5.2023.01.26.05.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:14:20 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v3 1/8] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Thu, 26 Jan 2023 15:14:08 +0200
Message-Id: <20230126131415.1453741-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131415.1453741-1-abel.vesa@linaro.org>
References: <20230126131415.1453741-1-abel.vesa@linaro.org>
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

The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
for the new driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v2 version of this patch was here:
https://lore.kernel.org/all/20230126124651.1362533-2-abel.vesa@linaro.org/

Changes since v2:
 * none

Changes since v1:
 * dropped the "ref src" clock
 * dropped the usb-repeater property

 .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
new file mode 100644
index 000000000000..49a5dad486c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,snps-eusb2-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm SNPS eUSB2 phy controller
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description:
+  eUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
+
+properties:
+  compatible:
+    const: qcom,sm8550-snps-eusb2-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: ref
+
+  clock-names:
+    items:
+      - const: ref
+
+  resets:
+    maxItems: 1
+    description:
+      Phandle to reset to phy block.
+
+  vdd-supply:
+    description:
+      Phandle to 0.88V regulator supply to PHY digital circuit.
+
+  vdda12-supply:
+    description:
+      Phandle to 1.2V regulator supply to PHY refclk pll block.
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - vdd-supply
+  - vdda12-supply
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8550.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,tcsrcc-sm8550.h>
+
+    usb_1_hsphy: phy@88e3000 {
+        compatible = "qcom,sm8550-snps-eusb2-phy";
+        reg = <0x88e3000 0x154>;
+        #phy-cells = <0>;
+
+        clocks = <&rpmhcc RPMH_CXO_PAD_CLK>,
+                 <&tcsrcc TCSR_USB2_CLKREF_EN>;
+        clock-names = "ref_src", "ref";
+
+        vdd-supply = <&vreg_l1e_0p88>;
+        vdda12-supply = <&vreg_l3e_1p2>;
+
+        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+    };
-- 
2.34.1

