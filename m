Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A496FC9C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjEIPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEIPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:01:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F759210E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:01:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73D8AFEC;
        Tue,  9 May 2023 08:02:40 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58CCF3F663;
        Tue,  9 May 2023 08:01:54 -0700 (PDT)
Date:   Tue, 9 May 2023 16:01:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        rafael@kernel.org, yongxuan.wang@sifive.com,
        pierre.gondois@arm.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com, palmer@rivosinc.com, puwen@hygon.cn
Subject: Re: [PATCH 0/2] drivers: base: cacheinfo: Fix shared_cpu_list
 inconsistency in event of CPU hotplug
Message-ID: <20230509150151.kscbev7qrycz5cqy@bogus>
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508084115.1157-1-kprateek.nayak@amd.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:11:13PM +0530, K Prateek Nayak wrote:
> Since v6.3-rc1, the shared_cpu_list in per-cpu cacheinfo breaks in case
> of hotplug activity on x86. This can be tracked back to two commits:
> 
> o commit 198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared
>   caches at different levels") that matches cache instance IDs without
>   considering if the instance IDs belong to same cache level or not.
> 
> o commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
>   sysfs") which skips calling populate_cache_leaves() if
>   last_level_cache_is_valid(cpu) returns true. populate_cache_leaves()
>   on x86 would have populated the shared_cpu_map when CPU comes online,
>   which is now skipped, and the alternate path has an early bailout
>   before setting the CPU in the shared_cpu_map is even attempted.
> 
>   On x86, populate_cache_leaves() also sets the
>   cpu_cacheinfo->cpu_map_populated flag when the cacheinfo is first
>   populated, the cache_shared_cpu_map_setup() in the driver is bypassed
>   when a thread comes back online during the hotplug activity. This leads
>   to the shared_cpu_list displaying abnormal values for the CPU that was
>   offlined and then onlined since the shared_cpu_maps are never
>   revaluated.
> 
> Following is the output from a dual socket 3rd Generation AMD EPYC
> processor (2 x 64C/128T) for cachinfo when offlining and then onlining
> CPU8:
> 
> o v6.3-rc5 with no changes:
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
> 
>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>   # echo 1 > /sys/devices/system/cpu/cpu8/online
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8
> 
>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>     136
> 
>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>     9-15,136-143
> 
> o v6.3-rc5 with commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
>   through sysfs") reverted (Behavior consistent with v6.2):
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
> 
>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>   # echo 1 > /sys/devices/system/cpu/cpu8/online
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
> 
>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>     8,136
> 
>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>     8-15,136-143
> 
> This is not only limited to AMD processors but affects Intel processors
> too. Following is the output from same experiment on a dual socket Intel
> Ice Lake server (2 x 32C/64T) running kernel v6.3-rc5:
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,
>     26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,
>     88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
> 
>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>   # echo 1 > /sys/devices/system/cpu/cpu8/online
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8
> 
>   # cat /sys/devices/system/cpu/cpu72/cache/index0/shared_cpu_list
>     72
> 
>   # cat /sys/devices/system/cpu/cpu72/cache/index3/shared_cpu_list
>     0,2,4,6,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,
>     66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,
>     120,122,124,126
> 
> This patch addresses two issues associated with building
> shared_cpu_list:
> 
> o Patch 1 fixes an ID matching issue that can lead to cacheinfo
>   associating CPUs from different cache levels in case IDs are not
>   unique across all the different cache levels. 
> 
> o Patch 2 clears the cpu_cacheinfo->cpu_map_populated flag when CPU goes
>   offline and is removed from the shared_cpu_map.
> 
> Following are the results after applying the series on v6.3-rc5 on
> respective x86 platforms:
> 
> o 3rd Generation AMD EPYC Processor (2 x 64C/128T)
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>   
>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>   
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>   
>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>     8,136
>   
>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>     8-15,136-143
> 
> o Intel Ice Lake Xeon (2 x 32C/128T)
> 
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,26,
>     28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,
>     92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
>   
>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>   
>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,26,
>     28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,
>     92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
>   
>   # cat /sys/devices/system/cpu/cpu72/cache/index0/shared_cpu_list
>     8,72
>   
>   # cat /sys/devices/system/cpu/cpu72/cache/index3/shared_cpu_list
>     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,
>     68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,
>     124,126
> 
> Running "grep -r 'cpu_map_populated' arch/" shows MIPS and loongarch too
> set the cpu_cacheinfo->cpu_map_populated who might also be affected by
> the changes in commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
> through sysfs") and this series. Changes from Patch 1 might also affect
> RISC-V since Yong-Xuan Wang <yongxuan.wang@sifive.com> from SiFive last
> made changes to cache_shared_cpu_map_setup() and
> cache_shared_cpu_map_remove() in commit 198102c9103f ("cacheinfo: Fix
> shared_cpu_map to handle shared caches at different levels").

I think they may be affected as well, it is just that it is not caught
in the testing.

Thanks for the detailed explanation and output logs. Not sure how much
time it took you to write but saved lot of time by making it so simple
to understand the exact issue. The changes look good.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Greg,

Can you please pick up these fixes in your next cycle of fixes for v6.4 ?

-- 
Regards,
Sudeep
