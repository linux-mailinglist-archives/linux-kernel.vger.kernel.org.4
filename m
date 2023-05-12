Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6316C70104A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbjELVHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjELVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:07:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168DD052;
        Fri, 12 May 2023 14:07:11 -0700 (PDT)
Message-ID: <20230512205255.875713771@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683925630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CERacbFmAU0r2YyiKnQSCmUMCfPrzAHfru8m3ZNl0KY=;
        b=mlVKNpwrrZo8g1O5g2m+Me4aq4cJcRqHlfaggouQckkiLNuNl3gMI9wJGW+qTK77NJ8L1t
        BNZic2MIATVICLudtbI4AZFCsrK6yBKlMcV3RCwHbtApC9WMnfOTf/384jFhT6DDyDkJLU
        68mjGx+kFnbdgLpBHRHDsZybKUUSd4DCRTEkmrpezylPkqkyKvPz75OmYdO3ljKUmH8DT+
        qileb82DTQnWi+EWLiBSaCU365hMQBR6WvjZdiFAVtGRc9MA/Xyms7EJNSpFNCUC672GYD
        N9c4DHYS2yGrtOZTD5VUq08pLhp9Cqoy87Bcu1VdvrO1+17UGGzGP2jJGlQcVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683925630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CERacbFmAU0r2YyiKnQSCmUMCfPrzAHfru8m3ZNl0KY=;
        b=pI9Kl0/aVsNuuAI/L8tX3o8uA++5XGmGpbq0v8JJXHVuwg59C4dNMi5XaYjRi8u2L2df6G
        eiU05lrMbsKzBPAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch V4 08/37] x86/smpboot: Remove unnecessary barrier()
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 23:07:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter stumbled over the barrier() after the invocation of smp_callin() in
start_secondary():

  "...this barrier() and it's comment seem weird vs smp_callin(). That
   function ends with an atomic bitop (it has to, at the very least it must
   not be weaker than store-release) but also has an explicit wmb() to order
   setup vs CPU_STARTING.

   There is no way the smp_processor_id() referred to in this comment can land
   before cpu_init() even without the barrier()."

The barrier() along with the comment was added in 2003 with commit
d8f19f2cac70 ("[PATCH] x86-64 merge") in the history tree. One of those
well documented combo patches of that time which changes world and some
more. The context back then was:

	/*
	 * Dont put anything before smp_callin(), SMP
	 * booting is too fragile that we want to limit the
	 * things done here to the most necessary things.
	 */
	cpu_init();
	smp_callin();

+	/* otherwise gcc will move up smp_processor_id before the cpu_init */
+ 	barrier();

	Dprintk("cpu %d: waiting for commence\n", smp_processor_id()); 

Even back in 2003 the compiler was not allowed to reorder that
smp_processor_id() invocation before the cpu_init() function call.
Especially not as smp_processor_id() resolved to:

  asm volatile("movl %%gs:%c1,%0":"=r" (ret__):"i"(pda_offset(field)):"memory");

There is no trace of this change in any mailing list archive including the
back then official x86_64 list discuss@x86-64.org, which would explain the
problem this change solved.

The debug prints are gone by now and the the only smp_processor_id()
invocation today is farther down in start_secondary() after locking
vector_lock which itself prevents reordering.

Even if the compiler would be allowed to reorder this, the code would still
be correct as GSBASE is set up early in the assembly code and is valid when
the CPU reaches start_secondary(), while the code at the time when this
barrier was added did the GSBASE setup in cpu_init().

As the barrier has zero value, remove it.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230509100421.GU83892@hirez.programming.kicks-ass.net
---
V4: New patch
---
 arch/x86/kernel/smpboot.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -238,8 +238,6 @@ static void notrace start_secondary(void
 	x86_cpuinit.early_percpu_clock_init();
 	smp_callin();
 
-	/* otherwise gcc will move up smp_processor_id before the cpu_init */
-	barrier();
 	/* Check TSC synchronization with the control CPU: */
 	check_tsc_sync_target();
 

