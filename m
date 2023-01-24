Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4946678E05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAXCLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:11:21 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE61A972;
        Mon, 23 Jan 2023 18:11:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s3so10237361pfd.12;
        Mon, 23 Jan 2023 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCGlc7mWURATKW4pBp/mMbnvAjkNxvQ5RvlFZ+5SXrA=;
        b=Q2OJ7E/ovDJZRJ1/WrC7I1yuDO3Hb6jh2iai0Os4K2WdyHqq0h1cH5JrkPYY0LyrTY
         7pubiTyoZItmkh0TVFAVAGmXnvHqYco6E/bJ9SAJWFGJV+UzGBvkYmb/zpo5/BffZziZ
         JaUWdDXTBbvbtQ1aNpDtvOl58OyifVwiKon0KX67c66ujtxL6CwZEzUbjnw8bOnoGm74
         8k3YxA5iHDZF2LERPK0k7Ti8XPJH2AN7w1s1gLDWa+ggmjT+8d+vp02GVoi90UC4ndJK
         Op15iN5zK7IgomVvrth+xB+TALm5s/EdbhomubldZ9LTG+Ta/mwoayP7RSJmJgZfUz5E
         2wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCGlc7mWURATKW4pBp/mMbnvAjkNxvQ5RvlFZ+5SXrA=;
        b=HdoAp+Bsx8vX5e7L8B2/r9SndAnGIMZ1YvqooPkKTaZa1SEE4H9C1Y0bAy1VIzG6X/
         SugfrlWNJRSxcO1yxnYrPlofjqZ6Y+EwoMQSIwIz2SOL43ymQYJUMlqaU1gY1yEmpIAD
         78ezb0om4i33vKsEP9WTWnfT/hXWr35aIKIVyaNxb+xYHQlvA3qEAJLX8aH/4TAY6ExT
         2ewr2saCJ62t2CR4RotMzMkzQel2Njx5kr1NCmKgiQkZPAUVX9iObdAOA5S5h9PoVOLy
         gm5+zD+b2yUMbXi5vjGyKi9y0AgE11adv0UB7mpsQI+de0VKro+QZUA//ORBwPtvtwwq
         uNaw==
X-Gm-Message-State: AFqh2koL26myySOIutpFUDCbfD6r+NxQ9XeuOVCjvjU0fj7y9gOq4EEV
        21JOxHY+CnPGg7mqG6zVx2k=
X-Google-Smtp-Source: AMrXdXssaRcK8VwNrNmgxgUxK3PVNJ9Gzeiag04Vn7nr3eYgvMh+HvBnpxQv18Cho9tj1oOKoXLqNQ==
X-Received: by 2002:a62:e406:0:b0:581:7430:aba with SMTP id r6-20020a62e406000000b0058174300abamr28478685pfh.10.1674526279369;
        Mon, 23 Jan 2023 18:11:19 -0800 (PST)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id z67-20020a626546000000b0058bacd6c4e8sm254143pfb.207.2023.01.23.18.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 18:11:18 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v7 0/3] cachestat: a new syscall for page cache state of files
Date:   Mon, 23 Jan 2023 18:11:15 -0800
Message-Id: <20230124021118.154078-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Changelog:
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

There is currently no good way to query the page cache state of large
file sets and directory trees. There is mincore(), but it scales poorly:
the kernel writes out a lot of bitmap data that userspace has to
aggregate, when the user really doesn not care about per-page information
in that case. The user also needs to mmap and unmap each file as it goes
along, which can be quite slow as well.

This series of patches introduces a new system call, cachestat, that
summarizes the page cache statistics (number of cached pages, dirty
pages, pages marked for writeback, evicted pages etc.) of a file, in a
specified range of bytes. It also include a selftest suite that tests some
typical usage

This interface is inspired by past discussion and concerns with fincore,
which has a similar design (and as a result, issues) as mincore.
Relevant links:

https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04207.html
https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04209.html

For comparison with mincore, I ran both syscalls on a 2TB sparse file:

Using mincore:
real    0m37.510s
user    0m2.934s
sys     0m34.558s

Using cachestat:
real    0m0.009s
user    0m0.000s
sys     0m0.009s

This series should be applied on top of:

workingset: fix confusion around eviction vs refault container
https://lkml.org/lkml/2023/1/4/1066

This series consist of 3 patches:

Nhat Pham (3):
  workingset: refactor LRU refault to expose refault recency check
  cachestat: implement cachestat syscall
  selftests: Add selftests for cachestat

 MAINTAINERS                                   |   7 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 include/linux/fs.h                            |   3 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   4 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 154 +++++++++++
 mm/workingset.c                               | 142 ++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 260 ++++++++++++++++++
 27 files changed, 573 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c


base-commit: 1440f576022887004f719883acb094e7e0dd4944
prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
-- 
2.30.2
