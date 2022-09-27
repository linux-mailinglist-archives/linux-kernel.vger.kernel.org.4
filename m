Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7275EC971
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiI0Q1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiI0Q1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:27:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A413E13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d82so10120440pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yKkZRQ4S6qF20ERKBmJQJhLjqhHD+FnPmS5gRtuu8Nw=;
        b=BfVWCwq3A98FgWmW2YP2YhIiDDZfq+9wvHK/SVvamBdDVwRiJSJXZAWOuC49eNIadC
         70oTqfAUXtDUkw+r5DiuaerFXnhM63K4RGlARclqe7cSjScTc2zcFE1gLQi5360gFM9X
         pS/OEiuZWHHAcZRMxEJ92XWyoNTqHMqo0Wt90VINfxZCksrDDRYE0iX8uSyi9+cVU4YP
         EcRKdemSPUn8dEB4V8IcVftG9Rqwg+XLdKbmJeNSKL/RmrSavCZGJQwrBpdLrjvENRz6
         sJK//cyfrXz2VbzrFaaEEPy6lW+4a65M1EWIcr8kkfrmmvoGXIXxgu3/olllgdLPQxa8
         5+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yKkZRQ4S6qF20ERKBmJQJhLjqhHD+FnPmS5gRtuu8Nw=;
        b=rD+sI51HlHDiosxUhJ9+QebLeYfYjKPNeCgmMQ2sGFRV2PlRUbWaov2fC0ZRX4razm
         mC0hnlh8MST6lIQR9ATCZ2FAVFoAM2cX3ktrpgCWPaznSqwdRZnWbhSecvUNOVaXeFKa
         qhpVKGrTB+8k0nP8vVJzb8tNX1mkKO7hbxDXAcNLyVh821Zh74hJ8gYM4BuEAFgpz1mL
         mNvSoxaWxOdAkMKM85/Kb3f5TvlSRsuLruR2ZhNemUkbHrYy6Pnm6UfX1gPYo018luKc
         WHJdV1wiPkQ+aaRJo5WKVMgmFNAcfCyQf1qxaDLt4xIXfMqyijZRgFZLVHaxeEDBA4SL
         ExFA==
X-Gm-Message-State: ACrzQf2gp3O43oJJV3PXRtVFj3tTuv1AWYNhhERoi7kfIaDIG3+vCK4M
        csyD/wExtsbzj9dnPP1iUgo=
X-Google-Smtp-Source: AMsMyM6mPKyKej3tNBQJuxd+/fOtxb+DSBurT9tbAj9KQ+cpy77jRew3c8KDHQPAp7p4c4k42YUZHA==
X-Received: by 2002:a63:8941:0:b0:43c:87ec:e2fb with SMTP id v62-20020a638941000000b0043c87ece2fbmr15113057pgd.518.1664296055658;
        Tue, 27 Sep 2022 09:27:35 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:27:35 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 0/9] Introduce Copy-On-Write to Page Table
Date:   Wed, 28 Sep 2022 00:29:48 +0800
Message-Id: <20220927162957.270460-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, copy-on-write is only used for the mapped memory; the child
process still needs to copy the entire page table from the parent
process during forking. The parent process might take a lot of time and
memory to copy the page table when the parent has a big page table
allocated. For example, the memory usage of a process after forking with
1 GB mapped memory is as follows:

              DEFAULT FORK
          parent         child
VmRSS:   1049688 kB    1048688 kB
VmPTE:      2096 kB       2096 kB

This patch introduces copy-on-write (COW) for the PTE level page tables.
COW PTE improves performance in the situation where the user needs
copies of the program to run on isolated environments. Feedback-based
fuzzers (e.g., AFL) and serverless/microservice frameworks are two major
examples. For instance, COW PTE achieves a 9.3x throughput increase when
running SQLite on a fuzzer (AFL). As COW PTE only boosts performance in
some cases, the patch adds a new sysctl, vm.cow_pte, with the input
process ID (PID) to allow the user to enable COW PTE for a specific
process.

To handle the page table state of each process that has a shared PTE
table, the patch introduces the concept of COW PTE table ownership. This
implementation uses the address of the PMD index to track the ownership
of the PTE table. This helps maintain the state of the COW PTE tables,
such as the RSS and pgtable_bytes. Some PTE tables (e.g., pinned pages
that reside in the table) still need to be copied immediately for
consistency with the current COW logic. As a result, a flag,
COW_PTE_OWNER_EXCLUSIVE, indicating whether a PTE table is exclusive
(i.e., only one task owns it at a time) is added to the table’s owner
pointer. Every time a PTE table is copied during the fork, the owner
pointer (and thus the exclusive flag) will be checked to determine
whether the PTE table can be shared across processes.

This patch uses a refcount to track the shared page table's lifetime.
Invoking fork with COW PTE will increase the refcount. A refcount=1
means that the page table is not currently shared with another process
but may be shared. And, when someone writes to the shared PTE table, it
will cause the write fault to break COW PTE. If the shared PTE table's
refcount is one, the process that triggers the fault will reuse the
shared PTE table. Otherwise, the process will decrease the refcount,
copy the information to a new PTE table or dereference all the
information and change the owner if they have the shared PTE table.

After applying COW to PTE, the memory usage after forking is as follows:

                 COW PTE
          parent         child
VmRSS:	 1049968 kB       2576 kB
VmPTE:	    2096 kB         44 kB

The results show that this patch significantly decreases memory usage.
Other improvements such as lower fork latency and page fault latency,
which are the major benefits, are discussed later.

Real-world applications
=======================

We run benchmarks of fuzzing and VM cloning. The experiments were done
with the normal fork or the fork with COW PTE.

With AFL (LLVM mode) and SQLite, COW PTE (503.67 execs/sec) achieves a
9.3x throughput increase over the normal fork version (53.86 execs/sec).

                   fork
     execs_per_sec     unix_time        time
count    26.000000  2.600000e+01   26.000000
mean     53.861538  1.663145e+09   84.423077
std       3.715063  5.911357e+01   59.113567
min      35.980000  1.663145e+09    0.000000
25%      54.440000  1.663145e+09   32.250000
50%      54.610000  1.663145e+09   82.000000
75%      54.837500  1.663145e+09  140.750000
max      55.600000  1.663145e+09  178.000000

                 COW PTE
     execs_per_sec     unix_time        time
count    36.000000  3.600000e+01   36.000000
mean    503.674444  1.663146e+09   88.916667
std      81.805271  5.369191e+01   53.691912
min      84.910000  1.663146e+09    0.000000
25%     472.952500  1.663146e+09   44.500000
50%     504.700000  1.663146e+09   89.000000
75%     553.367500  1.663146e+09  133.250000
max     568.270000  1.663146e+09  178.000000

With TriforceAFL which is for kernel fuzzing with QEMU, COW PTE
(124.31 execs/sec) achieves a 1.3x throughput increase over the
normal fork version (96.44 execs/sec).

                   fork
     execs_per_sec     unix_time        time
count    18.000000  1.800000e+01   18.000000
mean     96.436667  1.663146e+09   84.388889
std      25.260184  6.601795e+01   66.017947
min       6.590000  1.663146e+09    0.000000
25%      91.025000  1.663146e+09   21.250000
50%     100.350000  1.663146e+09   92.000000
75%     111.247500  1.663146e+09  146.750000
max     122.260000  1.663146e+09  169.000000

                 COW PTE
     execs_per_sec     unix_time        time
count    22.000000  2.200000e+01   22.000000
mean    124.305455  1.663147e+09   90.409091
std      32.508728  6.033846e+01   60.338457
min       6.590000  1.663146e+09    0.000000
25%     113.227500  1.663146e+09   26.250000
50%     122.435000  1.663147e+09  112.000000
75%     145.792500  1.663147e+09  141.500000
max     161.280000  1.663147e+09  168.000000

Comparison with uffd
====================

For RFC v1, David Hildenbrand mentioned that uffd-wp is a new way of
snapshotting in QEMU. There is some overlap between uffd and fork use
cases, such as database snapshotting. So the following microbenchmarks
also measure the overhead of uffd-wp and uffd-copy-page.

To be fair in terms of CPU usage, the uffd handlers are pinned to the
same core as the main thread. uffd-wp simulates the work QEMU does with
uffd-wp. It will store the page that causes the fault into a memory
buffer and remove write protection for that page. Also, uffd-copy-page
will allocate the memory and replace the original page that causes the
fault.

Microbenchmark - syscall/registering latency
=============================================

We run microbenchmarks to measure the latency of a fork syscall or
registering uffd with sizes of mapped memory ranging from 0 to 512 MB
for the use cases that focus on lowering startup time (e.g., serverless
frameworks). The results show that the latency of a normal fork and
registering uffd-wp reaches 10 ms and 3.9 ms respectively, while the
latency of registering uffd-copy-page is around 0.007 ms. The latency of
a fork with COW PTE is around 0.625 ms after 200 MB, which is
significantly lower than the normal fork/uffd-wp. In short, with 512 MB
mapped memory, COW PTE decreases latency by 93% for normal fork and 83%
for uffd-wp.

Microbenchmark - page fault latency
====================================

We conducted some microbenchmarks to measure page fault latency with
different patterns of accesses to a 512 MB memory buffer after forking
or registering uffd.

In the first experiment, the program accesses the entire 512 MB memory
by writing to all the pages consecutively. The experiment is done with
normal fork, fork with COW PTE, uffd-wp, and uffd-copy-page and
calculates the single access average latency. The result shows that the
page fault latency of COW PTE (0.000045 ms) is 59.5x faster than the
uffd-wp (0.002676 ms). The low uffd-wp performance is probably because
of the cost of switching between kernel and user mode. What is more
interesting is that COW PTE also improves the average page fault
latency. COW PTE page fault latency (0.000045 ms) is 16.5x lower than
the normal fork fault latency (0.000742 ms). Here are the raw numbers:

Page fault - Access to the entire 512 MB memory
fork mean: 0.000742 ms
COW PTE mean: 0.000045 ms
uffd (wp) mean: 0.002676 ms
uffd (copy-page) mean: 0.008667 ms

The second experiment simulates real-world applications with sparse
accesses. The program randomly accesses the memory by writing to one
random page 1 million times and calculates the average access time.
Since the number of fork and COW PTE are too close to each other, we
cannot simply conclude which one is faster, so we run both 100 times
to get the averages. The result shows that COW PTE (0.000027 ms) is
similar to normal fork (0.000028 ms) and is 2.3x faster than uffd-wp
(0.000060 ms).

Page fault - Random access
fork mean: 0.000028 ms
COW PTE mean: 0.000027 ms
uffd (wp) mean: 0.000060 ms
uffd (copy-page) mean: 0.002363 ms

All the tests were run with QEMU and the kernel was built with the
x86_64 default config.

Summary
=======

In summary, COW PTE reduces the memory footprint of processes and
improves the initialization and page fault latency for various
applications, which would be important to some frameworks that require
very low execution startup (e.g., serverless framework) or
high-throughput short executions of child processes (e.g., testing).

This patch is based on the paper "On-demand-fork: a microsecond fork
for memory-intensive and latency-sensitive applications" [1] from
Purdue University.

Any comments and suggestions are welcome.

Thanks,
Chih-En Lin

---

TODO list:
- Handle the file-backed and shmem with reclaim.
- Handle OOM, KSM, page table walker, and migration.
- Deal with TLB flush in the break COW PTE handler.

RFC v1 -> RFC v2
- Change the clone flag method to sysctl with PID.
- Change the MMF_COW_PGTABLE flag to two flags, MMF_COW_PTE and
  MMF_COW_PTE_READY, for the sysctl.
- Change the owner pointer to use the folio padding.
- Handle all the VMAs that cover the PTE table when doing the break COW PTE.
- Remove the self-defined refcount to use the _refcount for the page
  table page.
- Add the exclusive flag to let the page table only own by one task in
  some situations.
- Invalidate address range MMU notifier and start the write_seqcount
  when doing the break COW PTE.
- Handle the swap cache and swapoff.

RFC v1: https://lore.kernel.org/all/20220519183127.3909598-1-shiyn.lin@gmail.com/

[1] https://dl.acm.org/doi/10.1145/3447786.3456258

This patch is based on v6.0-rc5.

---

Chih-En Lin (9):
  mm: Add new mm flags for Copy-On-Write PTE table
  mm: pgtable: Add sysctl to enable COW PTE
  mm, pgtable: Add ownership to PTE table
  mm: Add COW PTE fallback functions
  mm, pgtable: Add a refcount to PTE table
  mm, pgtable: Add COW_PTE_OWNER_EXCLUSIVE flag
  mm: Add the break COW PTE handler
  mm: Handle COW PTE with reclaim algorithm
  mm: Introduce Copy-On-Write PTE table

 include/linux/mm.h             |   2 +
 include/linux/mm_types.h       |   5 +-
 include/linux/pgtable.h        | 140 +++++++++++++
 include/linux/rmap.h           |   2 +
 include/linux/sched/coredump.h |   8 +-
 kernel/fork.c                  |   5 +
 kernel/sysctl.c                |   8 +
 mm/Makefile                    |   2 +-
 mm/cow_pte.c                   |  39 ++++
 mm/gup.c                       |  13 +-
 mm/memory.c                    | 360 ++++++++++++++++++++++++++++++++-
 mm/mmap.c                      |   3 +
 mm/mremap.c                    |   3 +
 mm/page_vma_mapped.c           |   5 +
 mm/rmap.c                      |   2 +-
 mm/swapfile.c                  |   1 +
 mm/vmscan.c                    |   1 +
 17 files changed, 587 insertions(+), 12 deletions(-)
 create mode 100644 mm/cow_pte.c

-- 
2.37.3

