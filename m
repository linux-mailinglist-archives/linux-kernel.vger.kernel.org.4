Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B381B70E521
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjEWTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEWTM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE6119;
        Tue, 23 May 2023 12:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CAF61D46;
        Tue, 23 May 2023 19:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E1C433EF;
        Tue, 23 May 2023 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684869143;
        bh=WdRoFC44v3WUBPc3fySFHSlYSbtfp6uk3GWktHrtFag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYU9y1TqSYrzbyMgF/yvKqyYzQj+G4L+n75uSRjTBwAkEpze5BHUe0j54ATOE90gv
         rtgYyIh7slSjEqkhgWRvWbWmtmsKr4tQ+M+g4I95+6hE17XPlBv1x7DrItZe8XEdvc
         YTckXtINR7yuw/dqXtglfxT4cES4y+C4Xc+2vjyDuBV6LzhUUvmghWfd1XObZkrXLi
         FM0HIK8HNkM31HtD67MUmpzq3f7aJvmrJD7zBsoSNDxyS2ytvC0+G62WK0bmkmHcZt
         wnwauWaubJUzta5Yd8bT+Y69KqIsAsQUiUY/dbc4Dan7Ygf5zxjpwMQJt5WXZHmAT1
         RZDUsYKRqTf7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72A11403B5; Tue, 23 May 2023 16:12:20 -0300 (-03)
Date:   Tue, 23 May 2023 16:12:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ravi.bangoria@amd.com, sandipan.das@amd.com,
        ananth.narayan@amd.com, gautham.shenoy@amd.com, eranian@google.com,
        irogers@google.com, puwen@hygon.cn
Subject: Re: [PATCH v4 2/5] perf stat: Setup the foundation to allow
 aggregation based on cache topology
Message-ID: <ZG0QFGgwqv3GVsn2@kernel.org>
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
 <20230517172745.5833-3-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517172745.5833-3-kprateek.nayak@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 17, 2023 at 10:57:42PM +0530, K Prateek Nayak escreveu:
> Processors based on chiplet architecture, such as AMD EPYC and Hygon do
> not expose the chiplet details in the sysfs CPU topology information.
> However, this information can be derived from the per CPU cache level
> information from the sysfs.
> 
> perf stat has already supported aggregation based on topology
> information using core ID, socket ID, etc. It'll be useful to aggregate
> based on the cache topology to detect problems like imbalance and
> cache-to-cache sharing at various cache levels.
> 
> This patch lays the foundation for aggregating data in perf stat based
> on the processor's cache topology. The cmdline option to aggregate data
> based on the cache topology is added in Patch 4 of the series while this
> patch sets up all the necessary functions and variables required to
> support the new aggregation option.
> 
> The patch also adds support to display per-cache aggregation, or save it
> as a JSON or CSV, as splitting it into a separate patch would break
> builds when compiling with "-Werror=switch-enum" where the compiler will
> complain about the lack of handling for the AGGR_CACHE case in the
> output functions.
> 
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changelog:
> o v3->v4:
>   - Some parts of the previous Patch 2 have been put into subsequent
>     smaller patches (while being careful not to introduce any build
>     errors in case someone were to bisect through the series)
>   - Fixed comments.

So I had to make the following changes, added this explanation to the
resulting cset:

    Committer notes:

    Don't use perf_stat_config in tools/perf/util/cpumap.c, this would make
    code that is in util/, thus not really specific to a single builtin, use
    a specific builtin config structure.

    Move the functions introduced in this patch from
    tools/perf/util/cpumap.c since it needs access to builtin specific
    and is not strictly needed to live in the util/ directory.

    With this 'perf test python' is back building.

- Arnaldo

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68294ea499ae51d9..0528d1bc15d27705 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -150,7 +150,7 @@ static struct perf_stat		perf_stat;
 
 static volatile sig_atomic_t done = 0;
 
-struct perf_stat_config stat_config = {
+static struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
 	.aggr_level		= MAX_CACHE_LVL + 1,
 	.scale			= true,
@@ -1251,6 +1251,129 @@ static struct option stat_options[] = {
 	OPT_END()
 };
 
+/**
+ * Calculate the cache instance ID from the map in
+ * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
+ * Cache instance ID is the first CPU reported in the shared_cpu_list file.
+ */
+static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
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
+/**
+ * cpu__get_cache_id - Returns 0 if successful in populating the
+ * cache level and cache id. Cache level is read from
+ * /sys/devices/system/cpu/cpuX/cache/indexY/level where as cache instance ID
+ * is the first CPU reported by
+ * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
+ */
+static int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache)
+{
+	int ret = 0;
+	u32 cache_level = stat_config.aggr_level;
+	struct cpu_cache_level caches[MAX_CACHE_LVL];
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
+/**
+ * aggr_cpu_id__cache - Create an aggr_cpu_id with cache instache ID, cache
+ * level, die and socket populated with the cache instache ID, cache level,
+ * die and socket for cpu. The function signature is compatible with
+ * aggr_cpu_id_get_t.
+ */
+static struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
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
 static const char *const aggr_mode__string[] = {
 	[AGGR_CORE] = "core",
 	[AGGR_CACHE] = "cache",
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 88d387200745de2f..a0719816a218d441 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -3,8 +3,6 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
-#include "header.h"
-#include "stat.h"
 #include <assert.h>
 #include <dirent.h>
 #include <stdio.h>
@@ -311,113 +309,6 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 	return id;
 }
 
-extern struct perf_stat_config stat_config;
-
-int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
-{
-	int id;
-	struct perf_cpu_map *cpu_map = perf_cpu_map__new(map);
-
-	/*
-	 * If the map contains no CPU, consider the current CPU to
-	 * be the first online CPU in the cache domain else use the
-	 * first online CPU of the cache domain as the ID.
-	 */
-	if (perf_cpu_map__empty(cpu_map))
-		id = cpu.cpu;
-	else
-		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
-
-	/* Free the perf_cpu_map used to find the cache ID */
-	perf_cpu_map__put(cpu_map);
-
-	return id;
-}
-
-int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache)
-{
-	int ret = 0;
-	struct cpu_cache_level caches[MAX_CACHE_LVL];
-	u32 cache_level = stat_config.aggr_level;
-	u32 i = 0, caches_cnt = 0;
-
-	cache->cache_lvl = (cache_level > MAX_CACHE_LVL) ? 0 : cache_level;
-	cache->cache = -1;
-
-	ret = build_caches_for_cpu(cpu.cpu, caches, &caches_cnt);
-	if (ret) {
-		/*
-		 * If caches_cnt is not 0, cpu_cache_level data
-		 * was allocated when building the topology.
-		 * Free the allocated data before returning.
-		 */
-		if (caches_cnt)
-			goto free_caches;
-
-		return ret;
-	}
-
-	if (!caches_cnt)
-		return -1;
-
-	/*
-	 * Save the data for the highest level if no
-	 * level was specified by the user.
-	 */
-	if (cache_level > MAX_CACHE_LVL) {
-		int max_level_index = 0;
-
-		for (i = 1; i < caches_cnt; ++i) {
-			if (caches[i].level > caches[max_level_index].level)
-				max_level_index = i;
-		}
-
-		cache->cache_lvl = caches[max_level_index].level;
-		cache->cache = cpu__get_cache_id_from_map(cpu, caches[max_level_index].map);
-
-		/* Reset i to 0 to free entire caches[] */
-		i = 0;
-		goto free_caches;
-	}
-
-	for (i = 0; i < caches_cnt; ++i) {
-		if (caches[i].level == cache_level) {
-			cache->cache_lvl = cache_level;
-			cache->cache = cpu__get_cache_id_from_map(cpu, caches[i].map);
-		}
-
-		cpu_cache_level__free(&caches[i]);
-	}
-
-free_caches:
-	/*
-	 * Free all the allocated cpu_cache_level data.
-	 */
-	while (i < caches_cnt)
-		cpu_cache_level__free(&caches[i++]);
-
-	return ret;
-}
-
-struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
-{
-	int ret;
-	struct aggr_cpu_id id;
-	struct perf_cache cache;
-
-	id = aggr_cpu_id__die(cpu, data);
-	if (aggr_cpu_id__is_empty(&id))
-		return id;
-
-	ret = cpu__get_cache_details(cpu, &cache);
-	if (ret)
-		return id;
-
-	id.cache_lvl = cache.cache_lvl;
-	id.cache = cache.cache;
-	return id;
-}
-
 int cpu__get_core_id(struct perf_cpu cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu.cpu, "core_id", &value);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 1212b4ab19386293..f394ccc0ccfbca4c 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -86,20 +86,6 @@ int cpu__get_socket_id(struct perf_cpu cpu);
  * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
  */
 int cpu__get_die_id(struct perf_cpu cpu);
-/**
- * Calculate the cache instance ID from the map in
- * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
- * Cache instance ID is the first CPU reported in the shared_cpu_list file.
- */
-int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map);
-/**
- * cpu__get_cache_id - Returns 0 if successful in populating the
- * cache level and cache id. Cache level is read from
- * /sys/devices/system/cpu/cpuX/cache/indexY/level where as cache instance ID
- * is the first CPU reported by
- * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
- */
-int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache);
 /**
  * cpu__get_core_id - Returns the core id as read from
  * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
@@ -140,13 +126,6 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
  * aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
-/**
- * aggr_cpu_id__cache - Create an aggr_cpu_id with cache instache ID, cache
- * level, die and socket populated with the cache instache ID, cache level,
- * die and socket for cpu. The function signature is compatible with
- * aggr_cpu_id_get_t.
- */
-struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data);
 /**
  * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
  * populated with the core, die and socket for cpu. The function signature is
