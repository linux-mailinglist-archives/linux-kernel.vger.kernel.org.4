Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC10629E44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiKOP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKOP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:58:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638D2ED45
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:58:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s5so6288092edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGWW/MIEHrCQNewHhRIGxXTQAeOC4rpUnCL7BHFVFTI=;
        b=Lwa63gbzI5j9Db9s8Tqo3pXxDn8bTBGC+950ifG8Uz2bpbSF1oscH0frYnjYaR0ERK
         rDu3aYe+mm6brSi6rKtOcMBnJ9aG/H3G7JvqcGPn5GtdshRIgHy4g4hmF93ikZW4SVpA
         S69zH9z1s3Vfgxx16h6OQrZY0S7AR+Yso0IeaJmQNX5kFV8kpYNKE7Ru9QSKuorHdyes
         NwIhpnoBQbknI85fF5KIuFzVVcERf1c4v97jTRYlWJo4cyXXG+10oHZZCiVMEScM5el/
         Gcl3jjD1tQCTTPVPgNU+lFj2mHwYv2xlruI3BlcfDHuMW5E1jPCPWAP1d+3absNiOqGs
         aVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGWW/MIEHrCQNewHhRIGxXTQAeOC4rpUnCL7BHFVFTI=;
        b=Z2wM4fjNdTUfaP1RzcnMBvVVGBTr2LbhuqQFQsP+9SrZuV4itok7IO683IfOkn22kn
         gLxettgh7k3K9PU6sDMttDvg6GNaKqBeRgOb/QJ8H9sm85dI/Rw9t/Fa29eeAzPVR3wx
         lmRB27eyBIZEfzMsw7qPcd84ml/kU1og45VQ6h5RLz4GTHWfQ7AC6owaWhjam0JFX7ZI
         nCy3SWjcBSh8yJVw7+IJZavdP8Kyjvw4z0T/C9r2SqqoHRoQtLCxCHP9Iq937kGLH2Xg
         kXvTYxTj/1tcVf0Q8B1lrrgHB+HdKBUUtAnmpD8vcEve3lY9ZG0loiUEkImsH1F5TiOD
         88Ig==
X-Gm-Message-State: ANoB5pkLRUbbbIYSuCmBfD7MADpmrtvlALPgQEmLRLD/v9K35Cl8qzp7
        O5QSDJ8JZCvCJ6YOZG+KSISP9w==
X-Google-Smtp-Source: AA0mqf7luJopzkTusEkfEOC8tAcynClaHNm8M2ztZoZ1CBg7umddLW94rNC65M0BYZxMvfKkgbqhTw==
X-Received: by 2002:aa7:cd15:0:b0:458:5987:7203 with SMTP id b21-20020aa7cd15000000b0045859877203mr15005315edw.161.1668527896175;
        Tue, 15 Nov 2022 07:58:16 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0077b523d309asm5648085ejc.185.2022.11.15.07.58.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:58:15 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: add QCOM SM6375 display clock bindings
Date:   Tue, 15 Nov 2022 16:58:04 +0100
Message-Id: <20221115155808.10899-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

Add device tree bindings for display clock controller for
Qualcomm Technology Inc's SM6375 SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Switch to dual licensing in both files
- Adjust the wording with the recent refactoring
- use qcom,gcc.yaml for common properties

 .../bindings/clock/qcom,sm6375-dispcc.yaml    | 54 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6375-dispcc.h    | 42 +++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6375-dispcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
new file mode 100644
index 000000000000..183b1c75dbdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6375-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller on SM6375
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm display clock control module provides the clocks, resets and power
+  domains on SM6375.
+
+  See also:: include/dt-bindings/clock/qcom,dispcc-sm6375.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm6375-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 source from GCC
+      - description: Byte clock from DSI PHY
+      - description: Pixel clock from DSI PHY
+
+required:
+  - compatible
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    clock-controller@5f00000 {
+      compatible = "qcom,sm6375-dispcc";
+      reg = <0x05f00000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+               <&dsi_phy 0>,
+               <&dsi_phy 1>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6375-dispcc.h b/include/dt-bindings/clock/qcom,sm6375-dispcc.h
new file mode 100644
index 000000000000..1cb0bed004bd
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6375-dispcc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6375_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6375_H
+
+/* Clocks */
+#define DISP_CC_PLL0					0
+#define DISP_CC_MDSS_AHB_CLK				1
+#define DISP_CC_MDSS_AHB_CLK_SRC			2
+#define DISP_CC_MDSS_BYTE0_CLK				3
+#define DISP_CC_MDSS_BYTE0_CLK_SRC			4
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC			5
+#define DISP_CC_MDSS_BYTE0_INTF_CLK			6
+#define DISP_CC_MDSS_ESC0_CLK				7
+#define DISP_CC_MDSS_ESC0_CLK_SRC			8
+#define DISP_CC_MDSS_MDP_CLK				9
+#define DISP_CC_MDSS_MDP_CLK_SRC			10
+#define DISP_CC_MDSS_MDP_LUT_CLK			11
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK			12
+#define DISP_CC_MDSS_PCLK0_CLK				13
+#define DISP_CC_MDSS_PCLK0_CLK_SRC			14
+#define DISP_CC_MDSS_ROT_CLK				15
+#define DISP_CC_MDSS_ROT_CLK_SRC			16
+#define DISP_CC_MDSS_RSCC_AHB_CLK			17
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK			18
+#define DISP_CC_MDSS_VSYNC_CLK				19
+#define DISP_CC_MDSS_VSYNC_CLK_SRC			20
+#define DISP_CC_SLEEP_CLK				21
+#define DISP_CC_XO_CLK					22
+
+/* Resets */
+#define DISP_CC_MDSS_CORE_BCR				0
+#define DISP_CC_MDSS_RSCC_BCR				1
+
+/* GDSCs */
+#define MDSS_GDSC					0
+
+#endif
-- 
2.38.1

