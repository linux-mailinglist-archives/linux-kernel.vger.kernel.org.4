Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD81A6FC373
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjEIKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjEIKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:06:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FA74220;
        Tue,  9 May 2023 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iQWsW3vK30T3lTlKXPjWF0ZCCCbqYMC5X75lG5LhBXg=; b=cDPXLQL0z0hLF1/yioFQfmCaBB
        N8lg3b/6x/H60+tu73L248gNyd5xmZKox7zPuU6VKCA8HcngpEx3i7EoIRxvCJJ2pou+WtOB8+c9l
        YAHhjctqF48WprPL0AyMzqqVZVwEpLUFVHpyjG9u8qxjZkI2cmceUyq18t9h1WvD06PgFHVUtc705
        oUIyYOlqGQYWw9krcv5O2YQSBJhVKeLH6KQpRFn783U2eBmeNUpii/ZsJVFV2chFCnrg6UHHo2dd7
        DFXEbQ718ZPPJ5wbZiakPwUWdfgyQIDGAdRJdu8G/8DVLYhi0TuNwKpexszZz1O5menSPb5zkPzoM
        5WEFDxwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwKCp-00F8Kf-BN; Tue, 09 May 2023 10:04:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE21E300451;
        Tue,  9 May 2023 12:04:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36C9B20B0882F; Tue,  9 May 2023 12:04:21 +0200 (CEST)
Date:   Tue, 9 May 2023 12:04:21 +0200
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
Message-ID: <20230509100421.GU83892@hirez.programming.kicks-ass.net>
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

On Mon, May 08, 2023 at 09:43:39PM +0200, Thomas Gleixner wrote:

> @@ -233,14 +237,31 @@ static void notrace start_secondary(void
>  	load_cr3(swapper_pg_dir);
>  	__flush_tlb_all();
>  #endif
> +	/*
> +	 * Sync point with wait_cpu_initialized(). Before proceeding through
> +	 * cpu_init(), the AP will call wait_for_master_cpu() which sets its
> +	 * own bit in cpu_initialized_mask and then waits for the BSP to set
> +	 * its bit in cpu_callout_mask to release it.
> +	 */
>  	cpu_init_secondary();
>  	rcu_cpu_starting(raw_smp_processor_id());
>  	x86_cpuinit.early_percpu_clock_init();
> +
> +	/*
> +	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
> +	 * but just sets the bit to let the controlling CPU (BSP) know that
> +	 * it's got this far.
> +	 */
>  	smp_callin();
>  
> -	/* otherwise gcc will move up smp_processor_id before the cpu_init */
> +	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
>  	barrier();

Not to the detriment of this patch, but this barrier() and it's comment
seem weird vs smp_callin(). That function ends with an atomic bitop (it
has to, at the very least it must not be weaker than store-release) but
also has an explicit wmb() to order setup vs CPU_STARTING.

(arguably that should be a full fence *AND* get a comment)

There is no way the smp_processor_id() referred to in this comment can
land before cpu_init() even without the barrier().

> -	/* Check TSC synchronization with the control CPU: */
> +
> +	/*
> +	 * Check TSC synchronization with the control CPU, which will do
> +	 * its part of this from wait_cpu_online(), making it an implicit
> +	 * synchronization point.
> +	 */
>  	check_tsc_sync_target();
>  
>  	/*
