Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140DC730E98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbjFOFSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbjFOFSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:18:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FA26AA;
        Wed, 14 Jun 2023 22:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogHhtXIEySsTD/DbumsGC82dhDtbv11BdPEYXZqD/ZPflF53+pkY7fc5yQFEMRCJDn3zEedG+tsOzcUe+YB/ZjQAhzgHVN/pw1BN4vX91d3hJU+6Hm+6ffGCEC8Xuv0QExg6Jw1BU/+0CyEH7j/1ISXfjAirAu1Nx/rWWwKaBzGc8L1a6WrCpd6uRm5JKDv7fE/MsEZsWsO9GPW90RJKSArhRairF30AazoW+9H7odKkrTp2VzJFw0gK6GV+RYHY5YoCiU7DzvG2GmuAe2kDe4OLLnH98KiVwhzahe4ANUp+9q7w+6smCZ3El4617CxwH+GZTMeRxJ3l/yT2aq2ijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ST+1N4AP2h9SfKLNCEbqV/wWYRWBNuR+dUrCdoQzSs=;
 b=ZzY4F0DTAUO06OJz7x5jndWJZQ8l2fEFW9UtuUfXanJ154qAScDkcUZJgPJCcF2G9vKbhxbPN+zkIR7B/v01CRYcaa9foqUzhvy97HukzIpLc3Eg9lnU4ufOqG1hVbmMYP3iXCQBz0zXfAI3PHMdfiKH6yJUFlbv9nbV++wisulPjLEfNusePR3oVGqYI2LQVascvogBsLgVHah2gmrZAvTVosliXa5W0nORkVzqJxkcLlcZbR0Byg2GRaukq//Iur2Dibowt5JvJ6h8VKjaTWDx4BnB7ylnkngJCYAdpddhIlhYkTkkVnfcumswPY7YLUBWpGrCTyGZKUAnbYSCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ST+1N4AP2h9SfKLNCEbqV/wWYRWBNuR+dUrCdoQzSs=;
 b=bI2VX1SXpi+1BxXlMR+/i5jGLeVAGwnthmS8CVIVGrvyB86Twh0pUM1kwnEjQvps/0FyXJO+HhagXPZMrW4UeQLn4DG+XqMWrfv9PxqUeWZJvgQsukRF+t/DkJHXGlUxy8SGeQi+ZCis3Q33mrv65FvVX498UaNkq1GUvd4Iu20=
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 05:18:20 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::85) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 05:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 05:18:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 00:18:14 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <james.clark@arm.com>, <alisaidi@amazon.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <mark.rutland@arm.com>, <maddy@linux.ibm.com>,
        <tmricht@linux.ibm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 3/3] perf mem: Scan all PMUs instead of just core ones
Date:   Thu, 15 Jun 2023 10:47:00 +0530
Message-ID: <20230615051700.1833-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615051700.1833-1-ravi.bangoria@amd.com>
References: <20230615051700.1833-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d9c079-2ae8-4aa5-c804-08db6d5fef23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq+6/Z1AQSLSw2xK3OorZ6RXlbeyMH8L+MBZZ7dFzs/oNe2Lt2JJk5yiiRmLpeXD8RCSSlIXmMAwCya6QZ4ph7Ax7l0iJNY2ZfZrw2188SiwZR4eoGiPnoDqM1sOawZ5hGA96jgYfxWrQ35TQf8MZZNRGedv/rO9MzF/y8bCSsv42hNkAQ1WSbXpgOBUD2r/6iHkbVsepBuLq5GWjclY1srbMtlKx1Ht6ZGIF4lev2r1isuIc7QsAx4UOreTKvmc5467DbORYIUg1wsUkwYmeemaOuJBCCheQjQ15ALyH6REVekJenScFpuvo1eoLp9MjPntmO1l9d6KSW1LkEQy2IrKwSaJumF3Qtg8EyyCXH2l54rrsUrEdMvK3Wo1N0s5ncPa9bwEu1eVPVH42tYLb+6IbebI6IZ5N+k+xeNm7s2x988wgkU5vloEtQpYfLvL8vPZwmiJ7kXMUX70ht03DcfKf89Lyr7QvAPmj6igSlWlmoLL3OsymM3pVKGFcczkJYlBCHa1qS2vB0O5iPGvv6/3q8OIAAze8wYbUC70oxBwaolfujYvCYkXYTbssql2cWMEdwdby92QMDRw05SgNcMY6GDSxzeE952G7TryNwxjHdA7NV+xmUBnOZy1G9wg+8trGbe13TYyAJxmKgaZCI/auOnOBcG1qjsIdnlsE8DLgKgrKHSKF/OtN3hqOFc9Qyyk0fguNq53b0Fv4QolMnUhpwVa6odof7EFmQQfKegOYKQHEJuW7xeRelzjQKQALTvOOrJi392H1TINmM+kAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(6916009)(6666004)(70206006)(316002)(70586007)(54906003)(4326008)(478600001)(36756003)(2616005)(82740400003)(86362001)(36860700001)(336012)(426003)(47076005)(83380400001)(186003)(1076003)(26005)(16526019)(41300700001)(356005)(5660300002)(8936002)(44832011)(7416002)(82310400005)(8676002)(7696005)(40480700001)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 05:18:20.3696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d9c079-2ae8-4aa5-c804-08db6d5fef23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning only core PMUs is not sufficient on platforms like AMD since
perf mem on AMD uses IBS OP PMU, which is independent of core PMU.
Scan all PMUs instead of just core PMUs. There should be negligible
performance overhead because of scanning all PMUs, so we should be okay.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index be15aadb6b14..c07fe3a90722 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -130,7 +130,12 @@ int perf_mem_events__init(void)
 		if (!e->tag)
 			continue;
 
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		/*
+		 * Scan all PMUs not just core ones, since perf mem/c2c on
+		 * platforms like AMD uses IBS OP PMU which is independent
+		 * of core PMU.
+		 */
+		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 			scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
 			e->supported |= perf_mem_event__supported(mnt, sysfs_name);
 		}
@@ -165,7 +170,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
 	char sysfs_name[100];
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
 			  pmu->name);
 		if (!perf_mem_event__supported(mnt, sysfs_name)) {
@@ -188,7 +193,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 		if (!e->record)
 			continue;
 
-		if (perf_pmus__num_core_pmus() == 1) {
+		if (perf_pmus__num_mem_pmus() == 1) {
 			if (!e->supported) {
 				pr_err("failed: event '%s' not supported\n",
 				       perf_mem_events__name(j, NULL));
@@ -203,7 +208,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				return -1;
 			}
 
-			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 				rec_argv[i++] = "-e";
 				s = perf_mem_events__name(j, pmu->name);
 				if (s) {
-- 
2.40.1

