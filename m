Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B995B64E7AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLPHXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPHXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:23:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9FB396D9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:23:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so5205605pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+53BnfeYu1ORvpQ//JGkVrjwsAc5oI+mHD+wDYntMik=;
        b=o1pRfqS0yLNASTSFuakIkUrqkFG/IwkHZEAg+4UNQMSjyzFK/1NuQrN0rfDKHb011B
         DoWccbEZDF6TeI3sTTeittOwHa0k+agGwcGICuBauR7ueJYMKrY8Q9KmiqMnE/OMQnZr
         SrG3xW3Udj4zjutl1vPM0J0qC23w4icl0bg+J34lomr9uuxpPd03bm0E69eptlLNEb4Y
         VkR3V6McmjnjiCiGzNPgcK6nzODaWz27u5M4ittOEhu5zXF+/Z6NB8Q7wm8bQCmiFGXc
         Rxh8o11q+aWCfVjYoq47iujWXcirm6kjpSwehx9ZfB8fk6IFFRVlfrKQb7btdOu2NOt+
         ff5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+53BnfeYu1ORvpQ//JGkVrjwsAc5oI+mHD+wDYntMik=;
        b=O/y2X1eHCCFx0roIeOO5qIXqMajn/OuHC+HnXKl4QmUz0j4HbSNvFLCSYalQ24iD8P
         KrCzSmLaiZ5ABN6vVYjNDcW2bmBd7DcXrvWVj+M63MhNCNcQLtct7nXkHCIsG+9NY+h9
         zbAxjLWUYn36QDleErgCgTSycRjrUA3Cp3R7xAz0ir70Mbqfd2pnMyMyhKVU28IsBrBJ
         0ZUtxqFtMPNhcDC7DgGxorYToBIjDXOiEJ1Ph/nD3dvVcDjnTL8HV1ZIg0YCv+2nQzYE
         yvPHc823gP2XUzT1WyYhoUhoDpoCOv9A3/k3mONdFgFcUxTzV7l2PU7DNC2+gCWVU1iT
         Ohjw==
X-Gm-Message-State: AFqh2kpBzn3gxjo+F5RMhOD2zamWgsVbuH5aiu+cZb6eOiB/ks0kYkyO
        a0FWLYwUbFT3nev34DXTAH6O3w==
X-Google-Smtp-Source: AMrXdXu5JKTm3+WKdHWVob1wFxQjySX/1lItv+d0q297oKmV/hYn9Jc4shfOXgbiNrH7R3sx3qMBXQ==
X-Received: by 2002:a17:903:285:b0:191:3c6:1748 with SMTP id j5-20020a170903028500b0019103c61748mr904475plr.11.1671175429616;
        Thu, 15 Dec 2022 23:23:49 -0800 (PST)
Received: from [10.255.23.40] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001894dc5fdf2sm815207pls.296.2022.12.15.23.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 23:23:48 -0800 (PST)
Message-ID: <6c87eead-9235-757a-ad8e-b992fbe783ab@bytedance.com>
Date:   Fri, 16 Dec 2022 15:23:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] sched: Reduce rq lock contention in load_balance()
To:     Chen Yu <yu.c.chen@intel.com>,
        chenying <chenying.kernel@bytedance.com>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
 <c086b5fb-681e-d104-1e11-873ed5444c5c@bytedance.com>
 <11222824-9a23-0766-70f3-709ab2fc6cc0@bytedance.com>
 <Y5ijqxqKPVxLebkh@chenyu5-mobl1>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Y5ijqxqKPVxLebkh@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen, thanks for reviewing!

On 12/14/22 12:09 AM, Chen Yu wrote:
> On 2022-12-13 at 11:13:24 +0800, chenying wrote:
>> From: chenying <chenying.kernel@bytedance.com>
>>
>> When doing newidle load balancing, we may have lock contention on rq->lock
>> while finding the same busiest rq on multiple cpus. However, it is often
>> the case that after the first load balancing, the busiest-rq may not be the
>> busiest anymore. This may lead to pointless waits for locks.
>>
>> Add rq->balancing to quickly check if the busiest rq has been selected
>> in load_balance on other cpu. If it has been selected, clear the busiest
>> rq's
>> cpu from load_balance_mask and then goto refind.
>>
>> The test results show that this patch brings ~30% rq lock contentions
>> reduced and no scheduling latency degradation.
>>
>> unpatched:
>> lock_stat version 0.4
>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>                                class name    con-bounces    contentions
>> waittime-min   waittime-max waittime-total   waittime-avg acq-bounces
>> acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>
>>                                 &rq->lock:         25532          26471
>> 0.09          22.86       42250.81           1.60 1232063        6586225
>> 0.05          40.54    10280028.19       1.56
>>                                 ---------
>>                                 &rq->lock           1310 [<0000000081600630>]
>> __schedule+0xa9/0x800
>>                                 &rq->lock           1430 [<00000000754f510d>]
>> try_to_wake_up+0x206/0x710
>>                                 &rq->lock          15426 [<0000000020af4cb5>]
>> update_blocked_averages+0x30/0x6f0
>>                                 &rq->lock           1449 [<00000000dc949053>]
>> _nohz_idle_balance+0x116/0x250
>>                                 ---------
>>                                 &rq->lock           3329 [<00000000754f510d>]
>> try_to_wake_up+0x206/0x710
>>                                 &rq->lock           1241 [<0000000081600630>]
>> __schedule+0xa9/0x800
>>                                 &rq->lock          15480 [<0000000020af4cb5>]
>> update_blocked_averages+0x30/0x6f0
>>                                 &rq->lock           5333 [<000000004969102f>]
>> load_balance+0x3b7/0xe40
>>
> Does the scenario above indicate that one CPU is trying to grab the rq lock
> in either __schedule or try_to_wake_up or update_blocked_averages or
> _nohz_idle_balance.
> but it could be grabbed by another CPU at load_balance+0x3b7/0xe40,
> and this patch is trying to avoid grabbing the rq lock in load_balance()
> as much as possible?

Pretty much, and there can be other concern. The chosen busiest
cpu can be the src_cpu of multiple other cpus at same time, which
can lead to over pulling from the busiest cpu.

> And it seems that update_blocked_averages is quite contended too.

Yes indeed, since newidle_balance() is one of its callers.

>> patched:
>> lock_stat version 0.4
>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>                                class name    con-bounces    contentions
>> waittime-min   waittime-max waittime-total   waittime-avg acq-bounces
>> acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>> .............................................................................................................................................................................................................................
>>
>>                                 &rq->lock:         17497          18300
>> 0.09          23.15       32152.22           1.76 1137409        6484176
>> 0.05          40.19    10125220.60       1.56
>>                                 ---------
>>                                 &rq->lock          12298 [<000000004314e22f>]
>> update_blocked_averages+0x30/0x6f0
>>                                 &rq->lock           1005 [<000000005b222b90>]
>> __schedule+0xa9/0x800
>>                                 &rq->lock           1271 [<00000000c7a66a89>]
>> try_to_wake_up+0x206/0x710
>>                                 &rq->lock           1380 [<00000000eac23b6b>]
>> load_balance+0x560/0xe70
>>                                 ---------
>>                                 &rq->lock           2962 [<00000000c7a66a89>]
>> try_to_wake_up+0x206/0x710
>>                                 &rq->lock          11844 [<000000004314e22f>]
>> update_blocked_averages+0x30/0x6f0
>>                                 &rq->lock            592 [<0000000032421516>]
>> scheduler_tick+0x4f/0xf0
>>                                 &rq->lock           1243 [<000000005b222b90>]
>> __schedule+0xa9/0x800
>>
>> unpatched:
>>   # ./runqlat 60 1
>>
>>      usecs               : count     distribution
>>           0 -> 1          : 1172     |       |
>>           2 -> 3          : 210063   |************************       |
>>           4 -> 7          : 337576 |****************************************|
>>           8 -> 15         : 24555    |**       |
>>          16 -> 31         : 13598    |*       |
>>          32 -> 63         : 779      |       |
>>          64 -> 127        : 230      |       |
>>         128 -> 255        : 83       |       |
>>         256 -> 511        : 54       |       |
>>         512 -> 1023       : 62       |       |
>>        1024 -> 2047       : 123      |       |
>>        2048 -> 4095       : 283      |       |
>>        4096 -> 8191       : 1362     |       |
>>        8192 -> 16383      : 2775     |       |
>>       16384 -> 32767      : 52352    |******       |
>>       32768 -> 65535      : 14       |       |
>>       65536 -> 131071     : 140      |       |
>>
>>   patched:
>>   # ./runqlat 60 1
>>
>>       usecs               : count     distribution
>>           0 -> 1          : 1091     |       |
>>           2 -> 3          : 205259   |***********************       |
>>           4 -> 7          : 351620 |****************************************|
>>           8 -> 15         : 27812    |***       |
>>          16 -> 31         : 13971    |*       |
>>          32 -> 63         : 727      |       |
>>          64 -> 127        : 198      |       |
>>         128 -> 255        : 103      |       |
>>         256 -> 511        : 61       |       |
>>         512 -> 1023       : 45       |       |
>>        1024 -> 2047       : 108      |       |
>>        2048 -> 4095       : 271      |       |
>>        4096 -> 8191       : 1342     |       |
>>        8192 -> 16383      : 2732     |       |
>>       16384 -> 32767      : 49367    |*****       |
>>       32768 -> 65535      : 8        |       |
>>       65536 -> 131071     : 183      |       |
>>
>> Below is the script to run the sysbench workload:
>>
>>          #!/bin/bash
>>
>>          mkdir /sys/fs/cgroup/cpuset/test1
>>          echo 12,14,16,18,20,22 > /sys/fs/cgroup/cpuset/test1/cpuset.cpus
>>          echo 0 > /sys/fs/cgroup/cpuset/test1/cpuset.mems
>>
>>          mkdir /sys/fs/cgroup/cpuset/test2
>>          echo
>> 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46 >
>> /sys/fs/cgroup/cpuset/test2/cpuset.cpus
>>          echo 0 > /sys/fs/cgroup/cpuset/test2/cpuset.mems
>>
>>          cgexec -g cpuset:test1 sysbench --test=cpu --cpu-max-prime=200000
>> run --num-threads=24 --rate=100 --time=6000 &
>>          cgexec -g cpuset:test2 sysbench --test=cpu --cpu-max-prime=200000
>> run --num-threads=96 --rate=100 --time=6000 &
>>
> May I know how many CPUs are there in the system, 46 * 2 ? So this test is
> to saturate test1 and idle CPUs in test2 try to continously pull task from test1
> but fail due to affinity, which introduce rq lock contention?

Yeah seems so. Might be better to include some other benchmarks.
I think fast idling workload will benefit from this.

Best,
	Abel

>> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
>> Signed-off-by: chenying <chenying.kernel@bytedance.com>
>> ---
>>   kernel/sched/core.c  |  1 +
>>   kernel/sched/fair.c  | 11 +++++++++++
>>   kernel/sched/sched.h |  1 +
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index daff72f00385..ca4fa84c8751 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9737,6 +9737,7 @@ void __init sched_init(void)
>>                  rq->rd = NULL;
>>                  rq->cpu_capacity = rq->cpu_capacity_orig =
>> SCHED_CAPACITY_SCALE;
>>                  rq->balance_callback = &balance_push_callback;
>> +               rq->balancing = false;
> Maybe rq->balancing = 0 because balancing is not bool.
>>                  rq->active_balance = 0;
>>                  rq->next_balance = jiffies;
>>                  rq->push_cpu = 0;
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..aeb4fa9ac93a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10295,6 +10295,7 @@ static int load_balance(int this_cpu, struct rq
>> *this_rq,
>>                  goto out_balanced;
>>          }
>>
>> +refind:
>>          busiest = find_busiest_queue(&env, group);
>>          if (!busiest) {
>>                  schedstat_inc(sd->lb_nobusyq[idle]);
>> @@ -10303,6 +10304,14 @@ static int load_balance(int this_cpu, struct rq
>> *this_rq,
>>
>>          WARN_ON_ONCE(busiest == env.dst_rq);
>>
>> +       if (READ_ONCE(busiest->balancing)) {
> rq->balancing is not protected by lock so there could be race condition,
> but I think it is ok because this could be a trade-off.
>> +               __cpumask_clear_cpu(cpu_of(busiest), cpus);
>> +               if (cpumask_intersects(sched_group_span(group), cpus))
>> +                       goto refind;
>> +
>> +               goto out_balanced;
>> +       }
>> +
>>          schedstat_add(sd->lb_imbalance[idle], env.imbalance);
>>
>>          env.src_cpu = busiest->cpu;
>> @@ -10323,6 +10332,7 @@ static int load_balance(int this_cpu, struct rq
>> *this_rq,
>>   more_balance:
>>                  rq_lock_irqsave(busiest, &rf);
>>                  update_rq_clock(busiest);
>> +               WRITE_ONCE(busiest->balancing, true);
> 		WRITE_ONCE(busiest->balancing, 1)
>>
>>                  /*
>>                   * cur_ld_moved - load moved in current iteration
>> @@ -10338,6 +10348,7 @@ static int load_balance(int this_cpu, struct rq
>> *this_rq,
>>                   * See task_rq_lock() family for the details.
>>                   */
>>
>> +               WRITE_ONCE(busiest->balancing, false);
> 		WRITE_ONCE(busiest->balancing, 0)
> 
> thanks,
> Chenyu
