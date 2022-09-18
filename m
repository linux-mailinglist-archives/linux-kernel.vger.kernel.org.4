Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9C5BBC5B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIRIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIRIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF0B25E8F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y5-20020a25bb85000000b006af8f244604so15410250ybg.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=v3m094CgrDxvdHR4x0rpO2eFi/KIArXRDXN2zaxXjkA=;
        b=TxFB3bZpLjmexi2pt3Ev8lXKwRs5DgK47hlPYNwJ4PxIS63K/HJM8y26bCV3X9cf7Q
         rkLuyieaeYLQowqMxcpK1tP+smqew3XcrDXTLq+zvPLJMcRu174F2iyLr7lz2ams12Hq
         mvSdlEBsEdXPMJqRRDuS8/eqxgzLahGh7kAISqU43fu/iPyCl66pwE1Dkacgf/jb4hjB
         6sdgVt5nX2Zr5uzuiWzE90zkpFw3mQI7hBLou06vFPhzh0JJi3Ln5I7KFoo2SkVLc3Wp
         /LWs0HaG5XSkFYgnYDlZaNvZShjnwnWBc7keFuEL15fnlEcdiP/y2V2ymgHkCfTDfDV9
         8KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=v3m094CgrDxvdHR4x0rpO2eFi/KIArXRDXN2zaxXjkA=;
        b=TjaorhennFWYsKmwX2sJk2h9ZIgAvbk1UUCUnAeJWXEAxRD5Nn7q+Ef+ZgclJM2viS
         Rk4NGNBwy/GSkXzI14Mk69u9ppO0wrrrntP+JesxPvqwlMe95K0hhCoOuSt1ISkKR9zb
         U3yyGsenEeOcU01+BgMS6FcfSyeEspGkC/xJAuHqYVTZpd9H4XzoN834Y0i8/a4BeMSI
         QBvLjid1CZSghyECX5fviIv02dWaKGgqE16tuJhj7EIjakclG6Fi7cQXHSJhwuEN0Qc+
         KKyg4JL5GkG3tMYaZM4QL3ZBPF/uKDOihxE/0l3bPMPrnc/2i5iS2x7Og86IypgpIjrG
         bYQw==
X-Gm-Message-State: ACrzQf2UhSBg27VgmcOM5mnE7i7+VcKOcBhbHbvUnMLPF4FxXwHo+GKy
        TI2w6KkETYWkqoiThrfjbjVS3RAQN3E=
X-Google-Smtp-Source: AMsMyM6QXYth/xEgJIXNKVbYWFsdSRxl4TquSriq7jq2dDpVQZxdlawd7EGzGh80pcIp7nDNsV1QsBCsdr8=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a81:7992:0:b0:336:8015:4889 with SMTP id
 u140-20020a817992000000b0033680154889mr10627551ywc.80.1663488061170; Sun, 18
 Sep 2022 01:01:01 -0700 (PDT)
Date:   Sun, 18 Sep 2022 01:59:57 -0600
Message-Id: <20220918080010.2920238-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 00/14] Multi-Gen LRU Framework
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's new
==========
1. OpenWrt, in addition to Android, Arch Linux Zen, Armbian, ChromeOS,
   Liquorix, post-factum and XanMod, is now shipping MGLRU on 5.15.
2. Fixed long-tailed direct reclaim latency seen on high-memory (TBs)
   machines. The old direct reclaim backoff, which tries to enforce a
   minimum fairness among all eligible memcgs, over-swapped by about
   (total_mem>>DEF_PRIORITY)-nr_to_reclaim. The new backoff, which
   pulls the plug on swapping once the target is met, trades some
   fairness for curtailed latency:
   https://lore.kernel.org/r/20220918080010.2920238-10-yuzhao@google.com/
3. Fixed minior build warnings and conflicts. More comments and nits.

TLDR
====
The current page reclaim is too expensive in terms of CPU usage and it
often makes poor choices about what to evict. This patchset offers an
alternative solution that is performant, versatile and
straightforward.

Patchset overview
=================
The design and implementation overview is in patch 14:
https://lore.kernel.org/r/20220918080010.2920238-15-yuzhao@google.com/

01. mm: x86, arm64: add arch_has_hw_pte_young()
02. mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
Take advantage of hardware features when trying to clear the accessed
bit in many PTEs.

03. mm/vmscan.c: refactor shrink_node()
04. Revert "include/linux/mm_inline.h: fold __update_lru_size() into
    its sole caller"
Minor refactors to improve readability for the following patches.

05. mm: multi-gen LRU: groundwork
Adds the basic data structure and the functions that insert pages to
and remove pages from the multi-gen LRU (MGLRU) lists.

06. mm: multi-gen LRU: minimal implementation
A minimal implementation without optimizations.

07. mm: multi-gen LRU: exploit locality in rmap
Exploits spatial locality to improve efficiency when using the rmap.

08. mm: multi-gen LRU: support page table walks
Further exploits spatial locality by optionally scanning page tables.

09. mm: multi-gen LRU: optimize multiple memcgs
Optimizes the overall performance for multiple memcgs running mixed
types of workloads.

10. mm: multi-gen LRU: kill switch
Adds a kill switch to enable or disable MGLRU at runtime.

11. mm: multi-gen LRU: thrashing prevention
12. mm: multi-gen LRU: debugfs interface
Provide userspace with features like thrashing prevention, working set
estimation and proactive reclaim.

13. mm: multi-gen LRU: admin guide
14. mm: multi-gen LRU: design doc
Add an admin guide and a design doc.

Benchmark results
=================
Independent lab results
-----------------------
Based on the popularity of searches [01] and the memory usage in
Google's public cloud, the most popular open-source memory-hungry
applications, in alphabetical order, are:
      Apache Cassandra      Memcached
      Apache Hadoop         MongoDB
      Apache Spark          PostgreSQL
      MariaDB (MySQL)       Redis

An independent lab evaluated MGLRU with the most widely used benchmark
suites for the above applications. They posted 960 data points along
with kernel metrics and perf profiles collected over more than 500
hours of total benchmark time. Their final reports show that, with 95%
confidence intervals (CIs), the above applications all performed
significantly better for at least part of their benchmark matrices.

On 5.14:
1. Apache Spark [02] took 95% CIs [9.28, 11.19]% and [12.20, 14.93]%
   less wall time to sort three billion random integers, respectively,
   under the medium- and the high-concurrency conditions, when
   overcommitting memory. There were no statistically significant
   changes in wall time for the rest of the benchmark matrix.
2. MariaDB [03] achieved 95% CIs [5.24, 10.71]% and [20.22, 25.97]%
   more transactions per minute (TPM), respectively, under the medium-
   and the high-concurrency conditions, when overcommitting memory.
   There were no statistically significant changes in TPM for the rest
   of the benchmark matrix.
3. Memcached [04] achieved 95% CIs [23.54, 32.25]%, [20.76, 41.61]%
   and [21.59, 30.02]% more operations per second (OPS), respectively,
   for sequential access, random access and Gaussian (distribution)
   access, when THP=always; 95% CIs [13.85, 15.97]% and
   [23.94, 29.92]% more OPS, respectively, for random access and
   Gaussian access, when THP=never. There were no statistically
   significant changes in OPS for the rest of the benchmark matrix.
4. MongoDB [05] achieved 95% CIs [2.23, 3.44]%, [6.97, 9.73]% and
   [2.16, 3.55]% more operations per second (OPS), respectively, for
   exponential (distribution) access, random access and Zipfian
   (distribution) access, when underutilizing memory; 95% CIs
   [8.83, 10.03]%, [21.12, 23.14]% and [5.53, 6.46]% more OPS,
   respectively, for exponential access, random access and Zipfian
   access, when overcommitting memory.

On 5.15:
5. Apache Cassandra [06] achieved 95% CIs [1.06, 4.10]%, [1.94, 5.43]%
   and [4.11, 7.50]% more operations per second (OPS), respectively,
   for exponential (distribution) access, random access and Zipfian
   (distribution) access, when swap was off; 95% CIs [0.50, 2.60]%,
   [6.51, 8.77]% and [3.29, 6.75]% more OPS, respectively, for
   exponential access, random access and Zipfian access, when swap was
   on.
6. Apache Hadoop [07] took 95% CIs [5.31, 9.69]% and [2.02, 7.86]%
   less average wall time to finish twelve parallel TeraSort jobs,
   respectively, under the medium- and the high-concurrency
   conditions, when swap was on. There were no statistically
   significant changes in average wall time for the rest of the
   benchmark matrix.
7. PostgreSQL [08] achieved 95% CI [1.75, 6.42]% more transactions per
   minute (TPM) under the high-concurrency condition, when swap was
   off; 95% CIs [12.82, 18.69]% and [22.70, 46.86]% more TPM,
   respectively, under the medium- and the high-concurrency
   conditions, when swap was on. There were no statistically
   significant changes in TPM for the rest of the benchmark matrix.
8. Redis [09] achieved 95% CIs [0.58, 5.94]%, [6.55, 14.58]% and
   [11.47, 19.36]% more total operations per second (OPS),
   respectively, for sequential access, random access and Gaussian
   (distribution) access, when THP=always; 95% CIs [1.27, 3.54]%,
   [10.11, 14.81]% and [8.75, 13.64]% more total OPS, respectively,
   for sequential access, random access and Gaussian access, when
   THP=never.

Our lab results
---------------
To supplement the above results, we ran the following benchmark suites
on 5.16-rc7 and found no regressions [10].
      fs_fio_bench_hdd_mq      pft
      fs_lmbench               pgsql-hammerdb
      fs_parallelio            redis
      fs_postmark              stream
      hackbench                sysbenchthread
      kernbench                tpcc_spark
      memcached                unixbench
      multichase               vm-scalability
      mutilate                 will-it-scale
      nginx

[01] https://trends.google.com
[02] https://lore.kernel.org/r/20211102002002.92051-1-bot@edi.works/
[03] https://lore.kernel.org/r/20211009054315.47073-1-bot@edi.works/
[04] https://lore.kernel.org/r/20211021194103.65648-1-bot@edi.works/
[05] https://lore.kernel.org/r/20211109021346.50266-1-bot@edi.works/
[06] https://lore.kernel.org/r/20211202062806.80365-1-bot@edi.works/
[07] https://lore.kernel.org/r/20211209072416.33606-1-bot@edi.works/
[08] https://lore.kernel.org/r/20211218071041.24077-1-bot@edi.works/
[09] https://lore.kernel.org/r/20211122053248.57311-1-bot@edi.works/
[10] https://lore.kernel.org/r/20220104202247.2903702-1-yuzhao@google.com/

Read-world applications
=======================
Third-party testimonials
------------------------
Konstantin reported [11]:
   I have Archlinux with 8G RAM + zswap + swap. While developing, I
   have lots of apps opened such as multiple LSP-servers for different
   langs, chats, two browsers, etc... Usually, my system gets quickly
   to a point of SWAP-storms, where I have to kill LSP-servers,
   restart browsers to free memory, etc, otherwise the system lags
   heavily and is barely usable.
   
   1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU
   patchset, and I started up by opening lots of apps to create memory
   pressure, and worked for a day like this. Till now I had not a
   single SWAP-storm, and mind you I got 3.4G in SWAP. I was never
   getting to the point of 3G in SWAP before without a single
   SWAP-storm.

Vaibhav from IBM reported [12]:
   In a synthetic MongoDB Benchmark, seeing an average of ~19%
   throughput improvement on POWER10(Radix MMU + 64K Page Size) with
   MGLRU patches on top of 5.16 kernel for MongoDB + YCSB across
   three different request distributions, namely, Exponential, Uniform
   and Zipfan.

Shuang from U of Rochester reported [13]:
   With the MGLRU, fio achieved 95% CIs [38.95, 40.26]%, [4.12, 6.64]%
   and [9.26, 10.36]% higher throughput, respectively, for random
   access, Zipfian (distribution) access and Gaussian (distribution)
   access, when the average number of jobs per CPU is 1; 95% CIs
   [42.32, 49.15]%, [9.44, 9.89]% and [20.99, 22.86]% higher
   throughput, respectively, for random access, Zipfian access and
   Gaussian access, when the average number of jobs per CPU is 2.

Daniel from Michigan Tech reported [14]:
   With Memcached allocating ~100GB of byte-addressable Optante,
   performance improvement in terms of throughput (measured as queries
   per second) was about 10% for a series of workloads.

Large-scale deployments
-----------------------
We've rolled out MGLRU to tens of millions of ChromeOS users and
about a million Android users. Google's fleetwide profiling [15] shows
an overall 40% decrease in kswapd CPU usage, in addition to
improvements in other UX metrics, e.g., an 85% decrease in the number
of low-memory kills at the 75th percentile and an 18% decrease in
app launch time at the 50th percentile.

The downstream kernels that have been using MGLRU include:
1. Android [16]
2. Arch Linux Zen [17]
3. Armbian [18]
4. ChromeOS [19]
5. Liquorix [20]
6. OpenWrt [21]
7. post-factum [22]
8. XanMod [23]

[11] https://lore.kernel.org/r/140226722f2032c86301fbd326d91baefe3d7d23.camel@yandex.ru/
[12] https://lore.kernel.org/r/87czj3mux0.fsf@vajain21.in.ibm.com/
[13] https://lore.kernel.org/r/20220105024423.26409-1-szhai2@cs.rochester.edu/
[14] https://lore.kernel.org/r/CA+4-3vksGvKd18FgRinxhqHetBS1hQekJE2gwco8Ja-bJWKtFw@mail.gmail.com/
[15] https://dl.acm.org/doi/10.1145/2749469.2750392
[16] https://android.com
[17] https://archlinux.org
[18] https://armbian.com
[19] https://chromium.org
[20] https://liquorix.net
[21] https://openwrt.org
[22] https://codeberg.org/pf-kernel
[23] https://xanmod.org

Summery
=======
The facts are:
1. The independent lab results and the real-world applications
   indicate substantial improvements; there are no known regressions.
2. Thrashing prevention, working set estimation and proactive reclaim
   work out of the box; there are no equivalent solutions.
3. There is a lot of new code; no smaller changes have been
   demonstrated similar effects.

Our options, accordingly, are:
1. Given the amount of evidence, the reported improvements will likely
   materialize for a wide range of workloads.
2. Gauging the interest from the past discussions, the new features
   will likely be put to use for both personal computers and data
   centers.
3. Based on Google's track record, the new code will likely be well
   maintained in the long term. It'd be more difficult if not
   impossible to achieve similar effects with other approaches.

Yu Zhao (14):
  mm: x86, arm64: add arch_has_hw_pte_young()
  mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
  mm/vmscan.c: refactor shrink_node()
  Revert "include/linux/mm_inline.h: fold __update_lru_size() into its
    sole caller"
  mm: multi-gen LRU: groundwork
  mm: multi-gen LRU: minimal implementation
  mm: multi-gen LRU: exploit locality in rmap
  mm: multi-gen LRU: support page table walks
  mm: multi-gen LRU: optimize multiple memcgs
  mm: multi-gen LRU: kill switch
  mm: multi-gen LRU: thrashing prevention
  mm: multi-gen LRU: debugfs interface
  mm: multi-gen LRU: admin guide
  mm: multi-gen LRU: design doc

 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/admin-guide/mm/multigen_lru.rst |  162 +
 Documentation/mm/index.rst                    |    1 +
 Documentation/mm/multigen_lru.rst             |  159 +
 arch/Kconfig                                  |    8 +
 arch/arm64/include/asm/pgtable.h              |   15 +-
 arch/x86/Kconfig                              |    1 +
 arch/x86/include/asm/pgtable.h                |    9 +-
 arch/x86/mm/pgtable.c                         |    5 +-
 fs/exec.c                                     |    2 +
 fs/fuse/dev.c                                 |    3 +-
 include/linux/cgroup.h                        |   15 +-
 include/linux/memcontrol.h                    |   36 +
 include/linux/mm.h                            |    5 +
 include/linux/mm_inline.h                     |  231 +-
 include/linux/mm_types.h                      |   76 +
 include/linux/mmzone.h                        |  214 ++
 include/linux/nodemask.h                      |    1 +
 include/linux/page-flags-layout.h             |   16 +-
 include/linux/page-flags.h                    |    4 +-
 include/linux/pgtable.h                       |   17 +-
 include/linux/sched.h                         |    4 +
 include/linux/swap.h                          |    4 +
 kernel/bounds.c                               |    7 +
 kernel/cgroup/cgroup-internal.h               |    1 -
 kernel/exit.c                                 |    1 +
 kernel/fork.c                                 |    9 +
 kernel/sched/core.c                           |    1 +
 mm/Kconfig                                    |   26 +
 mm/huge_memory.c                              |    3 +-
 mm/internal.h                                 |    1 +
 mm/memcontrol.c                               |   28 +
 mm/memory.c                                   |   39 +-
 mm/mm_init.c                                  |    6 +-
 mm/mmzone.c                                   |    2 +
 mm/rmap.c                                     |    6 +
 mm/swap.c                                     |   54 +-
 mm/vmscan.c                                   | 2995 ++++++++++++++++-
 mm/workingset.c                               |  110 +-
 39 files changed, 4122 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
 create mode 100644 Documentation/mm/multigen_lru.rst


base-commit: 6cf215f1d5dac59a5a09514138ca37aed2719d0a
-- 
2.37.3.968.ga6b4b080e4-goog

