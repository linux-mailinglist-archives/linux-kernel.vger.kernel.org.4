Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A648653E03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiLVKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiLVKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:07:48 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBF1EAC1;
        Thu, 22 Dec 2022 02:07:43 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM7iAZA001831;
        Thu, 22 Dec 2022 11:07:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xJK/PfJ7a74dAX+0p69wYwTOoPXBkawojf+F+1J+EJc=;
 b=mKxCD5aTipUU9ZfCp+7WKQXd3vfv1eVl2RpQYOtJlMexj5tTsBA98Ocjpf7r2JpZaZyf
 22orp71qCycBLuFzw2Gk38L9ncJN0VLVualCtxSlKtiYmKmPp4MXz/dPtutuNkqeZN1W
 DHuG8WnkyudX+i/o3kSk3oSLTWg+NsrbZwEolYjS/GAZBV5omrfqXv1MqYPZnXbaBSSV
 CsCsOf5DSs9OWr9QXl6Nq5IDAvdu2aP185OFco6P1bkw7SpAhNqYRnKp+tbNpEzntJow
 6Q37OuNBwuyBpU1Alahgv50I86kh+GsvRNYWc3vJXgIUsWY99+uLqeK8oH67e0gvdB3C Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mka9xfdjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 11:07:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 876A8100050;
        Thu, 22 Dec 2022 11:07:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A957921D3D2;
        Thu, 22 Dec 2022 11:06:28 +0100 (CET)
Received: from localhost (10.201.21.217) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 11:06:28 +0100
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <gatien.chevallier@foss.st.com>
Subject: [RFC PATCH v2 2/7] dt-bindings: bus: add STM32 System Bus
Date:   Thu, 22 Dec 2022 11:04:59 +0100
Message-ID: <20221222100504.68247-3-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
References: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_05,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document STM32 System Bus. This bus is intended to control firewall
access for the peripherals connected to it.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Signed-off-by: Loic PALLARDY <loic.pallardy@st.com>
---

Changes in V2: 
	- Corrected errors highlighted by Rob's robot
	- Re-ordered Signed-off-by tags

 .../devicetree/bindings/bus/st,sys-bus.yaml   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/st,sys-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/st,sys-bus.yaml b/Documentation/devicetree/bindings/bus/st,sys-bus.yaml
new file mode 100644
index 000000000000..d246fbdd6dea
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/st,sys-bus.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/st,sys-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32 System Bus
+
+description: |
+  The STM32 System Bus is an internal bus to which some internal peripherals
+  are connected. STM32 System Bus integrates a firewall controlling access to each
+  device. This bus prevents non-accessible devices to be probed.
+
+  To see which peripherals are securable, please check the SoC reference manual.
+
+maintainers:
+  - Gatien Chevallier <gatien.chevallier@foss.st.com>
+
+allOf:
+  - $ref: /schemas/feature-controllers/feature-domain-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,stm32mp13-sys-bus
+      - st,stm32mp15-sys-bus
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  '#feature-domain-cells':
+    minimum: 1
+
+  ranges: true
+
+  feature-domain-controller: true
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    description: Devices attached to system bus
+    type: object
+    properties:
+      feature-domains:
+        $ref: /schemas/feature-controllers/feature-domain-controller.yaml#/properties/feature-domains
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - feature-domain-controller
+  - '#feature-domain-cells'
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    // In this example,
+    // - the foo1 device refers to etzpc as his domain controller.
+    // - same goes for foo2.
+    // Access rights are verified before creating devices.
+
+    etzpc: etzpc@5c007000 {
+        compatible = "st,stm32mp15-sys-bus";
+        reg = <0x5c007000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        feature-domain-controller;
+        #feature-domain-cells = <1>;
+
+        foo1: foo@1000000 {
+          reg = <0x0 0x1000000>;
+          feature-domains = <&etzpc 0>;
+        };
+
+        foo2: foo@2000000 {
+          reg = <0x0 0x2000000>;
+          feature-domains = <&etzpc 0>;
+        };
+    };
-- 
2.25.1

