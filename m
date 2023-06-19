Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46EC734CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFSHyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjFSHxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:53:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B153E7F;
        Mon, 19 Jun 2023 00:53:43 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ql24T4yRfzMnwD;
        Mon, 19 Jun 2023 15:50:33 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 15:53:40 +0800
Message-ID: <a54be73e-840b-2091-b240-1417499f5738@huawei.com>
Date:   Mon, 19 Jun 2023 15:53:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <richard.weiyang@linux.alibaba.com>,
        <mst@redhat.com>, <jasowang@redhat.com>,
        <pankaj.gupta.linux@gmail.com>, <mhocko@kernel.org>,
        <osalvador@suse.de>
Subject: Re: [PATCH stable 5.10] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Content-Language: en-US
To:     <david@redhat.com>, <gregkh@linuxfoundation.org>
References: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
 <20230619065121.1720912-1-mawupeng1@huawei.com>
 <2023061926-monoxide-pastor-fa3b@gregkh>
 <a7d39606-cc85-42c3-c882-fa217954bf00@huawei.com>
 <cc1c2973-493a-6e21-048e-148ed55e653b@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <cc1c2973-493a-6e21-048e-148ed55e653b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/19 15:41, David Hildenbrand wrote:
> On 19.06.23 09:22, mawupeng wrote:
>>
>>
>> On 2023/6/19 15:16, Greg KH wrote:
>>> On Mon, Jun 19, 2023 at 02:51:21PM +0800, Wupeng Ma wrote:
>>>> From: David Hildenbrand <david@redhat.com>
>>>>
>>>> commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.
>>>>
>>>> virtio-mem soon wants to use offline_and_remove_memory() memory that
>>>> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
>>>> remove that restriction.
>>>>
>>>> Let's remember the old state and try to restore that if anything goes
>>>> wrong. While re-onlining can, in general, fail, it's highly unlikely to
>>>> happen (usually only when a notifier fails to allocate memory, and these
>>>> are rather rare).
>>>>
>>>> This will be used by virtio-mem to offline+remove memory ranges that are
>>>> bigger than a single memory block - for example, with a device block
>>>> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
>>>> block size of 128MB.
>>>>
>>>> While we could compress the state into 2 bit, using 8 bit is much
>>>> easier.
>>>>
>>>> This handling is similar, but different to acpi_scan_try_to_offline():
>>>>
>>>> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
>>>> optimization is still relevant - it should only apply to ZONE_NORMAL
>>>> (where we have no guarantees). If relevant, we can always add it.
>>>>
>>>> b) acpi_scan_try_to_offline() simply onlines all memory in case
>>>> something goes wrong. It doesn't restore previous online type. Let's do
>>>> that, so we won't overwrite what e.g., user space configured.
>>>>
>>>> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> Link: https://lore.kernel.org/r/20201112133815.13332-28-david@redhat.com
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>>> ---
>>>>   mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
>>>>   1 file changed, 89 insertions(+), 16 deletions(-)
>>>>
>>>
>>> Why is this needed in 5.10.y?  Looks like a new feature to me, what
>>> problem does it solve there?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> It do introduce a new feature. But at the same time, it fix a memleak introduced
>> in Commit 08b3acd7a68f ("mm/memory_hotplug: Introduce offline_and_remove_memory()"
>>
>> Our test find a memleak in init_memory_block, it is clear that mem is never
>> been released due to wrong refcount. Commit 08b3acd7a68f ("mm/memory_hotplug:
>> Introduce offline_and_remove_memory()") failed to dec refcount after
>> find_memory_block which fail to dec refcount to zero in remove memory
>> causing the leak.
>>
>> Commit 8dc4bb58a146 ("mm/memory_hotplug: extend offline_and_remove_memory()
>> to handle more than one memory block") introduce walk_memory_blocks to
>> replace find_memory_block which dec refcount by calling put_device after
>> find_memory_block_by_id. In the way, the memleak is fixed.
>>
>> Here is the simplified calltrace:
>>
>>    kmem_cache_alloc_trace+0x664/0xed0
>>    init_memory_block+0x8c/0x170
>>    create_memory_block_devices+0xa4/0x150
>>    add_memory_resource+0x188/0x530
>>    __add_memory+0x78/0x104
>>    add_memory+0x6c/0xb0
>>
> 
> Makes sense to me. Of course, we could think about a simplified stable fix that only drops the ref.

Since the new patch does not introduce any kabi change, maybe we can merge this one？

However the changelog may lead to some confusion for other people just like the question
you asked.

> 
