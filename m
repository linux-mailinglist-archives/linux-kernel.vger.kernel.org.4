Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9973D6F0E72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjD0WpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjD0WpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206F2106
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C5F64027
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB41FC433EF;
        Thu, 27 Apr 2023 22:45:01 +0000 (UTC)
Date:   Thu, 27 Apr 2023 18:45:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florent Revest <revest@chromium.org>,
        Hao Zeng <zenghao@kylinos.cn>,
        Johannes Berg <johannes.berg@intel.com>,
        Ken Lin <lyenting@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Updates for 6.4
Message-ID: <20230427184500.6d093468@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Resending, as I forgot to include LKML! ]

Linus,

[
  Note: The beginning of the commits includes commits I shared with arm64
  that they needed for implementing their direct trampolines. If you merged
  their branch, then you may already have those commits.
]

tracing updates for 6.4:

- User events are finally ready!
  After lots of collaboration between various parties, we finally locked
  down on a stable interface for user events that can also work with user
  space only tracing. This is implemented by telling the kernel (or user
  space library, but that part is user space only and not part of this
  patch set), where the variable is that the application uses to know if
  something is listening to the trace. There's also an interface to tell
  the kernel about these events, which will show up in the
  /sys/kernel/tracing/events/user_events/ directory, where it can be
  enabled. When it's enabled, the kernel will update the variable, to tell
  the application to start writing to the kernel.
  See https://lwn.net/Articles/927595/

- Cleaned up the direct trampolines code to simplify arm64 addition of
  direct trampolines. Direct trampolines use the ftrace interface but
  instead of jumping to the ftrace trampoline, applications (mostly BPF)
  can register their own trampoline for performance reasons.

- Some updates to the fprobe infrastructure. fprobes are more efficient than
  kprobes, as it does not need to save all the registers that kprobes on
  ftrace do. More work needs to be done before the fprobes will be exposed
  as dynamic events.

- More updates to references to the obsolete path of
  /sys/kernel/debug/tracing for the new /sys/kernel/tracing path.

- Add a seq_buf_do_printk() helper to seq_bufs, to print a large buffer line
  by line instead of all at once. There's users in production kernels that
  have a large data dump that originally used printk() directly, but the
  data dump was larger than what printk() allowed as a single print.
  Using seq_buf() to do the printing fixes that.

- Add /sys/kernel/tracing/touched_functions that shows all functions that
  was every traced by ftrace or a direct trampoline. This is used for
  debugging issues where a traced function could have caused a crash by
  a bpf program or live patching.

- Add a "fields" option that is similar to "raw" but outputs the fields of
  the events. It's easier to read by humans.

- Some minor fixes and clean ups.


Please pull the latest trace-v6.4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.4

Tag SHA1: 4c817fb7dde5c2bf6d5b5f3eac9b1ff75125356d
Head SHA1: 675751bb20634f981498c7d66161584080cc061e


Beau Belgrave (18):
      tracing/user_events: Split header into uapi and kernel
      tracing/user_events: Track fork/exec/exit for mm lifetime
      tracing/user_events: Use remote writes for event enablement
      tracing/user_events: Fixup enable faults asyncly
      tracing/user_events: Add ioctl for disabling addresses
      tracing/user_events: Update self-tests to write ABI
      tracing/user_events: Add ABI self-test
      tracing/user_events: Use write ABI in example
      tracing/user_events: Update documentation for ABI
      tracing/user_events: Charge event allocs to cgroups
      tracing/user_events: Limit global user_event count
      tracing/user_events: Align structs with tabs for readability
      tracing/user_events: Set event filter_type from type
      tracing: Fix print_fields() for __dyn_loc/__rel_loc
      tracing/user_events: Ensure write index cannot be negative
      tracing/user_events: Ensure bit is cleared on unregister
      tracing/user_events: Prevent same address and bit per process
      tracing/user_events: Limit max fault-in attempts

Florent Revest (6):
      ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
      ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
      ftrace: Remove the legacy _ftrace_direct API
      ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
      ftrace: Store direct called addresses in their ops
      ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS

Hao Zeng (1):
      recordmcount: Fix memory leaks in the uwrite function

Johannes Berg (1):
      ring-buffer: Sync IRQ works before buffer destruction

Ken Lin (1):
      tracing: Add missing spaces in trace_print_hex_seq()

Mark Rutland (1):
      ftrace: selftest: remove broken trace_direct_tramp

Masami Hiramatsu (Google) (7):
      fprobe: Pass entry_data to handlers
      lib/test_fprobe: Add private entry_data testcases
      fprobe: Add nr_maxactive to specify rethook_node pool size
      lib/test_fprobe: Add a test case for nr_maxactive
      fprobe: Skip exit_handler if entry_handler returns !0
      lib/test_fprobe: Add a testcase for skipping exit_handler
      docs: tracing: Update fprobe documentation

Ross Zwisler (3):
      selftests: use canonical ftrace path
      leaking_addresses: also skip canonical ftrace path
      tools/kvm_stat: use canonical ftrace path

Sergey Senozhatsky (1):
      seq_buf: Add seq_buf_do_printk() helper

Steven Rostedt (Google) (4):
      ftrace: Show a list of all functions that have ever been enabled
      tracing: Add "fields" option to show raw trace event fields
      tracing/user_events: Use print_format_fields() for trace output
      tracing: Unbreak user events

Tze-nan Wu (1):
      ring-buffer: Ensure proper resetting of atomic variables in
ring_buffer_reset_online_cpus

Uros Bizjak (3):
      ring_buffer: Change some static functions to void
      ring_buffer: Change some static functions to bool
      ring_buffer: Use try_cmpxchg instead of cmpxchg

Zheng Yejian (1):
      ring-buffer: Clearly check null ptr returned by rb_set_head_page()

----
 Documentation/trace/fprobe.rst                    |   16 +-
 Documentation/trace/ftrace.rst                    |    6 +
 Documentation/trace/user_events.rst               |  167 ++--
 arch/s390/kernel/mcount.S                         |    5 +
 arch/x86/kernel/ftrace_32.S                       |    5 +
 arch/x86/kernel/ftrace_64.S                       |    4 +
 fs/exec.c                                         |    2 +
 include/linux/fprobe.h                            |   10 +-
 include/linux/ftrace.h                            |   66 +-
 include/linux/sched.h                             |    5 +
 include/linux/seq_buf.h                           |    2 +
 include/linux/user_events.h                       |  101 +-
 include/uapi/linux/user_events.h                  |   81 ++
 kernel/bpf/trampoline.c                           |   12 +-
 kernel/exit.c                                     |    2 +
 kernel/fork.c                                     |    2 +
 kernel/trace/Kconfig                              |    8 +-
 kernel/trace/bpf_trace.c                          |   17 +-
 kernel/trace/fprobe.c                             |   32 +-
 kernel/trace/ftrace.c                             |  489 ++--------
 kernel/trace/ring_buffer.c                        |  102 +-
 kernel/trace/trace.c                              |    7 +-
 kernel/trace/trace.h                              |    2 +
 kernel/trace/trace_events_user.c                  | 1034
+++++++++++++++++---- kernel/trace/trace_output.c                       |
175 +++- kernel/trace/trace_output.h                       |    2 +
 kernel/trace/trace_selftest.c                     |   19 +-
 lib/seq_buf.c                                     |   32 +
 lib/test_fprobe.c                                 |  105 ++-
 samples/Kconfig                                   |    2 +-
 samples/fprobe/fprobe_example.c                   |    7 +-
 samples/ftrace/ftrace-direct-modify.c             |   10 +-
 samples/ftrace/ftrace-direct-multi-modify.c       |    9 +-
 samples/ftrace/ftrace-direct-multi.c              |    5 +-
 samples/ftrace/ftrace-direct-too.c                |   10 +-
 samples/ftrace/ftrace-direct.c                    |   10 +-
 samples/user_events/example.c                     |   45 +-
 scripts/leaking_addresses.pl                      |    1 +
 scripts/recordmcount.c                            |    6 +-
 tools/kvm/kvm_stat/kvm_stat                       |    2 +-
 tools/testing/selftests/mm/protection_keys.c      |    4 +-
 tools/testing/selftests/user_events/Makefile      |    2 +-
 tools/testing/selftests/user_events/abi_test.c    |  229 +++++
 tools/testing/selftests/user_events/dyn_test.c    |    2 +-
 tools/testing/selftests/user_events/ftrace_test.c |  176 ++--
 tools/testing/selftests/user_events/perf_test.c   |   39 +-
 46 files changed, 2060 insertions(+), 1009 deletions(-)
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 tools/testing/selftests/user_events/abi_test.c
---------------------------
