Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344671039F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbjEYEEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjEYEDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:03:40 -0400
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65FE53
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:03:29 -0700 (PDT)
Message-ID: <be04dc3e-a671-ec70-6cf6-70dc702f4184@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684987407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY9F6XP9W54uyc2pLmcaqEZDVFiSzX+vgdndjumDa+0=;
        b=URhEF9BtgHMdP6CTiwSydQ5X3SqJqaxism3G2uIkjvsQNNUQdnSjW2Q12/a2aIYKCborlO
        acEtf+ig27oLn7m2/l3t9q6xkKgEnUVEOAE9JhYIRZT1QlXOSOj0ceIFQuYeI5qJPqs517
        n2n/ra5YTs0UUkjyzJb051zxPljx8JA=
Date:   Thu, 25 May 2023 12:03:16 +0800
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
To:     RCU <rcu@vger.kernel.org>, Yujie Liu <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Kirill Tkhai <tkhai@ya.ru>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202305230837.db2c233f-yujie.liu@intel.com>
 <eba38fce-2454-d7a4-10ef-240b4686f23d@linux.dev>
 <ZG29ULGNJdErnatI@yujie-X299>
 <896bbb09-d400-ec73-ba3a-b64c6e9bbe46@linux.dev>
 <e5fb8b34-c1ad-92e0-e7e5-f7ed1605dbc6@linux.dev>
 <bfb36563-fac9-4c84-96db-87dd28892088@linux.dev>
In-Reply-To: <bfb36563-fac9-4c84-96db-87dd28892088@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 19:56, Qi Zheng wrote:
> 
> 
> On 2023/5/24 19:08, Qi Zheng wrote:
> 
> [...]
> 
>>
>> Well, I just ran the following command and reproduced the result:
>>
>> stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &
>>
>> 1) with commit 42c9db3970483:
>>
>> stress-ng: info:  [11023] setting to a 60 second run per stressor
>> stress-ng: info:  [11023] dispatching hogs: 9 ramfs
>> stress-ng: info:  [11023] stressor       bogo ops real time  usr time 
>> sys time   bogo ops/s     bogo ops/s
>> stress-ng: info:  [11023]                           (secs)    (secs) 
>> (secs)   (real time) (usr+sys time)
>> stress-ng: info:  [11023] ramfs            774966     60.00     10.18 
>> 169.45     12915.89        4314.26
>> stress-ng: info:  [11023] for a 60.00s run time:
>> stress-ng: info:  [11023]    1920.11s available CPU time
>> stress-ng: info:  [11023]      10.18s user time   (  0.53%)
>> stress-ng: info:  [11023]     169.44s system time (  8.82%)
>> stress-ng: info:  [11023]     179.62s total time  (  9.35%)
>> stress-ng: info:  [11023] load average: 8.99 2.69 0.93
>> stress-ng: info:  [11023] successful run completed in 60.00s (1 min, 
>> 0.00 secs)
>>
>> 2) with commit f95bdb700bc6b:
>>
>> stress-ng: info:  [37676] dispatching hogs: 9 ramfs
>> stress-ng: info:  [37676] stressor       bogo ops real time  usr time 
>> sys time   bogo ops/s     bogo ops/s
>> stress-ng: info:  [37676]                           (secs)    (secs) 
>> (secs)   (real time) (usr+sys time)
>> stress-ng: info:  [37676] ramfs            168673     60.00      1.61 
>>   39.66      2811.08        4087.47
>> stress-ng: info:  [37676] for a 60.10s run time:
>> stress-ng: info:  [37676]    1923.36s available CPU time
>> stress-ng: info:  [37676]       1.60s user time   (  0.08%)
>> stress-ng: info:  [37676]      39.66s system time (  2.06%)
>> stress-ng: info:  [37676]      41.26s total time  (  2.15%)
>> stress-ng: info:  [37676] load average: 7.69 3.63 2.36
>> stress-ng: info:  [37676] successful run completed in 60.10s (1 min, 
>> 0.10 secs)
>>
>> The bogo ops/s (real time) did drop significantly.
>>
>> And the memory reclaimation was not triggered in the whole process. so
>> theoretically no one is in the read critical section of shrinker_srcu.
>>
>> Then I found that some stress-ng-ramfs processes were in
>> TASK_UNINTERRUPTIBLE state for a long time:
>>
>> root       42313  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42314  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42315  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42316  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42317  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42318  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42319  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42320  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42321  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42322  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42323  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42324  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42325  7.8  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42326  0.0  0.0  69592  2068 pts/0    S    19:00   0:00 
>> stress-ng-ramfs [run]
>> root       42327  7.9  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42328  7.9  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42329  7.9  0.0  69592  1812 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>> root       42330  7.9  0.0  69592  1556 pts/0    D    19:00   0:02 
>> stress-ng-ramfs [run]
>>
>> Their call stack is as follows:
>>
>> cat /proc/42330/stack
>>
>> [<0>] __synchronize_srcu.part.21+0x83/0xb0
>> [<0>] unregister_shrinker+0x85/0xb0
>> [<0>] deactivate_locked_super+0x27/0x70
>> [<0>] cleanup_mnt+0xb8/0x140
>> [<0>] task_work_run+0x65/0x90
>> [<0>] exit_to_user_mode_prepare+0x1ba/0x1c0
>> [<0>] syscall_exit_to_user_mode+0x1b/0x40
>> [<0>] do_syscall_64+0x44/0x80
>> [<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> + RCU folks, Is this result as expected? I would have thought that
>> synchronize_srcu() should return quickly if no one is in the read
>> critical section. :(
>>
> 
> With the following changes, ops/s can return to previous levels:

Or just set rcu_expedited to 1:
	echo 1 > /sys/kernel/rcu_expedited

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index db2ed6e08f67..90f541b07cd1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -763,7 +763,7 @@ void unregister_shrinker(struct shrinker *shrinker)
>          debugfs_entry = shrinker_debugfs_remove(shrinker);
>          up_write(&shrinker_rwsem);
> 
> -       synchronize_srcu(&shrinker_srcu);
> +       synchronize_srcu_expedited(&shrinker_srcu);
> 
>          debugfs_remove_recursive(debugfs_entry);
> 
> stress-ng: info:  [13159] dispatching hogs: 9 ramfs
> stress-ng: info:  [13159] stressor       bogo ops real time  usr time 
> sys time   bogo ops/s     bogo ops/s
> stress-ng: info:  [13159]                           (secs)    (secs) 
> (secs)   (real time) (usr+sys time)
> stress-ng: info:  [13159] ramfs            710062     60.00      9.63 
> 157.26     11834.18        4254.75
> stress-ng: info:  [13159] for a 60.00s run time:
> stress-ng: info:  [13159]    1920.14s available CPU time
> stress-ng: info:  [13159]       9.62s user time   (  0.50%)
> stress-ng: info:  [13159]     157.26s system time (  8.19%)
> stress-ng: info:  [13159]     166.88s total time  (  8.69%)
> stress-ng: info:  [13159] load average: 9.49 4.02 1.65
> stress-ng: info:  [13159] successful run completed in 60.00s (1 min, 
> 0.00 secs)
> 
> Can we make synchronize_srcu() call synchronize_srcu_expedited() when no
> one is in the read critical section?
> 
>>
> 

-- 
Thanks,
Qi
