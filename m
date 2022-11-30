Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CDD63E0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiK3Tbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3Tbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:31:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FAF86A14
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FEF461D96
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D8C4347C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:31:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HMBhsAXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669836706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ScMaAIgcavRwlnc4K5Bo/PJrf8VIf6mrT3T2oiNawk=;
        b=HMBhsAXD/2ls5hHnyzrHsZvKaX/qCCBffiYotopqAyrtFIDFROcOxzr8Uk0ANLTiOApN2r
        5Qxb+6ZD/hKMXj4eceBkY8IYC8F3i5AhQojD9sc920IADnc3vUI9aeY8fbtLYblhWHKY9g
        AP3+6/l40UZOJ4OGTGxSwI1/43q02yw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d16cd9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 30 Nov 2022 19:31:45 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id m4so18354225vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:31:45 -0800 (PST)
X-Gm-Message-State: ANoB5pmeBIcStCwrErBDJHMUwa1kSJnSpHcV3QG3T6cRG15SLaly4V9Q
        eGGHEV8VpHwMWM6cMjMyBB0X9HdrDKxQVJlt+uQ=
X-Google-Smtp-Source: AA0mqf4wDWFsoIop7y9uDv0CAz1F0ELRaeOde/n4mSE5vseu/TD9+EtjGBC37rBf2EVkGw/nkTAEd29V2QCmSI7ezOE=
X-Received: by 2002:a05:6102:30bc:b0:3b0:93af:fc3f with SMTP id
 y28-20020a05610230bc00b003b093affc3fmr10983840vsd.55.1669836704982; Wed, 30
 Nov 2022 11:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20221130020815.283814-1-Jason@zx2c4.com> <Y4biVHVPhVyVJ6Fc@sol.localdomain>
 <Y4cqpwwbNBKhdidq@zx2c4.com> <Y4en9fSll1vSY4Bt@gmail.com>
In-Reply-To: <Y4en9fSll1vSY4Bt@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 30 Nov 2022 20:31:33 +0100
X-Gmail-Original-Message-ID: <CAHmME9p63Cpi4273OMFB=8F3+CfEfMUxZ4vV=xjWqxQ=frr34Q@mail.gmail.com>
Message-ID: <CAHmME9p63Cpi4273OMFB=8F3+CfEfMUxZ4vV=xjWqxQ=frr34Q@mail.gmail.com>
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

On Wed, Nov 30, 2022 at 7:59 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Nov 30, 2022 at 11:04:23AM +0100, Jason A. Donenfeld wrote:
> > > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > > index 67558b95d531..2494e08c76d8 100644
> > > > --- a/drivers/char/random.c
> > > > +++ b/drivers/char/random.c
> > > > @@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
> > > >  static void __cold try_to_generate_entropy(void)
> > > >  {
> > > >   enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
> > > > - struct entropy_timer_state stack;
> > > > + struct entropy_timer_state stack ____cacheline_aligned;
> > >
> > > Several years ago, there was a whole thing about how __attribute__((aligned)) to
> > > more than 8 bytes doesn't actually work on stack variables in the kernel on x86,
> > > because the kernel only keeps the stack 8-byte aligned but gcc assumes it is
> > > 16-byte aligned.  See
> > > https://lore.kernel.org/linux-crypto/20170110143340.GA3787@gondor.apana.org.au/T/#t
> > >
> > > IIRC, nothing was done about it at the time.
> > >
> > > Has that been resolved in the intervening years?
> >
> > Maybe things are different for ____cacheline_aligned, which is 64 bytes.
> > Reading that thread, it looks like it was a case of trying to align the
> > stack to 16 bytes, but gcc assumed 16 bytes already while the kernel
> > only gave it 8. So gcc didn't think it needed to emit any code to align
> > it. Here, though, it's 64, and gcc certainly isn't assuming 64-byte
> > stack alignment.
> >
> > Looking at the codegen, gcc appears to doing `rsp = (rsp & ~63) - 64`,
> > which appears correct.
>
> Well, if gcc thinks the stack is already 16-byte aligned, then it would be
> perfectly within its rights to do 'rsp = (rsp & ~47) - 64', right?  You probably
> don't want to be relying on an implementation detail of gcc codegen...

The really pathological one would be ~48, which would just clear those
two extra bits. I can't imagine gcc or clang ever deciding to do that.
But I guess they could?

What would you recommend here? kmalloc'ing it instead? Keeping things
as is with ____cacheline_aligned, since this has always been broken,
and it's not the end of the world? Something else?

Jason
