Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21696DFA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDLPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDLPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56583E3;
        Wed, 12 Apr 2023 08:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F3BE62AAA;
        Wed, 12 Apr 2023 15:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6487C433EF;
        Wed, 12 Apr 2023 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681314083;
        bh=uEXsdxZQV1QfEC1h3A9FFDtHPNZrT00npYRCTSESuAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWHdlxL1MNgvesIsfYwYbJtQYw7cn/kjAqJJuA2Q3T2rVDTb6Hk255saGxv3fdWSo
         3eztLhDqFlvO7JoZCrSlnjJBe+VY4cBaYgTsN/h5LWQMJ4knXpH7ZBgZmk71ub4OVQ
         9Af6DrJQn33hgDEkofpnF7GvO4u82aH8rshXK5kCewvQQo6PZctd/TFXJesruDYfQt
         Lt2yi7QORfwlaULkSONcnvewCnsFBOVDlLmddhKf9IiC5ewZwvFkN4g+KciiYV54Nl
         C94IiehfL9R4Ga+7tsCOEtyuOTgKijuOQ4sWvNoEMLZCunfWtyDq4S/1EegzbTvVD8
         Q/JayVrAOvi5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 271C940080; Wed, 12 Apr 2023 12:41:20 -0300 (-03)
Date:   Wed, 12 Apr 2023 12:41:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v7 2/5] perf cpumap: Add reference count checking
Message-ID: <ZDbRIJknafLnDwtO@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-3-irogers@google.com>
 <ZDWkmmj/UvuiXSWX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWkmmj/UvuiXSWX@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 11, 2023 at 03:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 07, 2023 at 04:04:02PM -0700, Ian Rogers escreveu:
> > This change is intended to catch:
> >  - use after put: using a cpumap after you have put it will cause a
> >    segv.
> >  - unbalanced puts: two puts for a get will result in a double free
> >    that can be captured and reported by tools like address sanitizer,
> >    including with the associated stack traces of allocation and frees.
> >  - missing puts: if a put is missing then the get turns into a memory
> >    leak that can be reported by leak sanitizer, including the stack
> >    trace at the point the get occurs.
 
> I think this should be further split into self contained patches as it
> does:

> 3. Shouldn't we have a map__refcnt(map) accessor to avoid using those
> verbose macros outside the object that is having its reference counts
> checked?

So I added this one, in the end its just to avoid 

From 997a7909789d5b5570dc3cfcd1b9f03877f544bd Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 12 Apr 2023 12:36:58 -0300
Subject: [PATCH 1/1] perf map: Add map__refcnt() accessor to use in the maps
 test

To remove one more direct access to 'struct map' so that we can intecept
accesses to its instantiations and refcount check it to catch use after
free, etc.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/maps.c | 4 ++--
 tools/perf/util/map.h   | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 1c7293476acad2e5..a6278f9c8b713220 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -30,7 +30,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 			if (map__start(map) != merged[i].start ||
 			    map__end(map) != merged[i].end ||
 			    strcmp(map__dso(map)->name, merged[i].name) ||
-			    refcount_read(&map->refcnt) != 1) {
+			    refcount_read(map__refcnt(map)) != 1) {
 				failed = true;
 			}
 			i++;
@@ -50,7 +50,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 				map__start(map),
 				map__end(map),
 				map__dso(map)->name,
-				refcount_read(&map->refcnt));
+				refcount_read(map__refcnt(map)));
 		}
 	}
 	return failed ? TEST_FAIL : TEST_OK;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 102485699aa8d7c3..f89ab7c2d3277239 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -97,6 +97,11 @@ static inline bool map__priv(const struct map *map)
 	return map->priv;
 }
 
+static inline refcount_t *map__refcnt(struct map *map)
+{
+	return &map->refcnt;
+}
+
 static inline size_t map__size(const struct map *map)
 {
 	return map__end(map) - map__start(map);
-- 
2.39.2

