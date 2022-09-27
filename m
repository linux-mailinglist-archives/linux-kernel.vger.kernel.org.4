Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3B5EC8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiI0QBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiI0QBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D6BD4A81
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8494661A55
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5D6C433C1;
        Tue, 27 Sep 2022 16:01:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2f-00G2mz-0P;
        Tue, 27 Sep 2022 12:02:41 -0400
Message-ID: <20220927160216.349640304@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 00/20] tracing: Update for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 45f491cd66689431f822a1d7a1137f0fc9155cfb


Chen Zhongjin (1):
      x86: kprobes: Remove unused macro stack_addr

Gaosheng Cui (3):
      x86/ftrace: Remove unused modifying_ftrace_code declaration
      x86/kprobes: Remove unused arch_kprobe_override_function() declaration
      ftrace: Remove obsoleted code from ftrace and task_struct

Masami Hiramatsu (Google) (2):
      tracing/eprobe: Add eprobe filter support
      selftests/ftrace: Add eprobe syntax error testcase

Nico Pache (1):
      tracing/osnoise: Fix possible recursive locking in stop_per_cpu_kthreads

Steven Rostedt (Google) (4):
      tracing: Add numeric delta time to the trace event benchmark
      tracing/hist: Call hist functions directly via a switch statement
      tracing: Move struct filter_pred into trace_events_filter.c
      tracing/filter: Call filter predicate functions directly via a switch statement

Tao Chen (1):
      tracing/eprobe: Fix alloc event dir failed when event name no set

Waiman Long (1):
      tracing: Disable interrupt or preemption before acquiring arch_spinlock_t

Xiu Jianfeng (1):
      rv/monitor: Add __init/__exit annotations to module init/exit funcs

Yipeng Zou (2):
      tracing: kprobe: Fix kprobe event gen test module on exit
      tracing: kprobe: Make gen test module work in arm and riscv

Zeng Heng (2):
      rv/monitors: add 'static' qualifier for local symbols
      rv/dot2K: add 'static' qualifier for local variable

Zhen Lei (1):
      tracepoint: Optimize the critical region of mutex_lock in tracepoint_module_coming()

Zheng Yejian (1):
      ftrace: Properly unset FTRACE_HASH_FL_MOD

----
 arch/x86/include/asm/ftrace.h                      |   1 -
 arch/x86/include/asm/kprobes.h                     |   2 -
 arch/x86/kernel/kprobes/core.c                     |   2 -
 include/linux/ftrace.h                             |  41 ----
 include/linux/sched.h                              |   3 -
 kernel/trace/ftrace.c                              |   8 +-
 kernel/trace/kprobe_event_gen_test.c               |  49 +++-
 kernel/trace/rv/monitors/wip/wip.c                 |   8 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c               |   8 +-
 kernel/trace/trace.c                               |  23 ++
 kernel/trace/trace.h                               |  13 --
 kernel/trace/trace_benchmark.c                     |   2 +-
 kernel/trace/trace_benchmark.h                     |   8 +-
 kernel/trace/trace_eprobe.c                        | 107 ++++++++-
 kernel/trace/trace_events_filter.c                 | 239 ++++++++++++++------
 kernel/trace/trace_events_hist.c                   | 246 ++++++++++++++-------
 kernel/trace/trace_osnoise.c                       |   3 +-
 kernel/trace/trace_probe.h                         |   3 +-
 kernel/tracepoint.c                                |  14 +-
 .../test.d/dynevent/eprobes_syntax_errors.tc       |  27 +++
 .../dot2/dot2k_templates/main_global.c             |   8 +-
 .../dot2/dot2k_templates/main_per_cpu.c            |   8 +-
 .../dot2/dot2k_templates/main_per_task.c           |   8 +-
 23 files changed, 570 insertions(+), 261 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
