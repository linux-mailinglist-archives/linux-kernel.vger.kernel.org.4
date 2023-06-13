Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1907872DE63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbjFMJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbjFMJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1133110F7;
        Tue, 13 Jun 2023 02:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXD1LhFDvO2Xf836UonY1A10c8ajIYg0ahcREs8CcqViY/HadbpwJdcNqJ6ouCk8uHyL1WT3ZMDM7fJjjxyM3rhSUMmNqI5BN7kyNvLHifYkHDEXNSG2GC/aNjT2FVkYAtydDuso6km2RBI6qihEUWvVYz+09vErIq1XxX3jDl87rpCsGU8AWdazZcwD4C6wP9jD5tQaLaPDLki6fW2rvBbd5CGG+kj2c9XVRac+Aqh0vIkvVIQlW4JAE1f1/bWIH3DioLdhMObruH2AcbHHK6UH2HNG7gVRgfnBoFYsdMlGPuUyhJ8b9nEEmzMEVzHQbjVNWD3YAKFVAWyL18WGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjhtwrSqUQQPgUBWDsmm175+OpJdVZSK9WpkNag4JYE=;
 b=FCR1JYiSC4psgGx1+4H2I3WBDFRfWTyAmn7opESOHG5qEnfoeyS09Bu3O6ixFHHf9aqZE7jo01E2Qcd2KvoIGUOTV2b/pkT3YyStkVre+BK2+T/puJBM6hkjOXAdNO6OKWR92LzGQRZaYxbBecjaMZBC1meJfBbm84F8rcs/HkbGdkKOx1460vBT74/xJklS8kVDlJK1/lEQtOFR3ijkLl7XrwVhs6wdGHJ4wxVQgQmoHl6f3Je9T4dK7xISVniN0PZCJo40VO2yNy6JLmS6uiqWlcXK+XQ/2KFyvPjrfw1QC+ruLGI3IOAyqeaANGPC1sZSEfe5ovMW47I6cX5NOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjhtwrSqUQQPgUBWDsmm175+OpJdVZSK9WpkNag4JYE=;
 b=j0q75D+G3uZqzSlOoAyOjfTMpVhOkNRqvEtVZ+0tflgBXvKBWyWZ0HdS4g3FtaOmmM/nu536BdKCK5pmMcFOsaHYUGTts6UoJbdKzl+G9kMHWhRvcTBQNcNIFv3JpaJJqnT4kC1mylLj+AH5ZaH+rd+MygWS/yEGsdkuvh6x4hI=
Received: from SN6PR04CA0081.namprd04.prod.outlook.com (2603:10b6:805:f2::22)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 09:56:22 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::6e) by SN6PR04CA0081.outlook.office365.com
 (2603:10b6:805:f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 09:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 09:56:21 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 04:56:15 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <alisaidi@amazon.com>, <leo.yan@linaro.org>, <maddy@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 4/4] perf mem amd: Scan all PMUs instead of just core ones
Date:   Tue, 13 Jun 2023 15:25:06 +0530
Message-ID: <20230613095506.547-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613095506.547-1-ravi.bangoria@amd.com>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: a7438da6-be89-4e06-f3d0-08db6bf47134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZleVwqXVnSsWo6rzFmUcJN2CSX8FgigPzIGQijOrZo6ZfQPp2QdGNMX9WtlbkXzYsInxECoh51xX/YFly7Qt3vLnXd2GeUFiwtG7GbDnH6OGM3uSX6LliswM15X0pi2o18xKpcIM/utbJJuKiMH/9lE4qahOurWKEV51+El9WmxHB9nBw0gCiToy9lTzddso5ik30M9MF47y0iMbQz0p1Vf9KurAQuhQz4+QodbzruqeDvOOatid2Ilb57ik+ZZMszs0D3eED0D2tzG4yrFdmr9tXgyxUJ3uGR38bNGZKS35TmFtlOdhYakOfBcehsoYh8Xy8G9F4nQtPfs81D2/lqMH/Gn84+/+n1podPZ6u9Vw5OadXyymfwiljNgSylgSzBwzTo6lAeTjck3xvvDOOzE1iZXYJHfZYH5kP8suaModrhZkp4KJISbL+6b+ctQctOUwgSgSpWClCFsfL0/wB3FNg+0tyflMn3KCyZvLUc0zPBvT2Io0hjowKSJv98kaWGIPkc5V5fv6au47fIFp/yUI2dCKln+cZY2gHYSyFwgLXMTl5tLdw4tz38ExczAdtdB6jALpTn3FGfquYUr3YIzn/uqaTrpd3A7+OfyTsV5gk4j0QJfIOASp/cfaMqIrTZn9ETjJH0Q6WJkmqQBlnBMKq3RFuh9L9KxN/X0OsfRcOiiIO3UIrJM+bQFpHAw5I+WEiBriUEDDAFf59mBAzfqncaHh79ZdPrt9/i+knglnVwEQOlBFhI9tPj64/kNMszV+Sw/x0B2N3rlBt4ofg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(83380400001)(36860700001)(7416002)(336012)(426003)(44832011)(36756003)(478600001)(8676002)(40480700001)(8936002)(70586007)(86362001)(316002)(41300700001)(82740400003)(356005)(81166007)(70206006)(5660300002)(4326008)(6916009)(7696005)(6666004)(2906002)(82310400005)(54906003)(186003)(1076003)(26005)(16526019)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:21.7920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7438da6-be89-4e06-f3d0-08db6bf47134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning only core PMUs is not sufficient on AMD since perf mem on
AMD uses IBS OP PMU, which is independent of core PMU.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/mem-events.c |  5 +++++
 tools/perf/util/mem-events.c          | 16 ++++++++++++----
 tools/perf/util/mem-events.h          |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index a8a782bcb121..43af872e89a6 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -91,3 +91,8 @@ char *perf_mem_events__name(int i, char *pmu_name)
 
 	return (char *)e->name;
 }
+
+bool perf_mem_events__via_core_pmus(void)
+{
+	return !x86__is_amd_cpu();
+}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index be15aadb6b14..0c04f883d634 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -109,6 +109,14 @@ static bool perf_mem_event__supported(const char *mnt, char *sysfs_name)
 	return !stat(path, &st);
 }
 
+bool __weak perf_mem_events__via_core_pmus(void)
+{
+	return true;
+}
+
+#define perf_mem_scan_next_pmu(pmu) \
+	(perf_mem_events__via_core_pmus() ? perf_pmus__scan_core(pmu) : perf_pmus__scan(pmu))
+
 int perf_mem_events__init(void)
 {
 	const char *mnt = sysfs__mount();
@@ -130,7 +138,7 @@ int perf_mem_events__init(void)
 		if (!e->tag)
 			continue;
 
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		while ((pmu = perf_mem_scan_next_pmu(pmu)) != NULL) {
 			scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
 			e->supported |= perf_mem_event__supported(mnt, sysfs_name);
 		}
@@ -165,7 +173,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
 	char sysfs_name[100];
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_mem_scan_next_pmu(pmu)) != NULL) {
 		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
 			  pmu->name);
 		if (!perf_mem_event__supported(mnt, sysfs_name)) {
@@ -188,7 +196,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 		if (!e->record)
 			continue;
 
-		if (perf_pmus__num_core_pmus() == 1) {
+		if (perf_pmus__num_mem_pmus() == 1) {
 			if (!e->supported) {
 				pr_err("failed: event '%s' not supported\n",
 				       perf_mem_events__name(j, NULL));
@@ -203,7 +211,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				return -1;
 			}
 
-			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			while ((pmu = perf_mem_scan_next_pmu(pmu)) != NULL) {
 				rec_argv[i++] = "-e";
 				s = perf_mem_events__name(j, pmu->name);
 				if (s) {
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 12372309d60e..d650eb311113 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -36,6 +36,7 @@ enum {
 extern unsigned int perf_mem_events__loads_ldlat;
 
 int perf_mem_events__parse(const char *str);
+bool perf_mem_events__via_core_pmus(void);
 int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i, char *pmu_name);
-- 
2.40.1

