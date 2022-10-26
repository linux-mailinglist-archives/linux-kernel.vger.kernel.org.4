Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD660DBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJZHPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJZHPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:15:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7598CB8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FFZ6l2955No38OkpSABmKnKKUnPQ62XcPPzsCT8f1/s=; b=ncHiHr8KM3pkzhqiU2WdLC5ssV
        gKW5E1VGnhkR1M6M0s1KCCvj1Rlsd0XaehJfluxtulR91VDweXAfV3xr9J9LNovvLx8fcoQKtLj27
        Aa3NSxqnADLlKYLlVUDjcxoohHYZ4+2JY7+11qlEXtO0ozzOnvw/Oqkh6M271eK8vLbmwZSeyZD+T
        EmOYXPq5RnoT39zpkm0vEilKjzIasBu8cFN/qlcOg70/dGGQOCMv3fvy10mT41h1yCX/Ag/TGQvSQ
        Whc/SjbWKhVmY0yEvsLwfXVC1EfgfLzlhbrrxtvX16mLovTD9MbOJejoL0gEsDA2rUfAkI/7uFhFc
        Yz+MGYng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onadQ-006WOq-Jn; Wed, 26 Oct 2022 07:15:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D10E3000DD;
        Wed, 26 Oct 2022 09:15:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14CDC2C259E9D; Wed, 26 Oct 2022 09:15:32 +0200 (CEST)
Date:   Wed, 26 Oct 2022 09:15:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rostedt@goodmis.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
Message-ID: <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
References: <20221025200656.951281799@infradead.org>
 <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:07:25PM -0700, Linus Torvalds wrote:

> It does strike me that it's stupid to make those be two calls that do
> exactly the same thing, and we should have a combined "set it
> read-only and executable" function, but that's a separate issue.

Right, and we have it all over the place. Something like the below
perhaps? I'll feed it to the robots, see if something breaks.

> The slowness is probably not the trampilines, but just the regular
> "text_poke of kernel text" that we probably want to keep special just
> because otherwise it's _so_ slow to do for every alternative etc.

I tried with and without the patches, it's dead slow either way and I
couldn't spot a noticable difference between the two -- so I'm assuming
it's simply the trace overhead, not the trace-enable time.


---
--- a/arch/arm/mach-omap1/sram-init.c
+++ b/arch/arm/mach-omap1/sram-init.c
@@ -74,8 +74,7 @@ void *omap_sram_push(void *funcp, unsign
 
 	dst = fncpy(sram, funcp, size);
 
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
+	set_memory_rox(base, pages);
 
 	return dst;
 }
@@ -126,8 +125,7 @@ static void __init omap_detect_and_map_s
 	base = (unsigned long)omap_sram_base;
 	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
 
-	set_memory_ro(base, pages);
-	set_memory_x(base, pages);
+	set_memory_rox(base, pages);
 }
 
 static void (*_omap_sram_reprogram_clock)(u32 dpllctl, u32 ckctl);
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -96,8 +96,7 @@ void *omap_sram_push(void *funcp, unsign
 
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
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
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
 
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops
 
 	set_vm_flush_reset_perms(trampoline);
 
-	set_memory_ro((unsigned long)trampoline, npages);
-	set_memory_x((unsigned long)trampoline, npages);
+	set_memory_rox((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline);
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
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
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -106,10 +106,7 @@ void *sram_exec_copy(struct gen_pool *po
 
 	dst_cpy = fncpy(dst, src, size);
 
-	ret = set_memory_ro((unsigned long)base, pages);
-	if (ret)
-		goto error_out;
-	ret = set_memory_x((unsigned long)base, pages);
+	ret = set_memory_rox((unsigned long)base, pages);
 	if (ret)
 		goto error_out;
 
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -860,8 +860,7 @@ static inline void bpf_prog_lock_ro(stru
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
 	set_vm_flush_reset_perms(hdr);
-	set_memory_ro((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
-	set_memory_x((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
+	set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -14,6 +14,14 @@ static inline int set_memory_x(unsigned
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
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -494,8 +494,7 @@ static int bpf_struct_ops_map_update_ele
 	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
 
-	set_memory_ro((long)st_map->image, 1);
-	set_memory_x((long)st_map->image, 1);
+	set_memory_rox((long)st_map->image, 1);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* Pair with smp_load_acquire() during lookup_elem().
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -864,8 +864,7 @@ static struct bpf_prog_pack *alloc_new_p
 	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
 	return pack;
 }
 
@@ -883,8 +882,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
-			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
-			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
+			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
 		}
 		goto out;
 	}
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -468,8 +468,7 @@ static int bpf_trampoline_update(struct
 	if (err < 0)
 		goto out;
 
-	set_memory_ro((long)im->image, 1);
-	set_memory_x((long)im->image, 1);
+	set_memory_rox((long)im->image, 1);
 
 	WARN_ON(tr->cur_image && tr->selector == 0);
 	WARN_ON(!tr->cur_image && tr->selector);
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -124,8 +124,7 @@ int bpf_struct_ops_test_run(struct bpf_p
 	if (err < 0)
 		goto out;
 
-	set_memory_ro((long)image, 1);
-	set_memory_x((long)image, 1);
+	set_memory_rox((long)image, 1);
 	prog_ret = dummy_ops_call_op(image, args);
 
 	err = dummy_ops_copy_args(args);
