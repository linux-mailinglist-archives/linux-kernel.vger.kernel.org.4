Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0496D6A50CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjB1BsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjB1BsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:48:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111CEDBD5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:48:15 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PQgFB1Xt9zKqGN;
        Tue, 28 Feb 2023 09:46:06 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 09:48:03 +0800
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
To:     Ard Biesheuvel <ardb@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
 <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
 <20230131150644.GA2605@willie-the-truck>
 <20230131150750.GB2605@willie-the-truck>
 <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
 <20230207112940.GA12147@willie-the-truck>
 <8c287b1d-476c-7b00-27f6-76c3a1a5fd46@leemhuis.info>
 <CAMj1kXGWEaQXoKj=DzG9XpVGi4t5zfE-RSG0BodVL-b47nsj-A@mail.gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <856fa1a1-cecd-a7b7-a6b0-3e3c8fedda47@huawei.com>
Date:   Tue, 28 Feb 2023 09:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGWEaQXoKj=DzG9XpVGi4t5zfE-RSG0BodVL-b47nsj-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2023/2/28 0:14, Ard Biesheuvel wrote:
> On Mon, 27 Feb 2023 at 16:08, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> On 07.02.23 12:29, Will Deacon wrote:
>>> On Tue, Jan 31, 2023 at 05:03:32PM +0100, Ard Biesheuvel wrote:
>>>> On Tue, 31 Jan 2023 at 16:07, Will Deacon <will@kernel.org> wrote:
>>>>> On Tue, Jan 31, 2023 at 03:06:44PM +0000, Will Deacon wrote:
>>>>>> On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
>>>>>>> On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>>>>>>> On 2022/12/27 17:26, Liu Shixin wrote:
>>>>>>>>> After I add a 10GB pmem device, I got the following error message when
>>>>>>>>> insert module:
>>>>>>>>>
>>>>>>>>>  insmod: vmalloc error: size 16384, vm_struct allocation failed,
>>>>>>>>>  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
>>>>>>>>>
>>>>>>>>> If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
>>>>>>>>> vmalloc region entirely. Although module_alloc() can fall back to a 2GB
>>>>>>>>> window if ARM64_MODULE_PLTS is set, the module region is still easily
>>>>>>>>> exhausted because the module region is located at bottom of vmalloc region
>>>>>>>>> and the vmalloc region is allocated from bottom to top.
>>>>>>>>>
>>>>>>>>> Skip module region if not calling from module_alloc().
>>>>>>> I'll assume this is for the arm tree.
>>>>>>>
>>>>>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>>>>> This looks like the same issue previously reported at:
>>>>>>
>>>>>> https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/
>>>>>>
>>>>>> where Ard had a few suggestions but, afaict, they didn't help.
>>>>>>
>>>> Thanks for the cc.
>>>>
>>>> So this is a bit clunky, and I wonder whether we wouldn't be better
>>>> off just splitting the vmalloc region into two separate regions: one
>>>> for the kernel and modules, and one for everything else. That way, we
>>>> lose one bit of entropy in the randomized placement, but the default
>>>> 48-bit VA space is vast anway, and even on 39-bit VA configs (such as
>>>> Android), I seriously doubt that we come anywhere close to exhausting
>>>> the vmalloc space today.
>>> That sounds like a good idea to me.
>>>
>>> Liu Shixin -- do you think you could have a go at implementing Ard's
>>> suggestion instead?
>> Liu Shixin, did you ever look into realizing this idea?
>>
>> Or was some progress already made and I just missed it?
>>
> This patch
>
> https://lore.kernel.org/all/20230223204101.1500373-1-ardb@kernel.org/
>
> should fix the issue.
>
>> I'm asking, as the idea discussed afaics is not only supposed to fix the
>> regression you tried to address, but also one that is now three months
>> old and stalled since Mid-December -- which is really unfortunate, as
>> that's not how regressions should be handled. :-/
> Is it documented anywhere how regressions should be handled? The
> mailing list is flooded with hard to reproduce reports from users as
> well as automatic fuzzers and build bots, so I don't think it is
> entirely unreasonable to move unresponsive reporters to the back of
> the queue.
>
>> But well, it afaik was
>> caused by a patch from Ard, so it's obviously not your job to address
>> it. But it seems you were working on it.
>>
> We are all working together here, so please refrain from telling
> people what they should or should not be working on. (I am aware that
> you probably did not mean it that way, but things tend to get lost in
> translation very easily on the mailing list)
>
> Liu, could you please check whether the linked patch addresses your issue?
Thanks, I will try this patch.
>
> Thanks,
> Ard.
> .
>

