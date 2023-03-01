Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AE6A76A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCAWLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:11:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CF4DBC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:11:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677708710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlyLbB45rqwaCq9vwI4qCKVScjkmgzhanVl7NNh7+f8=;
        b=w9u2JD+MLUI7LDfWDULU0t0zORxd9L+araLd6yCpyUH1TSrEnRon4OoOMDfSFmf2cHb2up
        CGU61+R7YMlok8zLkzwSYpbGLJwcZ5Rx1BO4kgKrliI1Ch3afubHAZ9GYX7BfldTqvNU2Q
        n7dGwiXBTQ5irVF8scjwwaLCwD1MtEyDZXLrigNfNNoRZexauc7bPBTwZ4WlJqo5QPW1wo
        bTIg9J4Gjft5+Zksyg1kXQU2SNEWuLpGwirYJJ2EcDRQw3Q363zdlbKRHbuX33el6Subyv
        xBKdvUW21aByhF7qyx0WF2S07AOq8cEcG+sCoPXK2GRySkdOXroEQUqWyQzKcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677708710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlyLbB45rqwaCq9vwI4qCKVScjkmgzhanVl7NNh7+f8=;
        b=bCDc65SmDl4qqCJdWfnnrJmBjvjzGQ4X4M8WzKSKY/NyB3/t8j5X4N8dblebhWTrkQt5pJ
        TwNN0C5nJDcFBeDA==
To:     John Stultz <jstultz@google.com>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx>
 <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx>
 <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
 <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
Date:   Wed, 01 Mar 2023 23:11:50 +0100
Message-ID: <87h6v4ktp5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27 2023 at 20:06, John Stultz wrote:
> On Mon, Feb 27, 2023 at 4:03=E2=80=AFPM John Stultz <jstultz@google.com> =
wrote:
>> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
>> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, unsig=
ned long state,
>> > +                                    void *unused)
>> > +{
>> > +       switch (state) {
>> > +       case PM_HIBERNATION_PREPARE:
>> > +       case PM_POST_HIBERNATION:
>> > +               atomic_set(&alarmtimer_wakeup, 0);
>> > +               break;
>> > +       }
>> > +       return NOTIFY_DONE;
>>
>> But here, we're setting the alarmtimer_wakeup count to zero if we get
>> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
>> And Michael noted we need to add  PM_SUSPEND_PREPARE and
>> PM_POST_SUSPEND there for this to seemingly work.

Yup. I missed those when sending out that hack.

> So Thomas's notifier method of zeroing at the begining of suspend and
> tracking any wakeups after that point makes more sense now. It still
> feels a bit messy, but I'm not sure there's something better.

I'm not enthused about it either.=20

> My only thought is this feels a little bit like its mirroring what the
> pm_wakeup_event() logic is supposed to do. Should we be adding a
> pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend from
> occuring for 500ms or so after an alarmtimer has fired so there is
> enough time for it to be re-armed if needed?

The question is whether this can be called unconditionally and how that
interacts with the suspend logic. Rafael?

Thanks,

        tglx
