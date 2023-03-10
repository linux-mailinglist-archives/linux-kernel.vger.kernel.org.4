Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E46B50AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCJTHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCJTHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:07:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC91314F7;
        Fri, 10 Mar 2023 11:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFHYIeGpz5zAOYEcmrEuRvyHHueBRfwR1m7O8ppqEaQNTfKB0FE/9Dc/lDUEJeWgPMKSmu4oyzOoBcQjhu2zkMSAFNOLFWX0abH9Wg54TICK4rpGIPa/9yZLAmoHX01xzbIz0hBamUer6EoOQWbN5eobzZt2cnukmTc/OfW8eXlItKKVKYp0PDJMiVGEFSWtlnx+C0dJTE58owii0Dnr/akw2y3guRIQIKDj4CHEyVyMI/AU+8qf1hzZaH6chhXFUkm2SuBPCeGom4ogd2LTtTcxVUajo00GcMIsWyN9d6tMkNIrKB1ScvbwdnPejcCMVf8YvsTNrvMd1BVZ90CRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv7LE4pku3V7LWfoSdB/sjmfsNoyQqUbOERnowhHlnk=;
 b=bJTNbyAm6I5OBpGA8Hpv08Tn4tYCj4WxbhYcxTI0wXq2mW5qwBSyM7Q7YfvX71JF6XonerhYRZPWy3oJLVIfuvHx/hvFgQUnJmF6ii3PO4LsdH0ALOEeaOORqLRHG5bcgvQ0X3g1xGgfZL7FDIbXcnkovyL545R+hkC3BBrJvGbQOL4cGQ1oi8Ss3mIAm8LPqnfTjAXIwn0eepAPyNQcFFPBoR64gqscxVdaciefbN5rYAPVovYYzATofL3FBgrt1p/d2MS0JiaIVaQ6xbDg0HPm/Wb6s7pc6rMMiEULjGlaqDkfsLYHslSZ6jbZo6ll5Q58dzCMoDSJPCuuXMPuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv7LE4pku3V7LWfoSdB/sjmfsNoyQqUbOERnowhHlnk=;
 b=nUJ3lH9HjOwFt2jrYICBFWNfJd0vX0wV78KxH0Ww3RFKUE4v8kw1ejbMYU28jDxYwwvbwC3uPcFVrQiQ/jRgrA4EkFzRZtFpLKUiFjMRRefPRna4rYI10ey0JHCKoMGCjPh5//1Sc03gfYey25uq31NZWyIU0StGny5n5Vuu7d/G7y5F7eUUWT+uZYe2ozr5/7lWEoSiIEhMDLyRh0Y+vVjQzu8XvyrE7IocpLMCMO0aXZCXE5MSw95k3hyqE1Se8jc8a/zUGXpkcVUvZT9qNCUCc7pcNQat49i2KLD78pvXFB07WaSBdhNpHkTRMsrtjdRd6xOf9872p/MIFqxvHA==
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:06:53 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::5) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.21 via Frontend Transport; Fri, 10 Mar 2023 19:06:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:40 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:40 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 4/6] hte: Add Tegra234 provider
Date:   Fri, 10 Mar 2023 11:06:32 -0800
Message-ID: <20230310190634.5053-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230310190634.5053-1-dipenp@nvidia.com>
References: <20230310190634.5053-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: adf24e1c-577a-448f-38a6-08db219a9c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhMyyIXdgum1D5sYZvCq3E56+Wp4Kc5B5E9roiA5sntKQz3y5tsUrtUgcc99bj06ArOVehiFQyos4NdmrOWZDUXvhQKqt8jfJX5kpjqttk3MLmdycXPO/IPbxoGUVh3eZKwtcaB0GdTePA8uXisF3zRnoXMIwgUWu6U+DmHiWUVrNCae6xfBr/LzNPex91BzJwt3Low7DcphZftF4gcFXWzHB9a0hbYXkajL7wpbx+pmw1QMaig/E/rat0jHDKkoqU8x4kSyYuXXIgxG1Ul3Ru/S+yxXMrSg6nq+7/bN9EgmB8S34gKOkAuy1khb++hj5J3/O+9pLbMlKwop+VMopQ0ru+gAvMI9e+V06MOxMab8riOogu/makTomHlo750wHm37exPRDRFi2dgFcF8Qz+80wSSNZR+E4MUXjHdm2LPUTalKeRWweI7UClVMAyAvUJ8Dc7JwqCBBvVzAFJdRqtbJI2JXz/ZM7QJQgGaWvuGFx9tNMrZmvh11x6Mg4zCxg0saWVcgGsI/TSfxawO0d4bBSc3EBXYH6AqVXSJ7/NLD7VxWGVHOsQuCYAviBkSNdw8qGXaVxEsEE41oFvbugG4TH9Q43AfM64JSg6YLQjgqM7Ags7FIATC2XqmMjYqo+M57JgXp7EZrbZrIiQ5vKK3Ccl74+EigpMtA/Db5SCuFaV0Z4Qm8mR8HdTbZa2OS5o8a7ZVwBEy6V4apex0BjdUq8ihOZG6VI4Q1Xld27J2+Ox56NUVTz0qE9YIOMjGEpak6Wo9mkTQP2lU2mta2699K414bhAkR4s6x3RVJIyU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(46966006)(36840700001)(356005)(36756003)(110136005)(478600001)(5660300002)(7416002)(316002)(7696005)(107886003)(70206006)(8936002)(2906002)(8676002)(70586007)(4326008)(41300700001)(82740400003)(1076003)(36860700001)(7636003)(921005)(40480700001)(86362001)(186003)(2616005)(26005)(82310400005)(83380400001)(6666004)(336012)(426003)(47076005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:53.3857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf24e1c-577a-448f-38a6-08db219a9c62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds HTE provider support for the Tegra234 and reflects the
changes made in the device tree as follow.
- Add slices field in the SoC specific structure
- Remove gpio chip find by name function instead make use of the phandle
parsed from the DT node

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
v2:
- Changed how gpio_chip could be aquired for the mapping

v3:
- Renamed gpio_chip matching function
- Used of_node to fwnode field in gpio_chip matching function
as data as gpio_chip struct does not have of_node member anymore.

 drivers/hte/hte-tegra194-test.c |   2 +-
 drivers/hte/hte-tegra194.c      | 152 ++++++++++++++++++++++++++++----
 2 files changed, 138 insertions(+), 16 deletions(-)

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
index 49a27af22742..7c8a2973e6a3 100644
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
@@ -114,6 +118,7 @@ struct tegra_hte_line_data {
 
 struct tegra_hte_data {
 	enum tegra_hte_type type;
+	u32 slices;
 	u32 map_sz;
 	u32 sec_map_sz;
 	const struct tegra_hte_line_mapped *map;
@@ -220,18 +225,129 @@ static const struct tegra_hte_line_mapped tegra194_aon_gpio_sec_map[] = {
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
 	.sec_map = tegra194_aon_gpio_sec_map,
 	.type = HTE_TEGRA_TYPE_GPIO,
+	.slices = 3,
 };
 
-static const struct tegra_hte_data lic_hte = {
+static const struct tegra_hte_data t234_aon_hte = {
+	.map_sz = ARRAY_SIZE(tegra234_aon_gpio_map),
+	.map = tegra234_aon_gpio_map,
+	.sec_map_sz = ARRAY_SIZE(tegra234_aon_gpio_sec_map),
+	.sec_map = tegra234_aon_gpio_sec_map,
+	.type = HTE_TEGRA_TYPE_GPIO,
+	.slices = 3,
+};
+
+static const struct tegra_hte_data t194_lic_hte = {
 	.map_sz = 0,
 	.map = NULL,
 	.type = HTE_TEGRA_TYPE_LIC,
+	.slices = 11,
+};
+
+static const struct tegra_hte_data t234_lic_hte = {
+	.map_sz = 0,
+	.map = NULL,
+	.type = HTE_TEGRA_TYPE_LIC,
+	.slices = 17,
 };
 
 static inline u32 tegra_hte_readl(struct tegra_hte_soc *hte, u32 reg)
@@ -534,8 +650,10 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 }
 
 static const struct of_device_id tegra_hte_of_match[] = {
-	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
-	{ .compatible = "nvidia,tegra194-gte-aon", .data = &aon_hte},
+	{ .compatible = "nvidia,tegra194-gte-lic", .data = &t194_lic_hte},
+	{ .compatible = "nvidia,tegra194-gte-aon", .data = &t194_aon_hte},
+	{ .compatible = "nvidia,tegra234-gte-lic", .data = &t234_lic_hte},
+	{ .compatible = "nvidia,tegra234-gte-aon", .data = &t234_aon_hte},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
@@ -556,9 +674,9 @@ static void tegra_gte_disable(void *data)
 	tegra_hte_writel(gs, HTE_TECTRL, 0);
 }
 
-static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
+static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
 {
-	return !strcmp(chip->label, data);
+	return chip->fwnode == of_node_to_fwnode(data);
 }
 
 static int tegra_hte_probe(struct platform_device *pdev)
@@ -569,16 +687,10 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct tegra_hte_soc *hte_dev;
 	struct hte_chip *gc;
+	struct device_node *gpio_ctrl;
 
 	dev = &pdev->dev;
 
-	ret = of_property_read_u32(dev->of_node, "nvidia,slices", &slices);
-	if (ret != 0) {
-		dev_err(dev, "Could not read slices\n");
-		return -EINVAL;
-	}
-	nlines = slices << 5;
-
 	hte_dev = devm_kzalloc(dev, sizeof(*hte_dev), GFP_KERNEL);
 	if (!hte_dev)
 		return -ENOMEM;
@@ -590,6 +702,9 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hte_dev);
 	hte_dev->prov_data = of_device_get_match_data(&pdev->dev);
 
+	slices = hte_dev->prov_data->slices;
+	nlines = slices << 5;
+
 	hte_dev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hte_dev->regs))
 		return PTR_ERR(hte_dev->regs);
@@ -635,8 +750,15 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		gc->match_from_linedata = tegra_hte_match_from_linedata;
 
-		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-					   tegra_get_gpiochip_from_name);
+		gpio_ctrl = of_parse_phandle(dev->of_node,
+					     "nvidia,gpio-controller", 0);
+		if (!gpio_ctrl) {
+			dev_err(dev, "gpio controller node not found\n");
+			return -ENODEV;
+		}
+
+		hte_dev->c = gpiochip_find(gpio_ctrl, tegra_gpiochip_match);
+		of_node_put(gpio_ctrl);
 		if (!hte_dev->c)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "wait for gpio controller\n");
-- 
2.17.1

