Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C972923A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjFIHty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjFIHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2C30C8;
        Fri,  9 Jun 2023 00:47:43 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVqi+HwSBu5+RBoe6c7hBNQEOzIi/+hzXFyc/TgfZsk=;
        b=T0KqIHNI96iAZ7E5n0vBVOTmf7XC/G7Nr9FyKYnGXYKS5h2emWqnu+ekfMkHiDyZeScsQd
        uoJW0Rj2zinpR4R+LKO3VxuCEKIOxgC6h5x8RbAQW85NAPrk53jGXJbZb05TjqdQm0hQJ4
        mVtm/or9DZtUayqp4XsxzrOoI3pLGj8kSiEqg4cK5IYXIGTT3NCRTijkzN8VA40392grSP
        JhxCVkdl3QvdAlllXb8YxgNzSuSM5qBR8yPLqUTsDhkgTm9TJxOhFPp3Kl6eS4nUe6lEGW
        +4ahAIKjBMVHuchCoOY3KRjHGmJYw3qHh16YM56HAWf8vPqyhiqgY+154CbGRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVqi+HwSBu5+RBoe6c7hBNQEOzIi/+hzXFyc/TgfZsk=;
        b=TDssK2RHim3KS6VrACiWIfzr5P5MkOZmdPcJjc25UzDbzPoZmR1QlSacPto87J6Qy1kfl9
        kp9Tzy1wF2JbR+DQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] drm/vmwgfx: Add unwind hints around RBP clobber
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4c795f2d87bc0391cf6543bcb224fa540b55ce4b.1685981486.git.jpoimboe@kernel.org>
References: <4c795f2d87bc0391cf6543bcb224fa540b55ce4b.1685981486.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685987.404.14910646503772478220.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a9da8247627eefc73f909bf945031a5431a53993
Gitweb:        https://git.kernel.org/tip/a9da8247627eefc73f909bf945031a5431a53993
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 05 Jun 2023 09:12:22 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:12 -07:00

drm/vmwgfx: Add unwind hints around RBP clobber

VMware high-bandwidth hypercalls take the RBP register as input.  This
breaks basic frame pointer convention, as RBP should never be clobbered.

So frame pointer unwinding is broken for the instructions surrounding
the hypercalls.  Fortunately this doesn't break live patching with
CONFIG_FRAME_POINTER, as it only unwinds from blocking tasks, and stack
traces from preempted tasks are already marked unreliable anyway.

However, for live patching with ORC, this could actually be a
theoretical problem if vmw_port_hb_{in,out}() were still compiled with a
frame pointer due to having an aligned stack.  In practice that hasn't
seemed to be an issue since the objtool warnings have only been seen
with CONFIG_FRAME_POINTER.

Add unwind hint annotations to tell the ORC unwinder to mark stack
traces as unreliable.

Fixes the following warnings:

  vmlinux.o: warning: objtool: vmw_port_hb_in+0x1df: return with modified stack frame
  vmlinux.o: warning: objtool: vmw_port_hb_out+0x1dd: return with modified stack frame

Fixes: 89da76fde68d ("drm/vmwgfx: Add VMWare host messaging capability")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305160135.97q0Elax-lkp@intel.com/
Link: https://lore.kernel.org/r/4c795f2d87bc0391cf6543bcb224fa540b55ce4b.1685981486.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/unwind_hints.h     |  9 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 01cb969..85cc57c 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -76,9 +76,18 @@
 
 #else
 
+#define UNWIND_HINT_UNDEFINED \
+	UNWIND_HINT(UNWIND_HINT_TYPE_UNDEFINED, 0, 0, 0)
+
 #define UNWIND_HINT_FUNC \
 	UNWIND_HINT(UNWIND_HINT_TYPE_FUNC, ORC_REG_SP, 8, 0)
 
+#define UNWIND_HINT_SAVE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+
+#define UNWIND_HINT_RESTORE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
index 0b74ca2..23899d7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
@@ -105,10 +105,14 @@
                         flags, magic, bp,		\
                         eax, ebx, ecx, edx, si, di)	\
 ({							\
-        asm volatile ("push %%rbp;"			\
+        asm volatile (					\
+		UNWIND_HINT_SAVE			\
+		"push %%rbp;"				\
+		UNWIND_HINT_UNDEFINED			\
                 "mov %12, %%rbp;"			\
                 VMWARE_HYPERCALL_HB_OUT			\
-                "pop %%rbp;" :				\
+                "pop %%rbp;"				\
+		UNWIND_HINT_RESTORE :			\
                 "=a"(eax),				\
                 "=b"(ebx),				\
                 "=c"(ecx),				\
@@ -130,10 +134,14 @@
                        flags, magic, bp,		\
                        eax, ebx, ecx, edx, si, di)	\
 ({							\
-        asm volatile ("push %%rbp;"			\
+        asm volatile (					\
+		UNWIND_HINT_SAVE			\
+		"push %%rbp;"				\
+		UNWIND_HINT_UNDEFINED			\
                 "mov %12, %%rbp;"			\
                 VMWARE_HYPERCALL_HB_IN			\
-                "pop %%rbp" :				\
+                "pop %%rbp;"				\
+		UNWIND_HINT_RESTORE :			\
                 "=a"(eax),				\
                 "=b"(ebx),				\
                 "=c"(ecx),				\
