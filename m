Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2D668F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbjAMHem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbjAMHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:33:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889111165;
        Thu, 12 Jan 2023 23:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/IHAf6xpp/J+7+TeyUogtmVDthztbYNzsOjzYmgSeF7jyAueoueWaZx08b6Gp3W8fvmHR4kZFXuBXYNBup+Eq98Rj8O4wMyOQkTg7UTCdnFvkq4j+0Vr6KGw1F4c2ixVv4i+N9Vzq9I1SCP6u+Xh2SMVJUhe+FISzLeCJ9ebY6hDHYFitBuOnloInAlW30l082mEf2MEaB6/PzDBNhvr2Z+QXrOU09yTrDjRODBcKrFPda0xGEgfS7OiifhTuPoZIOwifcKbG0GIxuslWsyit9R8DEy7Sjep8zckhBJnlWwzbRqhpk47t3Y7YFQ9kxlhueiWn5MXSSiElSM2A8emA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLtly/pVIDJj8inooB/0YSXTqbtqYBaC7zX3HoN5gtw=;
 b=E8s1UudS6Orz1i4Z4h/66nQwxI881KGOwGWmPz8MdWJmXuE7AB/sHEYhCvfkKroq5guXsBVPI4EutppCmlNko/D7hNYwr9IV2wOpOHB0ajEXkOf83hUMLhzLEliU7IqxM1OG9lXtqqLlZnWgaLvIsy0oW+iH/Bjf6QP7VclePG1ECX3fxc8Tp2Gbfa0v1KB8dxdv+dIGB8TkDvPF0srd7DTL3IGKe/THG6IketpJd3KLd3g0l1noHpl6rTtU0xozR+g34QueD1fvJHen7GRCZN+u9/9fSF0B7HFaosl35Nr+HiyXOvZ9WfNAbTA0XqiGNVFi74fTJIPRO/G4gOwZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLtly/pVIDJj8inooB/0YSXTqbtqYBaC7zX3HoN5gtw=;
 b=IIYNYIgoDhkcpMGXvaOBHFJEiBw8zgumOfXO94I9B3uurwR2A8OvWVn84gA/qqGQbPE8ckQ4P46877p8YdgoIuxR90bouaG0Z9KYA9wFcKnSJjYBTEpBweGPQLwBuMsP4dagADOR2+sIt/MtPcP/GEbpjMlgcH1bz0miW4Lg1ys=
Received: from DM6PR08CA0055.namprd08.prod.outlook.com (2603:10b6:5:1e0::29)
 by CH2PR12MB4876.namprd12.prod.outlook.com (2603:10b6:610:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 07:31:44 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::b1) by DM6PR08CA0055.outlook.office365.com
 (2603:10b6:5:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 07:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 07:31:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 01:31:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:31:05 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Jan 2023 01:31:05 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <tanmay.shah@amd.com>
Subject: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Date:   Thu, 12 Jan 2023 23:30:46 -0800
Message-ID: <20230113073045.4008853-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|CH2PR12MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaad9f8-adca-49f0-6323-08daf538386f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaYAmeddtHAZjQ13qnaIjw2IOVS7IDQEy7h5tf3llE4SoX1I+/RyiVSb+8b2O7EKPPyX3/mOKtVNb9AFwzJU927pXt7Iy4ZwTvwElahlgZQoE/ydb9wRiDNZDWgKrtEdBd4UL6Hur2QTTh4SP2SWNQ4doCaMYSqpMgoqJ3IjX5RKSeak+1OE1DVD0ECrVcCSGMRRV70CV6XsS74gZVB/e8RzRf/ARIkamUDrhgw8Em0A23gURahPpOxGPCHaf3o/OzoeMxo+u6wrtsF0dNxKSP1RBFg4lQq8mm/TUgzeESbfxhy5AAw23YsQl6h0V0KI5/1EH4iR+dL1+1sFaGGOkayQHuH7CcF/OTdhqcHo8qcQT32pGZalGGOGDknzObCEEeMLQ4fhlIrygLJC7MLAQmYWfW92LBqu8ZDnx8HM1NsgpEwkLesNswXZTIlideRVFik3ZIrNn94BQmzuIVXBdzIYkct6foGgtapmMHV4pNo/3VZKdvSxqbI6mibO0/Eif0jEEBDtO51YRw6cd3n2DGaooMbEKYs1DV5ihMjDntOCNTOa/8FyhwB9QIAXLSYfN77NgcEmsjEuv6AaZ41fouvTdXW+qAnPsVL09thS0CpKvLAFAKGfm9vXsOOOtRDaFarxM1K9K9n88ni1CYC1sIXBrF0ScHQ673ERtnRvBl88RblBA8E4S2oQB3TMXT0TH5Jw2ax5sstdJaJ/FjOWFRBLIa7K3OUXsC4CvkyAbYZmDvdCgolrfTgch1HLiKsKmHSm2q4jZO6AgmDCXBjOzieIS7zio+huhpFL35QDwx8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(6666004)(186003)(966005)(26005)(478600001)(336012)(2616005)(54906003)(4326008)(1076003)(70586007)(8676002)(40460700003)(41300700001)(426003)(70206006)(47076005)(110136005)(44832011)(40480700001)(82740400003)(8936002)(5660300002)(316002)(83380400001)(36756003)(356005)(82310400005)(36860700001)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 07:31:43.9362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaad9f8-adca-49f0-6323-08daf538386f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces bindings for TCM memory address space on AMD-xilinx
platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
driver. This bindings will help in defining TCM in device-tree and
make it's access platform agnostic and data-driven from the driver.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml

diff --git a/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
new file mode 100644
index 000000000000..02d17026fb1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sram/xlnx,tcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tightly Coupled Memory (TCM)
+
+maintainers:
+  - Tanmay Shah <tanmay.shah@amd.com>
+
+description: |
+  Tightly Coupled Memory(TCM) is available on AMD-Xilinx paltforms for ARM
+  cortex remote processors to use. It is low-latency memory that provide
+  predictable instruction execution and predictable data load/store timing.
+  TCM can be configured in lockstep mode or split mode. In split mode
+  configuration each RPU core has its own set of ATCM and BTCM memories and in
+  lockstep mode redundant processor's TCM become available to lockstep
+  processor. So In lockstep mode ATCM and BTCM size is increased.
+
+properties:
+  $nodename:
+    pattern: "sram-[0-9a-f]+$"
+
+patternProperties:
+  "^tcm-[a-z]+@[0-9a-f]+$":
+    type: object
+    description: |
+      During the split mode, each RPU core has its own set of ATCM and BTCM memory
+
+      During the lock-step operation, the TCMs that are associated with the
+      redundant processor become available to the lock-step processor.
+      For example if each individual processor has 64KB ATCM, then in lockstep mode
+      The size of ATCM become 128KB. Same for BTCM. tcm-lockstep node represents
+      TCM address space in lockstep mode. tcm-core@x node specfies each core's
+      TCM address space in split mode.
+
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - enum:
+                  - xlnx,tcm-lockstep
+                  - xlnx,tcm-split
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+      reg:
+        items:
+          - description: |
+              ATCM Memory address space. An ATCM typically holds interrupt or
+              exception code that must be accessed at high speed, without any
+              potential delay resulting from a cache miss.
+              RPU on AMD-Xilinx platform can also fetch data from ATCM
+          - description: |
+              BTCM Memory address space. A BTCM typically holds a block of data
+              for intensive processing, such as audio or video processing. RPU on
+              AMD-Xilinx Platforms can also fetch Code (Instructions) from BTCM
+
+      reg-names:
+        items:
+          - const: atcm
+          - const: btcm
+
+      ranges: true
+
+      power-domains:
+        maxItems: 8
+        items:
+          - description: list of ATCM Power domains
+          - description: list of BTCM Power domains
+        additionalItems: true
+
+    required:
+      - compatible
+      - '#address-cells'
+      - '#size-cells'
+      - reg
+      - ranges
+      - power-domains
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+
+    amba {
+        sram@ffe00000 {
+            tcm-lockstep@ffe00000 {
+                compatible = "xlnx,tcm-lockstep";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
+                reg-names = "atcm", "btcm";
+                ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
+                power-domains = <&zynqmp_firmware PD_R5_0_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_0_BTCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+            };
+
+            tcm-core@0 {
+                compatible = "xlnx,tcm-split";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
+                reg-names = "atcm", "btcm";
+                ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>;
+                power-domains = <&zynqmp_firmware PD_R5_0_ATCM>,
+                                <&zynqmp_firmware PD_R5_0_BTCM>;
+            };
+
+            tcm-core@1 {
+                compatible = "xlnx,tcm-split";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
+                reg-names = "atcm", "btcm";
+                ranges = <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
+                power-domains = <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+            };
+        };
+    };
+...

base-commit: 6b31ffe9c8b9947d6d3552d6e10752fd96d0f80f
-- 
2.25.1

