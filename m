Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F616550CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiLWNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLWNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:20:47 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48BF6B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:20:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y4so4989728ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0h8gBiSip5CPQa41Be2qfSjOofzaNdmELJ6gbSf7W+Q=;
        b=BM4mM/ZEBiugthpciRcdgoIZedNvK7KRM+cZ568R7kpSRPwACaY8wMlGQ7O3B8PGoi
         VZImChTjy0m5IHpf5gat1apVPTi+mXna/i8iTWhHOhHZltpJSDUTWGrZw1yg7AcfrSh5
         WbDGahdlaV4rqorw0UaTGM4HGfGcLutfVb16WdLCZJwqVOTzG2C/AHjQIZ4AcuHRywY9
         OrI++4i/gTNCk/PtqGvC4jqzLdKflJkvstrz9TnbSSdlfBEmGm+6EEp0WJm4RsuO3hpX
         XEAjDZt6SDLhtcKEySowhripkYGC8s3W34bObuuUAKCa7OudwzPQSFMKaWJ6nLxVa0HU
         YatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h8gBiSip5CPQa41Be2qfSjOofzaNdmELJ6gbSf7W+Q=;
        b=jB9nHQmmMTwxTII1ZPRjogwXe3wPwKkrHKjpw80q6BTBlr7BUyq4RovujZwA+AulAC
         tJzoIchaOwuTh3yuvtpXaj8X3bIY+nFSNHtlm03pGWCkQugYRmYtL+stCY6Sl8cLSuKi
         Dd956QIVfwafhtGNSnW+zmIFnHo18uXM6B9B0zmza1ztpu/7fSIVWuKsL3nHnZ5XG7sU
         o1nitkh1B38fb5LJB0F9byAOKXM9Yb+OQkDHvMq/sGDM/hhD4S51QxH0sEDRiKcpyVWq
         55vuHE5bU3z4s93ubCH9C/o6RRr7XMJZ+RaUdFn9l7sPaxMQ3pFjXsNQ0MffVAgLNj2V
         jqyg==
X-Gm-Message-State: AFqh2kouQXZmYp/tpwxmtCdnDGwoI4QWFcjUG5SoFIsp7tOdrVTG0wtb
        tkN6GFGjOTNrFpQo67HRHJo9Gw==
X-Google-Smtp-Source: AMrXdXtWY4Wr6HDx1RmiVT5cyM3RHiUOV7DYWSjRrzf7W3d5GqVel23YQGTvIhNqKkWXf8dKFXlpnw==
X-Received: by 2002:a2e:b637:0:b0:27a:e3f:7dd5 with SMTP id s23-20020a2eb637000000b0027a0e3f7dd5mr2614956ljn.33.1671801643202;
        Fri, 23 Dec 2022 05:20:43 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea60b000000b0026c2baa72d4sm426753ljp.27.2022.12.23.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:20:42 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: interconnect: split SC7280 to own schema
Date:   Fri, 23 Dec 2022 14:20:38 +0100
Message-Id: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
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

SC7280 comes with interconnects having and missing IO address space, so
split it from common file for easier maintenancen and to fix warnings like:

  sc7280-herobrine-crd.dtb: interconnect: 'reg' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      | 12 ----
 .../interconnect/qcom,sc7280-rpmh.yaml        | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index a429a1ed1006..4bdcc014c46b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -39,18 +39,6 @@ properties:
       - qcom,sc7180-npu-noc
       - qcom,sc7180-qup-virt
       - qcom,sc7180-system-noc
-      - qcom,sc7280-aggre1-noc
-      - qcom,sc7280-aggre2-noc
-      - qcom,sc7280-clk-virt
-      - qcom,sc7280-cnoc2
-      - qcom,sc7280-cnoc3
-      - qcom,sc7280-dc-noc
-      - qcom,sc7280-gem-noc
-      - qcom,sc7280-lpass-ag-noc
-      - qcom,sc7280-mc-virt
-      - qcom,sc7280-mmss-noc
-      - qcom,sc7280-nsp-noc
-      - qcom,sc7280-system-noc
       - qcom,sc8180x-aggre1-noc
       - qcom,sc8180x-aggre2-noc
       - qcom,sc8180x-camnoc-virt
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
new file mode 100644
index 000000000000..b135597d9489
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc7280-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SC7280
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sc7280.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7280-aggre1-noc
+      - qcom,sc7280-aggre2-noc
+      - qcom,sc7280-clk-virt
+      - qcom,sc7280-cnoc2
+      - qcom,sc7280-cnoc3
+      - qcom,sc7280-dc-noc
+      - qcom,sc7280-gem-noc
+      - qcom,sc7280-lpass-ag-noc
+      - qcom,sc7280-mc-virt
+      - qcom,sc7280-mmss-noc
+      - qcom,sc7280-nsp-noc
+      - qcom,sc7280-system-noc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-clk-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect {
+        compatible = "qcom,sc7280-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@9100000 {
+        reg = <0x9100000 0xe2200>;
+        compatible = "qcom,sc7280-gem-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
-- 
2.34.1

