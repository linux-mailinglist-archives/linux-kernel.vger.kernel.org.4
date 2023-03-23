Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497296C5C11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCWBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCWB3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5A2D5A;
        Wed, 22 Mar 2023 18:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOLM52lUVHBrmQQE68omjH6xWpnZ4iHeKKs1SNOdZNL5aN9SQKk6gM6ey+bTx5StOgixbO/Im3Q48Yw6xGoio920cUaT6TiX8xi0It2nUOkArdm3iaFQQi0YvoqhwNv/TDEmZ1qeOAoPQ/aRWs2MkmG9WbYzFrj+RMe5dkqMUIF7FNUvicjNHA2gupg7dilbILihdPoRHXdC5qSgyxsuUTSF1LyJsh8vQTK2IcfaJIsypKkwVbZ70PFDJIevPADl39tT+ND5EQl/ndvudFgaf96cy2nz5LMgPalhPYGj2JnQe2Y6EB/9Hf+KzXlqpSmcAMdDGEs/WqnThZs2vr63sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRSrneVwlnQEB9m06wEPIjU9TDyL1SRZmKcYT9YP7UM=;
 b=govFxe8XtCphJbTsFM5Eh8lDUA3/AD5mbMN3SZGVVnEVJYEqsImEpuMThikbs57s+Y+42STsZRv4M0R8D7nWzQ9Nx6EX0DI9PenTtZEIuawB2BA3bd58L7YfVw1/taxa7m2hxuYFLpmP9/DmEGc1/+UX+eImCBA2IbXF3U7QF8bF8Jo0bEaR/IGDWddtTwFkMXuGwykGn/beJ2r2+/qNcYICY7IhdfgVqHxnTdrNsBZMfhFLd2xM7mEME6be+8/SlThsJV2V9nhi6ssC34Pu0DEGSaaZZTvx+Iy7T1Y7Aq29MAjqIfS9qUk4XF42DwxOgSxvqHKX1/UQtK1Yh1QxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRSrneVwlnQEB9m06wEPIjU9TDyL1SRZmKcYT9YP7UM=;
 b=USwU3gFrx8i3bkEF+/xAfQhApyQyt+oFWDRFuy2niSavh8QOoyszOHN3NZpYYZAjXP7pPHFMMN1kV0iSU35//gAPQK3bleDVWPfKiIcy/zllvN1Ll0kvRhyByHlX5YUftBL0WB+41fDDJ8tBxeBGadiLd6iUjqXOO0U++KF/fNyaY/Ge1ppsw2s8aM+874Ihsd1fieiWJrS7bXUTKJ6sTONEMe4WS04KLBi02TznJ1Fe4ot0bhdAe12/xhbMhxY/NWPukQ5s87BKOuyBndItlyHwQhORJgDnOi9RvSjcH0SJYKMfD6TVW+qIZo6qDmss9O+8TBRk9ZPCYLKiCTBjrQ==
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:44 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::9a) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:33 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:33 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 04/10] dt-bindings: timestamp: Add nvidia,gpio-controller
Date:   Wed, 22 Mar 2023 18:29:23 -0700
Message-ID: <20230323012929.10815-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f479a2-cbc7-4d2f-e1ee-08db2b3e1509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyLaBmxefDrQzcpNskfNgKteNTzFW0+p9D/I1y3rQI+pnhhlguz3Ch1S4+BM7fmBMT1pYH5yi2ZCRF5txdu2I5TAeG9py1CPR2HG5c2wdj7g2j73g06H6lBcQoZYsyelG4tbq+0RHD7p/ORu49z682LGn95R4FmZvDLUEWGTTX5V5OG4uz6BHcNPvwdXd49Q8eVCR9Vdk5JZQ8jH2PJE8yKjOiLxi8N+XVmhF29RR+qagOYqWEXb9V7vj/pYZUOKdDy9OGw/IEdYlnwVH455ktYx6+kMR+TsYT9BZILrRPjn8rYhyqakOCPhkYfxFQsj+OSMjkJHQe7YHMezmiw+Wpj/fmTfxTfnlfkS+fJx7WutqW2Jed+PCIrQYXdsKXFVT9INcYSP+cxBqMwl7ATjs0ORubc9R5WbEXFTaDdXcn7HikNvZanOrh0w1En9UOER9zBm23D1MKSuJEAePdUdKLKwcDdzz/P9QJjxLDglTBGbg+J/6FSDH1CjIcRSk0T3QW03pIYk0WeJznbzBPQl30/FFhcCSXj5qn1zqS5aGnzRD6kNgn0gf923lFEMUYnggI/f01o5A/jzBWNREFubVC+YkLWqgBc9FwH/Q3WqgYk++MKJJxfG4y2CjeXL9KVKvpsLrxF0vzDTXhQ0m8BjPGRK9Et+aYTHtAl/MkEigna7dQf+qlNmDfNLmJZ/+g6TCUDQ1nPdmuWfzQramuRwSNNo+SabD0vcV5OzUq2stkihwkEavy2yOxksf83agPOWxqD7/n37NMudxPPFnZakn+9NRtSoyPwjoi45zZzux80XFlQp5DeQ2LjA3ImxrT5G
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(921005)(4326008)(86362001)(40460700003)(356005)(7416002)(26005)(36756003)(41300700001)(110136005)(47076005)(70206006)(8676002)(5660300002)(8936002)(83380400001)(6666004)(36860700001)(40480700001)(426003)(82740400003)(336012)(316002)(7636003)(107886003)(7696005)(82310400005)(2616005)(2906002)(186003)(70586007)(478600001)(1076003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:44.2430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f479a2-cbc7-4d2f-e1ee-08db2b3e1509
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
This is done to help below case.

Without this property code would look like:
if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
				   tegra_get_gpiochip_from_name);
else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
				   tegra_get_gpiochip_from_name);
else
	return -ENODEV;

This means for every future addition of the compatible string, if else
condition statements have to be expanded.

With the property:
gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
....
hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);

This simplifies the code significantly. The introdunction of this
property/binding does not break existing Tegra194 provider driver.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 .../timestamp/nvidia,tegra194-hte.yaml        | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index eafc33e9ae2e..841273a3d8ae 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -51,6 +51,12 @@ properties:
       LIC instance has 11 slices and Tegra234 LIC has 17 slices.
     enum: [3, 11, 17]
 
+  nvidia,gpio-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to AON gpio controller instance. This is required to handle
+      namespace conversion between GPIO and GTE.
+
   '#timestamp-cells':
     description:
       This represents number of line id arguments as specified by the
@@ -65,22 +71,43 @@ required:
   - interrupts
   - "#timestamp-cells"
 
+allOf:
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
   - |
     tegra_hte_aon: timestamp@c1e0000 {
               compatible = "nvidia,tegra194-gte-aon";
-              reg = <0xc1e0000 0x10000>;
+              reg = <0x0 0xc1e0000 0x0 0x10000>;
+              interrupts = <0 13 0x4>;
+              nvidia,int-threshold = <1>;
+              #timestamp-cells = <1>;
+    };
+
+  - |
+    tegra234_hte_aon: timestamp@c1e0000 {
+              compatible = "nvidia,tegra234-gte-aon";
+              reg = <0x0 0xc1e0000 0x0 0x10000>;
               interrupts = <0 13 0x4>;
               nvidia,int-threshold = <1>;
+              nvidia,gpio-controller = <&gpio_aon>;
               #timestamp-cells = <1>;
     };
 
   - |
     tegra_hte_lic: timestamp@3aa0000 {
               compatible = "nvidia,tegra194-gte-lic";
-              reg = <0x3aa0000 0x10000>;
+              reg = <0x0 0x3aa0000 0x0 0x10000>;
               interrupts = <0 11 0x4>;
               nvidia,int-threshold = <1>;
               #timestamp-cells = <1>;
-- 
2.17.1

