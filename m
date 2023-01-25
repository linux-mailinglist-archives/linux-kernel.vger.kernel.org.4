Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA167B82E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjAYROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjAYRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935B7A9C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCAACB81B44
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EFCC4339B;
        Wed, 25 Jan 2023 17:13:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKjL8-004Np5-1M;
        Wed, 25 Jan 2023 12:13:38 -0500
Message-ID: <20230125171252.431857411@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 12:12:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: Updates for 6.3
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: dc513fd5321d4c15ac1f820c224b2e5220b6e14f


Jia-Ju Bai (1):
      tracing: Add NULL checks for buffer in ring_buffer_free_read_page()

Mark Rutland (1):
      ftrace: Add sample with custom ops

Steven Rostedt (Google) (10):
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

----
 Documentation/trace/events.rst                     |  12 +
 Documentation/trace/histogram.rst                  | 129 +++++++++++
 include/trace/bpf_probe.h                          |  45 +---
 include/trace/perf.h                               |  46 +---
 include/trace/stages/stage6_event_callback.h       |   3 +
 kernel/trace/ring_buffer.c                         |   7 +-
 kernel/trace/trace.c                               |   2 +-
 kernel/trace/trace.h                               |   4 +
 kernel/trace/trace_events.c                        |   2 +-
 kernel/trace/trace_events_filter.c                 |  93 +++++++-
 kernel/trace/trace_events_hist.c                   |  63 ++++--
 kernel/trace/trace_events_synth.c                  |  83 ++++++-
 kernel/trace/trace_synth.h                         |   1 +
 samples/Kconfig                                    |   7 +
 samples/Makefile                                   |   1 +
 samples/ftrace/Makefile                            |   1 +
 samples/ftrace/ftrace-ops.c                        | 252 +++++++++++++++++++++
 .../ftrace/test.d/filter/event-filter-function.tc  |  58 +++++
 .../inter-event/trigger-synthetic-event-stack.tc   |  24 ++
 .../inter-event/trigger-synthetic-event-syntax.tc  |   6 +
 20 files changed, 729 insertions(+), 110 deletions(-)
 create mode 100644 samples/ftrace/ftrace-ops.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
