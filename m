Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3369D699976
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBPQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:06:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501BBD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:06:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AFA61EE0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3854FC4339B;
        Thu, 16 Feb 2023 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676563581;
        bh=5quNsDGcZVe0gaSifOQAJ90xer6RcOym34vO1CNtzY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnSqLLuuPWtWpAzhaDGahamMlY1azLO+kUS8f4E1DFTWl6uD9BYuLdaGV+J25RSx2
         5rRtqA2ZuaSF2z/WQzgEMaY7m50HoPWLGUpOlOBNIoeRcuSFj46V0cmWpczE2DM56E
         iWhh5ZyWyNZnHRm/0nh5PIGrBEdc3KB63fJrpghlDT+1u62dzzzOumF8DI0K3Dlhin
         07fB+Oa/8ZBUZm5YWZfukmAw5hj1ImOZKmFplKG1OP4qSmEyiQzfitFfCk8D3Hf0lX
         kRRTsiKB6JEkeyLOy5F8k4Eq0fuRFe6X5ZOf08uA3G9f0VUFlx2HFw6QLe0JUq7wuP
         WX4tlruQf06Pg==
Date:   Thu, 16 Feb 2023 08:06:19 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <20230216160619.rleqhnrufcilizy2@treble>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <Y+4agrPvSUYhdaFT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+4agrPvSUYhdaFT@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:58:58PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 10, 2023 at 02:42:02PM -0800, Josh Poimboeuf wrote:
> 
> > The problem is that #BP saves the pointer to the instruction immediately
> > *after* the INT3, rather than to the INT3 itself.  The instruction
> > replaced by the INT3 hasn't actually run, but ORC assumes otherwise and
> > expects the wrong stack layout.
> > 
> > Fix it by annotating the #BP exception as a non-signal stack frame,
> > which tells the ORC unwinder to decrement the instruction pointer before
> > looking up the corresponding ORC entry.
> > 
> > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/entry/entry_64.S | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 15739a2c0983..8d21881adf86 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -385,7 +385,14 @@ SYM_CODE_END(xen_error_entry)
> >   */
> >  .macro idtentry vector asmsym cfunc has_error_code:req
> >  SYM_CODE_START(\asmsym)
> > -	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
> > +
> > +	.if \vector == X86_TRAP_BP
> > +		/* #BP advances %rip to the next instruction */
> > +		UNWIND_HINT_IRET_REGS offset=\has_error_code*8 signal=0
> 
> So the fact that INT3 is trap like is not the problem, the problem is
> that we use INT3 to overwrite stack modifying instruction and we should
> not assume those instructions have completed when in the #BP handler.
> 
> Now, the reason all this actually works is because INT3 itself does not
> modify the stack so rewinding on non-overwrite INT3 instructions is
> invariant wrt stack state.

Right, that's what my patch description attempting to say.

That's also why I was asking about INT1, which is a trap.  Do we care
about INT1?

-- 
Josh
