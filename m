Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276F6FAFEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjEHM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEHM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:27:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD2348A4;
        Mon,  8 May 2023 05:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNX0gGuzBWuPlAEowkRKR4jiwB7U765KqsZIiumE8YGWuN2QrfkMZ5qXfYarguvM16XOULyCXu8rNfGMfMDny+YbNKyWemOtPVEkLCcL9Atr+WwF4l3d5vaIHnLI+EiQUSWWPuCQwXEj3vUyzzSYZPXgTgr49p4A9Q8422kVEz8+BDIhn9WjX1s9e1RkxceWF7X1SFZch1pvcN7XxqqglXdBJqKTycVp3BBACoJML5DrC8g6x2CixPXfRTggS/xyfVLg8vVIFcWS7OriCeiHqhB7Eh0dBXdG5IqLcsv2lwpt1RMa2kZ78UDArI7I4zd0qXNc39N/cdYq9BD6yCxwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggPzDBoMg+NSkCkSTSGEpJElqU9s0QggF8m3H/JWI40=;
 b=Ugtw8Mdq5lJyjybhsVxtFpLIVI7Bt6t5qfdb7dgveRFTXc4fZxtCqocA0aHssKirfGBgHInusEYb+AbpQLR7FmeVUQ7T2sCaHsqZsJEr4GQmCmYvEDPlATXt+fJJjyTseFEacwwurCRw7jDkOhyjX7+TRebQ2NhjZVNidrBS7PRTPwB6OdnvAUknKG6xzIL4ZUUYoer6ZwoOTmo/nmhXFYqHj4H0Lw/xm3suBTMCImJNavrSVXrZ3pTegoAaycZH/w8yox3TI8aWFCZHJzsih9uts/6T/8vch15lT60zWtPDYRs0ZGyZHtJhKW0duBqZf4AGFDUu35paniKQqDt9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggPzDBoMg+NSkCkSTSGEpJElqU9s0QggF8m3H/JWI40=;
 b=B7cDtL/Z6R4keGK5Q7yfDlpeKjOFS/D3BG5n72h9cpBghajFCkCSecake3Em7FtXJ4xXdv7Jj4ZPeyW3qVzCUi7GZxiSjk24TpIcKmz7mIHJH6vU93TqKlTExKra33mnHCC121LiujQPOXN/V9LC2ANSFlQehG3xk4OOFSPSNLLy8Cuc1iqikvRnTx6YiuBS08lh38aaAUQsH/quSjNSgHEp6XJgePvydf+cjiV9oCd7iHBlSzwDrky3fDF1a43qk8dvsaeIvW1a4j+PmJ34hpH1FLZEv3M2QBdWEZSQezzoRp0WOUd6CFVKLTzrHdzTcbBLXDgf/ebLmmDfJEOTMg==
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:27:35 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::31) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 12:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 12:27:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 05:27:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 05:27:27 -0700
Received: from mallet.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 05:27:25 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Date:   Mon, 8 May 2023 15:20:52 +0300
Message-ID: <20230508122048.99953-5-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508122048.99953-1-pdeschrijver@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|BN9PR12MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: cb95df79-fc18-4420-36f1-08db4fbf99d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3/hyzTck2ueF/hTMacXUVfjIUuZWgoi3XV1ZLJ2JDkujds0ARQyPXlGMLl4w9FVh1iMxVkYhHsSb88Y8o7rNUM7VQEYGH4GyC7qc2SvmTcbq7eB7Vg7L1084Vc9CYeeAAG8Kk6WmNSbedVWZR1JaDwtnMsS1FZC0sYJaJuMF4f3eliG8fn/iVR2eCPdy3Q4J5e914E+uP602Yi6ZBWGZDvwnjIdzoaqwNB1/jqHpV84WarUdWeZIzSEv2kBIv3J8iGX1lCqS5Vm4r34S0tOO5nKrij7e2ZWctRKu86wxvSURnbUr/Rb5pC8X35hVRw99B/QaEqhXMWwSvEWZnazQ/Av8D0A06mGDGsR+dbNZhuOy8OQyZ5z4bXdCCqgKHVXDK+2S/3A94tVgf/P/kVjJsbnNBqEvWLFtCLrtyDJ0Z1KPrv76KOmG6icl8zKdw4vcYQMJHj5x4Ins4FcYR/JvLnNODCKstui0Z4+qapnhbA6qJ5PeNo3ES1Xg1EUf9Bvu6U4ny902hQEPSlHQTASCSWD/U3oy/jf2vzuJExjh3xNaAXqKUqczGj8sUnetp8GxNIFwNErAKGEbAfsnDcJPR9TupFccbk6X+amgPZlznrqVdBpC/ZM+ePYB9UYryJgYmBhfyPYf8/7QOO3B+rE6/uje+ox1uuchj3A35+Eacw34m9c4vwX9W21KbnU4Mr7E8wryEGIofpd31BBX9ZechUbFL+lE4Z6kzdBWOQL7LLJd8ke6c457nNrgb/9ZGSm
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(36860700001)(426003)(5660300002)(47076005)(356005)(7636003)(82740400003)(82310400005)(36756003)(86362001)(40480700001)(54906003)(110136005)(478600001)(186003)(26005)(966005)(7696005)(6666004)(1076003)(107886003)(316002)(2616005)(8936002)(336012)(8676002)(41300700001)(70586007)(6636002)(4326008)(83380400001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:27:33.9936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95df79-fc18-4420-36f1-08db4fbf99d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for DRAM MRQ GSC support.

Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../firmware/nvidia,tegra186-bpmp.yaml        | 69 ++++++++++++++++++-
 .../nvidia,tegra264-bpmp-shmem.yaml           | 40 +++++++++++
 2 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
index 833c07f1685c..d818cfe1d783 100644
--- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
@@ -57,8 +57,11 @@ description: |
   "#address-cells" or "#size-cells" property.
 
   The shared memory area for the IPC TX and RX between CPU and BPMP are
-  predefined and work on top of sysram, which is an SRAM inside the
-  chip. See ".../sram/sram.yaml" for the bindings.
+  predefined and work on top of either sysram, which is an SRAM inside the
+  chip, or in normal SDRAM.
+  See ".../sram/sram.yaml" for the bindings for the SRAM case.
+  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for bindings for
+  the SDRAM case.
 
 properties:
   compatible:
@@ -81,6 +84,11 @@ properties:
     minItems: 2
     maxItems: 2
 
+  memory-region:
+    description: phandle to reserved memory region used for IPC between
+      CPU-NS and BPMP.
+    maxItems: 1
+
   "#clock-cells":
     const: 1
 
@@ -115,10 +123,16 @@ properties:
 
 additionalProperties: false
 
+allOf:
+  - oneOf:
+      - required:
+          - memory-region
+      - required:
+          - shmem
+
 required:
   - compatible
   - mboxes
-  - shmem
   - "#clock-cells"
   - "#power-domain-cells"
   - "#reset-cells"
@@ -184,3 +198,52 @@ examples:
             #thermal-sensor-cells = <1>;
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/tegra186-hsp.h>
+    #include <dt-bindings/memory/tegra186-mc.h>
+
+    hsp_top0: hsp@3c00000 {
+        compatible = "nvidia,tegra186-hsp";
+        reg = <0x03c00000 0xa0000>;
+        interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "doorbell";
+        #mbox-cells = <2>;
+    };
+
+    reserved-memory {
+        dram_cpu_bpmp_mail: shmem@f1be0000  {
+            compatible = "nvidia,tegra264-bpmp-shmem";
+            reg = <0x0 0xf1be0000 0x0 0x2000>;
+            no-map;
+        };
+    };
+
+    bpmp {
+        compatible = "nvidia,tegra186-bpmp";
+        interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
+        interconnect-names = "read", "write", "dma-mem", "dma-write";
+        iommus = <&smmu TEGRA186_SID_BPMP>;
+        mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
+                            TEGRA_HSP_DB_MASTER_BPMP>;
+        memory-region = <&dram_cpu_bpmp_mail>;
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+
+        i2c {
+            compatible = "nvidia,tegra186-bpmp-i2c";
+            nvidia,bpmp-bus-id = <5>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        thermal {
+            compatible = "nvidia,tegra186-bpmp-thermal";
+            #thermal-sensor-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
new file mode 100644
index 000000000000..6cd9a61cd31f
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra CPU-NS - BPMP IPC reserved memory binding
+
+maintainers:
+ - Peter De Schrijver <pdeschrijver@nvidia.com>
+
+description: |
+  Define a memory region used for communication between CPU-NS and BPMP.
+  Typically this node is created by the bootloader as the physical address
+  has to be known to both CPU-NS and BPMP for correct IPC operation.
+  The memory region is defined using a child node under /reserved-memory.
+  The sub-node is named shmem@<address>.
+
+properties:
+  compatible:
+    const: nvidia,tegra264-bpmp-shmem
+
+  reg:
+    description: The physical address and size of the shared SDRAM region
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+examples:
+  - |
+    reserved-memory {
+       dram_cpu_bpmp_mail: shmem@f1be0000  {
+           compatible = "nvidia,tegra264-bpmp-shmem";
+           reg = <0x0 0xf1be0000 0x0 0x2000>;
+           no-map;
+       };
+    };
+...
-- 
2.40.0

