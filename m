Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDF706F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEQRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQRY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:24:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D6AD27;
        Wed, 17 May 2023 10:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3lXbJdiJnno1UeDCJ2YyvMr07S4K5JsH1tlRq/NzmW147KTdPRKjFL8ZjXZE0eKy+uGR0U+xYKBwlqP6LYfAkoLrpnl34mXSjCaeytau5nfls+fzG/bz3Reyde9dQkwQxcNU1nLnzqYTyZ+ctTwvXafDveeS1d5olARFHmG5IRGfuaPVyS7m8D3y0u+HzQtKuG3VqSrUvRWnFtoUh8dm5+ASTD9a401pjuNDeaB3WytYO89PMVreP3yIG/yz2pC8fMx4wfBrqSgWqOuQcK+Tgi4dbhaIBg/mDpYl+go5opKzCkXC8hvyQcdc5a3ruyz5Q/hOBP4ivnMsFw3u0A9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIRjZqidLmTLD+jtTCGUMrXvi45qBTRgAMNCKNBw5PI=;
 b=aChE74cCUXIJ9iDrW+HimQAXbPTf/RsrfFmFLLYBBiyuTOrwUM5hZZl2GCwcf1rSfkquz4P5XUMSrheJxIRFP2oXnX3Yxp1sdVdKd44MAKMooQkvOLacDODn0yZLNpykan9nR0sNyrcJM3xUtJcwfBl6xcyqURuEQ0FN1iFOnGp5qqxzpYQpfrJj13mboYzwJciqbryL8ipr/RV4cGJKz9+DIEzXuVJjBzYVbVel1kpayYFiIOmTK8YsjnGvf2PryNqNpU+TXWb5UTLgWNAaJE/WibMR+LeZP/234V5GREpr5lRc/280JEI4MFsIFLnaI+XGtMzkBdaqXIe4MXVNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIRjZqidLmTLD+jtTCGUMrXvi45qBTRgAMNCKNBw5PI=;
 b=aMw3FDWmLQDnKj7w6eNWmbjjSrK96J0dW/NJT6fPPkjDKe08PwY1DMyIssJ/tfUr+8qZlpTVAWGP5c64GFa7Q8bIVu1VGtFtFjQINlYcaqCaxWhdsCHD1ZKU0RCGiZbH6A0/PDj1ryIsi8QqXQl+efGMQj2ZpTuvFFbFqcCcQV0=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:24:21 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::42) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 17:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 17:24:21 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 12:24:14 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <irogers@google.com>, <puwen@hygon.cn>
Subject: [PATCH v4 2/5] perf stat: Setup the foundation to allow aggregation based on cache topology
Date:   Wed, 17 May 2023 22:57:42 +0530
Message-ID: <20230517172745.5833-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517172745.5833-1-kprateek.nayak@amd.com>
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: c18790eb-63c0-4316-5c3c-08db56fb8d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/+I9gaCsfTN2SubwQtCIcteL4pe4Uygs5fo5rdYwa+n6YAOsH98UKoHM6SOTge7Je960UdvAjqlo+1VlR65xXSUR1Q296g5j8UexqbKyKbEBQ9zdVEEUUs6E6ilWc7kOgGGErU7zAS/m9MoLFyD0J5JZfHHiFdfjKrAfq77bK3MDuhFcFGwjXLyrnxg0/pHtKqHz9w/HV83qzn2znKX8DzOfOhtB7NrrxQQtXpUdaNVF1/T0BAB1oQqvCzGbjg7nnox7eCHgH5qXWrdkasJQGnAhM8qPR0wx6bOb+6z0LN4od4mec0KHJXsK69l8d5kk4W7K6OqrivBWslIIFInntodQsg2HgvQFo4+HSDe9lNSg+SViVZAYCzk62+cm8F+S2jNXb5DlcmMbsNcuYE/pOUOFB1PPCK7NQYNRrSbYs7ndNvD2jSy/sNYdUMWBduHeDjqd01G1W6mFt5+nMOXHhP02NT1vlrYNkuSWNCMuinLTRK8BwWPxMB8h6bwir8+o9p/gsgeSvGvLRyBqJUF4n1/XflksuXTzvun8J3dKQ8nHTf8/HYZT69XZZGzLrad9x/G9/QRl5mDS/TtYAEUzFk8NGuSAb90n8EsT5G7Y2QjhivC1YY9e0g30K2CFgK4RxyiwsicytmzriXqivcThZI7upWMntcgyFhMhzdrvEMDo0eG9zpHXrq+gUCI0H31/MhVSTUvZTOAUnYPetsvQPFsDzefnr743UyuqQuQw5vv9iFXt8/U5k6SjswPGk5mJG/TDzGZ/rOcBTshtB7J/kTZG2qQq48qrr23039P3JA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(70586007)(478600001)(7696005)(36756003)(70206006)(6666004)(110136005)(86362001)(40460700003)(316002)(4326008)(82310400005)(47076005)(426003)(40480700001)(336012)(186003)(107886003)(36860700001)(2616005)(356005)(82740400003)(81166007)(1076003)(7416002)(5660300002)(2906002)(41300700001)(30864003)(8936002)(8676002)(16526019)(83380400001)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:24:21.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18790eb-63c0-4316-5c3c-08db56fb8d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
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

Processors based on chiplet architecture, such as AMD EPYC and Hygon do
not expose the chiplet details in the sysfs CPU topology information.
However, this information can be derived from the per CPU cache level
information from the sysfs.

perf stat has already supported aggregation based on topology
information using core ID, socket ID, etc. It'll be useful to aggregate
based on the cache topology to detect problems like imbalance and
cache-to-cache sharing at various cache levels.

This patch lays the foundation for aggregating data in perf stat based
on the processor's cache topology. The cmdline option to aggregate data
based on the cache topology is added in Patch 4 of the series while this
patch sets up all the necessary functions and variables required to
support the new aggregation option.

The patch also adds support to display per-cache aggregation, or save it
as a JSON or CSV, as splitting it into a separate patch would break
builds when compiling with "-Werror=switch-enum" where the compiler will
complain about the lack of handling for the AGGR_CACHE case in the
output functions.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:
o v3->v4:
  - Some parts of the previous Patch 2 have been put into subsequent
    smaller patches (while being careful not to introduce any build
    errors in case someone were to bisect through the series)
  - Fixed comments.
---
 tools/lib/perf/include/perf/cpumap.h |   5 ++
 tools/perf/builtin-stat.c            |  88 +++++++++++++++++++-
 tools/perf/util/cpumap.c             | 119 +++++++++++++++++++++++++++
 tools/perf/util/cpumap.h             |  28 +++++++
 tools/perf/util/stat-display.c       |  17 ++++
 tools/perf/util/stat.h               |   2 +
 6 files changed, 257 insertions(+), 2 deletions(-)

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
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b9ad32f21e57..7923940edef7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -138,6 +138,7 @@ struct perf_stat {
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
 	enum aggr_mode		 aggr_mode;
+	u32			 aggr_level;
 };
 
 static struct perf_stat		perf_stat;
@@ -145,8 +146,9 @@ static struct perf_stat		perf_stat;
 
 static volatile sig_atomic_t done = 0;
 
-static struct perf_stat_config stat_config = {
+struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
+	.aggr_level		= MAX_CACHE_LVL + 1,
 	.scale			= true,
 	.unit_width		= 4, /* strlen("unit") */
 	.run_count		= 1,
@@ -1245,6 +1247,7 @@ static struct option stat_options[] = {
 
 static const char *const aggr_mode__string[] = {
 	[AGGR_CORE] = "core",
+	[AGGR_CACHE] = "cache",
 	[AGGR_DIE] = "die",
 	[AGGR_GLOBAL] = "global",
 	[AGGR_NODE] = "node",
@@ -1266,6 +1269,12 @@ static struct aggr_cpu_id perf_stat__get_die(struct perf_stat_config *config __m
 	return aggr_cpu_id__die(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_cache_id(struct perf_stat_config *config __maybe_unused,
+						  struct perf_cpu cpu)
+{
+	return aggr_cpu_id__cache(cpu, /*data=*/NULL);
+}
+
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 					      struct perf_cpu cpu)
 {
@@ -1318,6 +1327,12 @@ static struct aggr_cpu_id perf_stat__get_die_cached(struct perf_stat_config *con
 	return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_cache_id_cached(struct perf_stat_config *config,
+							 struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_cache_id, cpu);
+}
+
 static struct aggr_cpu_id perf_stat__get_core_cached(struct perf_stat_config *config,
 						     struct perf_cpu cpu)
 {
@@ -1349,6 +1364,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 		return aggr_cpu_id__socket;
 	case AGGR_DIE:
 		return aggr_cpu_id__die;
+	case AGGR_CACHE:
+		return aggr_cpu_id__cache;
 	case AGGR_CORE:
 		return aggr_cpu_id__core;
 	case AGGR_NODE:
@@ -1372,6 +1389,8 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_cached;
 	case AGGR_DIE:
 		return perf_stat__get_die_cached;
+	case AGGR_CACHE:
+		return perf_stat__get_cache_id_cached;
 	case AGGR_CORE:
 		return perf_stat__get_core_cached;
 	case AGGR_NODE:
@@ -1484,6 +1503,60 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(struct perf_cpu cpu, voi
 	return id;
 }
 
+static void perf_env__get_cache_id_for_cpu(struct perf_cpu cpu, struct perf_env *env,
+					   u32 cache_level, struct aggr_cpu_id *id)
+{
+	int i;
+	int caches_cnt = env->caches_cnt;
+	struct cpu_cache_level *caches = env->caches;
+
+	id->cache_lvl = (cache_level > MAX_CACHE_LVL) ? 0 : cache_level;
+	id->cache = -1;
+
+	if (!caches_cnt)
+		return;
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
+			id->cache_lvl = caches[i].level;
+			id->cache = cpu__get_cache_id_from_map(cpu, caches[i].map);
+			return;
+		}
+	}
+}
+
+static struct aggr_cpu_id perf_env__get_cache_aggr_by_cpu(struct perf_cpu cpu,
+							  void *data)
+{
+	struct perf_env *env = data;
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	if (cpu.cpu != -1) {
+		u32 cache_level = (perf_stat.aggr_level) ?: stat_config.aggr_level;
+
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
+		perf_env__get_cache_id_for_cpu(cpu, env, cache_level, &id);
+	}
+
+	return id;
+}
+
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1552,6 +1625,12 @@ static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *confi
 	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_cache_file(struct perf_stat_config *config __maybe_unused,
+						    struct perf_cpu cpu)
+{
+	return perf_env__get_cache_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
 						   struct perf_cpu cpu)
 {
@@ -1583,6 +1662,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 		return perf_env__get_socket_aggr_by_cpu;
 	case AGGR_DIE:
 		return perf_env__get_die_aggr_by_cpu;
+	case AGGR_CACHE:
+		return perf_env__get_cache_aggr_by_cpu;
 	case AGGR_CORE:
 		return perf_env__get_core_aggr_by_cpu;
 	case AGGR_NODE:
@@ -1606,6 +1687,8 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_file;
 	case AGGR_DIE:
 		return perf_stat__get_die_file;
+	case AGGR_CACHE:
+		return perf_stat__get_cache_file;
 	case AGGR_CORE:
 		return perf_stat__get_core_file;
 	case AGGR_NODE:
@@ -2124,7 +2207,8 @@ static struct perf_stat perf_stat = {
 		.stat		= perf_event__process_stat_event,
 		.stat_round	= process_stat_round_event,
 	},
-	.aggr_mode = AGGR_UNSET,
+	.aggr_mode	= AGGR_UNSET,
+	.aggr_level	= 0,
 };
 
 static int __cmd_report(int argc, const char **argv)
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 75d9c73e0184..88d387200745 100644
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
@@ -222,6 +224,10 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
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
@@ -305,6 +311,113 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 	return id;
 }
 
+extern struct perf_stat_config stat_config;
+
+int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
+{
+	int id;
+	struct perf_cpu_map *cpu_map = perf_cpu_map__new(map);
+
+	/*
+	 * If the map contains no CPU, consider the current CPU to
+	 * be the first online CPU in the cache domain else use the
+	 * first online CPU of the cache domain as the ID.
+	 */
+	if (perf_cpu_map__empty(cpu_map))
+		id = cpu.cpu;
+	else
+		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
+
+	/* Free the perf_cpu_map used to find the cache ID */
+	perf_cpu_map__put(cpu_map);
+
+	return id;
+}
+
+int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache)
+{
+	int ret = 0;
+	struct cpu_cache_level caches[MAX_CACHE_LVL];
+	u32 cache_level = stat_config.aggr_level;
+	u32 i = 0, caches_cnt = 0;
+
+	cache->cache_lvl = (cache_level > MAX_CACHE_LVL) ? 0 : cache_level;
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
+		cache->cache = cpu__get_cache_id_from_map(cpu, caches[max_level_index].map);
+
+		/* Reset i to 0 to free entire caches[] */
+		i = 0;
+		goto free_caches;
+	}
+
+	for (i = 0; i < caches_cnt; ++i) {
+		if (caches[i].level == cache_level) {
+			cache->cache_lvl = cache_level;
+			cache->cache = cpu__get_cache_id_from_map(cpu, caches[i].map);
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
@@ -679,6 +792,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
+		a->cache_lvl == b->cache_lvl &&
+		a->cache == b->cache &&
 		a->core == b->core &&
 		a->cpu.cpu == b->cpu.cpu;
 }
@@ -689,6 +804,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
+		a->cache_lvl == -1 &&
+		a->cache == -1 &&
 		a->core == -1 &&
 		a->cpu.cpu == -1;
 }
@@ -700,6 +817,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.node = -1,
 		.socket = -1,
 		.die = -1,
+		.cache_lvl = -1,
+		.cache = -1,
 		.core = -1,
 		.cpu = (struct perf_cpu){ .cpu = -1 },
 	};
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index e3426541e0aa..1212b4ab1938 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -20,6 +20,13 @@ struct aggr_cpu_id {
 	int socket;
 	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The cache level as read from /sys/devices/system/cpu/cpuX/cache/indexY/level */
+	int cache_lvl;
+	/**
+	 * The cache instance ID, which is the first CPU in the
+	 * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
+	 */
+	int cache;
 	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 	/** CPU aggregation, note there is one CPU for each SMT thread. */
@@ -79,6 +86,20 @@ int cpu__get_socket_id(struct perf_cpu cpu);
  * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
  */
 int cpu__get_die_id(struct perf_cpu cpu);
+/**
+ * Calculate the cache instance ID from the map in
+ * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
+ * Cache instance ID is the first CPU reported in the shared_cpu_list file.
+ */
+int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map);
+/**
+ * cpu__get_cache_id - Returns 0 if successful in populating the
+ * cache level and cache id. Cache level is read from
+ * /sys/devices/system/cpu/cpuX/cache/indexY/level where as cache instance ID
+ * is the first CPU reported by
+ * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
+ */
+int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache);
 /**
  * cpu__get_core_id - Returns the core id as read from
  * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
@@ -119,6 +140,13 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
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
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bf5a6c14dfcd..319f456f0673 100644
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
 			id.socket, id.die, id.core, sep, aggr_nr, sep);
 		break;
+	case AGGR_CACHE:
+		fprintf(config->output, "S%d-D%d-L%d-ID%d%s%d%s",
+			id.socket, id.die, id.cache_lvl, id.cache, sep, aggr_nr, sep);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "S%d-D%d%s%d%s",
 			id.socket, id.die, sep, aggr_nr, sep);
@@ -284,6 +295,10 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, id.core, aggr_nr);
 		break;
+	case AGGR_CACHE:
+		fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d, ",
+			id.socket, id.die, id.cache_lvl, id.cache, aggr_nr);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, aggr_nr);
@@ -1125,6 +1140,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_NODE:
 	case AGGR_SOCKET:
 	case AGGR_DIE:
+	case AGGR_CACHE:
 	case AGGR_CORE:
 		fprintf(output, "#%*s %-*s cpus",
 			INTERVAL_LEN - 1, "time",
@@ -1425,6 +1441,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
+	case AGGR_CACHE:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NODE:
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index e35e188237c8..7abff7cbb5a1 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -48,6 +48,7 @@ enum aggr_mode {
 	AGGR_GLOBAL,
 	AGGR_SOCKET,
 	AGGR_DIE,
+	AGGR_CACHE,
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
@@ -64,6 +65,7 @@ typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, str
 
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
+	u32			 aggr_level;
 	bool			 scale;
 	bool			 no_inherit;
 	bool			 identifier;
-- 
2.34.1

