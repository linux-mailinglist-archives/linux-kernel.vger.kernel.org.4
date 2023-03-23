Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553D66C5C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCWB37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCWB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E63AB5;
        Wed, 22 Mar 2023 18:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2NyKuhwvQHKrJ1mLQzoHzDHiQQhlt7JuX+qS/GkosSvxT3N989QUO5vgfaQzDV90FgQ30K3MSCI7RBqim8OlLJPxOQCERHzLnESqrmOifqUuM4L61gu0gHY7Qdru8diGRGNqV3RKf0ul+815Ds/C5G2oo5Df/79qtPhDe5JAQ0s1zad2bS8Jg3KrfyK92kEUIbXq3pHPfJOYal6m3ItL3wnQoDgMYpfyQw6dyTtuptN1p65E2u34khnO4m/p4ccPch4Dhx6XVIJ7MnJ4VgErEsrRN49oMjZ0DH9cmgTq1UiTn5P+exD4sF3TAxTye5E+dcxLPhJxawiOJyPQV57/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG9Z9etWlohMIrbvOzFyAIxV9lXcepZbcGTnji9eEPI=;
 b=KCIXrajmxBfcJpzN2cY2i3nOrtGv/GBnssflO3y1uQwIK+zheOV/w5a5oTbOdv0WLCpyLLgEkCkf2EZ2nIRLA09Enln5KnTajXXfw9Dvb5DD2G2ik06XIP3glmegGAt3PhMzQRb0+Hs2Hev4uDA2XvwfXeqiEbpw0HzIVXy7P7a/2I1VYFiZjFIPEDa7Ztz+FdL+NcAxAQ3Eea13yBSbqjFvpRGFEOUr2o5nzOpYVYVya7fQor4QgOo2DRirxBXCP52V2RrKeMvvF8hWf9Gyt73uwJxIvwjgZclK6futqssiPlFGRj1nz1zaReCziUcatfxIJ8juPU/tjV9UuzN1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG9Z9etWlohMIrbvOzFyAIxV9lXcepZbcGTnji9eEPI=;
 b=PmUajUvtxHLfL7DyLw0B/8ZazrCrNWipLsHej4/xRnCRYnjiSmr1ksxcX5D0wWXNeppTMWSTAceWGDyDBL5/HbfsWGaWO5Y0bxbgUybV3dLbQzgMTipl48q7BYPxevIGwFxGYikqUvGxibGEA3ys8vehWdKJ40Vva4fTNaCgsDKm4JaeIFWCuEfrFLuTinnzRZasLLDegq0aSK5IN22JbFlcpdkAf3qnnCIUyRFGgI8iJ4H83pmbPAZT0cYp6duDxTyEqoCeL84iahMM4ODtYdsSkUz30AaW+mbe6JnrHDRpwvqjvLlig4+dUBYQNnI2mYvG/W3FeO68cZRe8mXyKA==
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:41 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::3c) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:32 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:32 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 02/10] dt-bindings: timestamp: Add Tegra234 support
Date:   Wed, 22 Mar 2023 18:29:21 -0700
Message-ID: <20230323012929.10815-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ba2bf4-02e4-4dca-b24d-08db2b3e132a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxCWXUPf6O+X1IoQOeVWnbqoOqeOJ2boUDvxdj9TBvug+RqKuZwA4Ts8FNcWFbxCpIgP+Slz0BioUMQ7TQHwQs/RS6c0A9NQnG8lrxQq1yxjUtjeIa7B6pmjsr/2NrxbZAxVZLhdQIVB9LgP0ZVpavGXCrT18gxjzNUT4cPN4vFfJHAXwB+NypDzi+U1Gxniwoi2pdKaEERIQ/taLCfaz9snEh3PWODjzpAtRVZemvY9yI7lKjBfQoOF8Uiq9uHy3aeppt+6wRyuPGSg7kwUIHbMy4+Q9cfpcZZR/tGaDCmp0kul2mme7E1zNwP+B/N9I8Cxk8Dw5ucbmGLJ9Q0J2ll4252PfrR5Jf05Vx6AAvJunMx+vB5GIoUt9XUYCCehNFlwvz7P1Vu6ecShAqWOiRpBhLWLKqz6ZVCHPsX+i+UxCozpLozfs6WkJXfx1vAwjOvgfb0itXVDTnTFW6QQnbBvsnZR7v3jH0OpwCEaC/RjE9A4TAQn1y4JFYt4rjvDBNmGtkl0fyBa/4y69NpiwpjjsQ3fN72hUddEbRVNn5jRO3qL9alF3bS5gIYt8WEcD3BdtH7HgKwXGKei2c8HJtfoMJg4VsFlgfeiWsJoAsw6SsXNCknGh6I4PT2JtP/P5F18HJfb0tS94t+TuScoVA6Wi605lJsGbJ3Ru4nFWfs6QnkSiBKdBhvvNv2W5Ik7zAnGHheeIy9iBkdQwW2MQyi4pBsmpjEFD4brveKGg8+CVobaNTPBsHiKgmrs020BL5IPDStTthAQ+DP3fhDszL1iOUcdXTY0CEOUOr1EBXVfkqIdyQsd/jUwYVvG0zbCvaM6wSioco5QNAiGiFd/dxl+CsBp30M78pd3j1rVIeP5YyBcskgRJBPAG//b4kWxl8aZ5ZsASeZBRlum7pkvyQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(2616005)(426003)(47076005)(70206006)(86362001)(82740400003)(36860700001)(7636003)(336012)(356005)(40460700003)(921005)(110136005)(8936002)(8676002)(2906002)(4326008)(70586007)(36756003)(40480700001)(41300700001)(6666004)(5660300002)(186003)(478600001)(966005)(107886003)(1076003)(26005)(83380400001)(316002)(7416002)(7696005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:41.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba2bf4-02e4-4dca-b24d-08db2b3e132a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added timestamp provider support for the Tegra234 in devicetree
bindings.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
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

