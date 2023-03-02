Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48B6A84B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCBO5Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 09:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCBO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:57:24 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4113D5708B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:56:58 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id o15so66228101edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677769014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuYEyupnyEDDEWi8yor53LRWxRGfTMHlAYvCB7+0j5U=;
        b=zFB4yZL1ugslBX0bddg//XLPgc+Es/ah9tTJn8gDdI8VdLf3tPtja6iOpIy5RwLoRW
         7dbfcu/+Ah/DAlr8+7oqJIJrJCZQfxHOKyXgIosgBVcQGS1+KOnRMszRW3TeAioGuiYA
         MFiaGW92jeAjO72scFED/fMZHVZWZ5qQUEQhJLc4GiLQf4ouR0xGx5XwEfagPuGPu04a
         mlnfpVRgDBblP/ePZUFo56oVMyhITYbpeen8VeodfvthxLVKbI9erHrEewoxbQ8/dRiV
         zQEjfMOg1SfcXcAuYJWLni3OEHYKSu23pTmQlqh/MPNuQrXNqntrNP3YNQaagvq78GGQ
         l48Q==
X-Gm-Message-State: AO0yUKVj8RcUL6/qSqBnVAzdVaepsoJycIiIg5pF1mlWgUKMg3tt7FLC
        LMEIX6CfCk+Jqk0Jbr5KMJhWaR5s+uZ7uNXwCvQ=
X-Google-Smtp-Source: AK7set/r8sKKeNwnfusyIIVD/v7P6ZJbytl4igK1tnM3BH01CWKCwYuQIoNnZAn32T7S+bJwT24VtLzH9FtTF5zg36Y=
X-Received: by 2002:a50:cd17:0:b0:4bf:a788:1d68 with SMTP id
 z23-20020a50cd17000000b004bfa7881d68mr1813954edi.6.1677769014537; Thu, 02 Mar
 2023 06:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
 <87h6v4ktp5.ffs@tglx> <CAJZ5v0jtYE+yp57t60szEbtzFVc-kbeMcxAiWuYc-cf1q2HxMA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jtYE+yp57t60szEbtzFVc-kbeMcxAiWuYc-cf1q2HxMA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Mar 2023 15:56:43 +0100
Message-ID: <CAJZ5v0hwNzr6EdmM9SNnCmy9SZV_Ed9r_WO9L_cQ6Ms_+N2e8Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
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

On Thu, Mar 2, 2023 at 3:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 1, 2023 at 11:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
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
> >
> > > My only thought is this feels a little bit like its mirroring what the
> > > pm_wakeup_event() logic is supposed to do. Should we be adding a
> > > pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend from
> > > occuring for 500ms or so after an alarmtimer has fired so there is
> > > enough time for it to be re-armed if needed?
> >
> > The question is whether this can be called unconditionally and how that
> > interacts with the suspend logic. Rafael?
>
> The pm_wakeup_event() doesn't need the timeout, but it is conditional
> on using /sys/power/wakeup_count.
>
> However, in any case it doesn't guarantee that the target user of the
> alarm timer will be able to handle the signal on time AFAICS.  To my
> eyes, it is entirely possible for alarmtimer_fired() to run before
> /sys/power/wakeup_count is written to while the signal will be sent to

I actually should have said "read from" instead of "written to" here, sorry.

> the given task later, in which case there is no guarantee that the
> task will not be frozen in the meantime.
>
> Moreover, I'm wondering if all alarm timers should always wake up the
> system from sleep or abort suspends in progress?  If the answer is
> "no" here, it changes the problem at hand quite a bit.
