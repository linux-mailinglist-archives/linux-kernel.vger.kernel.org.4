Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4A6FC3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjEIKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjEIKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:33:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD510A21;
        Tue,  9 May 2023 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gd64jCpByI9ftMmszyCnHSbL15wXcN+sPo8L/Xdfd60=; b=CuTgyV8Kb4pFfLeLsvFJaMyO39
        w2tpTejdL1282DKRtl3AaKdBc8Hn9nRTvQQ9DYhYlpzuM+dpyDsaxtc21qM27D5mhnRuD9XTvUY5G
        MfmaLX0npp7MFDGUFX7ijHJkVij0No7VT3AyLbMnuaBv9CKOD2u3qLQSzqJSxcKBidQ7zxyDDXI7m
        hqnlBbQaeXEG6bseRUttA1lqVEUVI3JxK01J44mwxCael+dlQLLA7vZjXVQQ7OBQnE6iIxtBTXeCR
        ImOG2OhzXWYJBbeaCRJM8CDHHwhpRKJBAE1FMdg0FB6l5hrBc2ELTNWjQncuzgP6yccu91Zu935vF
        pcCRHJ6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwKdJ-00F9hx-3z; Tue, 09 May 2023 10:31:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29CF1300451;
        Tue,  9 May 2023 12:31:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10E2120B21BBF; Tue,  9 May 2023 12:31:47 +0200 (CEST)
Date:   Tue, 9 May 2023 12:31:46 +0200
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
Subject: Re: [patch v3 08/36] x86/smpboot: Split up native_cpu_up() into
 separate phases and document them
Message-ID: <20230509103146.GW83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185217.671595388@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508185217.671595388@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


And since I'm commenting on existing things anyway, let me continue...

On Mon, May 08, 2023 at 09:43:39PM +0200, Thomas Gleixner wrote:

> +static int wait_cpu_cpumask(unsigned int cpu, const struct cpumask *mask)
> +{
> +	unsigned long timeout;
>  
> +	/*
> +	 * Wait up to 10s for the CPU to report in.
> +	 */
> +	timeout = jiffies + 10*HZ;
> +	while (time_before(jiffies, timeout)) {
> +		if (cpumask_test_cpu(cpu, mask))
> +			return 0;
> +
> +		schedule();
>  	}
> +	return -1;
> +}

> +/*
> + * Bringup step three: Wait for the target AP to reach smp_callin().
> + * The AP is not waiting for us here so we don't need to parallelise
> + * this step. Not entirely clear why we care about this, since we just
> + * proceed directly to TSC synchronization which is the next sync
> + * point with the AP anyway.
> + */
> +static void wait_cpu_callin(unsigned int cpu)
> +{
> +	while (!cpumask_test_cpu(cpu, cpu_callin_mask))
> +		schedule();
> +}
> +
> +/*
> + * Bringup step four: Synchronize the TSC and wait for the target AP
> + * to reach set_cpu_online() in start_secondary().
> + */
> +static void wait_cpu_online(unsigned int cpu)
>  {
>  	unsigned long flags;
> +
> +	/*
> +	 * Check TSC synchronization with the AP (keep irqs disabled
> +	 * while doing so):
> +	 */
> +	local_irq_save(flags);
> +	check_tsc_sync_source(cpu);
> +	local_irq_restore(flags);
> +
> +	/*
> +	 * Wait for the AP to mark itself online, so the core caller
> +	 * can drop sparse_irq_lock.
> +	 */
> +	while (!cpu_online(cpu))
> +		schedule();
> +}

These schedule() loops make me itch... this is basically Ye Olde yield()
loop with all it's known 'benefits'.

Now, I don't think it's horribly broken, we're explicitly waiting on
another CPU and can't have priority inversions, but yuck!

It could all be somewhat cleaned up with wait_var_event{_timeout}() and
wake_up_var(), but I'm really not sure that's worth it. But at least it
requires a comment to justify.
