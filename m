Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFE5E71A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiIWB4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIWB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:56:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F18EFFA70
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:56:39 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYZsS4yGrz1P6nx;
        Fri, 23 Sep 2022 09:52:28 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 09:56:37 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 09:56:37 +0800
Subject: Re: [PATCH v3 1/8] cgroup/cpuset: use hotplug_memory_notifier()
 directly
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
References: <20220922141904.3245505-1-liushixin2@huawei.com>
 <20220922141904.3245505-2-liushixin2@huawei.com>
 <f0675fe8-14dc-7890-357b-565c0a706932@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <b530a919-4035-cc34-0f9e-547903678423@huawei.com>
Date:   Fri, 23 Sep 2022 09:56:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f0675fe8-14dc-7890-357b-565c0a706932@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/23 1:56, David Hildenbrand wrote:
> On 22.09.22 16:18, Liu Shixin wrote:
>> Since patch 316346243be6 has already updated the minimum gcc version to 5.1.
>> The previous problem mentioned in patch f02c69680088 is not existed. So we
>> can now revert to use hotplug_memory_notifier() directly rather than
>> register_hotmemory_notifier().
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index b474289c15b8..0c6db6a4f427 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3630,11 +3630,6 @@ static int cpuset_track_online_nodes(struct notifier_block *self,
>>       return NOTIFY_OK;
>>   }
>>   -static struct notifier_block cpuset_track_online_nodes_nb = {
>> -    .notifier_call = cpuset_track_online_nodes,
>> -    .priority = 10,        /* ??! */
>> -};
>> -
>>   /**
>>    * cpuset_init_smp - initialize cpus_allowed
>>    *
>> @@ -3652,7 +3647,7 @@ void __init cpuset_init_smp(void)
>>       cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
>>       top_cpuset.effective_mems = node_states[N_MEMORY];
>>   -    register_hotmemory_notifier(&cpuset_track_online_nodes_nb);
>> +    hotplug_memory_notifier(cpuset_track_online_nodes, 10);
>>         cpuset_migrate_mm_wq = alloc_ordered_workqueue("cpuset_migrate_mm", 0);
>>       BUG_ON(!cpuset_migrate_mm_wq);
>
>
> Please don't drop Reviewed-by or Acked-by tags. Otherwise reviewers have no clue which patch they already reviewed -- and they always have little time ;)
>
Thanks for your reminder, I'll keep it in mind.

