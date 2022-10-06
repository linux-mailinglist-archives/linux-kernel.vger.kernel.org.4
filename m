Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2345F6ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJFPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiJFPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8E513FB0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D0F5619D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3922C433D6;
        Thu,  6 Oct 2022 15:40:23 +0000 (UTC)
Date:   Thu, 6 Oct 2022 11:40:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Nico Pache <npache@redhat.com>, Song Liu <song@kernel.org>,
        Tao Chen <chentao.kernel@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Updates for 6.1
Message-ID: <20221006114029.310e80a6@gandalf.local.home>
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

Note the first two major changes. This is the first pull request from the
new location at:

   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

Masami Hiramatsu will also be co-maintainer and may be sending pull
requests to you in the future. We will start breaking this up in topic
branches, and this will likely be the last time a single pull request for
tracing/ftrace/kprobes will be done from this tree.

Tracing updates for 6.1:

Major changes:

 - Changed location of tracing repo from personal git repo to:
   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

 - Added Masami Hiramatsu as co-maintainer

 - Updated MAINTAINERS file to separate out FTRACE as it is
   more than just TRACING.

Minor changes:

 - Added Mark Rutland as FTRACE reviewer

 - Updated user_events to make it on its way to remove the BROKEN tag.
   The changes should now be acceptable but will run it through
   a cycle and hopefully we can remove the BROKEN tag next release.

 - Added filtering to eprobes

 - Added a delta time to the benchmark trace event

 - Have the histogram and filter callbacks called via a switch
   statement instead of indirect functions. This speeds it up to
   avoid retpolines.

 - Add a way to wake up ring buffer waiters waiting for the
   ring buffer to fill up to its watermark.

 - New ioctl() on the trace_pipe_raw file to wake up ring buffer
   waiters.

 - Wake up waiters when the ring buffer is disabled.
   A reader may block when the ring buffer is disabled,
   but if it was blocked when the ring buffer is disabled
   it should then wake up.

Fixes:

 - Allow splice to read partially read ring buffer pages
   Fixes splice never moving forward.

 - Fix inverted compare that made the "shortest" ring buffer
   wait queue actually the longest.

 - Fix a race in the ring buffer between resetting a page when
   a writer goes to another page, and the reader.

 - Fix ftrace accounting bug when function hooks are added at
   boot up before the weak functions are set to "disabled".

 - Fix bug that freed a user allocated snapshot buffer when
   enabling a tracer.

 - Fix possible recursive locks in osnoise tracer

 - Fix recursive locking direct functions

 - And other minor clean ups and fixes


Please pull the latest trace-v6.1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.1

Tag SHA1: 9b396ae1e13db1a6d48855eaee57341ced5db5ff
Head SHA1: 4f881a696484a7d31a4d1b12547615b1a3ee5771


Beau Belgrave (7):
      tracing/user_events: Use NULL for strstr checks
      tracing/user_events: Use WRITE instead of READ for io vector import
      tracing/user_events: Ensure user provided strings are safely formatted
      tracing/user_events: Use refcount instead of atomic for ref tracking
      tracing/user_events: Use bits vs bytes for enabled status page data
      tracing/user_events: Update ABI documentation to align to bits vs bytes
      tracing/user_events: Move pages/locks into groups to prepare for namespaces

Chen Zhongjin (2):
      x86: kprobes: Remove unused macro stack_addr
      tracing: Remove unused variable 'dups'

Colin Ian King (1):
      tracing: Fix spelling mistake "preapre" -> "prepare"

Gaosheng Cui (3):
      x86/ftrace: Remove unused modifying_ftrace_code declaration
      x86/kprobes: Remove unused arch_kprobe_override_function() declaration
      ftrace: Remove obsoleted code from ftrace and task_struct

Mark Rutland (1):
      MAINTAINERS: add myself as a tracing reviewer

Masami Hiramatsu (Google) (2):
      tracing/eprobe: Add eprobe filter support
      selftests/ftrace: Add eprobe syntax error testcase

Nico Pache (1):
      tracing/osnoise: Fix possible recursive locking in stop_per_cpu_kthreads

Song Liu (1):
      ftrace: Fix recursive locking direct_mutex in ftrace_modify_direct_caller

Steven Rostedt (Google) (17):
      tracing: Add numeric delta time to the trace event benchmark
      tracing/hist: Call hist functions directly via a switch statement
      tracing: Move struct filter_pred into trace_events_filter.c
      tracing/filter: Call filter predicate functions directly via a switch statement
      ring-buffer: Allow splice to read previous partially read pages
      ring-buffer: Have the shortest_full queue be the shortest not longest
      ring-buffer: Check pending waiters when doing wake ups as well
      ring-buffer: Add ring_buffer_wake_waiters()
      tracing: Wake up ring buffer waiters on closing of the file
      tracing: Add ioctl() to force ring buffer waiters to wake up
      tracing: Wake up waiters when tracing is disabled
      ring-buffer: Fix race between reset page and reading page
      tracing: Add Masami Hiramatsu as co-maintainer
      ftrace: Still disable enabled records marked as disabled
      tracing: Do not free snapshot if tracer is on cmdline
      tracing: Update MAINTAINERS to reflect new tracing git repo
      ftrace: Create separate entry in MAINTAINERS for function hooks

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
 Documentation/trace/user_events.rst                |  86 +++-
 MAINTAINERS                                        |  26 +-
 arch/x86/include/asm/ftrace.h                      |   1 -
 arch/x86/include/asm/kprobes.h                     |   2 -
 arch/x86/kernel/kprobes/core.c                     |   2 -
 include/linux/ftrace.h                             |  41 --
 include/linux/ring_buffer.h                        |   2 +-
 include/linux/sched.h                              |   3 -
 include/linux/trace_events.h                       |   1 +
 include/linux/user_events.h                        |  15 +-
 kernel/trace/ftrace.c                              |  34 +-
 kernel/trace/kprobe_event_gen_test.c               |  49 +-
 kernel/trace/ring_buffer.c                         |  87 +++-
 kernel/trace/rv/monitors/wip/wip.c                 |   8 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c               |   8 +-
 kernel/trace/trace.c                               |  78 ++-
 kernel/trace/trace.h                               |  13 -
 kernel/trace/trace_benchmark.c                     |   2 +-
 kernel/trace/trace_benchmark.h                     |   8 +-
 kernel/trace/trace_eprobe.c                        | 107 +++-
 kernel/trace/trace_events_filter.c                 | 239 ++++++---
 kernel/trace/trace_events_hist.c                   | 246 ++++++---
 kernel/trace/trace_events_user.c                   | 568 +++++++++++++++------
 kernel/trace/trace_osnoise.c                       |   3 +-
 kernel/trace/trace_probe.h                         |   3 +-
 kernel/trace/tracing_map.c                         |   5 +-
 kernel/tracepoint.c                                |  14 +-
 samples/user_events/example.c                      |  25 +-
 .../test.d/dynevent/eprobes_syntax_errors.tc       |  27 +
 tools/testing/selftests/user_events/ftrace_test.c  |  47 +-
 tools/testing/selftests/user_events/perf_test.c    |  11 +-
 .../dot2/dot2k_templates/main_global.c             |   8 +-
 .../dot2/dot2k_templates/main_per_cpu.c            |   8 +-
 .../dot2/dot2k_templates/main_per_task.c           |   8 +-
 34 files changed, 1299 insertions(+), 486 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
---------------------------
