Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFF574820B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjGEKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGEKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:24:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A4AE47;
        Wed,  5 Jul 2023 03:24:16 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QwwjC0D2yzTkkg;
        Wed,  5 Jul 2023 18:23:11 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 18:24:13 +0800
CC:     <yangyicong@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <mark.rutland@arm.com>, <ryan.roberts@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <huzhanyuan@oppo.com>,
        <lipeifeng@oppo.com>, <zhangshiming@oppo.com>, <guojian@oppo.com>,
        <realmz6@gmail.com>, <linux-mips@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>, <Jonathan.Cameron@huawei.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RESEND PATCH v9 2/2] arm64: support batched/deferred tlb
 shootdown during page reclamation/migration
To:     Barry Song <21cnbao@gmail.com>
References: <20230518065934.12877-1-yangyicong@huawei.com>
 <20230518065934.12877-3-yangyicong@huawei.com> <ZJ2x6DlmyA3kVh1n@arm.com>
 <ZJ2+37Q7v4odMmEd@arm.com> <2f593850-797c-5422-2c80-ce214fac02bb@huawei.com>
 <CAGsJ_4zG=DT0gwC+5uN51rQKT=UudNDZ4t1BgRNoFb_3NNLOtQ@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <124b7798-94ae-ebfc-bbe5-21ebaaa02760@huawei.com>
Date:   Wed, 5 Jul 2023 18:24:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4zG=DT0gwC+5uN51rQKT=UudNDZ4t1BgRNoFb_3NNLOtQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/5 16:43, Barry Song wrote:
> On Tue, Jul 4, 2023 at 10:36 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> On 2023/6/30 1:26, Catalin Marinas wrote:
>>> On Thu, Jun 29, 2023 at 05:31:36PM +0100, Catalin Marinas wrote:
>>>> On Thu, May 18, 2023 at 02:59:34PM +0800, Yicong Yang wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> on x86, batched and deferred tlb shootdown has lead to 90%
>>>>> performance increase on tlb shootdown. on arm64, HW can do
>>>>> tlb shootdown without software IPI. But sync tlbi is still
>>>>> quite expensive.
>>>> [...]
>>>>>  .../features/vm/TLB/arch-support.txt          |  2 +-
>>>>>  arch/arm64/Kconfig                            |  1 +
>>>>>  arch/arm64/include/asm/tlbbatch.h             | 12 ++++
>>>>>  arch/arm64/include/asm/tlbflush.h             | 33 ++++++++-
>>>>>  arch/arm64/mm/flush.c                         | 69 +++++++++++++++++++
>>>>>  arch/x86/include/asm/tlbflush.h               |  5 +-
>>>>>  include/linux/mm_types_task.h                 |  4 +-
>>>>>  mm/rmap.c                                     | 12 ++--
>>>>
>>>> First of all, this patch needs to be split in some preparatory patches
>>>> introducing/renaming functions with no functional change for x86. Once
>>>> done, you can add the arm64-only changes.
>>>>
>>
>> got it. will try to split this patch as suggested.
>>
>>>> Now, on the implementation, I had some comments on v7 but we didn't get
>>>> to a conclusion and the thread eventually died:
>>>>
>>>> https://lore.kernel.org/linux-mm/Y7cToj5mWd1ZbMyQ@arm.com/
>>>>
>>>> I know I said a command line argument is better than Kconfig or some
>>>> random number of CPUs heuristics but it would be even better if we don't
>>>> bother with any, just make this always on.
>>
>> ok, will make this always on.
>>
>>>> Barry had some comments
>>>> around mprotect() being racy and that's why we have
>>>> flush_tlb_batched_pending() but I don't think it's needed (or, for
>>>> arm64, it can be a DSB since this patch issues the TLBIs but without the
>>>> DVM Sync). So we need to clarify this (see Barry's last email on the
>>>> above thread) and before attempting new versions of this patchset. With
>>>> flush_tlb_batched_pending() removed (or DSB), I have a suspicion such
>>>> implementation would be faster on any SoC irrespective of the number of
>>>> CPUs.
>>>
>>> I think I got the need for flush_tlb_batched_pending(). If
>>> try_to_unmap() marks the pte !present and we have a pending TLBI,
>>> change_pte_range() will skip the TLB maintenance altogether since it did
>>> not change the pte. So we could be left with stale TLB entries after
>>> mprotect() before TTU does the batch flushing.
>>>
> 
> Good catch.
> This could be also true for MADV_DONTNEED. after try_to_unmap, we run
> MADV_DONTNEED on this area, as pte is not present, we don't do anything
> on this PTE in zap_pte_range afterwards.
> 
>>> We can have an arch-specific flush_tlb_batched_pending() that can be a
>>> DSB only on arm64 and a full mm flush on x86.
>>>
>>
>> We need to do a flush/dsb in flush_tlb_batched_pending() only in a race
>> condition so we first check whether there's a pended batched flush and
>> if so do the tlb flush. The pending checking is common and the differences
>> among the archs is how to flush the TLB here within the flush_tlb_batched_pending(),
>> on arm64 it should only be a dsb.
>>
>> As we only needs to maintain the TLBs already pended in batched flush,
>> does it make sense to only handle those TLBs in flush_tlb_batched_pending()?
>> Then we can use the arch_tlbbatch_flush() rather than flush_tlb_mm() in
>> flush_tlb_batched_pending() and no arch specific function needed.
> 
> as we have issued no-sync tlbi on those pending addresses , that means
> our hardware
> has already "recorded" what should be flushed in the specific mm. so
> DSB only will flush
> them correctly. right?
> 

yes it's right. I was just thought something like below. arch_tlbbatch_flush()
will only be a dsb on arm64 so this will match what Catalin wants. But as you
told that this maybe incorrect on x86 so we'd better have arch specific
implementation for flush_tlb_batched_pending() as suggested.

diff --git a/mm/rmap.c b/mm/rmap.c
index 9699c6011b0e..afa3571503a0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -717,7 +717,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
        int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;

        if (pending != flushed) {
-               flush_tlb_mm(mm);
+               arch_tlbbatch_flush(&current->tlb_ubc.arch);
                /*
                 * If the new TLB flushing is pending during flushing, leave
                 * mm->tlb_flush_batched as is, to avoid losing flushing.
