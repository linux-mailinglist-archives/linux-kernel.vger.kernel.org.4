Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F065F565E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJEO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJEO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:26:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969FC4F6B5;
        Wed,  5 Oct 2022 07:26:36 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1og5Lx-0004qz-Ei; Wed, 05 Oct 2022 16:26:29 +0200
Message-ID: <93eb2474-077f-2714-ccfb-77ff1a29a926@leemhuis.info>
Date:   Wed, 5 Oct 2022 16:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-hwmon@vger.kernel.org
References: <20220922101036.87457-1-janusz.krzysztofik@linux.intel.com>
 <1f4899d2-52ed-ae94-f681-3953c82b4799@arm.com>
 <3185079.N7aMVyhfb1@jkrzyszt-mobl1.ger.corp.intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [core-for-CI][PATCH] iommu: Remove iova cpu hotplugging flushing
In-Reply-To: <3185079.N7aMVyhfb1@jkrzyszt-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664979996;29580abf;
X-HE-SMSGID: 1og5Lx-0004qz-Ei
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding the coretemp maintainer (Fenghua Yu) and the appropriate mailing
list to the list of recipients, as there apparently is a coretemp bug
that results in a iommu change causing a regression]

On 30.09.22 18:57, Janusz Krzysztofik wrote:
> I think this issue can hit any user with a platform that loads iommu and 
> coretemp drivers.  Adding regressions@lists.linux.dev to the loop.

f598a497bc7d was merged for 5.13-rc1, which is quite a while ago, so at
least a quick revert is out of question as it might do more harm than
good. The authors of the commit are kinda responsible for fixing
situations like this; but well, did anybody ask the developers of the
coretemp driver kindly if they are aware of the problem and maybe even
willing to fix it? Doesn't look like it from here from search lore (hope
I didn't miss anything), so let's give it a try.

Ciao, Thorsten

> On Thursday, 22 September 2022 14:09:35 CEST Robin Murphy wrote:
>> On 22/09/2022 11:10 am, Janusz Krzysztofik wrote:
>>> From: Chris Wilson <chris@chris-wilson.co.uk>
>>>
>>> Manual revert of commit f598a497bc7d ("iova: Add CPU hotplug handler to
>>> flush rcaches").  It is trying to instantiate a cpuhp notifier from inside
>>> a cpuhp callback.  That code replaced intel_iommu implementation of
>>> flushing per-IOVA domain CPU rcaches which used a single instance of cpuhp
>>> held for the module lifetime.
>>
>> OK, *now* I see what's going on. It doesn't seem unreasonable to me for 
>> bus notifiers to touch CPU hotplug - what seems more unexpected is the 
>> coretemp driver creating and adding a platform device from inside a 
>> hotplug callback.
>>
>> Once we start trying to revert multiple unrelated bits of important 
>> functionality from other subsystems because one driver is doing a weird 
>> thing, maybe it's time to instead question whether that driver should be 
>> doing a weird thing?
>>
>> Thanks,
>> Robin.
>>
>>> <4>[    6.928112] ======================================================
>>> <4>[    6.928621] WARNING: possible circular locking dependency detected
>>> <4>[    6.929225] 6.0.0-rc6-CI_DRM_12164-ga1f63e144e54+ #1 Not tainted
>>> <4>[    6.929818] ------------------------------------------------------
>>> <4>[    6.930415] cpuhp/0/15 is trying to acquire lock:
>>> <4>[    6.931011] ffff888100e02a78 (&(&priv->bus_notifier)->rwsem){++++}-
> {3:3}, at: blocking_notifier_call_chain+0x20/0x50
>>> <4>[    6.931533]
>>>                    but task is already holding lock:
>>> <4>[    6.931534] ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
> cpuhp_thread_fun+0x48/0x1f0
>>> <4>[    6.933069]
>>>                    which lock already depends on the new lock.
>>>
>>> <4>[    6.933070]
>>>                    the existing dependency chain (in reverse order) is:
>>> <4>[    6.933071]
>>>                    -> #2 (cpuhp_state-up){+.+.}-{0:0}:
>>> <4>[    6.933076]        lock_acquire+0xd3/0x310
>>> <4>[    6.933079]        cpuhp_thread_fun+0xa6/0x1f0
>>> <4>[    6.933082]        smpboot_thread_fn+0x1b5/0x260
>>> <4>[    6.933084]        kthread+0xed/0x120
>>> <4>[    6.933086]        ret_from_fork+0x1f/0x30
>>> <4>[    6.933089]
>>>                    -> #1 (cpu_hotplug_lock){++++}-{0:0}:
>>> <4>[    6.933092]        lock_acquire+0xd3/0x310
>>> <4>[    6.933094]        __cpuhp_state_add_instance+0x43/0x1c0
>>> <4>[    6.933096]        iova_domain_init_rcaches+0x199/0x1c0
>>> <4>[    6.933099]        iommu_setup_dma_ops+0x104/0x3d0
>>> <4>[    6.933101]        iommu_probe_device+0xa4/0x180
>>> <4>[    6.933103]        iommu_bus_notifier+0x2d/0x40
>>> <4>[    6.933105]        notifier_call_chain+0x31/0x90
>>> <4>[    6.933108]        blocking_notifier_call_chain+0x3a/0x50
>>> <4>[    6.933110]        device_add+0x3c1/0x900
>>> <4>[    6.933112]        pci_device_add+0x255/0x580
>>> <4>[    6.933115]        pci_scan_single_device+0xa6/0xd0
>>> <4>[    6.933117]        p2sb_bar+0x7f/0x220
>>> <4>[    6.933120]        i801_add_tco_spt.isra.18+0x2b/0xca [i2c_i801]
>>> <4>[    6.933124]        i801_add_tco+0xb1/0xfe [i2c_i801]
>>> <4>[    6.933126]        i801_probe.cold.25+0xa9/0x3a7 [i2c_i801]
>>> <4>[    6.933129]        pci_device_probe+0x95/0x110
>>> <4>[    6.933132]        really_probe+0xd6/0x350
>>> <4>[    6.933134]        __driver_probe_device+0x73/0x170
>>> <4>[    6.933137]        driver_probe_device+0x1a/0x90
>>> <4>[    6.933140]        __driver_attach+0xbc/0x190
>>> <4>[    6.933141]        bus_for_each_dev+0x72/0xc0
>>> <4>[    6.933143]        bus_add_driver+0x1bb/0x210
>>> <4>[    6.933146]        driver_register+0x66/0xc0
>>> <4>[    6.933147]        wmi_bmof_probe+0x3b/0xac [wmi_bmof]
>>> <4>[    6.933150]        do_one_initcall+0x53/0x2f0
>>> <4>[    6.933152]        do_init_module+0x45/0x1c0
>>> <4>[    6.933154]        load_module+0x1cd5/0x1ec0
>>> <4>[    6.933156]        __do_sys_finit_module+0xaf/0x120
>>> <4>[    6.933158]        do_syscall_64+0x37/0x90
>>> <4>[    6.933160]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> <4>[    6.953757]
>>>                    -> #0 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
>>> <4>[    6.953779]        validate_chain+0xb3f/0x2000
>>> <4>[    6.953785]        __lock_acquire+0x5a4/0xb70
>>> <4>[    6.953786]        lock_acquire+0xd3/0x310
>>> <4>[    6.953787]        down_read+0x39/0x140
>>> <4>[    6.953790]        blocking_notifier_call_chain+0x20/0x50
>>> <4>[    6.953794]        device_add+0x3c1/0x900
>>> <4>[    6.953797]        platform_device_add+0x108/0x240
>>> <4>[    6.953799]        coretemp_cpu_online+0xe1/0x15e [coretemp]
>>> <4>[    6.953805]        cpuhp_invoke_callback+0x181/0x8a0
>>> <4>[    6.958244]        cpuhp_thread_fun+0x188/0x1f0
>>> <4>[    6.958267]        smpboot_thread_fn+0x1b5/0x260
>>> <4>[    6.958270]        kthread+0xed/0x120
>>> <4>[    6.958272]        ret_from_fork+0x1f/0x30
>>> <4>[    6.958274]
>>>                    other info that might help us debug this:
>>>
>>> <4>[    6.958275] Chain exists of:
>>>                      &(&priv->bus_notifier)->rwsem --> cpu_hotplug_lock --
>> cpuhp_state-up
>>>
>>> <4>[    6.961037]  Possible unsafe locking scenario:
>>>
>>> <4>[    6.961038]        CPU0                    CPU1
>>> <4>[    6.961038]        ----                    ----
>>> <4>[    6.961039]   lock(cpuhp_state-up);
>>> <4>[    6.961040]                                lock(cpu_hotplug_lock);
>>> <4>[    6.961041]                                lock(cpuhp_state-up);
>>> <4>[    6.961042]   lock(&(&priv->bus_notifier)->rwsem);
>>> <4>[    6.961044]
>>>                     *** DEADLOCK ***
>>>
>>> <4>[    6.961044] 2 locks held by cpuhp/0/15:
>>> <4>[    6.961046]  #0: ffffffff82648f10 (cpu_hotplug_lock){++++}-{0:0}, 
> at: cpuhp_thread_fun+0x48/0x1f0
>>> <4>[    6.961053]  #1: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
> cpuhp_thread_fun+0x48/0x1f0
>>> <4>[    6.961058]
>>>                    stack backtrace:
>>> <4>[    6.961059] CPU: 0 PID: 15 Comm: cpuhp/0 Not tainted 6.0.0-rc6-
> CI_DRM_12164-ga1f63e144e54+ #1
>>> <4>[    6.961062] Hardware name: Intel Corporation NUC8i7HVK/NUC8i7HVB, 
> BIOS HNKBLi70.86A.0047.2018.0718.1706 07/18/2018
>>> <4>[    6.961063] Call Trace:
>>> <4>[    6.961064]  <TASK>
>>> <4>[    6.961065]  dump_stack_lvl+0x56/0x7f
>>> <4>[    6.961069]  check_noncircular+0x132/0x150
>>> <4>[    6.961078]  validate_chain+0xb3f/0x2000
>>> <4>[    6.961083]  __lock_acquire+0x5a4/0xb70
>>> <4>[    6.961087]  lock_acquire+0xd3/0x310
>>> <4>[    6.961088]  ? blocking_notifier_call_chain+0x20/0x50
>>> <4>[    6.961093]  down_read+0x39/0x140
>>> <4>[    6.961097]  ? blocking_notifier_call_chain+0x20/0x50
>>> <4>[    6.961099]  blocking_notifier_call_chain+0x20/0x50
>>> <4>[    6.961102]  device_add+0x3c1/0x900
>>> <4>[    6.961106]  ? dev_set_name+0x4e/0x70
>>> <4>[    6.961109]  platform_device_add+0x108/0x240
>>> <4>[    6.961112]  coretemp_cpu_online+0xe1/0x15e [coretemp]
>>> <4>[    6.961117]  ? create_core_data+0x550/0x550 [coretemp]
>>> <4>[    6.961120]  cpuhp_invoke_callback+0x181/0x8a0
>>> <4>[    6.961124]  cpuhp_thread_fun+0x188/0x1f0
>>> <4>[    6.961129]  ? smpboot_thread_fn+0x1e/0x260
>>> <4>[    6.961131]  smpboot_thread_fn+0x1b5/0x260
>>> <4>[    6.961134]  ? sort_range+0x20/0x20
>>> <4>[    6.961135]  kthread+0xed/0x120
>>> <4>[    6.961137]  ? kthread_complete_and_exit+0x20/0x20
>>> <4>[    6.961139]  ret_from_fork+0x1f/0x30
>>> <4>[    6.961145]  </TASK>
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/intel/issues/6641
>>> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>>> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>>> ---
>>>   drivers/iommu/iova.c       | 28 ----------------------------
>>>   include/linux/cpuhotplug.h |  1 -
>>>   include/linux/iova.h       |  1 -
>>>   3 files changed, 30 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 47d1983dfa2a4..f0136d0231f06 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -31,16 +31,6 @@ unsigned long iova_rcache_range(void)
>>>   	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
>>>   }
>>>   
>>> -static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>>> -{
>>> -	struct iova_domain *iovad;
>>> -
>>> -	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
>>> -
>>> -	free_cpu_cached_iovas(cpu, iovad);
>>> -	return 0;
>>> -}
>>> -
>>>   static void free_global_cached_iovas(struct iova_domain *iovad);
>>>   
>>>   static struct iova *to_iova(struct rb_node *node)
>>> @@ -255,21 +245,10 @@ int iova_cache_get(void)
>>>   {
>>>   	mutex_lock(&iova_cache_mutex);
>>>   	if (!iova_cache_users) {
>>> -		int ret;
>>> -
>>> -		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, 
> "iommu/iova:dead", NULL,
>>> -					iova_cpuhp_dead);
>>> -		if (ret) {
>>> -			mutex_unlock(&iova_cache_mutex);
>>> -			pr_err("Couldn't register cpuhp handler\n");
>>> -			return ret;
>>> -		}
>>> -
>>>   		iova_cache = kmem_cache_create(
>>>   			"iommu_iova", sizeof(struct iova), 0,
>>>   			SLAB_HWCACHE_ALIGN, NULL);
>>>   		if (!iova_cache) {
>>> -			
> cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>>>   			mutex_unlock(&iova_cache_mutex);
>>>   			pr_err("Couldn't create iova cache\n");
>>>   			return -ENOMEM;
>>> @@ -292,7 +271,6 @@ void iova_cache_put(void)
>>>   	}
>>>   	iova_cache_users--;
>>>   	if (!iova_cache_users) {
>>> -		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>>>   		kmem_cache_destroy(iova_cache);
>>>   	}
>>>   	mutex_unlock(&iova_cache_mutex);
>>> @@ -495,8 +473,6 @@ EXPORT_SYMBOL_GPL(free_iova_fast);
>>>   
>>>   static void iova_domain_free_rcaches(struct iova_domain *iovad)
>>>   {
>>> -	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>>> -					    &iovad-
>> cpuhp_dead);
>>>   	free_iova_rcaches(iovad);
>>>   }
>>>   
>>> @@ -755,10 +731,6 @@ int iova_domain_init_rcaches(struct iova_domain 
> *iovad)
>>>   		}
>>>   	}
>>>   
>>> -	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>>> -					       &iovad-
>> cpuhp_dead);
>>> -	if (ret)
>>> -		goto out_err;
>>>   	return 0;
>>>   
>>>   out_err:
>>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>>> index f61447913db97..8f541a6b63e41 100644
>>> --- a/include/linux/cpuhotplug.h
>>> +++ b/include/linux/cpuhotplug.h
>>> @@ -95,7 +95,6 @@ enum cpuhp_state {
>>>   	CPUHP_PAGE_ALLOC,
>>>   	CPUHP_NET_DEV_DEAD,
>>>   	CPUHP_PCI_XGENE_DEAD,
>>> -	CPUHP_IOMMU_IOVA_DEAD,
>>>   	CPUHP_LUSTRE_CFS_DEAD,
>>>   	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
>>>   	CPUHP_PADATA_DEAD,
>>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>>> index c6ba6d95d79c2..fd77cd5bfa333 100644
>>> --- a/include/linux/iova.h
>>> +++ b/include/linux/iova.h
>>> @@ -37,7 +37,6 @@ struct iova_domain {
>>>   	struct iova	anchor;		/* rbtree lookup anchor 
> */
>>>   
>>>   	struct iova_rcache	*rcaches;
>>> -	struct hlist_node	cpuhp_dead;
>>>   };
>>>   
>>>   static inline unsigned long iova_size(struct iova *iova)
>>
> 
> 
> 
> 
> 
> 
