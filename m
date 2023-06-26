Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8173DC62
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFZKkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFZKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:40:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D1410CF;
        Mon, 26 Jun 2023 03:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsDIkFZMn8Bly+7cKAdaRlYdcsWFHkGhg74AsSZoe3edsoxgnKifmZ9Z/Pu1zEd206YdLwImLvbcgGAuLAzbnuHMOJvDAwmVyDRl9JfSJBQzjRvM0atDY8gwHfzlgLZcH3mHLj6jW1qJaYn3g7FzjhYGdOlteghTMQMedK90q6/TFv/pUUN0Ir5bYMHaYcKYh/jSLGoOBo98ZxqokdCEby6WmwcHY2sTR8eGV8hwcZN6ZxbPKecAZRhEOFsAg5M29Zw2che60CcRx8i0em/HoEjvEyVCj8NsEontZpAgwzMNspZiub1XUJCjenvG94t8czOzkIgxWx80ksLwTTC91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1Y6oY2HOrJU2bbYdgYjV1Eu4N6rPgKgU84fT1+IstM=;
 b=Yh4eVb8AkA8hQfAXzRAD/axYzaWtmMCVjm17GcBCgFdlRxW6AhKXTr8jqA/JdJlDVxef1o5m645bs3Qw7Y/lQJ4Cy3tkBTGlsqqYkgc3aNHbNiLVrWDSrQNspU0Davnnyzlp04GkUOa17WtlmuWBfWs/rbnRqCvhGFYIa0qtJgAhDINam0banbRg6A+37AuUlcXzvAsQnbCnu7Rr6TvbEstUB/TIJrAsa7JOtRaFWYQVfCPksTwfAnmBrMBc7fKehE4e1OTIlZGtmtWjx03vGd7X/SAbl9/AnffLlBPh2NRCNMqPUAaNHNbN66qprPLT5l1we9eqEnnxNIA6Jgf11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1Y6oY2HOrJU2bbYdgYjV1Eu4N6rPgKgU84fT1+IstM=;
 b=pZ9YBc9HGohdSVj9gQPGWoE3aaIY4kj5xc/8o42d6Dq1DfkXPPYMw7hKndERBwtoFmG2loioUpBHyGfCZFmQXOFQxxMbNKM1xpZptrLXiomsOTDKV+jiZJNIdU4A+rJ2MggchQoE+BQYw+2GPoNv2NfoVgxG1rMEyjiRXK0EFa4=
Received: from BN0PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:e8::12)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:40:20 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::f6) by BN0PR04CA0037.outlook.office365.com
 (2603:10b6:408:e8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 10:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 10:40:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 05:40:15 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <irogers@google.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2] perf evsel amd: Fix IBS error message
Date:   Mon, 26 Jun 2023 16:09:58 +0530
Message-ID: <20230626103958.834-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: af7c9180-1521-4699-4939-08db7631bd23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fegEUPS8a+N88ghIoG5ygMX2OlX1bWtmRQwUdpRlehgRY3t84UAs4SBcduGQc3D1Q7ldNLhWGr1HwoP/mVpmy35Jjvi3/RoC3P0VoM2H561zNssJ2elTZO4f4w1VdfT4W+ykvc5APM1qfPtPPgDrLLTz5uJbuPRYApGGH8/zZQYwroW9BSwYCCuRm52rGCfvG+QoiVrCDkM1cnp16sR0JYaxHqrC16RHmvBictGEk7Uja6s22R+b4Zu9DtHU87d9OARESwEQOYlpdlYlxJef19B1JnqqJlWjzCBlVBju4UEqbVSKNL64whlifRAAiICir7w432bwZ9dxjaA+ARZqQwwq981HmcjayqZuqzzL2YywqLim1YmSR5YzdCzdlrIOeHdT1Zlniv8iJybfEiyAmgFL2l1lh+1nqK+zJxzNThYc9vX7/r0Ky7EVCgL7yXmQS8oDDJStMV+7PGJJkYUHdtiBdqz8flD9y2AwzvOiykosHHhDwUh9fpLE/60J8ekPBFNZZBay7AQLGz/eow+MbFom4kih1FFBwZ9o2W65aXfxO/Zyb6bHhBf5itA/c29xYH1/t5rDKjpEWT1HusEx92YcARdhOTcrZIs13X+TIz+64adaq3xlgHLh2TGTnumTJmZF+H47aucmp1hei7DGkayvy1RlsHP8CE4/1417Iwk7IL4fAxLhVafz6iFUld76r24aWFx1NwaQquRUbreKfnIVFC1a4UUlbf24+sV+Z8Dr828K+y4oABmfV5thpiv1eeWQU9pVy6rVlAx8CQ3KRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(8676002)(70206006)(8936002)(70586007)(41300700001)(316002)(6916009)(4326008)(1076003)(26005)(16526019)(186003)(336012)(426003)(2616005)(478600001)(54906003)(6666004)(40460700003)(966005)(7696005)(82310400005)(15650500001)(2906002)(5660300002)(40480700001)(44832011)(82740400003)(81166007)(356005)(36756003)(86362001)(36860700001)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:40:20.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c9180-1521-4699-4939-08db7631bd23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IBS can do per-process profiling[1] and is no longer restricted to
per-cpu or systemwide only. Remove stale error message. Also, checking
just exclude_kernel is not sufficient since IBS does not support any
privilege filters. So include all exclude_* checks. And finally, move
these checks under tools/perf/arch/x86/ from generic code.

Before:
  $ sudo ./perf record -e ibs_op//k -C 0
  Error:
  AMD IBS may only be available in system-wide/per-cpu mode.  Try
  using -a, or -C and workload affinity

After:
  $ sudo ./perf record -e ibs_op//k -C 0
  Error:
  AMD IBS doesn't support privilege filtering. Try again with
  exclude_{kernel|user|hv|idle|host|guest}=0.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1: https://lore.kernel.org/r/20230621062359.201-1-ravi.bangoria@amd.com
v1->v2:
  - Check all exclude_* flags not just exclude_kernel
  - Move AMD specific checks under tools/perf/arch/x86/

 tools/perf/arch/x86/util/evsel.c | 25 +++++++++++++++++++++++++
 tools/perf/util/evsel.c          | 30 +++++++++---------------------
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 512c2d885d24..9a7141c5a4ea 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -102,3 +102,28 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 		}
 	}
 }
+
+int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
+{
+	if (!x86__is_amd_cpu())
+		return 0;
+
+	if (!evsel->core.attr.precise_ip &&
+	    !(evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3)))
+		return 0;
+
+	/* More verbose IBS errors. */
+	if (evsel->core.attr.exclude_kernel || evsel->core.attr.exclude_user ||
+	    evsel->core.attr.exclude_hv || evsel->core.attr.exclude_idle ||
+	    evsel->core.attr.exclude_host || evsel->core.attr.exclude_guest) {
+		return scnprintf(msg, size, "AMD IBS doesn't support privilege filtering. Try "
+				 "again with exclude_{kernel|user|hv|idle|host|guest}=0.");
+	}
+
+	if (!evsel->core.attr.sample_period) {
+		return scnprintf(msg, size, "AMD IBS doesn't support counting mode. Try "
+				 "again with sample_{period|freq} with non-zero value.");
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f607b5bddc76..762e2b2634a5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2924,25 +2924,19 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
-static bool is_amd(const char *arch, const char *cpuid)
+int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
+				     char *msg __maybe_unused,
+				     size_t size __maybe_unused)
 {
-	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
-}
-
-static bool is_amd_ibs(struct evsel *evsel)
-{
-	return evsel->core.attr.precise_ip
-	    || (evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3));
+	return 0;
 }
 
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
-	struct perf_env *env = evsel__env(evsel);
-	const char *arch = perf_env__arch(env);
-	const char *cpuid = perf_env__cpuid(env);
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
+	int ret;
 
 	switch (err) {
 	case EPERM:
@@ -3044,16 +3038,6 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
 					evsel__name(evsel));
-		if (is_amd(arch, cpuid)) {
-			if (is_amd_ibs(evsel)) {
-				if (evsel->core.attr.exclude_kernel)
-					return scnprintf(msg, size,
-	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
-				if (!evsel->core.system_wide)
-					return scnprintf(msg, size,
-	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
-			}
-		}
 
 		break;
 	case ENODATA:
@@ -3063,6 +3047,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		break;
 	}
 
+	ret = arch_evsel__open_strerror(evsel, msg, size);
+	if (ret)
+		return ret;
+
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
 	"/bin/dmesg | grep -i perf may provide additional information.\n",
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9f06d6cd5379..848534ec74fa 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -311,6 +311,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
 void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
+int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-- 
2.41.0

