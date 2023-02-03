Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06D46892D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBCI4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjBCI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:56:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87381B2D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:56:46 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P7TzN5blxzfZ4D;
        Fri,  3 Feb 2023 16:56:32 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 3 Feb 2023 16:56:44 +0800
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
To:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
 <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
 <20230131150644.GA2605@willie-the-truck>
 <20230131150750.GB2605@willie-the-truck>
 <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <5ecc890a-453a-ba2d-9c5e-073127067799@huawei.com>
Date:   Fri, 3 Feb 2023 16:56:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/1 0:03, Ard Biesheuvel wrote:
> On Tue, 31 Jan 2023 at 16:07, Will Deacon <will@kernel.org> wrote:
>> Now really adding Ard...
>>
>> On Tue, Jan 31, 2023 at 03:06:44PM +0000, Will Deacon wrote:
>>> +Ard -- full thread here:
>>>
>>> https://lore.kernel.org/all/20221227092634.445212-1-liushixin2@huawei.com/
>>>
>>> On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
>>>> On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> This patch seems to have been lost in the corner. Recently I've meet this problem again
>>>>>
>>>>> on v6.1, so I would like to propose this patch again.
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>
>>>>> On 2022/12/27 17:26, Liu Shixin wrote:
>>>>>> After I add a 10GB pmem device, I got the following error message when
>>>>>> insert module:
>>>>>>
>>>>>>  insmod: vmalloc error: size 16384, vm_struct allocation failed,
>>>>>>  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
>>>>>>
>>>>>> If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
>>>>>> vmalloc region entirely. Although module_alloc() can fall back to a 2GB
>>>>>> window if ARM64_MODULE_PLTS is set, the module region is still easily
>>>>>> exhausted because the module region is located at bottom of vmalloc region
>>>>>> and the vmalloc region is allocated from bottom to top.
>>>>>>
>>>>>> Skip module region if not calling from module_alloc().
>>>>>>
>>>> I'll assume this is for the arm tree.
>>>>
>>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>> This looks like the same issue previously reported at:
>>>
>>> https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/
>>>
>>> where Ard had a few suggestions but, afaict, they didn't help.
>>>
> Thanks for the cc.
>
> So this is a bit clunky, and I wonder whether we wouldn't be better
> off just splitting the vmalloc region into two separate regions: one
> for the kernel and modules, and one for everything else. That way, we
> lose one bit of entropy in the randomized placement, but the default
> 48-bit VA space is vast anway, and even on 39-bit VA configs (such as
> Android), I seriously doubt that we come anywhere close to exhausting
> the vmalloc space today.
> .
Thanks for your advice.

>

