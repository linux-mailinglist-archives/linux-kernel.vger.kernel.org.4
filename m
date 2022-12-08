Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C6647744
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLHU2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLHU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:28:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6261BBC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:28:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so5853373pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6aaxwm43tiVxdpJBY9octccgxrKQy3Qmz9QSXAzXTL4=;
        b=m2+cV4bVjngA8qv+x/EgqbrTWbgdLa5nIrdA6WnUxBgGNGF5zvLDYu/rnWBK3Nibpa
         YF7Kc8usZ3yAonphUbBm+ld94kFoxswSZ1nmtDSCs2j3PbPRIyTFrsVijUZAfYELDCxl
         rIv4JRaPtZxg5N4xXgqMT2FIUh9mW6QlboFTnnYjyHH1Xr4ywLvt9YEOxG4OY6tdSE3N
         4jCVODXuu4i8xyGzhncLoTxHTRsw9vcTGFXKSPe0yBmVAes2FTbyfR+NCVJ4cgWG7Onq
         QOEdIj1rWWZ+l9nxRTVzPid2C0AG/aopxlw3zGBy3XRJmXO5/Vxdv6H/C+Ssejtq8XJh
         S7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aaxwm43tiVxdpJBY9octccgxrKQy3Qmz9QSXAzXTL4=;
        b=WTw5AxvxDeqXDzllYeG4Rn+kEXKLKq7LyxKrXyPSKGO+9/VRJoqPOm8wor25Pp2KJ8
         JNmxaq5jK5ClkX6W80rEWYN4gaEmMTy3KaF4XxkgFvzp6Bn7WWfooZpOeuMsaQHpB8dO
         eYV8TR3/HKPoGj0HSFLJcKWk5Gng95uWRAGKRDavjTxhOp8TPBsYhNDt2xMz0rL/pMhd
         RacfH/0XKXk6s70QtdeNFN9ZbXyb+UjhM0PbfcgW/S5uoteOQ7OY1956ImTwp/tHoUsp
         4w7aUIpYAO15OzYmzQgej5GX9jv94UmHplpYmcqEd3ji9TMFl69ukH7BzcgftGS9fsJA
         JjCQ==
X-Gm-Message-State: ANoB5pmEHPrhdVUb+MMLfmpOnFHXmCzGX/6+a0owF/rdO+rHVtNdRtcd
        sWZKZJziNECDM/yyNYDhaXA=
X-Google-Smtp-Source: AA0mqf62PBR+BMeO5CDIFR47WRLfn7JEfDXkJwAgH8SbfB9zQATjhpfMj0KK2IvHxgkjgh8xKKaM4Q==
X-Received: by 2002:a17:90b:2711:b0:213:9b80:ceee with SMTP id px17-20020a17090b271100b002139b80ceeemr109608058pjb.243.1670531289530;
        Thu, 08 Dec 2022 12:28:09 -0800 (PST)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b001868bf6a7b8sm16933787ple.146.2022.12.08.12.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:28:08 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v3 0/4] cachestat: a new syscall for page cache state of files
Date:   Thu,  8 Dec 2022 12:28:04 -0800
Message-Id: <20221208202808.908690-1-nphamcs@gmail.com>
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

 MAINTAINERS                                   |   8 +
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
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/Makefile                                   |   1 +
 mm/cachestat.c                                | 117 +++++++++++
 mm/workingset.c                               | 130 ++++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   7 +
 .../selftests/cachestat/test_cachestat.c      | 186 ++++++++++++++++++
 27 files changed, 455 insertions(+), 39 deletions(-)
 create mode 100644 mm/cachestat.c
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

--
2.30.2
