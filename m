Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE37675B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjATRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjATRdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:33:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E2FDA10B;
        Fri, 20 Jan 2023 09:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E70F6202E;
        Fri, 20 Jan 2023 17:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959C3C433EF;
        Fri, 20 Jan 2023 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674235954;
        bh=IdUYMSt3wTGv2diJCAcwKvFCfNaWHFQmpW/zxgBkcx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEUTACJCTrqLyFYdY9iGjjURfV8/9YXDIqx013dd83fYyf5Oyx9e7UvZjgXdt2o8m
         BDRDB4otAl0Mm9y2G9qfVtywTfJjw5SMe88gn2fmaYe4zFe+CBOO/hh4aPQVOAvfIH
         +/5ZLn2fpcQK6tsh7v5tlh1zNDXJY2FKPBtIqit8e9TUoImkbDG+ROw6CI7s2ECoZF
         fBxz39uBBTVl7Km4GD7SkKFOsnLLaydjy6tmMhXGCxudFHPrNX9kW3MaSGPmDGq54A
         mpO5T+aLjG39w0UrNIc6sBsf5GOWNlkbMDUJHQh90HaVTYPaQH/lfsyrtGFK3TuD2/
         HgIqX0+65+iSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA224405BE; Fri, 20 Jan 2023 14:32:30 -0300 (-03)
Date:   Fri, 20 Jan 2023 14:32:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org, sgoutham@marvell.com,
        gcherian@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/8] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
Message-ID: <Y8rQLirdlgU8nMEW@kernel.org>
References: <20230120143702.4035046-1-james.clark@arm.com>
 <20230120143702.4035046-3-james.clark@arm.com>
 <Y8rNtO5HNcPJDpQ2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rNtO5HNcPJDpQ2@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 20, 2023 at 02:21:56PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 20, 2023 at 02:36:55PM +0000, James Clark escreveu:
> > Remove some code that duplicates existing methods. Copy strings where
> > const strings are required.
> > 
> > No functional changes.
> 
> 
> Have you used 'perf test'?
> 
> [acme@quaco perf]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>  19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 232379
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: perf_pmu__scan_file
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [acme@quaco perf]$

I added this to this cset, now it passes.

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d948455e5ed43656..9e5d881b098767a3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -20,6 +20,7 @@
 #include "stat.h"
 #include "metricgroup.h"
 #include "util/env.h"
+#include "util/pmu.h"
 #include <internal/lib.h>
 #include "util.h"
 
@@ -83,7 +84,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 }
 
 /*
- * This one is needed not to drag the PMU bandwagon, jevents generated
+ * These ones are needed not to drag the PMU bandwagon, jevents generated
  * pmu_sys_event_tables, etc and evsel__find_pmu() is used so far just for
  * doing per PMU perf_event_attr.exclude_guest handling, not really needed, so
  * far, for the perf python binding known usecases, revisit if this become
@@ -94,6 +95,11 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel __maybe_unused)
 	return NULL;
 }
 
+int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...)
+{
+	return EOF;
+}
+
 /*
  * Add this one here not to drag util/metricgroup.c
  */
  
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/cputopo.c    |  9 +-------
> >  tools/perf/util/pmu-hybrid.c | 27 +++++-------------------
> >  tools/perf/util/pmu.c        | 40 +++++++++++-------------------------
> >  tools/perf/util/pmu.h        |  3 ++-
> >  4 files changed, 20 insertions(+), 59 deletions(-)
> > 
> > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > index 1a3ff6449158..e08797c3cdbc 100644
> > --- a/tools/perf/util/cputopo.c
> > +++ b/tools/perf/util/cputopo.c
> > @@ -422,8 +422,6 @@ void numa_topology__delete(struct numa_topology *tp)
> >  static int load_hybrid_node(struct hybrid_topology_node *node,
> >  			    struct perf_pmu *pmu)
> >  {
> > -	const char *sysfs;
> > -	char path[PATH_MAX];
> >  	char *buf = NULL, *p;
> >  	FILE *fp;
> >  	size_t len = 0;
> > @@ -432,12 +430,7 @@ static int load_hybrid_node(struct hybrid_topology_node *node,
> >  	if (!node->pmu_name)
> >  		return -1;
> >  
> > -	sysfs = sysfs__mountpoint();
> > -	if (!sysfs)
> > -		goto err;
> > -
> > -	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, pmu->name);
> > -	fp = fopen(path, "r");
> > +	fp = perf_pmu__open_file(pmu, "cpus");
> >  	if (!fp)
> >  		goto err;
> >  
> > diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
> > index f51ccaac60ee..38628805a952 100644
> > --- a/tools/perf/util/pmu-hybrid.c
> > +++ b/tools/perf/util/pmu-hybrid.c
> > @@ -20,32 +20,15 @@ LIST_HEAD(perf_pmu__hybrid_pmus);
> >  
> >  bool perf_pmu__hybrid_mounted(const char *name)
> >  {
> > -	char path[PATH_MAX];
> > -	const char *sysfs;
> > -	FILE *file;
> > -	int n, cpu;
> > +	int cpu;
> > +	char pmu_name[PATH_MAX];
> > +	struct perf_pmu pmu = {.name = pmu_name};
> >  
> >  	if (strncmp(name, "cpu_", 4))
> >  		return false;
> >  
> > -	sysfs = sysfs__mountpoint();
> > -	if (!sysfs)
> > -		return false;
> > -
> > -	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
> > -	if (!file_available(path))
> > -		return false;
> > -
> > -	file = fopen(path, "r");
> > -	if (!file)
> > -		return false;
> > -
> > -	n = fscanf(file, "%u", &cpu);
> > -	fclose(file);
> > -	if (n <= 0)
> > -		return false;
> > -
> > -	return true;
> > +	strlcpy(pmu_name, name, sizeof(pmu_name));
> > +	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
> >  }
> >  
> >  struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 1edbb714ff32..a771a5972fc5 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -571,45 +571,31 @@ static void pmu_read_sysfs(void)
> >  	closedir(dir);
> >  }
> >  
> > -static struct perf_cpu_map *__pmu_cpumask(const char *path)
> > -{
> > -	FILE *file;
> > -	struct perf_cpu_map *cpus;
> > -
> > -	file = fopen(path, "r");
> > -	if (!file)
> > -		return NULL;
> > -
> > -	cpus = perf_cpu_map__read(file);
> > -	fclose(file);
> > -	return cpus;
> > -}
> > -
> >  /*
> >   * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
> >   * may have a "cpus" file.
> >   */
> >  #define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
> > -#define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
> >  
> >  static struct perf_cpu_map *pmu_cpumask(const char *name)
> >  {
> > -	char path[PATH_MAX];
> >  	struct perf_cpu_map *cpus;
> > -	const char *sysfs = sysfs__mountpoint();
> >  	const char *templates[] = {
> > -		CPUS_TEMPLATE_UNCORE,
> > -		CPUS_TEMPLATE_CPU,
> > +		"cpumask",
> > +		"cpus",
> >  		NULL
> >  	};
> >  	const char **template;
> > +	char pmu_name[PATH_MAX];
> > +	struct perf_pmu pmu = {.name = pmu_name};
> > +	FILE *file;
> >  
> > -	if (!sysfs)
> > -		return NULL;
> > -
> > +	strlcpy(pmu_name, name, sizeof(pmu_name));
> >  	for (template = templates; *template; template++) {
> > -		snprintf(path, PATH_MAX, *template, sysfs, name);
> > -		cpus = __pmu_cpumask(path);
> > +		file = perf_pmu__open_file(&pmu, *template);
> > +		if (!file)
> > +			continue;
> > +		cpus = perf_cpu_map__read(file);
> >  		if (cpus)
> >  			return cpus;
> >  	}
> > @@ -620,13 +606,11 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
> >  static bool pmu_is_uncore(const char *name)
> >  {
> >  	char path[PATH_MAX];
> > -	const char *sysfs;
> >  
> >  	if (perf_pmu__hybrid_mounted(name))
> >  		return false;
> >  
> > -	sysfs = sysfs__mountpoint();
> > -	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
> > +	perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpumask");
> >  	return file_available(path);
> >  }
> >  
> > @@ -1737,7 +1721,7 @@ bool pmu_have_event(const char *pname, const char *name)
> >  	return false;
> >  }
> >  
> > -static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
> > +FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
> >  {
> >  	char path[PATH_MAX];
> >  
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 96d030c8b3b3..742d4db319a0 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/list.h>
> >  #include <stdbool.h>
> > +#include <stdio.h>
> >  #include "parse-events.h"
> >  #include "pmu-events/pmu-events.h"
> >  
> > @@ -22,7 +23,6 @@ enum {
> >  };
> >  
> >  #define PERF_PMU_FORMAT_BITS 64
> > -#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
> >  #define MAX_PMU_NAME_LEN 128
> >  
> >  struct perf_event_attr;
> > @@ -262,5 +262,6 @@ double perf_pmu__cpu_slots_per_cycle(void);
> >  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
> >  int perf_pmu__pathname_scnprintf(char *buf, size_t size,
> >  				 const char *pmu_name, const char *filename);
> > +FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
> >  
> >  #endif /* __PMU_H */
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
