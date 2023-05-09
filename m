Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4A6FC7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjEINPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjEINPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:15:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962135251;
        Tue,  9 May 2023 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khqr0MrXgdTVdwiWa8T0MGcDfR6bo4jGzZcTutjT+jQ=; b=AEUW7P6wHkheamaa+eBuAM5GlC
        HfXe2ylLtWfcka1eSHoTdooMv0rHLwy/4UXXJfZaPtCYmRmGdjmuMt/FClhve6qLhrukTIXm+8N+x
        nnGp+Vzv9Hegi36E8Rf/r4OzxVgdZvlwWMFCYnhPsYrrh5BHtNngH7k2UHSRocxMaqFkCSuUYHGyM
        EsKfIzE5XcxVl6vZOctnKdun9FsIUQbYBW2M+Z1E/CAIBnpced8CJq1O4rRlwdi1xMIKktEKJ2RfE
        L+hwPaIMMTATJdkHhod0l8xSQ9RsSKpUEP7+RkcJIh1jBJKJkRFGUcEM0nLnU4e2CbQIrer3yhEJm
        rDt36aIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwNA0-00FGci-C9; Tue, 09 May 2023 13:13:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B23CD30026A;
        Tue,  9 May 2023 15:13:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9497920B41FB2; Tue,  9 May 2023 15:13:40 +0200 (CEST)
Date:   Tue, 9 May 2023 15:13:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [patch v3 34/36] x86/smpboot: Implement a bit spinlock to
 protect the realmode stack
Message-ID: <20230509131340.GA83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185219.123719053@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508185219.123719053@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:44:22PM +0200, Thomas Gleixner wrote:

> @@ -252,6 +252,17 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>  	movq	TASK_threadsp(%rax), %rsp
>  
>  	/*
> +	 * Now that this CPU is running on its own stack, drop the realmode
> +	 * protection. For the boot CPU the pointer is NULL!
> +	 */
> +	movq	trampoline_lock(%rip), %rax
	movl	$0, (%rax)

> +.Lsetup_gdt:
> +	/*
>  	 * We must switch to a new descriptor in kernel space for the GDT
>  	 * because soon the kernel won't have access anymore to the userspace
>  	 * addresses where we're currently running on. We have to do that here

> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -37,6 +37,24 @@
>  	.text
>  	.code16
>  
> +.macro LOAD_REALMODE_ESP
> +	/*
> +	 * Make sure only one CPU fiddles with the realmode stack
> +	 */
> +.Llock_rm\@:
> +	btl	$0, tr_lock
> +	jnc	2f
> +	pause
> +	jmp	.Llock_rm\@
> +2:
> +	lock
> +	btsl	$0, tr_lock
> +	jc	.Llock_rm\@

Do we really care about performance here; or should we pick the simpler
form? Also, 'lock' is a prefix, not an instruction.

.Llock_rm\@:
	lock btsl	$0, tr_lock;
	jnc		2f
	pause
	jmp		.Llock_rm\@
2:

> +
> +	# Setup stack
> +	movl	$rm_stack_end, %esp
> +.endm
> +
>  	.balign	PAGE_SIZE
