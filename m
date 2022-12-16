Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5273264E59B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLPBZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPBZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0185D69F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F4E61FDB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCBDC433EF;
        Fri, 16 Dec 2022 01:25:51 +0000 (UTC)
Date:   Thu, 15 Dec 2022 20:25:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Song Chen <chensong_2000@189.cn>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Updates for 6.2
Message-ID: <20221215202548.554bd268@gandalf.local.home>
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

Tracing updates for 6.2:

- Add options to the osnoise tracer
  o panic_on_stop option that panics the kernel if osnoise is greater than some
    user defined threshold.
  o preempt option, to test noise while preemption is disabled
  o irq option, to test noise when interrupts are disabled

- Add .percent and .graph suffix to histograms to give different outputs

- Add nohitcount to disable showing hitcount in histogram output

- Add new __cpumask() to trace event fields to annotate that a unsigned long
  array is a cpumask to user space and should be treated as one.

- Add trace_trigger kernel command line parameter to enable trace event
  triggers at boot up. Useful to trace stack traces, disable tracing and take
  snapshots.

- Fix x86/kmmio mmio tracer to work with the updates to lockdep

- Unify the panic and die notifiers

- Add back ftrace_expect reference that is used to extract more information in
  the ftrace_bug() code.

- Have trigger filter parsing errors show up in the tracing error log.

- Updated MAINTAINERS file to add kernel tracing  mailing list and patchwork
  info

- Use IDA to keep track of event type numbers.

- And minor fixes and clean ups


Please pull the latest trace-v6.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.2

Tag SHA1: 2b786b778a6ab43d5cff51a437d4fd1ad5cdc7b2
Head SHA1: eb9d58947d40699d93e5e69e1ddc54e41da7e132


Bagas Sanjaya (1):
      Documentation/osnoise: Escape underscore of NO_ prefix

Beau Belgrave (1):
      tracing/user_events: Fix call print_fmt leak

Chuang Wang (1):
      tracing/perf: Use strndup_user instead of kzalloc/strncpy_from_user

Daniel Bristot de Oliveira (7):
      tracing/osnoise: Add osnoise/options file
      tracing/osnoise: Add OSNOISE_WORKLOAD option
      Documentation/osnoise: Add osnoise/options documentation
      tracing/osnoise: Make osnoise_options static
      tracing/osnoise: Add PANIC_ON_STOP option
      tracing/osnoise: Add preempt and/or irq disabled options
      Documentation/osnoise: Add osnoise/options documentation

David Howells (1):
      tracing: Fix some checker warnings

Guilherme G. Piccoli (2):
      ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
      tracing: Improve panic/die notifiers

Masami Hiramatsu (Google) (5):
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value
      tracing: Add nohitcount option for suppressing display of raw hitcount
      tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'
      tracing: Fix complicated dependency of CONFIG_TRACER_MAX_TRACE

Ross Zwisler (1):
      tracing: remove unnecessary trace_trigger ifdef

Song Chen (2):
      ring_buffer: Remove unused "event" parameter
      trace/kprobe: remove duplicated calls of ring_buffer_event_data

Steven Rostedt (3):
      x86/mm/kmmio: Switch to arch_spin_lock()
      x86/mm/kmmio: Use rcu_read_lock_sched_notrace()
      ring-buffer: Handle resize in early boot up

Steven Rostedt (Google) (11):
      tracing: Add __cpumask to denote a trace event field that is a cpumask_t
      tracing: Add trace_trigger kernel command line option
      ftrace: Avoid needless updates of the ftrace function call
      tracing: Update MAINTAINERS file for new patchwork and mailing list
      ftrace/x86: Add back ftrace_expected for ftrace bug reports
      tracing/probes: Handle system names with hyphens
      x86/mm/kmmio: Remove redundant preempt_disable()
      tracing: Have trigger filter parsing errors show up in error_log
      tracing: Remove pointer (asterisk) and brackets from cpumask_t field
      tracing: Do not synchronize freeing of trigger filter on boot up
      tracing: Fix cpumask() example typo

Tom Zanussi (1):
      tracing: Allow multiple hitcount values in histograms

Xiu Jianfeng (1):
      tracing: Make tracepoint_print_iter static

Yang Jihong (1):
      tracing: Fix infinite loop in tracing_read_pipe on overflowed print_trace_line

Zheng Yejian (6):
      ftrace: Clean comments related to FTRACE_OPS_FL_PER_CPU
      tracing: Optimize event type allocation with IDA
      tracing/hist: Fix wrong return value in parse_action_params()
      tracing/hist: Fix out-of-bound write on 'action_data.var_ref_idx'
      tracing: Fix issue of missing one synthetic field
      tracing/hist: Fix issue of losting command info in error_log

----
 Documentation/admin-guide/kernel-parameters.txt |  19 ++
 Documentation/trace/histogram.rst               |  10 +-
 Documentation/trace/osnoise-tracer.rst          |  32 +++-
 MAINTAINERS                                     |   9 +
 arch/x86/kernel/ftrace.c                        |   2 +
 arch/x86/mm/kmmio.c                             |  50 +++--
 include/linux/ring_buffer.h                     |   3 +-
 include/linux/trace_events.h                    |   4 +-
 include/linux/trace_seq.h                       |   3 +-
 include/trace/bpf_probe.h                       |   6 +
 include/trace/perf.h                            |   6 +
 include/trace/stages/stage1_struct_define.h     |   6 +
 include/trace/stages/stage2_data_offsets.h      |   6 +
 include/trace/stages/stage3_trace_output.h      |   6 +
 include/trace/stages/stage4_event_fields.h      |  12 ++
 include/trace/stages/stage5_get_offsets.h       |   6 +
 include/trace/stages/stage6_event_callback.h    |  20 ++
 include/trace/stages/stage7_class_define.h      |   2 +
 kernel/trace/Kconfig                            |   2 +
 kernel/trace/ftrace.c                           |  28 ++-
 kernel/trace/ring_buffer.c                      |  44 +++--
 kernel/trace/ring_buffer_benchmark.c            |   2 +-
 kernel/trace/trace.c                            | 104 ++++++----
 kernel/trace/trace.h                            |  31 +--
 kernel/trace/trace_event_perf.c                 |  16 +-
 kernel/trace/trace_events.c                     |  66 ++++++-
 kernel/trace/trace_events_hist.c                | 190 +++++++++++++++---
 kernel/trace/trace_events_synth.c               |   2 +-
 kernel/trace/trace_events_trigger.c             |  19 +-
 kernel/trace/trace_events_user.c                |   1 +
 kernel/trace/trace_kprobe.c                     |   2 -
 kernel/trace/trace_osnoise.c                    | 244 +++++++++++++++++++++++-
 kernel/trace/trace_output.c                     |  71 ++-----
 kernel/trace/trace_probe.c                      |   2 +-
 samples/trace_events/trace-events-sample.c      |   2 +-
 samples/trace_events/trace-events-sample.h      |  34 +++-
 36 files changed, 843 insertions(+), 219 deletions(-)
---------------------------
