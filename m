Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D169B051
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBQQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBQQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:14:23 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032A6EF0A;
        Fri, 17 Feb 2023 08:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igv1IWVzi0haoqszYiL67/HcjmsiZPwywN2ByTkgr+eb2OsWJlGiNSvZeFrJTFn7KWszGyGYZ2L1TkXHahiPkToB/p7YGziiOIQCTMsL3bKRbR+aXrLpZBUY1NK6mdIg8kTwWiLp0c5oR8K3WuHc6HlSK8RrmRvtb3Hoztg+hzmwztH6c3tOGBeRwCcXlFnG0zjDC79Knma4C2aXpmMZK/iO3Y/1jG8aH65NLwEUdiw0Kf7/X66eYAc2WHuXsFFEh2wWNhR557ABU7Rr8U1VuylSJQjVWtmGEY3/Pi5Zy29wlEA9vBb4NUa3jVlRc6LeR5oBUWmhtSFdZpzY4PdREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4pULfmYSeRWtDzvhHtmTTzaG9ABd4iFHv8l4GAfUWk=;
 b=V32bNOq8q6i1bTNJYxeyudc/KMGqFATjyZyCUwzBvckU1kLcciHYPxMd7U1HQ3xLt0PG70VpZaVFqb95EAdUic4sU0ul2ALkASg6HL8IVwMM7dVJWJFsOhO6WLnpDtE+MfZj5yQQyzovFlK5YoOzahyBgXcUVS1JCbX4/v3HGt/q0ra1Hx1ZE5YdVSulRIW+gko3XPHYcffZylRm60iy4WzqOt20XWHQjuzXXCpXnzHiKZJVDAX5umjZEiQzYZybbyqbq7+HsXUxIyw8NnfhYqOtt4488Tib9sn3i1tf0EBxJo1KAZAnGdANekTuQYNjFN+s7f9LYhoEjfVy0Lmjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4pULfmYSeRWtDzvhHtmTTzaG9ABd4iFHv8l4GAfUWk=;
 b=rGu9NVOQqzGndOo1kl1RSe05S8mvjOYAK7dD+IDUp88kAPCuA42/hhA36ewRzIlTrM293gNbMnVJRpEomimpPe0tMHv60EbFTlOewycYPLhsUlwFc2U7DjsWS/zYaKwTSg/mTrbZsMx9Ez2V1K6tAMPBYMVm01KuOGmOYvcbmA0=
Received: from MW4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:303:16d::20)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 16:14:18 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::d2) by MW4PR02CA0009.outlook.office365.com
 (2603:10b6:303:16d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Fri, 17 Feb 2023 16:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Fri, 17 Feb 2023 16:14:17 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 10:14:11 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <ananth.narayan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Date:   Fri, 17 Feb 2023 16:13:54 +0000
Message-ID: <20230217161354.129442-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: acfa5eca-447f-4915-3c3c-08db110204ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnkZTZJXldC4K7sj3LpFhYDjM9hjyi2nXc7jPK1QUyhNBRaHk+DfCz6svsNbYmBECDGJzh75qWnfJxU23Th4Kz4UbFF2fwIhS0PYehoWSfTi53jOKSTvMMDpthO08KwfajCC7SzNcmshUY/sq0fqnfbLdOmgUx1lRgNlD2xxDRtmfGgOjKQ8eeABnkAP6k+YTRZRMC2M6LfTnpON7skgaAMz1E+OldRNP3J2kfuKn+IinaB1BC6BUjRtA8e56pLiIvtb/cZ+NbqeGmh7qjqOhJVE9FlHoVxXw8EOvLdWQvk8cbmv0UNANaRCeGuLL5a5mL6ybesQtluAMkvhYtgTRdLwERw2XJJ95gEt8Nvd7hphZxyccLvYdImozmr602yfCo7O18Igtsn/tXy4NoWuoIYY+dBjRUgBxAPQBw5v/r3s9Dr/eOo8aOUh+3KAoa27T6ZqWXLe/Z7hv9ntHBkZtKulyhmt2ZaN2JYywHEUwdooCODr4dbXrfMbI1pLMUBVvN0J88nxL0io77x5/B/T+Hh4MASN5ZxEZsGW9fPH/oU72PN1pydmSlotuMu5xyURlwMfnd1naotGLDjT/80ikNMjvFy33F2SxeU0EzCKnjLBukrme6AnzkRPPIlFMBqjttHn6WjFkani9EpR1Nh+btDtMcA9vGrxLafphumolYYxaESGmojskPjZkR/jybrQcOuVJMMnwXpSVB6mZQef6osWRGisRdcjJTHEO+SOJRP4SIb1V7A7H6aY8xWyChJ6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(81166007)(36860700001)(40480700001)(36756003)(1076003)(186003)(6666004)(26005)(16526019)(86362001)(356005)(82740400003)(921005)(426003)(336012)(83380400001)(47076005)(2616005)(54906003)(478600001)(70586007)(4326008)(316002)(8676002)(70206006)(7416002)(8936002)(44832011)(41300700001)(40460700003)(5660300002)(110136005)(7696005)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 16:14:17.2781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfa5eca-447f-4915-3c3c-08db110204ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD processors support per-package and per-core energy monitoring
through RAPL counters which can be accessed by users running in
supervisor mode.

Core RAPL counters gives power consumption information per core.  For
AMD processors the package level RAPL counter are already exposed to
perf. Expose the core level RAPL counters also.

sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/

Output:
S0-D0-C0           2               8.73 Joules power/energy-cores/
S0-D0-C1           2               8.73 Joules power/energy-cores/
S0-D0-C2           2               8.73 Joules power/energy-cores/
S0-D0-C3           2               8.73 Joules power/energy-cores/
S0-D0-C4           2               8.73 Joules power/energy-cores/

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 arch/x86/events/rapl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 52e6e7ed4f78..d301bbbc3b93 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - want to use same event codes across both architectures
  */
 static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PP0]  = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
 	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
@@ -764,7 +764,8 @@ static struct rapl_model model_spr = {
 };
 
 static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
-- 
2.34.1

