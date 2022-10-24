Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5260BF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJYAHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJYAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:07:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66199105CD3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBF67B811FB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2173C433D7;
        Mon, 24 Oct 2022 22:25:34 +0000 (UTC)
Date:   Mon, 24 Oct 2022 18:25:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v2] x86/mm: Do not verify W^X at boot up on ftrace
 trampolines
Message-ID: <20221024182545.78d638a9@gandalf.local.home>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Adding on the kernel command line "ftrace=function" triggered:

------------[ cut here ]------------
CPA detected W^X violation: 8000000000000063 -> 0000000000000063 range:
0xffffffffc0013000 - 0xffffffffc0013fff PFN 10031b
WARNING: CPU: 0 PID: 0 at arch/x86/mm/pat/set_memory.c:609
verify_rwx+0x61/0x6d
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-test+ #3
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
RIP: 0010:verify_rwx+0x61/0x6d
Code: e5 01 00 75 27 49 c1 e0 0c 48 89 d1 48 89 fe 48 c7 c7 5b b3 92 84 4e
8d 44 02 ff 48 89 da c6 05 71 29 e5 01 01 e8 35 90 e2 00 <0f> 0b 48 89 d8
5b 5d e9 6f 95 1a 01 0f 1f 44 00 00 55 48 89 e5 53
RSP: 0000:ffffffff84c03b08 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000003
RDX: 0000000000000003 RSI: ffffffff84c039b0 RDI: 0000000000000001
RBP: ffffffff84c03b10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000025 R12: ffff8e730031c098
R13: 000000000010031b R14: 800000010031b063 R15: 8000000000000063
FS:  0000000000000000(0000) GS:ffff8e7416a00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8e73fd801000 CR3: 00000001fcc22001 CR4: 00000000000606f0
Call Trace:
 <TASK>
 __change_page_attr_set_clr+0x146/0x8a6
 ? __mutex_unlock_slowpath+0x41/0x213
 ? mutex_unlock+0x12/0x18
 ? _vm_unmap_aliases+0x126/0x136
 change_page_attr_set_clr+0x135/0x268
 ? find_vmap_area+0x32/0x3e
 ? __fentry__+0x10/0x10
 change_page_attr_clear.constprop.0+0x16/0x1c
 set_memory_x+0x2c/0x32
 arch_ftrace_update_trampoline+0x218/0x2db
 ? ftrace_caller_op_ptr+0x17/0x17
 ftrace_update_trampoline+0x16/0xa1
 ? tracing_gen_ctx+0x1c/0x1c
 __register_ftrace_function+0x93/0xb2
 ftrace_startup+0x21/0xf0
 ? tracing_gen_ctx+0x1c/0x1c
 register_ftrace_function_nolock+0x26/0x40
 register_ftrace_function+0x4e/0x143
 ? mutex_unlock+0x12/0x18
 ? tracing_gen_ctx+0x1c/0x1c
 function_trace_init+0x7d/0xc3
 tracer_init+0x23/0x2c
 tracing_set_tracer+0x1d5/0x206
 register_tracer+0x1c0/0x1e4
 init_function_trace+0x90/0x96
 early_trace_init+0x25c/0x352
 start_kernel+0x424/0x6e4
 x86_64_start_reservations+0x24/0x2a
 x86_64_start_kernel+0x8c/0x95
 secondary_startup_64_no_verify+0xe0/0xeb
 </TASK>
---[ end trace 0000000000000000 ]---

This is because at boot up, kernel text is writable, and there's no reason
to do tricks to updated it. But the verifier does not distinguish updates
at boot up and at run time, and causes a warning at time of boot.

Add a check for system_state == SYSTEM_BOOTING and allow it if that is the
case and the address happens to be the ftrace trampoline.

Fixes: 652c5bf380ad0 ("x86/mm: Refuse W^X violations")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/r/20221024112730.180916b3@gandalf.local.home

 - Hack in a check to only ignore this check if it is early boot *and* the
   address being updated is the ftrace trampoline that is being created.
   (Dave Hansen)

 - Note, this is only needed if we can't come up with a proper way to
   be able to call trace_poke() at early boot up. See the discussion on v1.

 arch/x86/include/asm/ftrace.h | 2 ++
 arch/x86/kernel/ftrace.c      | 4 ++++
 arch/x86/mm/pat/set_memory.c  | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 908d99b127d3..41b3ecd23a08 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -25,6 +25,8 @@
 #ifndef __ASSEMBLY__
 extern void __fentry__(void);
 
+extern long ftrace_updated_trampoline;
+
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd165004776d..e2a1fc7bbe7a 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -417,7 +417,11 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	if (likely(system_state != SYSTEM_BOOTING))
 		set_memory_ro((unsigned long)trampoline, npages);
+	else
+		ftrace_updated_trampoline = trampoline;
 	set_memory_x((unsigned long)trampoline, npages);
+	ftrace_updated_trampoline = 0;
+
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 97342c42dda8..98921333ca00 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,6 +32,7 @@
 #include <asm/memtype.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/ftrace.h>
 
 #include "../mm_internal.h"
 
@@ -579,6 +580,9 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
 
+/* Store at early bootup the ftrace trampoline */
+long ftrace_updated_trampoline;
+
 /*
  * Validate strict W^X semantics.
  */
@@ -587,6 +591,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 {
 	unsigned long end;
 
+	/* Kernel text is rw at boot up and ftrace may call this */
+	if (system_state == SYSTEM_BOOTING && ftrace_updated_trampoline == start)
+		return new;
+
 	/*
 	 * 32-bit has some unfixable W+X issues, like EFI code
 	 * and writeable data being in the same page.  Disable
-- 
2.35.1

