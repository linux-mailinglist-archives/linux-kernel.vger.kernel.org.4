Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A606A7879
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCBAsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBAsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:48:02 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E085BB9C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:48:00 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536cd8f6034so397595607b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 16:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUOb49VAF5pAkVsChXn5iCT7iThCTQFMfi9xDuW2rps=;
        b=ZxPk/4tc/BLTear92MtasKWFUcZi0/HYAmSEvYFzopDx0wLHVvtu8UBNXzvmBto3Al
         F4DZ+iz/r9MOnn12pBRZrpX6vkA4t+dUdDWwRy6/sQjT9oKKa9YYUS5ACGPSx4JLYJNg
         p1EF/ImyYAKG9K0dVBCFo3bOHg3iaS8EgVChVXmRJz3KgGlWzMzO+y+UdC9Efg/OdM8Q
         2Q9Feh1FSA2y6gaujglxRc0aA5BdbECkXO4RpXjT8DOenQv/gziRiPpdl5940YOv8gfF
         hRxrb1rmXR+JF9Uvi8jKXIkAlTEN1PleFNZAhbG2IpatKQNqYSIAxyKGF5fMP2ToHfYv
         Wwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUOb49VAF5pAkVsChXn5iCT7iThCTQFMfi9xDuW2rps=;
        b=H/8mvNZ1Bkm+zspw+BC/NukV/Ra7zYqRWH8uSo7gegmIwcZJVHRlx/y+n8r8f4y1Ch
         sCOz6NYxuKdGd6dsLlRkXhmIJqmHVZc7NgvpjBtfdjUPo7Ca+VwdRi1pJ/NF1a1fDaU1
         nl1T6FnomNVn2HXPjiLRdyrLd8TvVb4HXvIA7c9Pn3DgC1Wy+QBStN+BBnrttVLn8l47
         dKIcXuxPZr5nYJiK/uUcMHbd46EUCpYzDH/AT0uPSJ8qmjqo+3tubGA/o98BmleQ+PeY
         +2QDl/zhuxhqpE8z4XyeC0O94v4pio1qg4cbE1JMDpCCOl0wAH8s3KeWR1fnHuBU3A0M
         o54A==
X-Gm-Message-State: AO0yUKV7OB5jek4XGU0PZ5HUfQDi753J0NNtDBD2rFDkDHWMDGPylLpq
        kqTteBx/rNaInRNeunzZOktOK98JKf44rl3JTR7B1peIvAJGoif/Og==
X-Google-Smtp-Source: AK7set9B4NTStm6PU6LLj+b26H8B0Z2DKO/jJ/5rXUPXi4FtBFzOjNEPFbX3J7VaK8I8xzgvRRP6i/9y4GPQhLJyAhI=
X-Received: by 2002:a81:ae0e:0:b0:534:7429:2eb4 with SMTP id
 m14-20020a81ae0e000000b0053474292eb4mr5167177ywh.3.1677718079743; Wed, 01 Mar
 2023 16:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com> <87h6v4ktp5.ffs@tglx>
In-Reply-To: <87h6v4ktp5.ffs@tglx>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 1 Mar 2023 16:47:48 -0800
Message-ID: <CANDhNCrFWhOBLFWbm+qFFO4H3+VmEjtNLZAxA57EHMuV7YmUdg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 2:11=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Feb 27 2023 at 20:06, John Stultz wrote:
> > On Mon, Feb 27, 2023 at 4:03=E2=80=AFPM John Stultz <jstultz@google.com=
> wrote:
> >> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> >> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, uns=
igned long state,
> >> > +                                    void *unused)
> >> > +{
> >> > +       switch (state) {
> >> > +       case PM_HIBERNATION_PREPARE:
> >> > +       case PM_POST_HIBERNATION:
> >> > +               atomic_set(&alarmtimer_wakeup, 0);
> >> > +               break;
> >> > +       }
> >> > +       return NOTIFY_DONE;
> >>
> >> But here, we're setting the alarmtimer_wakeup count to zero if we get
> >> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
> >> And Michael noted we need to add  PM_SUSPEND_PREPARE and
> >> PM_POST_SUSPEND there for this to seemingly work.
>
> Yup. I missed those when sending out that hack.
>
> > So Thomas's notifier method of zeroing at the begining of suspend and
> > tracking any wakeups after that point makes more sense now. It still
> > feels a bit messy, but I'm not sure there's something better.
>
> I'm not enthused about it either.

That said, it does work. :) In my testing, your approach has been
reliable, so it has that going for it.

> > My only thought is this feels a little bit like its mirroring what the
> > pm_wakeup_event() logic is supposed to do. Should we be adding a
> > pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend from
> > occuring for 500ms or so after an alarmtimer has fired so there is
> > enough time for it to be re-armed if needed?
>
> The question is whether this can be called unconditionally and how that
> interacts with the suspend logic. Rafael?

I took a brief stab at this, and one thing is the test needs to use
the /sys/power/wakeup_count dance before suspending.
However, I still had some cases where the recurring alarmtimer got
lost, so I need to dig a bit more to understand what was going wrong
there.

In the meantime, I'm ok with Thomas' approach, but we probably need
some comment documentation that suggests it might be reworked in a
cleaner way?

thanks
-john
