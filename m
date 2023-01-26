Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF367CB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjAZMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjAZMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:47:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656426227B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:47:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so1057817wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjmcWStl2IK8Csyv+ogApgFtuhkeFvtifhYRNf2NN2I=;
        b=kzjvcAcAB2RjA9S5XCpP7nHDFDr7BuTfnVSOLmo6KgowHfAFalacR5ofYf87fLc1cQ
         TDVy870YjmZjvDx10A4pmaelSqJXEXT+RZmPQ5+vKYNxiWvYcELNCDIpXtszCc5rmehP
         oycdFLWLIyVet6m1rzauYnIvJWxH82QGeceIUKXxaw1XS+R8p8+lxpBeaY7Mx5IVQ58e
         tMwvS36vS9oHC6GTb0n6l7Rbzu8BXnFxdeYojubLE+pDb2UwYPNRNkSjfJC1FuLAQHrn
         GEi0i46Vv0aqiEvSOU0YhVyAGqRMApkYkWja6yNKUuub5dJK6U/6jEso2N0vJRrbBn0b
         RGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjmcWStl2IK8Csyv+ogApgFtuhkeFvtifhYRNf2NN2I=;
        b=DsuNkfVef9yh3zIDe3t+zsqUt+uj+sv8maEFwezSI95F3Cca96xa2LzI6Y1qLLJnsr
         GIjzbfz7V6PfRJrSsVmeAWZGtydGKJjAFP/dX+3zJ62jGmckZhCClhbxW9lxemS+4TeT
         Zbm76wBtK7cp+m0ZzMdg5hYF3t1SAae8RsPZNJUudZI6HJYc0qXCycmF7UaZ1QuOzDL2
         kMly8e2ipXdvwzV9OCjrWTZiQfkmBpb3ktAt2y6Om+s0ZdmNHcjny4cktt1dLv3u4xbV
         iYWDR462aTRuQ+PKueF+VoIu7v5j1srtbAG91NGCXLyw+tkp5wkp5aEAZrJuTxicO9E1
         vsTQ==
X-Gm-Message-State: AFqh2kruy9GNs+UzqRhF7xMcoDoALa0J105Nn3KbUY9DDZI5+yTy/Syr
        YJgZjDA2l38NEia2vwZAkivjcw==
X-Google-Smtp-Source: AMrXdXsr/oD5McSggzW4QbpaCFefSS/ge1kqNAbrsKAOykCF4kgn2GXYcE4oS6NJo48qFaXxzQnyaA==
X-Received: by 2002:a05:600c:5028:b0:3db:1dea:75c9 with SMTP id n40-20020a05600c502800b003db1dea75c9mr27352292wmr.28.1674737218879;
        Thu, 26 Jan 2023 04:46:58 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b002bfb8f829eesm1198681wrp.71.2023.01.26.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:46:58 -0800 (PST)
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
Subject: [PATCH v2 1/8] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Thu, 26 Jan 2023 14:46:44 +0200
Message-Id: <20230126124651.1362533-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126124651.1362533-1-abel.vesa@linaro.org>
References: <20230126124651.1362533-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
for the new driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v1 version of this patch was here:
https://lore.kernel.org/all/20221116120157.2706810-9-abel.vesa@linaro.org/

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

