Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7051770A600
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjETG4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 02:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjETG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 02:56:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E11AD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 23:56:31 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QNZBp4PkNzqSHN;
        Sat, 20 May 2023 14:52:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 20 May 2023 14:56:26 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <yongxuan.wang@sifive.com>,
        <pierre.gondois@arm.com>, <vincent.chen@sifive.com>,
        <greentime.hu@sifive.com>, <prime.zeng@hisilicon.com>,
        <palmer@rivosinc.com>, <puwen@hygon.cn>
Subject: Re: [PATCH 2/2] drivers: base: cacheinfo: Update cpu_map_populated
 during CPU Hotplug
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
 <20230508084115.1157-3-kprateek.nayak@amd.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <32bd2ca8-30f1-204e-898f-fc93bbdd2e14@huawei.com>
Date:   Sat, 20 May 2023 14:56:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230508084115.1157-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On 2023/5/8 16:41, K Prateek Nayak wrote:
> Until commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
> sysfs"), cacheinfo called populate_cache_leaves() for CPU coming online
> which let the arch specific functions handle (at least on x86)
> populating the shared_cpu_map. However, with the changes in the
> aforementioned commit, populate_cache_leaves() is not called when a CPU
> comes online as a result of hotplug since last_level_cache_is_valid()
> returns true as the cacheinfo data is not discarded. The CPU coming

Yes in free_cache_attributes() we only update the shared_cpu_map but make
other attributes remained. From my feelings we should do all the work
opposite to detect_cache_attributes(), including free the memory allocated.

> online is not present in shared_cpu_map, however, it will not be added
> since the cpu_cacheinfo->cpu_map_populated flag is set (it is set in
> populate_cache_leaves() when cacheinfo is first populated for x86)
> 
> This can lead to inconsistencies in the shared_cpu_map when an offlined
> CPU comes online again. Example below depicts the inconsistency in the
> shared_cpu_list in cacheinfo when CPU8 is offlined and onlined again on
> a 3rd Generation EPYC processor:
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
> Clear the flag when the CPU is removed from shared_cpu_map when
> cache_shared_cpu_map_remove() is called during CPU hotplug. This will
> allow cache_shared_cpu_map_setup() to add the CPU coming back online in
> the shared_cpu_map. Set the flag again when the shared_cpu_map is setup.
> Following are results of performing the same test as described above with
> the changes:
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
> Fixes: 5c2712387d48 ("cacheinfo: Fix LLC is not exported through sysfs")

It's ok for me to have this tag but I don't think this is the root cause,
the commit happens to expose the problem. Other arthitectures like arm64
never updates the this_cpu_ci->cpu_map_populated even after the cpumap is
populated.

> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks for fixing this!

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  drivers/base/cacheinfo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index d1ae443fd7a0..cbae8be1fe52 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -410,11 +410,14 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>  			coherency_max_size = this_leaf->coherency_line_size;
>  	}
>  
> +	/* shared_cpu_map is now populated for the cpu */
> +	this_cpu_ci->cpu_map_populated = true;
>  	return 0;
>  }
>  
>  static void cache_shared_cpu_map_remove(unsigned int cpu)
>  {
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf, *sib_leaf;
>  	unsigned int sibling, index, sib_index;
>  
> @@ -447,6 +450,9 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
>  			}
>  		}
>  	}
> +
> +	/* cpu is no longer populated in the shared map */
> +	this_cpu_ci->cpu_map_populated = false;
>  }
>  
>  static void free_cache_attributes(unsigned int cpu)
> 
