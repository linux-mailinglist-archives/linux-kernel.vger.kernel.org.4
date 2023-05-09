Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB56FC5FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEIMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjEIMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:12:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCE3C25;
        Tue,  9 May 2023 05:12:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683634332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeDWxrG4XUYobVqWgAe3O2JPVJDj89o+5jrCfskGJg8=;
        b=hl/TK4RBTejer0s1ss/VQWoTE3DJHIErNy5ObBMt3F35AuGijMu5SQIYqEXIyyWfguIJ74
        IuVIsOwOjI+DOYpi1oyZvtSrA4xy0VqeURht3o6yDrYLZd0dCj9sQmFOFO0ByR3FGuzx1X
        DX/4mqvZ8z2EcTfmL6YwZj0AheRNPYO2Sw/CFuIRodeNmQ9+fMov+UrbzmNB3mOPDT4LpP
        XixRF4zedTnImudhtqeC8vGLPe0PN84sIltm+fYhikFa7xWpApb8aT+EKAws94oS5Kw77W
        ZD3DPvNRfQa9kERCm1KsnYEOdLoCE866a9iJjH9pstUyHznEaCqcjcX+ulrAEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683634332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeDWxrG4XUYobVqWgAe3O2JPVJDj89o+5jrCfskGJg8=;
        b=C/RxUkGIvC1trkLde7ELOcrRJTFX/YyTBVeqxDPOcpgYwMXYyUXrtmmSUhQ5qz65ax/jQH
        CAvGiAfvhE+ZmGAQ==
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [patch v3 18/36] [patch V2 18/38] cpu/hotplug: Add CPU state
 tracking and synchronization
In-Reply-To: <20230509110722.GZ83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.240871842@linutronix.de>
 <20230509110722.GZ83892@hirez.programming.kicks-ass.net>
Date:   Tue, 09 May 2023 14:12:12 +0200
Message-ID: <87bkit1z6r.ffs@tglx>
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

On Tue, May 09 2023 at 13:07, Peter Zijlstra wrote:
> On Mon, May 08, 2023 at 09:43:55PM +0200, Thomas Gleixner wrote:
>
>> +static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state)
>> +{
>> +	atomic_t *st = this_cpu_ptr(&cpuhp_state.ap_sync_state);
>> +	int sync = atomic_read(st);
>> +
>> +	while (!atomic_try_cmpxchg(st, &sync, state));
>> +}
>
> Why isn't:
>
> 	atomic_set(st, state);
>
> any good?

Good question. It's only the other side (control CPU) which needs to be
careful.

Thanks,

        tglx
