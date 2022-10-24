Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C460BEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJXXef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJXXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:34:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30E102F092C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:54:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 805DBED1;
        Mon, 24 Oct 2022 07:09:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 294D33F792;
        Mon, 24 Oct 2022 07:08:53 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: [PATCH 0/4] arm64/ftrace: move to DYNAMIC_FTRACE_WITH_ARGS
Date:   Mon, 24 Oct 2022 15:08:42 +0100
Message-Id: <20221024140846.3555435-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces arm64's support for FTRACE_WITH_REGS with support
for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
removes some latent issues with inconsistent presentation of struct
pt_regs (which can only be reliably saved/restored at exception
boundaries).

The existing FTRACE_WITH_REGS support was added for two major reasons:

(1) To make it possible to use the ftrace graph tracer with pointer
    authentication, where it's necessary to snapshot/manipulate the LR
    before it is signed by the instrumented function.

(2) To make it possible to implement LIVEPATCH in future, where we need
    to hook function entry before an instrumented function manipulates
    the stack or argument registers. Practically speaking, we need to
    preserve the argument/return registers, PC, LR, and SP.

Neither of these requires the full set of pt_regs, and only requires us
to save/restore a subset of registers used for passing
arguments/return-values and context/return information (which is the
minimum set we always need to save/restore today).

As there is no longer a need to save different sets of registers for
different features, we no longer need distinct `ftrace_caller` and
`ftrace_regs_caller` trampolines. This allows the trampoline assembly to
be simpler, and simplifies code which previously had to handle the two
trampolines.

I've tested this with the ftrace selftests, where there are no
unexpected failures.

I plan to build atop this with subsequent patches to add per-callsite
ftrace_ops, and I'm sending these patches on their own as I think they
make sense regardless.

Thanks,
Mark.

Mark Rutland (4):
  ftrace: pass fregs to arch_ftrace_set_direct_caller()
  ftrace: rename ftrace_instruction_pointer_set() ->
    ftrace_regs_set_instruction_pointer()
  ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
  ftrace: arm64: move from REGS to ARGS

 arch/arm64/Kconfig                |  18 +++--
 arch/arm64/Makefile               |   2 +-
 arch/arm64/include/asm/ftrace.h   |  70 ++++++++++++++++--
 arch/arm64/kernel/asm-offsets.c   |  13 ++++
 arch/arm64/kernel/entry-ftrace.S  | 117 ++++++++++++------------------
 arch/arm64/kernel/ftrace.c        |  37 +---------
 arch/arm64/kernel/module.c        |   3 -
 arch/powerpc/include/asm/ftrace.h |  22 +++++-
 arch/s390/include/asm/ftrace.h    |  25 ++++++-
 arch/x86/include/asm/ftrace.h     |  42 +++++++----
 include/linux/ftrace.h            |  40 ++++++++--
 kernel/livepatch/patch.c          |   2 +-
 kernel/trace/Kconfig              |   6 +-
 kernel/trace/ftrace.c             |   3 +-
 14 files changed, 247 insertions(+), 153 deletions(-)

-- 
2.30.2

