Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECE738729
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjFUOg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjFUOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:36:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A421BC1;
        Wed, 21 Jun 2023 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XF6WLknEk00s0CGB8SGhE9Z7BuDNsIowtmxtGqyuqs8=; b=Wklw+5s3Dy3I7wKwZAAgPkPhsg
        sDuWCKE8eWay2uz6IPjhYpzDmX37GmUXx0To0MUxRBRMTnpGDlwfF6vdrApfKJ3VJi7AZbjyVwLtg
        4igRqurnGpt5927uBDUa7PGOy9EG8kXRILIop2ZL252dIcblNgre9nYNET4VQkEOEr5y76PG/f5wg
        KXrkkIpMsVrrwjYVS/RB3WuOcRtrn52ZyNzYLmXBK85qeqbMNi2YYKiBNmpBwY4KwW5ivMDfIBX+n
        yo4MtAms6fa8bjWBN1ysZr/F05PXH2rRjmAd2qXbQpbKuvka+ZYr7zU3DjA2j77Tuw2GVnTFrYr/D
        HW0WCLnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBywF-00ERUK-ML; Wed, 21 Jun 2023 14:36:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2AAF3002F0;
        Wed, 21 Jun 2023 16:36:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A10AE2130B4A4; Wed, 21 Jun 2023 16:36:02 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:36:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 2/5] x86/idle: Disable IBRS when cpu is offline
Message-ID: <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-3-longman@redhat.com>
 <20230621072313.GA2046280@hirez.programming.kicks-ass.net>
 <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:59:52AM -0400, Waiman Long wrote:
> 
> On 6/21/23 03:23, Peter Zijlstra wrote:
> > On Tue, Jun 20, 2023 at 10:06:22AM -0400, Waiman Long wrote:
> > > Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> > > disables IBRS when the CPU enters long idle. However, when a CPU becomes
> > > offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS is
> > > enabled. That will impact the performance of a sibling CPU. Mitigate
> > > this performance impact by clearing all the mitigation bits in SPEC_CTRL
> > > MSR when offline and restoring the value of the MSR when it becomes
> > > online again.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   arch/x86/kernel/smpboot.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > index 352f0ce1ece4..5ff82fef413c 100644
> > > --- a/arch/x86/kernel/smpboot.c
> > > +++ b/arch/x86/kernel/smpboot.c
> > > @@ -84,6 +84,7 @@
> > >   #include <asm/hw_irq.h>
> > >   #include <asm/stackprotector.h>
> > >   #include <asm/sev.h>
> > > +#include <asm/nospec-branch.h>
> > >   /* representing HT siblings of each logical CPU */
> > >   DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
> > > @@ -1838,12 +1839,24 @@ void __noreturn hlt_play_dead(void)
> > >   void native_play_dead(void)
> > >   {
> > > +	u64 spec_ctrl = spec_ctrl_current();
> > > +
> > > +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
> > > +		this_cpu_write(x86_spec_ctrl_current, 0);
> > > +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> > > +	}
> > > +
> > >   	play_dead_common();
> > >   	tboot_shutdown(TB_SHUTDOWN_WFS);
> > >   	mwait_play_dead();
> > >   	if (cpuidle_play_dead())
> > >   		hlt_play_dead();
> > > +
> > > +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
> > > +		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> > > +		this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
> > > +	}
> > >   }
> > play_dead() is marked __noreturn
> 
> There are different versions of play_dead() in the kernel. Some of them are
> indeed marked __noreturn like the non-SMP one in arch/x86/kernel/process.c.
> The native_play_dead() that I am patching isn't one of those.

mostly by accident I think, hlt_play_dead() is, so I'm thinking
everybody (all compiler and objtool) managed to figure out
native_play_dead() is __noreturn too.
