Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D9862CEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiKPXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiKPXd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:33:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C632B9C;
        Wed, 16 Nov 2022 15:33:56 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:33:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668641634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Rrwn3XiFQACWItqwB/rq8DEZB6S62a07vlj6rycE4sg=;
        b=igKRZ4urK0SUk7PUglIhEmy+DBYKAVRCLlJXDAGbc3LXhNu0fIaInVhY3ghzijMVSs6KfM
        HXnrmWZYgEpDhVLQerBILAVeyhFDAqWpePfzX8Ao06I+4owOemWe1uqN7KIjTqZpERoAet
        i4n278nI+bBMFcxCkfEAVzvAD9b/ZWTbcaIHK4LsKLeoXw5DdxY7nCu8H4AKqW9oTQS+b6
        hPEGly4bj5DDOc3tg2gqTOzCEX+gfBHbP1xThFK39NZIlbHEoddB/0X1IPsVBIjiy8w5X1
        TSmFeD6s0jhIW18QnDYNCR3R6RgXQ/PrMvX46BWYJKhR5vUSBz2wHbuVbSnW4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668641634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Rrwn3XiFQACWItqwB/rq8DEZB6S62a07vlj6rycE4sg=;
        b=Szud7kgtTdq3cvWh8KlA5MoYg6Uuk9Q/R6S1BQLUATmml/rhkwNW46WZwRU4zq3lXax95f
        wIg7UM3Xvxzyw/DQ==
From:   "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add a pkru argument to
 copy_uabi_from_kernel_to_xstate().
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166864163317.4906.15150213496380358511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1c813ce0305571e1b2e4cc4acca451da9e6ad18f
Gitweb:        https://git.kernel.org/tip/1c813ce0305571e1b2e4cc4acca451da9e6ad18f
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Tue, 15 Nov 2022 15:09:28 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 16 Nov 2022 15:03:01 -08:00

x86/fpu: Add a pkru argument to copy_uabi_from_kernel_to_xstate().

Both KVM (through KVM_SET_XSTATE) and ptrace (through PTRACE_SETREGSET
with NT_X86_XSTATE) ultimately call copy_uabi_from_kernel_to_xstate(),
but the canonical locations for the current PKRU value for KVM guests
and processes in a ptrace stop are different (in the kvm_vcpu_arch and
the thread_state structs respectively).

In preparation for eventually handling PKRU in
copy_uabi_to_xstate, pass in a pointer to the PKRU location.

Signed-off-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221115230932.7126-3-khuey%40kylehuey.com
---
 arch/x86/kernel/fpu/core.c   | 2 +-
 arch/x86/kernel/fpu/regset.c | 2 +-
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/fpu/xstate.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3b28c5b..5501576 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -406,7 +406,7 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
-	ret = copy_uabi_from_kernel_to_xstate(kstate, ustate);
+	ret = copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 75ffaef..6d056b6 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -167,7 +167,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf, &target->thread.pkru);
 
 out:
 	vfree(tmpbuf);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c88c60b..d6f414a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1268,7 +1268,7 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
  * format and copy to the target thread. Used by ptrace and KVM.
  */
-int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru)
 {
 	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
 }
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index f08ee27..a4ecb04 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -46,7 +46,7 @@ extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 				      u32 pkru_val, enum xstate_copy_mode copy_mode);
 extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 				    enum xstate_copy_mode mode);
-extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf);
+extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru);
 extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void __user *ubuf);
 
 
