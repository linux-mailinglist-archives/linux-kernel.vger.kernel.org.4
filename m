Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250EF6EB3AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjDUVc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDUVcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4922705
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 14:32:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682112735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y70ANqKTzeTjGgvJyEnU2TbSMwNx98UPV9QFdT+z/F8=;
        b=kKcG/qEeFl1cwvNsJdRCnuh+fadQl6xlHTYxtxvpEUF5AiKUa9uWgDLzXw9kRDvLYMYYsh
        yaBVoUzEErvPBbtWTgjQL9lI9meskjW0A5IyWKVDIyUPA8r/3thoZAHWVhIX0l86H5YmF5
        4CeyedQeOVmnUFt6jLvnDBicmDPKj6vbRXaEVlq8bFkHMD0LJCvVpx9eeZLyS2NERg/mPH
        aETFm+aS5sUIkbeUep6ZYMsJh7LfEXEVw2Jw7FVAqO4FFy88+mXXIjhigGHXzVf81UM2Zp
        K6GriGvogzsoKZ28NOFeMD4wtRI80t1DblM/qpuAJV/ZaBfWd1D9Q+f3FE/R3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682112735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y70ANqKTzeTjGgvJyEnU2TbSMwNx98UPV9QFdT+z/F8=;
        b=1Rl/A9DSViA2U1dItlGCCseR/rT5eZMQZRnP33gGm6a6PYA9hJAJcjqMG6Am69a8qzwevq
        LmEoCCs+z08h/tBw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <ZD/uWdz7dKLKlUqH@localhost.localdomain>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx> <ZD/uWdz7dKLKlUqH@localhost.localdomain>
Date:   Fri, 21 Apr 2023 23:32:15 +0200
Message-ID: <87jzy42a74.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19 2023 at 15:36, Frederic Weisbecker wrote:
> Le Sat, Apr 15, 2023 at 11:01:51PM +0200, Thomas Gleixner a =C3=A9crit :
>> @@ -1020,48 +1021,89 @@ static inline ktime_t tick_get_next_peri
>>  /**
>>   * tick_broadcast_setup_oneshot - setup the broadcast device
>>   */
>> -static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
>> +static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
>> +					 bool from_periodic)
>>  {
>>  	int cpu =3D smp_processor_id();
>> +	ktime_t nexttick =3D 0;
>>=20=20
>>  	if (!bc)
>>  		return;
>>=20=20
>>  	/* Set it up only once ! */
>> -	if (bc->event_handler !=3D tick_handle_oneshot_broadcast) {
>> -		int was_periodic =3D clockevent_state_periodic(bc);
>> -
>> -		bc->event_handler =3D tick_handle_oneshot_broadcast;
>> -
>> +	if (bc->event_handler =3D=3D tick_handle_oneshot_broadcast) {
>>  		/*
>> -		 * We must be careful here. There might be other CPUs
>> -		 * waiting for periodic broadcast. We need to set the
>> -		 * oneshot_mask bits for those and program the
>> -		 * broadcast device to fire.
>> +		 * The CPU which switches from periodic to oneshot mode
>> +		 * sets the broadcast oneshot bit for all other CPUs which
>> +		 * are in the general (periodic) broadcast mask to ensure
>> +		 * that CPUs which wait for the periodic broadcast are
>> +		 * woken up.
>> +		 *
>> +		 * Clear the bit for the local CPU as the set bit would
>> +		 * prevent the first tick_broadcast_enter() after this CPU
>> +		 * switched to oneshot state to program the broadcast
>> +		 * device.
>>  		 */
>> +		tick_broadcast_clear_oneshot(cpu);
>
> So this path is reached when we setup/exchange a new tick device
> on a CPU after the broadcast device has been set to oneshot, right?
>
> Why does it have a specific treatment? Is it for optimization? Or am I
> missing a correctness based reason?

This path is taken during the switch from periodic to oneshot mode. The
way how this works is:

boot()
  setup_periodic()
    setup_periodic_broadcast()

  // From here on everything depends on the periodic broadcasting

  highres_clocksource_becomes_available()
    tick_clock_notify() <- Set's the .check_clocks bit on all CPUs

Now the first CPU which observes that bit switches to oneshot mode, but
the other CPUs might be waiting for the periodic broadcast at that
point. So the periodic to oneshot transition does:

  		cpumask_copy(tmpmask, tick_broadcast_mask);
		/* Remove the local CPU as it is obviously not idle */
  		cpumask_clear_cpu(cpu, tmpmask);
		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpm=
ask);

I.e. it makes sure that _ALL_ not yet converted CPUs will get woken up
by the new oneshot broadcast handler.=20

Now when the other CPUs will observe the check_clock bit after that they
need to clear their bit in the oneshot mask while switching themself
from periodic to oneshot one otherwise the next tick_broadcast_enter()
would do nothing. That's all serialized by broadcast lock, so no race.

But that has nothing to do with switching the underlying clockevent
device. At that point all CPUs are already in oneshot mode and
tick_broadcast_oneshot_mask is correct.

So that will take the other code path:

    if (bc->event_handler =3D=3D tick_handle_oneshot_broadcast) {
       // not taken because the new device is not yet set up
       return;
    }

    if (from_periodic) {
       // not taken because the switchover already happened
       // Here is where the cpumask magic happens
    }
=20=20=20=20
> For the case where the other CPUs have already installed their
> tick devices and if that function is called with from_periodic=3Dtrue,
> the other CPUs will notice the oneshot change on their next call to
> tick_broadcast_enter() thanks to the lock, right? So the tick broadcast
> will keep firing until all CPUs have been through idle once and called
> tick_broadcast_exit(), right? Because only them can clear themselves
> from tick_broadcast_oneshot_mask, am I understanding this correctly?

No. See above. It's about the check_clock bit handling on the other
CPUs.

It seems I failed miserably to explain that coherently with the tons of
comments added. Hrmpf :(

> I'm trying to find the opportunity for a race with dev->next_event
> being seen as too far ahead in the future but can't manage so far...

There is none :)

Thanks,

        tglx
