Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF663C006
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiK2M1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiK2M1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:27:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED95B594
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:26:58 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NM1ln6cfpzHwFs;
        Tue, 29 Nov 2022 20:26:13 +0800 (CST)
Received: from [10.174.179.176] (10.174.179.176) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 20:26:55 +0800
Subject: Re: [PATCH 4/5] arm64: mm: Support ASID isolation feature
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <20221017083203.3690346-1-yeyunfeng@huawei.com>
 <20221017083203.3690346-5-yeyunfeng@huawei.com> <Y2ughyNLh9EFw3HT@arm.com>
 <3607b658-304a-ecc8-b07a-530f4a6365e8@huawei.com> <Y4TpL5IIHUSRtSQo@arm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <6376ad6d-1815-c2c5-575c-2ed89b877047@huawei.com>
Date:   Tue, 29 Nov 2022 20:26:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Y4TpL5IIHUSRtSQo@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/29 1:00, Catalin Marinas wrote:
> On Thu, Nov 10, 2022 at 03:07:53PM +0800, Yunfeng Ye wrote:
>> On 2022/11/9 20:43, Catalin Marinas wrote:
>>> On Mon, Oct 17, 2022 at 04:32:02PM +0800, Yunfeng Ye wrote:
>>>> After a rollover, the global generation will be flushed, which will
>>>> cause the process mm->context.id on all CPUs do not match the
>>>> generation. Thus, the process will compete for the global spinlock lock
>>>> to reallocate a new ASID and refresh the TLBs of all CPUs on context
>>>> switch. This will lead to the increase of scheduling delay and TLB miss.
>>>>
>>>> In some delay-sensitive scenarios, for example, part of CPUs are
>>>> isolated, only a limited number of processes are deployed to run on the
>>>> isolated CPUs. In this case, we do not want these key processes to be
>>>> affected by the rollover of ASID.
>>>
>>> Part of this commit log should also go in the cover letter and it would> help to back this up by some numbers, e.g. what percentage improvement
>>> you get with this patchset by running hackbench on an isolated CPU.
>>>
>>> In theory it looks like CPU isolation would benefit from this patchset
>>> but we try not to touch this code often, so any modification should come
>>> with proper justification, backed by numbers.
>>>
>> Yes, CPU isolation will benefit from this patchset. We use cyclictest tool
>> to test the maximum scheduling and interrupt delays, found that the
>> sched_switch process takes several microseconds sometimes, The analysis
>> result shows that the delay is caused by the ASID refresh.
> 
> Do you know whether it's predominantly the spinlock or the TLBI that's
> causing this (or just a combination of the two)?
> 
I think the spinlock is the main factor, I didn't distinguish how much
time it took for each of the two. On the other hand, the TLBI is processed
under the spinlock currently, its time-consuming will increase the
time-consuming of the spinlock too.

> I was talking to Will and concluded we should try to reuse the ASID
> pinning code that's already in that file rather than adding a new
> bitmap. At a high level, a thread migrating to an isolated CPU can have
At first, I want to reuse the ASID pinned bitmap too, which is the same
idea with you. but there is a difference between pinned bitmap and isolation
bitmap, the pinned bitmap will not be changed when the generation roll-over,
while the isolation bitmap need to be flushed.

The idea "broadcast a TLBI for the pinned ASID when the task dies" you
mentioned below maybe can reuse the pinned bitmap. I've considered this idea
too, I think this method is not as good as the current two bitmap method:

1. This will introduce some TLBI jitter, and maybe increase the contention
of spinlock when updating the pinned bitmap, which we don't want the jitter
on the isolation CPU.

2. Another disadvantage is that if only one pinned bitmap is used and a large
number of processes are on the isolation domain but the processes are not dead,
the available ASIDs are insufficient. for example, more than 65536 processes
running or sleeping on the isolation CPU, how to handle this situation?

> its ASID pinned. If context switching only happens between pinned ASIDs
> on an isolated CPU, we may be able to avoid the lock even if the
> generation rolled over on another CPU.
> 
> I think the tricky problem is when a pinned ASID task eventually dies,
> possibly after migrating to another CPU. If we avoided the TLBI on
> generation roll-over for the isolated CPU, it will have stale entries.
> One option would be to broadcast a TLBI for the pinned ASID when the
> task dies, though this would introduce some jitter. An alternative may
> be to track whether a pinned ASID ever run on a CPU and do a local TLBI
> for that ASID when a pinned thread is migrated.
> 
> All these need a lot more thinking and (formal) modelling. I have a TLA+
> model but I haven't updated it to cover the pinned ASIDs. Or,
> alternatively, make the current code stand-alone and get it through CBMC
> (faking the spinlock as pthread mutexes and implementing some of the
> atomics in plain C with __CPROVER_atomic_begin/end).
> 
