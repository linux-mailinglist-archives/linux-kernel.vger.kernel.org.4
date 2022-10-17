Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB360120C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiJQO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiJQO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66AC4B49E;
        Mon, 17 Oct 2022 07:54:51 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xOnecPPlMYFOEVyTdD349MS0B7vIN7DcahySrqR7Uc=;
        b=r7nEDhHHv+ZwWeSUkQwvSYlkfd6FDpi6letCQq9Nek88ocN+7cnaqm+HVbQ6X59hwf/HmM
        1//nZrGn2tGUWyPLS+OkgGZ/SMfFb7jSqNeQK4iLKtddvdIFV6s/aVoOdMCFy1vC57Waap
        3sTHG0x+0gSQ2/6/XHcqD/Ykd83cTeV15OmvTsFdiE4ogVRlaJHOyBGX9K2lHOzYQdh4Qp
        wkRF8AdPuhvgC+qrpHntAVL16gHt2FwPBqYDZ5gQEyT2mbaS+jczGGl4b1aeRPFZYfByCv
        RFhyQeXrj+ciCX6Hg1LYSNylXZGeUHJtMjNODw7w2DbwrPpVBagrMAH+00HBeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xOnecPPlMYFOEVyTdD349MS0B7vIN7DcahySrqR7Uc=;
        b=WSSHYpmWGAoVH1xfT+LtH4JE6bZx+fIS+uLWpm6z2ApF+VZHfV3fIMLM1K7lhUjIfDHRti
        rNr9zAx/RNOYSzDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/paravirt: Properly align PV functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.038540008@infradead.org>
References: <20220915111144.038540008@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846140.401.722787813329770938.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1d293758e548aa6ff65e4dd3f5a9bc2a34b38ce3
Gitweb:        https://git.kernel.org/tip/1d293758e548aa6ff65e4dd3f5a9bc2a34b38ce3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:59 +02:00

x86/paravirt: Properly align PV functions

Ensure inline asm functions are consistently aligned with compiler
generated and SYM_FUNC_START*() functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20220915111144.038540008@infradead.org
---
 arch/x86/include/asm/paravirt.h           | 1 +
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 arch/x86/kernel/kvm.c                     | 1 +
 arch/x86/kernel/paravirt.c                | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2a0b8dd..1be66c1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -665,6 +665,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	asm(".pushsection " section ", \"ax\";"				\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
+	    ASM_FUNC_ALIGN						\
 	    PV_THUNK_NAME(func) ":"					\
 	    ASM_ENDBR							\
 	    FRAME_BEGIN							\
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 60ece59..082551b 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 asm    (".pushsection .spinlock.text;"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
-	".align 4,0x90;"
+	ASM_FUNC_ALIGN
 	PV_UNLOCK ": "
 	ASM_ENDBR
 	FRAME_BEGIN
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d4e48b4..95fb85b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -802,6 +802,7 @@ asm(
 ".pushsection .text;"
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
+ASM_FUNC_ALIGN
 "__raw_callee_save___kvm_vcpu_is_preempted:"
 ASM_ENDBR
 "movq	__per_cpu_offset(,%rdi,8), %rax;"
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7ca2d46..e244c49 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -40,6 +40,7 @@
 extern void _paravirt_nop(void);
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global _paravirt_nop\n"
+     ASM_FUNC_ALIGN
      "_paravirt_nop:\n\t"
      ASM_ENDBR
      ASM_RET
@@ -50,6 +51,7 @@ asm (".pushsection .entry.text, \"ax\"\n"
 /* stub always returning 0. */
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global paravirt_ret0\n"
+     ASM_FUNC_ALIGN
      "paravirt_ret0:\n\t"
      ASM_ENDBR
      "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"
