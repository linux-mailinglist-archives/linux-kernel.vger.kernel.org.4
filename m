Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314CD6FC5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjEIMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjEIMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:07:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5730D5;
        Tue,  9 May 2023 05:07:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683634040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8MCFM0FDR2P5xT6w7iIAowrB6rGKJkA6dzl9HivHWk=;
        b=WQKf9JTpFPSQGT0uFg5INijnVR8R5fqcikzHfuS5DVBLQGQ7GwJQT+EVszHAmjT/3/UBuz
        qVYnARbWYomJ6gliEb43t5la/h6VifzuO+zL/GRl0NjzHXmgK5N/FGwqL06FgLMkljqBFm
        XyfTJfmksGnqa6BjZhyerBbGE6iuFhkjn27fQrUXAQ1QApceQPW64uUNRla+fMpap+pUkk
        SWZ9l1mk0piAcuHN5EvFC700NqxfjfjIo2TZ35Uf44N6qz9M7DRMymepQA2ZWVsdTMQEJG
        ZopQRoGBKBzZCgD4GsYTMKx5vSxJBSs3/zJnl8HdNjGWI5X3/Fou00r0/4324g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683634040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8MCFM0FDR2P5xT6w7iIAowrB6rGKJkA6dzl9HivHWk=;
        b=HEbhRwUpE3y701WVF4If5EM5F8H8s6m0+F3iRYhv9+fKfUn3XmN66AS4uimVHFaZrmTvUY
        YoYD1EwiDwf+ofDQ==
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
In-Reply-To: <20230509100421.GU83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185217.671595388@linutronix.de>
 <20230509100421.GU83892@hirez.programming.kicks-ass.net>
Date:   Tue, 09 May 2023 14:07:20 +0200
Message-ID: <87pm791zev.ffs@tglx>
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

On Tue, May 09 2023 at 12:04, Peter Zijlstra wrote:
> On Mon, May 08, 2023 at 09:43:39PM +0200, Thomas Gleixner wrote:
>> +	/*
>> +	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
>> +	 * but just sets the bit to let the controlling CPU (BSP) know that
>> +	 * it's got this far.
>> +	 */
>>  	smp_callin();
>>  
>> -	/* otherwise gcc will move up smp_processor_id before the cpu_init */
>> +	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
>>  	barrier();
>
> Not to the detriment of this patch, but this barrier() and it's comment
> seem weird vs smp_callin(). That function ends with an atomic bitop (it
> has to, at the very least it must not be weaker than store-release) but
> also has an explicit wmb() to order setup vs CPU_STARTING.
>
> (arguably that should be a full fence *AND* get a comment)
>
> There is no way the smp_processor_id() referred to in this comment can
> land before cpu_init() even without the barrier().

Right. Let me clean that up.

Thanks,

        tglx
