Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7D6011DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiJQOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJQOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6367CAA;
        Mon, 17 Oct 2022 07:53:57 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKeknugwLk+xvR0FEL/ext5YoRe9kcdKsrruIcJuqcM=;
        b=aim5g2OXS9V44PfIi7lP1jv2gYXtAgZ10YMOgsAcIqTNaYgGrbrzCmbR+xY9ziz8E2ws5y
        L2XxRd++vAs0LCYzEKbr5ENtgmkBv13jB4/JuJorpeGJzLcIqg9wVBjZwtvJLIY5ek3GVl
        pgJgf61MhHZh96eH87ayRyLSc2xIraWCYCc7LfjiHAWXAKRNjtFXPX/4ED8969STjzts7s
        UX9Pwgw0exsXzrjzF9QLnHgar3CsG/AVPn4M6kOOBcXka4Tuvh1ylGJ/HhtcpK3CYMKXjZ
        gRRP1vOqpDlniBf3giifpixxjqAPi36fID5sHmyaKVV7kf6eaobRR7vzVs7ccQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKeknugwLk+xvR0FEL/ext5YoRe9kcdKsrruIcJuqcM=;
        b=3RD6Gm4wFGOtkOBNbwnXQdVFQoKaoFHZ43+S18ReDyCnz1Q9iRmsKKStyRI60b6sqX+Ypp
        26ipxeYp3/nvPpDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternatives: Provide text_poke_copy_locked()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.159977224@infradead.org>
References: <20220915111147.159977224@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842806.401.11281852653540224244.tip-bot2@tip-bot2>
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

Commit-ID:     fe54d0793796ccdb213d8ea7bff0b49903b6afaa
Gitweb:        https://git.kernel.org/tip/fe54d0793796ccdb213d8ea7bff0b49903b6afaa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:11 +02:00

x86/alternatives: Provide text_poke_copy_locked()

The upcoming call thunk patching must hold text_mutex and needs access to
text_poke_copy(), which takes text_mutex.

Provide a _locked postfixed variant to expose the inner workings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.159977224@infradead.org
---
 arch/x86/include/asm/text-patching.h |  1 +-
 arch/x86/kernel/alternative.c        | 37 ++++++++++++++++-----------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 1cc1552..f4b87f0 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
+extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
 extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea..fad3c0e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1236,27 +1236,15 @@ void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
 	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
-/**
- * text_poke_copy - Copy instructions into (an unused part of) RX memory
- * @addr: address to modify
- * @opcode: source of the copy
- * @len: length to copy, could be more than 2x PAGE_SIZE
- *
- * Not safe against concurrent execution; useful for JITs to dump
- * new code blocks into unused regions of RX memory. Can be used in
- * conjunction with synchronize_rcu_tasks() to wait for existing
- * execution to quiesce after having made sure no existing functions
- * pointers are live.
- */
-void *text_poke_copy(void *addr, const void *opcode, size_t len)
+void *text_poke_copy_locked(void *addr, const void *opcode, size_t len,
+			    bool core_ok)
 {
 	unsigned long start = (unsigned long)addr;
 	size_t patched = 0;
 
-	if (WARN_ON_ONCE(core_kernel_text(start)))
+	if (WARN_ON_ONCE(!core_ok && core_kernel_text(start)))
 		return NULL;
 
-	mutex_lock(&text_mutex);
 	while (patched < len) {
 		unsigned long ptr = start + patched;
 		size_t s;
@@ -1266,6 +1254,25 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
 		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
 		patched += s;
 	}
+	return addr;
+}
+
+/**
+ * text_poke_copy - Copy instructions into (an unused part of) RX memory
+ * @addr: address to modify
+ * @opcode: source of the copy
+ * @len: length to copy, could be more than 2x PAGE_SIZE
+ *
+ * Not safe against concurrent execution; useful for JITs to dump
+ * new code blocks into unused regions of RX memory. Can be used in
+ * conjunction with synchronize_rcu_tasks() to wait for existing
+ * execution to quiesce after having made sure no existing functions
+ * pointers are live.
+ */
+void *text_poke_copy(void *addr, const void *opcode, size_t len)
+{
+	mutex_lock(&text_mutex);
+	addr = text_poke_copy_locked(addr, opcode, len, false);
 	mutex_unlock(&text_mutex);
 	return addr;
 }
