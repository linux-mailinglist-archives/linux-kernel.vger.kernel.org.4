Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2465AA7A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjAAPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAAPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:53:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E14F7C;
        Sun,  1 Jan 2023 07:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C27160DDD;
        Sun,  1 Jan 2023 15:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C939C433D2;
        Sun,  1 Jan 2023 15:53:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q1YDlcfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672588406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7UU0k0+xf0ESl7F6PUtPt9RVh2TOoL9Y1ZzrlTOJWs=;
        b=Q1YDlcfGuFuaizpFcR+VS2iOzsWuc2XGQ76b6FNCb2ve/qXwRXskQpzX6fe4dIo2VSXGvd
        AdPTIU8dkipKeO4rB7O0ciD4YfWuRcp+GKIEgSeayokyTiP+/QQIQDuMuA7o8csFfoQsbY
        qSSJWB4ppa4BwJ+XjwIaflxTe1okobo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7183c114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 1 Jan 2023 15:53:26 +0000 (UTC)
Date:   Sun, 1 Jan 2023 16:53:22 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v13 6/7] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y7GschU1qZPFZAhm@zx2c4.com>
References: <20221221142327.126451-1-Jason@zx2c4.com>
 <20221221142327.126451-7-Jason@zx2c4.com>
 <Y6OHa196S8e1mImg@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6OHa196S8e1mImg@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:23:39PM -0800, Eric Biggers wrote:
> On Wed, Dec 21, 2022 at 03:23:26PM +0100, Jason A. Donenfeld wrote:
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 6425f5f838e0..660cd15b6228 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -60,6 +60,7 @@
> >  #include <crypto/blake2s.h>
> >  #ifdef CONFIG_VDSO_GETRANDOM
> >  #include <vdso/getrandom.h>
> > +#include <vdso/datapage.h>
> >  #endif
> >  #include <asm/archrandom.h>
> >  #include <asm/processor.h>
> > @@ -407,6 +408,9 @@ static void crng_reseed(struct work_struct *work)
> >	/*
> >	 * We copy the new key into the base_crng, overwriting the old one,
> >	 * and update the generation counter. We avoid hitting ULONG_MAX,
> >	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
> >	 * forces new CPUs that come online to always initialize.
> >	 */
> >	spin_lock_irqsave(&base_crng.lock, flags);
> >	memcpy(base_crng.key, key, sizeof(base_crng.key));
> >	next_gen = base_crng.generation + 1;
> >  	if (next_gen == ULONG_MAX)
> >  		++next_gen;
> >  	WRITE_ONCE(base_crng.generation, next_gen);
> > +#ifdef CONFIG_VDSO_GETRANDOM
> > +	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> > +#endif
> 
> It's confusing that "uninitialized generation" is ULONG_MAX in the per-cpu
> crngs, but 0 in the vdso_rng_data.  That results in a weird off-by one thing,
> where the vdso_rng_data generation number has to be 1 higher.
> 
> Would it be possible to use 0 for both?

It might be, but this will involve some changes to how the batching
works too, so I think I'd like to do that separately, if at all.
However, I'll add a comment there noting what's happening so it's a bit
less confusing.

Jason
