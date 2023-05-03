Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21866F4E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjECBgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:36:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB63273A;
        Tue,  2 May 2023 18:36:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b52ad6311so5084584b3a.2;
        Tue, 02 May 2023 18:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683077770; x=1685669770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eK7EP3PhnpKeG8yIcMbqBOheIajrQYO1zrUhdTc/GBg=;
        b=jAJHFHeVCCl0GyCwxZqRtbGjIBY/ntNtzqEp+53+mYcAsq0S58vk7XdH9ZYoPuQQnc
         9tExO3ze3q62po/Q7KXkPoZaD0MytncpngiFQ3VW+SacbYAb0TTizRCXgO13Xpk4bb2Z
         GgE1AARNqFDPw/VC2a8GrnF80/Eshca6G4Vig70arVXzBW6vWgJJdry8GB7Y9BgALOc1
         7HGvpf51XFIPNe35xy2nhoHvUvunGxOSzj23O2Sso2WBkDV2WXayrWXjNesadjlRERwx
         f4+isGNlbwOehNf5aeF7G2MgLwzj7nvokQxTAFqnYTrMpGz9ewo4L6iFcK2wrEqEUAM4
         ZRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683077770; x=1685669770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eK7EP3PhnpKeG8yIcMbqBOheIajrQYO1zrUhdTc/GBg=;
        b=Xz/GVWb2YMZtx/mo19udtIxuyF28SZ9ZdS3JjXbVfrmIDO3K5mfLWmxXg4WlOZeRMr
         OP+pWqO73vMtcrK4XKZS49ndp+oJuQnGnmehmIPe0EuOdhRVbIrZwhFmKcig4Yx7ZY1n
         w6+8TmSo1sD41CbbIob4iUKfLBZ0USeJJaLQXm0A4XsSpzftoM5BGBubX+q1uzZ9b2xY
         6O+L+cfCRSSGKVi6uEw54qcUZlV4pYSETH0ke6i28e023NFY3F8QmfvRzsgm/ZbhONip
         SQuMrN9oSZrrFiO4KN5XHEzf0xZ6BzkXnaDsMjsTs66k/tuNbwIGieRUQrtJXfZcSbtd
         VIFA==
X-Gm-Message-State: AC+VfDyxB9EKG1sUhvv43lAC+KhukoW8vmY9rQZFJp+lAF83wYked3TE
        ZBYoGgMSTI/3czsusl3GvQU=
X-Google-Smtp-Source: ACHHUZ5+wkVPlH2fEQpQ22VkYwS1v+uafEQ9Gfhh9fUzt60DqvP/nimxfxU9E267I9yeN4gtVxkotw==
X-Received: by 2002:aa7:88c7:0:b0:63b:8cbc:bc0f with SMTP id k7-20020aa788c7000000b0063b8cbcbc0fmr27350279pff.22.1683077769508;
        Tue, 02 May 2023 18:36:09 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id fe5-20020a056a002f0500b0062de9ef6915sm22128854pfb.216.2023.05.02.18.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 18:36:09 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v13 0/3] cachestat: a new syscall for page cache state of files
Date:   Tue,  2 May 2023 18:36:05 -0700
Message-Id: <20230503013608.2431726-1-nphamcs@gmail.com>
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
v13:
  * Change the API, putting the offset and length arguments into a
    struct, passing only a userspace address to the syscall. It allows
    for explicit 64 bit length. (suggested by Jens Axboe) (patch 2)
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

The latest API change (in v13 of the patch series) is suggested by
Jens Axboe. It allows for 64-bit length argument, even on 32-bit
architecture (which is previously not possible due to the limit on the
number of syscall arguments). Furthermore, it eliminates the need for
compatibility handling - every user can use the same ABI.

This series consist of 3 patches:

Nhat Pham (3):
  workingset: refactor LRU refault to expose refault recency check
  cachestat: implement cachestat syscall
  selftests: Add selftests for cachestat

 MAINTAINERS                                   |   7 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   5 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |  14 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 172 ++++++++++++
 mm/workingset.c                               | 150 ++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 258 ++++++++++++++++++
 15 files changed, 587 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

-- 
2.34.1
