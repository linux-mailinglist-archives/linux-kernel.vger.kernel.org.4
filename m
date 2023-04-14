Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE40E6E193C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDNApT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNApM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn20320.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::320])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A5826A1;
        Thu, 13 Apr 2023 17:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+1GSFeMaROfgkmv89+hbTo7O6AdM7JhFRJeDyWPPf1szRGHDCcUAwUq/p2KCk1ddbelwlI0lIFiKA/IIht7Oie5AyKM4CXOWfwRGselJWC5kCOsnMZvAFtazM6allpDvXisQd+CraLodcy79V9dqZTmolDDuxqxHYDkfc1JpNRcOycu3mxWbphEhSiXoqFNre9Acdjbk3Dq8fBvKaKuCjZfXjCODGC4zB8NUMDK4h6PmcYjK2oxKbY32VFLIfUiNr3eB/OXGoTt7BURM3RmRxVQRUhihp84ha+sXxkzupGLLHlFnEdYwTqEWAiSFiqAJ/fh8JNHmVIhsur6wmcoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xILjkmil16koq6A5/fqPGQU7VzIZMSKdpC7DBNBP9F0=;
 b=DZbkBNANcXDHfWHkz2W9NAl6BqM42t0WMF7A3+pQvUzx4USegfXpzGroiQT8OUZGdJsC1SGxipP85QjdRAL3G3wb0yFTssVHrJ9zZTN1Wj3E4TZFKGnl/cUQFz7GVdDNmZRmHsmfsg9xUDIGMcqVqRXj02JaLTP2PjWIIxeDBeURleytxOp6IE8xz1w1J1hYTvi7iVuPEyM1lorQzT+yYM5qDmhp+/0mECx6spXIRtik6ZK0PyPB4GD6Swb3ZJguxp7hC6yLZfGJ9EKaq5lJNlJK/FxMpzRJdn8+s/Wt3qVcjO0cXRQgeC0kjUu4dM3sZA/cUwkoq08M0vcof8BB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xILjkmil16koq6A5/fqPGQU7VzIZMSKdpC7DBNBP9F0=;
 b=trz1F5V1DIHgL9xgE/b9v5pEXplCRVsbSCgza0O/uCdihdO/e0KndoMQUFp0FPVACtzZRBZ/+Qg7aILo5GfaElo1Jot4AQDcXDUc3afzIELLQxbeS2wqgt1AbT/FarFjlhuvMtSMVNkoGO4js3QrDMm9h4Oalz7mv3J3taB5xHQpHct0bmIwQAXrWYntetkRP/fXKrj7+QmHZEX2l74S/bMRI2EttxfmlZO4xtHqFTxwYcfkeelRhjIhTO/BQDRsBxrXh+ymR4/z8bx4Wc5/BjQtigu646yprJvUKmlK6mgF+ROrVSXVF/W7khCaDZKdtOLNahQ5h1IPSo4oZy/SPw==
Received: from MW4PR04CA0182.namprd04.prod.outlook.com (2603:10b6:303:86::7)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 00:45:05 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::bf) by MW4PR04CA0182.outlook.office365.com
 (2603:10b6:303:86::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 00:45:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:44:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:44:58 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:44:58 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 2/9] dt-bindings: timestamp: Add Tegra234 support
Date:   Thu, 13 Apr 2023 17:44:48 -0700
Message-ID: <20230414004455.19275-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: ff17f82b-95d3-4cb5-39de-08db3c817d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?82HB4vwZ/OKyfI9IyxJAXNtdGlBskOC1b+GQYDdn57AtaP5euCWqvENf3n+8?=
 =?us-ascii?Q?7HHsaytYnJ6csftCSoCC3DDcwhzD2tfJVQmu7aNfFLqK70yR+X315q0x9B2k?=
 =?us-ascii?Q?tSjVsZhWXaVaILuWUXHrcL4IeWonpciVAcuXCKlVQDFyHvOEZnbmN/IJjoGy?=
 =?us-ascii?Q?pldE2mggFUwszqGw+jZ03lmrLEfPV+41BE+m2KV/RHEgybQo/U7Q7ae9gQRL?=
 =?us-ascii?Q?eDLC1rw9rkzlL/Bgo5ImVJyqKEgvqqwlDakxkVlv62B5AMjKUgj6uvKz7j/z?=
 =?us-ascii?Q?rxsY7bmwwY4Dp/nEEohNoWxxLLw28N8GTOQTm7gVHHT7fAK5dltXyesFgGxp?=
 =?us-ascii?Q?2nBC2lUQ6zxutS4G+3eHlUZ9B/98K2Rx7OlANaA0fbovOEqQXOHwT7Oyn8tB?=
 =?us-ascii?Q?8PV4s8t5I+CgRjLGJcfQDUN7G/XTbhXi2pViG+11MY05HxHffY0i7Msb9G/1?=
 =?us-ascii?Q?F7tDrhk/SQGu3RIl3hW31HWnjMGJgl149AlmXLlNhIvOb4HwhrR8bJ1qxFSy?=
 =?us-ascii?Q?0jUPL6E4LIcXeLrHo5bkyuJ9fQJVpa7BEbZ6aCHyoBhb1xxbVQ1YKtZSTjON?=
 =?us-ascii?Q?wbmMujh/z8fhV25MaEvTxUyS0ga9PhhNN9bU3EG0XBVcqbd41GWZALJmFnvL?=
 =?us-ascii?Q?GaZDah9MXQKO2VdxGp15r/i9nBXwr4xMWNnRK1ddmRhVuK9IcFxw3/Yl0IvR?=
 =?us-ascii?Q?Ufwdpcx4rx36F1SGcQnpDUVd52+k3ci/qFCUenACLOogY0nA4mMusWYuyHdq?=
 =?us-ascii?Q?srExUelx5ZSibVmDFGZb5/A0Lz0YAriQ9D/qs856IDvBJidCrR/olzKVg7XO?=
 =?us-ascii?Q?YG/1N5svJ46nkm+4hg70HLfNBvlj247sPAVKvwzdKXZxgSnm4cSx2DaLSUic?=
 =?us-ascii?Q?bTOAn/nGGzQBQQ/hsQ4FT7gkOBiiweYkkFuQV+3WDgr4h686qLn4GGrq/xNw?=
 =?us-ascii?Q?NH6yuYalYJYlpuZcS4LAJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(5400799015)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(2906002)(82310400005)(40480700001)(7696005)(34020700004)(2616005)(6666004)(83380400001)(426003)(336012)(47076005)(186003)(26005)(107886003)(36860700001)(1076003)(8676002)(966005)(70586007)(40460700003)(4326008)(478600001)(7416002)(70206006)(82740400003)(921005)(7636003)(8936002)(356005)(316002)(41300700001)(110136005)(5660300002)(2101003)(83996005)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:05.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff17f82b-95d3-4cb5-39de-08db3c817d35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added timestamp provider support for the Tegra234 in devicetree
bindings. From Tegra234 SoC onwards, the nvidia,gpio-controller
property is required. This is needed as the tegra always-on (AON) GPIO
HTE/GTE provider depends on the AON GPIO controller where it needs to
do namespace conversion between GPIO line number (belonging to AON
GPIO controller instance) and the GTE slice bits.

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

v6:
- Merges the patch 3 from v5 into this patch

 .../timestamp/nvidia,tegra194-hte.yaml        | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index c31e207d1652..5de1eca9cbcd 100644
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
@@ -43,9 +45,14 @@ properties:
     description:
       HTE lines are arranged in 32 bit slice where each bit represents different
       line/signal that it can enable/configure for the timestamp. It is u32
-      property and depends on the HTE instance in the chip. The value 3 is for
-      GPIO GTE and 11 for IRQ GTE.
-    enum: [3, 11]
+      property and the value depends on the HTE instance in the chip.
+    enum: [3, 11, 17]
+
+  nvidia,gpio-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to AON gpio controller instance. This is required to handle
+      namespace conversion between GPIO and GTE.
 
   '#timestamp-cells':
     description:
@@ -62,6 +69,51 @@ required:
   - nvidia,slices
   - "#timestamp-cells"
 
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra234-gte-aon
+    then:
+      required:
+        - nvidia,gpio-controller
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

