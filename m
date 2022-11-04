Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63689619E16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKDRGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:05:58 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8966B3E08D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:05:57 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x21so3475893qkj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmgwhFKSfmRVfZGc4RFN5XxR8b40r2de6Oo0rq1T4LM=;
        b=JbUTll5MUjsFEpb6RFMbBc3v4wZC7nXCGMHb5OK0Dj1brJXpSu1B6bkm7Y7U9ncuKG
         iqnkdFnjDpJ/4iU0uVw5784Yk5pIFbYFFk7YLX74gaga3r1+BZWyM8k/tte7jaoZfLp+
         SlEYGRI1opxkZ1YRf0Y4i8oWvqEnxRFm1RUa5eAOVfW4YOseCzkAaRrueQgSzuEEILvk
         i9eEPWx2w/roHu+WfzQFQEo2ebRYbXiUsIeEZxCb/+ZMK51rTc/95nl1+OfG4qFyIvkk
         nOUuPaSW/ZFDusLt/V5JBCTDb231pwqVnE35hOL+wY7KG8B6OE9IbAc/plX1LmlgWrEp
         VTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmgwhFKSfmRVfZGc4RFN5XxR8b40r2de6Oo0rq1T4LM=;
        b=R5yuonUozwdPM1jy5p5j4yb2xphvN3xeKDlFX1S6irIehIGrgxz8fbFYKqvTNd+cbK
         QrQTnRQ2UPPKWj47vtUI7D5yxjYfCn1CwJzUZsGquLT+FaM7/4z/mVaE9PhSxhNPvdqp
         jK5G7oQJHDEkZvemOobMp/R7ZtOXu8XbQO6wArXsKD8Qi9BcWkB6NmGWAQkxgmaMU/fr
         2oibAiuwzvLbGXghpko5XBxbyVPFXMNS5J5zTbwJ6Xfoj5vdcpl3a2Kq/kQODOctjTkp
         BaNcN99JsPrrXPeG2i9LzI6sqsmLNVfvQl5ANJlnI7cEYS8JsgW9vVMHhfug5CTdMw1C
         xhsw==
X-Gm-Message-State: ACrzQf2BHeNTvPgfYYpPciF2pkjpMqQK9ncg1/00vWm2zWrX1v5JZV2a
        YHrW9U37D+rbDSEGoqJDXUh6Pg==
X-Google-Smtp-Source: AMsMyM6iuA5yKil9gA8TtmEMRoCASMZ22sLHJHjAsR2lUWcHqXr3ZMn45PnxakMpdKdj3KTXVDfCSQ==
X-Received: by 2002:a37:2d84:0:b0:6fa:1747:5369 with SMTP id t126-20020a372d84000000b006fa17475369mr25414271qkh.693.1667581556663;
        Fri, 04 Nov 2022 10:05:56 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id c11-20020ac8054b000000b003a527d29a41sm2667370qth.75.2022.11.04.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:05:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,sdm845-lpasscc: convert to dtschema
Date:   Fri,  4 Nov 2022 13:05:52 -0400
Message-Id: <20221104170552.72242-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert Qualcomm SDM845 LPASS clock controller bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,lpasscc.txt           | 26 ----------
 .../bindings/clock/qcom,sdm845-lpasscc.yaml   | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
deleted file mode 100644
index b9e9787045b9..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Qualcomm LPASS Clock Controller Binding
------------------------------------------------
-
-Required properties :
-- compatible		: shall contain "qcom,sdm845-lpasscc"
-- #clock-cells		: from common clock binding, shall contain 1.
-- reg			: shall contain base register address and size,
-			  in the order
-			Index-0 maps to LPASS_CC register region
-			Index-1 maps to LPASS_QDSP6SS register region
-
-Optional properties :
-- reg-names	: register names of LPASS domain
-		 "cc", "qdsp6ss".
-
-Example:
-
-The below node has to be defined in the cases where the LPASS peripheral loader
-would bring the subsystem out of reset.
-
-	lpasscc: clock-controller@17014000 {
-		compatible = "qcom,sdm845-lpasscc";
-		reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
-		reg-names = "cc", "qdsp6ss";
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
new file mode 100644
index 000000000000..10aa9b6e8d89
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sdm845-lpasscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM845 LPASS Clock Controller
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Qualcomm SDM845 LPASS (Low Power Audio SubSystem) Clock Controller.
+
+  See also:: include/dt-bindings/clock/qcom,lpass-sdm845.h
+
+properties:
+  compatible:
+    const: qcom,sdm845-lpasscc
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cc
+      - const: qdsp6ss
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@17014000 {
+        compatible = "qcom,sdm845-lpasscc";
+        reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
+        reg-names = "cc", "qdsp6ss";
+        #clock-cells = <1>;
+    };
-- 
2.34.1

