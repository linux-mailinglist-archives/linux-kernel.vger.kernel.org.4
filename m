Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F3607F96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJUUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJUUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:16:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F329E5A0;
        Fri, 21 Oct 2022 13:16:52 -0700 (PDT)
Date:   Fri, 21 Oct 2022 20:16:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666383410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rL3oVgJETn6O3bWX+jYbwettXNPsuf0/KLBlpRfdKuE=;
        b=G6Ofe4e6tD9SxU/71931ZAZDTZV+6Mhp+qlH8PVmta9/th+zFdLai0I9J2x9BbBwCogiw3
        B8Lff1+vm5oUt1mLynEbJu7AQybbmb6O+2R/3xvd3e2SE9GM00qwOpx5Lbkn7sDm402DIO
        yROQMzupcP/rdCKl3Ev4jPWgdEevbe5SL6AgS3Jn8+nWJ2WYBxpwNLNQeuKK6uobwAQ3I4
        rQIAX5uNWuDNT9IgeNrPdPZ3lw+FYIfQpmy0FKp3/5XUuxtaeeUJQZ3UO+IRfAcoZ93osm
        nf9RoFHbRAH5xc1JHw5s8K1pfbsEwUSDaCKeMVhSkVrvQaW+DntPS+NnMH7USg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666383410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rL3oVgJETn6O3bWX+jYbwettXNPsuf0/KLBlpRfdKuE=;
        b=jcLVAxS35afWjaCEppXqwCwEbcMTTjDaZf2DfNJOhgauV6ImL/kUor/TX8CGwYswMkdc7J
        URj49hczmkOYEwDw==
From:   "tip-bot2 for Chen Zhongjin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/unwind/orc: Fix unreliable stack dump with gcov
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166638340876.401.7064883651633264359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     230db82413c091bc16acee72650f48d419cebe49
Gitweb:        https://git.kernel.org/tip/230db82413c091bc16acee72650f48d419cebe49
Author:        Chen Zhongjin <chenzhongjin@huawei.com>
AuthorDate:    Wed, 27 Jul 2022 11:15:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Oct 2022 14:56:42 +02:00

x86/unwind/orc: Fix unreliable stack dump with gcov

When a console stack dump is initiated with CONFIG_GCOV_PROFILE_ALL
enabled, show_trace_log_lvl() gets out of sync with the ORC unwinder,
causing the stack trace to show all text addresses as unreliable:

  # echo l > /proc/sysrq-trigger
  [  477.521031] sysrq: Show backtrace of all active CPUs
  [  477.523813] NMI backtrace for cpu 0
  [  477.524492] CPU: 0 PID: 1021 Comm: bash Not tainted 6.0.0 #65
  [  477.525295] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
  [  477.526439] Call Trace:
  [  477.526854]  <TASK>
  [  477.527216]  ? dump_stack_lvl+0xc7/0x114
  [  477.527801]  ? dump_stack+0x13/0x1f
  [  477.528331]  ? nmi_cpu_backtrace.cold+0xb5/0x10d
  [  477.528998]  ? lapic_can_unplug_cpu+0xa0/0xa0
  [  477.529641]  ? nmi_trigger_cpumask_backtrace+0x16a/0x1f0
  [  477.530393]  ? arch_trigger_cpumask_backtrace+0x1d/0x30
  [  477.531136]  ? sysrq_handle_showallcpus+0x1b/0x30
  [  477.531818]  ? __handle_sysrq.cold+0x4e/0x1ae
  [  477.532451]  ? write_sysrq_trigger+0x63/0x80
  [  477.533080]  ? proc_reg_write+0x92/0x110
  [  477.533663]  ? vfs_write+0x174/0x530
  [  477.534265]  ? handle_mm_fault+0x16f/0x500
  [  477.534940]  ? ksys_write+0x7b/0x170
  [  477.535543]  ? __x64_sys_write+0x1d/0x30
  [  477.536191]  ? do_syscall_64+0x6b/0x100
  [  477.536809]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
  [  477.537609]  </TASK>

This happens when the compiled code for show_stack() has a single word
on the stack, and doesn't use a tail call to show_stack_log_lvl().
(CONFIG_GCOV_PROFILE_ALL=y is the only known case of this.)  Then the
__unwind_start() skip logic hits an off-by-one bug and fails to unwind
all the way to the intended starting frame.

Fix it by reverting the following commit:

  f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")

The original justification for that commit no longer exists.  That
original issue was later fixed in a different way, with the following
commit:

  f2ac57a4c49d ("x86/unwind/orc: Fix inactive tasks with stack pointer in %sp on GCC 10 compiled kernels")

Fixes: f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
[jpoimboe: rewrite commit log]
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 0ea57da..c059820 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -713,7 +713,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	/* Otherwise, skip ahead to the user-specified starting frame: */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp < (unsigned long)first_frame))
+			state->sp <= (unsigned long)first_frame))
 		unwind_next_frame(state);
 
 	return;
