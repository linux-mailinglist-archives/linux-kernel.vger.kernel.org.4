Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D606DD174
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjDKFR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDKFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:17:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E605226B6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:17:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f54781eeeso24191547b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681190243;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwWwP6LNOw1HacwMQfACM6w++EBrxPV5YikpqYkABv0=;
        b=MfGlZmeVagcHi9qz+Jz29EdrGWFUYOwRAyvIuZ4I0HUaOwGAcS6vvmgJrJ8Rv4uxFX
         x3SOvEqTOdx74ZxSDW+FGSI800SsAXTTgvodZiY/ncMUTAcyJ1M7m5o8A4uDke+3MgOL
         6LgkLpCGkl7cQF0jfBukWgNwQRpN33YKKICoWT+/TSOHfq5JrVMZslcym8wULONLMpXl
         vv0c1BIFRWvQGOznpTc3aVARZi1Up+fcqepjo5nD7T7pnu/9mJxwpi171JucyanMaLHR
         qe7NmzteTmD12YGZUT6a/Yw3cTBVFixs8xCAN9UtkqdJwfiRnasacMoOfT6ZvoY6Py6m
         Xonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190243;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwWwP6LNOw1HacwMQfACM6w++EBrxPV5YikpqYkABv0=;
        b=B6TlLZsMJ4btFuiQBPvhiId7WPrHNUNOPPRl1ue8JHLrRAoDMtNB+bG7QNXXIsgQWy
         4bHC2fFJcyQmC8ihaFjC4v+QJtsjLO/UFGLfYx0sEf00nWi37Y2ina/n6t/AdszmY2ne
         g+NhtEnGqMnk682egbiawQv7VVE+6MLx4f0f+H2QpNhZot1SUhCHkhLQVvPVNojtSZDe
         Q7Mv+Ca5gkhKJ1P9JdrVPbsOvebQfsKVrUjyqv+IShK1fByas7xaexe0e6SJbEPAHllT
         UKAjdiF7nYc38HgCvUQdPhyYwAZ4zWQ2GabMAXDfMQN525s4DtXjI3sFt+9TbUuPprlP
         +G0Q==
X-Gm-Message-State: AAQBX9eUdcecaP8clQxwM8Un16TUabz+7nrQPz6Xzs9tDlcUtyIU9UL1
        hv+vaDbf3rWnqX9fncocNH5d3YYx8MuN
X-Google-Smtp-Source: AKy350bDIJ/qq7YfeUGoMG9jSw25F5C6++hFZjG9EZPmeNfkqouU5axoyRXX60lPUMSw9wT3zKn5nXLo8Ufy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a25:7486:0:b0:b8b:f02b:ba20 with SMTP id
 p128-20020a257486000000b00b8bf02bba20mr4344367ybc.9.1681190243171; Mon, 10
 Apr 2023 22:17:23 -0700 (PDT)
Date:   Mon, 10 Apr 2023 22:17:18 -0700
Message-Id: <20230411051718.267228-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH] perf bperf: Avoid use after free via union
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bperf sets leader_skel or follower_skel then it appears bpf_skel is
set and can trigger the following use-after-free:

==13575==ERROR: AddressSanitizer: heap-use-after-free on address 0x60c000014080 at pc 0x55684b939880 bp 0x7ffdfcf30d70 sp 0x7ffdfcf30d68
READ of size 8 at 0x60c000014080 thread T0
     #0 0x55684b93987f in sample_filter_bpf__destroy tools/perf/bpf_skel/sample_filter.skel.h:44:11
     #1 0x55684b93987f in perf_bpf_filter__destroy tools/perf/util/bpf-filter.c:155:2
     #2 0x55684b98f71e in evsel__exit tools/perf/util/evsel.c:1521:2
     #3 0x55684b98a352 in evsel__delete tools/perf/util/evsel.c:1547:2
     #4 0x55684b981918 in evlist__purge tools/perf/util/evlist.c:148:3
     #5 0x55684b981918 in evlist__delete tools/perf/util/evlist.c:169:2
     #6 0x55684b887d60 in cmd_stat tools/perf/builtin-stat.c:2598:2
..
0x60c000014080 is located 0 bytes inside of 128-byte region [0x60c000014080,0x60c000014100)
freed by thread T0 here:
     #0 0x55684b780e86 in free compiler-rt/lib/asan/asan_malloc_linux.cpp:52:3
     #1 0x55684b9462da in bperf_cgroup_bpf__destroy tools/perf/bpf_skel/bperf_cgroup.skel.h:61:2
     #2 0x55684b9462da in bperf_cgrp__destroy tools/perf/util/bpf_counter_cgroup.c:282:2
     #3 0x55684b944c75 in bpf_counter__destroy tools/perf/util/bpf_counter.c:819:2
     #4 0x55684b98f716 in evsel__exit tools/perf/util/evsel.c:1520:2
     #5 0x55684b98a352 in evsel__delete tools/perf/util/evsel.c:1547:2
     #6 0x55684b981918 in evlist__purge tools/perf/util/evlist.c:148:3
     #7 0x55684b981918 in evlist__delete tools/perf/util/evlist.c:169:2
     #8 0x55684b887d60 in cmd_stat tools/perf/builtin-stat.c:2598:2
...
previously allocated by thread T0 here:
     #0 0x55684b781338 in calloc compiler-rt/lib/asan/asan_malloc_linux.cpp:77:3
     #1 0x55684b944e25 in bperf_cgroup_bpf__open_opts tools/perf/bpf_skel/bperf_cgroup.skel.h:73:35
     #2 0x55684b944e25 in bperf_cgroup_bpf__open tools/perf/bpf_skel/bperf_cgroup.skel.h:97:9
     #3 0x55684b944e25 in bperf_load_program tools/perf/util/bpf_counter_cgroup.c:55:9
     #4 0x55684b944e25 in bperf_cgrp__load tools/perf/util/bpf_counter_cgroup.c:178:23
     #5 0x55684b889289 in __run_perf_stat tools/perf/builtin-stat.c:713:7
     #6 0x55684b889289 in run_perf_stat tools/perf/builtin-stat.c:949:8
     #7 0x55684b888029 in cmd_stat tools/perf/builtin-stat.c:2537:12

Resolve by clearing bpf_skel as part of bpf_counter__destroy.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index bee3fe0905f6..d9677a51eae1 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -818,4 +818,5 @@ void bpf_counter__destroy(struct evsel *evsel)
 		return;
 	evsel->bpf_counter_ops->destroy(evsel);
 	evsel->bpf_counter_ops = NULL;
+	evsel->bpf_skel = NULL;
 }
-- 
2.40.0.577.gac1e443424-goog

