Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31986610729
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiJ1BUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiJ1BUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:20:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30227914;
        Thu, 27 Oct 2022 18:20:10 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mz4Qm4hLyzJnNK;
        Fri, 28 Oct 2022 09:17:20 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:20:08 +0800
CC:     <yangyicong@hisilicon.com>, <corbet@lwn.net>,
        <peterz@infradead.org>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <darren@os.amperecomputing.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linux-mm@kvack.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <akpm@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-doc@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Punit Agrawal <punit.agrawal@bytedance.com>,
        Barry Song <21cnbao@gmail.com>
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
 <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com> <87o7tx5oyx.fsf@stealth>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <bc44cf85-aee9-03ca-9911-dbd904a43cc8@huawei.com>
Date:   Fri, 28 Oct 2022 09:20:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87o7tx5oyx.fsf@stealth>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/27 22:19, Punit Agrawal wrote:
> 
> [ Apologies for chiming in late in the conversation ]
> 
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> On 9/28/22 05:53, Barry Song wrote:
>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>>>>> [...]
>>>>>
>>>>> On 9/21/22 14:13, Yicong Yang wrote:
>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>>> +{
>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>>>>>> +    if (num_online_cpus() <= 4)
>>>>>
>>>>> It would be great to have some more inputs from others, whether 4 (which should
>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>>>>> is optimal for an wide range of arm64 platforms.
>>>>>
>>>
>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>>> with 5,6,7
>>> cores.
>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>>> this patch.
>>>
>>> so it seems safe to have
>>> if (num_online_cpus()  < 8)
>>>
>>>>
>>>> Do you prefer this macro to be static or make it configurable through kconfig then
>>>> different platforms can make choice based on their own situations? It maybe hard to
>>>> test on all the arm64 platforms.
>>>
>>> Maybe we can have this default enabled on machines with 8 and more cpus and
>>> provide a tlbflush_batched = on or off to allow users enable or
>>> disable it according
>>> to their hardware and products. Similar example: rodata=on or off.
>>
>> No, sounds bit excessive. Kernel command line options should not be added
>> for every possible run time switch options.
>>
>>>
>>> Hi Anshuman, Will,  Catalin, Andrew,
>>> what do you think about this approach?
>>>
>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>>>
>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>>> even by hardware broadcast.
>>
>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
> 
> When running the test program in the commit in a VM, I saw benefits from
> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
> ptep_clear_flush() went from ~1% in the unpatched version to not showing
> up.
> 

Maybe you're booting VM on a server with more than 32 cores and Barry tested
on his 4 CPUs embedded platform. I guess a 4 CPU VM is not fully equivalent to
a 4 CPU real machine as the tbli and dsb in the VM may influence the host
as well.

> Yicong mentioned that he didn't see any benefit for <= 4 CPUs but is
> there any overhead? I am wondering what are the downsides of enabling
> the config by default.
> 
> Thanks,
> Punit
> .
> 
