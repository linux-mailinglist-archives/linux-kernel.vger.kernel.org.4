Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B268A276
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjBCTER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjBCTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:04:15 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0FA1BAD4;
        Fri,  3 Feb 2023 11:04:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s13so2638554pgc.10;
        Fri, 03 Feb 2023 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIAAb3JvVFe/JfZ06ePgE24x4hDheu1T0aof9KbX310=;
        b=WMo/4w24GYrb4HwP1ubPwTJP3051q2dr+NVDc3cZr0WlOU4mGKpSTUbi5LDkfukrgW
         aAGrEzlk78FA4eCqya8LWuekE8NknLB3dgRACuC6HrTvyfp3llabXmaQSowrkFMEF37h
         MQQB3Q0BtCNrtPClyT8lkW64f77ebYcwKyOZ7TO/Wf4aCkJnx6TSjc3gp1lDmf8ZEhsf
         18F5YVxvbFZhcbdIjqf7LRr7X4eAXWCS9Jt1wXjqAYsDvoN3Is/Jd3H8t5TV3/YF8jnF
         UG0uMP4PGO4eKpqSbN8xYineXBCzW8K+mY2NaE8pv6oSH6fZJtlYOkFLgmJ5pankdfMe
         C0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIAAb3JvVFe/JfZ06ePgE24x4hDheu1T0aof9KbX310=;
        b=WpGI3vV20hVb2k1DdSH2P90aq7shG9XJ9UgSnwIVNpO9V6jMM2NXv0bYl+iiVI+uRa
         f2fEoxo2eoLESOCFWcfkpocBRpQ052u7ekxyE5ZNy4Xj3JLj7Yb3Lp+16QCJR4EGrjP+
         kaRvjKHkA7mdU7whSyX/C0eZbzXWkcrR6jhBlecgkaJvhWCUSRqIGnmph626QpclHRUe
         lft4NvxAC6ZJlHfWX8Ok9mkJRI/T6Gg8FRNehhjmiH2GumB94XVVMdDJ2HZNkdGNz/UW
         NbJyj3msjAFnwLHmH0hVkHySDsGTH81BK5IzfGrGqTBha6NNHwA20bd8mYJMeP7I5cxc
         cO1w==
X-Gm-Message-State: AO0yUKVBPsg045Voi1cpOx0SC/yF7y9ra80lFcqipKdhGj7NE0/OtOne
        SCu9URropLDMWncbPe0ETDQ=
X-Google-Smtp-Source: AK7set+r7dfs0c/MDPthFFRe7IUNHS2fK5o5BUDku/0fi1MAqsZRY73i5rw/OzcQPnW+X4B8H/Wckg==
X-Received: by 2002:a05:6a00:1a47:b0:593:b309:aa55 with SMTP id h7-20020a056a001a4700b00593b309aa55mr11541388pfv.28.1675451053897;
        Fri, 03 Feb 2023 11:04:13 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b00593adee79efsm2184362pfk.55.2023.02.03.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:04:13 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v9 0/3] cachestat: a new syscall for page cache state of files
Date:   Fri,  3 Feb 2023 11:04:10 -0800
Message-Id: <20230203190413.2559707-1-nphamcs@gmail.com>
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
 include/linux/compat.h                        |   4 +-
 include/linux/fs.h                            |   3 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   4 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 157 +++++++++++
 mm/workingset.c                               | 142 ++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 256 ++++++++++++++++++
 17 files changed, 564 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c


base-commit: 1440f576022887004f719883acb094e7e0dd4944
prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
-- 
2.30.2
