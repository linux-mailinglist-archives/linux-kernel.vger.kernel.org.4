Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1825E69D253
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBTRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjBTRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:48:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516243A9D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:48:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676915303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQS4QsaFC3svyUHjmw0GJ0yql+bSOBNy4eYRriM2vsQ=;
        b=d/CFlFu2s4JEcQgZed+ej85ruXwVA4K34I+9Hp2si3oGD7DMsswzEQjWqQlbae/3cE22X4
        4FQ0WjXiGwrNTUdugqKOcE7WWuktyQwg2ehHe8dGVD0eBpV7clcaoIC7ZTnoB4HpQHyUrL
        6CglFkc2JaYXZpz0gGCkwOIAC5qBcXYag3E6swGUlQlPs8ZU8MsSxRzxBP0CALcvJA99hR
        HWL3aioXzDMf6JrNohQOj+rN5DWrfiAOAVW3j/+kfrxhlO17jUaI+vGbzdDFxdBCEO5zjB
        GyFXT+bekxYlNM0bzJU8jaeYng41aYhE4WfbO5y8Diwy6JdKiWbj9r+z43CYEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676915303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQS4QsaFC3svyUHjmw0GJ0yql+bSOBNy4eYRriM2vsQ=;
        b=ZnU4WC3wpSBJP1ReoCpUmC+ofDo7gPFqtkIvDjwZoIf977rzoXphxCBRmd6KTdGkEksor2
        BhRggHIzB/KCxXDQ==
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx>
 <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
Date:   Mon, 20 Feb 2023 18:48:22 +0100
Message-ID: <87a618qlcp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael!

On Mon, Feb 20 2023 at 12:47, Michael Nazzareno Trimarchi wrote:
> On Mon, Feb 20, 2023 at 9:23 AM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>> On Mon, Feb 20, 2023 at 8:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > > Starting suspend loops
>> > > [   89.674127] PM: suspend entry (deep)
>> > > [   89.714916] Filesystems sync: 0.037 seconds
>> > > [   89.733594] Freezing user space processes
>> > > [   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
>> > > [   89.748593] OOM killer disabled.
>> > > [   89.752257] Freezing remaining freezable tasks
>> > > [   89.756807] alarmtimer_fired: called
>> > > [   89.756831] alarmtimer_dequeue: called <---- HERE
>> > >
>> > > I have the dequeue but not an enquee of the periodic alarm. I was
>> > > thinking that create a periodic time of 4 seconds
>> > > and have the first alarm on suspend will always guarantee the re-arm
>> > > it but it's not working as I expect
>> >
>> > Again. You are not telling what you expect. It depends on how the timer
>> > is set up whether the timer is self rearmed or not.
>>
>> Posted the pseudo code. As far as I understand, the timer periodic is
>> re-armed in get_signal do_work_pending->do_signal()->get_signal(),
>> then in the posix timer code the enqueue_alarm is called. All the
>> timers used from suspend are coming from the expiration list that
>> contains only the enqueue alarm.

Let me try to decode the above.

Yes, periodic timers are re-armed when the signal is delivered, but that
happens way later after the system resumed.

Here is what I observe:

[   27.349352] alarmtimer_enqueue()

U: Before SUSPEND

[   31.353228] PM: suspend entry (s2idle)
[   31.388857] Filesystems sync: 0.033 seconds
[   31.418427] Freezing user space processes
[   31.422406] Freezing user space processes completed (elapsed 0.002 seconds)
[   31.425435] OOM killer disabled.
[   31.426833] Freezing remaining freezable tasks
[   31.429838] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   31.432922] printk: Suspending console(s) (use no_console_suspend to debug)
[   31.435912] alarmtimer alarmtimer.0.auto: PM: dpm_run_callback(): platform_pm_suspend+0x0/0x50 returns -16
[   31.435954] alarmtimer alarmtimer.0.auto: PM: failed to suspend: error -16

That means the RTC interrupt was raised before the system was able to suspend.

[   31.436077] PM: Some devices failed to suspend, or early wake event detected
[   31.444270] OOM killer enabled.
[   31.445011] Restarting tasks ... done.
[   31.446820] random: crng reseeded on system resumption
[   31.466019] PM: suspend exit

[   31.480283] alarmtimer_fired()
[   31.481403] alarmtimer_dequeue()     <- Signal queued

[   31.482596] alarmtimer_rearm()_      <- Signal delivery
[   31.483713] alarmtimer_enqueue()

U: ALRM signal received                 <- User space signal handler
U: Post Suspend                         <- system("echo .... >") returns

That's 6.2 + John's patches.

Thanks,

        tglx

