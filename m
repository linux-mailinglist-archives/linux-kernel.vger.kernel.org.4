Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381A6AFD5C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHD17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHD14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:27:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF282700;
        Tue,  7 Mar 2023 19:27:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so754105pjz.1;
        Tue, 07 Mar 2023 19:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678246071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/+PqUINQ//6SMKEaEI7/TJwTTa9y72VEOCQ2mIUhUA=;
        b=ez6hGB5qGNJMiD5UxRMvkGkKJxSWkolD9A0Rj2vtz1vLr38diPW8EUvgO7wIdy/qED
         PkGRkQLDLVzCbF6zGKxPooJ9rxoHblr0BuYGCWPdEl2in0HtHo3KFyuQ1sDFznmX6erW
         xRJ+iPBdblsImSsf1aCn9bkPIbkS5rYQD9jkaB+gwCMQUKw3X//AhrXZlZ0Ik3WtZx4Z
         W/CXCqdRuelnIqGT5fMk04dzLKG1e4yyTFYqFs9wUtKV4Cw5yT7ntCgZHixsFPXCavr1
         H5Gmb/uqySHwDkaeWBUjfHxmpjIwq6KVeeES/rMRuYB8UkbPiveXVbkWsWcGggQsfXCx
         D92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/+PqUINQ//6SMKEaEI7/TJwTTa9y72VEOCQ2mIUhUA=;
        b=DHsaKQISIlMqSKlPcxiVqWzR+7bVDkX29ymdmrPYJihC0W16pfNQE3YoBWd0CHJivQ
         1naxbJlf53rjCjiE5B0YmwLYEKoP3/EHiMiNN++PVi+cxOJUQHlTnGkqk0l6QoVK/FQP
         Qqrb+hzyCE4Ymcnd9cZdsBJOtBVAeAsLiLUk4rPuRHW4Quy0DKqh8gAGPLYg8OzKSHGt
         WfMaDMLHUcgj7/yt+p4PQoBxwoEGGeaqCu/z2P2HWHv7Ydgn6ZKt7SC+aNirErLP4O1m
         K7mm1koGIAQg2SiaZhrP7oqodewEUSaIkMC3ttYwFMloOLu3pW0XtnOTZxA+EzlMZOF+
         MLfw==
X-Gm-Message-State: AO0yUKUKKhUNwGkqWDyEt/JZhKrNsbq1zafC6zmpUlFanvrCAdmhUyXL
        iTUzbqaIvJRlk2LNMF03OCE=
X-Google-Smtp-Source: AK7set99AcARdeiEoEtTdABbOwCqnQWG8krt7O3NbPkb3yCS8JvGgDh0J4+qb7iDd6ccr1olNrinbw==
X-Received: by 2002:a17:90a:190d:b0:230:7a31:b9a6 with SMTP id 13-20020a17090a190d00b002307a31b9a6mr17824582pjg.7.1678246071482;
        Tue, 07 Mar 2023 19:27:51 -0800 (PST)
Received: from localhost ([113.161.42.54])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090a580100b00213202d77d9sm7839461pji.43.2023.03.07.19.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 19:27:51 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v11 0/3] cachestat: a new syscall for page cache state of files
Date:   Tue,  7 Mar 2023 19:27:45 -0800
Message-Id: <20230308032748.609510-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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
typical usage. Currently, the syscall is only wired in for x86
architecture.

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
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |   5 +-
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 166 +++++++++++
 mm/workingset.c                               | 145 ++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 257 ++++++++++++++++++
 16 files changed, 574 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c


base-commit: 1440f576022887004f719883acb094e7e0dd4944
prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
--
2.39.2
