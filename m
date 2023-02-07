Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D451F68D132
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjBGIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBGIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:04:12 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B22A9BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:04:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id EE080604EA;
        Tue,  7 Feb 2023 09:04:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1675757044; bh=1CCPPU1/c6yc/aulz+98WFCD+dR3YtKgYuNVwtGjgvg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Vja8kfclcedR1ugguQYzOrbdNALbbVmpSOZEZH+FVY35X2OrEM0lVN0qJWN3U3twk
         a6wlyOsGyHRuqZ4mWpYOwJX782hQk/nWbVRVrilbYNCE0UU1GliN+Ddcv3gkcTGwJP
         Mf7S4v066MC2RxyNmJVzArQPzOb7pFdGLD61JiJ3sbPJJzQ0X5/bZwgujsPSKNnAoJ
         fAl7RdzkMpz7ff1F07x/PPfddh08q71p1k0rhisO8KWPU68he3cytwWQQKkXzkzNsm
         28ZGvzlPyZd7kMA4Qp4/brwP38wvOPNT9TPkvL+SViBU5DBgsP7vY89TvsATWlImsm
         7zZngGc/DZQiA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uIrUfS12IEm4; Tue,  7 Feb 2023 09:04:02 +0100 (CET)
Received: from [10.0.1.17] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 0A6A3604ED;
        Tue,  7 Feb 2023 09:04:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1675757042; bh=1CCPPU1/c6yc/aulz+98WFCD+dR3YtKgYuNVwtGjgvg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=PW4sH8thgSu/sX9N96bLmpRadJyhlTQYhS9utvN7794i2IQHNN9/qO92AIoYOcplt
         6GXohYP28o85WxEfChMVYztgHn7bgMwB1Owq0sNT846YRAExYWqj0MibiQgA8kMVlq
         BjwQ0NY1oLYy9pKCqlAwvadWj3kE4KyPvBO0n6S7x0ZwGb8SOPpt9KZc8xIYL7WaCI
         Y9xiu+tHugXyJugVM7MOkwWUoPHuu1S/yaal7XRhLI/xdgxpifPSNYCzjkUOrQgSvu
         shOg9/QM50UrXkeXGtlxEFqqpnTmznwATwaejMsR7VsclzsJPys2+nVDDSey+Gwudz
         M/PTWs7QiCrLw==
Message-ID: <c299f2cd-1317-845c-0afe-a8ab67528c92@alu.unizg.hr>
Date:   Tue, 7 Feb 2023 09:03:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org
Cc:     liwei391@huawei.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <370700e7-6e93-d1ad-1215-81caccd50b5d@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <370700e7-6e93-d1ad-1215-81caccd50b5d@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.2.2023. 6:25, Mirsad Goran Todorovac wrote:
> Hi,Yu Liao,
> 
> On 28. 01. 2023. 03:00, Yu Liao wrote:
>> selftest/proc/proc-uptime-001 complains:
>>    Euler:/mnt # while true; do ./proc-uptime-001; done
>>    proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
>>    proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
>>
>> /proc/uptime should be monotonically increasing. This occurs because
>> the data races between get_cpu_idle_time_us and
>> tick_nohz_stop_idle/tick_nohz_start_idle, for example:
>>
>> CPU0                        CPU1
>> get_cpu_idle_time_us
>>
>>                              tick_nohz_idle_exit
>>                                now = ktime_get();
>>                                tick_nohz_stop_idle
>>                                  update_ts_time_stats
>>                                    delta = ktime_sub(now, ts->idle_entrytime);
>>                                    ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta)
>>                                    ts->idle_entrytime = now
>>
>> now = ktime_get();
>> if (ts->idle_active && !nr_iowait_cpu(cpu)) {
>>      ktime_t delta = ktime_sub(now, ts->idle_entrytime);
>>      idle = ktime_add(ts->idle_sleeptime, delta);
>>      //idle is slightly greater than the actual value
>> } else {
>>      idle = ts->idle_sleeptime;
>> }
>>                              ts->idle_active = 0
>>
>> After this, idle = idle_sleeptime(actual idle value) + now(CPU0) - now(CPU1).
>> If get_cpu_idle_time_us() is called immediately after ts->idle_active = 0,
>> only ts->idle_sleeptime is returned, which is smaller than the previously
>> read one, resulting in a non-monotonically increasing idle time. In
>> addition, there are other data race scenarios not listed here.
>>
>> This patch introduce a lock to prevent data races.
>>
>> Fixes: a130e8fbc7de ("fs/proc/uptime.c: Fix idle time reporting in /proc/uptime")
>> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>> ---
>>   kernel/time/tick-sched.c | 15 ++++++++++++++-
>>   kernel/time/tick-sched.h |  1 +
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index b0e3c9205946..ad7d47098a58 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -36,7 +36,9 @@
>>   /*
>>    * Per-CPU nohz control structure
>>    */
>> -static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched);
>> +static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched) = {
>> +	.idle_time_lock = __SPIN_LOCK_UNLOCKED(tick_cpu_sched.idle_time_lock),
>> +};
>>   
>>   struct tick_sched *tick_get_tick_sched(int cpu)
>>   {
>> @@ -661,16 +663,24 @@ update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_upda
>>   
>>   static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
>>   {
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ts->idle_time_lock, flags);
>>   	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
>>   	ts->idle_active = 0;
>> +	spin_unlock_irqrestore(&ts->idle_time_lock, flags);
>>   
>>   	sched_clock_idle_wakeup_event();
>>   }
>>   
>>   static void tick_nohz_start_idle(struct tick_sched *ts)
>>   {
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ts->idle_time_lock, flags);
>>   	ts->idle_entrytime = ktime_get();
>>   	ts->idle_active = 1;
>> +	spin_unlock_irqrestore(&ts->idle_time_lock, flags);
>>   	sched_clock_idle_sleep_event();
>>   }
>>   
>> @@ -691,12 +701,14 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
>>   u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
>>   {
>>   	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
>> +	unsigned long flags;
>>   	ktime_t now, idle;
>>   
>>   	if (!tick_nohz_active)
>>   		return -1;
>>   
>>   	now = ktime_get();
>> +	spin_lock_irqsave(&ts->idle_time_lock, flags);
>>   	if (last_update_time) {
>>   		update_ts_time_stats(cpu, ts, now, last_update_time);
>>   		idle = ts->idle_sleeptime;
>> @@ -709,6 +721,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
>>   			idle = ts->idle_sleeptime;
>>   		}
>>   	}
>> +	spin_unlock_irqrestore(&ts->idle_time_lock, flags);
>>   
>>   	return ktime_to_us(idle);
>>   
>> diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
>> index 504649513399..a64d4781e7af 100644
>> --- a/kernel/time/tick-sched.h
>> +++ b/kernel/time/tick-sched.h
>> @@ -81,6 +81,7 @@ struct tick_sched {
>>   	atomic_t			tick_dep_mask;
>>   	unsigned long			last_tick_jiffies;
>>   	unsigned int			stalled_jiffies;
>> +	spinlock_t			idle_time_lock;
>>   };
>>   
>>   extern struct tick_sched *tick_get_tick_sched(int cpu);
> 
> Thank you for the patch RFC.
> 
> I can confirm that v6.2-rc7 still exhibits the issue:
> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds/tools/testing/selftests/proc$ while true; do ./proc-uptime-001; done
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> ^C
> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds/tools/testing/selftests/proc$ uname -rms
> Linux 6.2.0-rc7-mglru-kmemlk x86_64
> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds/tools/testing/selftests/proc$
> 
> Your patch, however, apparently fixes the problem.
> 
> Rebooting with the patched kernel eliminates the Assertion above, on the same hardware platform.
> 
> All the programs in the tools/testing/seltest/proc now appear to pass the test:
> 
> make[2]: Entering directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc'
> TAP version 13
> 1..21
> # selftests: proc: fd-001-lookup
> ok 1 selftests: proc: fd-001-lookup
> # selftests: proc: fd-002-posix-eq
> ok 2 selftests: proc: fd-002-posix-eq
> # selftests: proc: fd-003-kthread
> ok 3 selftests: proc: fd-003-kthread
> # selftests: proc: proc-loadavg-001
> ok 4 selftests: proc: proc-loadavg-001
> # selftests: proc: proc-empty-vm
> ok 5 selftests: proc: proc-empty-vm
> # selftests: proc: proc-pid-vm
> ok 6 selftests: proc: proc-pid-vm
> # selftests: proc: proc-self-map-files-001
> ok 7 selftests: proc: proc-self-map-files-001
> # selftests: proc: proc-self-map-files-002
> ok 8 selftests: proc: proc-self-map-files-002
> # selftests: proc: proc-self-syscall
> ok 9 selftests: proc: proc-self-syscall
> # selftests: proc: proc-self-wchan
> ok 10 selftests: proc: proc-self-wchan
> # selftests: proc: proc-subset-pid
> ok 11 selftests: proc: proc-subset-pid
> # selftests: proc: proc-tid0
> ok 12 selftests: proc: proc-tid0
> # selftests: proc: proc-uptime-001
> ok 13 selftests: proc: proc-uptime-001
> # selftests: proc: proc-uptime-002
> ok 14 selftests: proc: proc-uptime-002
> # selftests: proc: read
> ok 15 selftests: proc: read
> # selftests: proc: self
> ok 16 selftests: proc: self
> # selftests: proc: setns-dcache
> ok 17 selftests: proc: setns-dcache
> # selftests: proc: setns-sysvipc
> ok 18 selftests: proc: setns-sysvipc
> # selftests: proc: thread-self
> ok 19 selftests: proc: thread-self
> # selftests: proc: proc-multiple-procfs
> ok 20 selftests: proc: proc-multiple-procfs
> # selftests: proc: proc-fsconfig-hidepid
> ok 21 selftests: proc: proc-fsconfig-hidepid
> make[2]: Leaving directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc'
> 
> What was applied was:
> 
> # git diff
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index b0e3c9205946..ad7d47098a58 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -36,7 +36,9 @@
>   /*
>    * Per-CPU nohz control structure
>    */
> -static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched);
> +static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched) = {
> +       .idle_time_lock = __SPIN_LOCK_UNLOCKED(tick_cpu_sched.idle_time_lock),
> +};
>   
>   struct tick_sched *tick_get_tick_sched(int cpu)
>   {
> @@ -661,16 +663,24 @@ update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_upda
>   
>   static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
>   {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ts->idle_time_lock, flags);
>          update_ts_time_stats(smp_processor_id(), ts, now, NULL);
>          ts->idle_active = 0;
> +       spin_unlock_irqrestore(&ts->idle_time_lock, flags);
>   
>          sched_clock_idle_wakeup_event();
>   }
>   
>   static void tick_nohz_start_idle(struct tick_sched *ts)
>   {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ts->idle_time_lock, flags);
>          ts->idle_entrytime = ktime_get();
>          ts->idle_active = 1;
> +       spin_unlock_irqrestore(&ts->idle_time_lock, flags);
>          sched_clock_idle_sleep_event();
>   }
>   
> @@ -691,12 +701,14 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
>   u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
>   {
>          struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
> +       unsigned long flags;
>          ktime_t now, idle;
>   
>          if (!tick_nohz_active)
>                  return -1;
>   
>          now = ktime_get();
> +       spin_lock_irqsave(&ts->idle_time_lock, flags);
>          if (last_update_time) {
>                  update_ts_time_stats(cpu, ts, now, last_update_time);
>                  idle = ts->idle_sleeptime;
> @@ -709,6 +721,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
>                          idle = ts->idle_sleeptime;
>                  }
>          }
> +       spin_unlock_irqrestore(&ts->idle_time_lock, flags);
>   
>          return ktime_to_us(idle);
>   
> diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> index 504649513399..a64d4781e7af 100644
> --- a/kernel/time/tick-sched.h
> +++ b/kernel/time/tick-sched.h
> @@ -81,6 +81,7 @@ struct tick_sched {
>          atomic_t                        tick_dep_mask;
>          unsigned long                   last_tick_jiffies;
>          unsigned int                    stalled_jiffies;
> +       spinlock_t                      idle_time_lock;
>   };
>   
>   extern struct tick_sched *tick_get_tick_sched(int cpu);
> 
> 
> Feel free to add: Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

P.S.

The fact that it works for me didn't take into account the kernel test robot result
I overlooked, which makes my test irrelevant.

Thanks,

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

