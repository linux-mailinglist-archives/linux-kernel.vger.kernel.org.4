Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461F163E108
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiK3Tvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiK3Tvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3F54375
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBED0B81CCB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B34AC433C1;
        Wed, 30 Nov 2022 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669837900;
        bh=eVJxCX1hitoCz8nMnVCg3lBI8n/IRY2ZPNrxXcZYbRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7ZyAppvH1F9kqzz+cNRBVu3zAedvzQ2Te7ll8xdjpNlQvh1sC0CvwdfstuXqDLX2
         JY5AaT8mOb1Pr8iFZZ5CH6KKNCVqKSRDIjUcSTDJLIMWrKXDMGJJ830sOhH5EYpmKJ
         IANwcrJfX28nx9GgRAiLwpey/TcLqFw+XvpHdT6zZs8HPA6P/KUKdEtQljOnbNJQ14
         c6ZNqqq89SQHPLmELsPg6R8LIe7T4UyAx7QM1USw1gl9IMBSuWph4pLHV9fOY754ch
         rtXKopiA3Q7bJNZ0dCJCYltJYhHWKNGpaWY7pDQnGsn3PuYEi4HB3McX8dKRGVR8Xy
         6R7Vwf5Wy5+RQ==
Date:   Wed, 30 Nov 2022 19:51:39 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: align entropy_timer_state to cache line
Message-ID: <Y4e0SwkUYANw1at7@gmail.com>
References: <20221130020815.283814-1-Jason@zx2c4.com>
 <Y4biVHVPhVyVJ6Fc@sol.localdomain>
 <Y4cqpwwbNBKhdidq@zx2c4.com>
 <Y4en9fSll1vSY4Bt@gmail.com>
 <CAHmME9p63Cpi4273OMFB=8F3+CfEfMUxZ4vV=xjWqxQ=frr34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p63Cpi4273OMFB=8F3+CfEfMUxZ4vV=xjWqxQ=frr34Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 08:31:33PM +0100, Jason A. Donenfeld wrote:
> On Wed, Nov 30, 2022 at 7:59 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Nov 30, 2022 at 11:04:23AM +0100, Jason A. Donenfeld wrote:
> > > > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > > > index 67558b95d531..2494e08c76d8 100644
> > > > > --- a/drivers/char/random.c
> > > > > +++ b/drivers/char/random.c
> > > > > @@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
> > > > >  static void __cold try_to_generate_entropy(void)
> > > > >  {
> > > > >   enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
> > > > > - struct entropy_timer_state stack;
> > > > > + struct entropy_timer_state stack ____cacheline_aligned;
> > > >
> > > > Several years ago, there was a whole thing about how __attribute__((aligned)) to
> > > > more than 8 bytes doesn't actually work on stack variables in the kernel on x86,
> > > > because the kernel only keeps the stack 8-byte aligned but gcc assumes it is
> > > > 16-byte aligned.  See
> > > > https://lore.kernel.org/linux-crypto/20170110143340.GA3787@gondor.apana.org.au/T/#t
> > > >
> > > > IIRC, nothing was done about it at the time.
> > > >
> > > > Has that been resolved in the intervening years?
> > >
> > > Maybe things are different for ____cacheline_aligned, which is 64 bytes.
> > > Reading that thread, it looks like it was a case of trying to align the
> > > stack to 16 bytes, but gcc assumed 16 bytes already while the kernel
> > > only gave it 8. So gcc didn't think it needed to emit any code to align
> > > it. Here, though, it's 64, and gcc certainly isn't assuming 64-byte
> > > stack alignment.
> > >
> > > Looking at the codegen, gcc appears to doing `rsp = (rsp & ~63) - 64`,
> > > which appears correct.
> >
> > Well, if gcc thinks the stack is already 16-byte aligned, then it would be
> > perfectly within its rights to do 'rsp = (rsp & ~47) - 64', right?  You probably
> > don't want to be relying on an implementation detail of gcc codegen...
> 
> The really pathological one would be ~48, which would just clear those
> two extra bits. I can't imagine gcc or clang ever deciding to do that.
> But I guess they could?
> 
> What would you recommend here? kmalloc'ing it instead? Keeping things
> as is with ____cacheline_aligned, since this has always been broken,
> and it's not the end of the world? Something else?

Well, other places in the kernel do the alignment manually:

	u8 __stack[sizeof(struct entropy_timer_state) + SMP_CACHE_BYTES - 1];
	struct entropy_timer_state *stack = (void *)PTR_ALIGN(__stack, SMP_CACHE_BYTES);

It's silly, but I'm not aware of a better option.

- Eric
