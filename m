Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0316D063A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjC3NP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3NPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:15:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F3185
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:15:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ew6so76268676edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680182119;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+RaE4XYGB80qyrp/p+4bFb+Fa0YEMFoXvqdGvo2ZNk=;
        b=ONXxGaalDe5k0dNXrxQs6A83VtdJzzP4OKcKWnuh8i5+JhLWI1oobBWma0BSZIH4gS
         8VPji3BNZghO37zjNor7eRlKtWW14jqswEzhWfcVz0JZkvNOZ+IX/1gcM2KpVx+w3O6O
         vDTgzRqUzux4A4ne06K4njwlYrOgzxyizw0TBIetkoXoX8FTnn66JsOexZcrQnw3U/8/
         no7t0vBu5yQ3A17zsey22jnYZ6pGTqpACTEXEa8H14YOQfICLLxyUvDper0qcnmmlx8g
         yZAt0lUv5fj057/z5xe5FMu/5hg2b3Y0bvaE9O7aMwcfz9Vn9f8Ztki5xMOREV/hzjXt
         IHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182119;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+RaE4XYGB80qyrp/p+4bFb+Fa0YEMFoXvqdGvo2ZNk=;
        b=mgARFi+TcFxwpO3seUpsXB5Jd8DxD/AqnDhNZvaurxNptBZqbmhRCrNEtyihVVVPUt
         VSnKql6Ok3D+bPFsS+NWBi+vgH9NubpC8j3SYzGqsB3l+cBhfrZk2gCg8oCXIhshjDoZ
         3roB7XRIvxm9V5MVBh9W6ZLFNc8e3imZnp+BPRse/3Di8xLnCEFP4l7DWfZx9nObB34B
         /vyIuiC4F66/btUeOEksihCcZLDUFI/TdVZUZerNFLacxcPmKRAENfqdLFzxhkJaerpz
         Zq2KoaKJbT2XIa57Su5w8KWZ3BnyCV1T8q5GbfH0WQn4HCr7STSwfs0yfzBjW/McNMzt
         VVng==
X-Gm-Message-State: AAQBX9eyuVlf9h56FVUoFho4yBCBqt8buuY5gPDYA7SFe53ZAz+LHpKD
        mT/QE8iHh17rMFxfz74rhIKTrQ==
X-Google-Smtp-Source: AKy350bRsIS81O1P1wJbKuTM1etnYVXfc+LKORzx35R/lxw+WuJo/v00Kps9b6AB+jvBtSF6gFwsJg==
X-Received: by 2002:a17:907:1c21:b0:8dd:5710:a017 with SMTP id nc33-20020a1709071c2100b008dd5710a017mr30636860ejc.4.1680182119599;
        Thu, 30 Mar 2023 06:15:19 -0700 (PDT)
Received: from localhost ([95.148.15.55])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b009474ee5de37sm826782ejg.143.2023.03.30.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:15:19 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
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
References: <20230329035512.57392-1-yangyicong@huawei.com>
        <20230329035512.57392-3-yangyicong@huawei.com>
Date:   Thu, 30 Mar 2023 14:15:18 +0100
In-Reply-To: <20230329035512.57392-3-yangyicong@huawei.com> (Yicong Yang's
        message of "Wed, 29 Mar 2023 11:55:12 +0800")
Message-ID: <87cz4qwfbt.fsf_-_@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

Yicong Yang <yangyicong@huawei.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> on x86, batched and deferred tlb shootdown has lead to 90%
> performance increase on tlb shootdown. on arm64, HW can do
> tlb shootdown without software IPI. But sync tlbi is still
> quite expensive.
>
> Even running a simplest program which requires swapout can
> prove this is true,
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include <string.h>
>
>  int main()
>  {
>  #define SIZE (1 * 1024 * 1024)
>          volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                           MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>
>          memset(p, 0x88, SIZE);
>
>          for (int k = 0; k < 10000; k++) {
>                  /* swap in */
>                  for (int i = 0; i < SIZE; i += 4096) {
>                          (void)p[i];
>                  }
>
>                  /* swap out */
>                  madvise(p, SIZE, MADV_PAGEOUT);
>          }
>  }
>
> Perf result on snapdragon 888 with 8 cores by using zRAM
> as the swap block device.
>
>  ~ # perf record taskset -c 4 ./a.out
>  [ perf record: Woken up 10 times to write data ]
>  [ perf record: Captured and wrote 2.297 MB perf.data (60084 samples) ]
>  ~ # perf report
>  # To display the perf.data header info, please use --header/--header-only options.
>  # To display the perf.data header info, please use --header/--header-only options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 60K of event 'cycles'
>  # Event count (approx.): 35706225414
>  #
>  # Overhead  Command  Shared Object      Symbol
>  # ........  .......  .................  .............................................................................
>  #
>     21.07%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irq
>      8.23%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
>      6.67%  a.out    [kernel.kallsyms]  [k] filemap_map_pages
>      6.16%  a.out    [kernel.kallsyms]  [k] __zram_bvec_write
>      5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
>      3.71%  a.out    [kernel.kallsyms]  [k] _raw_spin_lock
>      3.49%  a.out    [kernel.kallsyms]  [k] memset64
>      1.63%  a.out    [kernel.kallsyms]  [k] clear_page
>      1.42%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock
>      1.26%  a.out    [kernel.kallsyms]  [k] mod_zone_state.llvm.8525150236079521930
>      1.23%  a.out    [kernel.kallsyms]  [k] xas_load
>      1.15%  a.out    [kernel.kallsyms]  [k] zram_slot_lock
>
> ptep_clear_flush() takes 5.36% CPU in the micro-benchmark
> swapping in/out a page mapped by only one process. If the
> page is mapped by multiple processes, typically, like more
> than 100 on a phone, the overhead would be much higher as
> we have to run tlb flush 100 times for one single page.
> Plus, tlb flush overhead will increase with the number
> of CPU cores due to the bad scalability of tlb shootdown
> in HW, so those ARM64 servers should expect much higher
> overhead.
>
> Further perf annonate shows 95% cpu time of ptep_clear_flush
> is actually used by the final dsb() to wait for the completion
> of tlb flush. This provides us a very good chance to leverage
> the existing batched tlb in kernel. The minimum modification
> is that we only send async tlbi in the first stage and we send
> dsb while we have to sync in the second stage.
>
> With the above simplest micro benchmark, collapsed time to
> finish the program decreases around 5%.
>
> Typical collapsed time w/o patch:
>  ~ # time taskset -c 4 ./a.out
>  0.21user 14.34system 0:14.69elapsed
> w/ patch:
>  ~ # time taskset -c 4 ./a.out
>  0.22user 13.45system 0:13.80elapsed
>
> Also, Yicong Yang added the following observation.
> 	Tested with benchmark in the commit on Kunpeng920 arm64 server,
> 	observed an improvement around 12.5% with command
> 	`time ./swap_bench`.
> 		w/o		w/
> 	real	0m13.460s	0m11.771s
> 	user	0m0.248s	0m0.279s
> 	sys	0m12.039s	0m11.458s
>
> 	Originally it's noticed a 16.99% overhead of ptep_clear_flush()
> 	which has been eliminated by this patch:
>
> 	[root@localhost yang]# perf record -- ./swap_bench && perf report
> 	[...]
> 	16.99%  swap_bench  [kernel.kallsyms]  [k] ptep_clear_flush
>
> It is tested on 4,8,128 CPU platforms and shows to be beneficial on
> large systems but may not have improvement on small systems like on
> a 4 CPU platform. So make ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH depends
> on CONFIG_EXPERT for this stage and make this disabled on systems
> with less than 8 CPUs. User can modify this threshold according to
> their own platforms by CONFIG_NR_CPUS_FOR_BATCHED_TLB.

The commit log and the patch disagree on the name of the config option
(CONFIG_NR_CPUS_FOR_BATCHED_TLB vs CONFIG_ARM64_NR_CPUS_FOR_BATCHED_TLB).

But more importantly, I was wondering why this posting doesn't address
Catalin's feedback [a] about using a runtime tunable. Maybe I missed the
follow-up discussion.

Thanks,
Punit

[a] https://lore.kernel.org/linux-mm/Y7xMhPTAwcUT4O6b@arm.com/

> Also this patch improve the performance of page migration. Using pmbench
> and tries to migrate the pages of pmbench between node 0 and node 1 for
> 20 times, this patch decrease the time used more than 50% and saved the
> time used by ptep_clear_flush().
>
> This patch extends arch_tlbbatch_add_mm() to take an address of the
> target page to support the feature on arm64. Also rename it to
> arch_tlbbatch_add_pending() to better match its function since we
> don't need to handle the mm on arm64 and add_mm is not proper.
> add_pending will make sense to both as on x86 we're pending the
> TLB flush operations while on arm64 we're pending the synchronize
> operations.
>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  .../features/vm/TLB/arch-support.txt          |  2 +-
>  arch/arm64/Kconfig                            |  6 +++
>  arch/arm64/include/asm/tlbbatch.h             | 12 +++++
>  arch/arm64/include/asm/tlbflush.h             | 52 ++++++++++++++++++-
>  arch/x86/include/asm/tlbflush.h               |  5 +-
>  include/linux/mm_types_task.h                 |  4 +-
>  mm/rmap.c                                     | 12 +++--
>  7 files changed, 81 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm64/include/asm/tlbbatch.h


[...]

