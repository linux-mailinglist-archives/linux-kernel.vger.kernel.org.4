Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172E26E53DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDQVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDQVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BED46BC;
        Mon, 17 Apr 2023 14:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FBE562A9F;
        Mon, 17 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EE4C433EF;
        Mon, 17 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681767018;
        bh=c9wyqvm7qvjDBra8OeFJcTD+B23bdO0zYToSSBVC3Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XeS5LqpCY6qUIHuj1KCf+aHOKTaDdPhg770tNEVWdf6eMV9qHH21RMyChyUvdbiab
         zsHVEg/rjU0pr6eowt8qtxohgbwu49dIw0JKRb5A72jLRYfG04WtA4aYMm4oYFVSPN
         lIe4we7SsjvnGC5XUFrQUxZFwYmT9qgZYaCwYpiQGmJwKgKnt9UTJ7FZZo72mcwdPw
         K35ygfgXR5kPz9Byu6TFuWJmL3vrXsiQUu6KW3O4MUvJTCAloX9SicgG8EZ8fVHWss
         6Pns+08qZl02eWTkuwJ9JomuEKNc6nig6FmWnptluXztuFzdO2649afH4q8ret/I97
         +KFZs92h5ydqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F38EB403B5; Mon, 17 Apr 2023 18:30:14 -0300 (-03)
Date:   Mon, 17 Apr 2023 18:30:14 -0300
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
Subject: Re: [PATCH v7 3/5] perf namespaces: Add reference count checking
Message-ID: <ZD26ZlqSbgSyH5lX@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407230405.2931830-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 07, 2023 at 04:04:03PM -0700, Ian Rogers escreveu:
> Add reference count checking controlled by REFCNT_CHECKING ifdef. The
> reference count checking interposes an allocated pointer between the
> reference counted struct on a get and frees the pointer on a put.
> Accesses after a put cause faults and use after free, missed puts are
> caughts as leaks and double puts are double frees.
> 
> This checking helped resolve a memory leak and use after free:
> https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c  |   2 +-
>  tools/perf/util/annotate.c   |   2 +-
>  tools/perf/util/dso.c        |   2 +-
>  tools/perf/util/dsos.c       |   2 +-
>  tools/perf/util/namespaces.c | 132 ++++++++++++++++++++---------------
>  tools/perf/util/namespaces.h |   3 +-
>  tools/perf/util/symbol.c     |   2 +-
>  7 files changed, 83 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index fd2b38458a5d..fe6ddcf7fb1e 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -632,7 +632,7 @@ static int dso__read_build_id(struct dso *dso)
>  	else if (dso->nsinfo) {
>  		char *new_name;
>  
> -		new_name = filename_with_chroot(dso->nsinfo->pid,
> +		new_name = filename_with_chroot(RC_CHK_ACCESS(dso->nsinfo)->pid,
>  						dso->long_name);

To reduce these:


From c80478cfc86cf24f6f075576d731d99e0fa8fe4f Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 17 Apr 2023 18:28:01 -0300
Subject: [PATCH 1/1] perf dso: Add dso__filename_with_chroot() to reduce
 number of accesses to dso->nsinfo members

We'll need to reference count dso->nsinfo, so reduce the number of
direct accesses by having a shorter form of obtaining a filename with
a chroot (namespace one).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 4 +---
 tools/perf/util/annotate.c  | 3 +--
 tools/perf/util/dso.c       | 7 ++++++-
 tools/perf/util/dso.h       | 2 ++
 tools/perf/util/dsos.c      | 3 +--
 tools/perf/util/symbol.c    | 3 +--
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 76723ac314b60b80..61766eead4f48e34 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -630,10 +630,8 @@ static int dso__read_build_id(struct dso *dso)
 	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
 		dso->has_build_id = true;
 	else if (dso->nsinfo) {
-		char *new_name;
+		char *new_name = dso__filename_with_chroot(dso, dso->long_name);
 
-		new_name = filename_with_chroot(dso->nsinfo->pid,
-						dso->long_name);
 		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0)
 			dso->has_build_id = true;
 		free(new_name);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e2693a1c28d5989f..ca9f0add68f461e4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1692,8 +1692,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 		mutex_lock(&dso->lock);
 		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
-			char *new_name = filename_with_chroot(dso->nsinfo->pid,
-							      filename);
+			char *new_name = dso__filename_with_chroot(dso, filename);
 			if (new_name) {
 				strlcpy(filename, new_name, filename_size);
 				free(new_name);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e36b418df2c68cc2..0bc288f29a548dc9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -491,6 +491,11 @@ static int do_open(char *name)
 	return -1;
 }
 
+char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
+{
+	return filename_with_chroot(dso->nsinfo->pid, filename);
+}
+
 static int __open_dso(struct dso *dso, struct machine *machine)
 {
 	int fd = -EINVAL;
@@ -515,7 +520,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		if (errno != ENOENT || dso->nsinfo == NULL)
 			goto out;
 
-		new_name = filename_with_chroot(dso->nsinfo->pid, name);
+		new_name = dso__filename_with_chroot(dso, name);
 		if (!new_name)
 			goto out;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 58d94175e7148049..0b7c7633b9f6667d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -266,6 +266,8 @@ static inline bool dso__has_symbols(const struct dso *dso)
 	return !RB_EMPTY_ROOT(&dso->symbols.rb_root);
 }
 
+char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
+
 bool dso__sorted_by_name(const struct dso *dso);
 void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 2bd23e4cf19efaa7..cf80aa42dd07b036 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -91,8 +91,7 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 			have_build_id	  = true;
 			pos->has_build_id = true;
 		} else if (errno == ENOENT && pos->nsinfo) {
-			char *new_name = filename_with_chroot(pos->nsinfo->pid,
-							      pos->long_name);
+			char *new_name = dso__filename_with_chroot(pos, pos->long_name);
 
 			if (new_name && filename__read_build_id(new_name,
 								&pos->bid) > 0) {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 91ebf93e0c20bd24..e7f63670688e8e59 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1963,8 +1963,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 		is_reg = is_regular_file(name);
 		if (!is_reg && errno == ENOENT && dso->nsinfo) {
-			char *new_name = filename_with_chroot(dso->nsinfo->pid,
-							      name);
+			char *new_name = dso__filename_with_chroot(dso, name);
 			if (new_name) {
 				is_reg = is_regular_file(new_name);
 				strlcpy(name, new_name, PATH_MAX);
-- 
2.39.2

