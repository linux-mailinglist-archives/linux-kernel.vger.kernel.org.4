Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ED86DCC65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDJU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDJU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:57:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92338E6C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:57:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f1ffb8ccfso36988727b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681160231;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eWdwxWRwdg0pvB9ya1oVsLyAMFn35+DKvPw/ISvipM=;
        b=ZqJzO2zcgNvKdJ658OAIGgujk2jwAYaX9I03DWcsK7WA+948tTBUhncTeCKkbM7J7E
         /4r1DVTjHX028we0aKeCP+A7+ylhO9pPHYAsX0gSf/ySRxdrU+g4pi+ywSH1B2n1aCLi
         3uDlY2TlA0eXiiA0CE+YXZtF10eFjvctTv1OwhiM7FYE61/zU06hjeMH764s3SAbN6+w
         J38ua8rW5sX/+Ah5Fgb0A4OXFk2CoOHS2SpBKlFZxcGj2jjlqBBz9lj7w3otZA0mfVd5
         BKNg6xcuCfBlWA7GRkv+sLhyFJL55bsWqJSfHBbje2Plb26q9xNL44II/L9p6QImNn+E
         g1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160232;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eWdwxWRwdg0pvB9ya1oVsLyAMFn35+DKvPw/ISvipM=;
        b=fT0AN4KUPDoqLR480FsQ3CClmQuVF40bzotreOLoCqJUtIOJO/Kl50B/jzjc+QYAsL
         8CbWZfhQ4AvEyubQZ3NQ/t5qFkVLerdcYS1YLNuaaJw2O7kF7BQPphw9ygGl2T//zFCe
         QqD0IkHCtQ170LWXrdWXwP5otIS41h7azwMC3Uc5xuWeSYXBQ2bGTBrGQS3iCZeJOBBa
         CfjfHRYjalXHrkf/vYup65l/OEqWTL3NjEI2j9PwggvxRAaF6dsES6Ex3bp4oY/3GD6h
         2JerDpy3t6T5YWGVIV9IRXmxs/28Kk34wQA4fx626CgWTPDwb2V/YRmm7FUnjIWRWZ1+
         hciQ==
X-Gm-Message-State: AAQBX9fwbk/o4fuWCBRFmV1kt9LBH7keOH2ie9QRdiMeQNzptSj47J/X
        fRo8ulBl9n0Y8lc1fPB/2xgVDy+icq3y
X-Google-Smtp-Source: AKy350Yhn2aHlm6QXiur02De6NeXu8XVPTzikkL9VweYciL94aEaHYwHofbx50eIZ/EYPXm8Yrrur2nK9KL9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a0d:ec50:0:b0:54d:913b:c9e8 with SMTP id
 r16-20020a0dec50000000b0054d913bc9e8mr4548477ywn.5.1681160231741; Mon, 10 Apr
 2023 13:57:11 -0700 (PDT)
Date:   Mon, 10 Apr 2023 13:56:59 -0700
Message-Id: <20230410205659.3131608-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1] perf evsel: Avoid segv if delete is called on NULL
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
        Kan Liang <kan.liang@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Seen in "perf stat --bpf-counters --for-each-cgroup test" running in a
container:

libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
libbpf: failed to load object 'bperf_cgroup_bpf'
libbpf: failed to load BPF skeleton 'bperf_cgroup_bpf': -1
Failed to load cgroup skeleton

    #0 0x55f28a650981 in list_empty tools/include/linux/list.h:189
    #1 0x55f28a6593b4 in evsel__exit util/evsel.c:1518
    #2 0x55f28a6596af in evsel__delete util/evsel.c:1544
    #3 0x55f28a89d166 in bperf_cgrp__destroy util/bpf_counter_cgroup.c:283
    #4 0x55f28a899e9a in bpf_counter__destroy util/bpf_counter.c:816
    #5 0x55f28a659455 in evsel__exit util/evsel.c:1520
    #6 0x55f28a6596af in evsel__delete util/evsel.c:1544
    #7 0x55f28a640d4d in evlist__purge util/evlist.c:148
    #8 0x55f28a640ea6 in evlist__delete util/evlist.c:169
    #9 0x55f28a4efbf2 in cmd_stat tools/perf/builtin-stat.c:2598
    #10 0x55f28a6050c2 in run_builtin tools/perf/perf.c:330
    #11 0x55f28a605633 in handle_internal_command tools/perf/perf.c:384
    #12 0x55f28a6059fb in run_argv tools/perf/perf.c:428
    #13 0x55f28a6061d3 in main tools/perf/perf.c:562

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dc3faf005c3b..fe3ce765a4f3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1541,6 +1541,9 @@ void evsel__exit(struct evsel *evsel)
 
 void evsel__delete(struct evsel *evsel)
 {
+	if (!evsel)
+		return;
+
 	evsel__exit(evsel);
 	free(evsel);
 }
-- 
2.40.0.577.gac1e443424-goog

