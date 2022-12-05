Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14286438D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiLEXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiLEXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04A1DF03
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:00:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 203-20020a2502d4000000b006f94ab02400so13767560ybc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPB6mm4TgvEyyws63dJDbYxmtsHoaTSfd5QqDu3w1uI=;
        b=C5FPbwTLLReGGev2zyGrS3uZzYugF2818QQO5J2fo7XbqJivZvrYJ1P0C4lI3kcFuS
         VTlWaNs8ff9Qlv8WKub2nhSjxD/H4BjEO2XZwD89hbBjnoXcXJ6FjyzePLKJEyqTC+zr
         w54vIcSMfJ+XEXh0zTDrJsPXwabmzhoVnDlFd0VlpqeZdmpLKKjjON63et08uSV8rbCB
         qflhvqcsPF7S1uuAjx+D8+91UcT1mXEhvBaJH3bBfQQjRHMysOWYnw5CH1cwZSO9pkDk
         1rpS+C+TGN5n9qJNrFqJaE58+HkgF+BSNIh7tCT4Mbpi4WJGjhxQ9++mXCaSILOh4v+H
         sHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPB6mm4TgvEyyws63dJDbYxmtsHoaTSfd5QqDu3w1uI=;
        b=f25s1h4Kj1WNSfwaZKgjCkafOruP6n/S3CzWypxFK2dquku8O7++HVoYNOoAi9fchZ
         LAPW15u0NlajZDqyzEV74qrzj0ZZmaQ3XY4E4/BcyKn9g18/xDMm4QfKB0U7Uf0kXujt
         K2r35/qfhLwAjuqaKtu/BybeFLZYz+Gru5IRGig1plxUI/1Vebh2Nw+sd9EvwH4H0G0K
         Jf8uYz4uJ2fNble/UNNDfawkfp1e7HUWuo4U7uQEwsgMmHi1iUWyzmJTGyf8K14x4oYG
         Y5ZqEB7rfkTRP/4+sMpnqxLzhsvYIImYLu45rC+bJtqY0F0HrWKaoQLYafkrHx6Bfzxb
         IDeg==
X-Gm-Message-State: ANoB5pnTb+DrLfW+qZbNQSl6ze6b0tquOHwUYXM9WhzAHDMWshP2GsZT
        7GyRAGeU42JBpB8eva1KAAzLgtCjW5X7
X-Google-Smtp-Source: AA0mqf4/gStV2U+rF772WtObJJ72RvjxENibVb8G0GIypnoa3fG7AnxxhXmYWAKy2OxVypqvXmUdDsH+y/ul
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d2ab:5fbb:e81a:9151])
 (user=irogers job=sendgmr) by 2002:a25:9a43:0:b0:6cb:8f05:b35c with SMTP id
 r3-20020a259a43000000b006cb8f05b35cmr64275847ybo.217.1670281216121; Mon, 05
 Dec 2022 15:00:16 -0800 (PST)
Date:   Mon,  5 Dec 2022 14:59:37 -0800
Message-Id: <20221205225940.3079667-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 0/3] libtraceevent from system and build fix
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A combination of patches previously sent here:
https://lore.kernel.org/all/20221130062935.2219247-1-irogers@google.com/
https://lore.kernel.org/all/20221202045743.2639466-6-irogers@google.com/
and rebased on acme/tmp.perf/core. A fix is added to "perf build:
Fixes for LIBTRACEEVENT_DYNAMIC" for the case where install is invoked
without a DESTDIR.

Ian Rogers (3):
  perf build: Fixes for LIBTRACEEVENT_DYNAMIC
  perf build: Use libtraceevent from the system
  perf build: Fix python/perf.so library's name

 tools/perf/Build                              | 11 ++-
 tools/perf/Makefile.config                    | 41 ++++----
 tools/perf/Makefile.perf                      | 97 ++-----------------
 tools/perf/arch/x86/util/Build                |  2 +-
 tools/perf/arch/x86/util/intel-pt.c           |  4 +
 tools/perf/builtin-annotate.c                 |  2 +
 tools/perf/builtin-inject.c                   |  8 ++
 tools/perf/builtin-kmem.c                     |  1 +
 tools/perf/builtin-kvm.c                      | 12 +--
 tools/perf/builtin-kwork.c                    |  1 +
 tools/perf/builtin-record.c                   |  2 +
 tools/perf/builtin-report.c                   |  9 +-
 tools/perf/builtin-script.c                   | 19 +++-
 tools/perf/builtin-timechart.c                |  1 +
 tools/perf/builtin-trace.c                    |  5 +-
 tools/perf/builtin-version.c                  |  1 +
 tools/perf/perf.c                             | 24 +++--
 .../perf/scripts/python/Perf-Trace-Util/Build |  2 +-
 tools/perf/tests/Build                        | 12 +--
 tools/perf/tests/builtin-test.c               |  6 ++
 tools/perf/tests/parse-events.c               | 20 ++++
 tools/perf/util/Build                         | 10 +-
 tools/perf/util/data-convert-bt.c             |  5 +-
 tools/perf/util/data-convert-json.c           |  9 +-
 tools/perf/util/evlist.c                      |  6 +-
 tools/perf/util/evlist.h                      |  4 +
 tools/perf/util/evsel.c                       | 11 ++-
 tools/perf/util/evsel.h                       | 12 ++-
 tools/perf/util/evsel_fprintf.c               |  7 +-
 tools/perf/util/header.c                      | 19 ++++
 tools/perf/util/header.h                      |  2 +
 tools/perf/util/intel-pt.c                    |  7 +-
 tools/perf/util/parse-events.c                | 15 +++
 tools/perf/util/parse-events.h                |  1 -
 tools/perf/util/python.c                      |  4 +
 tools/perf/util/scripting-engines/Build       |  6 +-
 .../scripting-engines/trace-event-python.c    |  1 +
 tools/perf/util/session.c                     |  2 +
 tools/perf/util/session.h                     |  2 +
 tools/perf/util/sort.c                        | 60 ++++++++++--
 tools/perf/util/synthetic-events.c            |  6 ++
 tools/perf/util/trace-event-parse.c           |  2 +
 tools/perf/util/trace-event-read.c            |  1 +
 tools/perf/util/trace-event-scripting.c       |  1 +
 tools/perf/util/trace-event.c                 |  1 -
 tools/perf/util/trace-event.h                 | 11 ++-
 46 files changed, 316 insertions(+), 169 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

