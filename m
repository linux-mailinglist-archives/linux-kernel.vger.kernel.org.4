Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9917B687E90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjBBNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjBBNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:25:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB48D409
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:25:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1373682wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4nzyARZIT5i7ouqU6zm4IdSHZXgc31pmaeYmYVbTxo=;
        b=edWm92Yyv5rpe0OMlXAGEqX9M7qPhSHvx8rRM3NrQvxE3juveK8cHgBusvXG615lGl
         lTsNI1COW0Yk1CHplrOfeCj1oc7jAe/SUoZGBT6JEvrjqo0F2UxaKT9KUCnOcRJmT2iY
         VPpFcZBQvipAmmtDi20wNFcETX8DvZ6FFtShLJUVYOvXNHOw67Bz0T9j6ex8jUt9jKNO
         QVm6ZhOHIRn8Px53zlMyDCXG/dumGNgopxXVwiEAe2F9oaUH/Lp6NQmfKQAICU7D0CfM
         g96NOAxOF2Kaz7kISli93v+OjGZb53GGArMKXZPjjtBBwhGt/P3xJtrOqb5z4UPabMvY
         DZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4nzyARZIT5i7ouqU6zm4IdSHZXgc31pmaeYmYVbTxo=;
        b=Jd4rMkiLtW6ZVjHF9ewp0RBVqKuaXCl48wg0w3qCIvxPXYdiLBCrPPmobgTRXEY0Ay
         uPZZM3CbS8uTMUsKDsSJU84ffJwXPFXmmRsO/z+ua0VodLEfKNjpwQtefqQaA7OBjDJ/
         +8EJBN2ylBBCCExU7n6lDCOedBBhI+ki5/WEpLN/IFvRzjIwVDdNwsfsWd9eqQ6lc1Ia
         Ly1gRjlvC8QZ+vrcevzUFkAFuCVllzEKSCHHpt7dbtGqiSexOm3uC7hDJwXDOeghWB3J
         5hh2ICyX8AeT3xIIsJ8GU9EB8OAGI4ZYY3+h+Oo5FslTzIxhogFomvrsJKnXNQ6mgFKZ
         3i7g==
X-Gm-Message-State: AO0yUKVc8GMuWHcXi+4wxHt/FU8iMGbrPQ/brF4stcqMJdGjks2hMw24
        Ovg6lXNQQQCi6ql7KXa0CcBeWg==
X-Google-Smtp-Source: AK7set/oOtvBEcXPpH5zeExLI+TqxHKlGL5dOV9fGiNzrYmpI7B1dGpyB8EKAwBYhmMfl3Xl6Bjh4A==
X-Received: by 2002:a05:600c:4e4e:b0:3d2:bca5:10a2 with SMTP id e14-20020a05600c4e4e00b003d2bca510a2mr5804230wmq.22.1675344315624;
        Thu, 02 Feb 2023 05:25:15 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c449600b003db06224953sm4690943wmo.41.2023.02.02.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:25:15 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/8] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Thu,  2 Feb 2023 15:25:04 +0200
Message-Id: <20230202132511.3983095-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202132511.3983095-1-abel.vesa@linaro.org>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
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

The v3 version of this patch was here:
https://lore.kernel.org/all/20230126131415.1453741-2-abel.vesa@linaro.org/

Changes since v3:
 * removed blank line, like Rob suggested
 * dropped quotes and reset description, like Rob suggested
 * dropped the RPMH_CXO_PAD_CLK clock and the ref_src clock name
   to match the schema
 * fixed filenames of the includes in the example (sm8550-gcc and
   sm8550-tcsr)

Changes since v2:
 * none

Changes since v1:
 * dropped the "ref src" clock
 * dropped the usb-repeater property

 .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
new file mode 100644
index 000000000000..de72577e34a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,snps-eusb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
+
+    usb_1_hsphy: phy@88e3000 {
+        compatible = "qcom,sm8550-snps-eusb2-phy";
+        reg = <0x88e3000 0x154>;
+        #phy-cells = <0>;
+
+        clocks = <&tcsrcc TCSR_USB2_CLKREF_EN>;
+        clock-names = "ref";
+
+        vdd-supply = <&vreg_l1e_0p88>;
+        vdda12-supply = <&vreg_l3e_1p2>;
+
+        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+    };
-- 
2.34.1

