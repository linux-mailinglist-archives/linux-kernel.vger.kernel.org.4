Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DA6218BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiKHPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiKHPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:49:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DD1A05C;
        Tue,  8 Nov 2022 07:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900BF61656;
        Tue,  8 Nov 2022 15:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAC7C433C1;
        Tue,  8 Nov 2022 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922558;
        bh=OjXhkq0eLX0m3+uGzwgi/GSi4Io4hgZBT5i154Q5krA=;
        h=From:To:Cc:Subject:Date:From;
        b=qJZttUEs1+fDdvoazsDFN+Wzhbm262DZyxnsAD/+Rv1WRM15gQh/s+nAug2r8JxIW
         lz6aXH7JmW5HuAjmVlEE4/dvqgWxRoXDBMh6tOlDg5NkhnLxRmAa4M0do3zqZR4dLK
         wTY1SBdgLI38pgRjcwObHLY6OOCVX+Lwicg4Afe6/ziVcfrbd3mXdNbkmvoyOGLqww
         3JmAf1heSn4JKr1suKvePJDtbRS0Umxl7OuH1yDaMojBn3yw+HBfrumyU61L3ZPre5
         kRdUXTmtfpxQlMI60smVg7dY+YU2vlmrJ/s3wDf4++85HW9zBetJzr6ToORw3kxbZw
         RIp6dhVDODabw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 0/9] tracing: Add fprobe events
Date:   Wed,  9 Nov 2022 00:49:14 +0900
Message-Id: <166792255429.919356.14116090269057513181.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

Here is a series of patches to improve fprobe and add a basic fprobe event
support for ftrace (tracefs) and perf.

With this series, user can add new events on the entry and exit of kernel
functions (which can be ftraced). Unlike kprobe events, the fprobe events
can only probe the function entry and exit, the IP address will have some
offsets from the symbol address. And it can only trace the function args,
return value, and stacks. (no registers)

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

Masami Hiramatsu (Google) (9):
      fprobe: Pass entry_data to handlers
      lib/test_fprobe: Add private entry_data testcases
      fprobe: Add nr_maxactive to specify rethook_node pool size
      lib/test_fprobe: Add a test case for nr_maxactive
      fprobe: Skip exit_handler if entry_handler returns !0
      lib/test_fprobe: Add a testcase for skipping exit_handler
      docs: tracing: Update fprobe documentation
      fprobe: Pass return address to the handlers
      tracing/probes: Add fprobe-events


 Documentation/trace/fprobe.rst  |   16 -
 include/linux/fprobe.h          |   17 +
 include/linux/rethook.h         |    2 
 include/linux/trace_events.h    |    3 
 kernel/kprobes.c                |    1 
 kernel/trace/Kconfig            |   14 
 kernel/trace/Makefile           |    1 
 kernel/trace/bpf_trace.c        |   19 +
 kernel/trace/fprobe.c           |   45 +-
 kernel/trace/rethook.c          |    3 
 kernel/trace/trace.h            |   11 
 kernel/trace/trace_fprobe.c     | 1120 +++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.c      |    4 
 kernel/trace/trace_probe.h      |    4 
 lib/test_fprobe.c               |  109 ++++
 samples/fprobe/fprobe_example.c |   11 
 16 files changed, 1349 insertions(+), 31 deletions(-)
 create mode 100644 kernel/trace/trace_fprobe.c

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
