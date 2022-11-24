Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC62637BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKXOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:50:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FD10FED8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB17BB8283A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85901C433D6;
        Thu, 24 Nov 2022 14:50:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYr-001X24-1r;
        Thu, 24 Nov 2022 09:50:45 -0500
Message-ID: <20221124145019.782980678@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for 6.2
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

Head SHA1: bd604f3db49c5b21171abea0414a2020dcbf2646


Chuang Wang (1):
      tracing/perf: Use strndup_user instead of kzalloc/strncpy_from_user

Daniel Bristot de Oliveira (3):
      tracing/osnoise: Add osnoise/options file
      tracing/osnoise: Add OSNOISE_WORKLOAD option
      Documentation/osnoise: Add osnoise/options documentation

Song Chen (1):
      ring_buffer: Remove unused "event" parameter

Steven Rostedt (Google) (3):
      tracing: Add __cpumask to denote a trace event field that is a cpumask_t
      tracing: Add trace_trigger kernel command line option
      ftrace: Avoid needless updates of the ftrace function call

Xiu Jianfeng (1):
      tracing: Make tracepoint_print_iter static

Zheng Yejian (2):
      ftrace: Clean comments related to FTRACE_OPS_FL_PER_CPU
      tracing: Optimize event type allocation with IDA

----
 Documentation/admin-guide/kernel-parameters.txt |  19 +++
 Documentation/trace/osnoise-tracer.rst          |  12 ++
 include/linux/ring_buffer.h                     |   3 +-
 include/linux/trace_events.h                    |   1 -
 include/trace/bpf_probe.h                       |   6 +
 include/trace/perf.h                            |   6 +
 include/trace/stages/stage1_struct_define.h     |   6 +
 include/trace/stages/stage2_data_offsets.h      |   6 +
 include/trace/stages/stage3_trace_output.h      |   6 +
 include/trace/stages/stage4_event_fields.h      |   6 +
 include/trace/stages/stage5_get_offsets.h       |   6 +
 include/trace/stages/stage6_event_callback.h    |  20 +++
 include/trace/stages/stage7_class_define.h      |   2 +
 kernel/trace/ftrace.c                           |  27 ++--
 kernel/trace/ring_buffer.c                      |  12 +-
 kernel/trace/ring_buffer_benchmark.c            |   2 +-
 kernel/trace/trace.c                            |   4 +-
 kernel/trace/trace.h                            |   2 -
 kernel/trace/trace_event_perf.c                 |  16 +-
 kernel/trace/trace_events.c                     |  72 ++++++++-
 kernel/trace/trace_osnoise.c                    | 194 +++++++++++++++++++++++-
 kernel/trace/trace_output.c                     |  66 ++------
 samples/trace_events/trace-events-sample.c      |   2 +-
 samples/trace_events/trace-events-sample.h      |  34 ++++-
 24 files changed, 431 insertions(+), 99 deletions(-)
