Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329415B99D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIOLlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIOLkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51539501AB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ziGAKr7QhrrTtLR+TFwgCK+wh0GbBV7swcz66BqGyr4=; b=JsZnZzNGjX0EPW0/Rr433I7dys
        5qL6zOggA820wbg2VDSUV5XYkFUs9Pr5JktiPp+HcqIuOIYQm9BeVwCnLTbSEgvXuCdXUXDr5d7Mg
        Nea/qUAeFrfZ1abIvXTGhK2/GW04FeuhaB5/A9JyE3cQqhbpQp3irkoRMBYeNrpVaqsjWczleYpaU
        UMyGyJmREswot7/HvGwU/8mQpeBaiRmSwrVOkKg5Hx8cSXLjgriK3ftIdu8gPbhvxEg85D7MnoIHe
        DeSFQE+JLNvy+NkQnW6xDdE1hl746GjVVj6HRyd8ssamooqwi//j3cZvjNR0pAqHVKh8K/oxStwq/
        MswbttuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDa-0012Ml-IC; Thu, 15 Sep 2022 11:39:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE99F30045A;
        Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CF9BE2015DC36; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111143.097052006@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 02/59] x86/cpu: Remove segment load from switch_to_new_gdt()
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On 32bit FS and on 64bit GS segments are already set up correctly, but
load_percpu_segment() still sets [FG]S after switching from the early GDT
to the direct GDT.

For 32bit the segment load has no side effects, but on 64bit it causes
GSBASE to become 0, which means that any per CPU access before GSBASE is
set to the new value is going to fault. That's the reason why the whole
file containing this code has stackprotector removed.

But that's a pointless exercise for both 32 and 64 bit as the relevant
segment selector is already correct. Loading the new GDT does not change
that.

Remove the segment loads and add comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    1 
 arch/x86/kernel/cpu/common.c     |   47 +++++++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -673,7 +673,6 @@ extern struct desc_ptr		early_gdt_descr;
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
-extern void load_percpu_segment(int);
 extern void cpu_init(void);
 extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -701,16 +701,6 @@ static const char *table_lookup_model(st
 __u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
-void load_percpu_segment(int cpu)
-{
-#ifdef CONFIG_X86_32
-	loadsegment(fs, __KERNEL_PERCPU);
-#else
-	__loadsegment_simple(gs, 0);
-	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
-#endif
-}
-
 #ifdef CONFIG_X86_32
 /* The 32-bit entry code needs to find cpu_entry_area. */
 DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
@@ -738,16 +728,41 @@ void load_fixmap_gdt(int cpu)
 }
 EXPORT_SYMBOL_GPL(load_fixmap_gdt);
 
-/*
- * Current gdt points %fs at the "master" per-cpu area: after this,
- * it's on the real one.
+/**
+ * switch_to_new_gdt - Switch form early GDT to the direct one
+ * @cpu:	The CPU number for which this is invoked
+ *
+ * Invoked during early boot to switch from early GDT and early per CPU
+ * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
+ * CPU area.
  */
 void switch_to_new_gdt(int cpu)
 {
-	/* Load the original GDT */
 	load_direct_gdt(cpu);
-	/* Reload the per-cpu base */
-	load_percpu_segment(cpu);
+
+#ifdef CONFIG_X86_64
+	/*
+	 * No need to load %gs. It is already correct.
+	 *
+	 * Writing %gs on 64bit would zero GSBASE which would make any per
+	 * CPU operation up to the point of the wrmsrl() fault.
+	 *
+	 * Set GSBASE to the new offset. Until the wrmsrl() happens the
+	 * early mapping is still valid. That means the GSBASE update will
+	 * lose any prior per CPU data which was not copied over in
+	 * setup_per_cpu_areas().
+	 */
+	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
+#else
+	/*
+	 * %fs is already set to __KERNEL_PERCPU, but after switching GDT
+	 * it is required to load FS again so that the 'hidden' part is
+	 * updated from the new GDT. Up to this point the early per CPU
+	 * translation is active. Any content of the early per CPU data
+	 * which was not copied over in setup_per_cpu_areas() is lost.
+	 */
+	loadsegment(fs, __KERNEL_PERCPU);
+#endif
 }
 
 static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};


