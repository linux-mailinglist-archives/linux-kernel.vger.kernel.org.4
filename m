Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19C26FC5DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjEIMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjEIMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03097272D;
        Tue,  9 May 2023 05:08:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683634111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auvnPlCdrxbwfVCryOkTHE8CzjY0504gnLY8d2dRonQ=;
        b=wafQfE3T818swYq6uLvh8KHiTe44B+AlTcCuev0YTvhSecK7fkanUUlrOFuq1HA2ASd8t+
        BU6tHwwDMQA0mZaxMylheStrGpAitYQ7e4+1xdIBRK50qlGuPKGUbpzNoPFc/U7pFg4vp7
        3txn/u3LsCuYBQ0eNUlaTm7ZlGVH1WlsNSZfP3xwKGSzwPqUJorHyzC7YM1MHYvCO7Lmx3
        BiJQOvEs+Zr/r7cQvp3o3X/HSCezUruhmuDtMYKpw4lmxWL4y4XK9Xj0Ms0sscYlMfQk/M
        8L9/ObIQjuOr/DXSdupvrplmykX+MkwMcI4Kqk1nxIkYGFdBkt+5ECVVyItbUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683634111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auvnPlCdrxbwfVCryOkTHE8CzjY0504gnLY8d2dRonQ=;
        b=iQxVDqhAuaPEJSQzwxbX/REaKwQ08dwCm2L5m3NrRVeFnmsUvKPu/IfGcUkN/jYTMsh6S3
        yqlu1nzMP1/UIxCA==
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
Date:   Tue, 09 May 2023 14:08:31 +0200
Message-ID: <87mt2d1zcw.ffs@tglx>
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

As this is gone a few patches later, I just be lazy and leave it alone.
