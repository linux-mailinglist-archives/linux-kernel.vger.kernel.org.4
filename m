Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87953741C17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjF1XAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjF1XAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ACB294E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004F461486
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96614C433C8;
        Wed, 28 Jun 2023 23:00:35 +0000 (UTC)
Date:   Wed, 28 Jun 2023 19:00:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [GIT PULL] tracing: Updates for 6.5
Message-ID: <20230628190032.12421bf8@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates for 6.5:

- Add new feature to have function graph tracer record the return value.
  Adds a new option: funcgraph-retval ; when set, will show the return
  value of a function in the function graph tracer.

- Also add the option: funcgraph-retval-hex where if it is not set, and
  the return value is an error code, then it will return the decimal of
  the error code, otherwise it still reports the hex value.

- Add the file /sys/kernel/tracing/osnoise/per_cpu/cpu<cpu>/timerlat_fd
  That when a application opens it, it becomes the task that the timer lat
  tracer traces. The application can also read this file to find out how
  it's being interrupted.

- Add the file /sys/kernel/tracing/available_filter_functions_addrs
  that works just the same as available_filter_functions but also shows
  the addresses of the functions like kallsyms, except that it gives the
  address of where the fentry/mcount jump/nop is. This is used by BPF to
  make it easier to attach BPF programs to ftrace hooks.

- Replace strlcpy with strscpy in the tracing boot code.


Please pull the latest trace-v6.5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.5

Tag SHA1: 2560e018ceb91b477882b941216b9c5a3c0e4316
Head SHA1: fc30ace06f250f79381a8e3f6ed92dd68e25a9f5


Azeem Shaikh (1):
      tracing/boot: Replace strlcpy with strscpy

Daniel Bristot de Oliveira (3):
      tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
      tracing/osnoise: Skip running osnoise if all instances are off
      tracing/timerlat: Add user-space interface

Donglin Peng (8):
      function_graph: Support recording and printing the return value of function
      tracing: Add documentation for funcgraph-retval and funcgraph-retval-hex
      arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      selftests/ftrace: Add funcgraph-retval test case
      riscv: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      tracing: Fix warnings when building htmldocs for function graph retval

Jiri Olsa (1):
      ftrace: Show all functions with addresses in available_filter_functions_addrs

Steven Rostedt (Google) (1):
      fgraph: Add declaration of "struct fgraph_ret_regs"

----
 Documentation/trace/ftrace.rst                     | 132 ++++++
 Documentation/trace/timerlat-tracer.rst            |  78 ++++
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/ftrace.h                    |  22 +
 arch/arm64/kernel/asm-offsets.c                    |  13 +
 arch/arm64/kernel/entry-ftrace.S                   |  27 +-
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/include/asm/ftrace.h                |  22 +
 arch/loongarch/kernel/asm-offsets.c                |  15 +-
 arch/loongarch/kernel/mcount.S                     |  14 +-
 arch/loongarch/kernel/mcount_dyn.S                 |  15 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/include/asm/ftrace.h                    |  21 +
 arch/riscv/kernel/mcount.S                         |   7 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/ftrace.h                      |  20 +
 arch/x86/kernel/ftrace_32.S                        |   8 +-
 arch/x86/kernel/ftrace_64.S                        |   7 +-
 include/linux/ftrace.h                             |   4 +
 kernel/trace/Kconfig                               |  15 +
 kernel/trace/fgraph.c                              |  26 +-
 kernel/trace/ftrace.c                              |  37 ++
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_boot.c                          |   8 +-
 kernel/trace/trace_entries.h                       |  26 ++
 kernel/trace/trace_functions_graph.c               |  93 +++-
 kernel/trace/trace_osnoise.c                       | 477 ++++++++++++++++++++-
 kernel/trace/trace_output.c                        |   4 +-
 .../ftrace/test.d/ftrace/fgraph-retval.tc          |  44 ++
 29 files changed, 1079 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
---------------------------

