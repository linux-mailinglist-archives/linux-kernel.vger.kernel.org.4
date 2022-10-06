Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3795F65AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJFMEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJFMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20149DFB0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 309EEB81FC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88665C433C1;
        Thu,  6 Oct 2022 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665057814;
        bh=a8/cEVaLUOgGQJ3COrAs5k+ZjXA5Lp0LYvYgEbdpL1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVCBmKrs/1cuMquu+VNDu0QXjZUaZRCueZbOeRX4vOKOp68VD1WAfItjGPaNE17WJ
         sG2qBeuau1r3SAptALzHOPJH3GVq70kEORriYIiQKzJdCArS+HaOPFgTu1VOiiY2MW
         KCP6YC4EQkoBQwjwbJJbt2rW+AwFKzH1jMNDupN/XtWIQ8EM6HXoz1E1HMCKl8l3Vw
         O40qWgyrDhwvLPNsN2Gsajl5t6v5UQs5gHtu9HMbx/IlnKZNVQJByxUPAEagTfc8o9
         20nzvkonLvM9SUV8M3trh2v5LHehVL6/f0EDolqZ4TPRQj5kRqcAcHszL7s7f6iR9v
         TfRHB5o0FHd5g==
Date:   Thu, 6 Oct 2022 19:53:59 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: jump_label: mark arguments as const to
 satisfy asm constraints
Message-ID: <Yz7B1991xDY9ZtfL@xhacker>
References: <20221006075542.2658-1-jszhang@kernel.org>
 <20221006075542.2658-2-jszhang@kernel.org>
 <Yz6qksBFFj9Wo9M8@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz6qksBFFj9Wo9M8@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:14:42AM +0100, Mark Rutland wrote:
> On Thu, Oct 06, 2022 at 03:55:41PM +0800, Jisheng Zhang wrote:
> > Inspired by x86 commit 864b435514b2("x86/jump_label: Mark arguments as
> > const to satisfy asm constraints"), mark arch_static_branch()'s and
> > arch_static_branch_jump()'s arguments as const to satisfy asm
> > constraints. And Steven in [1] also pointed out that "The "i"
> > constraint needs to be a constant."
> 
> It needs to be a *compile-time constant*, but `const` on a function argument
> only ensures that the function can't modify the argument, not that it's a

compile-time constant is a subset of `const`.

> constant in the caller.
> 
> I think this is a quirk of the optimizer rather than anything else.

I dunno compiler internals, just tried as commit 864b435514b2 suggested
the issue did disappear. 

PS: I agree with you about this is a quirk or workaround.

> 
> > Tested with building a simple external kernel module with "O0".
> 
> Is building with `-O0` supported? I thought we required using `-O2` or above
> for a bunch of code that requires constant propagation, etc.

Per the information of Jason's reply in [1]: the reason tring O0/O1 is "to
play around with GCC's new static analyzer options".

While the reason I constify the arguments is that: in riscv world, even the
"-Os" can also reproduce the warnings and errors[2]. Grepping source found
arm64 also shares the same style, so these two patches.

[2]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/

> 
> I don't really have a problem with making this const, but I don't particularly
> want to try to "fix" all the other code that depends on constant propagation to
> assemble, and I'm worried this is the canary in the coal mine.

IMHO, it's a good idea to constify if the arguments can't be modified.

> 
> Thanks,
> Mark.
> 
> > 
> > [1]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/arm64/include/asm/jump_label.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > index cea441b6aa5d..48ddc0f45d22 100644
> > --- a/arch/arm64/include/asm/jump_label.h
> > +++ b/arch/arm64/include/asm/jump_label.h
> > @@ -15,8 +15,8 @@
> >  
> >  #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
> >  
> > -static __always_inline bool arch_static_branch(struct static_key *key,
> > -					       bool branch)
> > +static __always_inline bool arch_static_branch(struct static_key * const key,
> > +					       const bool branch)
> >  {
> >  	asm_volatile_goto(
> >  		"1:	nop					\n\t"
> > @@ -32,8 +32,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
> >  	return true;
> >  }
> >  
> > -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> > -						    bool branch)
> > +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> > +						    const bool branch)
> >  {
> >  	asm_volatile_goto(
> >  		"1:	b		%l[l_yes]		\n\t"
> > -- 
> > 2.37.2
> > 
