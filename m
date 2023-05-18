Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6C70771B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjERBAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERBAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:00:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE183F9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684371598; x=1715907598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFTEdZZ77ZfCpXoUlbcLlgEcs+1h55CyvaWi7viXnAM=;
  b=iXGrXmifUV9Cu5gkjngQKB8oPBcph9nx5LU0kCDTkNiK3VmVQU9OYoM7
   zTzhBBfvDQ7EB6xrDO8dM8bD8hinVonmQdbu3ls1LiRrm6jfXqVx8Rds2
   rar3NF2LMalblMGopZMHqRVrDwoBFE+lPsY44ng7ASspkxCjyUHg5ip9F
   qE+gh+0H4mOnNdmsSre+355sQSOm2DqB6Fdi7j8gYrDOXjpkgmRfyrwPb
   6/Vo2/26qaoSQzLlgAqEkBHu/fLMAMjYE6aHPasq7DL8PYJLdvD0xFuqg
   x1Q/agg6W4auX33GEc9lBjLbnaP6SHjnSESAypLhiaT7oStd3BzPsL2iq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="351942784"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="351942784"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 17:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652439728"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="652439728"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2023 17:59:57 -0700
Date:   Wed, 17 May 2023 18:02:54 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, sudeep.holla@arm.com, yongxuan.wang@sifive.com,
        pierre.gondois@arm.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com, palmer@rivosinc.com, puwen@hygon.cn
Subject: Re: [PATCH 0/2] drivers: base: cacheinfo: Fix shared_cpu_list
 inconsistency in event of CPU hotplug
Message-ID: <20230518010254.GA19915@ranerica-svr.sc.intel.com>
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508084115.1157-1-kprateek.nayak@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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


I was able to reproduce the issue on an Alder Lake system (single socket).
I also was able to verify that the this patchset fixes the issue.

FWIW, Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
