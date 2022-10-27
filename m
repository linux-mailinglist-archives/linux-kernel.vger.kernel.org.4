Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A860F86C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiJ0NGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiJ0NGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:06:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E784B7F58
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:06:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D93323A;
        Thu, 27 Oct 2022 06:06:48 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.4.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D58E3F7B4;
        Thu, 27 Oct 2022 06:06:39 -0700 (PDT)
Date:   Thu, 27 Oct 2022 14:06:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y1qCUYeiQ9Vwm5Md@FVFF77S0Q05N>
References: <20221027112741.1678057-1-ardb@kernel.org>
 <Y1p1oKCE+paB8JUK@FVFF77S0Q05N>
 <Y1p8LjXoAjPkWdL+@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1p8LjXoAjPkWdL+@zx2c4.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

I think my wording below might have been unclear -- I was not arguing to punt
on this patch. I've tried to clarify that below. Tone is always hard in text...

On Thu, Oct 27, 2022 at 02:40:14PM +0200, Jason A. Donenfeld wrote:
> On Thu, Oct 27, 2022 at 01:12:16PM +0100, Mark Rutland wrote:
> > I appreciate this is a simple way to rule out issues of that sort, but I think
> > the "may" in that sentence is doing a lot of work, since:
> > 
> > * IIUC, we don't have a specific case in mind that we're concerned about. I can
> >   believe that we think all the crypto code we intend to be constant time is
> >   theoretically affected.
> > 
> > * IIUC we haven't gone an audited all constant-time code to check it doesn't
> >   happen to use instructions with data-dependent-timing. So there might be more
> >   work to do atop this to ensure theoretical correctness.
> > 
> > * AFAIK there are no contemporary implementations where the DIT is both
> >   implemented and it being clear results in data-dependent-timing. i.e. we have
> >   nothing to actually test on.
> >  
> > I have a slight fear that (as above) if there are future CPUs which do consider
> > DIT, there's presumably a noticeable performance difference (or the CPU would
> > just provide data-independent-timing regardless), but I'm not sure if that's
> > just something we have to live with or could punt on until we notice such
> > cases.
> 
> You're heading on a road to disaster reasoning like that.
> 
> You wrote, "we don't have a specific case in mind that we're concerned
> about", but actually, all you can say here is that you're not personally
> aware of a specific case in mind to be concerned about. As somebody who
> actually works on this code, I do have specific cases I'm worried about,
> and I know there are certain assumptions I've made about various coding
> patterns being CT, resulting in various instructions that I assume to be
> CT, which is something I tend to check by hand, while others have entire
> frameworks to automatically verify this kind of thing. In other words,
> one man's theory is another man's practice.

What I'm trying to say here is that as-written the "may result in a side
channel" wording is sufficiently vague that it can easily be read both more
strongly and wore weakly than may have been intended (and can easily be
editotorialised to "there's a new side-channel bug" style reporting that isn't
helpful). Hence I'm calling that out explicitly for the benefit of others.

If we say something like "in the absence of DIT we can't ensure that
instructions sequences have data independent timing, and so where this matters
there could in theory be a side channel", or something like that, I'd be
happier.

As you say, people have different levels of riguour here, and (unfortunately)
there's plenty of extant code with informal assumptions that are hard to reason
about. If you have a specific example to contribute to the commit messge, that
would be great.

> Then you write that there aren't any contemporary instructions where
> this matters, but you fear they could come up in the future. Okay, good,
> that's a perspective we can both share. The logical thing to do about
> that would be Ard's patch here. However, you then conclude something
> vague about performance and suggest punting this down the road. 

Sorry, I think my wording was unclear here: I meant punting on the performance
concern (i.e. take Ard's patch now, and if we see a performance issue in
future, address it then). I think we're actually agreed on that?

My reason for noting the performance concern was to lampshade that for anyone
aware of any extant / in-progress implementations, both to get them to tell
their HW folk that they might not get the practical gains they expect, and
since if those do exist we could consider following up with mechanisms to
opt-out of data-independent-timing where we are both satisifed that doing so is
safe and where there's a noticeable performance impact.

> I guess this makes sense to you because you don't think timing attacks are
> real anyway. You're entitled to your opinion, of course, but I don't think
> it's a popular one, and it certainly is contrary to that of most implementers
> of the concerned code.

That is not at all what I was trying to say here, but I can see how it's
possible to read that, so apologies for not being clear.

I am well aware that timing attacks are real, having specnt quite a while on
spectre its acquaintances, and having argued for stronger architectural
guarantees / better mechanisms to deal with this sort of thing.

> On the contrary, we should be proactive in ensuring the kernel remains
> a suitable environment for CT code, preventing the problem *before* it
> happens, 

I agree. I'm just trying to make sure that we're clear that we're doing that
and this isn't a fix for an extant seurity bug which is actively exploitable
today.

> rather than having to deal with vulnerability response down the road,
> "punt[ing]" it, as you said. And perhaps if we handle this now, CPU designers
> also won't feel like they can get away with silly performance gains at the
> cost of CT instructions.

Sure.

Thanks,
Mark.
