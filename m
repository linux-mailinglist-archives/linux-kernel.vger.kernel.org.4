Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481F96CBDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjC1L3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjC1L2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:28:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE61F83D9;
        Tue, 28 Mar 2023 04:28:21 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pm6q30cLJzKmbS;
        Tue, 28 Mar 2023 19:27:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 19:27:55 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <james.clark@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Jonathan.Cameron@huawei.com>, <21cnbao@gmail.com>,
        <tim.c.chen@intel.com>, <prime.zeng@hisilicon.com>,
        <shenyang39@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>
Subject: [PATCH v2] perf stat: Support per-cluster aggregation
Date:   Tue, 28 Mar 2023 19:27:17 +0800
Message-ID: <20230328112717.19573-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Some platforms have 'cluster' topology and CPUs in the cluster will
share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
cache (for Intel Jacobsville). Currently parsing and building cluster
topology have been supported since [1].

perf stat has already supported aggregation for other topologies like
die or socket, etc. It'll be useful to aggregate per-cluster to find
problems like L3T bandwidth contention.

This patch add support for "--per-cluster" option for per-cluster
aggregation. Also update the docs and related test. The output will
be like:

[root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5

 Performance counter stats for 'system wide':

S56-D0-CLS158    4      1,321,521,570      LLC-load
S56-D0-CLS594    4        794,211,453      LLC-load
S56-D0-CLS1030    4             41,623      LLC-load
S56-D0-CLS1466    4             41,646      LLC-load
S56-D0-CLS1902    4             16,863      LLC-load
S56-D0-CLS2338    4             15,721      LLC-load
S56-D0-CLS2774    4             22,671      LLC-load
[...]

Note that this patch doesn't mix the cluster information in the outputs
of --per-core to avoid breaking any tools/scripts using it.

[1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")
Tested-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- Provides the information about how to map the cluster to the CPUs in the manual
- Thanks the review from Tim and test from Jie.
Link: https://lore.kernel.org/all/20230313085911.61359-1-yangyicong@huawei.com/

 tools/perf/Documentation/perf-stat.txt        | 11 ++++
 tools/perf/builtin-stat.c                     | 52 +++++++++++++++++--
 .../tests/shell/lib/perf_json_output_lint.py  |  4 +-
 tools/perf/tests/shell/stat+csv_output.sh     | 14 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 13 +++++
 tools/perf/util/cpumap.c                      | 28 +++++++++-
 tools/perf/util/cpumap.h                      | 19 +++++--
 tools/perf/util/env.h                         |  1 +
 tools/perf/util/stat-display.c                | 13 +++++
 tools/perf/util/stat.h                        |  1 +
 10 files changed, 147 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 18abdc1dce05..b3df12b06641 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -308,6 +308,14 @@ use --per-die in addition to -a. (system-wide).  The output includes the
 die number and the number of online processors on that die. This is
 useful to gauge the amount of aggregation.
 
+--per-cluster::
+Aggregate counts per processor cluster for system-wide mode measurement.  This
+is a useful mode to detect imbalance between clusters.  To enable this mode,
+use --per-cluster in addition to -a. (system-wide).  The output includes the
+cluster number and the number of online processors on that cluster. This is
+useful to gauge the amount of aggregation. The information of cluster ID and
+related CPUs can be gotten from /sys/devices/system/cpu/cpuX/topology/cluster_{id, cpus}.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.  This
 is a useful mode to detect imbalance between physical cores.  To enable this mode,
@@ -379,6 +387,9 @@ Aggregate counts per processor socket for system-wide mode measurements.
 --per-die::
 Aggregate counts per processor die for system-wide mode measurements.
 
+--per-cluster::
+Aggregate counts perf processor cluster for system-wide mode measurements.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fa7c40956d0f..e5630cb28985 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1237,6 +1237,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_SET_UINT(0, "per-cluster", &stat_config.aggr_mode,
+		     "aggregate counts per processor cluster", AGGR_CLUSTER),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
@@ -1298,6 +1300,7 @@ static struct option stat_options[] = {
 
 static const char *const aggr_mode__string[] = {
 	[AGGR_CORE] = "core",
+	[AGGR_CLUSTER] = "cluster",
 	[AGGR_DIE] = "die",
 	[AGGR_GLOBAL] = "global",
 	[AGGR_NODE] = "node",
@@ -1319,6 +1322,12 @@ static struct aggr_cpu_id perf_stat__get_die(struct perf_stat_config *config __m
 	return aggr_cpu_id__die(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_cluster(struct perf_stat_config *config __maybe_unused,
+						 struct perf_cpu cpu)
+{
+	return aggr_cpu_id__cluster(cpu, /*data=*/NULL);
+}
+
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 					      struct perf_cpu cpu)
 {
@@ -1371,6 +1380,12 @@ static struct aggr_cpu_id perf_stat__get_die_cached(struct perf_stat_config *con
 	return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_cluster_cached(struct perf_stat_config *config,
+							struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_cluster, cpu);
+}
+
 static struct aggr_cpu_id perf_stat__get_core_cached(struct perf_stat_config *config,
 						     struct perf_cpu cpu)
 {
@@ -1402,6 +1417,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 		return aggr_cpu_id__socket;
 	case AGGR_DIE:
 		return aggr_cpu_id__die;
+	case AGGR_CLUSTER:
+		return aggr_cpu_id__cluster;
 	case AGGR_CORE:
 		return aggr_cpu_id__core;
 	case AGGR_NODE:
@@ -1425,6 +1442,8 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_cached;
 	case AGGR_DIE:
 		return perf_stat__get_die_cached;
+	case AGGR_CLUSTER:
+		return perf_stat__get_cluster_cached;
 	case AGGR_CORE:
 		return perf_stat__get_core_cached;
 	case AGGR_NODE:
@@ -1537,6 +1556,21 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(struct perf_cpu cpu, voi
 	return id;
 }
 
+static struct aggr_cpu_id perf_env__get_cluster_aggr_by_cpu(struct perf_cpu cpu,
+							    void *data)
+{
+	struct perf_env *env = data;
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	if (cpu.cpu != -1) {
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
+		id.cluster = env->cpu[cpu.cpu].cluster_id;
+	}
+
+	return id;
+}
+
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1544,12 +1578,12 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, vo
 
 	if (cpu.cpu != -1) {
 		/*
-		 * core_id is relative to socket and die,
-		 * we need a global id. So we set
-		 * socket, die id and core id
+		 * core_id is relative to socket, die and cluster, we need a
+		 * global id. So we set socket, die id, cluster id and core id.
 		 */
 		id.socket = env->cpu[cpu.cpu].socket_id;
 		id.die = env->cpu[cpu.cpu].die_id;
+		id.cluster = env->cpu[cpu.cpu].cluster_id;
 		id.core = env->cpu[cpu.cpu].core_id;
 	}
 
@@ -1605,6 +1639,12 @@ static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *confi
 	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_cluster_file(struct perf_stat_config *config __maybe_unused,
+						      struct perf_cpu cpu)
+{
+	return perf_env__get_cluster_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
 						   struct perf_cpu cpu)
 {
@@ -1636,6 +1676,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 		return perf_env__get_socket_aggr_by_cpu;
 	case AGGR_DIE:
 		return perf_env__get_die_aggr_by_cpu;
+	case AGGR_CLUSTER:
+		return perf_env__get_cluster_aggr_by_cpu;
 	case AGGR_CORE:
 		return perf_env__get_core_aggr_by_cpu;
 	case AGGR_NODE:
@@ -1659,6 +1701,8 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_file;
 	case AGGR_DIE:
 		return perf_stat__get_die_file;
+	case AGGR_CLUSTER:
+		return perf_stat__get_cluster_file;
 	case AGGR_CORE:
 		return perf_stat__get_core_file;
 	case AGGR_NODE:
@@ -2219,6 +2263,8 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_SET_UINT(0, "per-cluster", &perf_stat.aggr_mode,
+		     "aggregate counts perf processor cluster", AGGR_CLUSTER),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 97598d14e532..1869ff9b92c1 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -14,6 +14,7 @@ ap.add_argument('--system-wide', action='store_true')
 ap.add_argument('--event', action='store_true')
 ap.add_argument('--per-core', action='store_true')
 ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-cluster', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
@@ -46,6 +47,7 @@ def check_json_output(expected_items):
       'counter-value': lambda x: is_counter_value(x),
       'cgroup': lambda x: True,
       'cpu': lambda x: isint(x),
+      'cluster': lambda x: True,
       'die': lambda x: True,
       'event': lambda x: True,
       'event-runtime': lambda x: isfloat(x),
@@ -82,7 +84,7 @@ try:
     expected_items = 7
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 8
-  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cluster:
     expected_items = 9
   else:
     # If no option is specified, don't check the number of items.
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 324fc9e6edd7..7311bc835280 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -26,6 +26,7 @@ function commachecker()
 	;; "--per-socket")	exp=8
 	;; "--per-node")	exp=8
 	;; "--per-die")		exp=8
+	;; "--per-cluster")	exp=8
 	esac
 
 	while read line
@@ -123,6 +124,18 @@ check_per_thread()
 	echo "[Success]"
 }
 
+check_per_cluster()
+{
+	echo -n "Checking CSV output: per cluster "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -x$csv_sep --per-cluster -a true 2>&1 | commachecker --per-cluster
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
+	check_per_cluster
 	check_per_die
 	check_per_socket
 else
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 2c4212c641ed..c74bfd32abcb 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -100,6 +100,18 @@ check_per_thread()
 	echo "[Success]"
 }
 
+check_per_cluster()
+{
+	echo -n "Checking json output: per cluster "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-cluster -a true 2>&1 | $PYTHON $pythonchecker --per-cluster
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
+	check_per_cluster
 	check_per_die
 	check_per_socket
 else
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5e564974fba4..636b3bc0cc04 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -227,6 +227,8 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
 		return a->socket - b->socket;
 	else if (a->die != b->die)
 		return a->die - b->die;
+	else if (a->cluster != b->cluster)
+		return a->cluster - b->cluster;
 	else if (a->core != b->core)
 		return a->core - b->core;
 	else
@@ -310,6 +312,25 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 	return id;
 }
 
+int cpu__get_cluster_id(struct perf_cpu cpu)
+{
+	int value, ret = cpu__get_topology_int(cpu.cpu, "cluster_id", &value);
+	return ret ?: value;
+}
+
+struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data)
+{
+	int cluster = cpu__get_cluster_id(cpu);
+	struct aggr_cpu_id id;
+
+	id = aggr_cpu_id__die(cpu, data);
+	if (aggr_cpu_id__is_empty(&id))
+		return id;
+
+	id.cluster = cluster;
+	return id;
+}
+
 int cpu__get_core_id(struct perf_cpu cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu.cpu, "core_id", &value);
@@ -321,8 +342,8 @@ struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data)
 	struct aggr_cpu_id id;
 	int core = cpu__get_core_id(cpu);
 
-	/* aggr_cpu_id__die returns a struct with socket and die set. */
-	id = aggr_cpu_id__die(cpu, data);
+	/* aggr_cpu_id__die returns a struct with socket die, and cluster set. */
+	id = aggr_cpu_id__cluster(cpu, data);
 	if (aggr_cpu_id__is_empty(&id))
 		return id;
 
@@ -684,6 +705,7 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
+		a->cluster == b->cluster &&
 		a->core == b->core &&
 		a->cpu.cpu == b->cpu.cpu;
 }
@@ -694,6 +716,7 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
+		a->cluster == -1 &&
 		a->core == -1 &&
 		a->cpu.cpu == -1;
 }
@@ -705,6 +728,7 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.node = -1,
 		.socket = -1,
 		.die = -1,
+		.cluster = -1,
 		.core = -1,
 		.cpu = (struct perf_cpu){ .cpu = -1 },
 	};
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2f5824a3a22..e3b6b8c1b0b4 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -20,6 +20,8 @@ struct aggr_cpu_id {
 	int socket;
 	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The cluster id as read from /sys/devices/system/cpu/cpuX/topology/cluster_id */
+	int cluster;
 	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 	/** CPU aggregation, note there is one CPU for each SMT thread. */
@@ -76,6 +78,11 @@ int cpu__get_socket_id(struct perf_cpu cpu);
  * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
  */
 int cpu__get_die_id(struct perf_cpu cpu);
+/**
+ * cpu__get_cluster_id - Returns the cluster id as read from
+ * /sys/devices/system/cpu/cpuX/topology/cluster_id for the given CPU
+ */
+int cpu__get_cluster_id(struct perf_cpu cpu);
 /**
  * cpu__get_core_id - Returns the core id as read from
  * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
@@ -117,9 +124,15 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
  */
 struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
 /**
- * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
- * populated with the core, die and socket for cpu. The function signature is
- * compatible with aggr_cpu_id_get_t.
+ * aggr_cpu_id__cluster - Create an aggr_cpu_id with cluster, die and socket
+ * populated with the cluster, die and socket for cpu. The function signature
+ * is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data);
+/**
+ * aggr_cpu_id__core - Create an aggr_cpu_id with the core, cluster, die and
+ * socket populated with the core, die and socket for cpu. The function
+ * signature is compatible with aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data);
 /**
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd9..e288649627d5 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -12,6 +12,7 @@ struct perf_cpu_map;
 struct cpu_topology_map {
 	int	socket_id;
 	int	die_id;
+	int	cluster_id;
 	int	core_id;
 };
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1b5cb20efd23..a6aca21ab040 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -193,6 +193,9 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 	case AGGR_CORE:
 		snprintf(buf, sizeof(buf), "S%d-D%d-C%d", id.socket, id.die, id.core);
 		break;
+	case AGGR_CLUSTER:
+		snprintf(buf, sizeof(buf), "S%d-D%d-CLS%d", id.socket, id.die, id.cluster);
+		break;
 	case AGGR_DIE:
 		snprintf(buf, sizeof(buf), "S%d-D%d", id.socket, id.die);
 		break;
@@ -239,6 +242,10 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
 		fprintf(output, "S%d-D%d-C%d%s%d%s",
 			id.socket, id.die, id.core, sep, nr, sep);
 		break;
+	case AGGR_CLUSTER:
+		fprintf(config->output, "S%d-D%d-CLS%d%s%d%s",
+			id.socket, id.die, id.cluster, sep, nr, sep);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "S%d-D%d%s%d%s",
 			id.socket, id.die, sep, nr, sep);
@@ -284,6 +291,10 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, id.core, nr);
 		break;
+	case AGGR_CLUSTER:
+		fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregate-number\" : %d, ",
+			id.socket, id.die, id.cluster, nr);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, nr);
@@ -1126,6 +1137,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_NODE:
 	case AGGR_SOCKET:
 	case AGGR_DIE:
+	case AGGR_CLUSTER:
 	case AGGR_CORE:
 		fprintf(output, "#%*s %-*s cpus",
 			INTERVAL_LEN - 1, "time",
@@ -1422,6 +1434,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
+	case AGGR_CLUSTER:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NODE:
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index bf1794ebc916..9efbfbc25bc7 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -74,6 +74,7 @@ enum aggr_mode {
 	AGGR_GLOBAL,
 	AGGR_SOCKET,
 	AGGR_DIE,
+	AGGR_CLUSTER,
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
-- 
2.24.0

