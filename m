Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6386FE00A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjEJOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjEJOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D247449F7;
        Wed, 10 May 2023 07:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzBXUxO7bKrP+JgJ50lowIgaKVeC0OIj/k/AN+yThfxX6bulk363FkjStuCjRoAjo3Wef6m19io1ehNtAjreoOoMPkdnL4Yn5gl696ZvEyWKoDujzL06C5Hf55IO03fzSeSqdm4QzRFe98WktRtOJn486mKqUTGBNr+puSKprEFSHD3plmNVAI9VT0jaR6VPc77EJrzyCebSaubHEJVDaZHcxpsy16JgZwdunHNsR5rlbvsKOF0f3Pwztc3aVd5ZYZYm2ENRjCBSwkjUyK0N9Husmf575H7JG1zNTey9teFhaoG+ElzfvXcpY1jvDKO2OSEz3VesCXjWaCo4xT2/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLbpQVxDrVejfcTM/lgsnUfRWa0pYoPEX6QosRNCiXo=;
 b=eP5yCIrdKYB3lb1qBkdEtlb6HmnxZ9SF6+l25QnnMSXN+wLg4plrRR4dqSgNjrV5hnXCJVZTc75XOYfNMveuET/Dmzk7Wt5xNkZT8kuvTpIOlkfV75pO1u/gy9lW2HCD1YCafdtrjjSGWWu7ArixgY3V8hMIZjuXFncAhSr6knQnItQeJ6Det90yWwGhx0qgeRKIrbtTVqB5H8t9jAAQ+G5AkSy/BWvQD4wyy+WcpZrZwBvXGZwRhna7sl9Dd3ornhZcL5jNB8ocT4nEs2NHmnNsETG/BC78ZWDUnzu3+6liuc9gqm+UPrFrQRhBY6Lw2obZ6UfheSWXhpWbd7xaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLbpQVxDrVejfcTM/lgsnUfRWa0pYoPEX6QosRNCiXo=;
 b=c4Gg1OUk0Aeoh1m2c7kShsDBqlFbpmuhyX7nDCGCOg9+6E+ciXISRXGTOy5w2MnqPvD9P2ZzW84B1meLX+Mx7atzwiLS51zsZY+Fze6c2BPtYHGCRYI8SZPr+SUCRQub6shPN8vfq6AbHT4JnOHO69v59WPirGanjUxe1hNwk5D6H0ovp4tjZu5koy3b9G2DmvABtdN2JYJMI/E7m6JYqDfm5DMN1c1mM/cgw1jqJgVgKsVVpNR6DQyGbq4Rxs+YNMALccHbD/9cFOMYVfl/m+wriwxzizYW6JfK4fE5/QD4trGmrgh+7LSd9AnhuQWDgA1yQ+yJvMT6my7lyiWv3w==
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18; Wed, 10 May 2023 14:23:32 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::e8) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 14:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 14:23:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:23:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:23:20 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:23:18 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v3 5/6] dt-bindings: memory-region property for tegra186-bpmp
Date:   Wed, 10 May 2023 17:22:47 +0300
Message-ID: <20230510142248.183629-6-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 28045f8f-c61c-4b68-6f3b-08db5162221e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0T4w2e9lkdCfE286IPlwxmupTKoU1O9N2tgm1nMPYdnGxT8yePkcJzEF5Rflq4UTmkYAy+dfBeIatTS6uWWZ9mZ0uWIH+b2lj9bJkoy1eFett0+wtYVG0ECxJQOaVaEbDFM3arnWn+ghqiyfohyLfdP+RV3FWXymfA3R58+UdF2qkEFoOu5PSpDMOQSQhEPpb4xkS1Btz/nK3MoA3Z+RK+HZjRrXR56R2ksfvKsWy3Htp8rVf8Jq6dN+EUPQ5QRPgbfziYsxDs/OkwqjLxqEFmF2BTzanPqEgG66heYuXSaugI56gHlqAAyvb1onr2gm2ZR6NNH6pfawhmGQNvQAqeThDSLHVvZrpHjeSmVazNr6VvlaR1MwGlSnrOtC/liTcFcol4Si1+LPxWfBr285Y/3P+c45MF65YNVOlC5Syzcl9GY99AI+r5JRK8otTMMv96Zux3axRf/12/K7Ds5lTeo0Fo5+dZA6iRIk1hbgOLzNHfBpAT/ET1oIB/y5iDDBbVS2ZzMgusot6qJxmvI4eHetCAZoHHPc0LfpCokJQ7B69Jg0W/VwELyfmd87kCkmUp5tGcgtrzsbYdkIHhikgcaF7/di0JCYw5qWiEnJMPh/u1IGjGub10pRoggAS3WV9n+sBkbib9Vm2FZNcIvM1LzvJrC6pW59NXDrL4PzjjFNAoCYUof2bC46tW6gqXEf9Gk2wGltPiKoE++JzNJKnswbj98K2xt2PSk9bA9s/clByxbAgBJFifayo8uPqKG
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(83380400001)(5660300002)(36756003)(47076005)(2616005)(426003)(336012)(82740400003)(41300700001)(36860700001)(2906002)(8936002)(8676002)(86362001)(26005)(107886003)(1076003)(40480700001)(4326008)(6636002)(316002)(186003)(356005)(478600001)(7636003)(110136005)(70206006)(70586007)(40460700003)(54906003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:32.2559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28045f8f-c61c-4b68-6f3b-08db5162221e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
---
 .../firmware/nvidia,tegra186-bpmp.yaml        | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
index 833c07f1685c..f3e02c9d090d 100644
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
@@ -184,3 +197,21 @@ examples:
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
+        mboxes = <&hsp_top1 TEGRA_HSP_MBOX_TYPE_DB
+                            TEGRA_HSP_DB_MASTER_BPMP>;
+        memory-region = <&dram_cpu_bpmp_mail>;
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.34.1

