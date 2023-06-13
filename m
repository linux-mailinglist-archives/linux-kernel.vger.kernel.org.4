Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DC72E039
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbjFMK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbjFMK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:58:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9FE52;
        Tue, 13 Jun 2023 03:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbjj9MhXMEJjsx36MvOndm76R3BKXv/xj8BBRJ37wtaQQHoZzIqDfGoRxaifRKZUokC3a2GRF/WQJw2KBNhlIAGW41Kl3z74liMtT99p2Ch7sgmtwcbystzlRB/j7NNo6tB9Z6UONGUm6Htc+1I9PEOzxQOv4AqZgFnFRU8v7UTLLDKWQgKeST0hvwTdXkOlvWT2DpDIgdEUpoCD0jiIKA0kCKhY/yO+xhB1vPwXFIpxUewsR3IyLOpmB4aX2R66gTUdEQAdmRJ8ccowNaBc3Uw+bM50r/Pj9fyc59NAd2+awvS9o9QwZGIX4XSPSioA0PjsqoTX7p5UEG6mKZVlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk//4IoYBKjHQ1JDmQ07PqeMkvW82IRfRisSTS5An2c=;
 b=UELBtrNsBAobSNmQFM+k3VKj/pvMkkQ0oFcbI5IfPjYNtx20UUWZSZSDYr1mogjbmTTlFSy0N0FLoZ+Gf3eT+whzOKd0R6qaMQ+eJQv9yjCjEI1jUELcZwFEZJzPszfmzeKv8iJTTV8aKQ954RGQFbFXxSOwd8hF5pobi5DwHQ6vlXZWixFjWwDCDNiH65IJofI6wI5wQaT6GLe3Uxxpc5Fbn+Sm454VHBUzD6iS5TvepxhIzYloHpfqBWNOFrv/8Mr5p51AO9pvhuLaG/RAJA2rBIx1aPQWO8MQVbGyD27hnk/9hIulHcJZ3R2MQlaPfr09P14vBVpFg149cVy6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk//4IoYBKjHQ1JDmQ07PqeMkvW82IRfRisSTS5An2c=;
 b=D+3OirCg1zPCyjhA23rr3AroHKwEDyk/1q4dDqrE/UDSlUsALVZXGoK4oVy9XQxbzcYG0JpnYutUCuBXponYpruklgmke85MnQwPUpb7Gyg3h2Jnx7ZtnnBiL3Mry4K8qTjEnSCPyr26hbc8V5+phFFtNxrJOMMY1V8Im7rdIvQ=
Received: from CYXPR02CA0034.namprd02.prod.outlook.com (2603:10b6:930:cc::22)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 10:58:23 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::ec) by CYXPR02CA0034.outlook.office365.com
 (2603:10b6:930:cc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 10:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 10:58:23 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 05:58:17 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <stable@vger.kernel.org>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/core: Fix overflow reset on hotplug
Date:   Tue, 13 Jun 2023 16:28:09 +0530
Message-ID: <20230613105809.524535-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee303c8-10bd-43a0-d1d9-08db6bfd1bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYh/7VuQaE8NdAeUAGjB7wGJE62EJnA0VeIUTsBjdr14LErQS045kW4Xq4GQCrX+bN2GUIGDrb8m2qW5gLRDhCFW5MTMSwa0hoZl4eGelraL/SVInAo6y2GxojFPokvTOk7v2jc6At1j6fLlTzifvvJT1hRWwPkVzB4P4MDB1ODETSfSaqrjR4qIWc1DE8gFL1sBIyO/gqOOS/rCYODlxyZ9iI0FtvJNlMgIkz9F6BswX7svZVF0C1135+Ev1nQUnRPMEyLYUxf49C4jToARbfbcPQdn8mOOeLFYJHjVWucsRRX7g/Cd0W3P8xppTIuLXvE8a2fDPAdg7D0j3ueo9xtoyQmaPD+Sf515NgIkEnlpDodoF1rbNK5ZFszYbZ4Cs9yfRvlWALp7TQEU5tgJSd8sC0XjvGysaJza/mVioqgQlx5tGJ1CcJ3KCooMPUM8c7Ww3cqAF4JuegNWWTtdZIGxZDPu8kCYHO/r7Clz5SH4+/dOy9N4DqUcD9gfaHvcHlgyWdfqfADDsjgJnErd9P9sMb1D03NUOyfsDOG9rIcJDcGg02sc+RO+W4ZuTgUjc9t7zyPEQFrb/0hVsImwk5FPsmjrmJfKxbQs13pLxXZgBQjEpuwpEYLrZXI+fTZU0yj/qHMLNdoQ+mfgpfnTeSdaan2TX8k8AOvaSrPNPvNqe65TG6JL5T1ZZ1WC7OgoMbXz+p7Rz0HoKXBnxCnyw2YNdx1LVy41/hggUuH1q8c9ykZIL1Saoj/vVpvfP9NhcNqkusmhWSesMjTvp/e/7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(8676002)(41300700001)(316002)(8936002)(4326008)(2906002)(5660300002)(7416002)(54906003)(110136005)(44832011)(70206006)(70586007)(36860700001)(40460700003)(6666004)(82740400003)(478600001)(7696005)(356005)(40480700001)(81166007)(1076003)(26005)(426003)(336012)(36756003)(83380400001)(186003)(16526019)(47076005)(2616005)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:58:23.7303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee303c8-10bd-43a0-d1d9-08db6bfd1bae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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

Kernels older than v5.19 do not support PerfMonV2 and the PMI handler
does not clear the overflow bits of the PerfCntrGlobalStatus register.
Because of this, loading a recent kernel using kexec from an older
kernel can result in inconsistent register states on Zen 4 systems.

The PMI handler of the new kernel gets confused and shows a warning when
an overflow occurs because some of the overflow bits are set even if the
corresponding counters are inactive. These are remnants from overflows
that were handled by the older kernel.

During CPU hotplug, the PerfCntrGlobalCtl and PerfCntrGlobalStatus
registers should always be cleared for PerfMonV2-capable processors.
However, a condition used for NB event constaints applicable only to
older processors currently prevents this from happening. Move the reset
sequence to an appropriate place and also clear the LBR Freeze bit.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f23425..ed626bfa1eed 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -534,8 +534,12 @@ static void amd_pmu_cpu_reset(int cpu)
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
-	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+	/*
+	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
+	 * and PerfCntrGLobalStatus.PerfCntrOvfl
+	 */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
 static int amd_pmu_cpu_prepare(int cpu)
@@ -570,6 +574,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	int i, nb_id;
 
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -591,8 +596,6 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -601,6 +604,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -613,8 +617,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static inline void amd_pmu_set_global_ctl(u64 ctl)
-- 
2.34.1

