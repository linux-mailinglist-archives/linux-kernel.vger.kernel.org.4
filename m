Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A76627EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjAIN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbjAIN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:58:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D109F25CD;
        Mon,  9 Jan 2023 05:58:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80ABAAD7;
        Mon,  9 Jan 2023 05:59:19 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9AB63F23F;
        Mon,  9 Jan 2023 05:58:35 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH 0/8] arm64/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
Date:   Mon,  9 Jan 2023 13:58:20 +0000
Message-Id: <20230109135828.879136-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new DYNAMIC_FTRACE_WITH_CALL_OPS mechanism, and
enables support for this on arm64. This significantly reduces the
overhead of tracing when a callsite/tracee has a single associated
tracer, avoids a number of issues that make it undesireably and
infeasible to use dynamically-allocated trampolines (e.g. branch range
limitations), and makes it possible to implement support for
DYNAMIC_FTRACE_WITH_DIRECT_CALLS in future.

The main idea is to give each ftrace callsite an associated pointer to
an ftrace_ops. The architecture's ftrace_caller trampoline can recover
the ops pointer and invoke ops->func from this without needing to use
ftrace_ops_list_func, which has to iterate through all registered ops.

To do this, we use -fpatchable-function-entry=M,N, there N NOPs are
placed before the function entry point. On arm64 NOPs are always 4
bytes, so by allocating 2 per-function NOPs, we have enaough space to
place a 64-bit value. So that we can manipulate the pointer atomically,
we need to align instrumented functions to at least 8 bytes.

The first three patches enable this function alignment, requiring
changes to the ACPICA Makefile, and working around cases where GCC drops
alignment.

The final four patches implement support for arm64. As noted in the
final patch, this results in a significant reduction in overhead:

  Before this patch:

  Number of tracers     || Total time  | Per-call average time (ns)
  Relevant | Irrelevant || (ns)        | Total        | Overhead
  =========+============++=============+==============+============
         0 |          0 ||      94,583 |         0.95 |           -
         0 |          1 ||      93,709 |         0.94 |           -
         0 |          2 ||      93,666 |         0.94 |           -
         0 |         10 ||      93,709 |         0.94 |           -
         0 |        100 ||      93,792 |         0.94 |           -
  ---------+------------++-------------+--------------+------------
         1 |          1 ||   6,467,833 |        64.68 |       63.73
         1 |          2 ||   7,509,708 |        75.10 |       74.15
         1 |         10 ||  23,786,792 |       237.87 |      236.92
         1 |        100 || 106,432,500 |     1,064.43 |     1063.38
  ---------+------------++-------------+--------------+------------
         1 |          0 ||   1,431,875 |        14.32 |       13.37
         2 |          0 ||   6,456,334 |        64.56 |       63.62
        10 |          0 ||  22,717,000 |       227.17 |      226.22
       100 |          0 || 103,293,667 |      1032.94 |     1031.99
  ---------+------------++-------------+--------------+--------------

  Note: per-call overhead is estiamated relative to the baseline case
  with 0 relevant tracers and 0 irrelevant tracers.

  After this patch

  Number of tracers     || Total time  | Per-call average time (ns)
  Relevant | Irrelevant || (ns)        | Total        | Overhead
  =========+============++=============+==============+============
         0 |          0 ||      94,541 |         0.95 |           -
         0 |          1 ||      93,666 |         0.94 |           -
         0 |          2 ||      93,709 |         0.94 |           -
         0 |         10 ||      93,667 |         0.94 |           -
         0 |        100 ||      93,792 |         0.94 |           -
  ---------+------------++-------------+--------------+------------
         1 |          1 ||     281,000 |         2.81 |        1.86
         1 |          2 ||     281,042 |         2.81 |        1.87
         1 |         10 ||     280,958 |         2.81 |        1.86
         1 |        100 ||     281,250 |         2.81 |        1.87
  ---------+------------++-------------+--------------+------------
         1 |          0 ||     280,959 |         2.81 |        1.86
         2 |          0 ||   6,502,708 |        65.03 |       64.08
        10 |          0 ||  18,681,209 |       186.81 |      185.87
       100 |          0 || 103,550,458 |     1,035.50 |     1034.56
  ---------+------------++-------------+--------------+------------

  Note: per-call overhead is estiamated relative to the baseline case
  with 0 relevant tracers and 0 irrelevant tracers.

Thanks,
Mark.

Mark Rutland (8):
  Compiler attributes: GCC function alignment workarounds
  ACPI: Don't build ACPICA with '-Os'
  arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
  ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
  arm64: insn: Add helpers for BTI
  arm64: patching: Add aarch64_insn_write_literal_u64()
  arm64: ftrace: Update stale comment
  arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS

 arch/arm64/Kconfig                  |   3 +
 arch/arm64/Makefile                 |   5 +-
 arch/arm64/include/asm/ftrace.h     |  15 +--
 arch/arm64/include/asm/insn.h       |   1 +
 arch/arm64/include/asm/linkage.h    |  10 +-
 arch/arm64/include/asm/patching.h   |   2 +
 arch/arm64/kernel/asm-offsets.c     |   4 +
 arch/arm64/kernel/entry-ftrace.S    |  32 +++++-
 arch/arm64/kernel/ftrace.c          | 158 +++++++++++++++++++++++++++-
 arch/arm64/kernel/patching.c        |  17 +++
 drivers/acpi/acpica/Makefile        |   2 +-
 include/linux/compiler_attributes.h |  23 +++-
 include/linux/ftrace.h              |  15 ++-
 kernel/trace/Kconfig                |   7 ++
 kernel/trace/ftrace.c               | 109 ++++++++++++++++++-
 15 files changed, 371 insertions(+), 32 deletions(-)

-- 
2.30.2

