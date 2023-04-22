Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA26EB7FB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDVIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 04:22:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F519B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oPp9UqoR4UBtVjA+K7yc1Qs4FdXoMSW5rFP84hUISRE=; b=CXL6rxoB064EkSMHipzGP8FP98
        8sFr0QS8RVGYYhbGbshXsSdu9Mx2Sr50X+BLrf4OA2pdCNZwsTo3B5MlOh6zaYb2w1qMgFxO6jRL+
        fX5DszM1SThUy1MzGBRrbUjvGS/QNXFSl/oJORP/rMf8PbMyaxQRZEGdq1fYAcni3HeTXHpNZrmjg
        88Fs1mmC8WcHhP79crOYC5CJKxs1TKAllLeEIroSR3lrrxHnl7ScjLaJX0kLziR7vhe6juQCKHEgJ
        OoxtTpAavUISgh0ywY6e6P27osZ+ALh6eWGna0AR+Aox4YIVqVUqCrSPsaQNb1Jl/RazT6h9V67og
        NOcxET8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pq8VZ-00G4YL-5g; Sat, 22 Apr 2023 08:22:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B542300338;
        Sat, 22 Apr 2023 10:22:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDD1E23BD94AF; Sat, 22 Apr 2023 10:22:11 +0200 (CEST)
Date:   Sat, 22 Apr 2023 10:22:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, tsbogend@alpha.franken.de
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <20230422082211.GA1215777@hirez.programming.kicks-ass.net>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ MIPS Thomas

On Sat, Apr 22, 2023 at 10:17:00AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 21, 2023 at 05:24:36PM +0200, Thomas Gleixner wrote:
> > On Fri, Apr 21 2023 at 14:36, Frederic Weisbecker wrote:
> > > I'm looking at the __arch_cpu_idle() implementation in Loongarch
> > > and I'm wondering about the rollback code. I don't understand well
> > > that code but with the help from PeterZ I might have seen something,
> > > so tell me if I'm wrong: when an interrupt happens within
> > > __arch_cpu_idle(), handle_vint() rolls back the return value to the
> > > beginning of __arch_cpu_idle(), so that TIF_NEED_RESCHED is checked
> > > again. Is that correct?
> > >
> > > Because if an interrupt fires while in __arch_cpu_idle(), that IRQ
> > > might enqueue a new timer and that new timer needs to be reprogrammed
> > > from the main idle loop and just checking TIF_NEED_RESCHED doesn't
> > > tell about that information.
> > 
> > The check for TIF_NEED_RESCHED as loop termination condition is simply
> > wrong. The architecture is not to supposed to loop in arch_cpu_idle().
> > 
> > That loop is from Linux 0.9 days. Seems MIPS::__r4k_wait() and
> > loongarch, which copied that muck are still stuck in the 1990'ies.
> > 
> > It has to return when an interrupt brings it out of the "idle wait"
> > instruction.
> 
> So I think the below is enough for these two...
> 
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 44ff1ff64260..5a102ff80de0 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>  	ori	t0, t0, 0x1f
>  	xori	t0, t0, 0x1f
>  	bne	t0, t1, 1f
> +	addi.d	t0, t0, 0x20
>  	LONG_S	t0, sp, PT_ERA
>  1:	move	a0, sp
>  	move	a1, sp
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index b6de8e88c1bd..cd6aae441ad9 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -140,6 +140,7 @@ LEAF(__r4k_wait)
>  	ori	k0, 0x1f	/* 32 byte rollback region */
>  	xori	k0, 0x1f
>  	bne	k0, k1, \handler
> +	addiu	k0, 0x20
>  	MTC0	k0, CP0_EPC
>  	.set pop
>  	.endm
