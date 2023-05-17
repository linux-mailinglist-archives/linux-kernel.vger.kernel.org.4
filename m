Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778847065E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEQK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjEQK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B76EA9;
        Wed, 17 May 2023 03:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F7B64556;
        Wed, 17 May 2023 10:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC54C433EF;
        Wed, 17 May 2023 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321129;
        bh=LyqQuqxk2nIF+cCI4D2OVfVZwmdd2faUMGSMypBGGAc=;
        h=From:To:Cc:Subject:Date:From;
        b=DhoHaQa2loe4pjG/qm2TFREQ1/wQxMoT//PzUU839g/p2cDP9sQCoufP7KhOId/ax
         IXfNMT4jn1tDIGDxy6a0WFugzPMAX9vdRTm6CFLvAUgdn+Irj/ShJSEAopJuuojqtE
         WRYk+IeYmPxWyWbjUoVIF+PSdbtao+I5d6N8DybrBKnvL5HKQrLstvDv+09VaBDjIi
         nGWn7RERe1DG5JjrnfWE1thYrh4+SXuwG4fudkEgUJZ7a1wGZ3nNk7w42/KJdVj8vQ
         tZXJY9Z3d+lvIyTHCO7FT28NXJk5sVaUobaHm2iqzBaYr7cTSBJdW18XnQtbBBjhft
         g92TfEPXfQlAw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v11 00/11] tracing: Add fprobe/tracepoint events
Date:   Wed, 17 May 2023 19:58:45 +0900
Message-ID:  <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 11th version of add a basic fprobe event support for
ftrace (tracefs) and perf. Here is the previous version.

https://lore.kernel.org/all/168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com/

The major change is using '$argr*' instead of '$$args' and automatically
use the argument name when user specifies '$argN' when the kernel supports
BTF [7/11].
This version also update test cases[10/11] and document [11/11].

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

With this fprobe events, we can continue to trace function entry/exit
even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
it is not available if the architecture only supports
CONFIG_DYNAMIC_FTRACE_WITH_ARGS (e.g. arm64). And that means kprobe
events can not probe function entry/exit effectively on such architecture.
But this problem can be solved if the dynamic events supports fprobe events
because fprobe events doesn't use kprobe but ftrace via fprobe.

FPROBE EVENTS
=============

Fprobe events allows user to add new events on the entry and exit of kernel
functions (which can be ftraced). Unlike kprobe events, the fprobe events
can only probe the function entry and exit, and it can only trace the
function args, return value, and stacks. (no registers)
For probing function body, users can continue to use the kprobe events.

The tracepoint probe events (tprobe events) also allows user to add new
events dynamically on the tracepoint. Most of the tracepoint already has
trace-events, so this feature is useful if you only want to know a
specific parameter, or trace the tracepoints which has no trace-events
(e.g. sched_*_tp tracepoints only exposes the tracepoints.)

The fprobe events syntax is;

 f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
 f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]

And tracepoint probe events syntax is;

 t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]

This series includes BTF argument support for fprobe/tracepoint events,
and kprobe events. This allows us to fetch a specific function parameter
by name, and all parameters by '$arg*'.
Note that enabling this feature, you need to enable CONFIG_BPF_SYSCALL and
confirm that your arch supports CONFIG_HAVE_FUNCTION_ARG_ACCESS_API.

E.g.

 # echo 't kfree ptr' >> dynamic_events
 # echo 'f kfree object' >> dynamic_events
 # cat dynamic_events 
t:tracepoints/kfree kfree ptr=ptr
f:fprobes/kfree__entry kfree object=object
 # echo 1 > events/fprobes/enable
 # echo 1 > events/tracepoints/enable
 # echo > trace
 # head -n 20 trace | tail
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            tail-84      [000] .....  1324.561958: kfree__entry: (kfree+0x4/0x140) object=0xffff888006383c00
            tail-84      [000] ...1.  1324.561961: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff888006383c00
            tail-84      [000] .....  1324.561988: kfree__entry: (kfree+0x4/0x140) object=0x0
            tail-84      [000] ...1.  1324.561988: kfree: (__probestub_kfree+0x4/0x10) ptr=0x0
            tail-84      [000] .....  1324.561989: kfree__entry: (kfree+0x4/0x140) object=0xffff88800671e600
            tail-84      [000] ...1.  1324.561989: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff88800671e600
            tail-84      [000] .....  1324.562368: kfree__entry: (kfree+0x4/0x140) object=0xffff8880065e0580
            tail-84      [000] ...1.  1324.562369: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff8880065e0580


Thank you,

---

Masami Hiramatsu (Google) (11):
      fprobe: Pass return address to the handlers
      tracing/probes: Add fprobe events for tracing function entry and exit.
      selftests/ftrace: Add fprobe related testcases
      tracing/probes: Add tracepoint support on fprobe_events
      tracing/probes: Move event parameter fetching code to common parser
      tracing/probes: Support function parameters if BTF is available
      tracing/probes: Add $arg* meta argument for all function args
      tracing/probes: Add BTF retval type support
      selftests/ftrace: Add tracepoint probe test case
      selftests/ftrace: Add BTF arguments test cases
      Documentation: tracing/probes: Add fprobe event tracing document


 Documentation/trace/fprobetrace.rst                |  187 +++
 Documentation/trace/index.rst                      |    1 
 include/linux/fprobe.h                             |   11 
 include/linux/rethook.h                            |    2 
 include/linux/trace_events.h                       |    3 
 include/linux/tracepoint-defs.h                    |    1 
 include/linux/tracepoint.h                         |    5 
 kernel/kprobes.c                                   |    1 
 kernel/trace/Kconfig                               |   26 
 kernel/trace/Makefile                              |    1 
 kernel/trace/bpf_trace.c                           |    6 
 kernel/trace/fprobe.c                              |   17 
 kernel/trace/rethook.c                             |    3 
 kernel/trace/trace.c                               |   13 
 kernel/trace/trace.h                               |   11 
 kernel/trace/trace_eprobe.c                        |   44 -
 kernel/trace/trace_fprobe.c                        | 1197 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |   33 -
 kernel/trace/trace_probe.c                         |  629 +++++++++--
 kernel/trace/trace_probe.h                         |   45 +
 kernel/trace/trace_uprobe.c                        |    8 
 lib/test_fprobe.c                                  |   10 
 samples/fprobe/fprobe_example.c                    |    6 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  102 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   16 
 29 files changed, 2404 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
