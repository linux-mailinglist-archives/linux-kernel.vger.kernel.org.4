Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C567D391
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjAZRyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAZRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:53:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A061F4BC;
        Thu, 26 Jan 2023 09:53:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so2524436pjl.0;
        Thu, 26 Jan 2023 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n192hm/L4uRs68EENWfUDYuKeHNwIAhNrH1oIJOJdPo=;
        b=hElnnUwAEXjPU1BMKqHU8Nbc5nyi2JcmAH76rGsl1zMxULVcq4BUAaP/1NF6fm2Qwq
         InontjRzWfvnNedHLbEfElVIh5rtVFwmkYbWpDEBZaXWUjs/rq2NLVPqyQyLJmjJQzh4
         nltLqoqFNXBGrZsXROXTqP6k3DD+UdRjizX/CzHln7bQZMhwCRsXKIsiYH55AhrxMsqI
         M/oPXPfxbpnO//3s8Zs/8GiJLARAB9fN/qgjJ95eJxHu+n9WlOxL2IY4/590KpGba4XD
         NAzTVHRm5iYQlJRdwj2of8lT4zrlZG4enNCm3mVNXjeSae0raXI/vcC3MWSe5LYgoMxy
         G+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n192hm/L4uRs68EENWfUDYuKeHNwIAhNrH1oIJOJdPo=;
        b=GuCD3kV+uMOTW+WiPm/sxOKJC012eaMZ5uNz8S4pUL1BjboBswEOXwg7mKhLkjGUGm
         5M6bmq8I9B6EgmukhbIY/Kq0zLSkYJYgs1Q9odmlyEGBguh+6DPkGEiRXiefoNH6fZOf
         lM9e8Qzab78dub5qh3Hyb0ITpE/tJQ9fZXT5TClIjY0ZTzjl6QSh1NAC4pZ6ZOcMLgQT
         hItnQpcLni1q2sPX4l33dL3QIP2aX+Nk3jM3rim4SxpIBL1DqOojZ852yMMJZ+1INWje
         eOGE4DVZAWqsAuuIi8uPoJJFpzztljTZFrUksOTUsOTCHRSvpX+gliYFhu+La1c8sl1m
         QWdA==
X-Gm-Message-State: AO0yUKU9Fej2xVpqDOkueeXqonHeIK+HP5v4G4PmM36uEhyb98oHqUC8
        gHe4NUI2E6MAR8rw22Y0Hxw=
X-Google-Smtp-Source: AK7set+3H/Cx43TB4eyf+4vgEpiUx/Qk3m7um1t94EtC9faczX5to4JK2c67kX0G+Mb2VpIwagYidQ==
X-Received: by 2002:a17:902:dacf:b0:196:2bf1:b68d with SMTP id q15-20020a170902dacf00b001962bf1b68dmr7722875plx.14.1674755637765;
        Thu, 26 Jan 2023 09:53:57 -0800 (PST)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b00196503444b0sm56169plb.43.2023.01.26.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:53:57 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v8 0/3] cachestat: a new syscall for page cache state of files
Date:   Thu, 26 Jan 2023 09:53:53 -0800
Message-Id: <20230126175356.1582123-1-nphamcs@gmail.com>
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
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
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
 30 files changed, 576 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c


base-commit: 1440f576022887004f719883acb094e7e0dd4944
prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
-- 
2.30.2
