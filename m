Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9246EB59D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjDUXO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjDUXOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:14:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67A1FDD;
        Fri, 21 Apr 2023 16:14:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a9253d4551so23524645ad.0;
        Fri, 21 Apr 2023 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682118863; x=1684710863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xv/2kclsGD89GAqCehsVLeXDFK4usBnjhSNfd0JqUI=;
        b=okHT+Kvv9o30UuAW1ii522SRwI5uailT685P5drlDTa5g/qkFqCPx6jaVWaAQZdnFU
         6zMJ9D+tRU83TUE5YWlUDS+2p4diBIXZt1SrUcA+dhZmsNzBm3T1MEDICBBdiusEUwTk
         MUaR6Kr55PSEH4hXgy3hi9ky0sOuyYFXNT6W4csSlKX2B+HdkzTkfbDq2SxV6/dztcmd
         K8uUkIII/C4tILBLXv1MNsw4hWIviNt6tsA1KsaO2+QplItT7rTZ/uCABpIeZckueD5y
         6e806ZgHMl0nERUegve0hwwu3CdOysYAZKxbb396i/KpwLKz4G0geR9mHb+S0EfRoD9a
         ZnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682118863; x=1684710863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Xv/2kclsGD89GAqCehsVLeXDFK4usBnjhSNfd0JqUI=;
        b=NvYslXs1H/e8HebG4dfb/22HxzRvVvrxRwinpV0pa3eixwwaymow9kjyQYDuv7KaYu
         VfjWFltMO/RiyMB5xdcwrf/yHvFkkknahacV7lI+ScHRCy7dLNyr8U2nvS9fjzPpCKua
         6uyILQJT+kYoDuymGYA3QSiW2zrZWisipD+xcxaKRqSzQALbZ2RraSMK1PFxHFGnZgER
         p0YwAFFF4vMtLZjOnJRXIO8+Gw2snv3e/u+oXtRddO8XdyFuiTdxi925dxeWqfowsiCS
         HTHUgVzhEyNBIJmkqvGFaehDDnNMfIyzZYT1UkOwr3+iycTbmo5gEF01Zny99C+KtBfg
         poLQ==
X-Gm-Message-State: AAQBX9druOHUCR8ODZTwhlLEr1vwry6vlvUjJQwpH0F28ezo/EKRIKQr
        aTVxEDoE9sc2dll4VLUf/eY=
X-Google-Smtp-Source: AKy350ZOdbY4zO3Y5PpHpFtiQ0duBTeD770anEevEnM288pOhK+Pfq2lG/mVyLB90alRSBEhZ8WO8A==
X-Received: by 2002:a17:903:22d0:b0:1a6:ed6f:d6b5 with SMTP id y16-20020a17090322d000b001a6ed6fd6b5mr7434968plg.38.1682118862851;
        Fri, 21 Apr 2023 16:14:22 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id jc1-20020a17090325c100b0019682e27995sm3162123plb.223.2023.04.21.16.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 16:14:22 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v12 0/3] cachestat: a new syscall for page cache state of files
Date:   Fri, 21 Apr 2023 16:14:18 -0700
Message-Id: <20230421231421.2401346-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v12:
  * Update the cover letter with more cachestat usecase and security
    concerns (suggested by Johannes Weiner and Andres Freund). 
  * Fix a bug that crashes cachestat when processing recently evicted
    pages.
  * Add a new benchmark for cachestat v.s mincore
v11:
  * Clean up code and comments/documentation.
    (patch 1 and 2) (suggested by Matthew Wilcox)
  * Drop support for hugetlbfs (patch 2)
    (from discussion with Johannes Weiner and Matthew Wilcox).
v10:
  * Reorder the arguments for archs with alignment requirements.
    (patch 2) (suggested by Arnd Bergmann)
v9:
  * Remove syscall from all the architectures syscall table except x86
    (patch 2)
  * API change: handle different cases for offset and add compat syscall.
    (patch 2) (suggested by Johannes Weiner and Arnd Bergmann)
v8:
  * Add syscall to mips syscall tables (detected by kernel test robot)
    (patch 2)
  * Add a missing return (suggested by Yu Zhao) (patch 2)
v7:
  * Fix and use lru_gen_test_recent (suggested by Brian Foster)
    (patch 2)
  * Small formatting and organizational fixes
v6:
  * Add a missing fdput() (suggested by Brian Foster) (patch 2)
  * Replace cstat_size with cstat_version (suggested by Brian Foster)
    (patch 2)
  * Add conditional resched to the xas walk. (suggested by Hillf Danton)
    (patch 2)
v5:
  * Separate first patch into its own series.
    (suggested by Andrew Morton)
  * Expose filemap_cachestat() to non-syscall usage
    (patch 2) (suggested by Brian Foster).
  * Fix some build errors from last version.
    (patch 2)
  * Explain eviction and recent eviction in the draft man page and
    documentation (suggested by Andrew Morton).
    (patch 2)
v4:
  * Refactor cachestat and move it to mm/filemap.c (patch 3)
    (suggested by Brian Foster)
  * Remove redundant checks (!folio, access_ok)
    (patch 3) (suggested by Matthew Wilcox and Al Viro)
  * Fix a bug in handling multipages folio.
    (patch 3) (suggested by Matthew Wilcox)
  * Add a selftest for shmem files, which can be used to test huge
    pages (patch 4) (suggested by Johannes Weiner)
v3:
  * Fix some minor formatting issues and build errors.
  * Add the new syscall entry to missing architecture syscall tables.
    (patch 3).
  * Add flags argument for the syscall. (patch 3).
  * Clean up the recency refactoring (patch 2) (suggested by Yu Zhao)
  * Add the new Kconfig (CONFIG_CACHESTAT) to disable the syscall.
    (patch 3) (suggested by Josh Triplett)
v2:
  * len == 0 means query to EOF. len < 0 is invalid.
    (patch 3) (suggested by Brian Foster)
  * Make cachestat extensible by adding the `cstat_size` argument in the
    syscall (patch 3)

There is currently no good way to query the page cache statistics of large
files and directory trees. There is mincore(), but it scales poorly: the
kernel writes out a lot of bitmap data that userspace has to aggregate,
when the user really does not care about per-page information in that
case. The user also needs to mmap and unmap each file as it goes along,
which can be quite slow as well.

Some use cases where this information could come in handy:
  * Allowing database to decide whether to perform an index scan or direct
    table queries based on the in-memory cache state of the index.
  * Visibility into the writeback algorithm, for performance issues
    diagnostic.
  * Workload-aware writeback pacing: estimating IO fulfilled by page cache
    (and IO to be done) within a range of a file, allowing for more
    frequent syncing when and where there is IO capacity, and batching
    when there is not.
  * Computing memory usage of large files/directory trees, analogous to
    the du tool for disk usage.

More information about these use cases could be found in this thread:
https://lore.kernel.org/lkml/20230315170934.GA97793@cmpxchg.org/

This series of patches introduces a new system call, cachestat, that
summarizes the page cache statistics (number of cached pages, dirty
pages, pages marked for writeback, evicted pages etc.) of a file, in a
specified range of bytes. It also include a selftest suite that tests some
typical usage. Currently, the syscall is only wired in for x86
architecture.

This interface is inspired by past discussion and concerns with fincore,
which has a similar design (and as a result, issues) as mincore.
Relevant links:

https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04207.html
https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04209.html


I have also developed a small tool that computes the memory usage of
files and directories, analogous to the du utility. User can choose
between mincore or cachestat (with cachestat exporting more information
than mincore). To compare the performance of these two options, I
benchmarked the tool on the root directory of a Meta's server machine,
each for five runs:

Using cachestat
real -- Median: 33.377s, Average: 33.475s, Standard Deviation: 0.3602
user -- Median: 4.08s, Average: 4.1078s, Standard Deviation: 0.0742
sys -- Median: 28.823s, Average: 28.8866s, Standard Deviation: 0.2689

Using mincore:
real -- Median: 102.352s, Average: 102.3442s, Standard Deviation: 0.2059
user -- Median: 10.149s, Average: 10.1482s, Standard Deviation: 0.0162
sys -- Median: 91.186s, Average: 91.2084s, Standard Deviation: 0.2046

I also ran both syscalls on a 2TB sparse file:

Using cachestat:
real    0m0.009s
user    0m0.000s
sys     0m0.009s

Using mincore:
real    0m37.510s
user    0m2.934s
sys     0m34.558s

Very large files like this are the pathological case for mincore. In fact,
to compute the stats for a single 2TB file, mincore takes as long as
cachestat takes to compute the stats for the entire tree! This could
easily happen inadvertently when we run it on subdirectories. Mincore is
clearly not suitable for a general-purpose command line tool.

Regarding security concerns, cachestat() should not pose any additional
issues. The caller already has read permission to the file itself (since
they need an fd to that file to call cachestat). This means that the
caller can access the underlying data in its entirety, which is a much
greater source of information (and as a result, a much greater security
risk) than the cache status itself.

This series consist of 3 patches:

Nhat Pham (3):
  workingset: refactor LRU refault to expose refault recency check
  cachestat: implement cachestat syscall
  selftests: Add selftests for cachestat

 MAINTAINERS                                   |   7 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |   4 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 179 ++++++++++++
 mm/workingset.c                               | 150 ++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 257 ++++++++++++++++++
 16 files changed, 590 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

-- 
2.34.1
