Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360B5B5017
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIKQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiIKQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:47:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289902250A;
        Sun, 11 Sep 2022 09:47:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s10so7330408ljp.5;
        Sun, 11 Sep 2022 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ty9xhUZrdzCp9f/9JoXoK+1CKaC1Gh77yxXsJpfOxa4=;
        b=ZE/XClz2KntijLvzZ9Y+iIk8Kgy+KfwH/5MxNBfwWqnvkBvpHNNwbjWUTr+6HB0goa
         j6CNsinRc0Lze4hiJL/hST1G/SGGbiwKajvZNVaORseEBo9pNXB7ZDC0ezmlX/e8X4ei
         VvurTUPF45joJncH6PmZgIww3SweEUb/FGu7iiZzdGzUupAF6wu7ekd8LrcgLCTW6EpL
         Tf65uztXrxNfwZ+0JlRxLiW2+cSqLEPDBmKn8hW+0+XMgUfLyXgX/oxIqRSVKwwVOprs
         niVY6Vg4b5bz1zTEoZGJvgzjnEUsXNYwUuv0irwHm9QpIv5pTpd/dPuwDryLFc1/gWoz
         95Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ty9xhUZrdzCp9f/9JoXoK+1CKaC1Gh77yxXsJpfOxa4=;
        b=m3QA+nY2rrlEWdKYw468mTxjJT7wThVPoukKNrF3aIh6FL53SEDyHOrRWopMpp/L43
         OvwsVrb3G5xrAsYUgctTbbq1izuFJjJPE+7RhDj+QnDiSHiU+zDWAAiDivyORKT9S7Zo
         +2uP5dbw4nnu2EMKjTmQBRQagbcNZEH+uhvwLyD4wMd9vqG+2kOyDDdS92RS52Jr10J8
         gHEDowptR9q9UlSE7Z6hKL9+sFGyqGeJ+h+9n6SQgYt4UZ9+9KfEivSThdXVTwFYHnvs
         itA+nxaptt9/7a8DzO7RgX4CpHHmP3VODzKc5L2zOoy2C23oz/+J5L3B11T2n7Q7Onr3
         LfAQ==
X-Gm-Message-State: ACgBeo19w3SudA3X7GoIGn0NH6uRL7NWaBiFQt8EGew1fOoC/rEoEn6/
        wDtd+ErfDHehNRMcckr3sL0xGc+H1Mo1RA==
X-Google-Smtp-Source: AA6agR6Or3TJTmo6Q7JlJ/ycJyKrNSjUIraAbzeLUYzOSiGP2ARqEMnpdgwnTaVXnMf8nmE1jUcqeg==
X-Received: by 2002:a2e:3c0c:0:b0:26c:2f4:afb1 with SMTP id j12-20020a2e3c0c000000b0026c02f4afb1mr824070lja.529.1662914869542;
        Sun, 11 Sep 2022 09:47:49 -0700 (PDT)
Received: from localhost.localdomain (adld177.neoplus.adsl.tpnet.pl. [79.185.7.177])
        by smtp.gmail.com with ESMTPSA id h1-20020a0565123c8100b004979e231fafsm664501lfv.38.2022.09.11.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:47:49 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: clock: add QCOM SM6115 display clock bindings
Date:   Sun, 11 Sep 2022 18:46:18 +0200
Message-Id: <20220911164635.182973-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911164635.182973-1-a39.skl@gmail.com>
References: <20220911164635.182973-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for display clock controller for
Qualcomm Technology Inc's SM6115 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/clock/qcom,sm6115-dispcc.yaml    | 70 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6115-dispcc.h    | 36 ++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
new file mode 100644
index 000000000000..a6bf363b5015
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6115-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock Controller Binding for SM6115
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks and
+  power domains on SM6115.
+
+  See also:
+    dt-bindings/clock/qcom,sm6115-dispcc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board sleep clock
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: GPLL0 DISP DIV clock from GCC
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+    clock-controller@5f00000 {
+      compatible = "qcom,sm6115-dispcc";
+      reg = <0x5f00000 0x20000>;
+      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+               <&sleep_clk>,
+               <&dsi0_phy 0>,
+               <&dsi0_phy 1>,
+               <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6115-dispcc.h b/include/dt-bindings/clock/qcom,sm6115-dispcc.h
new file mode 100644
index 000000000000..d1a6c45b5029
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6115-dispcc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
+
+/* DISP_CC clocks */
+#define DISP_CC_PLL0			0
+#define DISP_CC_PLL0_OUT_MAIN		1
+#define DISP_CC_MDSS_AHB_CLK		2
+#define DISP_CC_MDSS_AHB_CLK_SRC	3
+#define DISP_CC_MDSS_BYTE0_CLK		4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC	5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC	6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK	7
+#define DISP_CC_MDSS_ESC0_CLK		8
+#define DISP_CC_MDSS_ESC0_CLK_SRC	9
+#define DISP_CC_MDSS_MDP_CLK		10
+#define DISP_CC_MDSS_MDP_CLK_SRC	11
+#define DISP_CC_MDSS_MDP_LUT_CLK	12
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK	13
+#define DISP_CC_MDSS_PCLK0_CLK		14
+#define DISP_CC_MDSS_PCLK0_CLK_SRC	15
+#define DISP_CC_MDSS_ROT_CLK		16
+#define DISP_CC_MDSS_ROT_CLK_SRC	17
+#define DISP_CC_MDSS_VSYNC_CLK		18
+#define DISP_CC_MDSS_VSYNC_CLK_SRC	19
+#define DISP_CC_SLEEP_CLK		20
+#define DISP_CC_SLEEP_CLK_SRC		21
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC			0
+
+#endif
-- 
2.25.1

