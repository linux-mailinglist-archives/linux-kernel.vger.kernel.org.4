Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9D69D525
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjBTUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBTUpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:45:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F148FC66E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5EC86CE10AC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69FDC433EF;
        Mon, 20 Feb 2023 20:44:33 +0000 (UTC)
Date:   Mon, 20 Feb 2023 15:44:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jianlin Lv <iecedge@gmail.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Song Shuai <suagrfillet@gmail.com>, Tom Rix <trix@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [GIT PULL] tracing: Updates for 6.3
Message-ID: <20230220154432.12eefbf6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing updates for 6.3:

- Add function names as a way to filter function addresses

- Add sample module to test ftrace ops and dynamic trampolines

- Allow stack traces to be passed from beginning event to end event for
  synthetic events. This will allow seeing the stack trace of when a task is
  scheduled out and recorded when it gets scheduled back in.

- Add trace event helper __get_buf() to use as a temporary buffer when printing
  out trace event output.

- Add kernel command line to create trace instances on boot up.

- Add enabling of events to instances created at boot up.

- Add trace_array_puts() to write into instances.

- Allow boot instances to take a snapshot at the end of boot up.

- Allow live patch modules to include trace events

- Minor fixes and clean ups


Please pull the latest trace-v6.3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.3

Tag SHA1: 58d2fb362d449573480ed049e6b9f4b65af8ca0c
Head SHA1: 7568a21e52f60930ba8ae7897c2521bdab3ef5a4


Arnd Bergmann (1):
      ftrace: sample: avoid open-coded 64-bit division

Bagas Sanjaya (1):
      tracing/histogram: Wrap remaining shell snippets in code blocks

Davidlohr Bueso (1):
      tracing/osnoise: No need for schedule_hrtimeout range

Jia-Ju Bai (1):
      tracing: Add NULL checks for buffer in ring_buffer_free_read_page()

Jianlin Lv (1):
      tracepoint: Allow livepatch module add trace event

Linyu Yuan (1):
      tracing: Acquire buffer from temparary trace sequence

Mark Rutland (1):
      ftrace: Add sample with custom ops

Ross Zwisler (1):
      tracing: Always use canonical ftrace path

Song Shuai (1):
      samples: ftrace: Include the nospec-branch.h only for x86

Steven Rostedt (Google) (16):
      tracing: Add a way to filter function addresses to function names
      tracing/selftests: Add test for event filtering on function name
      tracing: Simplify calculating entry size using struct_size()
      tracing: Allow stacktraces to be saved as histogram variables
      tracing: Allow synthetic events to pass around stacktraces
      tracing/histogram: Add stacktrace type
      tracing/histogram: Document variable stacktrace
      tracing/histogram: Add simple tests for stacktrace usage of synthetic events
      perf/tracing: Use stage6 of tracing to not duplicate macros
      bpf/tracing: Use stage6 of tracing to not duplicate macros
      tracing: Fix trace_event_raw_event_synth() if else statement
      tracing: Add creation of instances at boot command line
      tracing: Add enabling of events to boot instances
      tracing: Add trace_array_puts() to write into instance
      tracing: Allow boot instances to have snapshot buffers
      tracing: Add BUILD_BUG() to make sure stacktrace fits in strings

Tom Rix (1):
      samples: ftrace: Make some global variables static

Tom Zanussi (4):
      tracing/histogram: Don't use strlen to find length of stacktrace variables
      tracing/histogram: Fix a few problems with stacktrace variable printing
      tracing/histogram: Fix stacktrace key
      tracing/histogram: Fix stacktrace histogram Documententation

Wang ShaoBo (1):
      tracing: Remove unnecessary NULL assignment

----
 Documentation/admin-guide/kernel-parameters.txt    |  29 +++
 Documentation/trace/events.rst                     |  12 +
 Documentation/trace/histogram.rst                  | 242 ++++++++++++++++----
 include/linux/kernel.h                             |   2 +-
 include/linux/trace.h                              |  12 +
 include/linux/trace_seq.h                          |   5 +
 include/linux/tracepoint.h                         |   4 +-
 include/trace/bpf_probe.h                          |  45 +---
 include/trace/perf.h                               |  46 +---
 include/trace/stages/stage3_trace_output.h         |   3 +
 include/trace/stages/stage6_event_callback.h       |   3 +
 include/trace/stages/stage7_class_define.h         |   1 +
 kernel/trace/Kconfig                               |  20 +-
 kernel/trace/kprobe_event_gen_test.c               |   2 +-
 kernel/trace/ring_buffer.c                         |   9 +-
 kernel/trace/synth_event_gen_test.c                |   2 +-
 kernel/trace/trace.c                               | 164 ++++++++++++--
 kernel/trace/trace.h                               |   6 +
 kernel/trace/trace_events.c                        |  13 +-
 kernel/trace/trace_events_filter.c                 |  93 +++++++-
 kernel/trace/trace_events_hist.c                   | 126 +++++++++--
 kernel/trace/trace_events_synth.c                  |  90 +++++++-
 kernel/trace/trace_osnoise.c                       |   2 +-
 kernel/trace/trace_seq.c                           |  23 ++
 kernel/trace/trace_synth.h                         |   1 +
 kernel/tracepoint.c                                |   4 +-
 samples/Kconfig                                    |   7 +
 samples/Makefile                                   |   1 +
 samples/ftrace/Makefile                            |   1 +
 samples/ftrace/ftrace-direct-modify.c              |   2 +-
 samples/ftrace/ftrace-direct-multi-modify.c        |   2 +-
 samples/ftrace/ftrace-direct-multi.c               |   2 +-
 samples/ftrace/ftrace-direct-too.c                 |   2 +-
 samples/ftrace/ftrace-direct.c                     |   2 +-
 samples/ftrace/ftrace-ops.c                        | 252 +++++++++++++++++++++
 samples/user_events/example.c                      |   4 +-
 scripts/tracing/draw_functrace.py                  |   6 +-
 tools/lib/api/fs/tracing_path.c                    |   4 +-
 .../ftrace/test.d/filter/event-filter-function.tc  |  58 +++++
 .../inter-event/trigger-synthetic-event-stack.tc   |  24 ++
 .../inter-event/trigger-synthetic-event-syntax.tc  |   6 +
 tools/tracing/latency/latency-collector.c          |   2 +-
 42 files changed, 1113 insertions(+), 221 deletions(-)
 create mode 100644 samples/ftrace/ftrace-ops.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
---------------------------
