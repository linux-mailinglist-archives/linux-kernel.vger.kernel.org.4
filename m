Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBD63E064
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiK3S7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiK3S7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:59:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BF54446
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:59:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43EC261D41
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCF1C433C1;
        Wed, 30 Nov 2022 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669834742;
        bh=3TD1S3j9pGxF2WpgRYYO4Ir4fNQvcwgiHdn38dgmJmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBKlEJWVE64uTEoiocu6EdVYn+nHHv5GLr/eSq1E0BoTx2zhNrMxlde8mWA4/CEE9
         tSkXF4g6jdhw3GJh2aEwaTzQzTlQBVZkZb9WPeubQ44OxfQYDsgQG6AdvfKxAD4/Ay
         t5g1gME4rzxlwwXNpg9eUkgiSNExMfgLL0zpdsAp1WhwkQxNM0GJ7b2mQB1HeOiQiB
         qe5lmQ189cKLjBmn0uHie/PziNW8xfQ5zgMfKVaCmOsbxUrR/xLJqH9QmfJifCkqF8
         eSATxDTOTsS0+8/Nyf7VyIspTP2LL0WF95CXRoWvoc1Oyq1amPo/X1cLDcMI7GWaKx
         q26s2gbTrTxUA==
Date:   Wed, 30 Nov 2022 18:59:01 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: align entropy_timer_state to cache line
Message-ID: <Y4en9fSll1vSY4Bt@gmail.com>
References: <20221130020815.283814-1-Jason@zx2c4.com>
 <Y4biVHVPhVyVJ6Fc@sol.localdomain>
 <Y4cqpwwbNBKhdidq@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4cqpwwbNBKhdidq@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:04:23AM +0100, Jason A. Donenfeld wrote:
> > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > index 67558b95d531..2494e08c76d8 100644
> > > --- a/drivers/char/random.c
> > > +++ b/drivers/char/random.c
> > > @@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
> > >  static void __cold try_to_generate_entropy(void)
> > >  {
> > >  	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
> > > -	struct entropy_timer_state stack;
> > > +	struct entropy_timer_state stack ____cacheline_aligned;
> > 
> > Several years ago, there was a whole thing about how __attribute__((aligned)) to
> > more than 8 bytes doesn't actually work on stack variables in the kernel on x86,
> > because the kernel only keeps the stack 8-byte aligned but gcc assumes it is
> > 16-byte aligned.  See
> > https://lore.kernel.org/linux-crypto/20170110143340.GA3787@gondor.apana.org.au/T/#t
> > 
> > IIRC, nothing was done about it at the time.
> > 
> > Has that been resolved in the intervening years?
> 
> Maybe things are different for ____cacheline_aligned, which is 64 bytes.
> Reading that thread, it looks like it was a case of trying to align the
> stack to 16 bytes, but gcc assumed 16 bytes already while the kernel
> only gave it 8. So gcc didn't think it needed to emit any code to align
> it. Here, though, it's 64, and gcc certainly isn't assuming 64-byte
> stack alignment.
> 
> Looking at the codegen, gcc appears to doing `rsp = (rsp & ~63) - 64`,
> which appears correct.

Well, if gcc thinks the stack is already 16-byte aligned, then it would be
perfectly within its rights to do 'rsp = (rsp & ~47) - 64', right?  You probably
don't want to be relying on an implementation detail of gcc codegen...

- Eric
