Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB262E8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiKQWuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiKQWuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:50:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65965E42
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:50:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-385bbf9bc8fso32725427b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mkE/jseB+mAvo5T0KGdJHv7G0FFmlGhJP5kFwdKFknc=;
        b=krp3Im7u4EE7ngh31O+puMO6xpuQb6aLCoGwbJ92YvbTje/EkifY+4TQxfmoaMaWlD
         xB4GmxVxsMYdX7TmLoELM6RpFweoK/aHDX73QOMeCH6FWJRp86y3ESmCTd24lEUefJ1W
         RbCozF+hPP+mKzQg/Qdh1QgjiH3XsXcxoNYGHSgOBpBmSxCxgklhGoahKdGFXBbouky8
         afcvPi1w/ydB6NGfQEzU4/tQRMoHf0pLEVC5BzN+jvIVM6BmFVPDM1Evfn78Z3Ay2wdQ
         6PwlCL/Y6pPS7voC1EbY5ODfg4fByTRSBVVwEM0hdmk/57PrGd/kLjHxJMqeRt+IWEql
         4ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkE/jseB+mAvo5T0KGdJHv7G0FFmlGhJP5kFwdKFknc=;
        b=7AdTewgJyYGYuEVfhNQbpHL1fiWvO2MuShIQNqaVI/Mp6IqCy5k5mDtsj+1JSvRGN6
         PYRWPBpaT8CmWTgEvTnsl+aje1bbtFgbrlycQIACGv4IeMLehFB5scB/+flmak9t942j
         alfl1Yb4PE21HVsI91D8G9shT44rwzdCs9eTFHQ+QF6Lqcyjz+s+pEyNVwCC0FOxWtQk
         3XBFfFJqCkcBQrmqQO7rTrYAMCJ7xpKaapeJ8YdxZSpRpopgOT3LenVB01yzjrTWv+EM
         itfeyh8ZXImkRSd6BYTfIv0PrxnhJ4/+SQ4qSHwc/Ohw+4DqX2g0dX/4NtGugA0YuZtU
         0vUw==
X-Gm-Message-State: ANoB5pnGz/ktC5/Yyow3LRIA4gxlNVcNtEIw+PR6s3fpuT4e+4NoxN4H
        bAjqiXo0gPb63n7hLer2l2U+9ZII7lP3
X-Google-Smtp-Source: AA0mqf7F7zom9i8xWEHIkUNYblobZwQJwp6/9AAJa/Rg8XPgD+B+ulVRzOK1PPLEBUzlvlpnsTtejtxb39SG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a25:ca56:0:b0:6c9:9c1a:e8c with SMTP id
 a83-20020a25ca56000000b006c99c1a0e8cmr4059860ybg.620.1668725405037; Thu, 17
 Nov 2022 14:50:05 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:49:50 -0800
Message-Id: <20221117224952.358639-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v1 0/2] perf always use system libtraceevent
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force the perf build to use the previously optional non-default
LIBTRACEEVENT_DYNAMIC, ie the system libtraceevent. With nothing using
the now out-of-date tools/lib/traceevent remove it.

Discussed on LKML here:
https://lore.kernel.org/lkml/CAP-5=fWxAjEia-Qbm0RVzKOxyiod8rUOBieqaGK=DtQboDe3Qw@mail.gmail.com/

Builds upon:
https://lore.kernel.org/lkml/20221116224631.207631-1-irogers@google.com/

Ian Rogers (2):
  perf build: Require libtraceevent from the system
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
 tools/perf/Makefile.config                    |   51 +-
 tools/perf/Makefile.perf                      |   95 +-
 71 files changed, 28 insertions(+), 19993 deletions(-)
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

