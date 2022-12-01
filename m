Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF563F305
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiLAOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiLAOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:39:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33406A8943
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D91BBB81F54
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81049C43151;
        Thu,  1 Dec 2022 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669905546;
        bh=DsgCcdAHypRC6WE6LOjXeWdrtqezoJ6nKI9UU3nEiy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2mmCU40nv1ThpqRBWHEKBqrN9tkNf47L+j+hfULS3VDH8XiT6/m90vxYw5cFCE1w
         UlncFgw+C/1elEWCXX7rDIPBONFaWgK3Fq/p8BcEobwxAGeS0+TtqkqxZKnzKCFXnZ
         zen4jEelxst3aZzPz14n+KtLJ+CNkaLXnj52RecGhX7qfhRHgClH0QIrHoVxHUXULk
         9psIqagbN+VFQg0n8quC7CAdve+sN+fkakAgxiuC22e5Tu0yoTOCg0JfrULgYN1t7l
         R/8PahDQ5wTyHkAdSSbM/ftodBYiuJXzpgxtSA1gtX5ZgKP0Jl299whyi2kVzlVpA0
         I57Q2iofRPa0A==
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
Subject: [PATCH 1/3] arm64: Prohibit probing on arch_stack_walk()
Date:   Thu,  1 Dec 2022 23:39:02 +0900
Message-Id: <166990554210.253128.7378208454827328942.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <166990553243.253128.13594802750635478633.stgit@devnote3>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
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

Make arch_stack_walk() as NOKPROBE_SYMBOL and make other inline functions
called from arch_stack_walk() as nokprobe_inline so that user does not
put probe on it, because this function can be used from return_address()
which is already NOKPROBE_SYMBOL.

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
 arch/arm64/kernel/stacktrace.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 634279b3b03d..b0e913f944b4 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -23,7 +23,7 @@
  *
  * The regs must be on a stack currently owned by the calling task.
  */
-static inline void unwind_init_from_regs(struct unwind_state *state,
+static nokprobe_inline void unwind_init_from_regs(struct unwind_state *state,
 					 struct pt_regs *regs)
 {
 	unwind_init_common(state, current);
@@ -40,7 +40,7 @@ static inline void unwind_init_from_regs(struct unwind_state *state,
  *
  * The function which invokes this must be noinline.
  */
-static __always_inline void unwind_init_from_caller(struct unwind_state *state)
+static nokprobe_inline void unwind_init_from_caller(struct unwind_state *state)
 {
 	unwind_init_common(state, current);
 
@@ -58,7 +58,7 @@ static __always_inline void unwind_init_from_caller(struct unwind_state *state)
  * duration of the unwind, or the unwind will be bogus. It is never valid to
  * call this for the current task.
  */
-static inline void unwind_init_from_task(struct unwind_state *state,
+static nokprobe_inline void unwind_init_from_task(struct unwind_state *state,
 					 struct task_struct *task)
 {
 	unwind_init_common(state, task);
@@ -218,3 +218,4 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	unwind(&state, consume_entry, cookie);
 }
+NOKPROBE_SYMBOL(arch_stack_walk);

