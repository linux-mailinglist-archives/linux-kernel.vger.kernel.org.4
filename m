Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229266D9E91
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbjDFRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDFRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C8B74F;
        Thu,  6 Apr 2023 10:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKCeGQbhUwt3N4Ar6blZkX4Dg9Ogx452/DxAdt8jRwmAef+4I7WG4bwforYVuyp6Xb/JxWaQ5U7oBFgaJzn7NOe3BwwMHx1oMlfYnj9pYgecDH/ArERLBWtU52X4ty/X9a9cD1rCDnV5vCfcBY3wZBocOUQ7wZtZFLKYjlEEud+kIupJkJM6QdYzqFMwZvulkWqpJxHFdmvsKQ0X63Yy3RtCEzA4Av4YkPBgljlNsHkbYvZU43nVwNJO89XaID5maNvzT8j4SvRcPGxQVMnxO0qRTug8Jsm6t52DAz6fbNEdMPAvorLSqbUz/ur6ojZIHbHTc7A6A6cDjb93Nc5MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq6UmJPHke1jcU1XfRhPlhhFfZbQYlbpC9SF83EL9xc=;
 b=VSz0boJK1Vy5T0sU4/e/nF0/zhWxRilF13fPt75f9ODOSKY5cuTx1qdo2lvcKgpjSTWNAyrc5tLGHt6GHvT8J2jC87Aeffp8dYuPSmMiiZpAHMPT8CGSM/iBLATJVRp7HOj63oIAnHNiqqOzhvfa54fZ4UtQ59SlUTjyJYdT5ILgzhlPcKBA1ecipSyTO4ueh65uUPmiP3mDCSrZ7U5HS5mfOgCNE73zmy91D9M1EGk5SprDmY7yNBWe6hf1l0Uouuwx5Sabm22F9MU0q5v21mpRwe2X0vs5V7Sd4X0JFf4V0FTyAYhPy1CehLpZYmfpm+n/v2KlYnFaTZZihzehQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq6UmJPHke1jcU1XfRhPlhhFfZbQYlbpC9SF83EL9xc=;
 b=R+bSpCLVwkneSOZtFpOSDqEzktZWLZ9NylEwFjcxSiNQJk6VURsl7u7QqIK23N0oChVptqp9eILCp9ArHHslhaZs/rWCgKO7G41kBzRzKhBkU8CW0ZZXOmr0o5ZPaayEWySUokgZI0SBsTP5TSm2G6PaRUF1ozADUC4uN80lYLPPHr+cIdOAwgWdVAx105M/k73dgYhmGxrVJS4Aw1Wq6t0MuDZcogw/AJEALEKLTsOsFvrw8yu8BrVRo9LUHCoxshxAdsj6/EJ8FebRD8+9938h1Y+NHh+uOSauM3CZPnE8iJIyJmHHss4fTRT/qoESyUqBt75wC3rK8aKph/PF8g==
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 17:19:06 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::c7) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Thu, 6 Apr 2023 17:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Thu, 6 Apr 2023 17:19:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:39 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:39 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 02/10] dt-bindings: timestamp: Add Tegra234 support
Date:   Thu, 6 Apr 2023 10:18:29 -0700
Message-ID: <20230406171837.11206-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d5c99f-f7fc-482c-b663-08db36c306a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvdTzGWtNW1BpwU+MIqhzU28qx1RYlQFhdespwdfgL/ft7ABSSuH0G9V56wDGaXyAv49i0OHSfc+XB3lQWeKmxK8IOI6pM3CfEmV0NdZYXAP8zEkIZxtTmAUsDjUv3eRPFJKwTR5VDIi65rZqiFASnYEU6/L2wROLDo6f83HPdrGHnxsn2JafP3cgnNMbqImYl9TW3XMuPArw9TuSCNOsrJCev2Vr77zU0u0gN7Lf49Iurog/NhIvadRHSFc5szW8RGT/uiIqybSeYCDtwH5N+gsurrIrHtEqBvYRgSQXKnjsyeBlm3sPvfRKexGLzZjxhPqwlaM3RBQT9DfXKi3glrJ/8VD6ED1WizeYOWilTpBpXc4fxY9V+rKJP1VCW3aPwm2kqyuIoeJ0AJQWrt7YwdZDw6pQO1qSGIxpzp5MqrX0RsUkQSFTHbFWgh6wfllPiBTdeCh5XyKSkl5TUiKbHykbC2r5AvU1KQ+aN7YaqvmvcqOT9XaRGe9ag8YOP0QkX4AgvKLYWGkHZukzmA7t3l1ifG/iBMU1Hr6qT3OC+upLrnicbfUhl8Yl+2I90isKHVGdjYPyTC3hzrSMoL2RiKpscw1pYdrOCLeJ+Ut4iQuCD73EiTNgLyCzrp2/GFatnFJU/k7xJ/8L+R5jmAqRVX4oFhVD+T8eRPkWZ5OgnxWiYueT7aOrhC16Nl8D2w/YTzVJxMYGOlQ8N3rtGSXpLR40JNRsGICpCx8Dlxt+f4K2AmMiCFvmBd23QGnxdJo4dERY2zijw/1uCnhlqfX6ADjj8syILJyHM38862DEqzwkJ0yfbU6UcNjDuHD23zdQ7JOWf34+4IbdFcRaYrDN3kStbnSGLXfQUU/s7iWVOaiKO/2ojThraRlszrPB/qOrgvJR5ESVQqu5a2dJdaCRw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(110136005)(478600001)(186003)(1076003)(2616005)(107886003)(40480700001)(7696005)(36756003)(966005)(2906002)(86362001)(40460700003)(83380400001)(6666004)(26005)(426003)(356005)(70206006)(70586007)(41300700001)(5660300002)(8936002)(7416002)(921005)(7636003)(8676002)(82740400003)(36860700001)(316002)(336012)(4326008)(82310400005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:19:05.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d5c99f-f7fc-482c-b663-08db36c306a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added timestamp provider support for the Tegra234 in devicetree
bindings.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
- Removed nvidia,slices property
- Added nvidia,gpio-controller based on review comments from Thierry,
  this will help simplify the  hte provider driver.

v3:
- Explained changes in detail in commit message
- Added allOf section per review comment

v4:
- Logically divide the v3 patch as follows
- Created Tegra234 support patch
- Created depracate nvidia,slices property patch
- Created addition of the nvidia,gpio-controller property patch

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

