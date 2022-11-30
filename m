Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11D63CD05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiK3Btm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3Btk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:49:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE56C729;
        Tue, 29 Nov 2022 17:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 647D161991;
        Wed, 30 Nov 2022 01:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F41C433C1;
        Wed, 30 Nov 2022 01:49:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eOO5ZNUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669772977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIRgI6kciaHBf4ZlMFOBJL8gb12Fku9oBg3Z0YWKqkE=;
        b=eOO5ZNUBmiO6jT2Ctjzwzgjnz/wFquHjS8EK+KadkNU271k0Vflu9wEv6pAiZTR/1DmWmt
        S9+LhN3ic1i28OE+udodYPJybo+547VA/UCTv5RTBYakclhEYE3k+/yIpiKAgtd3++oeG8
        nb+80y2W0TI2wZfBTFs/Vx3E4pVaA5A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6df184a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 01:49:36 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id n191so2932373vkf.2;
        Tue, 29 Nov 2022 17:49:36 -0800 (PST)
X-Gm-Message-State: ANoB5pncuesRptxEWsXePAgNUKA4mjJz2bJXbypFiYtzPR+aoxAAZYzl
        U3fMAAco1AN/piNLxzkfPPRdHDFiq69n8UoGpuE=
X-Google-Smtp-Source: AA0mqf66W/xcXtQdoAptFqPtF1wHQXnsUvnHp/kQjOjpUGwMeXm8SA7gdDZVPxsNQFNwaCYa1oZNUSxEAAaQH+v4EVY=
X-Received: by 2002:a1f:2ac9:0:b0:3bc:94ab:92f8 with SMTP id
 q192-20020a1f2ac9000000b003bc94ab92f8mr22579402vkq.37.1669772975193; Tue, 29
 Nov 2022 17:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20221129160811.563011-1-Jason@zx2c4.com> <20221129182751.610558-1-Jason@zx2c4.com>
 <20221130014514.6494-1-hdanton@sina.com>
In-Reply-To: <20221130014514.6494-1-hdanton@sina.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 30 Nov 2022 02:49:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9pMmbpgUWWJb5q_uxR9_HP0NWeoxd1AUYL7Fvji09x=vQ@mail.gmail.com>
Message-ID: <CAHmME9pMmbpgUWWJb5q_uxR9_HP0NWeoxd1AUYL7Fvji09x=vQ@mail.gmail.com>
Subject: Re: [PATCH v3] random: spread out jitter callback to different CPUs
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On Wed, Nov 30, 2022 at 2:45 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On 29 Nov 2022 19:27:52 +0100 Jason A. Donenfeld <Jason@zx2c4.com>
> > Rather than merely hoping that the callback gets called on another CPU,
> > arrange for that to actually happen, by round robining which CPU the
> > timer fires on. This way, on multiprocessor machines, we exacerbate
> > jitter by touching the same memory from multiple different cores.
> >
> > It's necessary to call [try_to_]del_timer_sync() before calling
> > add_timer_on(), so that the final call to del_timer_sync() at the end o=
f
> > the function actually succeeds at making sure no handlers are running.
> >
> > Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Changes v2->v3:
> > - Thomas convinced me try_to_del_timer_sync() was fine.
> >
> >  drivers/char/random.c | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 7b71cea6a6ab..4cb1d606a492 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1232,7 +1232,8 @@ void __cold rand_initialize_disk(struct gendisk *=
disk)
> >  struct entropy_timer_state {
> >       unsigned long entropy;
> >       struct timer_list timer;
> > -     unsigned int samples, samples_per_bit;
> > +     atomic_t samples;
> > +     unsigned int samples_per_bit;
> >  };
> >
> >  /*
> > @@ -1250,10 +1251,8 @@ static void __cold entropy_timer(struct timer_li=
st *timer)
> >  {
> >       struct entropy_timer_state *state =3D container_of(timer, struct =
entropy_timer_state, timer);
> >
> > -     if (++state->samples =3D=3D state->samples_per_bit) {
> > +     if (atomic_inc_return(&state->samples) % state->samples_per_bit =
=3D=3D 0)
> >               credit_init_bits(1);
> > -             state->samples =3D 0;
> > -     }
> >  }
> >
> >  /*
> > @@ -1263,9 +1262,10 @@ static void __cold entropy_timer(struct timer_li=
st *timer)
> >  static void __cold try_to_generate_entropy(void)
> >  {
> >       enum { NUM_TRIAL_SAMPLES =3D 8192, MAX_SAMPLES_PER_BIT =3D HZ / 1=
5 };
> > -     struct entropy_timer_state stack;
> > +     struct entropy_timer_state stack =3D { 0 };
> >       unsigned int i, num_different =3D 0;
> >       unsigned long last =3D random_get_entropy();
> > +     int cpu =3D -1;
> >
> >       for (i =3D 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
> >               stack.entropy =3D random_get_entropy();
> > @@ -1277,19 +1277,37 @@ static void __cold try_to_generate_entropy(void=
)
> >       if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
> >               return;
> >
> > -     stack.samples =3D 0;
> >       timer_setup_on_stack(&stack.timer, entropy_timer, 0);
> >       while (!crng_ready() && !signal_pending(current)) {
> > -             if (!timer_pending(&stack.timer))
> > -                     mod_timer(&stack.timer, jiffies);
> > +             /*
> > +              * Check !timer_pending() and then ensure that any previo=
us callback has finished
> > +              * executing by checking try_to_del_timer_sync(), before =
queueing the next one.
> > +              */
> > +             if (!timer_pending(&stack.timer) && try_to_del_timer_sync=
(&stack.timer) >=3D 0) {
>
> If CPU RR is moved to the timer callback, timer game like this one that h=
urts
> brain can be avoided.

There's a comment in the code from Linus about this:

* Note that we don't re-arm the timer in the timer itself - we are happy to=
 be
* scheduled away, since that just makes the load more complex, but we do no=
t
* want the timer to keep ticking unless the entropy loop is running.

> What sense made by trying to delete a non-pending timer?

If the timer is no longer pending, but has not completed executing its
callback, and add_timer_on() is called, subsequent calls to
del_timer_sync() will stop the second add_timer_on(), but the first
one that has not completed executing its callback will not be touched.
Take a look at this example: https://=D7=90.cc/xBdEiIKO/c

Jason
