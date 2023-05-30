Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8929D71694C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjE3QZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjE3QZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0D193;
        Tue, 30 May 2023 09:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 850DA62CC2;
        Tue, 30 May 2023 16:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A11FC4339B;
        Tue, 30 May 2023 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463915;
        bh=ONGZ6tx25zrzM63vUzRjI7+UDmVDsbNs76Pza82K8Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cou4SbxMDYtXOM0YrnZHiW2xhRHgnWTc+KVxlvQIKiP8JTxybe6xe4J2xSD03W/jy
         iXApPJGApkKzd3inCUspq7s7EyiGkrczyK3f3bXE3ZvDHE13UCFeuh3RQpVGSSR6Zm
         65F6ThnPerdLCRyAim2DmVPg/J9k3oOoON3aYOId/x76nEY9RDa2aT1jaBYAnXPuAn
         /wdM/V6OmzBxUmDjYnJkUR5ix5huBxLsKlh3qxNMi7u3jOl2nL/rxVSug3zdX1vGcV
         a/NkqcrIzzlmEV0Web8xWxObW6zIfFlU/76Cpw2gRqxFgdjHuAV5ta2zDYbK6lIpdl
         oBX0EIWbTVnnQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 03/15] dt-bindings: interconnect: split SC8180x to own schema
Date:   Tue, 30 May 2023 21:54:42 +0530
Message-Id: <20230530162454.51708-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8180x comes with interconnects with missing IO address space and
variable number of clocks, so split it from common file for easier
maintenance and to fix warnings like:

sc8180x-lenovo-flex-5g.dtb: interconnect-0: 'reg' is a required property

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      | 11 -----
 .../interconnect/qcom,sc8180x-rpmh.yaml       | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 4d93ad415e0b..5cbc3be49e99 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -39,17 +39,6 @@ properties:
       - qcom,sc7180-npu-noc
       - qcom,sc7180-qup-virt
       - qcom,sc7180-system-noc
-      - qcom,sc8180x-aggre1-noc
-      - qcom,sc8180x-aggre2-noc
-      - qcom,sc8180x-camnoc-virt
-      - qcom,sc8180x-compute-noc
-      - qcom,sc8180x-config-noc
-      - qcom,sc8180x-dc-noc
-      - qcom,sc8180x-gem-noc
-      - qcom,sc8180x-mc-virt
-      - qcom,sc8180x-mmss-noc
-      - qcom,sc8180x-qup-virt
-      - qcom,sc8180x-system-noc
       - qcom,sdm670-aggre1-noc
       - qcom,sdm670-aggre2-noc
       - qcom,sdm670-config-noc
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
new file mode 100644
index 000000000000..b182c2c5addc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc8180x-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SC8180X
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sc8180x.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8180x-aggre1-noc
+      - qcom,sc8180x-aggre2-noc
+      - qcom,sc8180x-camnoc-virt
+      - qcom,sc8180x-compute-noc
+      - qcom,sc8180x-config-noc
+      - qcom,sc8180x-dc-noc
+      - qcom,sc8180x-gem-noc
+      - qcom,sc8180x-ipa-virt
+      - qcom,sc8180x-mc-virt
+      - qcom,sc8180x-mmss-noc
+      - qcom,sc8180x-qup-virt
+      - qcom,sc8180x-system-noc
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
+        compatible = "qcom,sc8180x-camnoc-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
-- 
2.40.1

