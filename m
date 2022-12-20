Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC577651B89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiLTHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiLTHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:07 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA311826
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 62so7751761pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivJNJ9jaeQc47Jt63ij6NzHzbyTH4e1n0542myG3X6E=;
        b=XoNmxyn9xXkS1f6ccKEsVNPgdzoA6RyXsCmYJab5ybxiqX666A5NcHYVab5dIMIvT3
         itszokr3+eSK/Ln5rrQQVjiZZdjhP63/MO25QMuor9J3TesItJM0C4kezUFUubiz/kQQ
         1qIXbNFxsmNvlCg6AXPZ0JGly5OlX/ya0GEYQ1Py/qPM7F8Hgt1zhOR5zxHcpmLaGrB9
         bx3uEm1zrJnH3gDxrEXYQ50mdd7McWfDFd0jGO7eCDv9vd+2hMMZd9mZohVM6pNUKi6J
         KuB3/v4qXNKF6ZTp6SJiC2eUQxL35T9d9M4Ze98wzt8lcz9nQdTYCGyfycyQf3XNEv55
         /P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivJNJ9jaeQc47Jt63ij6NzHzbyTH4e1n0542myG3X6E=;
        b=kYVpddhXz+y2unbRksjl/JsBiAFMsKIZaEQfW/8mLjsrww5ckJToK4GJ2dBn9ifJJq
         38bXK5QtWBbz5JOIFM/2dTLFkPeGUcTTc53XKzkAHUwyc+HiET5uj4V35vAOza7ScqQJ
         ggzw121xghxfAsTE7dD9cCuw0ojT+lc1FLH4iaRe5XMUusssNuab119kGLtGkLa6pBd1
         mPCBtd4xvsf4FymtGtVOHRUTzt0cCkve9V5ywXSYEYEV6aovj/+CjD+/wKA7yPNxEqDH
         8EAd+tTeQDhHKAgSa+2SUFZVYHCRYkgA0h3U06fl0SjVMX3IM4AGCPoXknnIiULo6+Og
         iILQ==
X-Gm-Message-State: ANoB5pmVYUqw1GXpfpsd5in/pHMNYxitnaY18h+Eneuu3kCDHaUC+4Rb
        yOStqOhbCPzoUHTCIpHDYQw=
X-Google-Smtp-Source: AA0mqf6u//gTEjfJmtqVz2ub/KoOa1/C5nKAOxzjYqVxBhftlilJtTcIdc/ZaLbKf+890FFfrCJgog==
X-Received: by 2002:aa7:96d4:0:b0:576:8e8d:6675 with SMTP id h20-20020aa796d4000000b005768e8d6675mr50980493pfq.19.1671521104644;
        Mon, 19 Dec 2022 23:25:04 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:25:04 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Brian Geffon <bgeffon@google.com>, Yu Zhao <yuzhao@google.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Barret Rhoden <brho@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v3 00/14] Introduce Copy-On-Write to Page Table
Date:   Tue, 20 Dec 2022 15:27:29 +0800
Message-Id: <20221220072743.3039060-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

RFC v2 -> v3
- Change the sysctl with PID to prctl(PR_SET_COW_PTE).
- Account all the COW PTE mapped pages in fork() instead of defer it to
  page fault (break COW PTE).
- If there is an unshareable mapped page (maybe pinned or private
  device), recover all the entries that are already handled by COW PTE
  fork, then copy to the new one.
- Remove COW_PTE_OWNER_EXCLUSIVE flag and handle the only case of GUP,
  follow_pfn_pte().
- Remove the PTE ownership since we don't need it.
- Use pte lock to protect the break COW PTE and free COW-ed PTE.
- Do TLB flushing in break COW PTE handler.
- Handle THP, KSM, madvise, mprotect, uffd and migrate device.
- Handle the replacement page of uprobe.
- Handle the clear_refs_write() of fs/proc.
- All of the benchmarks dropped since the accounting and pte lock.
  The benchmarks of v3 is worse than RFC v2, most of the cases are
  similar to the normal fork, but there still have an use case
  (TriforceAFL) is better than the normal fork version.

RFC v2: https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.lin@gmail.com/T/

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

---

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
examples. For instance, COW PTE achieves a 1.03x throughput increase
when running TriforceAFL.

After applying COW to PTE, the memory usage after forking is as follows:

                 COW PTE
          parent         child
VmRSS:	 1049968 kB       2576 kB
VmPTE:	    2096 kB         44 kB

The results show that this patch significantly decreases memory usage.
The other number of latencies are discussed later.

Real-world application benchmarks
=================================

We run benchmarks of fuzzing and VM cloning. The experiments were
done with the normal fork or the fork with COW PTE.

With AFL (LLVM mode) and SQLite, COW PTE (52.15 execs/sec) is a
little bit worse than the normal fork version (53.50 execs/sec).

                   fork
       execs_per_sec     unix_time        time
count    28.000000  2.800000e+01   28.000000
mean     53.496786  1.671270e+09   96.107143
std       3.625060  7.194717e+01   71.947172
min      35.350000  1.671270e+09    0.000000
25%      53.967500  1.671270e+09   33.750000
50%      54.235000  1.671270e+09   92.000000
75%      54.525000  1.671270e+09  149.250000
max      55.100000  1.671270e+09  275.000000

                 COW PTE
       execs_per_sec     unix_time        time
count    34.000000  3.400000e+01   34.000000
mean     52.150000  1.671268e+09  103.323529
std       3.218271  7.507682e+01   75.076817
min      34.250000  1.671268e+09    0.000000
25%      52.500000  1.671268e+09   42.250000
50%      52.750000  1.671268e+09   94.500000
75%      52.952500  1.671268e+09  150.750000
max      53.680000  1.671268e+09  285.000000


With TriforceAFL which is for kernel fuzzing with QEMU, COW PTE
(105.54 execs/sec) achieves a 1.05x throughput increase over the
normal fork version (102.30 execs/sec).

                   fork
     execs_per_sec     unix_time        time
count    38.000000  3.800000e+01   38.000000
mean    102.299737  1.671269e+09  156.289474
std      20.139268  8.717113e+01   87.171130
min       6.600000  1.671269e+09    0.000000
25%      95.657500  1.671269e+09   82.250000
50%     109.950000  1.671269e+09  176.500000
75%     113.972500  1.671269e+09  223.750000
max     118.790000  1.671269e+09  281.000000

                 COW PTE
     execs_per_sec     unix_time        time
count    42.000000  4.200000e+01   42.000000
mean    105.540714  1.671269e+09  163.476190
std      19.443517  8.858845e+01   88.588453
min       6.200000  1.671269e+09    0.000000
25%      96.585000  1.671269e+09  123.500000
50%     113.925000  1.671269e+09  180.500000
75%     116.940000  1.671269e+09  233.500000
max     121.090000  1.671269e+09  286.000000

Microbenchmark - syscall latency
================================

We run microbenchmarks to measure the latency of a fork syscall with
sizes of mapped memory ranging from 0 to 512 MB. The results show that
the latency of a normal fork reaches 10 ms. The latency of a fork with
COW PTE is also around 10 ms.

Microbenchmark - page fault latency
====================================

We conducted some microbenchmarks to measure page fault latency with
different patterns of accesses to a 512 MB memory buffer after forking.

In the first experiment, the program accesses the entire 512 MB memory
by writing to all the pages consecutively. The experiment is done with
normal fork, fork with COW PTE and calculates the single access average
latency. COW PTE page fault latency (0.000795 ms) and the normal fork
fault latency (0.000770 ms). Here are the raw numbers:

Page fault - Access to the entire 512 MB memory

fork mean: 0.000770 ms
fork median: 0.000769 ms
fork std: 0.000010 ms

COW PTE mean: 0.000795 ms
COW PTE median: 0.000795 ms
COW PTE std: 0.000009 ms

The second experiment simulates real-world applications with sparse
accesses. The program randomly accesses the memory by writing to one
random page 1 million times and calculates the average access time,
after that, we run both 100 times to get the averages. The result shows
that COW PTE (0.000029 ms) is similar to the normal fork (0.000026 ms).

Page fault - Random access

fork mean: 0.000026 ms
fork median: 0.000025 ms
fork std: 0.000002 ms

COW PTE mean: 0.000029 ms
COW PTE median: 0.000026 ms
COW PTE std: 0.000004 ms

All the tests were run with QEMU and the kernel was built with
the x86_64 default config.

Summary
=======

In summary, COW PTE reduces the memory footprint of processes and
improves the performance for some use cases.

This patch is based on the paper "On-demand-fork: a microsecond fork
for memory-intensive and latency-sensitive applications" [1] from
Purdue University.

Any comments and suggestions are welcome.

Thanks,
Chih-En Lin

---

[1] https://dl.acm.org/doi/10.1145/3447786.3456258

This patch is based on v6.1-rc7.

---

Chih-En Lin (14):
  mm: Allow user to control COW PTE via prctl
  mm: Add Copy-On-Write PTE to fork()
  mm: Add break COW PTE fault and helper functions
  mm/rmap: Break COW PTE in rmap walking
  mm/khugepaged: Break COW PTE before scanning pte
  mm/ksm: Break COW PTE before modify shared PTE
  mm/madvise: Handle COW-ed PTE with madvise()
  mm/gup: Break COW PTE in follow_pfn_pte()
  mm/mprotect: Break COW PTE before changing protection
  mm/userfaultfd: Support COW PTE
  mm/migrate_device: Support COW PTE
  fs/proc: Support COW PTE with clear_refs_write
  events/uprobes: Break COW PTE before replacing page
  mm: fork: Enable COW PTE to fork system call

 fs/proc/task_mmu.c                 |   3 +
 include/linux/mm.h                 |  20 +
 include/linux/pgtable.h            |   6 +
 include/linux/rmap.h               |   2 +
 include/linux/sched/coredump.h     |  12 +-
 include/trace/events/huge_memory.h |   1 +
 include/uapi/linux/prctl.h         |   6 +
 kernel/events/uprobes.c            |   2 +-
 kernel/fork.c                      |   5 +
 kernel/sys.c                       |  11 +
 mm/gup.c                           |   2 +
 mm/khugepaged.c                    |  23 ++
 mm/ksm.c                           |   4 +-
 mm/madvise.c                       |  13 +
 mm/memory.c                        | 582 ++++++++++++++++++++++++++++-
 mm/migrate.c                       |   3 +-
 mm/migrate_device.c                |   2 +
 mm/mmap.c                          |   4 +
 mm/mprotect.c                      |   9 +
 mm/mremap.c                        |   2 +
 mm/page_vma_mapped.c               |   2 +
 mm/rmap.c                          |  12 +-
 mm/swapfile.c                      |   2 +
 mm/userfaultfd.c                   |   6 +
 mm/vmscan.c                        |   7 +-
 25 files changed, 725 insertions(+), 16 deletions(-)

-- 
2.37.3

