Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7F6D0738
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjC3Np4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjC3Npy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:45:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B6740EC;
        Thu, 30 Mar 2023 06:45:48 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PnPky3hmRzKwFr;
        Thu, 30 Mar 2023 21:43:22 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 21:45:46 +0800
CC:     <yangyicong@hisilicon.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <x86@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <darren@os.amperecomputing.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, Barry Song <21cnbao@gmail.com>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>, <Jonathan.Cameron@Huawei.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v8 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Punit Agrawal <punit.agrawal@bytedance.com>
References: <20230329035512.57392-1-yangyicong@huawei.com>
 <20230329035512.57392-3-yangyicong@huawei.com> <87cz4qwfbt.fsf_-_@stealth>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <2687a998-6dbe-de8f-2f62-1456d2de7940@huawei.com>
Date:   Thu, 30 Mar 2023 21:45:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87cz4qwfbt.fsf_-_@stealth>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

On 2023/3/30 21:15, Punit Agrawal wrote:
> Hi Yicong,
> 
> Yicong Yang <yangyicong@huawei.com> writes:
> 
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> on x86, batched and deferred tlb shootdown has lead to 90%
>> performance increase on tlb shootdown. on arm64, HW can do
>> tlb shootdown without software IPI. But sync tlbi is still
>> quite expensive.
>>
>> Even running a simplest program which requires swapout can
>> prove this is true,
>>  #include <sys/types.h>
>>  #include <unistd.h>
>>  #include <sys/mman.h>
>>  #include <string.h>
>>
>>  int main()
>>  {
>>  #define SIZE (1 * 1024 * 1024)
>>          volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>>                                           MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>>
>>          memset(p, 0x88, SIZE);
>>
>>          for (int k = 0; k < 10000; k++) {
>>                  /* swap in */
>>                  for (int i = 0; i < SIZE; i += 4096) {
>>                          (void)p[i];
>>                  }
>>
>>                  /* swap out */
>>                  madvise(p, SIZE, MADV_PAGEOUT);
>>          }
>>  }
>>
>> Perf result on snapdragon 888 with 8 cores by using zRAM
>> as the swap block device.
>>
>>  ~ # perf record taskset -c 4 ./a.out
>>  [ perf record: Woken up 10 times to write data ]
>>  [ perf record: Captured and wrote 2.297 MB perf.data (60084 samples) ]
>>  ~ # perf report
>>  # To display the perf.data header info, please use --header/--header-only options.
>>  # To display the perf.data header info, please use --header/--header-only options.
>>  #
>>  #
>>  # Total Lost Samples: 0
>>  #
>>  # Samples: 60K of event 'cycles'
>>  # Event count (approx.): 35706225414
>>  #
>>  # Overhead  Command  Shared Object      Symbol
>>  # ........  .......  .................  .............................................................................
>>  #
>>     21.07%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irq
>>      8.23%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
>>      6.67%  a.out    [kernel.kallsyms]  [k] filemap_map_pages
>>      6.16%  a.out    [kernel.kallsyms]  [k] __zram_bvec_write
>>      5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
>>      3.71%  a.out    [kernel.kallsyms]  [k] _raw_spin_lock
>>      3.49%  a.out    [kernel.kallsyms]  [k] memset64
>>      1.63%  a.out    [kernel.kallsyms]  [k] clear_page
>>      1.42%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock
>>      1.26%  a.out    [kernel.kallsyms]  [k] mod_zone_state.llvm.8525150236079521930
>>      1.23%  a.out    [kernel.kallsyms]  [k] xas_load
>>      1.15%  a.out    [kernel.kallsyms]  [k] zram_slot_lock
>>
>> ptep_clear_flush() takes 5.36% CPU in the micro-benchmark
>> swapping in/out a page mapped by only one process. If the
>> page is mapped by multiple processes, typically, like more
>> than 100 on a phone, the overhead would be much higher as
>> we have to run tlb flush 100 times for one single page.
>> Plus, tlb flush overhead will increase with the number
>> of CPU cores due to the bad scalability of tlb shootdown
>> in HW, so those ARM64 servers should expect much higher
>> overhead.
>>
>> Further perf annonate shows 95% cpu time of ptep_clear_flush
>> is actually used by the final dsb() to wait for the completion
>> of tlb flush. This provides us a very good chance to leverage
>> the existing batched tlb in kernel. The minimum modification
>> is that we only send async tlbi in the first stage and we send
>> dsb while we have to sync in the second stage.
>>
>> With the above simplest micro benchmark, collapsed time to
>> finish the program decreases around 5%.
>>
>> Typical collapsed time w/o patch:
>>  ~ # time taskset -c 4 ./a.out
>>  0.21user 14.34system 0:14.69elapsed
>> w/ patch:
>>  ~ # time taskset -c 4 ./a.out
>>  0.22user 13.45system 0:13.80elapsed
>>
>> Also, Yicong Yang added the following observation.
>> 	Tested with benchmark in the commit on Kunpeng920 arm64 server,
>> 	observed an improvement around 12.5% with command
>> 	`time ./swap_bench`.
>> 		w/o		w/
>> 	real	0m13.460s	0m11.771s
>> 	user	0m0.248s	0m0.279s
>> 	sys	0m12.039s	0m11.458s
>>
>> 	Originally it's noticed a 16.99% overhead of ptep_clear_flush()
>> 	which has been eliminated by this patch:
>>
>> 	[root@localhost yang]# perf record -- ./swap_bench && perf report
>> 	[...]
>> 	16.99%  swap_bench  [kernel.kallsyms]  [k] ptep_clear_flush
>>
>> It is tested on 4,8,128 CPU platforms and shows to be beneficial on
>> large systems but may not have improvement on small systems like on
>> a 4 CPU platform. So make ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH depends
>> on CONFIG_EXPERT for this stage and make this disabled on systems
>> with less than 8 CPUs. User can modify this threshold according to
>> their own platforms by CONFIG_NR_CPUS_FOR_BATCHED_TLB.
> 
> The commit log and the patch disagree on the name of the config option
> (CONFIG_NR_CPUS_FOR_BATCHED_TLB vs CONFIG_ARM64_NR_CPUS_FOR_BATCHED_TLB).
> 

ah yes, it's a typo and I'll fix it.

> But more importantly, I was wondering why this posting doesn't address
> Catalin's feedback [a] about using a runtime tunable. Maybe I missed the
> follow-up discussion.
> 

I must have missed that, terribly sorry for it... Thanks for pointing it out!
Let me try to implement a version using a runtime tunable and get back with
some test results.

Thanks,
Yicong

> Thanks,
> Punit
> 
> [a] https://lore.kernel.org/linux-mm/Y7xMhPTAwcUT4O6b@arm.com/
> 
>> Also this patch improve the performance of page migration. Using pmbench
>> and tries to migrate the pages of pmbench between node 0 and node 1 for
>> 20 times, this patch decrease the time used more than 50% and saved the
>> time used by ptep_clear_flush().
>>
>> This patch extends arch_tlbbatch_add_mm() to take an address of the
>> target page to support the feature on arm64. Also rename it to
>> arch_tlbbatch_add_pending() to better match its function since we
>> don't need to handle the mm on arm64 and add_mm is not proper.
>> add_pending will make sense to both as on x86 we're pending the
>> TLB flush operations while on arm64 we're pending the synchronize
>> operations.
>>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>> Tested-by: Xin Hao <xhao@linux.alibaba.com>
>> Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  .../features/vm/TLB/arch-support.txt          |  2 +-
>>  arch/arm64/Kconfig                            |  6 +++
>>  arch/arm64/include/asm/tlbbatch.h             | 12 +++++
>>  arch/arm64/include/asm/tlbflush.h             | 52 ++++++++++++++++++-
>>  arch/x86/include/asm/tlbflush.h               |  5 +-
>>  include/linux/mm_types_task.h                 |  4 +-
>>  mm/rmap.c                                     | 12 +++--
>>  7 files changed, 81 insertions(+), 12 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/tlbbatch.h
> 
> 
> [...]
> 
> .
> 
