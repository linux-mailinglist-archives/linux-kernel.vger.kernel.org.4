Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873096073F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJUJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJUJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:23:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2F256D2A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:23:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MtzR01jchz15Lws;
        Fri, 21 Oct 2022 17:18:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:23:06 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:23:05 +0800
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-erofs@lists.ozlabs.org>, <ocfs2-devel@oss.oracle.com>,
        <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>,
        <rafael@kernel.org>, <somlo@cmu.edu>, <mst@redhat.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>,
        <hsiangkao@linux.alibaba.com>, <huangjianan@oppo.com>,
        <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>, <akpm@linux-foundation.org>,
        <alexander.deucher@amd.com>, <richard@nod.at>,
        <liushixin2@huawei.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
 <5efd73b0-d634-d34f-3d7a-13d674e40d04@amd.com> <Y1JV1wxf/7ERAMhl@kroah.com>
 <35e66c7c-ff25-efd3-cfbc-d06130687aa7@amd.com>
 <19689b9e-16d1-c6c5-4ee8-58885fbf8fb0@amd.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e8e21756-c5b8-9098-8fb6-8e381bbf3dd1@huawei.com>
Date:   Fri, 21 Oct 2022 17:23:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <19689b9e-16d1-c6c5-4ee8-58885fbf8fb0@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/21 16:41, Luben Tuikov wrote:
> On 2022-10-21 04:24, Luben Tuikov wrote:
>> On 2022-10-21 04:18, Greg KH wrote:
>>> On Fri, Oct 21, 2022 at 03:55:18AM -0400, Luben Tuikov wrote:
>>>> On 2022-10-21 01:37, Greg KH wrote:
>>>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>>>> The previous discussion link:
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7Cd41da3fd6449492d01f808dab33cdb75%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019371236833115%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=C%2Bj1THkHpzVGks5eqB%2Fm%2FPAkMRohR7CYvRnOCqUqdcM%3D&amp;reserved=0
>>>>>> The very first discussion on this was here:
>>>>>>
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7Cd41da3fd6449492d01f808dab33cdb75%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019371236833115%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=pSR10abmK8nAMvKSezqWC0SPUBL4qEwtCCizyIKW7Dc%3D&amp;reserved=0
>>>>>>
>>>>>> Please use this link, and not the that one up there you which quoted above,
>>>>>> and whose commit description is taken verbatim from the this link.
>>>>>>
>>>>>>> kset_register() is currently used in some places without calling
>>>>>>> kset_put() in error path, because the callers think it should be
>>>>>>> kset internal thing to do, but the driver core can not know what
>>>>>>> caller doing with that memory at times. The memory could be freed
>>>>>>> both in kset_put() and error path of caller, if it is called in
>>>>>>> kset_register().
>>>>>> As I explained in the link above, the reason there's
>>>>>> a memory leak is that one cannot call kset_register() without
>>>>>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>>>>>> in this case, i.e. kset_register() fails with -EINVAL.
>>>>>>
>>>>>> Thus, the most common usage is something like this:
>>>>>>
>>>>>> 	kobj_set_name(&kset->kobj, format, ...);
>>>>>> 	kset->kobj.kset = parent_kset;
>>>>>> 	kset->kobj.ktype = ktype;
>>>>>> 	res = kset_register(kset);
>>>>>>
>>>>>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>>>>>> by the common idiom shown above. This needs to be mentioned in
>>>>>> the documentation, at least, in case, in the future this is absolved
>>>>>> in kset_register() redesign, etc.
>>>>> Based on this, can kset_register() just clean up from itself when an
>>>>> error happens?  Ideally that would be the case, as the odds of a kset
>>>>> being embedded in a larger structure is probably slim, but we would have
>>>>> to search the tree to make sure.
>>>> Looking at kset_register(), we can add kset_put() in the error path,
>>>> when kobject_add_internal(&kset->kobj) fails.
>>>>
>>>> See the attached patch. It needs to be tested with the same error injection
>>>> as Yang has been doing.
>>>>
>>>> Now, struct kset is being embedded in larger structs--see amdgpu_discovery.c
>>>> starting at line 575. If you're on an AMD system, it gets you the tree
>>>> structure you'll see when you run "tree /sys/class/drm/card0/device/ip_discovery/".
>>>> That shouldn't be a problem though.
>>> Yes, that shouldn't be an issue as the kobject embedded in a kset is
>>> ONLY for that kset itself, the kset structure should not be controling
>>> the lifespan of the object it is embedded in, right?
>> Yes, and it doesn't. It only does a kobject_get(parent) and kobject_put(parent).
>> So that's fine and natural.
>>
>> Yang, do you want to try the patch in my previous email in this thread, since you've
>> got the error injection set up already?
> I spoke too soon. I believe you're onto something, because looking at the idiom:
>
> 	kobj_set_name(&kset->kobj, format, ...);
> 	kset->kobj.kset = parent_kset;
> 	kset->kobj.ktype = ktype;
> 	res = kset_register(kset);
>
> The ktype defines a release method, which frees the larger struct the kset is embedded in.
> And this would result in double free, for instance in the amdgpu_discovery.c code, if
> kset_put() is called after kset_register() fails, since we kzalloc the larger object
> just before and kfree it on error just after. Ideally, we'd only "revert" the actions
> done by kobj_set_name(), as there's some error recovery on create_dir() in kobject_add_internal().
>
> So, we cannot do this business with the kset_put() on error from kset_register(), after all.
> Not sure how this wasn't caught in Yang's testing--the kernel should've complained.
I have already tried the change that in your posted patch when I was 
debugging this issue
before sent these fixes, because it may lead double free in some cases, 
and I had mentioned
it in this mail:

https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/#m68eade1993859dfc6c3d14d35f988d35a32ef837

Thanks,
Yang
>
> Regards,
> Luben
>
> .
