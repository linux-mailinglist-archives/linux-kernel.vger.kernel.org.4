Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D368E5B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBHB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBHB5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A423675
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D44C6147C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BEBC433D2;
        Wed,  8 Feb 2023 01:57:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiE-006dLu-1J;
        Tue, 07 Feb 2023 20:57:30 -0500
Message-ID: <20230208015633.791198913@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for 6.3
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

Head SHA1: 9c1c251d670bc107b9ce600a2c20adb08b4849e9


Arnd Bergmann (1):
      ftrace: sample: avoid open-coded 64-bit division

Bagas Sanjaya (1):
      tracing/histogram: Wrap remaining shell snippets in code blocks

Davidlohr Bueso (1):
      tracing/osnoise: No need for schedule_hrtimeout range

Linyu Yuan (1):
      tracing: Acquire buffer from temparary trace sequence

Song Shuai (1):
      samples: ftrace: Include the nospec-branch.h only for x86

Steven Rostedt (Google) (5):
      tracing: Fix trace_event_raw_event_synth() if else statement
      tracing: Add creation of instances at boot command line
      tracing: Add enabling of events to boot instances
      tracing: Add trace_array_puts() to write into instance
      tracing: Allow boot instances to have snapshot buffers

Tom Rix (1):
      samples: ftrace: Make some global variables static

----
 Documentation/admin-guide/kernel-parameters.txt |  29 +++++
 Documentation/trace/histogram.rst               |  93 +++++++-------
 include/linux/trace.h                           |  12 ++
 include/linux/trace_seq.h                       |   5 +
 include/trace/stages/stage3_trace_output.h      |   3 +
 include/trace/stages/stage7_class_define.h      |   1 +
 kernel/trace/trace.c                            | 160 +++++++++++++++++++++---
 kernel/trace/trace.h                            |   2 +
 kernel/trace/trace_events.c                     |   9 +-
 kernel/trace/trace_events_synth.c               |   4 +-
 kernel/trace/trace_osnoise.c                    |   2 +-
 kernel/trace/trace_seq.c                        |  23 ++++
 samples/ftrace/ftrace-direct-modify.c           |   2 +-
 samples/ftrace/ftrace-direct-multi-modify.c     |   2 +-
 samples/ftrace/ftrace-direct-multi.c            |   2 +-
 samples/ftrace/ftrace-direct-too.c              |   2 +-
 samples/ftrace/ftrace-direct.c                  |   2 +-
 samples/ftrace/ftrace-ops.c                     |  26 ++--
 18 files changed, 290 insertions(+), 89 deletions(-)
