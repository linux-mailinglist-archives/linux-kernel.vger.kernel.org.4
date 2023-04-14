Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557DB6E194F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNAph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDNApM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2235.outbound.protection.outlook.com [52.100.172.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27157268B;
        Thu, 13 Apr 2023 17:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEuLocZGYXzZF7XbhfiiyTUGKE7tiUPBT2J9XV6MuC2OAUW6Gmf0U+LMQuAz8uj8DMTICKbKBelBQqTMRDVcmP2l7f+cdy/Pr7Glej+KP6dTbN1HxQq5WuB5k1xkOXnWxqcQ8DTl1fjqi8W5/Tvs9mg1Dl4I8jEFXSVD7zcRiP6L/+bbEI78XwRHXAFRAuahNL52o7MqGIRqiDpCz26rF5wxOFkWNE8TgWeXESx4x6MgkgClFhiSjYLFCwULDuMju/BOPyPW6RUU3+YWtDqpC6390X5TchGnEAahwvJPfBTa8elFm2xDuGKyT6uW2rQ2U7sYTqFftlP8yOinBFRfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70N85/s9O6sRb8t6SsCO/qnhpuW0O25Zo9jwvf7lX9Y=;
 b=JhA9BQiS+3tGV+iSTpI1BrikdiZ2o8yiADayqCFjKC7E7sFh/xZxLlmbQp6dNY6Szx2YHvGjxfbISr9bHWy6OJ1PTulzx2n5ZFNo8usE0uPnyn3cNJW8wzUCjGMzE3Md4rFSpDDdlJKFMBMBCwnj4nn91QXc5BsoFrzgCMv2OA/0ye+6sTDpLsLm3hXjxabj9aYCBQH4kuumSoSQyxU3cj7+8cV/9qVJa26MW0pjaUx+gL6PxvhzQU9lU3sGRgePxYLbWGgBbf7TBCKxXk6woNxn30FTDEXPiB2Dvdz5+aL/w1I1OoNehw9bfzJaYkDqiafo9JKwIx+SD5BU7o2q0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70N85/s9O6sRb8t6SsCO/qnhpuW0O25Zo9jwvf7lX9Y=;
 b=rvdM67c54HvK+YowcxLVzKj83riv15I6Axpq8ROogZhndZzkcEM+Nj1V97Ys209E/i7/MX+wgT2841C26rECji0jxpGDAHO+Td0AEpxKVzY2Ss+WWg4laFt7kEgOfOqS2X/ZlkP0dVW51u1LCzb0zYMGXPF9eJqlhdzMT4TVbDRoi2udFrNjwwaADCz5i5VEmU3qX7571ft6T2rN1cgxjCGSrsvsdpEsT4/uv+cj4OhYtrsk2XhOeswrPqg+eXUOns9485ekg8e7gAwmhj1Bf4E2tDvRFCI5w1ctJeYVCsOPgMOlfCodZ3KMsq0f7gmH0C9g2F4bIckcHv+kv7Ev0g==
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:07 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::5f) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 00:45:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:45:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:45:01 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:45:01 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 6/9] hte: Add Tegra234 provider
Date:   Thu, 13 Apr 2023 17:44:52 -0700
Message-ID: <20230414004455.19275-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CH0PR12MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: c51a37e2-faec-4b95-b09b-08db3c817e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMLwFPJ6u1xLZf9SK+awdk7jNJQu+pe0RD354nnDNwae3B70Zo5Jyi7sQ6Jty/kJZqPeBMaLoTyHy0x5kZKmOK7z2Z9JIcSqVsfrpR5c+poRJVYLBjwh0rCJzermTA28vEoXF2hsn/g8x1GPqqtPEihWNojTmrYp/8hGGyKirqgQRk6Nz9EwWoy6MOesZpPVvK/eMmU/L0RDOxL5ZPeb7xUQHd4mQuVKbIyQgmmtr1/a5/VuENfKlNHbManOzWqCv7835uo0C/XmqrKpR/Yn+eFBfF5D4TnA8nahWmJdd/EFRFvkAUDHo+Zp4mJaWrRzyLEyeh+eB+w6JjdjuFToagUvG+w6UqSDJ0ZTkuelDDlZpfe4aFx7s9iWoEMg0J5HIjdZt7KFzT2BvIAPET9E88fxbCzVOKraloiQQJGxLn+tjWMlISnPT8vdJMtya4RZN1uGCJrYpOBH4qffVZJfNMG7sNy5tzelB+712XeJpt+hh3KAk7yKjiqvKgRpfmIJX8NnY8cvq0IO/SIoR+SFO4PkEwHXI2MCFbA9LhJbG1n8yoYbms2b6HV/Id+JvcXtQ+FRliNUICMYUYdNsksSqccfYNv3QXdIOuRwwY5/rjyp/q/kd57Ng0r5b6iP3A78r+IFijfX/7DoYa9PnOe66fJxtC5OBZUI96qoY5ASqQgpUdZao9RoSYFis2hIpuYtPtZTlQZ0eWxbNHZlG9bo89OV+n3poNt9cPIMeYxxzsTHLd19gP+FDCejL69gyB/mhT5T/h7NjBLJEhzIRblL6wMZEDIjXtmcfuYeu4OQQjXgydx/vrW20Slee0+l507k6W/OWhGy/1BX1E2qfRHDnqGZhKTGyxVIxtBfs9pME0BwdKbqRm9X9d35NFwWJZpS
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(36756003)(110136005)(41300700001)(316002)(478600001)(8676002)(70206006)(70586007)(4326008)(7696005)(86362001)(6666004)(7416002)(40480700001)(82310400005)(5660300002)(8936002)(82740400003)(2906002)(34020700004)(356005)(36860700001)(186003)(7636003)(921005)(83380400001)(107886003)(1076003)(336012)(426003)(2616005)(26005)(47076005)(40460700003)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:07.2144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51a37e2-faec-4b95-b09b-08db3c817e74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
HTE support, it also requires to add mapping between GPIO and HTE
framework same as it was done with Tegra194 SoC.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
v2:
- Changed how gpio_chip could be aquired for the mapping

v3:
- Renamed gpio_chip matching function
- Used of_node to fwnode field in gpio_chip matching function
as data as gpio_chip struct does not have of_node member anymore.

v4:
- Logically divide the original v3 patch as follows
- Created this Tegra234 support patch
- Created deprecated nvidia,slices patch
- Created handle nvidia,gpio-controller patch

 drivers/hte/hte-tegra194-test.c |   2 +-
 drivers/hte/hte-tegra194.c      | 124 ++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 5d776a185bd6..d79c28a80517 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -16,7 +16,7 @@
 #include <linux/hte.h>
 
 /*
- * This sample HTE GPIO test driver demonstrates HTE API usage by enabling
+ * This sample HTE test driver demonstrates HTE API usage by enabling
  * hardware timestamp on gpio_in and specified LIC IRQ lines.
  *
  * Note: gpio_out and gpio_in need to be shorted externally in order for this
diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 49a27af22742..5d1f947db0f6 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -62,6 +62,10 @@
 #define NV_AON_HTE_SLICE2_IRQ_GPIO_25	25
 #define NV_AON_HTE_SLICE2_IRQ_GPIO_26	26
 #define NV_AON_HTE_SLICE2_IRQ_GPIO_27	27
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_28	28
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_29	29
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_30	30
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_31	31
 
 #define HTE_TECTRL		0x0
 #define HTE_TETSCH		0x4
@@ -220,7 +224,100 @@ static const struct tegra_hte_line_mapped tegra194_aon_gpio_sec_map[] = {
 	[39] = {NV_AON_SLICE_INVALID, 0},
 };
 
-static const struct tegra_hte_data aon_hte = {
+static const struct tegra_hte_line_mapped tegra234_aon_gpio_map[] = {
+	/* gpio, slice, bit_index */
+	/* AA port */
+	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	/* BB port */
+	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	/* CC port */
+	[12] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[13] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[14] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[15] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	/* DD port */
+	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	/* EE port */
+	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
+	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
+	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
+	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
+	[27] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[28] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[29] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[30] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	/* GG port */
+	[31] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+};
+
+static const struct tegra_hte_line_mapped tegra234_aon_gpio_sec_map[] = {
+	/* gpio, slice, bit_index */
+	/* AA port */
+	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	/* BB port */
+	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	[12] = {NV_AON_SLICE_INVALID, 0},
+	[13] = {NV_AON_SLICE_INVALID, 0},
+	[14] = {NV_AON_SLICE_INVALID, 0},
+	[15] = {NV_AON_SLICE_INVALID, 0},
+	/* CC port */
+	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	/* DD port */
+	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	[27] = {NV_AON_SLICE_INVALID, 0},
+	[28] = {NV_AON_SLICE_INVALID, 0},
+	[29] = {NV_AON_SLICE_INVALID, 0},
+	[30] = {NV_AON_SLICE_INVALID, 0},
+	[31] = {NV_AON_SLICE_INVALID, 0},
+	/* EE port */
+	[32] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
+	[33] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
+	[34] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
+	[35] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
+	[36] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[37] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[38] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[39] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	/* GG port */
+	[40] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+};
+
+static const struct tegra_hte_data t194_aon_hte = {
 	.map_sz = ARRAY_SIZE(tegra194_aon_gpio_map),
 	.map = tegra194_aon_gpio_map,
 	.sec_map_sz = ARRAY_SIZE(tegra194_aon_gpio_sec_map),
@@ -228,6 +325,14 @@ static const struct tegra_hte_data aon_hte = {
 	.type = HTE_TEGRA_TYPE_GPIO,
 };
 
+static const struct tegra_hte_data t234_aon_hte = {
+	.map_sz = ARRAY_SIZE(tegra234_aon_gpio_map),
+	.map = tegra234_aon_gpio_map,
+	.sec_map_sz = ARRAY_SIZE(tegra234_aon_gpio_sec_map),
+	.sec_map = tegra234_aon_gpio_sec_map,
+	.type = HTE_TEGRA_TYPE_GPIO,
+};
+
 static const struct tegra_hte_data lic_hte = {
 	.map_sz = 0,
 	.map = NULL,
@@ -535,7 +640,9 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 
 static const struct of_device_id tegra_hte_of_match[] = {
 	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
-	{ .compatible = "nvidia,tegra194-gte-aon", .data = &aon_hte},
+	{ .compatible = "nvidia,tegra194-gte-aon", .data = &t194_aon_hte},
+	{ .compatible = "nvidia,tegra234-gte-lic", .data = &lic_hte},
+	{ .compatible = "nvidia,tegra234-gte-aon", .data = &t234_aon_hte},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
@@ -635,8 +742,17 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		gc->match_from_linedata = tegra_hte_match_from_linedata;
 
-		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-					   tegra_get_gpiochip_from_name);
+		if (of_device_is_compatible(dev->of_node,
+					    "nvidia,tegra194-gte-aon"))
+			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
+						tegra_get_gpiochip_from_name);
+		else if (of_device_is_compatible(dev->of_node,
+						 "nvidia,tegra234-gte-aon"))
+			hte_dev->c = gpiochip_find("tegra234-gpio-aon",
+						tegra_get_gpiochip_from_name);
+		else
+			return -ENODEV;
+
 		if (!hte_dev->c)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "wait for gpio controller\n");
-- 
2.17.1

