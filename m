Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5C6F68A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjEDJrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjEDJr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:47:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C449DA;
        Thu,  4 May 2023 02:47:25 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3448eebR015762;
        Thu, 4 May 2023 11:46:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=AM1K4/BQXW0CuUZYLo3aJkmKe0XEgpleRDfLVkoedAI=;
 b=uZOIRkdOTl99BF7eO1RBUF+TjGa6A4pXBpyM1jSFlXg54mSviWfc87P4dl1Zub+BOJcx
 LMm+MHRQf57uvLtzs192j1NuQw0zqdB/URdPLvH6GcMPkMt2wpsWNMwDTJkm++BcuC3/
 tlN6woxZWCb0zVkjn/udU+WgItBp/M5yg5C+B5+rsFkAAMwtDJX4LErIZUjCTseLVgeL
 vUdQxB/H27zwpL0giZyIh2ok5ME/+ZvwU+9YWnryqMWHaX0MxvAG5bizPq7LhkNm/7c9
 o6e9Qt6q/VWoQmYg7IcMhuCc8uC7ZzGdRdTX5Z9n0UOLblXsyhNp67n5J/wbbk28A3ZW iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qc6uw9tde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 11:46:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85370100034;
        Thu,  4 May 2023 11:46:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BC0E214D07;
        Thu,  4 May 2023 11:46:52 +0200 (CEST)
Received: from localhost (10.201.21.213) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 11:46:52 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2 1/4] dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
Date:   Thu, 4 May 2023 11:46:38 +0200
Message-ID: <20230504094641.870378-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504094641.870378-1-arnaud.pouliquen@foss.st.com>
References: <20230504094641.870378-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of the SCMI (System Control and Management
Interface), it is now possible to use the SCMI to handle the
hold boot instead of a dedicated SMC call.

As consequence two configurations are possible:
- without SCMI server on OP-TEE:
  use the Linux rcc reset service and use syscon for the MCU hold boot
- With SCMI server on OP-TEE:
  use the SCMI reset service for both the MCU reset and the MCU hold boot.

This patch:
- make optional and deprecated the use of the property st,syscfg-tz
  which was used to check if the trusted Zone was enable to use scm call,
  to manage the hold boot. The reset controller phandle is used instead
  to select the configurations.
- make st,syscfg-holdboot optional
- adds properties check on resets definitions.
- adds an example of the SCMI reset service usage.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates vs previous version:
- do not suppress "st,syscfg-tz" property to keep legacy compatibility
  but set it as deprecated
- remove "reset-name" from requested property for legacy compatibility
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 42 ++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 66b1e3efdaa3..93105d174279 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -25,7 +25,14 @@ properties:
     maxItems: 3
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: mcu_rst
+      - const: hold_boot
+    minItems: 1
 
   st,syscfg-holdboot:
     description: remote processor reset hold boot
@@ -37,6 +44,7 @@ properties:
           - description: The field mask of the hold boot
 
   st,syscfg-tz:
+    deprecated: true
     description:
       Reference to the system configuration which holds the RCC trust zone mode
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
@@ -135,22 +143,46 @@ required:
   - compatible
   - reg
   - resets
-  - st,syscfg-holdboot
-  - st,syscfg-tz
+
+allOf:
+  - if:
+      properties:
+        reset-names:
+          not:
+            contains:
+              const: hold_boot
+    then:
+      required:
+        - st,syscfg-holdboot
+    else:
+      properties:
+        st,syscfg-holdboot: false
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/reset/stm32mp1-resets.h>
-    m4_rproc: m4@10000000 {
+    m4_rproc_example1: m4@10000000 {
       compatible = "st,stm32mp1-m4";
       reg = <0x10000000 0x40000>,
             <0x30000000 0x40000>,
             <0x38000000 0x10000>;
       resets = <&rcc MCU_R>;
+      reset-names = "mcu_rst";
       st,syscfg-holdboot = <&rcc 0x10C 0x1>;
-      st,syscfg-tz = <&rcc 0x000 0x1>;
+      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
+      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
+    };
+  - |
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    m4_rproc_example2: m4@10000000 {
+      compatible = "st,stm32mp1-m4";
+      reg = <0x10000000 0x40000>,
+            <0x30000000 0x40000>,
+            <0x38000000 0x10000>;
+      resets = <&scmi MCU_R>, <&scmi MCU_HOLD_BOOT_R>;
+      reset-names = "mcu_rst", "hold_boot";
       st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
       st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
     };
-- 
2.25.1

