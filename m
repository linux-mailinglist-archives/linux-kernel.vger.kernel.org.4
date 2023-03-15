Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF49F6BBDCC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjCOUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjCOUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:12:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B264991B68
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:12:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x13so32809041edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1678911146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt1/82Ohrg4jPVSWuL40A6QrPT+N1kf8sWMSIZegpm0=;
        b=GtDrb2+bwaC877pRIvXwe3QCLIUCpE+6N9P1VgUBIcKLBdBXMp4soV4SwXVm4HERVg
         bO5n22TCMGaPLNAol1usD7mvN375j2kfdwj7hFvk/QS4nqIMuNe9my/xsCgwYenF5LU/
         B3Qw5gisLdsLM3AdEfkT2cyaIkvanNJksaykA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678911146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt1/82Ohrg4jPVSWuL40A6QrPT+N1kf8sWMSIZegpm0=;
        b=lC0xFby731Tiltzuhv68GDstnQFPMbmhJZ4y35C2DwKgy3A/FaQVYqVXa8cf9mlm7G
         s+7aHoGFej72IV3iYlUfPA9H1/iVwAZeeiDORQvq0gEgtNNLF+FbjNe/0L7vpdpfwjyW
         TMCBWV6t8MT8Aind153VD0uHD2GuAJZ+u1Iggp3TC/lKDIs76iZv906q8Unt7McMY6lE
         0QW3lUCgKrAAFCqEIVnKbDwpES1gZreceMOJIrdu9JMdbuVm/foPoMINnZIACh07QIQQ
         8Is6Zbf0+7qnBUVp4riD6N7va7HbdJwA1EYpNXLvhdCVKjJfda4mphyWpJYmb8pnaTJ2
         kflg==
X-Gm-Message-State: AO0yUKWAepwqo21QbqPhCbcCRe0F6UvvWEBuUmdXIKJ8ZkvRTNN4GWEu
        ebt7cCebyrdxvLSKxXVI8le6q3xTS3yFE51D9ICmYA==
X-Google-Smtp-Source: AK7set/qxzDGcRZcamsPiZKDQDL5GeHVZR1+TdIyuBXeuPV9LOCbQBtRn0/kcwiSTXetdxE1LDH//Aq794hDHcJCPYY=
X-Received: by 2002:a17:907:3f81:b0:8b8:aef3:f2a9 with SMTP id
 hr1-20020a1709073f8100b008b8aef3f2a9mr4061330ejc.0.1678911146049; Wed, 15 Mar
 2023 13:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
 <87h6v4ktp5.ffs@tglx> <CANDhNCrFWhOBLFWbm+qFFO4H3+VmEjtNLZAxA57EHMuV7YmUdg@mail.gmail.com>
 <CAJZ5v0jEZ6dgy5TjKVZ7dE24WX6HHNOYKR1BG5wM1gS2_ONXeA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jEZ6dgy5TjKVZ7dE24WX6HHNOYKR1BG5wM1gS2_ONXeA@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Wed, 15 Mar 2023 21:12:14 +0100
Message-ID: <CAOf5uwnfXkZfeDbS9us-+KKS1YB559Xd-y=f42usM3HPtB6M2g@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael

On Thu, Mar 2, 2023 at 4:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Thu, Mar 2, 2023 at 1:48 AM John Stultz <jstultz@google.com> wrote:
> >
> > On Wed, Mar 1, 2023 at 2:11=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> > >
> > > On Mon, Feb 27 2023 at 20:06, John Stultz wrote:
> > > > On Mon, Feb 27, 2023 at 4:03=E2=80=AFPM John Stultz <jstultz@google=
.com> wrote:
> > > >> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> > > >> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl,=
 unsigned long state,
> > > >> > +                                    void *unused)
> > > >> > +{
> > > >> > +       switch (state) {
> > > >> > +       case PM_HIBERNATION_PREPARE:
> > > >> > +       case PM_POST_HIBERNATION:
> > > >> > +               atomic_set(&alarmtimer_wakeup, 0);
> > > >> > +               break;
> > > >> > +       }
> > > >> > +       return NOTIFY_DONE;
> > > >>
> > > >> But here, we're setting the alarmtimer_wakeup count to zero if we =
get
> > > >> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
> > > >> And Michael noted we need to add  PM_SUSPEND_PREPARE and
> > > >> PM_POST_SUSPEND there for this to seemingly work.
> > >
> > > Yup. I missed those when sending out that hack.
> > >
> > > > So Thomas's notifier method of zeroing at the begining of suspend a=
nd
> > > > tracking any wakeups after that point makes more sense now. It stil=
l
> > > > feels a bit messy, but I'm not sure there's something better.
> > >
> > > I'm not enthused about it either.
> >
> > That said, it does work. :) In my testing, your approach has been
> > reliable, so it has that going for it.
> >
> > > > My only thought is this feels a little bit like its mirroring what =
the
> > > > pm_wakeup_event() logic is supposed to do. Should we be adding a
> > > > pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend f=
rom
> > > > occuring for 500ms or so after an alarmtimer has fired so there is
> > > > enough time for it to be re-armed if needed?
> > >
> > > The question is whether this can be called unconditionally and how th=
at
> > > interacts with the suspend logic. Rafael?
> >
> > I took a brief stab at this, and one thing is the test needs to use
> > the /sys/power/wakeup_count dance before suspending.
>
> That's correct.
>
> > However, I still had some cases where the recurring alarmtimer got
> > lost, so I need to dig a bit more to understand what was going wrong
> > there.
>
> I'm interested in that too, so if you have any conclusions, please let me=
 know.
>
> > In the meantime, I'm ok with Thomas' approach, but we probably need
> > some comment documentation that suggests it might be reworked in a
> > cleaner way?
>
> Well, in theory, the PM notifier can run in parallel with
> alarmtimer_fired() right after it has incremented the atomic var,
> can't it?

Can we add a function like pm_get_state()?

So can we mark the suspend window using some state?

Michael
