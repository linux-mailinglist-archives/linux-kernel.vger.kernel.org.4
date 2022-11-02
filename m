Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88534615F50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiKBJOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKBJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87629341;
        Wed,  2 Nov 2022 02:12:51 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErZ2a/RApEnR8ArCDlCkmTfWwbFthyMGfGgeBHpe32E=;
        b=R9nAqqSBydD6WwtvQa4MupLaLSZY/XrFWdh4D5BO5oOI5qFdYkI38TEMYtq1qOojz2MlTz
        TCWy8+a5vSpfxwu2VAgKPWlc8ApxJYM/40p/ri2O0yNo/Icb71bw8aLQty5mpj5lxq7ui5
        KR8HR3a4V/po9OhPD3CJVXxrYAJlheBahnAo00WWQo28dU1EdDUyNG/dMOdtXMbtEUsGt6
        7Zzkzu6IcUpgWqFFP5I7n3BA4Z3zbqmuFSyJMxgDFQYw2hSka7gU3fpOgHBVsgEWxbYPkG
        7olZfrT0mcvrEzWIv4YSHhode4ngWBjz66cYOt6+uX6jCHy90fdo6/s25eH2MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErZ2a/RApEnR8ArCDlCkmTfWwbFthyMGfGgeBHpe32E=;
        b=jl5otWTulqp3wtxefz4o+YFmrCZEA/jBK/Fh0NbL9Az+Fl1ICLk6Cs7Qn/Jq8gbQSh6sv7
        hZX+R3aFq0dnTpBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Introduce set_memory_rox()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
References: <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166738036841.7716.16669271709347477505.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1f6eae43052889579dae56eae275003b9a876c21
Gitweb:        https://git.kernel.org/tip/1f6eae43052889579dae56eae275003b9a876c21
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 26 Oct 2022 12:13:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:58 +01:00

mm: Introduce set_memory_rox()

Because endlessly repeating:

	set_memory_ro()
	set_memory_x()

is getting tedious.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y1jek64pXOsougmz@hirez.programming.kicks-ass.net
---
 arch/arm/mach-omap1/sram-init.c |  8 +++-----
 arch/arm/mach-omap2/sram.c      |  8 +++-----
 arch/powerpc/kernel/kprobes.c   |  9 ++++-----
 arch/x86/kernel/ftrace.c        |  5 ++---
 arch/x86/kernel/kprobes/core.c  |  9 ++-------
 drivers/misc/sram-exec.c        |  7 ++-----
 include/linux/filter.h          |  3 +--
 include/linux/set_memory.h      |  8 ++++++++
 kernel/bpf/bpf_struct_ops.c     |  3 +--
 kernel/bpf/core.c               |  6 ++----
 kernel/bpf/trampoline.c         |  3 +--
 net/bpf/bpf_dummy_struct_ops.c  |  3 +--
 12 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap1/sram-init.c b/arch/arm/mach-omap1/sram-init.c
index 27c42e2..dabf0c4 100644
--- a/arch/arm/mach-omap1/sram-init.c
+++ b/arch/arm/mach-omap1/sram-init.c
@@ -10,11 +10,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/set_memory.h>
 
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
-#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -74,8 +74,7 @@ void *omap_sram_push(void *funcp, unsigned long size)
 
 	dst = fncpy(sram, funcp, size);
 
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
+	set_memory_rox(base, pages);
 
 	return dst;
 }
@@ -126,8 +125,7 @@ static void __init omap_detect_and_map_sram(void)
 	base = (unsigned long)omap_sram_base;
 	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
 
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
+	set_memory_rox(base, pages);
 }
 
 static void (*_omap_sram_reprogram_clock)(u32 dpllctl, u32 ckctl);
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 39cf270..815d390 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -14,11 +14,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/set_memory.h>
 
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
-#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -96,8 +96,7 @@ void *omap_sram_push(void *funcp, unsigned long size)
 
 	dst = fncpy(sram, funcp, size);
 
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
+	set_memory_rox(base, pages);
 
 	return dst;
 }
@@ -217,8 +216,7 @@ static void __init omap2_map_sram(void)
 	base = (unsigned long)omap_sram_base;
 	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
 
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
+	set_memory_rox(base, pages);
 }
 
 static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index bd7b1a0..7a89de3 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -20,12 +20,12 @@
 #include <linux/kdebug.h>
 #include <linux/slab.h>
 #include <linux/moduleloader.h>
+#include <linux/set_memory.h>
 #include <asm/code-patching.h>
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
 #include <asm/sections.h>
 #include <asm/inst.h>
-#include <asm/set_memory.h>
 #include <linux/uaccess.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
@@ -134,10 +134,9 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
-	if (strict_module_rwx_enabled()) {
-		set_memory_ro((unsigned long)page, 1);
-		set_memory_x((unsigned long)page, 1);
-	}
+	if (strict_module_rwx_enabled())
+		set_memory_rox((unsigned long)page, 1);
+
 	return page;
 }
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 43628b8..0357946 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -24,10 +24,10 @@
 #include <linux/module.h>
 #include <linux/memory.h>
 #include <linux/vmalloc.h>
+#include <linux/set_memory.h>
 
 #include <trace/syscall.h>
 
-#include <asm/set_memory.h>
 #include <asm/kprobes.h>
 #include <asm/ftrace.h>
 #include <asm/nops.h>
@@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	set_vm_flush_reset_perms(trampoline);
 
-	set_memory_ro((unsigned long)trampoline, npages);
-	set_memory_x((unsigned long)trampoline, npages);
+	set_memory_rox((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index eb8bc82..e7b7ca6 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -43,6 +43,7 @@
 #include <linux/objtool.h>
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
+#include <linux/set_memory.h>
 
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -51,7 +52,6 @@
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/debugreg.h>
-#include <asm/set_memory.h>
 #include <asm/ibt.h>
 
 #include "common.h"
@@ -415,17 +415,12 @@ void *alloc_insn_page(void)
 		return NULL;
 
 	set_vm_flush_reset_perms(page);
-	/*
-	 * First make the page read-only, and only then make it executable to
-	 * prevent it from being W+X in between.
-	 */
-	set_memory_ro((unsigned long)page, 1);
 
 	/*
 	 * TODO: Once additional kernel code protection mechanisms are set, ensure
 	 * that the page was not maliciously altered and it is still zeroed.
 	 */
-	set_memory_x((unsigned long)page, 1);
+	set_memory_rox((unsigned long)page, 1);
 
 	return page;
 }
diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index a948e95..b71dbbd 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -10,9 +10,9 @@
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/sram.h>
+#include <linux/set_memory.h>
 
 #include <asm/fncpy.h>
-#include <asm/set_memory.h>
 
 #include "sram.h"
 
@@ -106,10 +106,7 @@ void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 
 	dst_cpy = fncpy(dst, src, size);
 
-	ret = set_memory_ro((unsigned long)base, pages);
-	if (ret)
-		goto error_out;
-	ret = set_memory_x((unsigned long)base, pages);
+	ret = set_memory_rox((unsigned long)base, pages);
 	if (ret)
 		goto error_out;
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efc42a6..f0b17af 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -860,8 +860,7 @@ static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
 	set_vm_flush_reset_perms(hdr);
-	set_memory_ro((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
-	set_memory_x((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
+	set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 369769c..023ebc6 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -14,6 +14,14 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+static inline int set_memory_rox(unsigned long addr, int numpages)
+{
+	int ret = set_memory_ro(addr, numpages);
+	if (ret)
+		return ret;
+	return set_memory_x(addr, numpages);
+}
+
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
 static inline int set_direct_map_invalid_noflush(struct page *page)
 {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 84b2d9d..ece9870 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -494,8 +494,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
 
-	set_memory_ro((long)st_map->image, 1);
-	set_memory_x((long)st_map->image, 1);
+	set_memory_rox((long)st_map->image, 1);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* Pair with smp_load_acquire() during lookup_elem().
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 25a54e0..b0525ea 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -864,8 +864,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
 	return pack;
 }
 
@@ -883,8 +882,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
-			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
-			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
+			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
 		}
 		goto out;
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index bf0906e..a848922 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -468,8 +468,7 @@ again:
 	if (err < 0)
 		goto out;
 
-	set_memory_ro((long)im->image, 1);
-	set_memory_x((long)im->image, 1);
+	set_memory_rox((long)im->image, 1);
 
 	WARN_ON(tr->cur_image && tr->selector == 0);
 	WARN_ON(!tr->cur_image && tr->selector);
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index e78dadf..9ff3232 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -124,8 +124,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (err < 0)
 		goto out;
 
-	set_memory_ro((long)image, 1);
-	set_memory_x((long)image, 1);
+	set_memory_rox((long)image, 1);
 	prog_ret = dummy_ops_call_op(image, args);
 
 	err = dummy_ops_copy_args(args);
