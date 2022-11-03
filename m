Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90610618687
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiKCRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKCRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69E1A817;
        Thu,  3 Nov 2022 10:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZqRpBykx/ZC0fKOHfJQQ0AeYzZNy2o3UVdpbj0DqSTNW755n+AfhPlRf8yPh04Pfq1H3OqwMyuBSBl0QdXz1xVF7jwPjcLZaw/gtcwV5Fh7xjoi9sG3ikiWgc1+nHQjiHZTxhmq03Y+lD7DdvZbAYuVVf42nhpPksI2faEJ4FpWYkJ43Nk4OQFWSOz+YVbOIKEK37uNxbC3GVgWVCdBcDEkM7Vxz01QQdCS/7Vh9KLEHVPqX9As/+IEmfFeFm/R9VOnw5b2TMmE/IaaMD0dqEkW5fEEyBSFb0CCdKoktLKwDKTn50fMoj8nLecb9vwuxNCMzSBHoym18kSoDH0POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cppyvgqds94o3k9iW6NBlfmhi6W+iWWhvb03akvEwUY=;
 b=E3yN3jd+YNv8l0OjrufFjj8G99KSXBuZyGXADIDdFSW8AQQqKinnKxDuBea1Vsw66rn3uJqdDQJM/4zFcFhlwtmvRZUpvhpqVua5BYfOM3hq84e1q2pHdLVRe+JeAH+cm8cQ3395V104V+QDcRrmXt5RYuqcJCjlVfmO4WAIQOy0/NwXPwMfymcfHntvLHQGxo8pZ4jsNwlar+F+FA8h8d+ST5w8CxbRkGtA0kfWhFBNPxjMvPcdn5loQY2PjA7bQUiikrSU9yL9D4XWEwzGnJBsI8OOGrDgH4kY3IUWsfzWQlpq4WlmY8p0DCxXBUMOqAR/94PscHXgu3hJqGyleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cppyvgqds94o3k9iW6NBlfmhi6W+iWWhvb03akvEwUY=;
 b=J1rIncxP+Mxndj7wiOjpAOjCJhaG1lo2FmT/OdPlUYM5wgU3jsLu4tuf9f+Dd4dgW8nmR10ejpFjrmzU5coKqppClwoPr5dfzMM2O7M8eDUY/HR5cQnzI7KV25tAB9iTblbinjzGXN/EznuGEUCglpK+/jeKqqvlspvz+vMlh9LPluVoNInZHE9qFLc04wDd4CQ5/jwkvw/NtcU1ZkWwajvZF1LrM8/DDankSSFp7X2zt+TSHM8+2jKqQu2WvhHfMFGx+/jRcJuXu+1zpHx+Ni4X2KjfQBW6mbja0eBfgMD15vqZv3hVCQQMevZFgpSGpP9plfPrDWloSNdn8zXwUg==
Received: from BN0PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:143::17)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 17:45:53 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::74) by BN0PR10CA0013.outlook.office365.com
 (2603:10b6:408:143::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:35 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 4/7] dt-bindings: timestamp: Add Tegra234 support
Date:   Thu, 3 Nov 2022 10:45:20 -0700
Message-ID: <20221103174523.29592-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: c99784d3-3aa5-4614-35d3-08dabdc340a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLyNWzNTjfFcv1VcMPLDbCyvLIPrik6qvkooU9zG8pstf2Sg3Jv7jGOqgumQOkM1V6IQSb4oR8knMIuEJH/Ml47gScbMoRT0z3Nd/2xmxF2z7BcV8wgLgMyqbwauOCQBiBe6I08nLcek4kkx8Gsn4eI7jS8zy6b8CWBDRYKQWBznuU2n+fMcXYgyfR71IFIHBpTpSrGXy7ziJsJZAegXVyM/wWVXpxj7/bA9sq0ftd0BCorhkb0bNFrkUSRz8/hJK3xfe49X0wTB8PNyd5Dxb6U59/opIMT75GSgObXzmC5K02K3o90vHbbnn4dHJZ8RSufs+Cx0bv17J/MMiTaRkyUjqMDbm7TUXsgaruGFiotPUG58Kj+ENZAPeXTnarRoyDGRGzqYitEHUhFe0WQbGzJkYk9YCqE6RQT7iMIt6o5g/Cd1lCE9scTuKCYxerIIUUWPBL3HlYmGoPjPuBpIZJBDLWzVzCefQlbkh7zcfY6gAoBPIIw+nQMYtQ8yxqDpU8VOfjX4PbpY6oWTuKwp08SHmPrUcksmx4pIRgrBS1XWOKyxq93q1tIK2UsMDyC03Hgl6RWnmuo9AiPTZXaXjzu96A7b6yARmkPIGnLnhZY1jAdvPNDAanQEPrKoCJjYmkFxfVOG4sup0+xcuEzKY8v8U8xIiPlMbUzp3vL19JE1tZ+k3bNsxG7FQDorHRfF5ZEZsYFWIHL1Ixny4kyd8ZTZGdoR36sjAdDSm9my/mmgom20gOsdmisi99EunFSQWWpCqgvuSH4652MAAdUdHaBZAW3CSBQUz//0BalBopXk2JraWb4yYh/amSN2gkDbj3WqPkHhhyHwHBNy7UNnyfJ3qpWT8FAjyWwz7UfDzyt0iFLckZ/8V89Zc/1rct5roAS4Q2/MJtknz6+VRZppeuocez5doZX0Z60GEarkaIs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(110136005)(316002)(107886003)(6666004)(4326008)(478600001)(336012)(70206006)(7696005)(8676002)(8936002)(47076005)(186003)(26005)(1076003)(5660300002)(2906002)(966005)(2616005)(41300700001)(426003)(70586007)(82310400005)(40480700001)(7636003)(356005)(83380400001)(40460700003)(36756003)(86362001)(36860700001)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:52.4582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99784d3-3aa5-4614-35d3-08dabdc340a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added timestamp provider support for the Tegra234 in devicetree
bindings.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 .../timestamp/nvidia,tegra194-hte.yaml        | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index c31e207d1652..158dbe58c49f 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Tegra194 on chip generic hardware timestamping engine (HTE)
+title: Tegra on chip generic hardware timestamping engine (HTE) provider
 
 maintainers:
   - Dipen Patel <dipenp@nvidia.com>
@@ -23,6 +23,8 @@ properties:
     enum:
       - nvidia,tegra194-gte-aon
       - nvidia,tegra194-gte-lic
+      - nvidia,tegra234-gte-aon
+      - nvidia,tegra234-gte-lic
 
   reg:
     maxItems: 1
@@ -43,9 +45,8 @@ properties:
     description:
       HTE lines are arranged in 32 bit slice where each bit represents different
       line/signal that it can enable/configure for the timestamp. It is u32
-      property and depends on the HTE instance in the chip. The value 3 is for
-      GPIO GTE and 11 for IRQ GTE.
-    enum: [3, 11]
+      property and the value depends on the HTE instance in the chip.
+    enum: [3, 11, 17]
 
   '#timestamp-cells':
     description:
@@ -55,6 +56,41 @@ properties:
       mentioned in the nvidia GPIO device tree binding document.
     const: 1
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra194-gte-aon
+              - nvidia,tegra234-gte-aon
+    then:
+      properties:
+        nvidia,slices:
+          const: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra194-gte-lic
+    then:
+      properties:
+        nvidia,slices:
+          const: 11
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra234-gte-lic
+    then:
+      properties:
+        nvidia,slices:
+          const: 17
+
 required:
   - compatible
   - reg
-- 
2.17.1

