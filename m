Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9569ABC5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBQMoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBQMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:44:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC154D73
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yGD6KtsmluWP1FGxV4p66xLC13Sm1TnslOz2BVZo9Dc=; b=j7xZD+pRlBhpiqN/5elTdgdJ+s
        OT9/WYQgZwdHC7aJZDu/kvSU9NWYdCWRlMCQggOZrA2F7fY0SDQBYBBwnJXhf4aSNOLTE8c8Nkkcq
        ypQBMK7qyj6xU9+q9Vgho70VdoiTVgbaO0ot6ohu05y52LCXRuFX8Bk7MgsFuCY7v8KZc2n9+GwY3
        FEzqOmCg8xwP7X3QLBKwLOPriFbFbXGAYaFaciGoM0kNneyFR7YXgRYdFD5/2ZNTrWgyOKDcobFPt
        D76JtBx5CT35evkNFrF4oqRhBZuKey7+Ar/L2bRODivnRfQSA4NpVOOLbW8LKEZ5u6iMmBsHaVmuN
        kLTxGfXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pT05V-00Ae2Y-0R;
        Fri, 17 Feb 2023 12:44:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AB9130031E;
        Fri, 17 Feb 2023 13:44:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E58B9233D2D46; Fri, 17 Feb 2023 13:44:20 +0100 (CET)
Date:   Fri, 17 Feb 2023 13:44:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <Y+92pBgaH8VpYbsL@hirez.programming.kicks-ass.net>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <Y+4agrPvSUYhdaFT@hirez.programming.kicks-ass.net>
 <20230216160619.rleqhnrufcilizy2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160619.rleqhnrufcilizy2@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 08:06:19AM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 16, 2023 at 12:58:58PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 10, 2023 at 02:42:02PM -0800, Josh Poimboeuf wrote:
> > 
> > > The problem is that #BP saves the pointer to the instruction immediately
> > > *after* the INT3, rather than to the INT3 itself.  The instruction
> > > replaced by the INT3 hasn't actually run, but ORC assumes otherwise and
> > > expects the wrong stack layout.
> > > 
> > > Fix it by annotating the #BP exception as a non-signal stack frame,
> > > which tells the ORC unwinder to decrement the instruction pointer before
> > > looking up the corresponding ORC entry.
> > > 
> > > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >  arch/x86/entry/entry_64.S | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > index 15739a2c0983..8d21881adf86 100644
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -385,7 +385,14 @@ SYM_CODE_END(xen_error_entry)
> > >   */
> > >  .macro idtentry vector asmsym cfunc has_error_code:req
> > >  SYM_CODE_START(\asmsym)
> > > -	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
> > > +
> > > +	.if \vector == X86_TRAP_BP
> > > +		/* #BP advances %rip to the next instruction */
> > > +		UNWIND_HINT_IRET_REGS offset=\has_error_code*8 signal=0
> > 
> > So the fact that INT3 is trap like is not the problem, the problem is
> > that we use INT3 to overwrite stack modifying instruction and we should
> > not assume those instructions have completed when in the #BP handler.
> > 
> > Now, the reason all this actually works is because INT3 itself does not
> > modify the stack so rewinding on non-overwrite INT3 instructions is
> > invariant wrt stack state.
> 
> Right, that's what my patch description attempting to say.
> 
> That's also why I was asking about INT1, which is a trap.  Do we care
> about INT1?

We do not care about INT1, #DB is an IST and an allround pain in the
backside, INT3 is where it's at.
