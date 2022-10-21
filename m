Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3F607218
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJUIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:24:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7C9AFDF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:24:53 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mty7v25HnzVj06;
        Fri, 21 Oct 2022 16:20:11 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:24:25 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:24:24 +0800
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luben Tuikov <luben.tuikov@amd.com>
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
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
Date:   Fri, 21 Oct 2022 16:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y1IwLOUGayjT9p6d@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


On 2022/10/21 13:37, Greg KH wrote:
> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>> The previous discussion link:
>>> https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
>> The very first discussion on this was here:
>>
>> https://www.spinics.net/lists/dri-devel/msg368077.html
>>
>> Please use this link, and not the that one up there you which quoted above,
>> and whose commit description is taken verbatim from the this link.
>>
>>> kset_register() is currently used in some places without calling
>>> kset_put() in error path, because the callers think it should be
>>> kset internal thing to do, but the driver core can not know what
>>> caller doing with that memory at times. The memory could be freed
>>> both in kset_put() and error path of caller, if it is called in
>>> kset_register().
>> As I explained in the link above, the reason there's
>> a memory leak is that one cannot call kset_register() without
>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>> in this case, i.e. kset_register() fails with -EINVAL.
>>
>> Thus, the most common usage is something like this:
>>
>> 	kobj_set_name(&kset->kobj, format, ...);
>> 	kset->kobj.kset = parent_kset;
>> 	kset->kobj.ktype = ktype;
>> 	res = kset_register(kset);
>>
>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>> by the common idiom shown above. This needs to be mentioned in
>> the documentation, at least, in case, in the future this is absolved
>> in kset_register() redesign, etc.
> Based on this, can kset_register() just clean up from itself when an
> error happens?  Ideally that would be the case, as the odds of a kset
> being embedded in a larger structure is probably slim, but we would have
> to search the tree to make sure.
I have search the whole tree, the kset used in bus_register() - patch 
#3, kset_create_and_add() - patch #4
__class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and 
amdgpu_discovery.c - patch #10
is embedded in a larger structure. In these cases, we can not call 
kset_put() in error path in kset_register()
itself.

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
