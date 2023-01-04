Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC9565E0C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjADXMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjADXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:11:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED34435C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:11:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl14so1454024pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 15:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B01nNF6+kAsKxYPfPU/0+WQhCbAoy0WeTmIq8oeqfFU=;
        b=JiUO5mHSM/MIxGODEHrg/AoXwcS8ykkc7cqXOu6R17bTnhr/sxC80tsMyFwM3GSy0N
         TGUlhJqg6mI6r8OQxOaVw2psyT5SqCfYcaBfY8NrQFHUqXdx/ClXgMpwUW8xDQUqWpBf
         6nLcUbQ5qEKGfNCnhgQG3Qo9NX51HteWTPJiZz6BQMKD/K4jAc52MjY993hSqYNCWpUd
         Ma7cG7D+1OliPk6NJjprZ395u57GtYGT3wBsD8H3+mS83uLagLvrvC9ntylFWb4IjcNu
         dV0qfBX8vSkEaUFyhweRVmpqN4dCl/IWZWkBl5SwKsUNC0E6nGtzJw+7C5dnsec4TmUu
         yV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B01nNF6+kAsKxYPfPU/0+WQhCbAoy0WeTmIq8oeqfFU=;
        b=CBanTvVm/QtQpZJroyy0QSJsB1QRhVcIVok81HyJPSQGrMifHcWcbypPXu62frGID5
         79HqQVm4ln1BnbFG6Z7DGbv12RF7I3JP1XDQKf0YsPGsKn6rFDq+XoqDia2PIOHVk0Rc
         jpHeGHEEl25OoG3pZr0vI9Gu6otm08+H9p8VRZkMDez2whEewyMq9+PvFcOS2d5uDlle
         OmanZg+tAQ6uubjU22a5PFsP0LvQbQG5RDKCeP1oHdeTontZK+E5Hqw2VvgmNIuTeJBx
         C5IW263jo+uvmjhip1W4t8gbdC4hk+Fj4WweUS+GjVCjnGnZ+wHN7gj8XjC/PC56KRTJ
         Lo3A==
X-Gm-Message-State: AFqh2kpSw+pLDO8xMHYTiL+BFsCeCvCNGH86IVrHD2DPA/i4NdBr3p+I
        KLKJniLNj08mIB4p42fEpSU=
X-Google-Smtp-Source: AMrXdXu9OtNw7kC4ZerWZaqKJgogMCk/OiL0NNs4/nqn/3V8BlR2QnHZyoJulj8Z0gkiemu9zjXdFg==
X-Received: by 2002:a05:6a20:e615:b0:a3:5864:e0c5 with SMTP id my21-20020a056a20e61500b000a35864e0c5mr65770842pzb.9.1672873888381;
        Wed, 04 Jan 2023 15:11:28 -0800 (PST)
Received: from localhost (fwdproxy-prn-022.fbsv.net. [2a03:2880:ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id p26-20020a631e5a000000b004768ce9e4fasm20955212pgm.59.2023.01.04.15.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 15:11:27 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v5 0/3] cachestat: a new syscall for page cache state of files
Date:   Wed,  4 Jan 2023 15:11:24 -0800
Message-Id: <20230104231127.2634648-1-nphamcs@gmail.com>
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
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 143 ++++++++++
 mm/workingset.c                               | 129 ++++++---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 259 ++++++++++++++++++
 27 files changed, 555 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c


base-commit: 1440f576022887004f719883acb094e7e0dd4944
prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
-- 
2.30.2
