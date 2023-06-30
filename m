Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765687437C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjF3IxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjF3IxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:53:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BF3596;
        Fri, 30 Jun 2023 01:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDTksAn/QzgLE7yCGAM6HePJ2j+MSHB04gAdLtdhdbhjaW5FjLA0wANU2hpy/dw3CZqDQISTfuGN2mMcIewEQYT6LcZn2UA1xvLyvC9plY9MIxRrgirr8thpaLvrG8T8A5GSiEa/T4jU8rVrBZYKLSS+2PvkWh2HVhUswCoF3KXXvNVgCQxUbm9pESzcflclgO0Pai70N2Uxdh4YnmkAqWPBABTxX2qNtCbAeyKbu8TsVwShsyXWm4IzEfcOWvjDjcFfEEEVXsUY3523S2o1/i8CaGk+ulFDPRFrO6ySatXzxUSeB8Lbb17L7dZFwMZ8BE8QwKih9JabxJqYP0vUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWAn0NDBM78v/cFJ1AHQxi6rMNtfCkoxW+BsQTE+soQ=;
 b=goCI8viKUfs3GjrhBLysfq3Urk28ugu1q63TMn2tL/ID52O/ZiOPQh6HS1RwX4FjZUyf3WrJfwez5p16YJ/WH4JZO87OzEWPZ/dqT9oEI70YduCkm6tprz7I76Op4WxxlBNpKS9NOvzOwC7cYgbLW0H8OB0D7wOeQsimcbWoWezfzPgaB0UJOFKgT94HmXy5wuYsb2qM/nbvMibBljTBZXDZ6mBNJ5zzw2GETxWgov9knoBpegI8KEV/Vh6N74X5d6isyF/i14Tga5Nb7AjUAE39rO2qe1mcskaSAQK726GhEi/dUYcbOQJScG1k52SiqvJbXkwZMxJig+XpfVvtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWAn0NDBM78v/cFJ1AHQxi6rMNtfCkoxW+BsQTE+soQ=;
 b=xkpXpkhMmWPTPkWeXupw8w6KfEDo2SVItocGA81UQLslVKUTqR0l14929eXajytrYQUef98n2GRcmzrAqPVCd9XcAZuyyQ6G13rZVNRIT+f677XxWfkYjV4D4WQGmntRPt1RGc2H/Fia6noPowcc22qOS6oo4RT09VVl2USjKwg=
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 08:52:56 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::44) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 08:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 08:52:55 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 03:52:48 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <irogers@google.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3] perf evsel amd: Fix IBS error message
Date:   Fri, 30 Jun 2023 14:22:30 +0530
Message-ID: <20230630085230.437-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ec3f1a-a4ec-4c46-b912-08db79476559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXK+kHc9ClsO8tCFPhUHkLQ8ZlsdO+GPIrnmpd7x8AV76CjAWZsTiLsfxaBim/sV7RQomDqUmVRwob3A7ZtLGquMnV//3hIrLpNXusMrvLfYjSknTEkGQzdIZStPG6ewVjj91TiimjMYnsUG2QFQZrg2u0KIMxmQnwb1ZhbNGPKSBRDELzyJui+z71BRqbVZ2+6/qjNUZt6joNJaUKHEK/QCVom1KiBfPPEmmf0+zjLgrlCEdh3pgjTAu8i5i2Xvw6pXDDwgVqq9jbWEHgFPRdyB0WbKVaoJFBApc+3AN0d3Q3Enreqwnex2KiZcM5MwAAdJuryyZ8jZ9yeDG8+seW2iokPRrgYINufl1LqtjtB8SFk3OMonJ4eWW2NO7h36LuKn1FkoB7y95l22wRrGxfZ45AXXjBbCD0XFMGQ8ioqgeg6VCfXa86w5aOhmSFT78JIbuduvdY2Ggdofj72eJUgTDXTA9mfhYELZbITdHpzLCOTn7surIG+mqxcr7oJZAQPdwySsqRoRrBVY2eZklAzE8xNnnMfiS1Bmz2NTW2bK8Q4idhpTNy4CXS8bJKedFrkLgW0eQrgM1inW63heWmzEutfUEjMr6GOroI1cTOolYOs8cOBpIUK1nKAX1fdszuCDDFZXU/X1/+76WysOJ2VtJ2Nn8xgIUUCRbzMRngVVLZZTI5nziTSyY19o/KS9jJ19xGZmZ0JVm2IIV0gy8URcmuptzDaTGgxJhYWQUzX/IAvgfx2kLDibzj9G3qjLQhPOxq7h2yXM8QbNcFwA6cmC3Oc8rZISpJl5C1IgCy8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(44832011)(5660300002)(6916009)(70586007)(70206006)(316002)(36756003)(2906002)(4326008)(8676002)(15650500001)(8936002)(478600001)(40460700003)(36860700001)(966005)(40480700001)(41300700001)(86362001)(54906003)(82310400005)(7696005)(186003)(1076003)(47076005)(336012)(426003)(26005)(82740400003)(6666004)(16526019)(356005)(2616005)(81166007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 08:52:55.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ec3f1a-a4ec-4c46-b912-08db79476559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
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
  AMD IBS doesn't support privilege filtering. Try again without
  the privilege modifiers (like 'k') at the end.

[1] https://git.kernel.org/torvalds/c/30093056f7b2

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v2: https://lore.kernel.org/r/20230626103958.834-1-ravi.bangoria@amd.com
v2->v3:
  - Make error message more perf tool user friendly.

 tools/perf/arch/x86/util/evsel.c | 20 ++++++++++++++++++++
 tools/perf/util/evsel.c          | 30 +++++++++---------------------
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 512c2d885d24..af454fd07887 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -102,3 +102,23 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
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
+				 "again without the privilege modifiers (like 'k') at the end.");
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

