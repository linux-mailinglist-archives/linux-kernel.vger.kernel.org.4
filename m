Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA163E10D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK3TzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiK3TzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:55:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D556D57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:55:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D6961D9F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39C9C433B5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:55:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Iy5f+r9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669838106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cui/LxsuZ7z7QlTGbYIAupfZbeo4PSFTUr9t5PrYIgI=;
        b=Iy5f+r9q97nmSCtEDuROrXHsNda3ocZILQdzOvzCtjPswpW/1XuOq179w1ekHyMZWvnEmT
        rIGFuUG4YF91e+dSa4P4HeGQz02dXLNcidyoUDKuy35COWq0q6yKnRV3kJdhJyfPxXiwTD
        n1jXo5he+4/qWIYFw1H33HlKcMsdzvI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 23fdb4be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 30 Nov 2022 19:55:06 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id n9so3286748uao.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:55:06 -0800 (PST)
X-Gm-Message-State: ANoB5pkNCd8PBGlZaizpp9F098xf2ERplC3A6bTe9F08W6nxMx3UDuDK
        q0/7IoftOwG0TBQ9hyYC1mScpk1/LrcyDirTDeI=
X-Google-Smtp-Source: AA0mqf7CMcb83uu1r7TvxtFGSKmu1kZOpZP/leeCGZP3+UZ5bbPkdfEvVKJ0096hOb82H+x3D7HB7+zYMTxXgqeCS9I=
X-Received: by 2002:ab0:7243:0:b0:3ad:4f5c:66ad with SMTP id
 d3-20020ab07243000000b003ad4f5c66admr36645092uap.65.1669838105535; Wed, 30
 Nov 2022 11:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20221130020815.283814-1-Jason@zx2c4.com> <Y4biVHVPhVyVJ6Fc@sol.localdomain>
 <Y4cqpwwbNBKhdidq@zx2c4.com> <Y4en9fSll1vSY4Bt@gmail.com> <CAHmME9p63Cpi4273OMFB=8F3+CfEfMUxZ4vV=xjWqxQ=frr34Q@mail.gmail.com>
 <Y4e0SwkUYANw1at7@gmail.com>
In-Reply-To: <Y4e0SwkUYANw1at7@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 30 Nov 2022 20:54:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9rFNXpCrmoQ7Uk1T3ykVj2-ap_TCerDMSjLMyADh3XJAA@mail.gmail.com>
Message-ID: <CAHmME9rFNXpCrmoQ7Uk1T3ykVj2-ap_TCerDMSjLMyADh3XJAA@mail.gmail.com>
Subject: Re: [PATCH] random: align entropy_timer_state to cache line
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Nov 30, 2022 at 8:51 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Nov 30, 2022 at 08:31:33PM +0100, Jason A. Donenfeld wrote:
> > On Wed, Nov 30, 2022 at 7:59 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Wed, Nov 30, 2022 at 11:04:23AM +0100, Jason A. Donenfeld wrote:
> > > > > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > > > > index 67558b95d531..2494e08c76d8 100644
> > > > > > --- a/drivers/char/random.c
> > > > > > +++ b/drivers/char/random.c
> > > > > > @@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
> > > > > >  static void __cold try_to_generate_entropy(void)
> > > > > >  {
> > > > > >   enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
> > > > > > - struct entropy_timer_state stack;
> > > > > > + struct entropy_timer_state stack ____cacheline_aligned;
> > > > >
> > > > > Several years ago, there was a whole thing about how __attribute__((aligned)) to
> > > > > more than 8 bytes doesn't actually work on stack variables in the kernel on x86,
> > > > > because the kernel only keeps the stack 8-byte aligned but gcc assumes it is
> > > > > 16-byte aligned.  See
> > > > > https://lore.kernel.org/linux-crypto/20170110143340.GA3787@gondor.apana.org.au/T/#t
> > > > >
> > > > > IIRC, nothing was done about it at the time.
> > > > >
> > > > > Has that been resolved in the intervening years?
> > > >
> > > > Maybe things are different for ____cacheline_aligned, which is 64 bytes.
> > > > Reading that thread, it looks like it was a case of trying to align the
> > > > stack to 16 bytes, but gcc assumed 16 bytes already while the kernel
> > > > only gave it 8. So gcc didn't think it needed to emit any code to align
> > > > it. Here, though, it's 64, and gcc certainly isn't assuming 64-byte
> > > > stack alignment.
> > > >
> > > > Looking at the codegen, gcc appears to doing `rsp = (rsp & ~63) - 64`,
> > > > which appears correct.
> > >
> > > Well, if gcc thinks the stack is already 16-byte aligned, then it would be
> > > perfectly within its rights to do 'rsp = (rsp & ~47) - 64', right?  You probably
> > > don't want to be relying on an implementation detail of gcc codegen...
> >
> > The really pathological one would be ~48, which would just clear those
> > two extra bits. I can't imagine gcc or clang ever deciding to do that.
> > But I guess they could?
> >
> > What would you recommend here? kmalloc'ing it instead? Keeping things
> > as is with ____cacheline_aligned, since this has always been broken,
> > and it's not the end of the world? Something else?
>
> Well, other places in the kernel do the alignment manually:
>
>         u8 __stack[sizeof(struct entropy_timer_state) + SMP_CACHE_BYTES - 1];
>         struct entropy_timer_state *stack = (void *)PTR_ALIGN(__stack, SMP_CACHE_BYTES);
>
> It's silly, but I'm not aware of a better option.

Well alright then, why not. I'll send a v2.

Jason
