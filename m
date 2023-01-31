Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93BB682F89
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjAaOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:44:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B603B8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:44:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675176240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xup1RluWPEnVOmzVlYwglrfkeCvq+WlpCcrzNblUL7w=;
        b=ltplNdFMJb7qfqM2+KBilG6cdzeWLBUdu9sAkcXalQWlYI0oezZNWe+S8GMFbjrSUm6Osh
        TlGXFT5QBykfERdSE6fdVCDfYwK+8F/YXESTcvt6wrvuaeshYr6T5IEmyjtBE5n2+MfwU4
        31yrkGGF76daZJ6zJSDWYj8whBBldTtkTkMhPajl6tTxWA0ww5pyuXjM3n7j8Wb8vh5xP5
        +mA0mSnlacAv2Vn7hOGX1ENwk2RkMdk7hctez3npkfsA9szNkJZ9MgyIT6wly6Q6yS+4Ui
        1SUk0dhxExjZczRy46beiDfYaJhblvTFqmLJ+Y6C6eCs1TnBS9T98I7Ydfn9aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675176240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xup1RluWPEnVOmzVlYwglrfkeCvq+WlpCcrzNblUL7w=;
        b=Gh9fH0lUD+f+iPsw89aH6uaoN3R/Ab3AKl1cTvk8UiBRzPJ+B0ASzNMQTqEtwZ/yEtepcA
        Vw9A+70zDMk0vVDw==
To:     Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com, mingo@kernel.org
Cc:     liaoyu15@huawei.com, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
In-Reply-To: <20230128020051.2328465-1-liaoyu15@huawei.com>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
Date:   Tue, 31 Jan 2023 15:44:00 +0100
Message-ID: <87357q228f.ffs@tglx>
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

On Sat, Jan 28 2023 at 10:00, Yu Liao wrote:
> selftest/proc/proc-uptime-001 complains:
>   Euler:/mnt # while true; do ./proc-uptime-001; done
>   proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
>   proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
>
> /proc/uptime should be monotonically increasing. This occurs because
> the data races between get_cpu_idle_time_us and
> tick_nohz_stop_idle/tick_nohz_start_idle, for example:
>
> CPU0                        CPU1
> get_cpu_idle_time_us
>
>                             tick_nohz_idle_exit
>                               now = ktime_get();
>                               tick_nohz_stop_idle
>                                 update_ts_time_stats
>                                   delta = ktime_sub(now, ts->idle_entrytime);
>                                   ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta)
>                                   ts->idle_entrytime = now
>
> now = ktime_get();
> if (ts->idle_active && !nr_iowait_cpu(cpu)) {
>     ktime_t delta = ktime_sub(now, ts->idle_entrytime);
>     idle = ktime_add(ts->idle_sleeptime, delta);
>     //idle is slightly greater than the actual value
> } else {
>     idle = ts->idle_sleeptime;
> }
>                             ts->idle_active = 0
>
> After this, idle = idle_sleeptime(actual idle value) + now(CPU0) - now(CPU1).
> If get_cpu_idle_time_us() is called immediately after ts->idle_active = 0,
> only ts->idle_sleeptime is returned, which is smaller than the previously
> read one, resulting in a non-monotonically increasing idle time. In
> addition, there are other data race scenarios not listed here.

Seriously this procfs accuracy is the least of the problems and if this
would be the only issue then we could trivially fix it by declaring that
the procfs output might go backwards. It's an estimate after all. If
there would be a real reason to ensure monotonicity there then we could
easily do that in the readout code.

But the real issue is that both get_cpu_idle_time_us() and
get_cpu_iowait_time_us() can invoke update_ts_time_stats() which is way
worse than the above procfs idle time going backwards.

If update_ts_time_stats() is invoked concurrently for the same CPU then
ts->idle_sleeptime and ts->iowait_sleeptime are turning into random
numbers.

This has been broken 12 years ago in commit 595aac488b54 ("sched:
Introduce a function to update the idle statistics").

> This patch introduce a lock to prevent data races.

Please search for 'This patch' in Documentation/process and act
accordingly.

> diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> index 504649513399..a64d4781e7af 100644
> --- a/kernel/time/tick-sched.h
> +++ b/kernel/time/tick-sched.h
> @@ -81,6 +81,7 @@ struct tick_sched {
>  	atomic_t			tick_dep_mask;
>  	unsigned long			last_tick_jiffies;
>  	unsigned int			stalled_jiffies;
> +	spinlock_t			idle_time_lock;

That must be a raw_spinlock_t and we need to look at the placement
inside the structure.

@Frederic: This structure is patently unstructured and if we fix this
issue here then we really want to look at the cache line layout for
real.

Also the name is misleading. It's protecting way more than the idle
time muck.

>  static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ts->idle_time_lock, flags);

  raw_spin_lock();

tick_nohz_start/stop_idle() are called with interrupts disabled.

>  u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)

u64 get_cpu_iowait_time_us() requires the same treatment.

Thanks,

        tglx

P.S.: I hate the spinlock in the idle code path, but I don't have a
      better idea.
