Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394B06F236B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjD2Grz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjD2Grx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 02:47:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB22691
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:47:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94eee951c70so97522066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682750870; x=1685342870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MGoIrx5I92tfleJ2HR27INRzqM7E79/a8JDCJVDvYY=;
        b=ovsBT7/IZbSVH/DuO+TwRN/ywo0ywsemZ7Th+rjEdKlmR57vDK2obt4hMcqMblcQY8
         JIWDx5WufPma5WNyBg4niWelbMJG7XTxvU40biIRzNPabfPlYw3k1JDEsvLil3bvYTlw
         Lzs3TNx5bAn3xykbwwy231Xj8UKh9uZQLcYGujR3PJrJ3a8TMvNB+BqyPPGxjCAQj9Rp
         7Qrv/Ar3nO91So9i/xZtGu836nYCdDkwTD8vIi4TMH7NEMRXgM79gd+nIDobwUClRMiN
         mDZkObZ1SwnY5u1Hjvptes4OG/G3omSeBD2kTcYLDb0lKK5vgSU8riDFpYdtDWzJCKIv
         BIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682750870; x=1685342870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MGoIrx5I92tfleJ2HR27INRzqM7E79/a8JDCJVDvYY=;
        b=Cqsp6LPcssbcq2DLsaY3OSdI5Lg/h0RMGcfaW/dNNZKleWsxUeMLjc1rEirZsxsUhd
         /qQBC6hxzS2hYjeYtu7Z1nLylo0L5pESOmppH4m6mGkG3XmzRbL2FItHGt1HzXQW/3to
         zTf/9CK2kzcqRWsCkPNHk7gJRW3xo+E/8mgmTlNUAYpzi1VrRRsyEfc1nwHgJN8MITPB
         wBIaDweS4V4Vt9RYQ8Z461Obwkh45njI8TCrnb1sauqTFW6FIYrH5cez4YOv2NjOYFct
         idkC6gYBxSnSOxcdfz9unLwgezEsgmrcEbqKFm2bkSuTDY8gPb89ZW0V5QX2/yyjH6Cb
         ysYw==
X-Gm-Message-State: AC+VfDzSct6EVRDwweC2OnVKwcZUtI1ufZKUTB52BxVjQIEXPPtj1xn0
        ciY2XhHCogpbT9rBueFKeh1YrkiAjug=
X-Google-Smtp-Source: ACHHUZ5WZf6AkuQAH8ASNEEdBqdI4XlcFCdofFcqZH7hpPf1ih9QJrvdnSf6dMwchYUw1lN7AvYfaQ==
X-Received: by 2002:a17:907:9807:b0:94f:7c4e:24ea with SMTP id ji7-20020a170907980700b0094f7c4e24eamr7764502ejc.38.1682750870112;
        Fri, 28 Apr 2023 23:47:50 -0700 (PDT)
Received: from gmail.com (1F2EF38A.nat.pool.telekom.hu. [31.46.243.138])
        by smtp.gmail.com with ESMTPSA id u10-20020a056402064a00b00506addaaab0sm9973804edx.32.2023.04.28.23.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 23:47:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 29 Apr 2023 08:47:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v6.4
Message-ID: <ZEy9kUpwx/N3JEA/@gmail.com>
References: <Y/NmzouehvMWTPVZ@gmail.com>
 <ZErTyKxjGQvF6EqP@gmail.com>
 <CAHk-=wiDTLgf8LhigR4XKnjgkuhsoS-pXZckXU79J-EXiOj7Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiDTLgf8LhigR4XKnjgkuhsoS-pXZckXU79J-EXiOj7Vw@mail.gmail.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Apr 27, 2023 at 12:58 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - Add non-atomic __xchg() variant, use it in a couple of places
> 
> Guys, this is insane, and completely unacceptable.
> 
> I pulled this, but I'm going to unpull it, because the code is
> actively wrong and ugly.
> 
> It not only randomly decides to re-use a name that has existing users
> that now need to be fixed up.

meh - you are 100% right, I'm not sure what we were thinking there ... [ 
actually, I know what we were thinking, but it's a bit complicated - see 
the various non-perfect nomenclature options further below. ]

So the first line of our thinking was that "__" also often & additionally 
means 'lighter weight version of a similar API signature, beware, here be 
dragons, use at your own risk', and more of the focus of these particular 
changes was on identifying hand-coded xchg-ish pieces of code, such as in:

   26ace5d28d36 ("arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr")

... but while that background of '__' is somewhat valid logic that we use 
quite often in various kernel facilities, it doesn't really excuse the 
sloppy decision to slap __ in front of an existing API without trying 
harder, *especially* that a better name with fetch_and_zero() already 
existed :-/

> It then *also* decides to start "preferring" this absolutely
> disgusting new name over a much more legible one in the i915 driver,
> which had this same functionality except it used a prettier name:
> 
>    fetch_and_zero()
> 
> But what then takes the cake for me is that this horribly ugly feature
> then didn't even get that right, and only randomly converted *some* of
> the users, with most of them remaining:
> 
>   git grep fetch_and_zero drivers/gpu/drm/i915/ | wc
>      58     187    5534
>   git grep -w __xchg drivers/gpu/drm/i915/ | wc
>      22     109    1899
> 
> and it looks like the only "logic" to this is that the converted ones
> were in the "gt/" subdirectory. What a random choice, but happily it
> caused a trivial conflict, and as a result I noticed how bad things
> were.
> 
> Anyway, I really find this all offensively ugly and pointless. I'm not
> going to pull some "fixed" version of this. This needs to go away and
> never come back.

Yeah. So I've rebased locking/core to take out these changes - a simple 
revert is too ugly and the history has no value here really.

Will re-send the rest of locking/core.

> What was so magically great about the name "__xchg" that it needed to be 
> taken over by this function? And why was that legibly named version of it 
> replaced so randomly?

Yeah.

So fetch_and_zero() has a bit of a nomenclature & ambiguity problem as 
well: there's already an atomic_fetch_*() API family, and it's easy to 
think that fetch_and_zero() is atomic too - a bit like how xchg() is atomic 
without mentioning 'atomic'.

Adding to the confusion is that there's already atomic APIs that don't use 
atomic_t:

  xchg()
  cmpxchg()
  try_cmpxchg()

... and by *that* implicit nomenclature logic, dropping the atomic_ from a 
atomic_fetch_and_zero() API means: 'atomic API, not using atomic_t'. Which 
fetch_and_zero() clearly isnt ...

So by all that logic and somewhat idiosynchratic API history, the new 
facility should probably not be fetch_and_zero(), but something like 
nonatomic_fetch_and_zero(), but that's quite a mouthful for something so 
simple - and the API family connection to xchg() is lost as well, which is 
a bit sad...

In all that context the least bad approach sounded to add a __ to denote 
__xchg() is 'something special and also lighter weight' (which it is).

I *think* the bigger danger in locking nomenclature is to falsely imply 
atomicity - in that sense I'm not sure fetch_and_zero() is ideal - but I 
can certainly live with it b/c the perfect name keeps eluding me.

> The *whole* point of two underscores is to say "don't use this - it's
> an internal implementation". That's the historical meaning, and it's
> the meaning we have in the kernel too. Two underscores means "this is
> special and doesn't do everything required" (it might need locking
> around it, for example).

Yeah. I do think we might want to keep one related change though:

  e27cff3d2d43 ("arch: rename all internal names __xchg to __arch_xchg")

... not because we want to use the __xchg namespace, but because an _arch 
prefix makes it even *less* likely to be used by non-infrastructure code.

> So then making a new interface with two underscores and thinking "we 
> should now make random drivers use this" is fundamentally bogus.
> 
> Look, just grep for "__xchg" in the main tree (ie the one *without* this 
> change). It all makes sense. It's all clearly an internal helper - as 
> marked by that double underscore - and it's not used by any driver or 
> filesystem code.
> 
> Exactly like K&R and God intended.

Yeah. We'll try this new facility again in v6.5, but with a better name. 
Sorry about that!

Thanks,

	Ingo
