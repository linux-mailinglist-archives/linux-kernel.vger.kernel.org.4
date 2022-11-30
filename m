Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473C63D2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiK3KEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiK3KEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:04:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401432FC3D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:04:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBBE6B81A9D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7C8C433C1;
        Wed, 30 Nov 2022 10:04:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cGo625hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669802667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAH9LAXx8wngIDYY+/Q9ACjtDSk3XyMnbXxPfMmFhXQ=;
        b=cGo625hbzRrEgSKA8cY+MyaYl/BjZfNXI1dKuMujRdFyt/bJzTy9RsXOfNgeWwUcgkQRFd
        8v0yHrrHXt81XJdnkXZIQ+g00bfdxbbT8rEHDbyvLsknYjKr5IuxIEi+pcg6ioQXGtVMkI
        BKkuNVZJkH+YxTsp+fQjEwtH5L9F1Wc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id efd0addb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 10:04:26 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:04:23 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: align entropy_timer_state to cache line
Message-ID: <Y4cqpwwbNBKhdidq@zx2c4.com>
References: <20221130020815.283814-1-Jason@zx2c4.com>
 <Y4biVHVPhVyVJ6Fc@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4biVHVPhVyVJ6Fc@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Nov 29, 2022 at 08:55:48PM -0800, Eric Biggers wrote:
> Hi Jason,
> 
> On Wed, Nov 30, 2022 at 03:08:15AM +0100, Jason A. Donenfeld wrote:
> > The theory behind the jitter dance is that multiple things are poking at
> > the same cache line. This only works, however, if those things are
> > actually all in the same cache line. Ensure this is the case by aligning
> > the struct on the stack to the cache line size.
> > 
> > On x86, this indeed aligns the stack struct:
> > 
> >  000000000000000c <try_to_generate_entropy>:
> >  {
> >     c:  55                      push   %rbp
> > -   d:  53                      push   %rbx
> > -   e:  48 83 ec 38             sub    $0x38,%rsp
> > +   d:  48 89 e5                mov    %rsp,%rbp
> > +  10:  41 54                   push   %r12
> > +  12:  53                      push   %rbx
> > +  13:  48 83 e4 c0             and    $0xffffffffffffffc0,%rsp
> > +  17:  48 83 ec 40             sub    $0x40,%rsp
> > 
> > Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> > Fixes: 50ee7529ec45 ("random: try to actively add entropy rather than passively wait for it")
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/char/random.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 67558b95d531..2494e08c76d8 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
> >  static void __cold try_to_generate_entropy(void)
> >  {
> >  	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
> > -	struct entropy_timer_state stack;
> > +	struct entropy_timer_state stack ____cacheline_aligned;
> 
> Several years ago, there was a whole thing about how __attribute__((aligned)) to
> more than 8 bytes doesn't actually work on stack variables in the kernel on x86,
> because the kernel only keeps the stack 8-byte aligned but gcc assumes it is
> 16-byte aligned.  See
> https://lore.kernel.org/linux-crypto/20170110143340.GA3787@gondor.apana.org.au/T/#t
> 
> IIRC, nothing was done about it at the time.
> 
> Has that been resolved in the intervening years?

Maybe things are different for ____cacheline_aligned, which is 64 bytes.
Reading that thread, it looks like it was a case of trying to align the
stack to 16 bytes, but gcc assumed 16 bytes already while the kernel
only gave it 8. So gcc didn't think it needed to emit any code to align
it. Here, though, it's 64, and gcc certainly isn't assuming 64-byte
stack alignment.

Looking at the codegen, gcc appears to doing `rsp = (rsp & ~63) - 64`,
which appears correct.

Jason
