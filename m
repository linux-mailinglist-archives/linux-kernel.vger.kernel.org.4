Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B791266D084
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjAPUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjAPUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83A2B2B2;
        Mon, 16 Jan 2023 12:48:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so28610857wrz.12;
        Mon, 16 Jan 2023 12:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qQ8r5klQKZOPNxZmvUkgfn+XujAPPGh9PdCcXs4m7c=;
        b=TdR2L9dWbWTBiPlXImP1DoGTKyxgOW14Mg/6kTwPpsq/iPYmkz3DAEIPmJ4RuPkow2
         4bQBV/LjGERV58vz1T8flBK531C4yIyw90ekaNd4dSOHZ5O0aaar+Bizb196WEvykGkY
         IBgIG4Ur9F28ptLsbEWmHLMVY6Bnu/i0u/KKfG0E6VtGehufpjbapZ+2ejDf13LPERfW
         p6xX4cKQjMhiJ9r2YAnyQZtcqn2cRRJOHDWsgUnJMsaRsDjZMfNHgWlTlhYeSctg2duo
         iHm0KAJouvYCMzvu/nE5denFWQoFoXRa02ZwD7+CpJXbdFBa18KYh5ew47ehrRKwTdvL
         Ky/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qQ8r5klQKZOPNxZmvUkgfn+XujAPPGh9PdCcXs4m7c=;
        b=vbkoMIVNBqyJvKZkT4+8q7qrb8sIrdND3ceAxI1B1s24MGOcBRytEbBI9U20L446rA
         dU/GMpphlyLgpScaGatPDseJXl2lXr8hISGiP/Ck2Aoo913vIpCnN4/oFj+1AWRD53t6
         /fXdPLrs8IdVgZmMSMD0up3NvdfqyPSRbJBwyaGQ70a6aI2sPtbYkzkxHJAXJ/lRosT1
         mBfQCmP4UgM5JPD82FaLwFXQLATwZlmzOFGMzRxclneArwtD+6r3CBqYh0kQd/5/4YfM
         tjxWeZ/NIo7N6Ptr0INfnQC/jL3J4hUF1+GoeTpOyYRyvdD2U1uSTn6RaXxJ09ipGLRS
         vOOA==
X-Gm-Message-State: AFqh2krbsCN0my6QrtrXj+LFk/rQXNI+FvtRzL4T4F/PR87UXMpdaMqY
        887X/HuWsQB2KtIckaExH84yrHuLcek=
X-Google-Smtp-Source: AMrXdXuGpTcrmhS56zZTqWNNoR3UgBKGuP8a30rrGqoou/XA+wrevx/SEczwki139FyYL1mRYSEtng==
X-Received: by 2002:a5d:4ac4:0:b0:2bd:d6bd:57c7 with SMTP id y4-20020a5d4ac4000000b002bdd6bd57c7mr8873668wrs.12.1673902079079;
        Mon, 16 Jan 2023 12:47:59 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:47:58 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/7] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Mon, 16 Jan 2023 21:47:45 +0100
Message-Id: <20230116204751.23045-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,krait-cc to yaml Documentation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
deleted file mode 100644
index 030ba60dab08..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Krait Clock Controller
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-			"qcom,krait-cc-v1"
-			"qcom,krait-cc-v2"
-
-- #clock-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 1
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the clock parents of hfpll, secondary muxes.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
-
-Example:
-
-	kraitcc: clock-controller {
-		compatible = "qcom,krait-cc-v1";
-		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
-		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
new file mode 100644
index 000000000000..8caa5a677394
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Krait Clock Controller
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
+  rates.
+
+properties:
+  compatible:
+    enum:
+      - qcom,krait-cc-v1
+      - qcom,krait-cc-v2
+
+  clocks:
+    items:
+      - description: phandle to hfpll for CPU0 mux
+      - description: phandle to hfpll for CPU1 mux
+      - description: phandle to CPU0 aux clock
+      - description: phandle to CPU1 aux clock
+      - description: phandle to QSB fixed clk
+
+  clock-names:
+    items:
+      - const: hfpll0
+      - const: hfpll1
+      - const: acpu0_aux
+      - const: acpu1_aux
+      - const: qsb
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "qcom,krait-cc-v1";
+      clocks = <&hfpll0>, <&hfpll1>,
+               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
+      clock-names = "hfpll0", "hfpll1",
+                    "acpu0_aux", "acpu1_aux", "qsb";
+      #clock-cells = <1>;
+    };
+...
-- 
2.37.2

