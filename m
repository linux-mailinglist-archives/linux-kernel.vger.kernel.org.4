Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D8642F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLERw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiLERvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067391EC44
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:51:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so4301061pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4iGUxKXjjOVEMJuMdNLNIqO6vUJnd3qD/zTRON5oB0=;
        b=l4JO0S1zAOZ9BTlZyHNbVhEOy2tlu82fAp28Wov5NxHhuX0A6+qa7ECv/eWzW6VEKV
         MeZEK+8uirEsoLiTbhKw4Jg1YPyci4uMoo2W//SBGH0WvK2tweLZWrM6uZF2bj14B232
         XIXjEgbXZ1Qp0dePcNAgE7fiW0IHXQYBZpbQpi4rcb06BUqNbCenlLk0LHQBLPfPo6zB
         Ff3AFy1IYFYuoGE3aPe25fbW5JZo1hNpONd2R0hrskdbO0OOr5778gWWk543mp0/NtDL
         9K8NbBMDW4jWaQO12YeEezZvPEhUIipMrftILpKfyC9AeKl70MNIvtN83gU4Im+tbLGM
         1j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4iGUxKXjjOVEMJuMdNLNIqO6vUJnd3qD/zTRON5oB0=;
        b=v0Hb0xtQbZuh8r2hrUntN1T6g5kIA6BQUP6w4Bl71RQ+A0a91oU0uU8bMHbSEzg7Cd
         dyIbn7FMqHDgxNOtVmz7T0sqRbvBdmov92ej6H6pQFiREq+ePzfI++HupCNNBIu06mNb
         WHl3G7zvIzPZBOKicC1LKeLyUBFDEGMVD6VwBDsFQmqFpFY9f6/ahTS+qdXisSQ7Akpr
         Vgc+/Xp0LQGEeJeTu/HMa39yUjgxwyA1c6ZYDWtYCSoF2WmbDZBJzL3xnYwxAlSsHkHQ
         xt80oJwMrsc/PwGq3ANYtpbkxjSkId1iH/3DZautwtbjYKW2bWaTYmoGP1XQDMvA+GL8
         3pPg==
X-Gm-Message-State: ANoB5pm67LEZVnWFv7hlc20dBd6i0xGjx/6J79wZgDhyydwF77KeRgvJ
        wryTT41eqFCNw8Y7lIiNtuw=
X-Google-Smtp-Source: AA0mqf5ak4L8JQjPhq3WEAPzybNj0sOLOLmM7BPytWMDZktVdGjOrytBswm+TNkzR5EZEg/2eiqTBg==
X-Received: by 2002:a17:902:e005:b0:189:c62e:ac2f with SMTP id o5-20020a170902e00500b00189c62eac2fmr12430135plo.144.1670262703435;
        Mon, 05 Dec 2022 09:51:43 -0800 (PST)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b00188edd16246sm10860172plg.266.2022.12.05.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:51:42 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v2 0/4] cachestat: a new syscall for page cache state of files
Date:   Mon,  5 Dec 2022 09:51:36 -0800
Message-Id: <20221205175140.1543229-1-nphamcs@gmail.com>
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
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   8 +
 kernel/sys_ni.c                               |   1 +
 mm/Makefile                                   |   2 +-
 mm/cachestat.c                                | 115 +++++++++++
 mm/workingset.c                               | 144 +++++++++-----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   7 +
 .../selftests/cachestat/test_cachestat.c      | 186 ++++++++++++++++++
 15 files changed, 438 insertions(+), 47 deletions(-)
 create mode 100644 mm/cachestat.c
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

--
2.30.2
