Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00556E5FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjDRLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDRLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:35:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB337DA9;
        Tue, 18 Apr 2023 04:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqOZ0vQ4BrQSf7TlrxXBruqNmERlapYetcFKN9aSXNOcEWEb0tLXHWSwWj1Y6FpgZf9WaO7j1eOCOnSEyhpU/7obzth29X6oARM3jGUi9ddZt/ggieQRCN7mMFFSNwzqm+HaTV0mdVUaTfrabIgxQ5tUhul8CAhnfDStPPLA/bvU3+MJOvgBECt8ZnE4c5vwY43cU1YLMdXBBU2DESmDZopScuyegdRnCgg3VI4UlwqTvdDM4y+o9fxxV1EPUWl0SwgJoQugSUT5I1ytil7nppDAl6YEJwZRv1rdGa3yGigZLNiHO+VVoX/QNGN3/AzxC5DKaMDq0kNAoOUSR+LprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y653bwi3M5aOq9x8QWV3YqXHIBfbVcGhKhc8M8w/8g=;
 b=RcK7hXxojjDWv2+jA8hYgOP0Dp0oBMVR0n7yNnF/9jUarkHJuEMZgqSwrYiifRzMpW0fdicopxFwo38EUVAbivgfapShs7G+0lzV6uFKFMsbvDbqYwM3X+dCOwlIdhbi/Hw6SXGZIX78ZVETJZrYyDNQIbrQhAFHO/lcLIGwhtHNUqM6L+HBQtX7g1vmBDimWdUSmY+DXgGPV0erTFtOfUyi5d+i2TkK3i20Lc7TaPaIuPbssH76MBkr8TQ8By1ZiIHS0gOktqc3nxzkfL4YK6biKsiGOWTS3fbY6r7AyfKcYfuG3sMw7/EZZ0zpP0CpbdYLnU8MY7VJ7OYRjhdhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y653bwi3M5aOq9x8QWV3YqXHIBfbVcGhKhc8M8w/8g=;
 b=H/UU0CtaeATeaefAd2T0aUPQm2/X85o7N3kWXgkuNse/qnJMVITUW6FIuXflsa+WjYo2+ugGJIv76zUpZovparhpLLcGj7qShkbeoKsnRgrHqWvWZRLuoYORsdIY4qPVl7GjM8HgU89K0mHKDmRAS14b7HfqNAvCIae6SM7KbkxYQmeZiC/CJsiOPrx2oZU7w8utVWARmA96OgaBG9T3JcvEG9ulLqMmBC9wSzTgO3Fra8EumVpc3dI6uXWC45OuBmrI29NJ07s2x1iaAWe+Pyx/6fse2he61v7BUBoXc0vCFkL+AO/fic2Cfjt/NifoyfvDtvtOYl6WT2hgIk3k4A==
Received: from DM6PR17CA0009.namprd17.prod.outlook.com (2603:10b6:5:1b3::22)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:35:45 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::c6) by DM6PR17CA0009.outlook.office365.com
 (2603:10b6:5:1b3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 11:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:35:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:35:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:35:43 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:35:38 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <mark.rutland@arm.com>,
        <sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <sdonthineni@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 2/6] cpufreq: CPPC: make workaround apply code generic
Date:   Tue, 18 Apr 2023 17:04:55 +0530
Message-ID: <20230418113459.12860-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418113459.12860-1-sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 860a25bf-206c-438f-9a87-08db40010c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yVfHm6lv8xr9aQ/Sfn64LGzjgZG/y2HD7cYhiMYMf1RvKJk/uk6pqwD1rraRUasHr/pu/uwPid7vvga/rMckFn1jI/BpxkOXPjJmcHEs7Fm7iV7FXKRXk2Xyp1mlEknq09dLLWpHRWMNohjkULT0lwlIfc3qPfl2OKwlT8jgRu/yLBu42sOOoq6y0o9CeyIsjmUznM0bRHPiEZjmtbZZ7gMx/F6aQZG1EJyOo3Us8Gz2aXymcQliU042ya1GRhjO9QzOo0LH9dN/3akRW2K9Y2YD/zgf49cKKXq6ocMZN5bnnBtbPUD/7utDhY4DiT7qxZeSLY4ZdgbohOsFFq8LoRwKzCdpsBmoYG/hGcyfiMQoDcSqqkc/qz3BDNlOVq7KOAxnxoYXzQ9pHd3ZjQvQjdnnuXqtAFM8V3vFxn2Eg/EWOgGevAM4B0rd4mm1M6cbN+PePgAQSeNs0hBB+qeQ+8XB2RZbx3CC5om7XN6phUXKoCvZNdBShaV2h+ehHjZ3D84GXeuVaA5Wf/yTOaodENruzVYss+HOIyS04+4NQ2FqnmzhvnvVf1Q4Ea/2nI0JbA9+RuT3sd69hDQSKcUve9is/0Sz/yoJuox53yJpYJCMzayUA4ddNC4ltBYMZkiUHOyVX+GGhVkkx+boMGWmoe1B/SLa2Ou2wuUERmeK+4LXEZyXe+JOqa1d3SyVFRa5qbAvQCCUO2qLVHYC4r3EskMqoJgcqydd+hKqR6uwO8a0Ck5kmF1HCw8Nt7MS+Tg90830/Us6+ZBf4O8bKY53LdTWGjU/nCbB28DscipbCG8SoO19KYikzCrqT98Up0S
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(7416002)(426003)(5660300002)(82310400005)(2616005)(336012)(47076005)(83380400001)(356005)(86362001)(186003)(26005)(7636003)(107886003)(82740400003)(1076003)(34020700004)(36860700001)(8936002)(8676002)(110136005)(54906003)(478600001)(40480700001)(6666004)(7696005)(41300700001)(316002)(40460700003)(36756003)(70206006)(4326008)(70586007)(2906002)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:35:45.2451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860a25bf-206c-438f-9a87-08db40010c9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the code which applies SoC workarounds to make it generic
and easy to reuse.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..15c2cbb7a50e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -43,10 +43,13 @@ static LIST_HEAD(cpu_data_list);
 
 static bool boost_supported;
 
+static void cppc_check_hisi_workaround(void);
+
 struct cppc_workaround_oem_info {
 	char oem_id[ACPI_OEM_ID_SIZE + 1];
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 	u32 oem_revision;
+	void (*apply_wa_func)(void);
 };
 
 static struct cppc_workaround_oem_info wa_info[] = {
@@ -54,10 +57,12 @@ static struct cppc_workaround_oem_info wa_info[] = {
 		.oem_id		= "HISI  ",
 		.oem_table_id	= "HIP07   ",
 		.oem_revision	= 0,
+		.apply_wa_func	= cppc_check_hisi_workaround,
 	}, {
 		.oem_id		= "HISI  ",
 		.oem_table_id	= "HIP08   ",
 		.oem_revision	= 0,
+		.apply_wa_func	= cppc_check_hisi_workaround,
 	}
 };
 
@@ -938,6 +943,13 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 }
 
 static void cppc_check_hisi_workaround(void)
+{
+	/* Overwrite the get() callback */
+	cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
+	fie_disabled = FIE_DISABLED;
+}
+
+static void cppc_apply_workarounds(void)
 {
 	struct acpi_table_header *tbl;
 	acpi_status status = AE_OK;
@@ -951,9 +963,8 @@ static void cppc_check_hisi_workaround(void)
 		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
 		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
 		    wa_info[i].oem_revision == tbl->oem_revision) {
-			/* Overwrite the get() callback */
-			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
-			fie_disabled = FIE_DISABLED;
+			/* call work around function which matched from the table */
+			wa_info[i].apply_wa_func();
 			break;
 		}
 	}
@@ -968,7 +979,7 @@ static int __init cppc_cpufreq_init(void)
 	if (!acpi_cpc_valid())
 		return -ENODEV;
 
-	cppc_check_hisi_workaround();
+	cppc_apply_workarounds();
 	cppc_freq_invariance_init();
 	populate_efficiency_class();
 
-- 
2.17.1

