Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47C163EBA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLAI4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLAI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:56:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAD3D92D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:56:13 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NN8zj1tt2zmWNl;
        Thu,  1 Dec 2022 16:55:29 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 16:56:10 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 16:56:10 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
Subject: [PATCH] x86/unwind/orc: Fix unwind ip when kprobes hits push/pop
Date:   Thu, 1 Dec 2022 16:53:11 +0800
Message-ID: <20221201085311.249883-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unwind stack at asm_exc_int3, the orc type is UNWIND_HINT_TYPE_REGS
and the unwinder will use pt_regs->ip to find next orc, which point to
the probed insn + INT3_INSN_SIZE.

If the probed insn is push/pop, it will point to the next insn which has
different orc state. Before the probed insn has been really excuted in
single step, using next insn ip to find orc will get a wrong unwinding
result.

So, when there is kprobe running and the previous op code is int3,
state->signal should be false so that ip - 1 will be used to find next
orc, until the probed push/pop has been single steped and kprobe set
kprobe_status as KPROBE_HIT_SSDONE.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
dump_stack() in pre_handler probing push:

 Call Trace:
  <TASK>
  dump_stack_lvl+0x79/0x9b
  push_handler_pre+0x1b/0x2e [kp_unwind]
  aggr_pre_handler+0xd8/0x180
  ? opt_pre_handler+0x160/0x160
  ? run_push+0xd/0x61 [kp_unwind]
  kprobe_int3_handler+0x3f3/0x530
  do_int3+0x3b/0x80
  exc_int3+0x2b/0x80
  asm_exc_int3+0x35/0x40
 RIP: 0010:run_push+0xd/0x61 [kp_unwind]
 RSP: 0018:ffff88800650f998 EFLAGS: 00000293
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffc0708060
 RDX: ffff8880124b0000 RSI: 0000000000000000 RDI: ffffed1000ca1f28
 RBP: 0000000000000000 R08: 0000000000000020 R09: ffffed1000ca1ef7
 R10: ffff88800650f7b7 R11: ffffed1000ca1ef6 R12: ffffffffc0668000
 R13: 0000000000000000 R14: fffffbfff80e14f8 R15: 1ffffffff80e14f9
  ? 0xffffffffc0668000
  ? run_push+0xb/0x61 [kp_unwind]
  ? run_push+0xd/0x61 [kp_unwind]
  ? kprobe_init+0x8a/0x1000 [kp_unwind]
  ? do_one_initcall+0xd0/0x4e0
  ? trace_event_raw_event_initcall_level+0x1c0/0x1c0
  ? rcu_read_lock_sched_held+0xa5/0xd0
  ? rcu_read_lock_bh_held+0xc0/0xc0
  ? __kmem_cache_alloc_node+0x1da/0x780
  ? kasan_unpoison+0x23/0x50
  ? 0xffffffffc0668000
  ? do_init_module+0x1cc/0x6a0
  ? load_module+0x5eee/0x7210
  ? ext4_file_read_iter+0x161/0x3a0
  ? module_frob_arch_sections+0x40/0x40
  ? security_file_permission+0x408/0x600
  ? security_kernel_post_read_file+0x93/0xc0
  ? __do_sys_finit_module+0x13c/0x200
  ? __do_sys_finit_module+0x13c/0x200
  ? __ia32_sys_init_module+0xb0/0xb0
  ? rcu_read_lock_bh_held+0xc0/0xc0
  ? rcu_read_lock_bh_held+0xc0/0xc0
  ? syscall_enter_from_user_mode+0x1d/0x50
  ? syscall_enter_from_user_mode+0x1d/0x50
  ? do_syscall_64+0x38/0x90
  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
  </TASK>

After apply this patch, stack trace is correct: 

 Call Trace:
  <TASK>
  dump_stack_lvl+0x79/0x9b
  push_handler_post+0x1b/0x27 [kp_unwind]
  aggr_post_handler+0xdc/0x160
  ? aggr_pre_handler+0x180/0x180
  ? run_push+0xc/0x61 [kp_unwind]
  kprobe_post_process+0x7b/0x210
  kprobe_int3_handler+0x307/0x530
  ? 0xffffffffc0770000
  ? 0xffffffffc0770002
  do_int3+0x3b/0x80
  exc_int3+0x2b/0x80
  asm_exc_int3+0x35/0x40
 RIP: 0010:run_push+0xd/0x61 [kp_unwind]
 RSP: 0018:ffff88801014f9a0 EFLAGS: 00000293
 RAX: 0000000000000293 RBX: 0000000000000000 RCX: ffffffffc0760060
 RDX: ffff88800d1f8000 RSI: 0000000000000000 RDI: ffffed1002029f28
 RBP: 0000000000000000 R08: 0000000000000020 R09: ffffed1002029ef7
 R10: ffff88801014f7b7 R11: ffffed1002029ef6 R12: ffffffffc0768000
 R13: 0000000000000003 R14: fffffbfff80ec4f8 R15: 1ffffffff80ec4f9
  ? 0xffffffffc0768000
  ? run_push+0xb/0x61 [kp_unwind]
  ? 0xffffffffc0770002
  kprobe_init+0x8a/0x1000 [kp_unwind]
  do_one_initcall+0xd0/0x4e0
  ? trace_event_raw_event_initcall_level+0x1c0/0x1c0
  ? rcu_read_lock_sched_held+0xa5/0xd0
  ? rcu_read_lock_bh_held+0xc0/0xc0
  ? __kmem_cache_alloc_node+0x1da/0x780
  ? kasan_unpoison+0x23/0x50
  ? 0xffffffffc0768000
  do_init_module+0x1cc/0x6a0
  load_module+0x5eee/0x7210
  ? ext4_file_read_iter+0x161/0x3a0
  ? module_frob_arch_sections+0x40/0x40
  ? security_file_permission+0x408/0x600
  ? security_kernel_post_read_file+0x93/0xc0
  ? __do_sys_finit_module+0x13c/0x200
  __do_sys_finit_module+0x13c/0x200
  ? __ia32_sys_init_module+0xb0/0xb0
  ? rcu_read_lock_bh_held+0xc0/0xc0
  ? rcu_read_lock_bh_held+0xc0/0xc0
  ? syscall_enter_from_user_mode+0x1d/0x50
  ? syscall_enter_from_user_mode+0x1d/0x50
  do_syscall_64+0x38/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0033:0x7fe46ad1b839
---
 arch/x86/kernel/unwind_orc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index c059820dfaea..81e74b7e7fda 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -2,6 +2,7 @@
 #include <linux/objtool.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <linux/kprobes.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -425,6 +426,7 @@ bool unwind_next_frame(struct unwind_state *state)
 	enum stack_type prev_type = state->stack_info.type;
 	struct orc_entry *orc;
 	bool indirect = false;
+	u8 op;
 
 	if (unwind_done(state))
 		return false;
@@ -568,7 +570,21 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
 		state->full_regs = true;
-		state->signal = true;
+#ifdef CONFIG_KPROBES
+		/*
+		 * When kprobe replaces push/pop to int3, pt_regs->ip points to
+		 * the next insn which has different orc state.
+		 * Before push/pop is really excuted in single step, signal should
+		 * be set to false so we will use ip - 1 to find correct next orc.
+		 */
+		if (kprobe_running() &&
+			get_kprobe_ctlblk()->kprobe_status != KPROBE_HIT_SSDONE &&
+			!get_kernel_nofault(op, (u8 *)state->ip - 1) &&
+			op == INT3_INSN_OPCODE)
+			state->signal = false;
+		else
+#endif
+			state->signal = true;
 		break;
 
 	case UNWIND_HINT_TYPE_REGS_PARTIAL:
-- 
2.17.1

