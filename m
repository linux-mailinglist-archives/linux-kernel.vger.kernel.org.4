Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B7A622CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKIN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiKIN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:57:44 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC218370;
        Wed,  9 Nov 2022 05:57:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jea2MBTx3Mbk30v8HkrycnMNOViV0DzwSHudpTqf3FmPImtAvMbUPFlI+1MfWa666EOoT7e41SbQw5u3kn+T94LeuD9rfqc31vCCHzlbXKKZODUkRfMsCaUkCwzRyxUZbinfu3EWpH3qKlDXjzsIevH05phcwA+p2hzvDXIVP8JXiIX2v3bPEVZki4hBEdxKqN5vqD5rK433bppzyWs/9HYPqFnkKfMlzT68n8Cef8RRsVy+D62xwdEIfAmLURDE3vhDJLHlAfvlC99/7R4FT5cZ005R5FF2mBvBl4dEE6lZpGyyb9yKSduDhy0rHRm0bvYSn68PJtGzn74cmPBYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSN1VTUG7r8O4f6P9JoPZGHcLXdzx4HZacLn1ns4uY0=;
 b=hxoEOPTEa5Ow1GNuVsx6FPmE9qs3qGyCOG6FZnSVuRiTrj804XPluJAYfyFSvTZElNFrFId3sVdBYQwsfo3JLuntxRkNyy1qw8iAHwX8UNGJhRfv9l7TywodDfwrJ/+58wS0f2e8cDx5iBjC9YAi6jsBfOeM+dYgZ+xbjnwk1EF/h58gXvjWMSQd2ZhxI4KjVcqvV4YHyxYZb2eGbI/flVb1+QOjr8A1NUADcR3ksCKDGiK+5PQzXl03K/4ZyvZ3hGMAtA08E7WM5VD4OQcRs3Y8nYt92xwLuvMxCc50FOZiLv2vA7LrJmLxh5GhdKFZ6aZxbU6+I0CmRAmidBvCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSN1VTUG7r8O4f6P9JoPZGHcLXdzx4HZacLn1ns4uY0=;
 b=Cx+boltEt2UA+S98DajKLfFR6R+mRSrHIkgFhSFBjcixpBW2cFB+RGAb+ulNxz0K3NwjhWu1Fc357q9PXKHhb+Ccst0W2FjQMSdcdhSTj6zXsmy1GPmaFRTDPPw0NTC+IsmZyJNjHMoOPAKG3GIJZje4XMm8aO+xWr4gV+TmDsZ5puN7D8JjU+S5NPCxe8/yBOtGPMbf21fjIiO+3+WGDl6AexBV1Fw+ZUkKKXlAkmD1u+36rHjtIoYEe3GhT3Z3T/DkeZPFIYEC9AIlZCpPcsbGcZiOY3AezRl1PA0e5otodKNF7Z4Jj/laQPIk7Y64nu/UetYRNiGId75ctTZabQ==
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 13:57:35 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::70) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 13:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 13:57:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 05:57:32 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 05:57:32 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 05:57:30 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 3/4] soc/tegra: cbb: add checks for potential out of bound errors
Date:   Wed, 9 Nov 2022 19:27:16 +0530
Message-ID: <20221109135717.3809-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109135717.3809-1-sumitg@nvidia.com>
References: <20221109135717.3809-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: c195f3cd-d8de-4f62-462d-08dac25a5aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61jWobUVwN3FguyZECnOSul0VgP4mHjETmyp2F5XW33pFU5bR60PgF82+tl/3fBAg/QV1ipG6ton4t7aOdwG46X4pCiiyxZnpDGVLE2eVZgYvI7fVXpfhf19MnnbVP/qD6CogvlirCUEbGpwmW849yR6fSPgqFi2xE/DgYSmuafA6iIp+TzxqncUTSoiWJ6H0ZoUer6glrDayxrvTq6rA94E47dkm67ARfHgbpEbmvI0SPN0N+lXpxzYRobpf6UWESjPG6ZZNEUqQwPpehLKqQN6DHdUYtLbvGR3Wec/AXPK7OIFh4qBiMdsscIA1NLcShw0ekxU+oHLk405jhD3PxDZHE5tbCK4fkM2eRnhzqQOTTomcneR8TZ9Mk3JoaoxK/oMA6IA/rNaa81tc+R4A7VAL2mOfMWw6KQA5I77RXK7mV8kPNOLnT/AD2wC5VQqBNc/EGALfnc47sp5BeJY5PVN506X7EGtyOrMJ13UDlME/UtwMsPBzfe9+jWRoMi5AbDxNJdexWV9JwGq80l7Fc26hjSZ30hd8Oum5jXI9rgEL6ufGnCtHzL8YT1sRDRqTeYqw4+Pjc+k7KQSiKEH4Ik1m9Xv7qJt5dEcOpjsf2LYTiUDCtYO9syjbCm0Nbgz/ccCZyBepT5VenYE8nN9HAwWWKo+9nS9lec6xRHA656gfGplvJJw5NEMmE3vkDWF081aqYPUGLbXutfELXrHkRIVUOxMlEpdpucAFMS3jpMs9HqiuXHfIxTym189yFxFaFC/B7Urt+VqUwq4OiwhyA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(426003)(54906003)(316002)(110136005)(5660300002)(450100002)(2616005)(40480700001)(2906002)(47076005)(36756003)(40460700003)(186003)(7696005)(6666004)(107886003)(26005)(1076003)(70586007)(83380400001)(8676002)(41300700001)(86362001)(4326008)(70206006)(8936002)(336012)(7636003)(356005)(82740400003)(82310400005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:57:34.8762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c195f3cd-d8de-4f62-462d-08dac25a5aa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added checks to avoid potential out of bounds errors which
can come if the 'slave map' and 'cbb errors' arrays are not
correct or latest where some entries are missing.

Fixes: fc2f151d2314 ("soc/tegra: cbb: Add driver for Tegra234 CBB 2.0")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 04e12d9fdea5..0fab9e21d677 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -95,7 +95,9 @@ struct tegra234_cbb_fabric {
 	const char * const *master_id;
 	unsigned int notifier_offset;
 	const struct tegra_cbb_error *errors;
+	const int max_errors;
 	const struct tegra234_slave_lookup *slave_map;
+	const int max_slaves;
 };
 
 struct tegra234_cbb {
@@ -270,6 +272,12 @@ static void tegra234_cbb_print_error(struct seq_file *file, struct tegra234_cbb
 		tegra_cbb_print_err(file, "\t  Multiple type of errors reported\n");
 
 	while (status) {
+		if (type >= cbb->fabric->max_errors) {
+			tegra_cbb_print_err(file, "\t  Wrong type index:%u, status:%u\n",
+					    type, status);
+			return;
+		}
+
 		if (status & 0x1)
 			tegra_cbb_print_err(file, "\t  Error Code\t\t: %s\n",
 					    cbb->fabric->errors[type].code);
@@ -281,6 +289,12 @@ static void tegra234_cbb_print_error(struct seq_file *file, struct tegra234_cbb
 	type = 0;
 
 	while (overflow) {
+		if (type >= cbb->fabric->max_errors) {
+			tegra_cbb_print_err(file, "\t  Wrong type index:%u, overflow:%u\n",
+					    type, overflow);
+			return;
+		}
+
 		if (overflow & 0x1)
 			tegra_cbb_print_err(file, "\t  Overflow\t\t: Multiple %s\n",
 					    cbb->fabric->errors[type].code);
@@ -333,8 +347,11 @@ static void print_errlog_err(struct seq_file *file, struct tegra234_cbb *cbb)
 	access_type = FIELD_GET(FAB_EM_EL_ACCESSTYPE, cbb->mn_attr0);
 
 	tegra_cbb_print_err(file, "\n");
-	tegra_cbb_print_err(file, "\t  Error Code\t\t: %s\n",
-			    cbb->fabric->errors[cbb->type].code);
+	if (cbb->type < cbb->fabric->max_errors)
+		tegra_cbb_print_err(file, "\t  Error Code\t\t: %s\n",
+				    cbb->fabric->errors[cbb->type].code);
+	else
+		tegra_cbb_print_err(file, "\t  Wrong type index:%u\n", cbb->type);
 
 	tegra_cbb_print_err(file, "\t  MASTER_ID\t\t: %s\n", cbb->fabric->master_id[mstr_id]);
 	tegra_cbb_print_err(file, "\t  Address\t\t: %#llx\n", cbb->access);
@@ -373,6 +390,11 @@ static void print_errlog_err(struct seq_file *file, struct tegra234_cbb *cbb)
 	if ((fab_id == PSC_FAB_ID) || (fab_id == FSI_FAB_ID))
 		return;
 
+	if (slave_id >= cbb->fabric->max_slaves) {
+		tegra_cbb_print_err(file, "\t  Invalid slave_id:%d\n", slave_id);
+		return;
+	}
+
 	if (!strcmp(cbb->fabric->errors[cbb->type].code, "TIMEOUT_ERR")) {
 		tegra234_lookup_slave_timeout(file, cbb, slave_id, fab_id);
 		return;
@@ -639,7 +661,9 @@ static const struct tegra234_cbb_fabric tegra234_aon_fabric = {
 	.name = "aon-fabric",
 	.master_id = tegra234_master_id,
 	.slave_map = tegra234_aon_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra234_aon_slave_map),
 	.errors = tegra234_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x17000,
 };
 
@@ -655,7 +679,9 @@ static const struct tegra234_cbb_fabric tegra234_bpmp_fabric = {
 	.name = "bpmp-fabric",
 	.master_id = tegra234_master_id,
 	.slave_map = tegra234_bpmp_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra234_bpmp_slave_map),
 	.errors = tegra234_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
 };
 
@@ -727,7 +753,9 @@ static const struct tegra234_cbb_fabric tegra234_cbb_fabric = {
 	.name = "cbb-fabric",
 	.master_id = tegra234_master_id,
 	.slave_map = tegra234_cbb_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra234_cbb_slave_map),
 	.errors = tegra234_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x60000,
 	.off_mask_erd = 0x3a004
 };
@@ -745,7 +773,9 @@ static const struct tegra234_cbb_fabric tegra234_dce_fabric = {
 	.name = "dce-fabric",
 	.master_id = tegra234_master_id,
 	.slave_map = tegra234_common_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra234_common_slave_map),
 	.errors = tegra234_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
 };
 
@@ -753,7 +783,9 @@ static const struct tegra234_cbb_fabric tegra234_rce_fabric = {
 	.name = "rce-fabric",
 	.master_id = tegra234_master_id,
 	.slave_map = tegra234_common_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra234_common_slave_map),
 	.errors = tegra234_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
 };
 
@@ -761,7 +793,9 @@ static const struct tegra234_cbb_fabric tegra234_sce_fabric = {
 	.name = "sce-fabric",
 	.master_id = tegra234_master_id,
 	.slave_map = tegra234_common_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra234_common_slave_map),
 	.errors = tegra234_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra234_cbb_errors),
 	.notifier_offset = 0x19000,
 };
 
@@ -940,7 +974,9 @@ static const struct tegra234_cbb_fabric tegra241_cbb_fabric = {
 	.name = "cbb-fabric",
 	.master_id = tegra241_master_id,
 	.slave_map = tegra241_cbb_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra241_cbb_slave_map),
 	.errors = tegra241_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra241_cbb_errors),
 	.notifier_offset = 0x60000,
 	.off_mask_erd = 0x40004,
 };
@@ -960,7 +996,9 @@ static const struct tegra234_cbb_fabric tegra241_bpmp_fabric = {
 	.name = "bpmp-fabric",
 	.master_id = tegra241_master_id,
 	.slave_map = tegra241_bpmp_slave_map,
+	.max_slaves = ARRAY_SIZE(tegra241_bpmp_slave_map),
 	.errors = tegra241_cbb_errors,
+	.max_errors = ARRAY_SIZE(tegra241_cbb_errors),
 	.notifier_offset = 0x19000,
 };
 
-- 
2.17.1

