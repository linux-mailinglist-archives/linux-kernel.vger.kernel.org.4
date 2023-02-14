Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0E6962D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjBNL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjBNL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:13 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD61E241D5;
        Tue, 14 Feb 2023 03:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVZyb+7MYpn3P8dhdFwYpC8j66TQNrifBXDd4LbnK9sdbKir5C0EgTdnOS8bWVuGvI+Prw7mz/MM7hjxwUiHV/m5wycGwv65P9vmGrPcCKvYYjFeZeQfDDQzdo11vUsklmvKirNP8PyAyPiICN25mkJJ3WS9CbZZ2JMKiXxlWUl37XMgSGj9gPXwG+nOVAnpwoAsqxhxxQHuWQ9xTsrTOMSCKRLFyJIV+OCcw0c5F/lmSpZ8JNGCrOhu4Zo6o6ruM0NMMV+g409ThQB1gOEQlkm6IBJeSoyQC0iU3Hq6RAQi9M+lLhuSe8AO8p85ZPNU2D0zj18JCTpYeGExP6PAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZRbkzgu5/yDajxDho/3b+xMtOlsbwZbLaxpV4JqRAk=;
 b=hSFnAaQVwAu+afB5WKeX+JZDmB78IBsKSuqgn/KKZdTJ6QIKtCopTBDtgID7uamCwths90vX+YtOUocMwVH5UqQ+jQTWo1jYevuWHUJg2rxoecA2KGbEu/pA/oanFF2oVreeSKThEoOLo6uIrmA8lYioK3Vdv0C/wUFILaHVVkUe8j2LafLzVgLL3w3NQhfD6B0B7vPgBZNthFYanrjwTdKPR3fWNjdVKsh9tGrjIqArb40sgFj+q9r7ravzeE0UxNx4W1/BWFEJ4JXVAvKCfVxxoEEEaSgYo/SNquoh81nUTKhxrhBQ6bbZNSsJyxZOnaw+CxoPHPg8X+43YjTE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZRbkzgu5/yDajxDho/3b+xMtOlsbwZbLaxpV4JqRAk=;
 b=fGqW6V/1cYTZCcoRojeuFoCgImG+vywFup0xEeey4Xa1iG1tZTmJojwRNjrKgFIG/lics+c8LCeuIjBIQE1FtzqplOvuDdlgVdtzS6POdsnuo4Ib2/YMjo1eVLki61CqZB4cSLLU5LboYtViR5idg5r6R3mRrrxSHgq0kM5nRVLY9Yguu5Sjsu0Qs5gNRyD+DGvAJs5BvcQ4qx8x8xHPfPJnza5JLjWpfsaoj0buorj8V6JnbhBrp6wW1/dK0zUNYFjAfST4kDNJPyaHue+HltSyXqMDk/JqZBfXOnGViSbEXj8tz5PkYPBcx5MgPsbC8HhXW/2jrCpepgAUADSD1A==
Received: from MW4PR04CA0376.namprd04.prod.outlook.com (2603:10b6:303:81::21)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 11:56:10 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::1f) by MW4PR04CA0376.outlook.office365.com
 (2603:10b6:303:81::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 11:56:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:01 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:01 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:56:01 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
Date:   Tue, 14 Feb 2023 03:55:51 -0800
Message-ID: <20230214115553.10416-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214115553.10416-1-dipenp@nvidia.com>
References: <20230214115553.10416-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: af894e40-d107-416d-e17c-08db0e82768e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHtMIocQ+WwV7i3aTPtXyyWdyylf2g7i8b6KTJHLy+eVd7uDamZGrUyalNY3tnn74JxN4it1Wwq1l3qIrR6Ia5dI7OybSj5fXpcmwIMFJlrvltwp/DmE5yYPJzOK/qVb3HKBwF6RgdcyfYM5r//+wSkoFguzqKYgndQSlGeGPCsc4pXcu+lrdDF3QSnKkEqbNWQOSjbkS/rmcLDqN0mb0fqUayyPHhw+1BZntA+42Pi/zyQBJSONgMBf9bPLk8MFLUQOFozhqfvrreYeRhRSJnad6n1VKkfsnB0oPZ2rCKZNIgcloHQYUIwrp/wDdNzSYZk1AaLATmkHAtwYdUtFRzV5llROE7A+YM2SvxxyqZiuwdkFSpYpeijYhQGjPT7ZrNeAmIYZI9vr1BqwaB8RQ0yhHZ0gKeRn4a5qhbiXz5Mgxd2uyhJrXtyXhLUUkn0HVXMeu5HCJmrlBrkZFUBfggRRAGex2JGISOswhWqL4H/eZSBKw9k+udiYOD82EDG5rG4ua/uq7eHwYFu4pgObMAk9ebn4FU+mQy9gaOVB5ojEPtiITmiSg4fLGCyfuRLcSrE3t98b0ZVQz2VV3eoXy7zSeKYrU5GyT99WT5gg17NUEQpxI91gmMG4wwGyDbbp4kDQy1rmu5QHDtYy4dFn53ZgaHk9wwS3uCodzUhyqKfh8USr7yMEeTCUmLq0Dyk5oz/sxC48Mo3r57/zKNpsXSSj3zMp3bXBqUmM6swwyYNHfkVXQQSPHiDrbmnlewwVe/6PngArqvEMfpkG+RYQcBOMPx0YOh9ZF2wR7oRGmZESvcgL7/yT9iLa89EWXkxM5tpePckakf+to8ftR4N2hg6CAgBdzRKpGMBkxs0cySk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(5660300002)(47076005)(83380400001)(26005)(186003)(426003)(2906002)(36756003)(110136005)(82310400005)(40460700003)(1076003)(86362001)(107886003)(478600001)(41300700001)(6666004)(7696005)(966005)(7636003)(82740400003)(36860700001)(40480700001)(356005)(2616005)(336012)(8676002)(8936002)(921005)(316002)(70206006)(4326008)(70586007)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:09.9107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af894e40-d107-416d-e17c-08db0e82768e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

 .../timestamp/nvidia,tegra194-hte.yaml        | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index c31e207d1652..d0f4ed75baee 100644
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
@@ -38,14 +40,11 @@ properties:
     minimum: 1
     maximum: 256
 
-  nvidia,slices:
-    $ref: /schemas/types.yaml#/definitions/uint32
+  nvidia,gpio-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
-      HTE lines are arranged in 32 bit slice where each bit represents different
-      line/signal that it can enable/configure for the timestamp. It is u32
-      property and depends on the HTE instance in the chip. The value 3 is for
-      GPIO GTE and 11 for IRQ GTE.
-    enum: [3, 11]
+      The phandle to AON gpio controller instance. This is required to handle
+      namespace conversion between GPIO and GTE.
 
   '#timestamp-cells':
     description:
@@ -55,11 +54,21 @@ properties:
       mentioned in the nvidia GPIO device tree binding document.
     const: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nvidia,tegra194-gte-aon
+          - nvidia,tegra234-gte-aon
+then:
+  required:
+    - nvidia,gpio-controller
+
 required:
   - compatible
   - reg
   - interrupts
-  - nvidia,slices
   - "#timestamp-cells"
 
 additionalProperties: false
@@ -71,7 +80,7 @@ examples:
               reg = <0xc1e0000 0x10000>;
               interrupts = <0 13 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <3>;
+              nvidia,gpio-controller = <&gpio_aon>;
               #timestamp-cells = <1>;
     };
 
@@ -81,7 +90,6 @@ examples:
               reg = <0x3aa0000 0x10000>;
               interrupts = <0 11 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <11>;
               #timestamp-cells = <1>;
     };
 
-- 
2.17.1

