Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6ED61966E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiKDMpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:45:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92676258;
        Fri,  4 Nov 2022 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=he6RIM7sDg1RFnlk2V5fT0AHSyY9rvYvbcm1AqQP8BI=; b=wZEq6GPN9G8k4TptqlhfR626Ph
        BJqBUBO39tHtN40KMzaOzpielciEaHimdRTi+DlV995lKppyRjlNBNhY+VslpQfzwITZmNiimgLWJ
        gAfpfOz08y3EjBrxqPIGxTU3976Zji3qLvdUbNKpcleG1l6cb7W/DCRbDf36uTPm2EN9FH/JYZH+w
        Xkvm2mr0uiE+SM4Wlsv77bRHyUD+80mcwf8+IN1uUJx8md3wYWnzR2md7X1LOOh7cxCs6sl1dnEHx
        wujo72iH8BrxH61d4vaoUUGR4w4+llRRDJ8TOaok7O0nD9GxyIrmDqwM+QusqzXQ590/rB8RFagin
        89QLDSYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqw45-007M7A-Ko; Fri, 04 Nov 2022 12:44:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1DA1300205;
        Fri,  4 Nov 2022 13:44:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8456120234481; Fri,  4 Nov 2022 13:44:46 +0100 (CET)
Date:   Fri, 4 Nov 2022 13:44:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Eric Dumazet <edumazet@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: KVM vs AMD: Re: [PATCH v3 48/59] x86/retbleed: Add SKL return
 thunk
Message-ID: <Y2UJPrgYTtKHblnh@hirez.programming.kicks-ass.net>
References: <20220915111039.092790446@infradead.org>
 <20220915111147.890071690@infradead.org>
 <Y1HVZKW4o0KRsMtq@dev-arch.thelio-3990X>
 <Y1JsBQAhDFB2C0OE@hirez.programming.kicks-ass.net>
 <Y1K5D2u6pzXRQz6a@dev-arch.thelio-3990X>
 <08bbd7ab-049e-3cc3-f814-636669b856be@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08bbd7ab-049e-3cc3-f814-636669b856be@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:53:54PM +0000, Andrew Cooper wrote:
> On 21/10/2022 16:21, Nathan Chancellor wrote:
> > On Fri, Oct 21, 2022 at 11:53:09AM +0200, Peter Zijlstra wrote:
> >> On Thu, Oct 20, 2022 at 04:10:28PM -0700, Nathan Chancellor wrote:
> >>> This commit is now in -next as commit 5d8213864ade ("x86/retbleed: Add
> >>> SKL return thunk"). I just bisected an immediate reboot on my AMD test
> >>> system when starting a virtual machine with QEMU + KVM to it (see the
> >>> bisect log below). My Intel test systems do not show this.
> >>> Unfortunately, I do not have much more information, as there are no logs
> >>> in journalctl, which makes sense as the reboot occurs immediately after
> >>> I hit the enter key for the QEMU command.
> >>>
> >>> If there is any further information I can provide or patches I can test
> >>> for further debugging, I am more than happy to do so.
> >> Moo :-(
> >>
> >> you happen to have a .config for me?
> > Sure thing, sorry I did not provide it in the first place! Attached. It
> > has been run through localmodconfig for the particular machine but I
> > assume the core pieces should still be present.
> 
> Following up from some debugging on IRC.
> 
> The problem is that FILL_RETURN_BUFFER now has a per-cpu variable
> access, and AMD SVM has a fun optimisation where the VMRUN instruction
> doesn't swap, amongst other things, %gs.
> 
> per-cpu variables only become safe following
> vmload(__sme_page_pa(sd->save_area)); in svm_vcpu_enter_exit().
> 
> Given that retbleed=force ought to work on non-skylake hardware, the
> appropriate fix is to move the VMLOAD/VMSAVE's down into asm and put
> them adjacent to VMRUN.
> 
> This also addresses an undocumented dependency where its only the memory
> clobber in vmload() which stops the compiler moving
> svm_vcpu_enter_exit()'s calculation of sd into an unsafe position.

So, aside from wasting the entire morning on resuscitating my AMD
Interlagos, I ended up with the below patch which seems to work.

Not being a virt person, I'm sure I've messed up something, please
advise.

---
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 58f0077d9357..f7ee1eedacfe 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3929,11 +3929,8 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 		 * the state doesn't need to be copied between vmcb01 and
 		 * vmcb02 when switching vmcbs for nested virtualization.
 		 */
-		vmload(svm->vmcb01.pa);
-		__svm_vcpu_run(vmcb_pa, (unsigned long *)&vcpu->arch.regs);
-		vmsave(svm->vmcb01.pa);
-
-		vmload(__sme_page_pa(sd->save_area));
+		__svm_vcpu_run(vmcb_pa, (unsigned long *)&vcpu->arch.regs,
+			       svm->vmcb01.pa, __sme_page_pa(sd->save_area));
 	}
 
 	guest_state_exit_irqoff();
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6a7686bf6900..2a038def7ac7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -684,6 +684,7 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 /* vmenter.S */
 
 void __svm_sev_es_vcpu_run(unsigned long vmcb_pa);
-void __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
+void __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs,
+		    unsigned long guest_vmcb_pa, unsigned long host_vmcb_pa);
 
 #endif
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 09eacf19d718..50f200f7b773 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -32,8 +32,10 @@
 
 /**
  * __svm_vcpu_run - Run a vCPU via a transition to SVM guest mode
- * @vmcb_pa:	unsigned long
- * @regs:	unsigned long * (to guest registers)
+ * @vmcb_pa:		unsigned long
+ * @regs:		unsigned long * (to guest registers)
+ * @guest_vmcb_pa:	unsigned long
+ * @host_vmcb_pa:	unsigned long
  */
 SYM_FUNC_START(__svm_vcpu_run)
 	push %_ASM_BP
@@ -51,9 +53,18 @@ SYM_FUNC_START(__svm_vcpu_run)
 	/* Save @regs. */
 	push %_ASM_ARG2
 
+	/* Save host_vmcb_pa */
+	push %_ASM_ARG4
+
+	/* Save guest_vmcb_pa */
+	push %_ASM_ARG3
+
 	/* Save @vmcb. */
 	push %_ASM_ARG1
 
+	/* Save guest_vmcb_pa */
+	push %_ASM_ARG3
+
 	/* Move @regs to RAX. */
 	mov %_ASM_ARG2, %_ASM_AX
 
@@ -75,15 +86,29 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov VCPU_R15(%_ASM_AX), %r15
 #endif
 
+	/* POP and VMLOAD @guest_vmcb01_pa */
+	pop %_ASM_AX
+1:	vmload %_ASM_AX
+2:
 	/* "POP" @vmcb to RAX. */
 	pop %_ASM_AX
 
 	/* Enter guest mode */
 	sti
 
-1:	vmrun %_ASM_AX
+3:	vmrun %_ASM_AX
+4:
+	cli
 
-2:	cli
+	/* POP and VMSAVE @guest_vmcb01_pa */
+	pop %_ASM_AX
+5:	vmsave %_ASM_AX
+6:
+	/* POP and VMLOAD @host_vmcb01_pa */
+	pop %_ASM_AX
+7:	vmload %_ASM_AX
+8:
+	/* Now host %GS is live */
 
 #ifdef CONFIG_RETPOLINE
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
@@ -160,11 +185,26 @@ SYM_FUNC_START(__svm_vcpu_run)
 	pop %_ASM_BP
 	RET
 
-3:	cmpb $0, kvm_rebooting
+10:	cmpb $0, kvm_rebooting
 	jne 2b
 	ud2
 
-	_ASM_EXTABLE(1b, 3b)
+30:	cmpb $0, kvm_rebooting
+	jne 4b
+	ud2
+
+50:	cmpb $0, kvm_rebooting
+	jne 6b
+	ud2
+
+70:	cmpb $0, kvm_rebooting
+	jne 8b
+	ud2
+
+	_ASM_EXTABLE(1b, 10b)
+	_ASM_EXTABLE(3b, 30b)
+	_ASM_EXTABLE(5b, 50b)
+	_ASM_EXTABLE(7b, 70b)
 
 SYM_FUNC_END(__svm_vcpu_run)
 
