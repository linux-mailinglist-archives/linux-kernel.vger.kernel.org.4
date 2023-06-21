Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F9738B31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFUQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjFUQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847241994
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB86615EF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A41FC433C0;
        Wed, 21 Jun 2023 16:29:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iG-001yiF-1X;
        Wed, 21 Jun 2023 12:29:44 -0400
Message-ID: <20230621162923.953123395@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing: Updates for 6.5
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 513f25cdf82cec8eb98b111dc0570116562391e0


Azeem Shaikh (1):
      tracing/boot: Replace strlcpy with strscpy

Daniel Bristot de Oliveira (3):
      tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
      tracing/osnoise: Skip running osnoise if all instances are off
      tracing/timerlat: Add user-space interface

Donglin Peng (7):
      function_graph: Support recording and printing the return value of function
      tracing: Add documentation for funcgraph-retval and funcgraph-retval-hex
      arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
      selftests/ftrace: Add funcgraph-retval test case
      riscv: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL

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
