Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C46FCD1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjEIR7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjEIR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:59:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEF240F4;
        Tue,  9 May 2023 10:59:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683655167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xum3/PoQhkj8+lZ0cf9sSFx6MXDYkjs5zNnUN+Pv1LU=;
        b=Nkxxvef/gwwBJnsMEIx+ow4OwBi+0uHyp5RBmTf5nu2aiSk0OvZ3yifQpp8iu0sBDEUJcj
        a1p/dXIoIW4cJOIsg3u9nq+3ZMGA79rnrh+h78apzOr+Woxv52xV94jRRDOLibuFSvjBwU
        SUohqreBen1xyv3eEH/AIWmtrxMik/GCCKHEY26BeCG6MKFWZnPkyvuY6oXd/duWViLVW4
        n9vlzd7qcknLzQIMlzIHP9a/aIzu+mUh7LOMVIovsp4Zig3bcOdy74WIwY4m1K8dtzitFX
        d+4WVMFQBWUbsdvHH09vwdfFlTvUiShojFdmigWEUDG66lPt7MAObiHtgpD6iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683655167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xum3/PoQhkj8+lZ0cf9sSFx6MXDYkjs5zNnUN+Pv1LU=;
        b=hLLA1dOtcFDkk6Slof++fN9bjbnwHItgF9jR7A+4LDWa4ZEHpxGnn+ndm2NGXZQsn8wojt
        9d63Rl+ydABO0vAQ==
To:     Peter Zijlstra <peterz@infradead.org>
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
In-Reply-To: <87pm791zev.ffs@tglx>
References: <20230508181633.089804905@linutronix.de>
 <20230508185217.671595388@linutronix.de>
 <20230509100421.GU83892@hirez.programming.kicks-ass.net>
 <87pm791zev.ffs@tglx>
Date:   Tue, 09 May 2023 19:59:26 +0200
Message-ID: <87o7mtz8qp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09 2023 at 14:07, Thomas Gleixner wrote:
> On Tue, May 09 2023 at 12:04, Peter Zijlstra wrote:
>> On Mon, May 08, 2023 at 09:43:39PM +0200, Thomas Gleixner wrote:
>>> +	/*
>>> +	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
>>> +	 * but just sets the bit to let the controlling CPU (BSP) know that
>>> +	 * it's got this far.
>>> +	 */
>>>  	smp_callin();
>>>  
>>> -	/* otherwise gcc will move up smp_processor_id before the cpu_init */
>>> +	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
>>>  	barrier();
>>
>> Not to the detriment of this patch, but this barrier() and it's comment
>> seem weird vs smp_callin(). That function ends with an atomic bitop (it
>> has to, at the very least it must not be weaker than store-release) but
>> also has an explicit wmb() to order setup vs CPU_STARTING.
>>
>> (arguably that should be a full fence *AND* get a comment)
>>
>> There is no way the smp_processor_id() referred to in this comment can
>> land before cpu_init() even without the barrier().
>
> Right. Let me clean that up.

So I went and tried to figure out where this comes from. It's from
d8f19f2cac70 ("[PATCH] x86-64 merge") in the history tree. One of those
well documented combo patches which change world and some more. The
context back then was:

	/*
	 * Dont put anything before smp_callin(), SMP
	 * booting is too fragile that we want to limit the
	 * things done here to the most necessary things.
	 */
	cpu_init();
	smp_callin();

	Dprintk("cpu %d: waiting for commence\n", smp_processor_id()); 

That still does not explain what the barrier is doing. I tried to
harvest mailing list archives, but did not find anything. The back then
list discuss@x86-64.org was never publicly archived... Boris gave me an
tarball, but this 'barrier()' add on was nowhere discussed in public.

As the barrier has no obvious value, I'm adding a patch upfront which
removes it.

Thanks,

        tglx




