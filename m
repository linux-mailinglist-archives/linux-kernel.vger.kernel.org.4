Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3503B69D76B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjBUAM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjBUAMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:12:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD945FF9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:12:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676938371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwOcHyDhmKM0zAB+GbcrD7eW2Ij4McN5k7mmG6Z5gQM=;
        b=a2EiD8SagPG8nrtP281MLuuF91B0anYgqcArT83Hnm2i6jhq+TgyJ67hDkMOpnELEIPryG
        9c07W7OoiwuXzD8l5Tb1WHRTu0rjyFJ0l+HkLtVSmYDdN0304FIpmJZzTExO9tr/sLcFb3
        FfX7mPkmhb7pXUTGKy3d60DwNTZjFff8tMFRn0wuGO+YCBLf/I9uesXsaqTe5ziN4tsP6q
        mestqUSmvVnAxyRFVmfWDeMzoWomJ25zCKtZJltREHX9N9ZuIOLUUclhl1qdTn9luEiOnl
        ZTMTC9m6XpdPabkaPqMsot2hIwWjtVzrMxiXDWG8XLENU7QxdP8xI9uBXk1dTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676938371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwOcHyDhmKM0zAB+GbcrD7eW2Ij4McN5k7mmG6Z5gQM=;
        b=FXgoJ7leqhRkXM5V+ExvfKOZkrT9YHaHbdiOl/AAOQsvhPm1ryRsKT9OwbSwhGYVZU08z6
        xtgo5tjsP1kY7qDg==
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx>
 <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx>
 <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
 <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
Date:   Tue, 21 Feb 2023 01:12:51 +0100
Message-ID: <874jrfq3jw.ffs@tglx>
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

On Mon, Feb 20 2023 at 22:32, Michael Nazzareno Trimarchi wrote:
> On Mon, Feb 20, 2023 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>   * alarmtimer_fired - Handles alarm hrtimer being fired.
>> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
>>         int ret = HRTIMER_NORESTART;
>>         int restart = ALARMTIMER_NORESTART;
>>
>> +       atomic_inc(&alarmtimer_wakeup);
>> +
>
>        ptr->it_active = 0;
>         if (ptr->it_interval) {
>                 atomic_inc(&alarmtimer_wakeup);
>                 si_private = ++ptr->it_requeue_pending;
>         }
>
> Should I not go to the alarm_handle_timer? and only if it's a periodic
> one?

Why?

Any alarmtimer which hits that window has exactly the same problem.

It's not restricted to periodic timers. Why would a dropped one-shot
wakeup be acceptable?

It's neither restricted to posix timers. If a clock_nanosleep(ALARM)
expires in that window then the task wake up will just end up in the
/dev/null bucket for the very same reason. Why would this be correct?

Hmm?

<GRMBL>
> Michael
>
>>         spin_lock_irqsave(&base->lock, flags);

<SNIP>Tons of wasted electrons</SNIP>

Can you please trim your replies?

</GRMBL>

Thanks,

        tglx
