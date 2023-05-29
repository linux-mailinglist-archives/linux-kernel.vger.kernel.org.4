Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE33714B57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjE2OAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjE2N7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:59:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E461911C;
        Mon, 29 May 2023 06:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx6Wcttn5qJIBGeTcCoua5blWLt5ATlrQtuX4a4mRfbKQOKD8EVinRZg4rYb/7f0VEyLyLkuSCZcKKcV6kK0MJCj4ybZjkEC5I6/dOa7NgN1OKC7lZWgUyE0OyVtXBpYItzSudpMwvZ+KwhBikl14uYi9k8GZfKMBflhWaT3UMz1YzanGWXyz8SyRKRlSLtc/ryhGKaTgxNqedAWmooasXLWP1cq9jqBo+i1kkLfrvDPspZTd/iUuxbsXVVo0tBGZ6Kr7pE/rBhTkJZaD/yGgn/41Pf8LQfCWt3NKgxcFZWOI8v1hz3aSQF1vbIHG2/oFKDjOWPXzf1bjrtb6DSD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzZclNwZ/gObFz64Ogr3mJnAUnptUU1kiFRgvAChbgQ=;
 b=TLkx6NOP8nG0S6BqGypuyq6PfYAn7I+c6kHSAZU8Za1HoEJgetJppnZK6rveKmsjgSj0i34qx8hDDohHb8p3ay2wvg+JQNCzdLlHYFBELlCM7I0vTPXcNt2M28if5ko7bb+kbUVx3bF7V2CEAWAxH5v3/3fUPJI0dIyC4VLZnH7tPZaixQEAW3nzI1DZ5u61042pzQSsANbnVJNR0flYKKmN1XuFnDZnTlU87g8ezVYTmkaEWWgKZdf6Jfncc7viqIhgPi6m8wDKSBgPZBhNIAUUC70XOkJJyuvXzsEebt4Hj+MlrJw8fEc3iLp7ENUl0LlqYuWp2It776EG30A8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzZclNwZ/gObFz64Ogr3mJnAUnptUU1kiFRgvAChbgQ=;
 b=WoAuuBS5v9LinDRx27ksgpP0hWRygDFpDWAR41XHC8Eb3TpK7fkcL5ot0MQlVPU/YcoYyI5F2H6SIBCA5k9hXPj2YL2g0v31DvMF30XiV1YZ7XDfhVWMLuFyzt8ZeTbdaZUWS02f4iZisr5Bd4hESmnqEOHeZWSZFUe0tlf36y98EJizRQGiceMTO8NEs09vZPvPYX2JI/1sDDux7CtvOkE7drnwVgcSxohj1FZ8xXC2Or3Vc0BMOZQuo50H9HrsByetVHBo8OwW4RwKCmmzCwX6e8aEBK3f21YVdsWXFypo1wF78+D3wJTZgpqJLbaJ5OxUixAC7sFuRXY7EFE7Bg==
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 13:58:27 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e4) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Mon, 29 May 2023 13:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 13:58:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 29 May 2023
 06:58:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 29 May
 2023 06:58:18 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 29 May 2023 06:58:16 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 4/5] dt-bindings: firmware: Add support for tegra186-bpmp DRAM MRQ GSCs
Date:   Mon, 29 May 2023 16:50:49 +0300
Message-ID: <20230529135044.2746339-5-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d95b816-2c2a-4649-52d8-08db604cc648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNABfjEdBjWEAYNA13OOULzqDvpbM2wEUOQxJIG6C9b2CiTFt0GA4rkG67wVVnTDaNAU3oIr1R/XAwQpp2iKKgcIIFWG+BMo7k9Wam/SPdji4xy1TMXZZ4bh3JuvS1x3AZ9NmPHNzDo4ES/i04kj+0g6oD4uEVeoYYWg0mSNGy/SsltJ2YaeQyzjIZaklL11iR8TmNVfJ1P8862t5j8pudIE8tTB8EwwS4xXkDR3NE42PwYHl2Xnc3S3mQOrH1wLEvd7NdQFGx+gtmTUoTufkGEc57QvylF66sAPjx5LkUM9DBLUBczILcF2DQVaIMcndn8snxz3sq5us0XdsuLA8C2B9n4F8pDahso/ZElz/bIXpPQgUe0Qp53sxFTtqxH2d2PfEw5NSt17nylQ7aQDfUDi25VMrPHy5JsqzWX9HwRcB2pZ7q7clr0q14FvmJBZBpnKr/kiUg4Clu9Wsp6bH65gTue18NSV1XLSXOC/0DgADT341GumfnxdBhxuK3HT/9XpdvD73uqe+ZoGQu4Z4lAeK4JyFtdfH5PhdEvS9I3b1Mfk8v+JRCZb2O/A0QwEpxVlB11Ck7xv0nZlQX0WVUR/0eTxr6ILXdnnMgtisI0waowTzukq7Ik0ZPzhYa6qqXI7aroR1VIT1JFZuiw66Qnf/tcBSoj/fLo8wDGtKSD63OBzIb15mpWc3JLJcslbK+1gk4Ck7yykf4xvYvbQeSa0ZSsBiyX8V1QRrxLvBgZv99//yuKtZ7GR4/eaAtcN
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(478600001)(110136005)(40460700003)(8676002)(8936002)(5660300002)(7416002)(2906002)(86362001)(36756003)(82310400005)(70206006)(70586007)(4326008)(6636002)(82740400003)(356005)(316002)(7636003)(40480700001)(41300700001)(186003)(36860700001)(1076003)(26005)(47076005)(7696005)(426003)(6666004)(336012)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:58:26.2529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d95b816-2c2a-4649-52d8-08db604cc648
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory-region property to the tegra186-bpmp binding to support
DRAM MRQ GSCs.

Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../firmware/nvidia,tegra186-bpmp.yaml        | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
index 833c07f1685c..c43d17f6e96b 100644
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
 
@@ -115,10 +123,15 @@ properties:
 
 additionalProperties: false
 
+oneOf:
+  - required:
+      - memory-region
+  - required:
+      - shmem
+
 required:
   - compatible
   - mboxes
-  - shmem
   - "#clock-cells"
   - "#power-domain-cells"
   - "#reset-cells"
@@ -165,8 +178,7 @@ examples:
                         <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
         interconnect-names = "read", "write", "dma-mem", "dma-write";
         iommus = <&smmu TEGRA186_SID_BPMP>;
-        mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
-                            TEGRA_HSP_DB_MASTER_BPMP>;
+        mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB TEGRA_HSP_DB_MASTER_BPMP>;
         shmem = <&cpu_bpmp_tx>, <&cpu_bpmp_rx>;
         #clock-cells = <1>;
         #power-domain-cells = <1>;
@@ -184,3 +196,20 @@ examples:
             #thermal-sensor-cells = <1>;
         };
     };
+
+  - |
+    #include <dt-bindings/mailbox/tegra186-hsp.h>
+
+    bpmp {
+        compatible = "nvidia,tegra186-bpmp";
+        interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
+        interconnect-names = "read", "write", "dma-mem", "dma-write";
+        mboxes = <&hsp_top1 TEGRA_HSP_MBOX_TYPE_DB TEGRA_HSP_DB_MASTER_BPMP>;
+        memory-region = <&dram_cpu_bpmp_mail>;
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.34.1

