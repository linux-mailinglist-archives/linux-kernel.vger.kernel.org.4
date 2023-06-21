Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC913739080
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFUUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:04:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135571712
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jivk2cvZYtRDS6c1ZZTS2atKicw7SGBfxJ5V2QQO2lc=; b=bOmVP8i8J+qXbFKXBmni1/ADKR
        0YU839Jcfdu6iaEVAPZRHL/ocHT7HLuVKEmCWaw1mH4SYKTKJGbB6dLcSsM2G5Aae35IMV4dAsCZL
        BQWMY2KrD0/D/RebgdbfICwS00zU4L1H3cK0bBvgHQEIs1hbMxIUe/9rkJWxXV69mIWJIXAoLZjq2
        Ptzy0VI2xGHRtAUO1UNLSyqA37mM2GRInLrNpRmUIO1oBlU9SoyEgxvD6izFUCbLQ7JlwpsM1PjKt
        DQE0MF/mBc559+i7jQ1HtmMA7QeS6ST1GXTuWjuponAg+bUH0jQJ2nGVXYgiOPy0PtquEKS9XJKXV
        E5IWpmcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC43n-00058b-2F;
        Wed, 21 Jun 2023 20:04:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BABC30031B;
        Wed, 21 Jun 2023 22:04:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DAED213E05DC; Wed, 21 Jun 2023 22:04:09 +0200 (CEST)
Date:   Wed, 21 Jun 2023 22:04:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Per Bilse <Per.Bilse@citrix.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Message-ID: <20230621200409.GC4253@hirez.programming.kicks-ass.net>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 07:19:21PM +0000, Per Bilse wrote:
> On 6/21/2023 5:40 PM, Peter Zijlstra wrote:
> > I don't understand it -- fundamentally, how can linux schedule when the
> > guest isn't even running? Hypercall transfers control to the
> > host/hypervisor and leaves the guest suspended.
> 
> Hi Peter, as noted in earlier note to Andy, this is essentially existing
> code that other commits have rendered ineffective over time.  Hence,
> the finer details of how or why it works haven't changed since it was
> first introduced.

That doesn't mean you don't have to explain how stuff works.

> > This makes no sense; the race that warning warns about is:
> > 
> > 	CPU0			CPU1
> > 	per-cpu write
> > 	<preempt-out>
> > 				<preempt-in>
> > 				do-hypercall
> > 
> > So you wrote the value on CPU0, got migrated to CPU1 because you had
> > preemptioned enabled, and then continue with the percpu value of CPU1
> > because that's where you're at now.
> 
> This issue was raised internally, and it was noted that the only way
> for the preemptible code to switch task is via an interrupt that goes
> through xen_pv_evtchn_do_upcall(), which handles this.  I'm happy to
> check with my sources, but it's holiday season right now.

Then it should have all sorts of comments on and a comprehensive
changelog.

> >> 4) Update irqentry_exit_cond_resched() to raw_irqentry_exit_cond_resched().
> >> The code will call irqentry_exit_cond_resched() if the flag (as noted
> >> above) is set, but the dynamic preemption feature will livepatch that
> >> function to a no-op unless full preemption is selected.  The code is
> >> therefore updated to call raw_irqentry_exit_cond_resched().
> > 
> > That, again meeds more explanation. Why do you want this if not
> > preemptible?
> 
> I'm not quite sure what you mean here.  Dynamic preemption
> will livepatch irqentry_exit_cond_resched() to be a no-op, while
> raw_irqentry_exit_cond_resched() remains functional.  This was 
> introduced in commit 4624a14f4daa last year which was said to fix
> the problem, but doesn't.  You may remember, it was signed off by 
> yourself and Mark Rutland.

I don't see the relation; what you're doing is making dynamic preempt
that's not configured for full preempt do preemption. That's weird, and
again no comments.

I'm with Andy in that simply forcing full preemption would make far more
sense -- but I'm still missing something fundamental, see below.

> > You're doing 4 things, that should be 4 patches. Also, please give more
> > clues for how this is supposed to work at all.
> 
> I respectfully have to disagree with that.  The fixes here are very
> closely related, and we're not introducing anything new, we're merely
> re-enabling code which has been rendered ineffective due to oversights
> in commits made after the code was first introduced.  How the code is
> supposed to work hasn't changed, and is beyond the scope of these fixes;
> I'm sure it must have been discussed at great length at the time (commit 
> fdfd811ddde3).

You didn't even so much as reference that commit, nor provide any other
explanation. And having now read that commit, I'm not much enlightend.

*HOW* can a hypercall, something that exits the Guest and has the
Host/Hypervisor run get preempted in the Guest -- that isn't running.

Or are you calling apples pears?
