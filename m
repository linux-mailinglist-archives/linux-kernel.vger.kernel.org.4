Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96663CF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiK3G3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiK3G3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:29:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B51E720
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:29:46 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3ceb4c331faso45959617b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eUHyVliKjk6E4L3Mp8lrO/R0wPtbiqqoWIvdgha/83w=;
        b=IUFhznSFg/YWVHruqFXEx9mN+nUFOFRK2VMjAsJ82DHNc3x9ndU0ZmeeDqpsJDlQLL
         zw7T2iY3jZ5nR+tKfRpSkq01xR++qq7Y64wMetqV3wyvw6bMUw9IMxgoQbXVY7bD8C39
         qR1Hyo2d04eicNFPF3YkfMmhYk0Nibd/Y/KuE1I7DcigvUXX9DuprbFBvAmsBQmbF60e
         Mr9+1G6EUX/mVWN9vXQnkG/dsg7ky/RqQKtoU7w1KPJlnXIo2lk72IhCxn3nkVK6LiP2
         APZRj5rVwhwS7xNciDZCNm2YSmYACtdyDNeICm63N1wdUkYVkdjDeDtR3oC4VHOgwPLD
         kPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUHyVliKjk6E4L3Mp8lrO/R0wPtbiqqoWIvdgha/83w=;
        b=CcX67Q5aWaMCMlppQ43VCiU+Mxre1YM25C5OyPvRLtclQQfnvl+DQVx//8SHnt3Cc0
         b5ik3fc/4gPjrlFKZROMkpchYihEPV/IbCVNAbMJtFEB/ChrEDmlJJfh2Lpq7e/f05g7
         m4X4A/Z9EYjw6C+aaVaRtDUsONiff2iwtegvq6eM32D9fAXNCAAuU4AqQwANixP12h7D
         jEkaXBzBLIik2kQxXNIJ6dEPzXclyJ8P9AjIoLy7DWqnYmUaOs3IYQ7EhMLTaSbFMcRg
         wUCCxrxu+E5Sre5vEoDSrOaqLopIjnqvuWHzTbGDOMiiPET2pSGeB+8oYsMcFQietOUp
         dPZw==
X-Gm-Message-State: ANoB5pmH4IIij8djs+y4HcRTxlvVJTBGALBdR9pTTKDE51pAFt5pZ63x
        LQpx3aXcWQN+8dLhkt/jJdnYCTaNEhDM
X-Google-Smtp-Source: AA0mqf6lLgcujZVvEK0aBOKCAjQ5A2049KaaDtdc6B10iTKGiTQMrLQR/a8qtLRq112hKs29lRpgSlfV9UJr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:788c:ccf4:3670:3362])
 (user=irogers job=sendgmr) by 2002:a05:6902:143:b0:6d4:e3fe:8294 with SMTP id
 p3-20020a056902014300b006d4e3fe8294mr41396420ybh.461.1669789785706; Tue, 29
 Nov 2022 22:29:45 -0800 (PST)
Date:   Tue, 29 Nov 2022 22:29:31 -0800
Message-Id: <20221130062935.2219247-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 0/4] perf use system libtraceevent
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Detect whether libtraceevent is installed and if so build against
it. If not installed, warn and build a subset of perf that works
without libtraceevent. With nothing using the now out-of-date
tools/lib/traceevent remove it.

Discussed on LKML here:
https://lore.kernel.org/lkml/CAP-5=fWxAjEia-Qbm0RVzKOxyiod8rUOBieqaGK=DtQboDe3Qw@mail.gmail.com/

Builds upon:
https://lore.kernel.org/lkml/20221116224631.207631-1-irogers@google.com/

Based on discussion of the v1 patch set:
https://lore.kernel.org/lkml/20221117224952.358639-1-irogers@google.com/
v2 conditionally compiles a subset of perf that doesn't require
libtraceevent to avoid having to have libtraceevent installed on a
system.

The changes build upon the fix in:
https://lore.kernel.org/lkml/20221129192924.1580537-1-irogers@google.com/

Ian Rogers (4):
  perf util: Make header guard consistent with tool
  perf util: Add host_is_bigendian to util.h
  perf build: Use libtraceevent from the system
  tools lib traceevent: Remove libtraceevent

 tools/lib/traceevent/.gitignore               |    4 -
 tools/lib/traceevent/Build                    |    8 -
 tools/lib/traceevent/Documentation/Makefile   |  207 -
 .../traceevent/Documentation/asciidoc.conf    |  120 -
 .../Documentation/libtraceevent-commands.txt  |  153 -
 .../Documentation/libtraceevent-cpus.txt      |   77 -
 .../libtraceevent-endian_read.txt             |   78 -
 .../libtraceevent-event_find.txt              |  103 -
 .../Documentation/libtraceevent-event_get.txt |   99 -
 .../libtraceevent-event_list.txt              |  122 -
 .../libtraceevent-event_print.txt             |  130 -
 .../libtraceevent-field_find.txt              |  118 -
 .../libtraceevent-field_get_val.txt           |  122 -
 .../libtraceevent-field_print.txt             |  126 -
 .../libtraceevent-field_read.txt              |   81 -
 .../Documentation/libtraceevent-fields.txt    |  105 -
 .../libtraceevent-file_endian.txt             |   91 -
 .../Documentation/libtraceevent-filter.txt    |  209 -
 .../Documentation/libtraceevent-func_apis.txt |  183 -
 .../Documentation/libtraceevent-func_find.txt |   88 -
 .../Documentation/libtraceevent-handle.txt    |  101 -
 .../libtraceevent-header_page.txt             |  102 -
 .../libtraceevent-host_endian.txt             |  104 -
 .../Documentation/libtraceevent-long_size.txt |   78 -
 .../Documentation/libtraceevent-page_size.txt |   82 -
 .../libtraceevent-parse_event.txt             |   90 -
 .../libtraceevent-parse_head.txt              |   82 -
 .../Documentation/libtraceevent-plugins.txt   |  122 -
 .../libtraceevent-record_parse.txt            |  137 -
 .../libtraceevent-reg_event_handler.txt       |  156 -
 .../libtraceevent-reg_print_func.txt          |  155 -
 .../Documentation/libtraceevent-set_flag.txt  |  104 -
 .../Documentation/libtraceevent-strerror.txt  |   85 -
 .../Documentation/libtraceevent-tseq.txt      |  158 -
 .../Documentation/libtraceevent.txt           |  192 -
 .../traceevent/Documentation/manpage-1.72.xsl |   14 -
 .../traceevent/Documentation/manpage-base.xsl |   35 -
 .../Documentation/manpage-bold-literal.xsl    |   17 -
 .../Documentation/manpage-normal.xsl          |   13 -
 .../Documentation/manpage-suppress-sp.xsl     |   21 -
 tools/lib/traceevent/Makefile                 |  300 -
 tools/lib/traceevent/event-parse-api.c        |  333 -
 tools/lib/traceevent/event-parse-local.h      |  123 -
 tools/lib/traceevent/event-parse.c            | 7624 -----------------
 tools/lib/traceevent/event-parse.h            |  750 --
 tools/lib/traceevent/event-plugin.c           |  711 --
 tools/lib/traceevent/event-utils.h            |   67 -
 tools/lib/traceevent/kbuffer-parse.c          |  809 --
 tools/lib/traceevent/kbuffer.h                |   68 -
 .../lib/traceevent/libtraceevent.pc.template  |   10 -
 tools/lib/traceevent/parse-filter.c           | 2281 -----
 tools/lib/traceevent/parse-utils.c            |   71 -
 tools/lib/traceevent/plugins/Build            |   12 -
 tools/lib/traceevent/plugins/Makefile         |  225 -
 .../lib/traceevent/plugins/plugin_cfg80211.c  |   43 -
 .../lib/traceevent/plugins/plugin_function.c  |  282 -
 tools/lib/traceevent/plugins/plugin_futex.c   |  123 -
 tools/lib/traceevent/plugins/plugin_hrtimer.c |   74 -
 tools/lib/traceevent/plugins/plugin_jbd2.c    |   61 -
 tools/lib/traceevent/plugins/plugin_kmem.c    |   80 -
 tools/lib/traceevent/plugins/plugin_kvm.c     |  527 --
 .../lib/traceevent/plugins/plugin_mac80211.c  |   88 -
 .../traceevent/plugins/plugin_sched_switch.c  |  146 -
 tools/lib/traceevent/plugins/plugin_scsi.c    |  434 -
 tools/lib/traceevent/plugins/plugin_tlb.c     |   66 -
 tools/lib/traceevent/plugins/plugin_xen.c     |  138 -
 tools/lib/traceevent/tep_strerror.c           |   53 -
 tools/lib/traceevent/trace-seq.c              |  249 -
 tools/lib/traceevent/trace-seq.h              |   55 -
 tools/perf/Build                              |   11 +-
 tools/perf/Makefile.config                    |   37 +-
 tools/perf/Makefile.perf                      |   99 +-
 tools/perf/arch/x86/util/Build                |    2 +-
 tools/perf/arch/x86/util/intel-pt.c           |    4 +
 tools/perf/builtin-annotate.c                 |    2 +
 tools/perf/builtin-inject.c                   |    8 +
 tools/perf/builtin-kmem.c                     |    1 +
 tools/perf/builtin-kvm.c                      |   12 +-
 tools/perf/builtin-kwork.c                    |    1 +
 tools/perf/builtin-record.c                   |    2 +
 tools/perf/builtin-report.c                   |    9 +-
 tools/perf/builtin-script.c                   |   19 +-
 tools/perf/builtin-timechart.c                |    1 +
 tools/perf/builtin-trace.c                    |    5 +-
 tools/perf/builtin-version.c                  |    1 +
 tools/perf/perf.c                             |   24 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |    2 +-
 tools/perf/tests/Build                        |   12 +-
 tools/perf/tests/builtin-test.c               |    6 +
 tools/perf/tests/code-reading.c               |    4 +-
 tools/perf/tests/parse-events.c               |   20 +
 tools/perf/tests/sample-parsing.c             |    4 +-
 tools/perf/util/Build                         |   10 +-
 tools/perf/util/data-convert-bt.c             |    5 +-
 tools/perf/util/data-convert-json.c           |    9 +-
 tools/perf/util/evlist.c                      |    6 +-
 tools/perf/util/evlist.h                      |    4 +
 tools/perf/util/evsel.c                       |   16 +-
 tools/perf/util/evsel.h                       |   12 +-
 tools/perf/util/evsel_fprintf.c               |    7 +-
 tools/perf/util/header.c                      |   19 +
 tools/perf/util/header.h                      |    2 +
 tools/perf/util/intel-pt.c                    |    7 +-
 tools/perf/util/parse-events.c                |   15 +
 tools/perf/util/parse-events.h                |    1 -
 tools/perf/util/python.c                      |    4 +
 tools/perf/util/scripting-engines/Build       |    6 +-
 .../scripting-engines/trace-event-python.c    |    1 +
 tools/perf/util/session.c                     |    2 +
 tools/perf/util/session.h                     |    2 +
 tools/perf/util/sort.c                        |   60 +-
 tools/perf/util/synthetic-events.c            |    6 +
 tools/perf/util/trace-event-info.c            |   14 +-
 tools/perf/util/trace-event-parse.c           |    2 +
 tools/perf/util/trace-event-read.c            |    4 +-
 tools/perf/util/trace-event-scripting.c       |    1 +
 tools/perf/util/trace-event.c                 |    1 -
 tools/perf/util/trace-event.h                 |   13 +-
 tools/perf/util/util.h                        |   25 +-
 119 files changed, 344 insertions(+), 20071 deletions(-)
 delete mode 100644 tools/lib/traceevent/.gitignore
 delete mode 100644 tools/lib/traceevent/Build
 delete mode 100644 tools/lib/traceevent/Documentation/Makefile
 delete mode 100644 tools/lib/traceevent/Documentation/asciidoc.conf
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-commands.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-fields.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-filter.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-handle.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent.txt
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-1.72.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-base.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-normal.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
 delete mode 100644 tools/lib/traceevent/Makefile
 delete mode 100644 tools/lib/traceevent/event-parse-api.c
 delete mode 100644 tools/lib/traceevent/event-parse-local.h
 delete mode 100644 tools/lib/traceevent/event-parse.c
 delete mode 100644 tools/lib/traceevent/event-parse.h
 delete mode 100644 tools/lib/traceevent/event-plugin.c
 delete mode 100644 tools/lib/traceevent/event-utils.h
 delete mode 100644 tools/lib/traceevent/kbuffer-parse.c
 delete mode 100644 tools/lib/traceevent/kbuffer.h
 delete mode 100644 tools/lib/traceevent/libtraceevent.pc.template
 delete mode 100644 tools/lib/traceevent/parse-filter.c
 delete mode 100644 tools/lib/traceevent/parse-utils.c
 delete mode 100644 tools/lib/traceevent/plugins/Build
 delete mode 100644 tools/lib/traceevent/plugins/Makefile
 delete mode 100644 tools/lib/traceevent/plugins/plugin_cfg80211.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_function.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_futex.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_hrtimer.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_jbd2.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_kmem.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_kvm.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_mac80211.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_sched_switch.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_scsi.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_tlb.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_xen.c
 delete mode 100644 tools/lib/traceevent/tep_strerror.c
 delete mode 100644 tools/lib/traceevent/trace-seq.c
 delete mode 100644 tools/lib/traceevent/trace-seq.h

-- 
2.38.1.584.g0f3c55d4c2-goog

