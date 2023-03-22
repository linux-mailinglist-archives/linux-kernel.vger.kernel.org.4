Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510066C53EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCVSni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E908323A75
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73879621BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50EFC433D2;
        Wed, 22 Mar 2023 18:43:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qr-000pVk-2D;
        Wed, 22 Mar 2023 14:43:33 -0400
Message-ID: <20230322184239.594953818@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for 6.4
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: e11b521a7b69c2621bb2e5920bb96f6d2facdc7e


Florent Revest (6):
      ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
      ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
      ftrace: Remove the legacy _ftrace_direct API
      ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
      ftrace: Store direct called addresses in their ops
      ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS

Mark Rutland (1):
      ftrace: selftest: remove broken trace_direct_tramp

Steven Rostedt (Google) (1):
      ftrace: Show a list of all functions that have ever been enabled

Uros Bizjak (3):
      ring_buffer: Change some static functions to void
      ring_buffer: Change some static functions to bool
      ring_buffer: Use try_cmpxchg instead of cmpxchg

----
 arch/s390/kernel/mcount.S                   |   5 +
 arch/x86/kernel/ftrace_32.S                 |   5 +
 arch/x86/kernel/ftrace_64.S                 |   4 +
 include/linux/ftrace.h                      |  66 ++--
 kernel/bpf/trampoline.c                     |  12 +-
 kernel/trace/Kconfig                        |   2 +-
 kernel/trace/ftrace.c                       | 489 ++++------------------------
 kernel/trace/ring_buffer.c                  |  77 ++---
 kernel/trace/trace_selftest.c               |  19 +-
 samples/Kconfig                             |   2 +-
 samples/ftrace/ftrace-direct-modify.c       |  10 +-
 samples/ftrace/ftrace-direct-multi-modify.c |   9 +-
 samples/ftrace/ftrace-direct-multi.c        |   5 +-
 samples/ftrace/ftrace-direct-too.c          |  10 +-
 samples/ftrace/ftrace-direct.c              |  10 +-
 15 files changed, 185 insertions(+), 540 deletions(-)
