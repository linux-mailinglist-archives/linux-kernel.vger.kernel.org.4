Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37168F6F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBHSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBHSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:34:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0691523D83
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:34:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so17730149wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUXjhDhmgVyOnb0RLYblg25oIh4RJoZ6OJE0zKdx/T0=;
        b=NgxRe12LYBN66oI6Xy6VkY65AjdSLVclxt0WwxT1+MIgulJ5xr2E7SMDheEaahwfPl
         1g656UhrpeE3dMknMY3oiaryMGj5tjd7zPDzTtUTQ0i/uSclGVwVO6FAWNmoYdaFKotd
         +jlIMVdJZvkq7KRz/Q6Tw/DVkCGHmK2obbvNglf7ADvFjlCZ+o1ar/qpMus16ET5CY0f
         oFQoSNe0RBGgJegNpxokhhWMXaaWNGdgC6fOvEa8PP65TEjDB/uCeysp5FdHekYcldqZ
         tPvFaMzeq4Xz3p0ZhNVW9XZnJFA0aWKC2k7HvdPpqW8dLT3OqO0A69al0nPZlL2fOZYF
         4bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUXjhDhmgVyOnb0RLYblg25oIh4RJoZ6OJE0zKdx/T0=;
        b=6eZn2vvdb/X+Hguat+WYfTMpbh0lEgjXPPcTGtrFds7+CDljRHt6D+0zjl76PuwJP9
         hnX9xRb1T+KiQxSpWc0DfXBtJDJ5c1CjWnCgYBA1aJ0TDytQ5r3r2hyVPlFi/AVJOwvU
         m0R6UecFxZmnnEZt5WAwL2jS3WMI2qJa5rmyVHwp6lfjtvb7w8jgSBtklxzcj5BvAqlM
         CoCNSnncyCzpEb4/z7BjQ0FaQCaijAXPQ+Kvpl85JNAEe4iy2wwFoTnnRZUjcSAPqGO9
         Tn7QsgvZs33HyiGPqPBED7fnr35Dz3/Z9D1iuUsTL3KkLv3reouCMaqBPjWyQtqrfCG1
         av+g==
X-Gm-Message-State: AO0yUKWUY1HpqKuyvlt3yh6LMccx6TdvuNYg+TMTeNlolEy5NeiXh/WV
        HKtZ+syFKQPn8sIwbLz9RfZfug==
X-Google-Smtp-Source: AK7set/3jJJ89HDqmC4FF0jPaElw9vj0s7cmAz6Y9a2GqsOXfS0EbuBH6BhFGEDzxjhvj9c8pb/m0w==
X-Received: by 2002:adf:f586:0:b0:2c3:db9e:4aef with SMTP id f6-20020adff586000000b002c3db9e4aefmr8392374wro.45.1675881275599;
        Wed, 08 Feb 2023 10:34:35 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v1-20020adf8b41000000b002be505ab59asm14591304wra.97.2023.02.08.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:34:34 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/6] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Wed,  8 Feb 2023 20:34:16 +0200
Message-Id: <20230208183421.2874423-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208183421.2874423-1-abel.vesa@linaro.org>
References: <20230208183421.2874423-1-abel.vesa@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

The v5 version of this patch was here:
https://lore.kernel.org/all/20230207114024.944314-2-abel.vesa@linaro.org/

Changes since v5:
 * added Rob's R-b tag

Changes since v4:
 * none

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

