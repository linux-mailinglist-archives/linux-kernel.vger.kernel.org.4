Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264FB7403A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF0S5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0S52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:57:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468B19A9;
        Tue, 27 Jun 2023 11:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGHGMzqIi2CY4n1WEvU/a/8zXbGHKYiZKckYg/y88TuhVHIqLDr6uXwosckfaJGj+4sCF78Si1Dtf7BJ0rYEfZqk7l2EASG/kfXsnDmcNkxHUGvjM0iImRLFARlcJKOw8khgmX6Z+2RuC0+iPewOlvO0rgWzvpOZNKJ6KxUEgdhuBbCYYA9n/+CVLRvBqEpUmRl0QsR0SQTg4kBZdVC9ySPCagFEXDCXq2dOhjnAircVCvpAKEi9NtWhKfA2H4vSDlk7JoIgJlH74h5hWvrWNjKZhhCZ3M3fMZZBRIdfDH2PIvuebBPevSZogj08STphAfEyjWC0A2krGUxZPqdgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEq4+yaCnVDrDcjI2zYaE5TNfnci8w1sd9PRomO2ROo=;
 b=HKULv8jtP/VxWemeYm8zaYiLjEOFXzI9/30HU0PGiK3qlz+WaxYKxrBYakhHbQ2X1O4BLk8dI8nk+/Q/xvwNJxpxp1VqQ96np6xK1/iTdWL/O2/vw889v3exLsLhcYUDxwmqTiK7isM/OkepDAFEcIW2nHIYyY+0FyvifxhnFGzrwVXtJS4DliLoffnQ89SN6KZvHkDj2MXfMyrWxRv81avJCtNGwXtq04PrTWAVib5zsN1Fj4S3ucA0LM//2ZXwywxjbIgtIElb+6Z0SsR7PVkuartjlV6/EB03wtKGygn36EyewiN0dGGpArj3EO6Wo2mu0/QC/ELscexiaw17MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEq4+yaCnVDrDcjI2zYaE5TNfnci8w1sd9PRomO2ROo=;
 b=B4BiSRXax6c5nrq0Ci2o5Bcn5V3b08IfWiiLqDwKgq1TQW+8V8YB0LI4LU4xYMfQAGoQhZWstRe3D03g/PqR8+NZj0Nbwpxxa0EiqhdWvNzSGgANi0WA8luBGGr6hXLVJR1zyDRwKW2MJhcKOE+hP3r0vWGx0mfb2m7I6zD8hHA=
Received: from MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20) by
 IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 27 Jun 2023 18:57:23 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::a6) by MW2PR16CA0007.outlook.office365.com
 (2603:10b6:907::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 18:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 18:57:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 27 Jun
 2023 13:57:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 27 Jun
 2023 11:57:20 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 27 Jun 2023 13:57:16 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date:   Wed, 28 Jun 2023 00:27:06 +0530
Message-ID: <1687892226-3784452-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2fa8c9-6584-477f-deea-08db77405734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK1rb5COCIneJ+yYG7r3aZH51lLu7pqsKTAwlp8fDaxLPsnFacNuOcZtoS+t7KuTFTypSMNBeXnjt068Ja5Yd3ghUGjyl9Nqrf8VIDTMtKbY9vQaJk7ndw5W9SwOW6VVns7FPDGvbs1WjDkczzK3vxr85G11cUELzfojYdN6GeKLxq/ZtlHGXiltRf9HtAKvm9/NBTVxsuPVTkyyQXXENbtRacy9NC7Tom+93Ac7XAX7mqmSOHkFFZjqtdoJCGM0zdQtNxq7M8ME1iDIr2Qyj/IFiH0orFtSMa3uUrNbTywbucgwXrzS5hhfdY3UjQz9X6rsBWiAu5AaVtqdD/TNCtFaQsme1RJP3rCcNJvxEcO48E4s9Ni2V6FUvb8UVtwVuuCYJDxt41AM0OvGw8kcBw7OpQ6Wism1ELUYeWg41C9JoGq9fP4Ol87xiErz7Xi//r+2w2qr7hOw83isCp0HHnx/ScKYLVtk9Qu75e5MEBiVohONSdxvQU4jTX23VTSZQHW2wjjqQD4owmo4yxXvD6Tp+sTtzqjJGWtL4iZu3dniSlGERFgLCYOj7ret9gPf5qa8QQQWnkZGtOOtKgQY918tpiIVrNfNMWrgnF+iuy9/qamHxDCsA1l+8Lk782GjuBTItYyJzdUJ/0XWgoDacoJ4O1bB+Jz2hXmAx9GdWKlLTwZ9VIZDVYbgna3a6tOFZvsuY8YDmc1yCCXONmW0AGFDQkGPl7TBZlZx4i6kH41jYJTTTb/Ib0G/PmqBvAd3NlR4Vjs8Wc06LI2B94yPnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(26005)(4326008)(70586007)(8676002)(70206006)(6636002)(8936002)(478600001)(2906002)(316002)(36756003)(5660300002)(40460700003)(36860700001)(110136005)(41300700001)(54906003)(86362001)(82310400005)(40480700001)(186003)(336012)(47076005)(426003)(6666004)(82740400003)(83380400001)(356005)(2616005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 18:57:22.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2fa8c9-6584-477f-deea-08db77405734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
X-Spam-Status: No, score=1.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
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

The TCM resources(reg and power-domain) are documented in each R5 node.
It also extends the examples for TCM split and lockstep modes.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Add ranges property to r5fss cluster node.
- Use regex "^r5f(@[0-9a-f]+|-[a-f0-9]+)$".
- Drop address/size-cells and ranges from r5f core node.
- Mention "reg" and "reg names" as r5f core node required properties.
- Mention address/size-cells and ranges as r5fss required node properties.
- Modify commit description to remove ranges from R5 node.
- Rename r5f node labels(r5f_0 -> r5f_0_split/lockstep and
  r5f_1->r5f_1_split/lockstep)

The inspiration for integrating TCM nodes in R5 nodes is taken from
"5ee79c2ed5bd dt-bindings: remoteproc: Add bindings for R5F subsystem
on TI K3 SoCs".Once the binding is reviewed/accepted will send out
driver changes in follow-up series.
---
 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 90 +++++++++++++++++--
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 9f677367dd9f..958044b08e86 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -20,6 +20,17 @@ properties:
   compatible:
     const: xlnx,zynqmp-r5fss
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description: |
+      Standard ranges definition providing address translations for
+      local R5F TCM address spaces to bus addresses.
+
   xlnx,cluster-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
@@ -37,7 +48,7 @@ properties:
       2: single cpu mode
 
 patternProperties:
-  "^r5f-[a-f0-9]+$":
+  "^r5f(@[0-9a-f]+|-[a-f0-9]+)$":
     type: object
     description: |
       The RPU is located in the Low Power Domain of the Processor Subsystem.
@@ -54,8 +65,19 @@ patternProperties:
       compatible:
         const: xlnx,zynqmp-r5f
 
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
       power-domains:
-        maxItems: 1
+        minItems: 1
+        maxItems: 3
 
       mboxes:
         minItems: 1
@@ -102,31 +124,85 @@ patternProperties:
     required:
       - compatible
       - power-domains
+      - reg
+      - reg-names
 
     unevaluatedProperties: false
 
 required:
   - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
 
 additionalProperties: false
 
 examples:
   - |
-    remoteproc {
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+
+    //Split mode configuration
+    remoteproc@ffe00000 {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>,
+                 <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
+
+        r5f_0_split: r5f@ffe00000 {
+            compatible = "xlnx,zynqmp-r5f";
+            reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_0>,
+                            <&zynqmp_firmware PD_R5_0_ATCM>,
+                            <&zynqmp_firmware PD_R5_0_BTCM>;
+            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+            mbox-names = "tx", "rx";
+        };
+
+        r5f_1_split: r5f@ffe90000 {
+            compatible = "xlnx,zynqmp-r5f";
+            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
+            reg-names = "atcm", "btcm";
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
+    remoteproc@ffe00000 {
         compatible = "xlnx,zynqmp-r5fss";
         xlnx,cluster-mode = <1>;
 
-        r5f-0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
+
+        r5f_0_lockstep: r5f@ffe00000 {
             compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x7>;
+            reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_0>,
+                            <&zynqmp_firmware PD_R5_0_ATCM>,
+                            <&zynqmp_firmware PD_R5_0_BTCM>;
             memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
             mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
             mbox-names = "tx", "rx";
         };
 
-        r5f-1 {
+        r5f_1_lockstep: r5f@ffe90000 {
             compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x8>;
+            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_1>;
             memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
             mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
             mbox-names = "tx", "rx";
-- 
2.25.1

