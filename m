Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BCC733983
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjFPTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFPTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:16:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C6E35AD;
        Fri, 16 Jun 2023 12:16:57 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UmtZngEwGEglvAjwA1iZWOHFlGGQMSgXWHHhk2pwUQI=;
        b=xRQrYTKJQJ9BECIYsswb/M/tkHhl6sEroqSRxV7t8wtj9WrzEQkN0zwatBdHS7ergIpXZX
        zridPXwcp7Afk3Hk73gXVo38WF4oQsg47Mw5IDDtmJnfEUT6fOI9edP+Z8WZJ+RKf100jJ
        jURlIijjepod8YM97Ajbw89ozYB/sMj3fUuMWV9dULtiPhYFmJZj3X0V6xJZ4BUAp7kjJF
        sHi2a0+rztGu8I1m8HavXjmt8VRILkUQuhyAFjZ3o12BiyS5anKpvX/ydSlAYqBbbr/b76
        7h4OrcAMJcdn+YU+vRbkWEXEVxU9J7WcRr6Vkr6t8zuNGfASkxOedPhjM2fn5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UmtZngEwGEglvAjwA1iZWOHFlGGQMSgXWHHhk2pwUQI=;
        b=HY+ew+ZjmZrm04VhuWzfvMt5hLnOYsox2eYD3/S+BX3AS8pBxP/woLHsgl4bELA41kfR8C
        iDRCjmt8gNcahwAg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Introduce routines modifying shstk
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301574.404.8311948853813705393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     10b9f8c4a81cb827c555868bc06abc257fdfedf0
Gitweb:        https://git.kernel.org/tip/10b9f8c4a81cb827c555868bc06abc257fdfedf0
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:34 -07:00

x86/shstk: Introduce routines modifying shstk

Shadow stacks are normally written to via CALL/RET or specific CET
instructions like RSTORSSP/SAVEPREVSSP. However, sometimes the kernel will
need to write to the shadow stack directly using the ring-0 only WRUSS
instruction.

A shadow stack restore token marks a restore point of the shadow stack, and
the address in a token must point directly above the token, which is within
the same shadow stack. This is distinctively different from other pointers
on the shadow stack, since those pointers point to executable code area.

Introduce token setup and verify routines. Also introduce WRUSS, which is
a kernel-mode instruction but writes directly to user shadow stack.

In future patches that enable shadow stack to work with signals, the kernel
will need something to denote the point in the stack where sigreturn may be
called. This will prevent attackers calling sigreturn at arbitrary places
in the stack, in order to help prevent SROP attacks.

To do this, something that can only be written by the kernel needs to be
placed on the shadow stack. This can be accomplished by setting bit 63 in
the frame written to the shadow stack. Userspace return addresses can't
have this bit set as it is in the kernel range. It also can't be a valid
restore token.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-31-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/special_insns.h | 13 +++++-
 arch/x86/kernel/shstk.c              | 75 +++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index de48d13..d6cd934 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -202,6 +202,19 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+static inline int write_user_shstk_64(u64 __user *addr, u64 val)
+{
+	asm_volatile_goto("1: wrussq %[val], (%[addr])\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: [addr] "r" (addr), [val] "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EFAULT;
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
 #define nop() asm volatile ("nop")
 
 static inline void serialize(void)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index bd9cdc3..e22928c 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -25,6 +25,8 @@
 #include <asm/fpu/api.h>
 #include <asm/prctl.h>
 
+#define SS_FRAME_SIZE 8
+
 static bool features_enabled(unsigned long features)
 {
 	return current->thread.features & features;
@@ -40,6 +42,35 @@ static void features_clr(unsigned long features)
 	current->thread.features &= ~features;
 }
 
+/*
+ * Create a restore token on the shadow stack.  A token is always 8-byte
+ * and aligned to 8.
+ */
+static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(ssp, 8))
+		return -EINVAL;
+
+	addr = ssp - SS_FRAME_SIZE;
+
+	/*
+	 * SSP is aligned, so reserved bits and mode bit are a zero, just mark
+	 * the token 64-bit.
+	 */
+	ssp |= BIT(0);
+
+	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
+		return -EFAULT;
+
+	if (token_addr)
+		*token_addr = addr;
+
+	return 0;
+}
+
 static unsigned long alloc_shstk(unsigned long size)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
@@ -157,6 +188,50 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 	return addr + size;
 }
 
+static unsigned long get_user_shstk_addr(void)
+{
+	unsigned long long ssp;
+
+	fpregs_lock_and_load();
+
+	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+
+	fpregs_unlock();
+
+	return ssp;
+}
+
+#define SHSTK_DATA_BIT BIT(63)
+
+static int put_shstk_data(u64 __user *addr, u64 data)
+{
+	if (WARN_ON_ONCE(data & SHSTK_DATA_BIT))
+		return -EINVAL;
+
+	/*
+	 * Mark the high bit so that the sigframe can't be processed as a
+	 * return address.
+	 */
+	if (write_user_shstk_64(addr, data | SHSTK_DATA_BIT))
+		return -EFAULT;
+	return 0;
+}
+
+static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
+{
+	unsigned long ldata;
+
+	if (unlikely(get_user(ldata, addr)))
+		return -EFAULT;
+
+	if (!(ldata & SHSTK_DATA_BIT))
+		return -EINVAL;
+
+	*data = ldata & ~SHSTK_DATA_BIT;
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
