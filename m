Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD5623C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiKJHIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKJHH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:07:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DAE14016
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:07:56 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7CZn1xTHzHvl0;
        Thu, 10 Nov 2022 15:07:29 +0800 (CST)
Received: from [10.174.179.176] (10.174.179.176) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 15:07:54 +0800
Subject: Re: [PATCH 4/5] arm64: mm: Support ASID isolation feature
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <20221017083203.3690346-1-yeyunfeng@huawei.com>
 <20221017083203.3690346-5-yeyunfeng@huawei.com> <Y2ughyNLh9EFw3HT@arm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <3607b658-304a-ecc8-b07a-530f4a6365e8@huawei.com>
Date:   Thu, 10 Nov 2022 15:07:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Y2ughyNLh9EFw3HT@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.176]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/9 20:43, Catalin Marinas wrote:
> On Mon, Oct 17, 2022 at 04:32:02PM +0800, Yunfeng Ye wrote:
>> After a rollover, the global generation will be flushed, which will
>> cause the process mm->context.id on all CPUs do not match the
>> generation. Thus, the process will compete for the global spinlock lock
>> to reallocate a new ASID and refresh the TLBs of all CPUs on context
>> switch. This will lead to the increase of scheduling delay and TLB miss.
>>
>> In some delay-sensitive scenarios, for example, part of CPUs are
>> isolated, only a limited number of processes are deployed to run on the
>> isolated CPUs. In this case, we do not want these key processes to be
>> affected by the rollover of ASID.
> 
> Part of this commit log should also go in the cover letter and it would> help to back this up by some numbers, e.g. what percentage improvement
> you get with this patchset by running hackbench on an isolated CPU.
> 
> In theory it looks like CPU isolation would benefit from this patchset
> but we try not to touch this code often, so any modification should come
> with proper justification, backed by numbers.
> 
Yes, CPU isolation will benefit from this patchset. We use cyclictest tool
to test the maximum scheduling and interrupt delays, found that the
sched_switch process takes several microseconds sometimes, The analysis
result shows that the delay is caused by the ASID refresh.

We use simple test cases to construct the case of quickly consumption of
ASIDs, this increases the ASID refresh frequency and the contention for
the global ASID spin lock. In this case, the delay between sched_switch
and tlb_flush can reach 63 us. The following is the trace log:

    stress-ng-2864907 [012] dN.. 17006.430048: sched_stat_runtime: comm=stress-ng pid=2864907 runtime=859130 [ns] vruntime=9015202524211 [ns]
    stress-ng-2864907 [012] d... 17006.430048: sched_switch: prev_comm=stress-ng prev_pid=2864907 prev_prio=120 prev_state=R ==> next_comm=cyclictest next_pid=2866344 next_prio=19
    stress-ng-2864907 [012] d... 17006.430111: tlb_flush: pages:-1 reason:flush on task switch (0)
// 17006.430111 - 17006.430048 = 63 us

    cyclictest-2866344 [012] .... 17006.430112: kfree: call_site=__audit_syscall_exit+0x210/0x250 ptr=0000000000000000
    cyclictest-2866344 [012] .... 17006.430112: sys_exit: NR 115 = 0
    cyclictest-2866344 [012] .... 17006.430112: sys_clock_nanosleep -> 0x0
    cyclictest-2866344 [012] d... 17006.430113: user_enter:
    cyclictest-2866344 [012] d... 17006.430126: user_exit:
    cyclictest-2866344 [012] .... 17006.430126: sys_enter: NR 64 (4, ffffa451c4d0, 1f, 0, 3b, 0)
    cyclictest-2866344 [012] .... 17006.430126: sys_write(fd: 4, buf: ffffa451c4d0, count: 1f)
    cyclictest-2866344 [012] .... 17006.430129: tracing_mark_write: hit latency threshold (72 > 30)

The delay caused by ASID interference is variable, may be several nanoseconds,
or may be several microseconds, it depends on the concurrent competition.
If this patch series is used, the delay caused by ASID interference on the
isolated CPU can be reduced.

Thanks.

> Note that I haven't reviewed the algorithm you are proposing in detail,
> only had a brief look.
> 
