Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5D74F12E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjGKOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjGKOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFEFBC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6354A614E2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF426C433C8;
        Tue, 11 Jul 2023 14:07:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJE1L-0007ka-2I;
        Tue, 11 Jul 2023 10:07:15 -0400
Message-ID: <20230711140652.217008556@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jul 2023 10:06:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Minor fixes and clean ups
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes and clean ups:

- Fix some missing-prototype warnings

- Fix user events struct args (did not include size of struct)
  When creating a user event, the "struct" keyword is to denote
  that the size of the field will be passed in. But the parsing
  failed to handle this case.

- Fix sample code for direct trampolines.
  The sample code for direct trampolines attached to handle_mm_fault().
  But the prototype changed and the direct trampoline sample code
  was not updated. Direct trampolines needs to have the arguments correct
  otherwise it can fail or crash the system.

- Remove unused ftrace_regs_caller_ret() prototype.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/core

Head SHA1: 46b77ea28faeed56f1d1b63f9049c40b9eb3cbf5


Arnd Bergmann (1):
      tracing: arm64: Avoid missing-prototype warnings

Beau Belgrave (1):
      tracing/user_events: Fix struct arg size match check

Florent Revest (2):
      samples: ftrace: Save required argument registers in sample trampolines
      arm64: ftrace: Add direct call trampoline samples support

YueHaibing (1):
      x86/ftrace: Remove unsued extern declaration ftrace_regs_caller_ret()

----
 arch/arm64/Kconfig                          |  2 ++
 arch/arm64/include/asm/ftrace.h             |  4 +++
 arch/arm64/include/asm/syscall.h            |  3 +++
 arch/arm64/kernel/syscall.c                 |  3 ---
 arch/x86/kernel/ftrace.c                    |  1 -
 include/linux/ftrace.h                      |  8 ++++++
 kernel/trace/fgraph.c                       |  1 +
 kernel/trace/ftrace_internal.h              |  5 ++--
 kernel/trace/trace_events_user.c            |  3 +++
 kernel/trace/trace_kprobe_selftest.c        |  3 +++
 samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 25 ++++++++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 40 ++++++++++++++++++++++++-----
 samples/ftrace/ftrace-direct.c              | 24 +++++++++++++++++
 15 files changed, 184 insertions(+), 12 deletions(-)
