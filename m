Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0A637DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKXQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:39:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744B10CE82
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D987B82887
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5C5C433C1;
        Thu, 24 Nov 2022 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669307970;
        bh=OKXY4HOb6tjr1fLTcQMjreoqibQdHiqlX3XPx/NKo9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FF5BWWm70I4oWNIABZDD5ZpFGtfi4xlErQuLbHrchom/bIyjGAbpEMOYVG8rmdXq2
         6wd7icEHORG3GbzZLud50WsU3LCUvSdfENs1JIYho+TKFacLC+WjnL1qKGuIOziaV6
         cr14plP3s5Mqnfve1ScQR/NMHdIfZXrlbW6pCyCBrO45F+TD2H29FP7OmVrMnmx+37
         0pMTWSW3bm/1D/YVt6SapbZaIjNc/Zz8CFvYh3Fs5kmEv8gpsy4teGGd6pXgMcI9Nl
         spWVSqEETTY2dJ2LUJz7/jgvHdy33n1dmdw+EojgYr23nC6zfKtA1q+kezQE3v0DYe
         8cBAfQH4M+MfA==
Date:   Thu, 24 Nov 2022 08:39:28 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: objtool warning for next-20221118
Message-ID: <20221124163928.dof5ldfer6rswlnx@treble>
References: <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
 <20221123170337.keacggyvn4ykbtsw@treble>
 <20221124023934.nft3udxelth4lvai@treble>
 <72a4871b-3ee8-42c1-912a-321a45690428@suse.com>
 <68dc479a-6b61-0012-888d-c1b4cc513cdb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68dc479a-6b61-0012-888d-c1b4cc513cdb@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:47:47AM +0100, Juergen Gross wrote:
> > > +++ b/arch/x86/xen/smp_pv.c
> > > @@ -385,17 +385,9 @@ static void xen_pv_play_dead(void) /* used only
> > > with HOTPLUG_CPU */
> > >   {
> > >       play_dead_common();
> > >       HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(smp_processor_id()), NULL);
> > > -    cpu_bringup();
> > > -    /*
> > > -     * commit 4b0c0f294 (tick: Cleanup NOHZ per cpu data on cpu down)
> > > -     * clears certain data that the cpu_idle loop (which called us
> > > -     * and that we return from) expects. The only way to get that
> > > -     * data back is to call:
> > > -     */
> > > -    tick_nohz_idle_enter();
> > > -    tick_nohz_idle_stop_tick_protected();
> > > -    cpuhp_online_idle(CPUHP_AP_ONLINE_IDLE);
> > > +    /* FIXME: converge cpu_bringup_and_idle() and start_secondary() */
> > > +    cpu_bringup_and_idle();
> > 
> > I think this will leak stack memory. Multiple cpu offline/online cycles of
> > the same cpu will finally exhaust the idle stack.

Doh!  Of course...

I was actually thinking ahead, to where eventually xen_pv_play_dead()
can call start_cpu0(), which can be changed to automatically reset the
stack pointer like this:

SYM_CODE_START(start_cpu0)
	ANNOTATE_NOENDBR
	UNWIND_HINT_EMPTY
	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
	leaq	-PTREGS_SIZE(%rax), %rsp
	jmp	.Ljump_to_C_code
SYM_CODE_END(start_cpu0)

but that would only be possible be after more cleanups which converge
cpu_bringup_and_idle() with start_secondary().

> The attached patch seems to work fine.

The patch looks good to me.

It doesn't solve Paul's original issue where arch_cpu_idle_dead() needs
to be __noreturn.  But that should probably be a separate patch anyway.

> The __noreturn annotation seems to trigger an objtool warning, though, in
> spite of the added BUG() at the end of xen_pv_play_dead():
>
> arch/x86/xen/smp_pv.o: warning: objtool: xen_pv_play_dead() falls through to
> next function xen_pv_cpu_die()

You'll need to tell objtool that xen_cpu_bringup_again() is noreturn by
adding "xen_cpu_bringup_again" to global_noreturns[] in
tools/objtool/check.c.

(Yes it's a pain, I'll be working an improved solution to the noreturn
thing...)

-- 
Josh
