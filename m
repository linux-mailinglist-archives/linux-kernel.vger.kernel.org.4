Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55867695806
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 05:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjBNEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 23:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 23:54:57 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F884B443
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 20:54:56 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5E71392009C; Tue, 14 Feb 2023 05:54:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 50C2B92009B;
        Tue, 14 Feb 2023 04:54:53 +0000 (GMT)
Date:   Tue, 14 Feb 2023 04:54:53 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PING][PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
In-Reply-To: <877cwltmno.ffs@tglx>
Message-ID: <alpine.DEB.2.21.2302140447190.6368@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk> <alpine.DEB.2.21.2302122311470.46819@angie.orcam.me.uk> <877cwltmno.ffs@tglx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Thomas Gleixner wrote:

> >> For x86 kernel stack offset randomization uses the RDTSC instruction, 
> >> which according to H. Peter Anvin is not a secure source of entropy:
> >> 
> >> "RDTSC isn't a super fast instruction either, but what is *way* more
> >> significant is that this use of RDTSC is NOT safe: in certain power states
> >> it may very well be that stone number of lower bits of TSC contain no
> >> entropy at all."
> >
> >  Ping for:
> > <https://lore.kernel.org/all/alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk/>.
> 
> I'm waiting for you to address Peter Anvins feedback.

 Do you mean this part:

On Tue, 31 Jan 2023, H. Peter Anvin wrote:

> Well, what I said was that masking out the low bits of TSC is not a valid use to
> extract a random(-ish) number this way, because the lower bits may be affected
> by quantization. Something like a circular multiply using a large prime with a
> good 0:1 balance can be used to mitigate that.
> 
> However, the second part is that subsequent RDTSCs will be highly correlated,
> and so a CSPRNG is needed if you are actually trying to get reasonable security
> this way – and, well, we already have one of those.

?  Well, I inferred, perhaps incorrectly, from the second paragraph that 
Peter agrees with my approach (with the CSPRNG being what `get_random_u8' 
and friends get at).

> You also cite him
> w/o providing a link to the conversation, so any context is missing.

 Sorry about that.  I put the change heading for the previous iterations 
in the change log, but I agree actual web links would've been better:
<https://lore.kernel.org/all/alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk/>,
<https://lore.kernel.org/all/alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk/>.

 Please let me know if you need anything else.  Thank you for your review.

  Maciej
