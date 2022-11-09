Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A4C622CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKIN6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKIN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:57:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED0B1AF39;
        Wed,  9 Nov 2022 05:57:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOpx51R1Xiy+TTjvjnhZNqBcdpmbes101wGHEmupL2on1E6/aJD3ACVVGoE2o0Lp7/fEjl/menSFF0iIT/I8dhdAog6Wp6jiiRZJGShIowJTsnaJlWNyZ0LQqVJmAtT+XPW5muy678SInyq4MCKGOcMtm74tVhVOeWSWzxJRmqD7FnWjCtpGMKXrvz7aplUWpSg5fZmEdTm9N9Vlr0Ns9g6jTUEbyCdYmNGAO103bqcwPY3nqeUWaDyViRSnXZ1iuMFdYvWmMI3uRSatQCbB+bW799MpdcXs8fNkqdBvlkTkE8N8hozQHBrrLm8O3H9LtpSKKy7aLqjPtEKI1pRWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eYSS817GSKpUoHeunokUG1vix9Y9TpknM1af4HEfdw=;
 b=cuKnhFiumNvHp96mKGlWUhAatCDghgRE7300MNp1S+D9Nhfr92xPLU9x47THsQ9h+JIuYZ2eFqgH6+kwLoOZEIfAku+ifMQ9dEiuB156/DtoXJsnLxnm6ksvGWVaOQAK6KqV5Fm335kVE18Xu/TaG4HC82e7MdJcWyXw/r4XO6NIefPqRUkxk1oDhwZM42DkHA6EFb5tic69vnzbwk/GkxGmLGkX0nxgazCfKuZcrpFIB5AQflaikjvjqR1gcsbMPPEb7jwQwPY/4YF5TCYJ5TWsaiu87bVvPp33tekri78yMOuji4G0VGdn/1UPF8Ain9WDJt7KAo0kcFDbYH+4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eYSS817GSKpUoHeunokUG1vix9Y9TpknM1af4HEfdw=;
 b=KMYnrPDybFuLgzS6RlCT3EAYo0TERMPHZ1Y4emHU3k1uROREmEJJCHQtVaGH5b/Fu3UlNuUrrI6K+SgIiNpJhL16i5bh//q4CFheRo1dp7oSuyGSsKo6FxUc2Ns8M2/+7ZlIWD1jezYikMnLIZix4OQRu/cXiS3Mrp9DIp2A3yOIv3KriuNk629i/42tr6V08iTh57am/06OXm4SKa8ELdxFoFh2CjKTCoV9Ed93l/AkSjZSigx1zteO3nyueJboB7KY5bb+g1YqN87TOPKAq6BDWi8T0qLBBM66YGFjQsTYwVPqMLv5kJBcINFawB/xQnifk/0vTxMighGfcMf/qA==
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 13:57:34 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::f5) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 13:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 13:57:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 05:57:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 05:57:27 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 05:57:25 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 2/4] soc/tegra: cbb: update slave maps for Tegra234
Date:   Wed, 9 Nov 2022 19:27:15 +0530
Message-ID: <20221109135717.3809-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109135717.3809-1-sumitg@nvidia.com>
References: <20221109135717.3809-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 00adaf12-06c9-490f-1bb8-08dac25a5a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpXL6mWZMLKzWhOd7NEVt6a9WbR4nG0FSHvx6NmBQt1R8P3Rq5j+EjwA5tGceqAdazk9ppNg8Y4+BSKviukmrb0iyfdP6jZrOMHKEfGjUEZB5W+bHEPEGjcYY+r3txhvCP/NPV5LuWVGywHYQFIY3ypSeBGz/icz5BH9a1+sNjzJikfuSXCAgrzzTovsAWESK+KEFfugwWY04rHj6aUExRb0YR3a7WGp8upzuX04BzJqHDIa9HjhcVMoTtBtCWtlPPEdTJpQd5IHrt95L/kb5e9HPJwTbotAufUGD8MAmM17oWl0ZdpmV4vpQV9xvlbOyQXpaqlCzF6+AvABOi4Cg509LU8Q/cGwzPdPiP2+mza9XwjIYqChFHT8/gr4255QPu67m8poDqSiS1O8Tsf3+JGMV2qOZOAzlG2hJdWfdFT/zNLFYurrtGUtdzZuK4GAv0gdEREzCKGmLmyk3ns4P9pTXt84Mtnm49lOxysRtPVgawunPW9zPXbEkMnAvIfSU0zEN8u8xzuIeIcbRkrg+KPbxDncoiZNvok3hlked8whsfTeVTqGG3Dl4ES+ZZ+/ebPrYUIDk/kkFaTocp1MHNVgQnopc+TJvkYrSB4RfyqKbhGSP3+aCx+tn5wK7sPW1NT9Xh0Do8EnwUNMXGJCcXKjvaq/wCZUyjYI+E2bVsUR1KPzQBlHyNvoXF7SABqee5fldNZEA0yeMED56rtM3zBn8HiVQMCPkUSP5lBsDTc3GXtsk9mZ8zkxyXgFfIGvs0gJclKWXVSG6hEK1rBD/Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(2906002)(82740400003)(7636003)(356005)(40460700003)(2616005)(83380400001)(426003)(47076005)(186003)(1076003)(336012)(6666004)(107886003)(82310400005)(26005)(36756003)(36860700001)(7696005)(316002)(4326008)(8676002)(450100002)(70206006)(70586007)(86362001)(40480700001)(8936002)(5660300002)(54906003)(110136005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:57:34.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00adaf12-06c9-490f-1bb8-08dac25a5a4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the slave map for fabrics and using the same maps for
DCE, RCE and SCE as they all are a replica in Tegra234.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 34 +++++++++++-----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 654c3d164606..04e12d9fdea5 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -516,7 +516,7 @@ static irqreturn_t tegra234_cbb_isr(int irq, void *data)
 		u32 status = tegra_cbb_get_status(cbb);
 
 		if (status && (irq == priv->sec_irq)) {
-			tegra_cbb_print_err(NULL, "CPU:%d, Error: %s@%llx, irq=%d\n",
+			tegra_cbb_print_err(NULL, "CPU:%d, Error: %s@0x%llx, irq=%d\n",
 					    smp_processor_id(), priv->fabric->name,
 					    priv->res->start, irq);
 
@@ -732,48 +732,35 @@ static const struct tegra234_cbb_fabric tegra234_cbb_fabric = {
 	.off_mask_erd = 0x3a004
 };
 
-static const struct tegra234_slave_lookup tegra234_dce_slave_map[] = {
+static const struct tegra234_slave_lookup tegra234_common_slave_map[] = {
 	{ "AXI2APB", 0x00000 },
 	{ "AST0",    0x15000 },
 	{ "AST1",    0x16000 },
+	{ "CBB",     0x17000 },
+	{ "RSVD",    0x00000 },
 	{ "CPU",     0x18000 },
 };
 
 static const struct tegra234_cbb_fabric tegra234_dce_fabric = {
 	.name = "dce-fabric",
 	.master_id = tegra234_master_id,
-	.slave_map = tegra234_dce_slave_map,
+	.slave_map = tegra234_common_slave_map,
 	.errors = tegra234_cbb_errors,
 	.notifier_offset = 0x19000,
 };
 
-static const struct tegra234_slave_lookup tegra234_rce_slave_map[] = {
-	{ "AXI2APB", 0x00000 },
-	{ "AST0",    0x15000 },
-	{ "AST1",    0x16000 },
-	{ "CPU",     0x18000 },
-};
-
 static const struct tegra234_cbb_fabric tegra234_rce_fabric = {
 	.name = "rce-fabric",
 	.master_id = tegra234_master_id,
-	.slave_map = tegra234_rce_slave_map,
+	.slave_map = tegra234_common_slave_map,
 	.errors = tegra234_cbb_errors,
 	.notifier_offset = 0x19000,
 };
 
-static const struct tegra234_slave_lookup tegra234_sce_slave_map[] = {
-	{ "AXI2APB", 0x00000 },
-	{ "AST0",    0x15000 },
-	{ "AST1",    0x16000 },
-	{ "CBB",     0x17000 },
-	{ "CPU",     0x18000 },
-};
-
 static const struct tegra234_cbb_fabric tegra234_sce_fabric = {
 	.name = "sce-fabric",
 	.master_id = tegra234_master_id,
-	.slave_map = tegra234_sce_slave_map,
+	.slave_map = tegra234_common_slave_map,
 	.errors = tegra234_cbb_errors,
 	.notifier_offset = 0x19000,
 };
@@ -888,7 +875,7 @@ static const struct tegra_cbb_error tegra241_cbb_errors[] = {
 };
 
 static const struct tegra234_slave_lookup tegra241_cbb_slave_map[] = {
-	{ "CCPLEX",     0x50000 },
+	{ "RSVD",       0x00000 },
 	{ "PCIE_C8",    0x51000 },
 	{ "PCIE_C9",    0x52000 },
 	{ "RSVD",       0x00000 },
@@ -941,8 +928,12 @@ static const struct tegra234_slave_lookup tegra241_cbb_slave_map[] = {
 	{ "PCIE_C3",    0x58000 },
 	{ "PCIE_C0",    0x59000 },
 	{ "PCIE_C1",    0x5a000 },
+	{ "CCPLEX",     0x50000 },
 	{ "AXI2APB_29", 0x85000 },
 	{ "AXI2APB_30", 0x86000 },
+	{ "CBB_CENTRAL", 0x00000 },
+	{ "AXI2APB_31", 0x8E000 },
+	{ "AXI2APB_32", 0x8F000 },
 };
 
 static const struct tegra234_cbb_fabric tegra241_cbb_fabric = {
@@ -955,6 +946,7 @@ static const struct tegra234_cbb_fabric tegra241_cbb_fabric = {
 };
 
 static const struct tegra234_slave_lookup tegra241_bpmp_slave_map[] = {
+	{ "RSVD",    0x00000 },
 	{ "RSVD",    0x00000 },
 	{ "RSVD",    0x00000 },
 	{ "CBB",     0x15000 },
-- 
2.17.1

