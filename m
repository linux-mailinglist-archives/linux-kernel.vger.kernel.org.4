Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEB6FCD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjEISDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEISDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:03:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2E40F6;
        Tue,  9 May 2023 11:03:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683655413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8lMKg/Pl8bB6qnYC08+nBqTm61HWmUyuaLIaj1gFuQ=;
        b=p/DT4GAI2EtIvZG/E48g6Y7O0PSW6I7fXi+Elpt8is0SHczyNHYG4WQo1p8SYYocLErxKG
        tmvgrxjIF+UxfScN840YPnkbKctQmYUakhWVsbINnsqgaMlRICOjt3Qfc6Up2X1bjDtoAO
        ar+k+iD6nwCsxY3BjhAFgFJUIEJHTt1PrRE8rbODQZgYjBKNgq6ykZLI1Uu1z7pabrzvU3
        BwVO+gXxHyh4uHTSjhXVxYRN+IF1E8Jy0qeflsgMafTVMfAIUm1oLIOiNDcRtX6ADo3QXJ
        K1YoDfr+wSZLKitYMptlFZ4BJxPZWh1AEKhWq/8P8VH08qDCjiggV3Xig5/J1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683655413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8lMKg/Pl8bB6qnYC08+nBqTm61HWmUyuaLIaj1gFuQ=;
        b=o/GeRRk5OesDmJnkkrzpp/P4MfatYoS6Fv9RucWpaz9lKWhE91kzNOmkETuNZ878NLl+Jz
        nDab+Y4hdtD/OPAA==
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
In-Reply-To: <20230509101902.GV83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185217.671595388@linutronix.de>
 <20230509101902.GV83892@hirez.programming.kicks-ass.net>
Date:   Tue, 09 May 2023 20:03:32 +0200
Message-ID: <87lehxz8jv.ffs@tglx>
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

On Tue, May 09 2023 at 12:19, Peter Zijlstra wrote:
> Again, not really this patch, but since I had to look at this code ....
>
> On Mon, May 08, 2023 at 09:43:39PM +0200, Thomas Gleixner wrote:
>> @@ -1048,60 +1066,89 @@ static int do_boot_cpu(int apicid, int c
>
> 	/*
> 	 * AP might wait on cpu_callout_mask in cpu_init() with
> 	 * cpu_initialized_mask set if previous attempt to online
> 	 * it timed-out. Clear cpu_initialized_mask so that after
> 	 * INIT/SIPI it could start with a clean state.
> 	 */
> 	cpumask_clear_cpu(cpu, cpu_initialized_mask);
> 	smp_mb();
>
> ^^^ that barrier is weird too, cpumask_clear_cpu() is an atomic op and
> implies much the same (this is x86 after all). If you want to be super
> explicit about it write:
>
> 	smp_mb__after_atomic();
>
> (which is a no-op) but then it still very much requires a comment as to
> what exactly it orders against what.

Won't bother either as that mask is gone a few patches later.
