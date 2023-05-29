Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE9714FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjE2T1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2T1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:27:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD98B0;
        Mon, 29 May 2023 12:27:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685388433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kl0ODdCeKiDH/b09sXJZwrPwGLdocmdMEThYYertZKo=;
        b=Vxb6resa0Cee8qKiX40iLmpLbizKny04GkH5PE3gewsxqPqAzhTPcwc8GkVpD7IYkBdOob
        kldM9lYeqBeHeuVdf1n1uSRqpZ8thZOUUpxSgDMIWLmXNRAjjAYL9XB4nCkRJyP2BNBrgs
        +LjDC7xzihRAukwVXXSnFrbgcjETfKlxcQ0f7eAmLBfEur7iq3CkzZd7Fv+C3xIIfX9Oqn
        UDvSgGVwTUuYApQRu8CALqoBA3mLboEZWctl8SJ4zwTlaLr0WQyCLTztU3yg0BGhcD0i4q
        r0GC5zQfvpRfIKFDunUCoMLmRn5jMSReNtV5bplMpx4cZ9Wq3FpYR24PpP9nqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685388433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kl0ODdCeKiDH/b09sXJZwrPwGLdocmdMEThYYertZKo=;
        b=2dl6kWdCmqa//U1xNID+wwwyKgUQy1Ux9vDUW+tt7QyZfM5CWCbMX54JcFWLtsOWsuy9ZI
        CACTmSWLwHX7odAw==
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
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
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch v3 31/36] x86/apic: Provide cpu_primary_thread mask
In-Reply-To: <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name> <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
Date:   Mon, 29 May 2023 21:27:13 +0200
Message-ID: <87bki3kkfi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2023 at 05:39, Kirill A. Shutemov wrote:
> On Sat, May 27, 2023 at 03:40:02PM +0200, Thomas Gleixner wrote:
> But it gets broken again on "x86/smpboot: Implement a bit spinlock to
> protect the realmode stack" with
>
> [    0.554079] .... node  #0, CPUs:        #1  #2
> [    0.738071] Callback from call_rcu_tasks() invoked.
> [   10.562065] CPU2 failed to report alive state
> [   10.566337]   #3
> [   20.570066] CPU3 failed to report alive state
> [   20.574268]   #4
> ...
>
> Notably CPU1 is missing from "failed to report" list. So CPU1 takes the
> lock fine, but seems never unlocks it.
>
> Maybe trampoline_lock(%rip) in head_64.S somehow is not the same as
> &tr_lock in trampoline_64.S. I donno.

It's definitely the same in the regular startup (16bit mode), but TDX
starts up via:

trampoline_start64
  trampoline_compat
    LOAD_REALMODE_ESP <- lock

That place cannot work with that LOAD_REALMODE_ESP macro. The untested
below should cure it.

Thanks,

        tglx
---
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,12 +37,12 @@
 	.text
 	.code16
 
-.macro LOAD_REALMODE_ESP
+.macro LOAD_REALMODE_ESP lock:req
 	/*
 	 * Make sure only one CPU fiddles with the realmode stack
 	 */
 .Llock_rm\@:
-        lock btsl       $0, tr_lock
+        lock btsl       $0, \lock
         jnc             2f
         pause
         jmp             .Llock_rm\@
@@ -63,7 +63,7 @@ SYM_CODE_START(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	LOAD_REALMODE_ESP
+	LOAD_REALMODE_ESP tr_lock
 
 	call	verify_cpu		# Verify the cpu supports long mode
 	testl   %eax, %eax		# Check for return code
@@ -106,7 +106,7 @@ SYM_CODE_START(sev_es_trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	LOAD_REALMODE_ESP
+	LOAD_REALMODE_ESP tr_lock
 
 	jmp	.Lswitch_to_protected
 SYM_CODE_END(sev_es_trampoline_start)
@@ -189,7 +189,7 @@ SYM_CODE_START(pa_trampoline_compat)
 	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
 	 * paging and complete the switch to legacy 32-bit mode.
 	 */
-	LOAD_REALMODE_ESP
+	LOAD_REALMODE_ESP pa_tr_lock
 	movw	$__KERNEL_DS, %dx
 
 	movl	$(CR0_STATE & ~X86_CR0_PG), %eax

