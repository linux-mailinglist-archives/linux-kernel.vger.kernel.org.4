Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32F764F1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiLPTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiLPTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:21:52 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3EF57B67
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s7so3268055plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIGHTz0eabOdyvedXhDmOO3amXHWmKUtSF8hi4QPVYM=;
        b=K0eq7FlE/PQBcn5OgzH+EswODhhIlwrfi3mlASpMf2MLTLXT/8ZKtZ0fIf/TEPf5xg
         5P8v2S+I8GgvUDVQ+KJjmvTDtE/Hyz9It8r3XSBWAxnwtRyKXAG+1tVTmo/Mk1B6PlHv
         Pru/zJfB0Wc+xTdaRgK5GkGcAe5ws3V7jNc+4QFPhS5XqCsXAGvDDzzSU2O9+D6tgAa1
         H56BltNEkzAHE1gYbNbZIWSU4fdFQmTvHpolbeKTcVQte+ICmgcLGYU9V9LQw4A8da0O
         mEfdBMMR27zZxXx/jEVprTQzoOuLCpUTB+S8UOI5Nf5VZI9iMXTcLin2vfmrAThmrDA3
         VgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIGHTz0eabOdyvedXhDmOO3amXHWmKUtSF8hi4QPVYM=;
        b=HfNOwIv0RD/uzC8xugIry2tNpFdlix2dvfDAYV2kAKRe39mbOV+GrKB6sn2KGZkuZF
         +0Fm8HVyqtu4+pAdKkpOypG8AgpV8LZr/Dw/rmQQSyeD05rFzqt3MB3Zua+N2WyuUXST
         9udHizsW0rPfex2T4dmqHW/TamlUjqiEU+pKm9caDqa7kPh4l7imgZihCiY1XbRnR6WO
         5AeQUwTrtA6+ArNs/DTokemxf0UVEiq6AZ8hehlE7oQ89cBoPXEID2Fp228RSL1HZdk2
         dzcIAmL2tC1skad0VUgYUFc0SKweOloTTva3pIuJQiKqbpbvq0DYdlXc586Kerhf3v0U
         h06w==
X-Gm-Message-State: ANoB5pmqdPmU07tMFT12UyAMIApRIZewECSWgw5gpfwELkcsvYT/zGrG
        JM8bc+DDt+wJ8G3sR3oGbqg=
X-Google-Smtp-Source: AA0mqf7hKVxjYoyNhIPVLMPr8b1gSS8HgkQhOv+FnaoHN81bRsiffer8cW1S4jL7Yp9fLxubqkG08A==
X-Received: by 2002:a17:90b:1108:b0:218:fa99:8347 with SMTP id gi8-20020a17090b110800b00218fa998347mr34253695pjb.37.1671218510733;
        Fri, 16 Dec 2022 11:21:50 -0800 (PST)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090a39c700b00200461cfa99sm5145511pjf.11.2022.12.16.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:21:50 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v4 0/4] cachestat: a new syscall for page cache state of files
Date:   Fri, 16 Dec 2022 11:21:45 -0800
Message-Id: <20221216192149.3902877-1-nphamcs@gmail.com>
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

This series consist of 4 patches:

Johannes Weiner (1):
  workingset: fix confusion around eviction vs refault container

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
 mm/filemap.c                                  | 137 +++++++++
 mm/workingset.c                               | 130 ++++++---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 259 ++++++++++++++++++
 27 files changed, 550 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

-- 
2.30.2
