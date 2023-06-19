Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C642F734BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjFSGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjFSGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:54:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9851A4;
        Sun, 18 Jun 2023 23:54:24 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ql0m33pBkzMp5B;
        Mon, 19 Jun 2023 14:51:15 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 14:54:22 +0800
Message-ID: <0ce6abb5-bf32-a5dc-c6eb-0a96e12a8ebd@huawei.com>
Date:   Mon, 19 Jun 2023 14:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <richard.weiyang@linux.alibaba.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <pankaj.gupta.linux@gmail.com>,
        <mhocko@kernel.org>, <osalvador@suse.de>
Subject: Re: [PATCH stable 5.10 1/1] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Content-Language: en-US
To:     <gregkh@linuxfoundation.org>
References: <20230614061900.3296725-1-mawupeng1@huawei.com>
 <20230614061900.3296725-2-mawupeng1@huawei.com>
 <2023061440-showing-happiest-937e@gregkh>
 <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
 <2023061927-parsnip-gauging-86e9@gregkh>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <2023061927-parsnip-gauging-86e9@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2023/6/19 14:20, Greg KH wrote:
> On Wed, Jun 14, 2023 at 02:45:58PM +0800, mawupeng wrote:
>>
>>
>> On 2023/6/14 14:35, Greg KH wrote:
>>> On Wed, Jun 14, 2023 at 02:19:00PM +0800, Wupeng Ma wrote:
>>>> From: David Hildenbrand <david@redhat.com>
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
>>>> ---
>>>>  mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
>>>>  1 file changed, 89 insertions(+), 16 deletions(-)
>>>
>>> As you forwarded this patch on, you too need to sign-off on it.
>>
>> Thanks for reminding me.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>
>>>
>>> Also, what is the git id of the commit in Linus's tree?
>>
>> Sorry, here is the commit in Linus's tree.
>>
>> commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.
> 
> Please resend the change with both of these things fixed up, so I don't
> have to manually do it :)

I have resend the patch but use the parent message id for in-reply-to.

Sorry.

> 
> thanks,
> 
> greg k-h
