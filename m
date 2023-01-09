Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E634662C27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjAIRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjAIQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:59:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B310FFE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8EE611A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A990C433EF;
        Mon,  9 Jan 2023 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673283583;
        bh=RqksMv4zD/LvjPuFnm3sY2NeruEioV5qSYQooqnLggE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WElBdOgKCKysiCPvAAcTV7yi828Zu8bJ7GpC9SHxb/V1umXJOfsxCZDUiaiAz/p9x
         cZrMym4zmCh+6k0oHm7E7WFAx3eo0LT65EkfoYZ32RCOvMxP+sIsVU0Gk+iLMnxPl4
         DspBXWwBv1bwhiDHQeBl8yIm+0khFjY6q/wcayH5fwjE/lbKwIF+nFKJyBjOq2sNus
         Ot4nh2tC0aSAb604q9D5pX1nGKutEjsgxr/ZJvVU21QEwgFXF9ORpMAdVAVBYSsMkO
         ANGmzyFFHyP7US/gewKKfYT6+sLhhmfPVs9XHYWaTHFKks68MZ9JKRi0cIiJbMKaBG
         crS2VNTIfi8OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B53705C090A; Mon,  9 Jan 2023 08:59:42 -0800 (PST)
Date:   Mon, 9 Jan 2023 08:59:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH x86/nmi 1/2] x86/nmi: Accumulate NMI-progress evidence in
 exc_nmi()
Message-ID: <20230109165942.GQ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105011537.1774941-1-paulmck@kernel.org>
 <Y7w+r3Nbubin8sNN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7w+r3Nbubin8sNN@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 05:19:59PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 04, 2023 at 05:15:36PM -0800, Paul E. McKenney wrote:
> 
> > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > index cec0bfa3bc04f..4f1651dc65b3a 100644
> > --- a/arch/x86/kernel/nmi.c
> > +++ b/arch/x86/kernel/nmi.c
> > @@ -69,6 +69,15 @@ struct nmi_stats {
> >  	unsigned int unknown;
> >  	unsigned int external;
> >  	unsigned int swallow;
> > +	unsigned long recv_jiffies;
> > +	unsigned long idt_seq;
> > +	unsigned long idt_nmi_seq;
> > +	unsigned long idt_ignored;
> > +	atomic_long_t idt_calls;
> > +	unsigned long idt_seq_snap;
> > +	unsigned long idt_nmi_seq_snap;
> > +	unsigned long idt_ignored_snap;
> > +	long idt_calls_snap;
> >  };
> 
> Urgh, this is more than a whole cacheline of extra data :/ Can't we make
> this #ifdef CONFIG_NMI_CHECK_CPU ?

We can.  However, the new data is at the end of the structure.  Plus doing
that will also require converting the IS_ENABLED() checks to #ifdef or
to lots of tiny functions, neither of which will be at all pretty.

Another approach would be to have a #else that created a union of all
of these fields, thus reducing this unused space so that of a single
unsigned long, while still permitting IS_ENABLED() checks.  Thoughts?

> > @@ -509,8 +526,15 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
> >  
> >  	inc_irq_stat(__nmi_count);
> >  
> > -	if (!ignore_nmis)
> > +	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU) && ignore_nmis) {
> > +		WRITE_ONCE(nsp->idt_ignored, nsp->idt_ignored + 1);
> > +	} else if (!ignore_nmis) {
> > +		WRITE_ONCE(nsp->idt_nmi_seq, nsp->idt_nmi_seq + 1);
> > +		WARN_ON_ONCE(!(nsp->idt_nmi_seq & 0x1));
> >  		default_do_nmi(regs);
> > +		WRITE_ONCE(nsp->idt_nmi_seq, nsp->idt_nmi_seq + 1);
> > +		WARN_ON_ONCE(nsp->idt_nmi_seq & 0x1);
> > +	}
> >  
> >  	irqentry_nmi_exit(regs, irq_state);
> 
> That is not a NO-OP when !CONFIG_NMI_CHECK_CPU :/

Good catch, will fix!

							Thanx, Paul
