Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD26FC439
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjEIKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjEIKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:50:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D519A1;
        Tue,  9 May 2023 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8P7wZHGsQrdcODAexcyC5HmNjq7UyxY+a/r9BHYLyPc=; b=LZcrlvoWgQ+AuQIzSKoAbD0LMI
        b6BHDQIQNgv1TgrA6LONLCnHui8tdPe3S7PqOkv3sYRCrscZ+XMID94S8/TszoyfPgDPSAtQ+UTEb
        h4a3MCLNpB/XRmwM0n8A1ogc7k4Bpmn3jlbth/DX7axlvB31Yl6fCYMH6bJHqtyrRocreKHmePIjY
        oGkzR9e3lZU/07+fFI0IW2dT3qtKo/wVGsmWPmVsGg8bTZtIl1kVM5ehFmk3qTLmzEE7S3RcUzrrq
        Hzf61paJrYytBCotmCbO9yxt1Ffzzoe6S7f87moZIuIvJFRKis9FFf32XMpNwcYOWQPfdMZxjOYjd
        W8dWFyOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwKuD-0066WL-1Q;
        Tue, 09 May 2023 10:49:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2CAA300023;
        Tue,  9 May 2023 12:49:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A111020B0882C; Tue,  9 May 2023 12:49:15 +0200 (CEST)
Date:   Tue, 9 May 2023 12:49:15 +0200
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [patch v3 13/36] x86/smpboot: Remove cpu_callin_mask
Message-ID: <20230509104915.GX83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185217.956149661@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508185217.956149661@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:43:47PM +0200, Thomas Gleixner wrote:

> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c

> @@ -167,21 +166,16 @@ static inline void smpboot_restore_warm_
>   */
>  static void smp_callin(void)
>  {
> -	int cpuid;
> +	int cpuid = smp_processor_id();
>  
>  	/*
>  	 * If waken up by an INIT in an 82489DX configuration
> -	 * cpu_callout_mask guarantees we don't get here before
> -	 * an INIT_deassert IPI reaches our local APIC, so it is
> -	 * now safe to touch our local APIC.
> -	 */
> -	cpuid = smp_processor_id();
> -
> -	/*
> -	 * the boot CPU has finished the init stage and is spinning
> -	 * on callin_map until we finish. We are free to set up this
> -	 * CPU, first the APIC. (this is probably redundant on most
> -	 * boards)
> +	 * cpu_callout_mask guarantees we don't get here before an
> +	 * INIT_deassert IPI reaches our local APIC, so it is now safe to
> +	 * touch our local APIC.
> +	 *
> +	 * Set up this CPU, first the APIC, which is probably redundant on
> +	 * most boards.
>  	 */
>  	apic_ap_setup();
>  
> @@ -192,7 +186,7 @@ static void smp_callin(void)
>  	 * The topology information must be up to date before
>  	 * calibrate_delay() and notify_cpu_starting().
>  	 */
> -	set_cpu_sibling_map(raw_smp_processor_id());
> +	set_cpu_sibling_map(cpuid);
>  
>  	ap_init_aperfmperf();
>  
> @@ -205,11 +199,6 @@ static void smp_callin(void)
>  	 * state (CPUHP_ONLINE in the case of serial bringup).
>  	 */
>  	notify_cpu_starting(cpuid);
> -
> -	/*
> -	 * Allow the master to continue.
> -	 */
> -	cpumask_set_cpu(cpuid, cpu_callin_mask);
>  }
>  
>  static void ap_calibrate_delay(void)
> @@ -268,11 +257,6 @@ static void notrace start_secondary(void
>  	rcu_cpu_starting(raw_smp_processor_id());
>  	x86_cpuinit.early_percpu_clock_init();
>  
> -	/*
> -	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
> -	 * but just sets the bit to let the controlling CPU (BSP) know that
> -	 * it's got this far.
> -	 */
>  	smp_callin();
>  
>  	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */

Good riddance to that mask; however is smp_callin() still an appropriate
name for that function?

Would smp_starting() -- seeing how this kicks of CPU_STARTING not be a
better name?
