Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8777B665770
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjAKJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjAKJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:27:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130E8FE7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:26:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bn26so14421129wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3brE8bKAi5jlYapkTAnxHwAgUAoi/u6Zxd0ixAKnGy4=;
        b=RDguHcnO9XSHhS6bshVCzgTxT7jTE4aIAbLx6f8dXsz0Zk8G29rzvn21EfkO1znXjs
         //EotLDKz2Q0w3+ySL/ui3/1MD1ecAeJWYk2S3Hp1RJRXaX296PVLZQ5EJj3UAyAKObc
         99E2RNce7N7qs4lxxJ3Iq0OEZ5bwmpqpPvOm8ivRauyIK6kMhOdhq2YwxPCc51SkrWKd
         7tkcRMF9K0DzxIo+jYs92noPDVh8dmkUFY8FJMNWTfgUlWjjhDxafb6LfBqCm2xQim8U
         NqROxBZLHFAsSdpIEFcmmbeFtCv3BuT4N190EPcd9lCZw9aMd2JlozMFqDKuoiqAQu/+
         Bh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3brE8bKAi5jlYapkTAnxHwAgUAoi/u6Zxd0ixAKnGy4=;
        b=iONwG70LsWtEAxvV31exCZYvC/GgU+oWQe/K5CDj0ms1EBmhFytQGAMSVV0nZNOSjI
         lABIRB/cGb3GmKeyX+znAZMCvfV2+qM2ysOyGZXElt7LZ7faDX+1nWlVkTljI/RatjlT
         8MIlyRRtbQRTbCy72frQV5oEkmqu1mAXLWVandwNNyBGHNEjqxzcFvTmarrKyxjbsECh
         ox3jjjGyWPLldPFxOunsR4asE84uBTo58uBAkogAO0leepWefHvwYYZkTu47R413tXXv
         9FO7UBI1t+WVnnApuVnQuOA/6wgBjbosd3i1KDDxqu17U86fhaHJ9XBMAj/9LPkpGTEk
         24XQ==
X-Gm-Message-State: AFqh2kp6dBQFZJ/zqWAVgseVC4I5XbAwwqZOeIhgISB5fS/oE3/S5rru
        BI/Vh/pCL3dRm2aU3R3l71xSnA==
X-Google-Smtp-Source: AMrXdXvci8D+ttiqIrYjLYTQ5WNk6qZgGXph6udOPGAUh6Q8g25AjHT96OlMZGzi+cF8Aqs+er9z+Q==
X-Received: by 2002:adf:f5c6:0:b0:29f:ebd1:6a5 with SMTP id k6-20020adff5c6000000b0029febd106a5mr20258118wrp.14.1673429203997;
        Wed, 11 Jan 2023 01:26:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm7954177wrp.15.2023.01.11.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:26:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: interconnect: split SC8280XP to own schema
Date:   Wed, 11 Jan 2023 10:26:36 +0100
Message-Id: <20230111092637.17946-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111092637.17946-1-krzysztof.kozlowski@linaro.org>
References: <20230111092637.17946-1-krzysztof.kozlowski@linaro.org>
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

SC8280XP comes with interconnects without IO address space, so split it
from common file for easier maintenance and to fix warnings like:

  sc8280xp-lenovo-thinkpad-x13s.dtb: interconnect-mc-virt: 'reg' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Fix typo in commit msg
2. Add Rb tag
---
 .../bindings/interconnect/qcom,rpmh.yaml      | 12 -----
 .../interconnect/qcom,sc8280xp-rpmh.yaml      | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 4bdcc014c46b..448829ecf6b6 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -51,18 +51,6 @@ properties:
       - qcom,sc8180x-mmss-noc
       - qcom,sc8180x-qup-virt
       - qcom,sc8180x-system-noc
-      - qcom,sc8280xp-aggre1-noc
-      - qcom,sc8280xp-aggre2-noc
-      - qcom,sc8280xp-clk-virt
-      - qcom,sc8280xp-config-noc
-      - qcom,sc8280xp-dc-noc
-      - qcom,sc8280xp-gem-noc
-      - qcom,sc8280xp-lpass-ag-noc
-      - qcom,sc8280xp-mc-virt
-      - qcom,sc8280xp-mmss-noc
-      - qcom,sc8280xp-nspa-noc
-      - qcom,sc8280xp-nspb-noc
-      - qcom,sc8280xp-system-noc
       - qcom,sdm845-aggre1-noc
       - qcom,sdm845-aggre2-noc
       - qcom,sdm845-config-noc
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
new file mode 100644
index 000000000000..6c2da03f0cd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc8280xp-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SC8280XP
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sc8280xp.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-aggre1-noc
+      - qcom,sc8280xp-aggre2-noc
+      - qcom,sc8280xp-clk-virt
+      - qcom,sc8280xp-config-noc
+      - qcom,sc8280xp-dc-noc
+      - qcom,sc8280xp-gem-noc
+      - qcom,sc8280xp-lpass-ag-noc
+      - qcom,sc8280xp-mc-virt
+      - qcom,sc8280xp-mmss-noc
+      - qcom,sc8280xp-nspa-noc
+      - qcom,sc8280xp-nspb-noc
+      - qcom,sc8280xp-system-noc
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect-0 {
+        compatible = "qcom,sc8280xp-aggre1-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
-- 
2.34.1

