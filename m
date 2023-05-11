Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB616FF2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbjEKNYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbjEKNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:24:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3062B106EC;
        Thu, 11 May 2023 06:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5DhZnY3XUchsB+cUYL6JKj79QL/XSQeFz+xqRGcfKVX95VldwLzaNMRv0VFOhpa2OU/3Rdcx81BbGoC5LAzF5s2lWEOmk4wUrp1luvvuJ9pj95XlcLpZeb3uX9yBo9W1DVyfyp7dbn/AU40vNKN11Rqz53G3GY4ANP2LpqwKHTLpCe8pNaatITkXbhlJFHyz67W9kHBoOS9Qyek/l+w2m0/P/dd3Gxngzu5jCGsm9epRLdw/aQ/H/haeQlRQ/B0fNaqrcN6dVJ/k8uwIRgqCWUZK81kLNwyXchIa7hxwiPgcbWh47Z9O/AyMkSQqp0Xgs3IaR1KDpkNp1OSuW1+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLbpQVxDrVejfcTM/lgsnUfRWa0pYoPEX6QosRNCiXo=;
 b=MTsh8RDonbdjN1dvHG6TYlm/2HUrFt8tcxuMTMjEdJ4bL2c+/cq8RmoeP71TXYGZDp1YLa/+9UKUU1hcZNi2zRLi1PLC0LEo5ua8pwvr6WCxccbn0LCTgNOhMTx87o0bReRMrmNXu7GC/K+zca/PJJHnXqexFc+qP1Ub3xDHCMLQl39umOsXxM6hQLCujMF6qATs6MTiLEhxl0v8sVDw0vdmIpewsnp4CVnhjMFlUntacwKjMYqpslIIUpkM4YdQ5OondGnDK/Ga1cXIaB3Hu9oRGvYrXMI1dXstUjlfl6c5XWMEIyxwQzECv2TEvn8X2R3B2Zis72Tgxv3z23HnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLbpQVxDrVejfcTM/lgsnUfRWa0pYoPEX6QosRNCiXo=;
 b=iMc4TttV4sDDTovTX2ZXbaX14dufSMZEKuXww/d9B+73Po2PrY6hkcZkbzULdeFv2W3oM637n42EO65UIsmEsJfNAIjY4ldagYCTztQmUCuvVEBqzpE6wfEwta5/FFXx50RyjbYBuKztZNUGOgfHBYc52jI7VL+MYS7ySLofKw8ThRTE8zdcAsf5LO33tTkE0y+JZWCmdXGZhRvgVF9DptjVybD2kM7UKM7NUDC6UEzD6kwtXa5YT1fwAAlCd8FsZt0zeXCvWW1visSYDLPISNjIpTNyH7bhGhW7v31IZCGcVbkct51PKwS/IYx6vkxBQdV4BaXhHYImHATQP68ahQ==
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 13:22:06 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::6e) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 13:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Thu, 11 May 2023 13:22:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:21:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:21:46 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:21:44 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v4 5/6] dt-bindings: Add support for tegra186-bpmp DRAM MRQ GSCs
Date:   Thu, 11 May 2023 16:20:50 +0300
Message-ID: <20230511132048.1122075-6-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 424d933b-8e5e-420a-1087-08db5222b750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TS7wAYtTOJjLqaYbPh749jzpHd3lY1JjQ9OauS5JZiX31wnjLxcKaSWPxrVoPAe1Q0tdLhnY+YCqmCYvPshh1xe4dgAuSlgIdXhk3rZTsrouIXukcHJn3gbC7ULkP5+OOwQ1hdiv5KnDSVb2nnI7ov1MVi+PCaqoBANIlKrlwGawNESKiys6r1zBzTBBKOvbS0w7kabgaJVH/wp8ZfcyeYaFzL+JnQ/oj6u9a/JqqWYbIerPHiKd0k64haivhzixCUIHIX0P8+JAR4aE2Gyn7msmP5atV9co3U+HEZkTgmlvXyrlkkvWM8rfv9oZGEgS1Paaojn56PxFUbOSRyYEAScD6aZKwRgDP2RAluFP13iA01nahWSRJq/tUbCtl6X39WcZkU08lwgRiNYngF7oVWgTyZlQvJZen/WAMACtuGc7xag4BFhx2D7mQDZCEWeJO+HssRhS5MyyBlUeOrSdHEqP1TvGz19g4CHDJ56cEzJh39CD0a399H9J3jylhmOJKbI/pWYXxndkc8tRyxQO7BHlPFrA6mcQ925L1gqb/BW/A21Rc8bWzFW1wWG5Bq3Z5nDo5thDT4MqeFRdEp9hnCiTcrLBa1sASRzmN5eMePTob+w35vPa+z10mj0GIa7T+uiBt54ZsEoVXKdJup+p38K1cNs/P1hb3F4E9H88rTS8hZR/U5eRo9np43E5TUKLLFmgJ9SQNrxyfNIUEPLcsg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(40480700001)(54906003)(40460700003)(70206006)(6636002)(4326008)(2616005)(8676002)(107886003)(26005)(1076003)(8936002)(186003)(6666004)(41300700001)(82310400005)(2906002)(36756003)(7696005)(316002)(478600001)(70586007)(86362001)(7636003)(356005)(82740400003)(83380400001)(426003)(336012)(36860700001)(110136005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:22:05.9494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424d933b-8e5e-420a-1087-08db5222b750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

