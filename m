Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C6738BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjFUQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFUQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:41:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305FA118
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q8ZpFd9zhJ6vbE7RC8xwAURukdS6rBx4YiofuzrByd8=; b=mpUuWq+T2KEHGEgVKWj10ELKCz
        RJDgr2Qe8zmvnwKiugBusbRYyOc5Ln+Cd9vXiQ20G/U57IC9UXEI0htlLw3JOs+bChUIkR15xEqx4
        RHFQqKdXb2TnlCdi7o+5jABPENEBlQ4yjhqXjzpH2B8LtnV3QNYMkvLiUvh3YbrKUBGVQzlPhlTHu
        GQt8CdgE5hfCutdqilwWM4+tDzV3FdCMiOXl97eXC8ORKD3M4zcdsJKzo7/TAZ1DVIzbZ7AWUUQxM
        rFvOleEU91DCsYoLwnQlv6RxRUI268mIHeMP9aIs7EDbiIgyROsIgXIVQklKLkOHSiMJlq6qxEPg0
        zDf1a9fQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC0sq-00HaPO-2N;
        Wed, 21 Jun 2023 16:40:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55932300274;
        Wed, 21 Jun 2023 18:40:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DB482130B3BB; Wed, 21 Jun 2023 18:40:38 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:40:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Per Bilse <per.bilse@citrix.com>
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
Message-ID: <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621151442.2152425-1-per.bilse@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:14:42PM +0000, Per Bilse wrote:
> Some Xen hypercalls issued by dom0 guests may run for many 10s of
> seconds, potentially causing watchdog timeouts and other problems.
> It's rare for this to happen, but it does in extreme circumstances,
> for instance when shutting down VMs with very large memory allocations
> (> 0.5 - 1TB).  These hypercalls are preemptible, but the fixes in the
> kernel to ensure preemption have fallen into a state of disrepair, and
> are currently ineffective.  This patch brings things up to date by way of:

I don't understand it -- fundamentally, how can linux schedule when the
guest isn't even running? Hypercall transfers control to the
host/hypervisor and leaves the guest suspended.

> 1) Update general feature selection from XEN_PV to XEN_DOM0.
> The issue is unique to dom0 Xen guests, but isn't unique to PV dom0s,
> and will occur in future PVH dom0s.  XEN_DOM0 depends on either PV or PVH,
> as well as the appropriate details for dom0.
> 
> 2) Update specific feature selection from !PREEMPTION to !PREEMPT.
> The following table shows the relationship between different preemption
> features and their indicators/selectors (Y = "=Y", N = "is not set",
> . = absent):
> 
>                             | np-s | np-d | vp-s | vp-d | fp-s | fp-d
>     CONFIG_PREEMPT_DYNAMIC      N      Y      N      Y      N      Y
>          CONFIG_PREEMPTION      .      Y      .      Y      Y      Y
>             CONFIG_PREEMPT      N      N      N      N      Y      Y
>   CONFIG_PREEMPT_VOLUNTARY      N      N      Y      Y      N      N
>        CONFIG_PREEMPT_NONE      Y      Y      N      N      N      N
> 
> Unless PREEMPT is set, we need to enable the fixes.
> 
> 3) Update flag access from __this_cpu_XXX() to raw_cpu_XXX().
> The long-running hypercalls are flagged by way of a per-cpu variable
> which is set before and cleared after the relevant calls.  This elicits
> a warning "BUG: using __this_cpu_write() in preemptible [00000000] code",
> but xen_pv_evtchn_do_upcall() deals specifically with this.  For
> consistency, flag testing is also updated, and the code is simplified
> and tidied accordingly.

This makes no sense; the race that warning warns about is:

	CPU0			CPU1
	per-cpu write
	<preempt-out>
				<preempt-in>
				do-hypercall

So you wrote the value on CPU0, got migrated to CPU1 because you had
preemptioned enabled, and then continue with the percpu value of CPU1
because that's where you're at now.

Simply making the warning go away doesn't help, CPU1 does hypercall
while store was on CPU0.

> 4) Update irqentry_exit_cond_resched() to raw_irqentry_exit_cond_resched().
> The code will call irqentry_exit_cond_resched() if the flag (as noted
> above) is set, but the dynamic preemption feature will livepatch that
> function to a no-op unless full preemption is selected.  The code is
> therefore updated to call raw_irqentry_exit_cond_resched().

That, again meeds more explanation. Why do you want this if not
preemptible?

You're doing 4 things, that should be 4 patches. Also, please give more
clues for how this is supposed to work at all.


