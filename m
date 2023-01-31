Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA848683257
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjAaQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAaQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329E53E73;
        Tue, 31 Jan 2023 08:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D658CB81D12;
        Tue, 31 Jan 2023 16:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141D2C433EF;
        Tue, 31 Jan 2023 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181707;
        bh=On6dk7QxcXuk5ZrUhYfXctjO795dxCDztPU8h5Zx/64=;
        h=From:To:Cc:Subject:Date:From;
        b=kRtnAixxwqsW1e2PcXXP4D5YNhGZ1zzAbm1i8tSAmFwVApOdZ6lwzIJS7qQfJCX9D
         SaRTwi9lICKi1/CFNZmF+3CeBW8YwQEvBjCaHeoPlQSCgb10J0PDYazE4yhsWTh1Me
         +/jG/vBuyprnJIUipsRWtRfs9/67velv0IAdCGEBc2Mn2qbEP04exQswgse4prSjoD
         P6/XN1OXS+uCcwg5tXNvkKbKjbav4J2iymEWamyMjtAaUfsazUof8cRJIlfuy4EYBx
         ZE+VSYLuN/3cw+wDMafAXIYz1lgxe1dgi2U6nb9/Fsq3QfBa/HsN+sc26kfI99DeFK
         l9snyOkiWEymw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 00/10] tracing: Add fprobe events
Date:   Wed,  1 Feb 2023 01:15:03 +0900
Message-Id:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of improve fprobe and add a basic fprobe event
support for ftrace (tracefs) and perf. Here is the previous version.

https://lore.kernel.org/all/166792255429.919356.14116090269057513181.stgit@devnote3/T/#u

This version has some fixes, update patch description with the reason why
this is required, and add some testcases.

With this fprobe events, we can continue to trace function entry/exit
even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
it is not available if the architecture only supports
CONFIG_DYNAMIC_FTRACE_WITH_ARGS (e.g. arm64). And that means kprobe
events can not probe function entry/exit effectively on such architecture.
But this problem can be solved if the dynamic events supports fprobe events
because fprobe events doesn't use kprobe but ftrace via fprobe.

With this series, user can add new events on the entry and exit of kernel
functions (which can be ftraced). Unlike kprobe events, the fprobe events
can only probe the function entry and exit, the IP address will have some
offsets from the symbol address. And it can only trace the function args,
return value, and stacks. (no registers)
For probing function body, users can continue to use the kprobe events.

The fprobe events syntax is here;

 f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
 f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]

E.g.

 # echo 'f vfs_read $arg1'  >> dynamic_events
 # echo 'f vfs_read%return $retval'  >> dynamic_events
 # cat dynamic_events
 f:fprobes/vfs_read_entry vfs_read arg1=$arg1
 f:fprobes/vfs_read_exit vfs_read%return arg1=$retval
 # echo 1 > events/fprobes/enable
 # head -n 20 trace | tail
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
              sh-142     [005] ...1.   448.386420: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.386436: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
              sh-142     [005] ...1.   448.386451: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.386458: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
              sh-142     [005] ...1.   448.386469: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.386476: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
              sh-142     [005] ...1.   448.602073: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.602089: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1

Future works:
 - Trace multiple function entry/exit (wildcard).
 - Integrate it with the function graph tracer.
 - Use ftrace_regs instead of pt_regs and remove dependency of
   CONFIG_DYNAMIC_FTRACE_WITH_REGS.
 - Support (limited) register access via ftrace_regs.
 - Support fprobe event by perf probe.
 - Support entry data accessing from exit event.
 - Support BTF for trace arguments.

This fprobe event may eventually replace the kprobe events for
function entry and exit on some archs (e.g. arm64).

Here's my current migration (kretprobe to fprobe) idea:

Phase 1. introduce fprobe events. (THIS)
Phase 2. introduce generic function graph shadow stack
Phase 3. Replace the rethook with function shadow stack
         and use ftrace_regs in fprobe handlers.
Phase 4. Extend this fprobe support to other archs.

Even if kretprobe event is replaced with fprobe event, tracefs user can
transparently use fprobe events for function entry/exit with 'p:...'
and 'r:...' syntax (for backward compatibility.)

Thank you,

---

Masami Hiramatsu (Google) (10):
      fprobe: Pass entry_data to handlers
      lib/test_fprobe: Add private entry_data testcases
      fprobe: Add nr_maxactive to specify rethook_node pool size
      lib/test_fprobe: Add a test case for nr_maxactive
      fprobe: Skip exit_handler if entry_handler returns !0
      lib/test_fprobe: Add a testcase for skipping exit_handler
      docs: tracing: Update fprobe documentation
      fprobe: Pass return address to the handlers
      tracing/probes: Add fprobe events for tracing function entry and exit.
      selftests/ftrace: Add fprobe related testcases


 Documentation/trace/fprobe.rst                     |   16 
 include/linux/fprobe.h                             |   17 
 include/linux/rethook.h                            |    2 
 include/linux/trace_events.h                       |    3 
 kernel/kprobes.c                                   |    1 
 kernel/trace/Kconfig                               |   14 
 kernel/trace/Makefile                              |    1 
 kernel/trace/bpf_trace.c                           |   19 
 kernel/trace/fprobe.c                              |   45 +
 kernel/trace/rethook.c                             |    3 
 kernel/trace/trace.c                               |    3 
 kernel/trace/trace.h                               |   11 
 kernel/trace/trace_fprobe.c                        | 1125 ++++++++++++++++++++
 kernel/trace/trace_probe.c                         |    4 
 kernel/trace/trace_probe.h                         |    3 
 lib/test_fprobe.c                                  |  109 ++
 samples/fprobe/fprobe_example.c                    |   11 
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   88 ++
 19 files changed, 1470 insertions(+), 31 deletions(-)
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
