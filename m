Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DFE69CA24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjBTLrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjBTLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:47:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE01BE2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:47:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s26so3525990edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5MYDnxht01aIuDWLkYyvj7yZmM3aYYqRac20Yepq1lY=;
        b=JD2Iy/hmscHCz5oe0S09jyZNKkPVxb0f+R3OtOMg1ztU0utW792Q/7de9jd31ORy1D
         B8/BkYZf6BHU1DD2QJ1pIlCi6TmNJZNzF5vdeKHKq2vCqthijEX+CpT/uPO5s/52e1FT
         USHp1LIJRtmWSGwbhATDwSMzhkrT1QncRLStg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MYDnxht01aIuDWLkYyvj7yZmM3aYYqRac20Yepq1lY=;
        b=wzK5dXJRzVyw3NhoBf+PD9YqvSfOgOEQRPeEuFFVYiZ6MKczahNVgLbOoA1BymXs0b
         Yz2NaKikT2qhf3X6/0N8F6UoaE+u2rQ2AJwmMvvZ2do4/MrKwH2VsyjDOE2zhbnTzQsK
         xLoEoKKdIdBDKNTf6aR8XwP5r+dRe7gJaUl4GW0vgWQwBWgjANB1jBaqdbPP60i33HQp
         321u+d4zAdW2FbXrchriFQK+ocOlB0w4v7hcLBaZ3FNt3KbpiiebIUWMohLawaxHfdKz
         ui5HWDn6D1cmUXq/SW56KKQlEy7KiHZF0y4h5UEpMW8CYkP8aoyJm/uazzzpJE6U49LQ
         zdnQ==
X-Gm-Message-State: AO0yUKVfpYNhLs59cGD08Zm31iMUlrchC/5uhwUEYmFYFumloXActr6a
        0FA7yRBPcPm0Z71z5UsM2zXSkgxnMsN2irNjdZHRJA==
X-Google-Smtp-Source: AK7set/zCjOOdMN9SRibEUbaA9HfctlmSgam0qlRKB6MEy1DjJtBrvoHn8BdX7JrDkqX+PqSTeYHpnpEDE7gKZgyzMs=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr1367603edj.6.1676893667828; Mon, 20 Feb
 2023 03:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
In-Reply-To: <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 20 Feb 2023 12:47:36 +0100
Message-ID: <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Feb 20, 2023 at 9:23 AM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Thomas
>
> On Mon, Feb 20, 2023 at 8:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sat, Feb 18 2023 at 15:56, Michael Nazzareno Trimarchi wrote:
> > >
> > > I have changed the alarm test to check some corner case
> >
> > Could you tell us please which test did you change and what the change is?
> >
>

There are no changes in the kernel apart pr_info on enqueue dequeue
and fired call
in alarmtimer.c. linux  master branch sha
38f8ccde04a3fa317b51b05e63c3cb57e1641931
and both patches applied

time: alarmtimer: Use TASK_FREEZABLE to cleanup freezer handling
time: alarmtimer: Fix erroneous case of using 0 as an "invalid"
initialization value

Michael

>   if (timer_create(CLOCK_REALTIME_ALARM, &se, &tm1) == -1) {
>        printf("timer_create failed, %s unsupported?\n",
>        clockstring(alarm_clock_id));
>        exit(1);
>   }
>
>   clock_gettime(alarm_clock_id, &start_time);
>   printf("Start time (%s): %ld:%ld\n", clockstring(alarm_clock_id),
>                                 start_time.tv_sec, start_time.tv_nsec);
>   printf("Setting alarm for every %i seconds\n", SUSPEND_SECS);
>   its1.it_value = start_time;
>   its1.it_value.tv_sec += 4;
>   /* Empiric value for get in between a freeze task and fire of the timer */
>   its1.it_value.tv_nsec += 132079666;
>   its1.it_interval.tv_sec = 4;
>   its1.it_interval.tv_nsec = 0;
>
>   timer_settime(tm1, TIMER_ABSTIME, &its1, &its2);
>
>   printf("Starting suspend loops\n");
>   while (1) {
>       int ret;
>       sleep(4);
>       system("echo mem > /sys/power/state");
>   }
>
> > > periodic_alarm
> > > Start time (CLOCK_REALTIME_ALARM)[   85.624819] alarmtimer_enqueue: called
> > > : 94:865096467
> > > Setting alarm for every 4 seconds
> > > Starting suspend loops
> > > [   89.674127] PM: suspend entry (deep)
> > > [   89.714916] Filesystems sync: 0.037 seconds
> > > [   89.733594] Freezing user space processes
> > > [   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
> > > [   89.748593] OOM killer disabled.
> > > [   89.752257] Freezing remaining freezable tasks
> > > [   89.756807] alarmtimer_fired: called
> > > [   89.756831] alarmtimer_dequeue: called <---- HERE
> > >
> > > I have the dequeue but not an enquee of the periodic alarm. I was
> > > thinking that create a periodic time of 4 seconds
> > > and have the first alarm on suspend will always guarantee the re-arm
> > > it but it's not working as I expect
> >
> > Again. You are not telling what you expect. It depends on how the timer
> > is set up whether the timer is self rearmed or not.
> >
>
> Posted the pseudo code. As far as I understand, the timer periodic is
> re-armed in get_signal
> do_work_pending->do_signal()->get_signal(), then in the posix timer
> code the enqueue_alarm is called. All the timers
> used from suspend are coming from the expiration list that contains
> only the enqueue alarm
>
> My test case is a single core, arm and with only one REAL_TIME_ALARM
> periodic timer created.
>
> Michael
>
> > Thanks,
> >
> >         tglx



-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
