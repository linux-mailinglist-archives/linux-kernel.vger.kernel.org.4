Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80A6D1674
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCaEyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaEyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:54:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618551AC;
        Thu, 30 Mar 2023 21:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1KRmlXa6TC/jWJ5CIcanGrkJa9g4t4+xEDWdqtv0hdpFWfPUGdVaoka4UmOLNKYU/9nSyUFnKVBX0JHn5AbYCU7uOsABOcOvdY+S2R0QoQfr5AY4+/a+7CnjrtjqJ4LOTzhpJ3oqckTKZJvoioK0uWS9Mmpt0ZH96b7VFxHrpLxzFZS7cv9IxJ1SSrykI8P0uIzCUxXuY9gxrSk06kxlng0+eKvUTgP4bADJt0ms2RDtId7wx/7H1+dt2Ks/D9UhIkduIub+J2RBaP+v6bITnHEtbVnD3DYvnSmDPQRZ3+LPpMVtsLrFLPujBsxslCCRSn2A8CUFWXqGK9a2eP+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn9uk7OSyQsqRUotfDS8HI/kSGsK73QiViKkdI0eddQ=;
 b=F4se5aYNhJCcn6epgcy2Ppxibr+tF/8odnQh3mrME/ZHVoZfmqLs05CNnIxcxmDV0iALFLZOhTJu/gaCFJEyQ5x/TSgFXL0MGr+hOJPGcVtoTCKbvyl0SRlr5D6l9n3lwgNpbq9VM7P7KffR7aPhl+diHvCcTfw3+GR0T/BYXREewBbv8q8WX/RJukebKDr0VUZs0opPTe+AZkS2nOhVsTPTKcMY66I4Z8I6CQXaU2wAc/mA8XMQqwCRyU1bkWFKBiJYN+NqPzbYzjEMbZsZrsdhs/yQVbzEg+klfJxXcP5BPtSwEQqkK+vyWklSv2sf92Tb+bd1w2pMBPC57aoeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn9uk7OSyQsqRUotfDS8HI/kSGsK73QiViKkdI0eddQ=;
 b=tK4pr6eh8UrTccS18UPnbUlXoNtZCVWJtMms1F+mWKnkbO4x8LXZ3EFyc9T124sduuqRsHLpUINbejbMQm1aBFDppyHJTDgHjcqeQ2bO9Be9RSouy0N10c/f8ifZcLVmplJb9H3lHq6/pZSzrskb5yDTMsDZuk+vm7SQHMf8T5U=
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 31 Mar
 2023 04:54:06 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::c4) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 04:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 04:54:06 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 23:54:00 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>
Subject: [RFC PATCH 4/4] perf: Add option for --per-cache aggregation
Date:   Fri, 31 Mar 2023 10:21:17 +0530
Message-ID: <20230331045117.1266-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331045117.1266-1-kprateek.nayak@amd.com>
References: <20230331045117.1266-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 01100e99-ce33-405e-da0f-08db31a3f4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 800K66uYpz91RbInwuCCduxRAEkMuEadcbKcSJTc+EfswbF1uUYZqsx2qSd1WtzQ/6U2Vael83f2DPW+9yvCgW/Gj6fN+mZML+3F+qD0LDz5agzBDz3tyvm1fQdxbuWK17xtGSaZI8JgKeggYRY9CIQYD1iYJPIi7E2lR+eKYN7MTv0B/Z+y/hPlItmiCiaa88ZCGFQqVXICgC6k8e7KdWGWxdx3k3q7yk4HQ8c9UIetZifXKjgnLtkf16aFP6zAeWczgpcB0VPBlL0R7lkxJA7n+IFlqeg/e9sV7Z5FSmm19EvgKsUHk2B3FeRucyBqWcHO0hnWkSVJEOZcPxC46kpgtz2CXG7WrOyv3wlC6DUIYanbVWeAW8FThDhkL8gPE5QPdoA2woklAXMz8jFEGVWQWqh75FIEQfm5ws9LC72A9HP61Nygf6mtq3+ElYjtEa/vZ1M9j7DSfpE5r/2Eo7prLj7fH3iOPi62x93nN2AfRPVtH6qgi2sg1iF8JDDhZGXo7ELfliQH+NbFyV37OfXe6jxoGbSbd+bp46MmRgzyaGPNAuOILK8j6406opdgxs/3tTcBTCkjhcnFTaCb2vLVk6SBWt2jVP/D5xjzJSqyP8FSIMfjVfCmmulY7ty/dojfDMvdxTSuMSupdfqx+dzQYJBZYNO5LmUcvcNo2WXpvGdyZ1LWGKq+2OE7DVdMs0Mmfc0AIDLQxE2/Dz/LgO1owoOR4KQv1KGRg/cPOSXhAbd20GbMafIReOvyasj3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(316002)(186003)(2906002)(70206006)(81166007)(8936002)(6666004)(4326008)(30864003)(26005)(40460700003)(82740400003)(7696005)(1076003)(16526019)(8676002)(70586007)(478600001)(82310400005)(40480700001)(5660300002)(2616005)(86362001)(336012)(41300700001)(36860700001)(54906003)(356005)(7416002)(36756003)(47076005)(426003)(110136005)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:54:06.0808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01100e99-ce33-405e-da0f-08db31a3f4f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Processors based on chiplet architecture, such as AMD EPYC and Hygon do
not expose the chiplet details in the sysfs CPU topology information.
However, this information can be derived from the per CPU cache level
information from the sysfs.

perf stat has already supported aggregation based on topology
information using core ID, socket ID, etc. It'll be useful to aggregate
based on the cache topology to detect problems like imbalance and
cache-to-cache sharing at various cache levels.

This patch adds support for "--per-cache" option for aggregation at a
particular cache level. Also update the docs and related test. The
output will be like:

  $ sudo ./perf stat --per-cache=L3 -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- sleep 5

   Performance counter stats for 'system wide':

  S0-D0-L3-ID0             16              7,022      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID1             16                994      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID2             16                297      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID3             16              2,852      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID4             16              7,764      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID5             16              1,779      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID6             16              2,747      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID7             16              6,665      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID8             16                799      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID9             16                846      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID10            16              3,048      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID11            16              1,015      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID12            16                432      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID13            16                837      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID14            16                348      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID15            16              1,175      ls_dmnd_fills_from_sys.ext_cache_remote

Also support perf stat record and perf stat report with the ability to
specify a different cache level to aggregate data at when running perf
stat report.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 tools/lib/perf/include/perf/cpumap.h          |   5 +
 tools/lib/perf/include/perf/event.h           |   3 +-
 tools/perf/Documentation/perf-stat.txt        |  16 ++
 tools/perf/builtin-stat.c                     | 153 +++++++++++++++++-
 .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  14 ++
 tools/perf/tests/shell/stat+json_output.sh    |  13 ++
 tools/perf/util/cpumap.c                      |  97 +++++++++++
 tools/perf/util/cpumap.h                      |  17 ++
 tools/perf/util/event.c                       |   7 +-
 tools/perf/util/stat-display.c                |  17 ++
 tools/perf/util/stat-shadow.c                 |   1 +
 tools/perf/util/stat.h                        |   2 +
 tools/perf/util/synthetic-events.c            |   1 +
 14 files changed, 343 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 3f43f770cdac..8724dde79342 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -11,6 +11,11 @@ struct perf_cpu {
 	int cpu;
 };
 
+struct perf_cache {
+	int cache_lvl;
+	int cache;
+};
+
 struct perf_cpu_map;
 
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ad47d7b31046..f3ceb2f96593 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -378,7 +378,8 @@ enum {
 	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
 	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
 	PERF_STAT_CONFIG_TERM__SCALE		= 2,
-	PERF_STAT_CONFIG_TERM__MAX		= 3,
+	PERF_STAT_CONFIG_TERM__AGGR_LEVEL	= 3,
+	PERF_STAT_CONFIG_TERM__MAX		= 4,
 };
 
 struct perf_record_stat_config_entry {
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 18abdc1dce05..ad7894f5c02b 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -308,6 +308,14 @@ use --per-die in addition to -a. (system-wide).  The output includes the
 die number and the number of online processors on that die. This is
 useful to gauge the amount of aggregation.
 
+--per-cache::
+Aggregate counts per cache instance for system-wide mode measurements.  By
+default, the aggregation happens for the cache level at the highest index
+in the system. To specify a particular level, mention the cache level
+alongside the option in the format [Ll][1-9][0-9]*. For example:
+"--per-cache=l3", "--per-cache=L3", and "--per-cache=3" will aggregate
+the information at the boundary of the level 3 cache in the system.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.  This
 is a useful mode to detect imbalance between physical cores.  To enable this mode,
@@ -379,6 +387,14 @@ Aggregate counts per processor socket for system-wide mode measurements.
 --per-die::
 Aggregate counts per processor die for system-wide mode measurements.
 
+--per-cache::
+Aggregate counts per cache instance for system-wide mode measurements.  By
+default, the aggregation happens for the cache level at the highest index
+in the system. To specify a particular level, mention the cache level
+alongside the option in the format [Ll][1-9][0-9]*. For example:
+"--per-cache=l3", "--per-cache=L3", and "--per-cache=3" will aggregate
+the information at the boundary of the level 3 cache in the system.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fa7c40956d0f..884f92319f9f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -203,6 +203,7 @@ struct perf_stat {
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
 	enum aggr_mode		 aggr_mode;
+	u32			 aggr_level;
 };
 
 static struct perf_stat		perf_stat;
@@ -210,8 +211,9 @@ static struct perf_stat		perf_stat;
 
 static volatile sig_atomic_t done = 0;
 
-static struct perf_stat_config stat_config = {
+struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
+	.aggr_level		= MAX_CACHE_LVL + 1,
 	.scale			= true,
 	.unit_width		= 4, /* strlen("unit") */
 	.run_count		= 1,
@@ -1160,6 +1162,52 @@ static int parse_hybrid_type(const struct option *opt,
 	return 0;
 }
 
+static int parse_cache_level(const struct option *opt, const char *str,
+		 int unset __maybe_unused)
+{
+	int level;
+	u32 *aggr_mode = (u32 *)opt->value;
+	u32 *aggr_level = (u32 *)opt->data;
+
+	if (str == NULL) {
+		level = MAX_CACHE_LVL + 1;
+		goto out;
+	}
+
+	if (!strlen(str) || (str[0] != 'l' && str[0] != 'L')) {
+		pr_err("Cache level must be of form L[1-%d], or l[1-%d]\n",
+		       MAX_CACHE_LVL,
+		       MAX_CACHE_LVL);
+		return -EINVAL;
+	}
+
+	level = atoi(str);
+	if (level > 0)
+		goto out;
+
+	/*
+	 * Assume first character of string is 'L' or 'l'
+	 * if the conversion fails.
+	 */
+	level = atoi(&str[1]);
+	if (level < 1) {
+		pr_err("Cache level must be of form L[1-%d], or l[1-%d]\n",
+		       MAX_CACHE_LVL,
+		       MAX_CACHE_LVL);
+		return -EINVAL;
+	}
+
+	if (level > MAX_CACHE_LVL) {
+		pr_err("perf only supports max cache level of %d.\n"
+		       "Consider increasing MAX_CACHE_LVL\n", MAX_CACHE_LVL);
+		return -EINVAL;
+	}
+out:
+	*aggr_mode = AGGR_CACHE;
+	*aggr_level = level;
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1237,6 +1285,9 @@ static struct option stat_options[] = {
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat_config.aggr_level,
+			    "cache level", "aggregate count at this cache level (Default: LLC)",
+			    parse_cache_level),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
@@ -1298,6 +1349,7 @@ static struct option stat_options[] = {
 
 static const char *const aggr_mode__string[] = {
 	[AGGR_CORE] = "core",
+	[AGGR_CACHE] = "cache",
 	[AGGR_DIE] = "die",
 	[AGGR_GLOBAL] = "global",
 	[AGGR_NODE] = "node",
@@ -1319,6 +1371,12 @@ static struct aggr_cpu_id perf_stat__get_die(struct perf_stat_config *config __m
 	return aggr_cpu_id__die(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_cache_id(struct perf_stat_config *config __maybe_unused,
+						 struct perf_cpu cpu)
+{
+	return aggr_cpu_id__cache(cpu, /*data=*/NULL);
+}
+
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 					      struct perf_cpu cpu)
 {
@@ -1371,6 +1429,12 @@ static struct aggr_cpu_id perf_stat__get_die_cached(struct perf_stat_config *con
 	return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_cache_id_cached(struct perf_stat_config *config,
+							struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_cache_id, cpu);
+}
+
 static struct aggr_cpu_id perf_stat__get_core_cached(struct perf_stat_config *config,
 						     struct perf_cpu cpu)
 {
@@ -1402,6 +1466,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 		return aggr_cpu_id__socket;
 	case AGGR_DIE:
 		return aggr_cpu_id__die;
+	case AGGR_CACHE:
+		return aggr_cpu_id__cache;
 	case AGGR_CORE:
 		return aggr_cpu_id__core;
 	case AGGR_NODE:
@@ -1425,6 +1491,8 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_cached;
 	case AGGR_DIE:
 		return perf_stat__get_die_cached;
+	case AGGR_CACHE:
+		return perf_stat__get_cache_id_cached;
 	case AGGR_CORE:
 		return perf_stat__get_core_cached;
 	case AGGR_NODE:
@@ -1537,6 +1605,72 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(struct perf_cpu cpu, voi
 	return id;
 }
 
+static int perf_env__get_cache_id_for_cpu(struct perf_cpu cpu, struct perf_env *env,
+					  u32 cache_level, struct perf_cache *cache)
+{
+	int i;
+	int caches_cnt = env->caches_cnt;
+	struct cpu_cache_level *caches = env->caches;
+
+	if (!caches_cnt)
+		return -1;
+
+	for (i = caches_cnt - 1; i > -1; --i) {
+		struct perf_cpu_map *cpu_map;
+		int map_contains_cpu;
+
+		/*
+		 * If user has not specified a level, find the fist level with
+		 * the cpu in the map. Since building the map is expensive, do
+		 * this only if levels match.
+		 */
+		if (cache_level <= MAX_CACHE_LVL && caches[i].level != cache_level)
+			continue;
+
+		cpu_map = perf_cpu_map__new(caches[i].map);
+		map_contains_cpu = perf_cpu_map__idx(cpu_map, cpu);
+		perf_cpu_map__put(cpu_map);
+
+		if (map_contains_cpu != -1) {
+			cache->cache = caches[i].id;
+			cache->cache_lvl = caches[i].level;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static struct aggr_cpu_id perf_env__get_cache_aggr_by_cpu(struct perf_cpu cpu,
+							  void *data)
+{
+	struct perf_env *env = data;
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	if (cpu.cpu != -1) {
+		int ret;
+		u32 cache_level;
+		struct perf_cache cache = {
+			.cache		= -1,
+			.cache_lvl	= -1,
+		};
+
+		cache_level = (perf_stat.aggr_level) ?: stat_config.aggr_level;
+
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
+
+		ret = perf_env__get_cache_id_for_cpu(cpu, env, cache_level, &cache);
+		if (ret)
+			return id;
+
+		id.cache_lvl = cache.cache_lvl;
+		id.cache = cache.cache;
+	}
+
+	return id;
+}
+
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1605,6 +1739,12 @@ static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *confi
 	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_cache_file(struct perf_stat_config *config __maybe_unused,
+						      struct perf_cpu cpu)
+{
+	return perf_env__get_cache_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
 						   struct perf_cpu cpu)
 {
@@ -1636,6 +1776,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 		return perf_env__get_socket_aggr_by_cpu;
 	case AGGR_DIE:
 		return perf_env__get_die_aggr_by_cpu;
+	case AGGR_CACHE:
+		return perf_env__get_cache_aggr_by_cpu;
 	case AGGR_CORE:
 		return perf_env__get_core_aggr_by_cpu;
 	case AGGR_NODE:
@@ -1659,6 +1801,8 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_file;
 	case AGGR_DIE:
 		return perf_stat__get_die_file;
+	case AGGR_CACHE:
+		return perf_stat__get_cache_file;
 	case AGGR_CORE:
 		return perf_stat__get_core_file;
 	case AGGR_NODE:
@@ -2207,7 +2351,8 @@ static struct perf_stat perf_stat = {
 		.stat		= perf_event__process_stat_event,
 		.stat_round	= process_stat_round_event,
 	},
-	.aggr_mode = AGGR_UNSET,
+	.aggr_mode	= AGGR_UNSET,
+	.aggr_level	= 0,
 };
 
 static int __cmd_report(int argc, const char **argv)
@@ -2219,6 +2364,10 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_stat.aggr_level,
+			    "cache level",
+			    "aggregate count at this cache level (Default: LLC)",
+			    parse_cache_level),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 97598d14e532..62489766b93c 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -14,6 +14,7 @@ ap.add_argument('--system-wide', action='store_true')
 ap.add_argument('--event', action='store_true')
 ap.add_argument('--per-core', action='store_true')
 ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-cache', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
@@ -46,6 +47,7 @@ def check_json_output(expected_items):
       'counter-value': lambda x: is_counter_value(x),
       'cgroup': lambda x: True,
       'cpu': lambda x: isint(x),
+      'cache': lambda x: True,
       'die': lambda x: True,
       'event': lambda x: True,
       'event-runtime': lambda x: isfloat(x),
@@ -82,7 +84,7 @@ try:
     expected_items = 7
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 8
-  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
     expected_items = 9
   else:
     # If no option is specified, don't check the number of items.
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 324fc9e6edd7..6cdf2fd386d5 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -26,6 +26,7 @@ function commachecker()
 	;; "--per-socket")	exp=8
 	;; "--per-node")	exp=8
 	;; "--per-die")		exp=8
+	;; "--per-cache")	exp=8
 	esac
 
 	while read line
@@ -123,6 +124,18 @@ check_per_thread()
 	echo "[Success]"
 }
 
+check_per_cache_instance()
+{
+	echo -n "Checking CSV output: per cache instance "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -x$csv_sep --per-cache -a true 2>&1 | commachecker --per-cache
+	echo "[Success]"
+}
+
 check_per_die()
 {
 	echo -n "Checking CSV output: per die "
@@ -197,6 +210,7 @@ if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr
 	check_per_core
+	check_per_cache_instance
 	check_per_die
 	check_per_socket
 else
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 2c4212c641ed..d79a6e0d4042 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -100,6 +100,18 @@ check_per_thread()
 	echo "[Success]"
 }
 
+check_per_cache_instance()
+{
+	echo -n "Checking json output: per cache_instance "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-cache -a true 2>&1 | $PYTHON $pythonchecker --per-cache
+	echo "[Success]"
+}
+
 check_per_die()
 {
 	echo -n "Checking json output: per die "
@@ -174,6 +186,7 @@ if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr
 	check_per_core
+	check_per_cache_instance
 	check_per_die
 	check_per_socket
 else
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5e564974fba4..5d62f21c6adc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -3,6 +3,8 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
+#include "header.h"
+#include "stat.h"
 #include <assert.h>
 #include <dirent.h>
 #include <stdio.h>
@@ -227,6 +229,10 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
 		return a->socket - b->socket;
 	else if (a->die != b->die)
 		return a->die - b->die;
+	else if (a->cache_lvl != b->cache_lvl)
+		return a->cache_lvl - b->cache_lvl;
+	else if (a->cache != b->cache)
+		return a->cache - b->cache;
 	else if (a->core != b->core)
 		return a->core - b->core;
 	else
@@ -310,6 +316,91 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 	return id;
 }
 
+extern struct perf_stat_config stat_config;
+
+int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache)
+{
+	int ret = 0;
+	struct cpu_cache_level caches[MAX_CACHE_LVL];
+	u32 cache_level = stat_config.aggr_level;
+	u32 i = 0, caches_cnt = 0;
+
+	cache->cache_lvl = -1;
+	cache->cache = -1;
+
+	ret = build_caches_for_cpu(cpu.cpu, caches, &caches_cnt);
+	if (ret) {
+		/*
+		 * If caches_cnt is not 0, cpu_cache_level data
+		 * was allocated when building the topology.
+		 * Free the allocated data before returning.
+		 */
+		if (caches_cnt)
+			goto free_caches;
+
+		return ret;
+	}
+
+	if (!caches_cnt)
+		return -1;
+
+	/*
+	 * Save the data for the highest level if no
+	 * level was specified by the user.
+	 */
+	if (cache_level > MAX_CACHE_LVL) {
+		int max_level_index = 0;
+
+		for (i = 1; i < caches_cnt; ++i) {
+			if (caches[i].level > caches[max_level_index].level)
+				max_level_index = i;
+		}
+
+		cache->cache_lvl = caches[max_level_index].level;
+		cache->cache = caches[max_level_index].id;
+
+		i = 0; // Reset i to 0 to free entire caches[]
+		goto free_caches;
+	}
+
+	for (i = 0; i < caches_cnt; ++i) {
+		if (caches[i].level == cache_level) {
+			cache->cache_lvl = cache_level;
+			cache->cache = caches[i].id;
+		}
+
+		cpu_cache_level__free(&caches[i]);
+	}
+
+free_caches:
+	/*
+	 * Free all the allocated cpu_cache_level data.
+	 */
+	while (i < caches_cnt)
+		cpu_cache_level__free(&caches[i++]);
+
+	return ret;
+}
+
+struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
+{
+	int ret;
+	struct aggr_cpu_id id;
+	struct perf_cache cache;
+
+	id = aggr_cpu_id__die(cpu, data);
+	if (aggr_cpu_id__is_empty(&id))
+		return id;
+
+	ret = cpu__get_cache_details(cpu, &cache);
+	if (ret)
+		return id;
+
+	id.cache_lvl = cache.cache_lvl;
+	id.cache = cache.cache;
+	return id;
+}
+
 int cpu__get_core_id(struct perf_cpu cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu.cpu, "core_id", &value);
@@ -684,6 +775,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
+		a->cache_lvl == b->cache_lvl &&
+		a->cache == b->cache &&
 		a->core == b->core &&
 		a->cpu.cpu == b->cpu.cpu;
 }
@@ -694,6 +787,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
+		a->cache_lvl == -1 &&
+		a->cache == -1 &&
 		a->core == -1 &&
 		a->cpu.cpu == -1;
 }
@@ -705,6 +800,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.node = -1,
 		.socket = -1,
 		.die = -1,
+		.cache_lvl = -1,
+		.cache = -1,
 		.core = -1,
 		.cpu = (struct perf_cpu){ .cpu = -1 },
 	};
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2f5824a3a22..d319c260ea09 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -20,6 +20,10 @@ struct aggr_cpu_id {
 	int socket;
 	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The cache level as read from /sys/devices/system/cpu/cpuX/cache/indexY/level */
+	int cache_lvl;
+	/** The cache instance ID as read from /sys/devices/system/cpu/cpuX/cache/indexY/id */
+	int cache;
 	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 	/** CPU aggregation, note there is one CPU for each SMT thread. */
@@ -76,6 +80,12 @@ int cpu__get_socket_id(struct perf_cpu cpu);
  * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
  */
 int cpu__get_die_id(struct perf_cpu cpu);
+/**
+ * cpu__get_cache_id - Returns 0 if successful in populating the
+ * cache level and cache id as read from
+ * /sys/devices/system/cpu/cpuX/cache/indexY/{id, level} for the given CPU.
+ */
+int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache);
 /**
  * cpu__get_core_id - Returns the core id as read from
  * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
@@ -116,6 +126,13 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
  * aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
+/**
+ * aggr_cpu_id__cache - Create an aggr_cpu_id with cache instache ID, cache
+ * level, die and socket populated with the cache instache ID, cache level,
+ * die and socket for cpu. The function signature is compatible with
+ * aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data);
 /**
  * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
  * populated with the core, die and socket for cpu. The function signature is
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1fa14598b916..faf0df3c5b95 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -135,9 +135,10 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 			config->__val = event->data[i].val;	\
 			break;
 
-		CASE(AGGR_MODE, aggr_mode)
-		CASE(SCALE,     scale)
-		CASE(INTERVAL,  interval)
+		CASE(AGGR_MODE,  aggr_mode)
+		CASE(SCALE,      scale)
+		CASE(INTERVAL,   interval)
+		CASE(AGGR_LEVEL, aggr_level)
 #undef CASE
 		default:
 			pr_warning("unknown stat config term %" PRI_lu64 "\n",
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1b5cb20efd23..82ec668bc3ba 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -36,6 +36,7 @@
 
 static int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
+	[AGGR_CACHE]	= 22,
 	[AGGR_DIE] 	= 12,
 	[AGGR_SOCKET] 	= 6,
 	[AGGR_NODE] 	= 6,
@@ -46,6 +47,7 @@ static int aggr_header_lens[] = {
 
 static const char *aggr_header_csv[] = {
 	[AGGR_CORE] 	= 	"core,cpus,",
+	[AGGR_CACHE]	= 	"cache,cpus,",
 	[AGGR_DIE] 	= 	"die,cpus,",
 	[AGGR_SOCKET] 	= 	"socket,cpus,",
 	[AGGR_NONE] 	= 	"cpu,",
@@ -56,6 +58,7 @@ static const char *aggr_header_csv[] = {
 
 static const char *aggr_header_std[] = {
 	[AGGR_CORE] 	= 	"core",
+	[AGGR_CACHE] 	= 	"cache",
 	[AGGR_DIE] 	= 	"die",
 	[AGGR_SOCKET] 	= 	"socket",
 	[AGGR_NONE] 	= 	"cpu",
@@ -193,6 +196,10 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 	case AGGR_CORE:
 		snprintf(buf, sizeof(buf), "S%d-D%d-C%d", id.socket, id.die, id.core);
 		break;
+	case AGGR_CACHE:
+		snprintf(buf, sizeof(buf), "S%d-D%d-L%d-ID%d",
+			 id.socket, id.die, id.cache_lvl, id.cache);
+		break;
 	case AGGR_DIE:
 		snprintf(buf, sizeof(buf), "S%d-D%d", id.socket, id.die);
 		break;
@@ -239,6 +246,10 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
 		fprintf(output, "S%d-D%d-C%d%s%d%s",
 			id.socket, id.die, id.core, sep, nr, sep);
 		break;
+	case AGGR_CACHE:
+		fprintf(config->output, "S%d-D%d-L%d-ID%d%s%d%s",
+			id.socket, id.die, id.cache_lvl, id.cache, sep, nr, sep);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "S%d-D%d%s%d%s",
 			id.socket, id.die, sep, nr, sep);
@@ -284,6 +295,10 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, id.core, nr);
 		break;
+	case AGGR_CACHE:
+		fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d, ",
+			id.socket, id.die, id.cache_lvl, id.cache, nr);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, nr);
@@ -1126,6 +1141,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_NODE:
 	case AGGR_SOCKET:
 	case AGGR_DIE:
+	case AGGR_CACHE:
 	case AGGR_CORE:
 		fprintf(output, "#%*s %-*s cpus",
 			INTERVAL_LEN - 1, "time",
@@ -1422,6 +1438,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
+	case AGGR_CACHE:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NODE:
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 806b32156459..f080905a3ece 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -20,6 +20,7 @@
  * AGGR_GLOBAL: Use CPU 0
  * AGGR_SOCKET: Use first CPU of socket
  * AGGR_DIE: Use first CPU of die
+ * AGGR_CACHE: Use first CPU of cache level instance
  * AGGR_CORE: Use first CPU of core
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index bf1794ebc916..848b3b3f5819 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -74,6 +74,7 @@ enum aggr_mode {
 	AGGR_GLOBAL,
 	AGGR_SOCKET,
 	AGGR_DIE,
+	AGGR_CACHE,
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
@@ -139,6 +140,7 @@ typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, str
 
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
+	u32			 aggr_level;
 	bool			 scale;
 	bool			 no_inherit;
 	bool			 identifier;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9ab9308ee80c..2fe648be1e7d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1373,6 +1373,7 @@ int perf_event__synthesize_stat_config(struct perf_tool *tool,
 	ADD(AGGR_MODE,	config->aggr_mode)
 	ADD(INTERVAL,	config->interval)
 	ADD(SCALE,	config->scale)
+	ADD(AGGR_LEVEL,	config->aggr_level)
 
 	WARN_ONCE(i != PERF_STAT_CONFIG_TERM__MAX,
 		  "stat config terms unbalanced\n");
-- 
2.34.1

