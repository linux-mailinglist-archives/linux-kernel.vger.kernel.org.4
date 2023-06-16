Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D0733152
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjFPMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbjFPMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:35:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F92702;
        Fri, 16 Jun 2023 05:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9/lAY9HO8rZfvcHo2vzME/4OcIC9ir+SbWxmG28F7RoZ0+fFoAeW82UuWcgcH+hECCa4kf1Z+V07FDRNN0G0k+TFNeqcivgS/suseSQb1gL/IPjP0cY//vy1hreDQ6JSgSD/04+VVsecolWXF2cKvwfOXshGwOF+b2X5vkGQg52aNgbLXyUvzkPzq0QmiFkxRrtITFr4QzVv68tIH8qA/ilWErxJF98JNmEgAg6Be+x1EqQ067yLtaJAC1OLqHZpm2Yju4+fQ1rysL4GFYYraqD47YKNcYfgIu39+maHl/Bky2A320pCAyGy5VUnqQluI/PpYvqGD9Ajpqoz4S7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1wT/I1X/OZISgF8/h1k9yvimuUOptt/A7Zv+3UJqsc=;
 b=mY8akAhlw8Yn/AyNY2gHk/BEXbdXVK3QxicTSvag6Hl1MYu87aGyD4gnmG35MgdAsZGfNpZx1SHPjNSQlqZ0EOKR0b95mxIkmLH6ghuF3SXd6gZ4MzUKWCP2QnTuxi4ezGYOgUUaJ9kx0XnzrbuWaJM4AuV8zf0pmOoqaL+R7GTYPnuwU0mUxE+GYG3nZVVK+60Cgs5NO49C9jqn+SmaXCAgWIELE/fFGydtKOGpzOa8HN3Ttohpj33PsT0n0Wc7mdfvWRwBKHz5l1fikdBctChxthQtLNeVRrnGV5/HzYoHZX4UP9sDbv+CFClrgU+pC2NL2+s/Ad/sJHQzM+q/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1wT/I1X/OZISgF8/h1k9yvimuUOptt/A7Zv+3UJqsc=;
 b=FhWa+SzAFscM45FLdEF92Ssm2GJiPV0wPzvetryIaLfwaxS6SVt0OFeXkqOGikRC+uFZqMVubn6FhmrhPuQ0UJli6vhVGAtZqD/TyO+nSKqjJ1nHNc9SVMMI53yufnsFaSs+fjeTywY9Xob6nuVuBvj76NpB4qP2QKRV+WdsaBc=
Received: from DM6PR06CA0089.namprd06.prod.outlook.com (2603:10b6:5:336::22)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:35:17 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f4) by DM6PR06CA0089.outlook.office365.com
 (2603:10b6:5:336::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 12:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 12:35:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:35:15 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 16 Jun 2023 07:35:11 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date:   Fri, 16 Jun 2023 18:04:25 +0530
Message-ID: <1686918865-2330677-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa57f87-e802-4467-94de-08db6e662349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZIACYi0DgSs1D6nxiT1ZD6+4l5gOmZYXKgEmqcgBziACLcbhutFlr17NBN3YGksynp3nBgLNz8z5gF21tA5i3IEEqXqTzCAkogGRSV5BnGvtdFtuovyjUqSTXJNNJ0Ca5yF31Qxr411hAL4HpTSCsQcKhTKAdIIX+JCz/FT+afieKHXPuo4RQdHlDmM1R1Mwo/HfwyIpsVhqTeqgZ0kTjfkV4km9O/d1ZnAzu06zJJA7MoxaGywvqBiDE449ukH9bFv/5FACJRaH98L43ajavLn5tBUoo445dN29pXf6U0xVKUbkweJ1S9SGk7t7+d7kg699cjr8SOtn2vywtHUMSdeAeaA1upX2Mev9iZLBql5JHgUdIg5829PLd7y0Wos4hKS4MMrrF0KoA8ViVtzE0L0hWUxloAEEDao6nR+az1XL4DM93ioepFtKmAC5VFv3tDBvm9O8HfAce2UyWi7NbsYuvIOYuwC0DFDhsafrer58L/alQpDK3E4Liy/1pACtlAsBMqE2yWVIbVM4Z4dfkeiSEwjIiHeFH2V0W4oLcItku4EOd/dwsfcxfGIcZTGnOVjMaEtRZc8obgJ6LRHQf9YLLLM7koYGbJpqbbhHufZYyCdJQb18kwDB0iD7+j+OPiWPi2L+a5lxIKxCuof2idIlMDxhLV618tNTYbE5HYBxAD0hOvmy0on5rhRCPEn/WLBkDc5eJm6uD4wmp15/BeT9udHXS9iufKggX/JqxV8oWzfS/9voGoerCfJ/FaTqPQ7YBKHYdQ1Tm9vNOKivQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(82310400005)(86362001)(82740400003)(5660300002)(336012)(316002)(8936002)(41300700001)(8676002)(70206006)(70586007)(4326008)(110136005)(36860700001)(6636002)(83380400001)(47076005)(54906003)(426003)(2616005)(186003)(478600001)(36756003)(26005)(2906002)(40480700001)(6666004)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:35:15.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa57f87-e802-4467-94de-08db6e662349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bindings for TCM memory address space on AMD-xilinx Zynq
UltraScale+ platform. As of now TCM addresses are hardcoded in xilinx
remoteproc driver. This binding will help in defining TCM in device-tree
and make it's access platform agnostic and data-driven from the driver.

Tightly-coupled memories(TCMs) are low-latency memory that provides
predictable instruction execution and predictable data load/store
timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
banks on the ATCM and BTCM ports, for a total of 128 KB of memory.

In split mode, TCM resources(reg, ranges and power-domain) are documented
in each R5 node and in lockstep mode TCM resources are documented in any
of the R5 node.

It also extends the examples for TCM split and lockstep modes.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
The inspiration for integrating TCM nodes in R5 nodes is taken from
"5ee79c2ed5bd dt-bindings: remoteproc: Add bindings for R5F subsystem
on TI K3 SoCs".Once the binding is reviewed/accepted will send out
driver changes in follow-up series.
---
 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 86 +++++++++++++++++--
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 9f677367dd9f..0bc3a8bb8374 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -20,6 +20,12 @@ properties:
   compatible:
     const: xlnx,zynqmp-r5fss
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
   xlnx,cluster-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
@@ -37,7 +43,7 @@ properties:
       2: single cpu mode
 
 patternProperties:
-  "^r5f-[a-f0-9]+$":
+  "^r5f(.*)+$":
     type: object
     description: |
       The RPU is located in the Low Power Domain of the Processor Subsystem.
@@ -54,8 +60,27 @@ patternProperties:
       compatible:
         const: xlnx,zynqmp-r5f
 
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+      reg:
+        items:
+          - description: Address and Size of the ATCM internal memory region
+          - description: Address and Size of the BTCM internal memory region
+
+      reg-names:
+        items:
+          - const: atcm
+          - const: btcm
+
+      ranges: true
+
       power-domains:
-        maxItems: 1
+        minItems: 1
+        maxItems: 3
 
       mboxes:
         minItems: 1
@@ -112,13 +137,64 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+
+    //Split mode configuration
+    remoteproc {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        r5f_0: r5f@ffe00000 {
+            compatible = "xlnx,zynqmp-r5f";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
+            reg-names = "atcm", "btcm";
+            ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>;
+            power-domains = <&zynqmp_firmware PD_RPU_0>,
+                            <&zynqmp_firmware PD_R5_0_ATCM>,
+                            <&zynqmp_firmware PD_R5_0_BTCM>;
+            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+            mbox-names = "tx", "rx";
+        };
+
+        r5f_1: r5f@ffe90000 {
+            compatible = "xlnx,zynqmp-r5f";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
+            reg-names = "atcm", "btcm";
+            ranges = <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
+            power-domains = <&zynqmp_firmware PD_RPU_1>,
+                            <&zynqmp_firmware PD_R5_1_ATCM>,
+                            <&zynqmp_firmware PD_R5_1_BTCM>;
+            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+            mbox-names = "tx", "rx";
+        };
+    };
+
+  - |
+    //Lockstep configuration
     remoteproc {
         compatible = "xlnx,zynqmp-r5fss";
         xlnx,cluster-mode = <1>;
 
-        r5f-0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        r5f_00: r5f@ffe00000 {
             compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x7>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
+            reg-names = "atcm", "btcm";
+            ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
+            power-domains = <&zynqmp_firmware PD_RPU_0>,
+                            <&zynqmp_firmware PD_R5_0_ATCM>,
+                            <&zynqmp_firmware PD_R5_0_BTCM>;
             memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
             mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
             mbox-names = "tx", "rx";
@@ -126,7 +202,7 @@ examples:
 
         r5f-1 {
             compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x8>;
+            power-domains = <&zynqmp_firmware PD_RPU_1>;
             memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
             mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
             mbox-names = "tx", "rx";
-- 
2.25.1

