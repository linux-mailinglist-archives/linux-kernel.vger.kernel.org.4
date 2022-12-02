Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4C63FE13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiLBCSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLBCSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:18:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715ECAF96
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6C9621EF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6393C433D6;
        Fri,  2 Dec 2022 02:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669947517;
        bh=d/lXGG0C2aiD02jOJY4ptnK9ZuIklkzqbOFkMk8yr0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIcOtysO/1w3lc+kLQuqC0ib2g7qPgkTgrCEhLuYzBJpk/gtzaibZPU4g2BgqOhRf
         mDc07gKkTVFokUSPi/PCJBp6rerTt+MmmmR1Cx8dUD/qfKSdvUOikLBrtp/R/VtQid
         fRv9cybKiXw4Nfgjbb9hVipdUBiWS2kdrTtUPPkqo4KQ6lNl+aTRmHxt3KqAPMk6jN
         Mplg13O9zyrFyUNYQI3JiAJgntKbbRH+gZqNO/pEIMOZYvZRzUg497vpeVCxsUYn7i
         pUhJDFtfRX/5/DgCW7aGnfvPeaYG4ECIwh41hqpPObpsFZDK56a+XEZn0ipoHUNd8D
         sWxn78mF86hdQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: [PATCH v2 1/3] arm64: Prohibit instrumentation on arch_stack_walk()
Date:   Fri,  2 Dec 2022 11:18:33 +0900
Message-Id: <166994751368.439920.3236636557520824664.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <166994750386.439920.1754385804350980158.stgit@devnote3>
References: <166994750386.439920.1754385804350980158.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Mark arch_stack_walk() as noinstr instead of notrace and inline functions
called from arch_stack_walk() as __always_inline so that user does not
put any instrumentations on it, because this function can be used from
return_address() which is used by lockdep.

Without this, if the kernel built with CONFIG_LOCKDEP=y, just probing
arch_stack_walk() via <tracefs>/kprobe_events will crash the kernel on
arm64.

 # echo p arch_stack_walk >> ${TRACEFS}/kprobe_events
 # echo 1 > ${TRACEFS}/events/kprobes/enable
  kprobes: Failed to recover from reentered kprobes.
  kprobes: Dump kprobe:
  .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
  ------------[ cut here ]------------
  kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
  kprobes: Failed to recover from reentered kprobes.
  kprobes: Dump kprobe:
  .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
  ------------[ cut here ]------------
  kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
  PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 17 Comm: migration/0 Tainted: G                 N 6.1.0-rc5+ #6
  Hardware name: linux,dummy-virt (DT)
  Stopper: 0x0 <- 0x0
  pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : kprobe_breakpoint_handler+0x178/0x17c
  lr : kprobe_breakpoint_handler+0x178/0x17c
  sp : ffff8000080d3090
  x29: ffff8000080d3090 x28: ffff0df5845798c0 x27: ffffc4f59057a774
  x26: ffff0df5ffbba770 x25: ffff0df58f420f18 x24: ffff49006f641000
  x23: ffffc4f590579768 x22: ffff0df58f420f18 x21: ffff8000080d31c0
  x20: ffffc4f590579768 x19: ffffc4f590579770 x18: 0000000000000006
  x17: 5f6b636174735f68 x16: 637261203d207264 x15: 64612e202c30203d
  x14: 2074657366666f2e x13: 30633178302f3078 x12: 302b6b6c61775f6b
  x11: 636174735f686372 x10: ffffc4f590dc5bd8 x9 : ffffc4f58eb31958
  x8 : 00000000ffffefff x7 : ffffc4f590dc5bd8 x6 : 80000000fffff000
  x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : 0000000000000000 x1 : ffff0df5845798c0 x0 : 0000000000000064
  Call trace:
  kprobes: Failed to recover from reentered kprobes.
  kprobes: Dump kprobe:
  .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
  ------------[ cut here ]------------
  kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!

Fixes: 39ef362d2d45 ("arm64: Make return_address() use arch_stack_walk()")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use noinstr instead of NOKPROBE_SYMBOL()
  - Use __always_inline because nokprobe_inline will be changed if
    CONFIG_KPROBES=n.
  - Fix indentation.
---
 arch/arm64/kernel/stacktrace.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 634279b3b03d..117e2c180f3c 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -23,8 +23,8 @@
  *
  * The regs must be on a stack currently owned by the calling task.
  */
-static inline void unwind_init_from_regs(struct unwind_state *state,
-					 struct pt_regs *regs)
+static __always_inline void unwind_init_from_regs(struct unwind_state *state,
+						  struct pt_regs *regs)
 {
 	unwind_init_common(state, current);
 
@@ -58,8 +58,8 @@ static __always_inline void unwind_init_from_caller(struct unwind_state *state)
  * duration of the unwind, or the unwind will be bogus. It is never valid to
  * call this for the current task.
  */
-static inline void unwind_init_from_task(struct unwind_state *state,
-					 struct task_struct *task)
+static __always_inline void unwind_init_from_task(struct unwind_state *state,
+						  struct task_struct *task)
 {
 	unwind_init_common(state, task);
 
@@ -186,7 +186,7 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 			: stackinfo_get_unknown();		\
 	})
 
-noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
+noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
 			      void *cookie, struct task_struct *task,
 			      struct pt_regs *regs)
 {

