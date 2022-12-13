Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691264AE17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiLMDNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLMDNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:13:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6E17A9E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:13:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 17so6755273pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpAOui2sBIeclLSg7JXbRXlM9G60c+NnibPKBiGvktE=;
        b=AdxEo8dzn8SoncOBPvxPQ77rnT1Jj8695vFFH6ohWlVpomztnMCuuTwvEX9w2CCV7Y
         5qft8IHBIzKRbH1THaGRW6BuKFDpwQmXMnY12WjAqJUM3vVDe60N2iB0APN44wABaPfH
         /ntz2VobNaJ3l1UAmSVUD9W2Ssyuorfa1b3UYtaSIX076d6QcRIYm0IEv29kt8tPa6xL
         0jR8fJZqlooZc8bdzcAGvEZIWuHn6QqgUkmU0QiNxb8Qei/QXES5JWNMeELhoZllxIYx
         UKKfidZ0NjizZE3kNGHbJt5T/j/w/Io+jonPEg47Lobt6hECZljpVnZrZq9/IU2uGz5u
         FfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpAOui2sBIeclLSg7JXbRXlM9G60c+NnibPKBiGvktE=;
        b=3GjD4Mik3tFA9FkHrPRA98HfBxPpezUBhfZU55MIBzn0OM4UPX06bRz+iarB99jBJV
         pYkEtmWDU7YuNUZNI/ZVyPp6U++oUkgw2oj/wEQ0a7wc5KorjTlX8008R1PHOVubL0Xo
         cqefQrEYFSw0oO7bKcFqxEld19P/tIuJh5ZJFcPlqoCM9bD8J7ats7duGFJGku8oxZ0I
         vp4jYLWq4+ve0bDCqnNBcxHFdHX6zt+IQWZqqJRaueTB4bImcN0sGcq3YN2cMEtgHwHm
         M5V6LxcFbBynSbM6CJK+BD6rtUNc6vcS/wvUbGWbD8Dke2Qf0GzcGmclPyatZRPcyEJR
         psqg==
X-Gm-Message-State: ANoB5pmqf6GGmCeFLbEsN3RgIrFbb0Un0uGOXMeLb10NYxEG9wHdUOVO
        j37H+2aZtwZnPR4g3PkdpT2WwQ==
X-Google-Smtp-Source: AA0mqf72y/RE7h9av1l7KZXSo+hv6Q8OS0SnifkAlMyX4BmZUh5KZrcG+TL9WK1vuJa48Z4KMefv4A==
X-Received: by 2002:a17:902:e550:b0:185:441e:2d91 with SMTP id n16-20020a170902e55000b00185441e2d91mr27355216plf.40.1670901209331;
        Mon, 12 Dec 2022 19:13:29 -0800 (PST)
Received: from [10.255.250.54] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm7142541plg.202.2022.12.12.19.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:13:28 -0800 (PST)
Message-ID: <11222824-9a23-0766-70f3-709ab2fc6cc0@bytedance.com>
Date:   Tue, 13 Dec 2022 11:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: [PATCH] sched: Reduce rq lock contention in load_balance()
To:     Abel Wu <wuyun.abel@bytedance.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
 <c086b5fb-681e-d104-1e11-873ed5444c5c@bytedance.com>
From:   chenying <chenying.kernel@bytedance.com>
In-Reply-To: <c086b5fb-681e-d104-1e11-873ed5444c5c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenying <chenying.kernel@bytedance.com>

When doing newidle load balancing, we may have lock contention on rq->lock
while finding the same busiest rq on multiple cpus. However, it is often
the case that after the first load balancing, the busiest-rq may not be the
busiest anymore. This may lead to pointless waits for locks.

Add rq->balancing to quickly check if the busiest rq has been selected
in load_balance on other cpu. If it has been selected, clear the busiest 
rq's
cpu from load_balance_mask and then goto refind.

The test results show that this patch brings ~30% rq lock contentions
reduced and no scheduling latency degradation.

unpatched:
lock_stat version 0.4
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                               class name    con-bounces    contentions 
   waittime-min   waittime-max waittime-total   waittime-avg 
acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total 
   holdtime-avg
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                &rq->lock:         25532          26471 
           0.09          22.86       42250.81           1.60 
1232063        6586225           0.05          40.54    10280028.19 
       1.56
                                ---------
                                &rq->lock           1310 
[<0000000081600630>] __schedule+0xa9/0x800
                                &rq->lock           1430 
[<00000000754f510d>] try_to_wake_up+0x206/0x710
                                &rq->lock          15426 
[<0000000020af4cb5>] update_blocked_averages+0x30/0x6f0
                                &rq->lock           1449 
[<00000000dc949053>] _nohz_idle_balance+0x116/0x250
                                ---------
                                &rq->lock           3329 
[<00000000754f510d>] try_to_wake_up+0x206/0x710
                                &rq->lock           1241 
[<0000000081600630>] __schedule+0xa9/0x800
                                &rq->lock          15480 
[<0000000020af4cb5>] update_blocked_averages+0x30/0x6f0
                                &rq->lock           5333 
[<000000004969102f>] load_balance+0x3b7/0xe40

patched:
lock_stat version 0.4
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                               class name    con-bounces    contentions 
   waittime-min   waittime-max waittime-total   waittime-avg 
acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total 
   holdtime-avg
.............................................................................................................................................................................................................................

                                &rq->lock:         17497          18300 
           0.09          23.15       32152.22           1.76 
1137409        6484176           0.05          40.19    10125220.60 
       1.56
                                ---------
                                &rq->lock          12298 
[<000000004314e22f>] update_blocked_averages+0x30/0x6f0
                                &rq->lock           1005 
[<000000005b222b90>] __schedule+0xa9/0x800
                                &rq->lock           1271 
[<00000000c7a66a89>] try_to_wake_up+0x206/0x710
                                &rq->lock           1380 
[<00000000eac23b6b>] load_balance+0x560/0xe70
                                ---------
                                &rq->lock           2962 
[<00000000c7a66a89>] try_to_wake_up+0x206/0x710
                                &rq->lock          11844 
[<000000004314e22f>] update_blocked_averages+0x30/0x6f0
                                &rq->lock            592 
[<0000000032421516>] scheduler_tick+0x4f/0xf0
                                &rq->lock           1243 
[<000000005b222b90>] __schedule+0xa9/0x800

unpatched:
  # ./runqlat 60 1

     usecs               : count     distribution
          0 -> 1          : 1172     | 
       |
          2 -> 3          : 210063   |************************ 
       |
          4 -> 7          : 337576 
|****************************************|
          8 -> 15         : 24555    |** 
       |
         16 -> 31         : 13598    |* 
       |
         32 -> 63         : 779      | 
       |
         64 -> 127        : 230      | 
       |
        128 -> 255        : 83       | 
       |
        256 -> 511        : 54       | 
       |
        512 -> 1023       : 62       | 
       |
       1024 -> 2047       : 123      | 
       |
       2048 -> 4095       : 283      | 
       |
       4096 -> 8191       : 1362     | 
       |
       8192 -> 16383      : 2775     | 
       |
      16384 -> 32767      : 52352    |****** 
       |
      32768 -> 65535      : 14       | 
       |
      65536 -> 131071     : 140      | 
       |

  patched:
  # ./runqlat 60 1

      usecs               : count     distribution
          0 -> 1          : 1091     | 
       |
          2 -> 3          : 205259   |*********************** 
       |
          4 -> 7          : 351620 
|****************************************|
          8 -> 15         : 27812    |*** 
       |
         16 -> 31         : 13971    |* 
       |
         32 -> 63         : 727      | 
       |
         64 -> 127        : 198      | 
       |
        128 -> 255        : 103      | 
       |
        256 -> 511        : 61       | 
       |
        512 -> 1023       : 45       | 
       |
       1024 -> 2047       : 108      | 
       |
       2048 -> 4095       : 271      | 
       |
       4096 -> 8191       : 1342     | 
       |
       8192 -> 16383      : 2732     | 
       |
      16384 -> 32767      : 49367    |***** 
       |
      32768 -> 65535      : 8        | 
       |
      65536 -> 131071     : 183      | 
       |

Below is the script to run the sysbench workload:

         #!/bin/bash

         mkdir /sys/fs/cgroup/cpuset/test1
         echo 12,14,16,18,20,22 > /sys/fs/cgroup/cpuset/test1/cpuset.cpus
         echo 0 > /sys/fs/cgroup/cpuset/test1/cpuset.mems

         mkdir /sys/fs/cgroup/cpuset/test2
         echo 
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46 > 
/sys/fs/cgroup/cpuset/test2/cpuset.cpus
         echo 0 > /sys/fs/cgroup/cpuset/test2/cpuset.mems

         cgexec -g cpuset:test1 sysbench --test=cpu 
--cpu-max-prime=200000 run --num-threads=24 --rate=100 --time=6000 &
         cgexec -g cpuset:test2 sysbench --test=cpu 
--cpu-max-prime=200000 run --num-threads=96 --rate=100 --time=6000 &

Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: chenying <chenying.kernel@bytedance.com>
---
  kernel/sched/core.c  |  1 +
  kernel/sched/fair.c  | 11 +++++++++++
  kernel/sched/sched.h |  1 +
  3 files changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..ca4fa84c8751 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9737,6 +9737,7 @@ void __init sched_init(void)
                 rq->rd = NULL;
                 rq->cpu_capacity = rq->cpu_capacity_orig = 
SCHED_CAPACITY_SCALE;
                 rq->balance_callback = &balance_push_callback;
+               rq->balancing = false;
                 rq->active_balance = 0;
                 rq->next_balance = jiffies;
                 rq->push_cpu = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..aeb4fa9ac93a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10295,6 +10295,7 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,
                 goto out_balanced;
         }

+refind:
         busiest = find_busiest_queue(&env, group);
         if (!busiest) {
                 schedstat_inc(sd->lb_nobusyq[idle]);
@@ -10303,6 +10304,14 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,

         WARN_ON_ONCE(busiest == env.dst_rq);

+       if (READ_ONCE(busiest->balancing)) {
+               __cpumask_clear_cpu(cpu_of(busiest), cpus);
+               if (cpumask_intersects(sched_group_span(group), cpus))
+                       goto refind;
+
+               goto out_balanced;
+       }
+
         schedstat_add(sd->lb_imbalance[idle], env.imbalance);

         env.src_cpu = busiest->cpu;
@@ -10323,6 +10332,7 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,
  more_balance:
                 rq_lock_irqsave(busiest, &rf);
                 update_rq_clock(busiest);
+               WRITE_ONCE(busiest->balancing, true);

                 /*
                  * cur_ld_moved - load moved in current iteration
@@ -10338,6 +10348,7 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,
                  * See task_rq_lock() family for the details.
                  */

+               WRITE_ONCE(busiest->balancing, false);
                 rq_unlock(busiest, &rf);

                 if (cur_ld_moved) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..6730808a0ab8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1044,6 +1044,7 @@ struct rq {

         struct balance_callback *balance_callback;

+       unsigned char           balancing;
         unsigned char           nohz_idle_balance;
         unsigned char           idle_balance;

--
2.11.0

