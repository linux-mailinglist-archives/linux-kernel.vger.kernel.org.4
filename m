Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA22D60121F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiJQO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiJQO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:57:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B568885;
        Mon, 17 Oct 2022 07:55:06 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTvjpn0KgxNDsUjGGkGy4CVh9hhBuLzsShC+ZJJI72s=;
        b=ZuUbGX3ey9eh0jBsFcA2kdL30QHF9+gx2ErowuXokFcOl55hCFV2jiq5nIeH/Eex+qIU+z
        82UvcM/XGrI4oy8viPD8cuwyJW/wPSLGZRz5MMEg0CIZkQOgObWsKdCX8ZZg4tmEjxllY8
        Hpv2VJ2WZj4pzHSVY5P+lBhPBponHHhQMUK+01SODfyYuEHGqezH2vmPh1bkTAI27c1OQ5
        +t5S1iZFDWEkUnCer0VQd2mcwtGU+4vj+Upr1L5j2eLy/60FmEri507fWmhZOGI1WutY29
        7S06+AtZakNC8KUisQ24cc2IUTioJRErY6Zo1/1kDQpd65L9WAALtehtrs+B1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTvjpn0KgxNDsUjGGkGy4CVh9hhBuLzsShC+ZJJI72s=;
        b=Dt+G7S7eDmQAVkBZBs/EHpf9iUowfCZrLbdlc392Rw5FYqOMd/+wh1yh22GDeTkY7fXkWw
        mqARFQmuWUOCrzBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.406703869@infradead.org>
References: <20220915111143.406703869@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846783.401.2287915526289128493.tip-bot2@tip-bot2>
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

Commit-ID:     4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff
Gitweb:        https://git.kernel.org/tip/4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:57 +02:00

x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

Instead of resetting permissions all over the place when freeing module
memory tell the vmalloc code to do so. Avoids the exercise for the next
upcoming user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.406703869@infradead.org
---
 arch/x86/kernel/ftrace.c       |  2 --
 arch/x86/kernel/kprobes/core.c |  1 -
 arch/x86/kernel/module.c       |  9 +++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd16500..00eac45 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -413,8 +413,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
-	set_vm_flush_reset_perms(trampoline);
-
 	if (likely(system_state != SYSTEM_BOOTING))
 		set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index eb8bc82..01b8d95 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -414,7 +414,6 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
-	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index c032edc..43f0112 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -74,10 +74,11 @@ void *module_alloc(unsigned long size)
 		return NULL;
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, gfp_mask,
-				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, gfp_mask, PAGE_KERNEL,
+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
+				 NUMA_NO_NODE, __builtin_return_address(0));
+
 	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
 		vfree(p);
 		return NULL;
