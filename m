Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC023648EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLJN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLJN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0D275
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2126B60B83
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE3C433D2;
        Sat, 10 Dec 2022 13:58:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40Mx-000kkQ-18;
        Sat, 10 Dec 2022 08:58:23 -0500
Message-ID: <20221210135750.425719934@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/25] tracing: Updates for 6.2
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

Head SHA1: d3f56476437f78d2cdea60ead59406b1da278584


Bagas Sanjaya (1):
      Documentation/osnoise: Escape underscore of NO_ prefix

Beau Belgrave (1):
      tracing/user_events: Fix call print_fmt leak

Daniel Bristot de Oliveira (4):
      tracing/osnoise: Make osnoise_options static
      tracing/osnoise: Add PANIC_ON_STOP option
      tracing/osnoise: Add preempt and/or irq disabled options
      Documentation/osnoise: Add osnoise/options documentation

David Howells (1):
      tracing: Fix some checker warnings

Masami Hiramatsu (Google) (5):
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value
      tracing: Add nohitcount option for suppressing display of raw hitcount
      tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'
      tracing: Fix complicated dependency of CONFIG_TRACER_MAX_TRACE

Ross Zwisler (1):
      tracing: remove unnecessary trace_trigger ifdef

Song Chen (1):
      trace/kprobe: remove duplicated calls of ring_buffer_event_data

Steven Rostedt (3):
      x86/mm/kmmio: Switch to arch_spin_lock()
      x86/mm/kmmio: Use rcu_read_lock_sched_notrace()
      ring-buffer: Handle resize in early boot up

Steven Rostedt (Google) (3):
      tracing: Update MAINTAINERS file for new patchwork and mailing list
      ftrace/x86: Add back ftrace_expected for ftrace bug reports
      tracing/probes: Handle system names with hyphens

Tom Zanussi (1):
      tracing: Allow multiple hitcount values in histograms

Zheng Yejian (4):
      tracing/hist: Fix wrong return value in parse_action_params()
      tracing/hist: Fix out-of-bound write on 'action_data.var_ref_idx'
      tracing: Fix issue of missing one synthetic field
      tracing/hist: Fix issue of losting command info in error_log

----
 Documentation/trace/histogram.rst      |  10 +-
 Documentation/trace/osnoise-tracer.rst |  22 +++-
 MAINTAINERS                            |   9 ++
 arch/x86/kernel/ftrace.c               |   2 +
 arch/x86/mm/kmmio.c                    |  37 ++++---
 include/linux/trace_events.h           |   3 +-
 include/linux/trace_seq.h              |   3 +-
 kernel/trace/Kconfig                   |   2 +
 kernel/trace/ring_buffer.c             |  32 ++++--
 kernel/trace/trace.c                   |  30 ++++--
 kernel/trace/trace.h                   |  29 +++--
 kernel/trace/trace_events.c            |   6 --
 kernel/trace/trace_events_hist.c       | 190 ++++++++++++++++++++++++++++-----
 kernel/trace/trace_events_synth.c      |   2 +-
 kernel/trace/trace_events_user.c       |   1 +
 kernel/trace/trace_kprobe.c            |   2 -
 kernel/trace/trace_osnoise.c           |  56 ++++++++--
 kernel/trace/trace_output.c            |   5 +-
 kernel/trace/trace_probe.c             |   2 +-
 19 files changed, 353 insertions(+), 90 deletions(-)
