Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCF6D713C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjDEAZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjDEAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:25:49 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBB3C15
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:25:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 251863200A74;
        Tue,  4 Apr 2023 20:25:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 20:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680654347; x=1680740747; bh=ocJqChMt1z19AkZ29xL82uUThwF2VFmVYjB
        YyFKJblg=; b=ckHxW7VzB2DAZXXTWL1189IT1mChZ34BgPfx62Zjxlm+RnG13Jl
        M14Vb7/h8Cx4dO2vsLHyKg81y6UIA3W6gHhbgsht4o8yisWXiIfA7a8Q1sXfqkYr
        rzgLWTXePbT2yRWi8AeSHhVZQS1AU3KSi2NdvMte7/7Uq5/QWMB+CLyFdvNJ1elZ
        UNr32JuN9zr7jj+iupS7J0FdEyw8ZS08cWw/SwtCSYdFuNHr1jEhw23pAhUrBEI0
        o/MCIsB/edQvxSuCXH/96N1s/tgCdaboPJ/BWsOttOsHz4MnViPzfYTnmiKeTDNP
        /1h9odl74Io4hF/UABoWkRYBABb6wyfDcjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680654347; x=1680740747; bh=ocJqChMt1z19A
        kZ29xL82uUThwF2VFmVYjBYyFKJblg=; b=S2opLDcEfuJpnbyquL6GjRmvEyGHh
        AuRXqLMfiiqVoBZq44jcyRN62OijDqn29S4wlqt0SmHjPx8QYPiU6H9gL/LiLcqb
        wIg9MYKREDZ/0/v5CMJKr9iarnnYRbTrBU4iaZaNiqMZ1aXsrYFMlEK25dWuGXlB
        afxCDazZ/+vUsalQ2Jez9DOdOg27s699Y5WbldgF1LHccgpYPctUXZcQRRaDD1+E
        zedU2Z2Zjd8BdVGzpqJHwNzBNvD8gYbBrnSrg1+racs45CxuWKqC5N0RTjYg2nMc
        gpishJt1aPP7GIfqfe/ZzhcFO8yRpqxZleLkKQ02251Qu7E9u0V6/K5wA==
X-ME-Sender: <xms:C8AsZBGw-EuL0TNtxRWcWsyWgGsUGj0fxI-xpRaL8SIJB0lp5P6c5Q>
    <xme:C8AsZGVZtBxMvfgbIMvSiihLWFwfRx9brJbUgztFX_aoQo5SN-7r5jzHVO1y6XYC-
    Nbf0X33Zo70OQQ4lrY>
X-ME-Received: <xmr:C8AsZDImlzdTZ_fzfQKK-kepozQfJJn7DOjXi1Uoa1GPzm8wu7QmIHOQG6lyBIb0EvxE49K1EKvNxaRy2dy7rWIsnrjlzcdtKYUYb6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejtddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhs
    hhhtrhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepudeigeehieejuedvte
    dufeevtdejfeegueefgffhkefgleefteetledvtdfftefgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvg
    htthdrohhrgh
X-ME-Proxy: <xmx:C8AsZHGbp07-3rUmYUimCYHZ6YjlfnyHAIrXxhzuFL-Mp6oNc9QbCA>
    <xmx:C8AsZHV5dJl4kzE-8VFmVpdsqlQWb8H78S2PI8O5mFEeMvQpDK0FyA>
    <xmx:C8AsZCNxeerpvwS_zgQ3UkjX_nsWniD9yL16l8p24-DYrCgCkWiO3g>
    <xmx:C8AsZIcXvMY1RtKvLXGuFZtbUUQeP2P1ucKosHn-CuhOB2S8rMnrUw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 20:25:45 -0400 (EDT)
Date:   Wed, 5 Apr 2023 09:25:43 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <ZCzABzH/tomN0pzc@localhost>
References: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
 <20230404124355.3efa7a201d2aa9896dc6353e@linux-foundation.org>
 <ZCy/vgprgeVUwCGv@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCy/vgprgeVUwCGv@localhost>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:24:36AM +0900, Josh Triplett wrote:
> On Tue, Apr 04, 2023 at 12:43:55PM -0700, Andrew Morton wrote:
> > On Tue, 4 Apr 2023 21:31:48 +0900 Josh Triplett <josh@joshtriplett.org> wrote:
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> > > @@ -2377,6 +2377,16 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
> > >  		PR_MDWE_REFUSE_EXEC_GAIN : 0;
> > >  }
> > >  
> > > +static int prctl_get_auxv(void __user *addr, unsigned long len)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);
> > > +
> > > +	if (size && copy_to_user(addr, mm->saved_auxv, size))
> > > +		return -EFAULT;
> > > +	return sizeof(mm->saved_auxv);
> > > +}
> > 
> > The type choices are unpleasing.  Maybe make `len' a size_t and make
> > the function return a size_t?  That way prctl_get_auxv() will be much
> > nicer, but the caller less so.
> 
> It'd have to be an ssize_t return to support returning -EFAULT. Also,
> sadly, size_t would still look just as bad, because
> `sizeof(mm->saved_auxv)` doesn't have type size_t (at least according to
> the error from the type-safe min macro). So this would still need a cast
> or a `min_t`.
> 
> But I'm happy to change the argument to size_t and the return value to
> ssize_t, if you'd prefer. Will send v3 with that changed.

That said, *all* the other helper functions here seem to return int...
