Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87D74328F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjF3CJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjF3CJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:09:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B581BD3;
        Thu, 29 Jun 2023 19:09:36 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qsdzc12KWz1HCPZ;
        Fri, 30 Jun 2023 10:09:16 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 10:09:34 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <stable@vger.kernel.org>
CC:     <mhiramat@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <xukuohai@huawei.com>, <lihuafei1@huawei.com>
Subject: [PATCH 5.10] kprobes/x86: Fix kprobe debug exception handling logic
Date:   Fri, 30 Jun 2023 10:08:45 +0800
Message-ID: <20230630020845.227939-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get the following crash caused by a null pointer access:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 ...
 RIP: 0010:resume_execution+0x35/0x190
 ...
 Call Trace:
  <#DB>
  kprobe_debug_handler+0x41/0xd0
  exc_debug+0xe5/0x1b0
  asm_exc_debug+0x19/0x30
 RIP: 0010:copy_from_kernel_nofault.part.0+0x55/0xc0
 ...
  </#DB>
  process_fetch_insn+0xfb/0x720
  kprobe_trace_func+0x199/0x2c0
  ? kernel_clone+0x5/0x2f0
  kprobe_dispatcher+0x3d/0x60
  aggr_pre_handler+0x40/0x80
  ? kernel_clone+0x1/0x2f0
  kprobe_ftrace_handler+0x82/0xf0
  ? __se_sys_clone+0x65/0x90
  ftrace_ops_assist_func+0x86/0x110
  ? rcu_nocb_try_bypass+0x1f3/0x370
  0xffffffffc07e60c8
  ? kernel_clone+0x1/0x2f0
  kernel_clone+0x5/0x2f0

The analysis reveals that kprobe and hardware breakpoints conflict in
the use of debug exceptions.

If we set a hardware breakpoint on a memory address and also have a
kprobe event to fetch the memory at this address. Then when kprobe
triggers, it goes to read the memory and triggers hardware breakpoint
monitoring. This time, since kprobe handles debug exceptions earlier
than hardware breakpoints, it will cause kprobe to incorrectly assume
that the exception is a kprobe trigger.

Notice that after the mainline commit 6256e668b7af ("x86/kprobes: Use
int3 instead of debug trap for single-step"), kprobe no longer uses
debug trap, avoiding the conflict with hardware breakpoints here. This
commit is to remove the IRET that returns to kernel, not to fix the
problem we have here. Also there are a bunch of merge conflicts when
trying to apply this commit to older kernels, so fixing it directly in
older kernels is probably a better option.

If the debug exception is triggered by kprobe, then regs->ip should be
located in the kprobe instruction slot. Add this check to
kprobe_debug_handler() to properly determine if a debug exception should
be handled by kprobe.

The stable kernels affected are 5.10, 5.4, 4.19, and 4.14. I made the
fix in 5.10, and we should probably apply this fix to other stable
kernels.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 5de757099186..fd8d7d128807 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -900,7 +900,14 @@ int kprobe_debug_handler(struct pt_regs *regs)
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	if (!cur)
+	if (!cur || !cur->ainsn.insn)
+		return 0;
+
+	/* regs->ip should be the address of next instruction to
+	 * cur->ainsn.insn.
+	 */
+	if (regs->ip < (unsigned long)cur->ainsn.insn ||
+	    regs->ip - (unsigned long)cur->ainsn.insn > MAX_INSN_SIZE)
 		return 0;
 
 	resume_execution(cur, regs, kcb);
-- 
2.17.1

