Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9BD6A84C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCBPBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 10:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCBPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:01:06 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB53E0A9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:01:05 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id i34so68713688eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677769264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSdi8RpAh9u5QxDP9l7b7STssWYXExp/By7WLN4/uXU=;
        b=gpiZ3tixi3KWKzwimoRBnQ3aFPNVwcr3IESMiY0A1wddvbE7iogL+UERyPjDGqruJO
         lIbS7IgY68jq4sUJu9ZCox6FDr4h6HGyQFgJG8I+z1wf/v+pEl+85TU9zKVEUi9lHsoe
         N1lxugB18Bizse5JFcwDXs9uf88IqPcenhi8ealQwTqq0y7fnEgsnJpbONKI07ROe0VV
         0cFYDofJX7hVhFj7QGGbNi2d0JpDzEQkN1hfWnL/PlpBhduczchWoML2zfRYp9CO9vQY
         N9JcHwk9PfQnkn7+3SNbi3YSbdpsse34l6BMZxtfBG0scdm49FrHN8ywoGOEGzTRTjJz
         C+Ww==
X-Gm-Message-State: AO0yUKUsKAHD+70JNSdGicJnqYEpMgODuS5kjGgxySjVeCZJidayzVCh
        IJSpeMDS49Iwdcao1qK8c6Gxo0Yj+cPw5joYqXw=
X-Google-Smtp-Source: AK7set8QPss+pOAsAHilPsnuRSyCVs9G2M3afZS03BIrXlYT+HPg2xHBs5xSFB1spCP4yMJQ6xwp2HPISWAo7JA+CFs=
X-Received: by 2002:a50:9559:0:b0:4af:62ad:6099 with SMTP id
 v25-20020a509559000000b004af62ad6099mr1317950eda.2.1677769263772; Thu, 02 Mar
 2023 07:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
 <87h6v4ktp5.ffs@tglx> <CANDhNCrFWhOBLFWbm+qFFO4H3+VmEjtNLZAxA57EHMuV7YmUdg@mail.gmail.com>
In-Reply-To: <CANDhNCrFWhOBLFWbm+qFFO4H3+VmEjtNLZAxA57EHMuV7YmUdg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Mar 2023 16:00:52 +0100
Message-ID: <CAJZ5v0jEZ6dgy5TjKVZ7dE24WX6HHNOYKR1BG5wM1gS2_ONXeA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 1:48 AM John Stultz <jstultz@google.com> wrote:
>
> On Wed, Mar 1, 2023 at 2:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Feb 27 2023 at 20:06, John Stultz wrote:
> > > On Mon, Feb 27, 2023 at 4:03 PM John Stultz <jstultz@google.com> wrote:
> > >> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> > >> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, unsigned long state,
> > >> > +                                    void *unused)
> > >> > +{
> > >> > +       switch (state) {
> > >> > +       case PM_HIBERNATION_PREPARE:
> > >> > +       case PM_POST_HIBERNATION:
> > >> > +               atomic_set(&alarmtimer_wakeup, 0);
> > >> > +               break;
> > >> > +       }
> > >> > +       return NOTIFY_DONE;
> > >>
> > >> But here, we're setting the alarmtimer_wakeup count to zero if we get
> > >> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
> > >> And Michael noted we need to add  PM_SUSPEND_PREPARE and
> > >> PM_POST_SUSPEND there for this to seemingly work.
> >
> > Yup. I missed those when sending out that hack.
> >
> > > So Thomas's notifier method of zeroing at the begining of suspend and
> > > tracking any wakeups after that point makes more sense now. It still
> > > feels a bit messy, but I'm not sure there's something better.
> >
> > I'm not enthused about it either.
>
> That said, it does work. :) In my testing, your approach has been
> reliable, so it has that going for it.
>
> > > My only thought is this feels a little bit like its mirroring what the
> > > pm_wakeup_event() logic is supposed to do. Should we be adding a
> > > pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend from
> > > occuring for 500ms or so after an alarmtimer has fired so there is
> > > enough time for it to be re-armed if needed?
> >
> > The question is whether this can be called unconditionally and how that
> > interacts with the suspend logic. Rafael?
>
> I took a brief stab at this, and one thing is the test needs to use
> the /sys/power/wakeup_count dance before suspending.

That's correct.

> However, I still had some cases where the recurring alarmtimer got
> lost, so I need to dig a bit more to understand what was going wrong
> there.

I'm interested in that too, so if you have any conclusions, please let me know.

> In the meantime, I'm ok with Thomas' approach, but we probably need
> some comment documentation that suggests it might be reworked in a
> cleaner way?

Well, in theory, the PM notifier can run in parallel with
alarmtimer_fired() right after it has incremented the atomic var,
can't it?
