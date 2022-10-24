Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8883760BEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJXXqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJXXp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E192F83F3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D6F561561
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3276EC433D7;
        Mon, 24 Oct 2022 22:03:58 +0000 (UTC)
Date:   Mon, 24 Oct 2022 18:04:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <20221024180408.7cd8dad7@gandalf.local.home>
In-Reply-To: <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
References: <20221024114536.44686c83@gandalf.local.home>
        <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
        <20221024145250.08cfc147@gandalf.local.home>
        <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 12:08:49 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And then all these special cases beget other special cases.

Well, I was able to get it to work without these special cases, but it
caused a bit of another kind of special cases to get poking_init() into
mm_init().

To get poking_init() working in mm_init() I had to pull in:

proc_caches_init(), as poking_init() uses some fork code that requires its
caches to be initialized.

Then dup_mm() is called, which uses maple tree code, which required
maple_tree_init() to be there too. (I pulled in radix_tree_init() just to
be consistent). But maple tree code calls kmem_cache_alloc_bulk() which
specifically states:

  /* Note that interrupts must be enabled when calling this function. */

and lockdep confirmed it.

So I did some hacking in the maple_tree.c to make that work.

And finally, dup_mm() calls dup_mmap() that calls flush_tlb_mm() for the
old mm, but since this is early boot up, there's really no need for that. I
added some hacks to avoid that.

Thus, I guess you get to choose your poison. Either we have special ftrace
cases in x86 that beget other special cases to keep it working, or we make
text_poke() work early by moving poking_init() into mm_init() and then
creating more generic special cases that beget other special cases (and I
have no idea if this works on other architectures, which could beget more
special cases).

Your call.

-- Steve

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..e240351e0bc1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1681,11 +1681,6 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 {
 	struct text_poke_loc *tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
@@ -1707,11 +1702,6 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 {
 	struct text_poke_loc tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd165004776d..43628b8480fa 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	set_vm_flush_reset_perms(trampoline);
 
-	if (likely(system_state != SYSTEM_BOOTING))
-		set_memory_ro((unsigned long)trampoline, npages);
+	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
diff --git a/init/main.c b/init/main.c
index aa21add5f7c5..e5f4ae2d4cca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -860,6 +860,10 @@ static void __init mm_init(void)
 	/* Should be run after espfix64 is set up. */
 	pti_init();
 	kmsan_init_runtime();
+	proc_caches_init();
+	radix_tree_init();
+	maple_tree_init();
+	poking_init();
 }
 
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
@@ -1011,8 +1015,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	if (WARN(!irqs_disabled(),
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
-	radix_tree_init();
-	maple_tree_init();
 
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
@@ -1117,7 +1119,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	thread_stack_cache_init();
 	cred_init();
 	fork_init();
-	proc_caches_init();
 	uts_ns_init();
 	key_init();
 	security_init();
@@ -1134,7 +1135,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
-	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..e24fb3ddcf9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -702,7 +702,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
-	flush_tlb_mm(oldmm);
+	if (likely(!early_boot_irqs_disabled))
+		flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1743803c851..6fc72ca62c7d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1253,7 +1253,12 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 		}
 
 		max_req = min(requested, max_req);
-		count = mt_alloc_bulk(gfp, max_req, slots);
+		if (unlikely(early_boot_irqs_disabled)) {
+			slots[0] = mt_alloc_one(gfp | GFP_ATOMIC);
+			count = slots[0] ? 1 : 0;
+		} else {
+			count = mt_alloc_bulk(gfp, max_req, slots);
+		}
 		if (!count)
 			goto nomem_bulk;
 
