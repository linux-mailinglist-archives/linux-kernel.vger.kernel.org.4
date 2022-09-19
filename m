Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E667D5BC205
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiISEYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiISEYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:24:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6494595A9;
        Sun, 18 Sep 2022 21:24:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724F1143D;
        Sun, 18 Sep 2022 21:24:56 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11DD63F73D;
        Sun, 18 Sep 2022 21:24:39 -0700 (PDT)
Message-ID: <dd480976-5054-7926-fb81-0aca74f6d1fd@arm.com>
Date:   Mon, 19 Sep 2022 09:54:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
References: <20220822082120.8347-1-yangyicong@huawei.com>
 <20220822082120.8347-5-yangyicong@huawei.com>
 <1e8642d5-0e2d-5747-d0d2-5aa0817ea4af@arm.com>
 <CAGsJ_4xD4m-szM1Cm4N5ZRCODGC0fbW+BLBhy8g6+eK=aHPQNw@mail.gmail.com>
 <1125554b-c183-23c4-5516-95b918a761cc@arm.com>
 <CAGsJ_4zkRv7RYCB2SC0uydMSQWfwXs3-nkjxMoR7wgn2nt43gA@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAGsJ_4zkRv7RYCB2SC0uydMSQWfwXs3-nkjxMoR7wgn2nt43gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/22 12:12, Barry Song wrote:
> On Thu, Sep 15, 2022 at 6:07 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 9/9/22 11:05, Barry Song wrote:
>>> On Fri, Sep 9, 2022 at 5:24 PM Anshuman Khandual
>>> <anshuman.khandual@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/22/22 13:51, Yicong Yang wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> on x86, batched and deferred tlb shootdown has lead to 90%
>>>>> performance increase on tlb shootdown. on arm64, HW can do
>>>>> tlb shootdown without software IPI. But sync tlbi is still
>>>>> quite expensive.
>>>>>
>>>>> Even running a simplest program which requires swapout can
>>>>> prove this is true,
>>>>>  #include <sys/types.h>
>>>>>  #include <unistd.h>
>>>>>  #include <sys/mman.h>
>>>>>  #include <string.h>
>>>>>
>>>>>  int main()
>>>>>  {
>>>>>  #define SIZE (1 * 1024 * 1024)
>>>>>          volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>>>>>                                           MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>>>>>
>>>>>          memset(p, 0x88, SIZE);
>>>>>
>>>>>          for (int k = 0; k < 10000; k++) {
>>>>>                  /* swap in */
>>>>>                  for (int i = 0; i < SIZE; i += 4096) {
>>>>>                          (void)p[i];
>>>>>                  }
>>>>>
>>>>>                  /* swap out */
>>>>>                  madvise(p, SIZE, MADV_PAGEOUT);
>>>>>          }
>>>>>  }
>>>>>
>>>>> Perf result on snapdragon 888 with 8 cores by using zRAM
>>>>> as the swap block device.
>>>>>
>>>>>  ~ # perf record taskset -c 4 ./a.out
>>>>>  [ perf record: Woken up 10 times to write data ]
>>>>>  [ perf record: Captured and wrote 2.297 MB perf.data (60084 samples) ]
>>>>>  ~ # perf report
>>>>>  # To display the perf.data header info, please use --header/--header-only options.
>>>>>  # To display the perf.data header info, please use --header/--header-only options.
>>>>>  #
>>>>>  #
>>>>>  # Total Lost Samples: 0
>>>>>  #
>>>>>  # Samples: 60K of event 'cycles'
>>>>>  # Event count (approx.): 35706225414
>>>>>  #
>>>>>  # Overhead  Command  Shared Object      Symbol
>>>>>  # ........  .......  .................  .............................................................................
>>>>>  #
>>>>>     21.07%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irq
>>>>>      8.23%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
>>>>>      6.67%  a.out    [kernel.kallsyms]  [k] filemap_map_pages
>>>>>      6.16%  a.out    [kernel.kallsyms]  [k] __zram_bvec_write
>>>>>      5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
>>>>>      3.71%  a.out    [kernel.kallsyms]  [k] _raw_spin_lock
>>>>>      3.49%  a.out    [kernel.kallsyms]  [k] memset64
>>>>>      1.63%  a.out    [kernel.kallsyms]  [k] clear_page
>>>>>      1.42%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock
>>>>>      1.26%  a.out    [kernel.kallsyms]  [k] mod_zone_state.llvm.8525150236079521930
>>>>>      1.23%  a.out    [kernel.kallsyms]  [k] xas_load
>>>>>      1.15%  a.out    [kernel.kallsyms]  [k] zram_slot_lock
>>>>>
>>>>> ptep_clear_flush() takes 5.36% CPU in the micro-benchmark
>>>>> swapping in/out a page mapped by only one process. If the
>>>>> page is mapped by multiple processes, typically, like more
>>>>> than 100 on a phone, the overhead would be much higher as
>>>>> we have to run tlb flush 100 times for one single page.
>>>>> Plus, tlb flush overhead will increase with the number
>>>>> of CPU cores due to the bad scalability of tlb shootdown
>>>>> in HW, so those ARM64 servers should expect much higher
>>>>> overhead.
>>>>>
>>>>> Further perf annonate shows 95% cpu time of ptep_clear_flush
>>>>> is actually used by the final dsb() to wait for the completion
>>>>> of tlb flush. This provides us a very good chance to leverage
>>>>> the existing batched tlb in kernel. The minimum modification
>>>>> is that we only send async tlbi in the first stage and we send
>>>>> dsb while we have to sync in the second stage.
>>>>>
>>>>> With the above simplest micro benchmark, collapsed time to
>>>>> finish the program decreases around 5%.
>>>>>
>>>>> Typical collapsed time w/o patch:
>>>>>  ~ # time taskset -c 4 ./a.out
>>>>>  0.21user 14.34system 0:14.69elapsed
>>>>> w/ patch:
>>>>>  ~ # time taskset -c 4 ./a.out
>>>>>  0.22user 13.45system 0:13.80elapsed
>>>>>
>>>>> Also, Yicong Yang added the following observation.
>>>>>       Tested with benchmark in the commit on Kunpeng920 arm64 server,
>>>>>       observed an improvement around 12.5% with command
>>>>>       `time ./swap_bench`.
>>>>>               w/o             w/
>>>>>       real    0m13.460s       0m11.771s
>>>>>       user    0m0.248s        0m0.279s
>>>>>       sys     0m12.039s       0m11.458s
>>>>>
>>>>>       Originally it's noticed a 16.99% overhead of ptep_clear_flush()
>>>>>       which has been eliminated by this patch:
>>>>>
>>>>>       [root@localhost yang]# perf record -- ./swap_bench && perf report
>>>>>       [...]
>>>>>       16.99%  swap_bench  [kernel.kallsyms]  [k] ptep_clear_flush
>>>>>
>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>> Cc: Nadav Amit <namit@vmware.com>
>>>>> Cc: Mel Gorman <mgorman@suse.de>
>>>>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>> Tested-by: Xin Hao <xhao@linux.alibaba.com>
>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>> ---
>>>>>  .../features/vm/TLB/arch-support.txt          |  2 +-
>>>>>  arch/arm64/Kconfig                            |  1 +
>>>>>  arch/arm64/include/asm/tlbbatch.h             | 12 ++++++++
>>>>>  arch/arm64/include/asm/tlbflush.h             | 28 +++++++++++++++++--
>>>>>  4 files changed, 40 insertions(+), 3 deletions(-)
>>>>>  create mode 100644 arch/arm64/include/asm/tlbbatch.h
>>>>>
>>>>> diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
>>>>> index 1c009312b9c1..2caf815d7c6c 100644
>>>>> --- a/Documentation/features/vm/TLB/arch-support.txt
>>>>> +++ b/Documentation/features/vm/TLB/arch-support.txt
>>>>> @@ -9,7 +9,7 @@
>>>>>      |       alpha: | TODO |
>>>>>      |         arc: | TODO |
>>>>>      |         arm: | TODO |
>>>>> -    |       arm64: | TODO |
>>>>> +    |       arm64: |  ok  |
>>>>>      |        csky: | TODO |
>>>>>      |     hexagon: | TODO |
>>>>>      |        ia64: | TODO |
>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>> index 571cc234d0b3..09d45cd6d665 100644
>>>>> --- a/arch/arm64/Kconfig
>>>>> +++ b/arch/arm64/Kconfig
>>>>> @@ -93,6 +93,7 @@ config ARM64
>>>>>       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>>>>       select ARCH_SUPPORTS_NUMA_BALANCING
>>>>>       select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>>>> +     select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>>>>>       select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>>>>>       select ARCH_WANT_DEFAULT_BPF_JIT
>>>>>       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>>>>> diff --git a/arch/arm64/include/asm/tlbbatch.h b/arch/arm64/include/asm/tlbbatch.h
>>>>> new file mode 100644
>>>>> index 000000000000..fedb0b87b8db
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/include/asm/tlbbatch.h
>>>>> @@ -0,0 +1,12 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +#ifndef _ARCH_ARM64_TLBBATCH_H
>>>>> +#define _ARCH_ARM64_TLBBATCH_H
>>>>> +
>>>>> +struct arch_tlbflush_unmap_batch {
>>>>> +     /*
>>>>> +      * For arm64, HW can do tlb shootdown, so we don't
>>>>> +      * need to record cpumask for sending IPI
>>>>> +      */
>>>>> +};
>>>>> +
>>>>> +#endif /* _ARCH_ARM64_TLBBATCH_H */
>>>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>>>> index 412a3b9a3c25..23cbc987321a 100644
>>>>> --- a/arch/arm64/include/asm/tlbflush.h
>>>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>>>> @@ -254,17 +254,24 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>>>>>       dsb(ish);
>>>>>  }
>>>>>
>>>>> -static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>>>>> +
>>>>> +static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>>>>>                                        unsigned long uaddr)
>>>>>  {
>>>>>       unsigned long addr;
>>>>>
>>>>>       dsb(ishst);
>>>>> -     addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>>>>> +     addr = __TLBI_VADDR(uaddr, ASID(mm));
>>>>>       __tlbi(vale1is, addr);
>>>>>       __tlbi_user(vale1is, addr);
>>>>>  }
>>>>>
>>>>> +static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>>>>> +                                      unsigned long uaddr)
>>>>> +{
>>>>> +     return __flush_tlb_page_nosync(vma->vm_mm, uaddr);
>>>>> +}
>>>>> +
>>>>>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>>>>>                                 unsigned long uaddr)
>>>>>  {
>>>>> @@ -272,6 +279,23 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>>>>>       dsb(ish);
>>>>>  }
>>>>>
>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>> +{
>>>>> +     return true;
>>>>> +}
>>>>
>>>> Always defer and batch up TLB flush, unconditionally ?
>>>
>>> My understanding is we actually don't need tlbbatch for a machine with one
>>> or two cores as the tlb flush is not expensive. even for a system with four
>>> cortex-a55 cores, i didn't see obvious cost. it was less than 1%.
>>> when we have 8 cores, we see the obvious cost of tlb flush. for a server with
>>> 100 crores, the cost is incredibly huge.
>>
>> Although dsb(ish) is deferred via arch_tlbbatch_flush(), there is still
>> one dsb(isht) instruction left in __flush_tlb_page_nosync(). Is not that
>> expensive as well, while queuing up individual TLB flushes ?
> 
> This one is much much cheaper as it is not waiting for the
> completion of tlbi. waiting for the completion of tlbi is a big
> deal in arm64, thus, similar optimization can be seen here
> 
> 3403e56b41c1("arm64: mm: Don't wait for completion of TLB invalidation
> when page aging").
> 
> 
>>
>> The very idea behind TLB deferral is the opportunity it (might) provide
>> to accumulate address ranges and cpu masks so that individual TLB flush
>> can be replaced with a more cost effective range based TLB flush. Hence
>> I guess unless address range or cpumask based cost effective TLB flush
>> is available, deferral does not improve the unmap performance as much.
> 
> 
> After sending tlbi, if we wait for the completion of tlbi, we have to get Ack
> from all cpus in the system, tlbi is not scalable. The point here is that we
> avoid waiting for each individual TLBi. Alternatively, they are batched. If
> you read the benchmark in the commit log, you can find the great decline
> in the cost to swap out a page.

Alright, although collecting and deferring 'dsb(ish)' to the very end, does
not feel like a direct fit case for ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH but I
guess it can be used to improve unmap performance on arm64.

But is this 'dsb(ish)' deferral architecturally valid ?

Let's examine single page unmap path via try_to_unmap_one(). 

should_defer_flush() {
	ptep_get_and_clear()		
	set_tlb_ubc_flush_pending()
		arch_tlbbatch_add_mm()
			__flush_tlb_page_nosync()
} else {
	ptep_clear_flush()
		ptep_get_and_clear()
		flush_tlb_page()
			flush_tlb_page_nosync()
				__flush_tlb_page_nosync()
			dsb(ish)
}

__flush_tlb_page_nosync()
{
	dsb(ishst);
	addr = __TLBI_VADDR(uaddr, ASID(mm));
 	__tlbi(vale1is, addr);
 	__tlbi_user(vale1is, addr);
}

Currently without TLB deferral, 'dsb(ish)' gets executed just after __tlbi()
and __tlbi_user(), because __flush_tlb_page_nosync() is an inline function.

#define __TLBI_0(op, arg) asm (ARM64_ASM_PREAMBLE                              \
                               "tlbi " #op "\n"                                \
                   ALTERNATIVE("nop\n                   nop",                  \
                               "dsb ish\n               tlbi " #op,            \
                               ARM64_WORKAROUND_REPEAT_TLBI,                   \
                               CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)            \
                            : : )

#define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE                              \
                               "tlbi " #op ", %0\n"                            \
                   ALTERNATIVE("nop\n                   nop",                  \
                               "dsb ish\n               tlbi " #op ", %0",     \
                               ARM64_WORKAROUND_REPEAT_TLBI,                   \
                               CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)            \
                            : : "r" (arg))

#define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)

#define __tlbi(op, ...)         __TLBI_N(op, ##__VA_ARGS__, 1, 0)

#define __tlbi_user(op, arg) do {                                               \
        if (arm64_kernel_unmapped_at_el0())                                     \
                __tlbi(op, (arg) | USER_ASID_FLAG);                             \
} while (0)

There is already a 'dsb(ish)' in between two subsequent TLB operations in
case ARM64_WORKAROUND_REPEAT_TLBI is detected on the system. Hence I guess
deferral should not enabled on such systems ?

But with deferral enabled, 'dsb(ish)' will be executed in arch_tlbbatch_flush()
via try_to_unmap_flush[_dirty](). There might be random number of instructions
in between __tlbi()/__tlbi_user() i.e 'tlbi' instructions and final 'dsb(ish)'.
Just wondering, if such 'detached in time with other instructions in between'
'tlbi' and 'dsb(ish)', is architecturally valid ?

There is a comment in 'struct tlbflush_unmap_batch'.

        /*
         * The arch code makes the following promise: generic code can modify a
         * PTE, then call arch_tlbbatch_add_mm() (which internally provides all
         * needed barriers), then call arch_tlbbatch_flush(), and the entries
         * will be flushed on all CPUs by the time that arch_tlbbatch_flush()
         * returns.
         */


It expects arch_tlbbatch_add_mm() to provide all barriers, hence wondering if
that would include just the first 'dsb(isht)' not the subsequent 'dsb(ish)' ?
