Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9404362FC91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbiKRSXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbiKRSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:23:03 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62928976E8;
        Fri, 18 Nov 2022 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1668795777; x=1700331777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qak47M4u6T8kHiYXWecTuKzaOl0IZojjbcoprnvHzZc=;
  b=J+bRXUIjbW0qQWNTXz6Iv0eHrYl+wxDuTh8uraAKRgv26i9zWsxxcGXz
   sso6moYAAOUmb6+BvATo5q3gh10udkngrVgtc8Xarpgypyc6VCtX9xBvr
   bJNz1+N0xY5AweHluu3vqujyd5UDP3Ms1ubkR085cFn56tMU2DDxCL+v2
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Nov 2022 10:22:57 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:22:57 -0800
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 10:22:56 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
Date:   Fri, 18 Nov 2022 10:22:43 -0800
Message-ID: <20221118182245.31035-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118182245.31035-1-quic_molvera@quicinc.com>
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for virtual rpmh devices. These interconnects
are not controlled by the application processor and thus
require separate bindings. Also, move compatibles for sm8450 to
this document and add them for QDU1000/QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
 .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
 2 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
new file mode 100644
index 000000000000..5cbaa51df863
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+  - Odelu Kukatla <quic_okukatla@quicinc.com>
+
+description: |
+   RPMh interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources. Virtual interconnect providers are not
+   controlled by AP and do not support QoS; they should not have associated
+   register regions.
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,qdu1000-clk-virt
+      - qcom,qdu1000-mc-virt
+      - qcom,sm8450-clk-virt
+      - qcom,sm8450-mc-virt
+
+  '#interconnect-cells': true
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/interconnect/qcom,sm8450.h>
+
+      clk_virt: interconnect-0 {
+             compatible = "qcom,sm8450-clk-virt";
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mc_virt: interconnect-1 {
+             compatible = "qcom,sm8450-mc-virt";
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index a429a1ed1006..bd474f49deb0 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -123,11 +123,9 @@ properties:
       - qcom,sm8350-system-noc
       - qcom,sm8450-aggre1-noc
       - qcom,sm8450-aggre2-noc
-      - qcom,sm8450-clk-virt
       - qcom,sm8450-config-noc
       - qcom,sm8450-gem-noc
       - qcom,sm8450-lpass-ag-noc
-      - qcom,sm8450-mc-virt
       - qcom,sm8450-mmss-noc
       - qcom,sm8450-nsp-noc
       - qcom,sm8450-pcie-anoc
-- 
2.38.1

