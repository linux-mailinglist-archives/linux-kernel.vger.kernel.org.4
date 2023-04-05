Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677556D713A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjDEAY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjDEAYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:24:41 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EEF4697
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:24:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CC49332009C8;
        Tue,  4 Apr 2023 20:24:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 04 Apr 2023 20:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680654275; x=1680740675; bh=Mx+3ceIjpuMWUpIMcp9gQXCLaSq9TOOpb+J
        xGIo/9cA=; b=CE85zjxhK1DPeU2JCKYp4z2uFnTO9DaVAvDgttFVg8mbxqbRxiA
        DPy5XLJAZ3/snXYkXfx78pLUrlQHqK2FnN9hGQ2ft8aCRjTLwmTxIFsTYQ0TmZzC
        92C+Qk5Q0gyP2pgORJIrY9K/EQ4sVw7IKK9KkCk4oA1tAlaAnmWIF9QHiJCTdrEY
        5d8AnZr6kxSWcewAJlEotTZKz7SL01cbdRszVPeDJESxQNhdGRU0TBC0aOEvTmN0
        RUOWk5mjx+rP7vlwrll/FRQCQTmJth7hDckNWFzLJeKuQ6eIf8c/L8yOoCRSOg0d
        45YQdchFmJNC4sIU0FKikgubaPROC0qtwuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680654275; x=1680740675; bh=Mx+3ceIjpuMWU
        pIMcp9gQXCLaSq9TOOpb+JxGIo/9cA=; b=K2usp+SXX4/YOmEgHiHEjRvy/boeX
        WrwruqLDVAG/EGZBsB2NK77LzL1xMw2X42QDYbyzsTQzv7OqLV7LnQMcL0ne6XdH
        67QrSaiGhyOizctyR5m9t0Mmhcu0BXUnBMRtbuYTgZdjpk6Pp0DLbT2NDdNS2F2b
        b8hTUOzhe6z80V4RFasnIWSuetIZLfoaHC4j2wqN51tG9ZdVdn9xbzlWAkHXp0hW
        0rHUZuUyLSF9wS82xxRAz3Lqw4yNx8f8rhvV6zQegHeCtgRZ8K/5xMb1UN+/tkh3
        /YEeGb9oYZ+mKCoeHnmrA7CVymGdHWczfzL7VC+w8fSMHgetYZXsQso2g==
X-ME-Sender: <xms:w78sZJq9u71A60idOY4QN92y9Eq3VTgWDsKldfM1n7Si7CpAmIhlRg>
    <xme:w78sZLoyNhOg6ToZVeVU65_GiQatG2RN23r0KceA_5OX9GGqRhCktNvxZYFWCek27
    LT8VC1Y1obqNWWerlk>
X-ME-Received: <xmr:w78sZGMNf-Z_KGm7r8Y1_krZ0HSyBxX8o9X9avNOcimWsCYHOC76J-yJxyjZVYdEBII5EFre61yzTc0tg5mGbpZg8jBsfklUv8CiEfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejtddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhs
    hhhtrhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepudeigeehieejuedvte
    dufeevtdejfeegueefgffhkefgleefteetledvtdfftefgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvg
    htthdrohhrgh
X-ME-Proxy: <xmx:w78sZE4RR8Cmtnt7tZzZHKnP70WeuAbwjoClz6ex_KVbpOTwJipOkA>
    <xmx:w78sZI42-ou7JgzcH57BI3-5NsPOXUVpBOo0atGpXQQAiW1N3J3ZNw>
    <xmx:w78sZMhqW1aHrnVr4TGg0lQFLkvrhCtSpwfQ7Khz4XkADoppa4jvuw>
    <xmx:w78sZNhTTTQdjZuz01Xa9P1W-xlGqTRnm1pLVNyFa1zvO5GvyRZz0g>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 20:24:33 -0400 (EDT)
Date:   Wed, 5 Apr 2023 09:24:30 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <ZCy/vgprgeVUwCGv@localhost>
References: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
 <20230404124355.3efa7a201d2aa9896dc6353e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404124355.3efa7a201d2aa9896dc6353e@linux-foundation.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:43:55PM -0700, Andrew Morton wrote:
> On Tue, 4 Apr 2023 21:31:48 +0900 Josh Triplett <josh@joshtriplett.org> wrote:
> 
> > If a library wants to get information from auxv (for instance,
> > AT_HWCAP/AT_HWCAP2), it has a few options, none of them perfectly
> > reliable or ideal:
> > 
> > - Be main or the pre-main startup code, and grub through the stack above
> >   main. Doesn't work for a library.
> > - Call libc getauxval. Not ideal for libraries that are trying to be
> >   libc-independent and/or don't otherwise require anything from other
> >   libraries.
> > - Open and read /proc/self/auxv. Doesn't work for libraries that may run
> >   in arbitrarily constrained environments that may not have /proc
> >   mounted (e.g. libraries that might be used by an init program or a
> >   container setup tool).
> > - Assume you're on the main thread and still on the original stack, and
> >   try to walk the stack upwards, hoping to find auxv. Extremely bad
> >   idea.
> > - Ask the caller to pass auxv in for you. Not ideal for a user-friendly
> >   library, and then your caller may have the same problem.
> 
> How does glibc's getauxval() do its thing?  Why can't glibc-independent
> code do the same thing?

glibc owns the pre-main startup code in programs linked to glibc, so it
can record auxv for later reference in getauxval. That isn't an option
for something that *doesn't* own the pre-main startup code.

> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -290,4 +290,6 @@ struct prctl_mm_map {
> >  #define PR_SET_VMA		0x53564d41
> >  # define PR_SET_VMA_ANON_NAME		0
> >  
> > +#define PR_GET_AUXV		0x41555856
> 
> How was this constant arrived at?

It's 'A' 'U' 'X' 'V', inspired by PR_SET_VMA above which is 'S' 'V' 'M' 'A'.

> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2377,6 +2377,16 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
> >  		PR_MDWE_REFUSE_EXEC_GAIN : 0;
> >  }
> >  
> > +static int prctl_get_auxv(void __user *addr, unsigned long len)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);
> > +
> > +	if (size && copy_to_user(addr, mm->saved_auxv, size))
> > +		return -EFAULT;
> > +	return sizeof(mm->saved_auxv);
> > +}
> 
> The type choices are unpleasing.  Maybe make `len' a size_t and make
> the function return a size_t?  That way prctl_get_auxv() will be much
> nicer, but the caller less so.

It'd have to be an ssize_t return to support returning -EFAULT. Also,
sadly, size_t would still look just as bad, because
`sizeof(mm->saved_auxv)` doesn't have type size_t (at least according to
the error from the type-safe min macro). So this would still need a cast
or a `min_t`.

But I'm happy to change the argument to size_t and the return value to
ssize_t, if you'd prefer. Will send v3 with that changed.

- Josh Triplett
