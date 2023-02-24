Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB56A1968
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjBXKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBXKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D014EA1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x10so51909533edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xp5RRtgEuUclN1gzlJG38qRywuFBqE+AlMuv+dm8tf8=;
        b=U0ma6NY+2FTKXGN0P6qdKtrg2IQ/16q9zrmLLf1gz+XI206uuB49xN57V85A8gh+Ys
         xsfvvPuD3485+qq+cS7YLMUX4ieB6eg8kys4Ljn1W3aWoLfsU42H3dYMo1jn4tTc5WdW
         vJ9MYmzmgQdSmwcLNab00czGWdHhoo4BtDUZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp5RRtgEuUclN1gzlJG38qRywuFBqE+AlMuv+dm8tf8=;
        b=C7HutlZu1OBHVaB/gufXehGkLNOMhSYAvCjixSe/dw2x25FNmkyjezcVaRIjxjWDid
         qizxWJON9w317VyoRHhoE4NfGPIrvRut7nJBtdHkm3Ye8LqtTbLM04TEvXflYnljy3kv
         +GZGRJNRuE6qbr2Wn/fYZ2iLXKA3AT2R+COnqSurNrJSrNUYOSNcL7M6X2pedEAFT9CL
         MbtinlhOiMETpqckXhZ+12bQFiMpIX7zRS7fRsDWTMegGQs7yWZRUZTyvwqpDVgERj7i
         TNIu8WbcirdyhL2EN/pmz/gRKaUDxy/FAWq9BSfMMHposkZ/kcSJ10iXMgknBPq62jB/
         GPAg==
X-Gm-Message-State: AO0yUKXyhUp4UjK8sOmOIH1BXI8TGiV5lSHJ9sfI7WVzw3dtBHGy7Qv8
        bzvt4oOWSJexezDktZWXOhos/rrs+Zz800RGtVB9dw==
X-Google-Smtp-Source: AK7set/Vi87e+88U7UTVLHS4rzVK6172JuMml9N5j9bjidx56MivcNux2HN3gPdbWBFnfcGerrGJaG3hTgWpg0gKl84=
X-Received: by 2002:a17:906:7b88:b0:8b1:81fa:b07a with SMTP id
 s8-20020a1709067b8800b008b181fab07amr11243575ejo.12.1677232980595; Fri, 24
 Feb 2023 02:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
 <874jrfq3jw.ffs@tglx> <CAOf5uw=+yZiTXGyjDgiw_w9yZZ5Pz3JQpykdCyFfbpNBTz+rXA@mail.gmail.com>
In-Reply-To: <CAOf5uw=+yZiTXGyjDgiw_w9yZZ5Pz3JQpykdCyFfbpNBTz+rXA@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 24 Feb 2023 11:02:49 +0100
Message-ID: <CAOf5uwmqLkFDAjQdSJF8zXHjoz1P-2-Fp1L6orRHsAa6x89EHA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

On Tue, Feb 21, 2023 at 8:10 AM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Tue, Feb 21, 2023 at 1:12 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Michael!
> >
> > On Mon, Feb 20 2023 at 22:32, Michael Nazzareno Trimarchi wrote:
> > > On Mon, Feb 20, 2023 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>   * alarmtimer_fired - Handles alarm hrtimer being fired.
> > >> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
> > >>         int ret = HRTIMER_NORESTART;
> > >>         int restart = ALARMTIMER_NORESTART;
> > >>
> > >> +       atomic_inc(&alarmtimer_wakeup);
> > >> +
> > >
> > >        ptr->it_active = 0;
> > >         if (ptr->it_interval) {
> > >                 atomic_inc(&alarmtimer_wakeup);
> > >                 si_private = ++ptr->it_requeue_pending;
> > >         }
> > >
> > > Should I not go to the alarm_handle_timer? and only if it's a periodic
> > > one?
> >
> > Why?
> >
>
> You are right. I will pay more attention to my reply.
>

I get time to test it and if the system suspend to ram we need to catch:

case PM_SUSPEND_PREPARE:
case PM_POST_SUSPEND:

Michael

> Michael
>
> > Any alarmtimer which hits that window has exactly the same problem.
> >
> > It's not restricted to periodic timers. Why would a dropped one-shot
> > wakeup be acceptable?
> >
> > It's neither restricted to posix timers. If a clock_nanosleep(ALARM)
> > expires in that window then the task wake up will just end up in the
> > /dev/null bucket for the very same reason. Why would this be correct?
> >
> > Hmm?
> >
> > <GRMBL>
> > > Michael
> > >
> > >>         spin_lock_irqsave(&base->lock, flags);
> >
> > <SNIP>Tons of wasted electrons</SNIP>
> >
> > Can you please trim your replies?
> >
> > </GRMBL>
> >
> > Thanks,
> >
> >         tglx
