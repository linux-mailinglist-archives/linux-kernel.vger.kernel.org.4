Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E165E0D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjADXW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjADXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:21:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5413FB6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:21:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso81875wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+w/QWwuvtOmFx+OVR4xG+AfY+zwDbmJijYlotknW6s=;
        b=VuWjPMk9shaCeXQ8DhN/P7DjmfsKWloX+W/HghViHxrB4cvZFadupjiPl/TIEPeU7k
         6ckW4dfvESWwdFdD4hed1i3F1WyH0MH/2CN2DioAO+nfrwi4l1oVCwoya9l2UqjWTj/M
         WmqAWINFjmbdnq4PXPlol6N5wwK0wcsFGJZ8OtrvX0QJbKZ6LqRrj2yeQdQmf+Aj2bMc
         /gtpmhYhUapAAWTMxQCtd6jzDINjbaBQ5KLOBI7MMQAwhIB/KvwMMyyKNISgaeaQJOCA
         jLWTM/kuGps0MMQ6835MzPCJCeBvTnGQR6cmDw/lFSAI7p3Xjwv8gPHuqpjHeBrYC2HO
         JN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+w/QWwuvtOmFx+OVR4xG+AfY+zwDbmJijYlotknW6s=;
        b=L0y9B3yotrXE1sKiSmx9Pd4tUAAU6joEs2/P+VU7DlF2WImwTfM/H7/1C0crdtTDaR
         9XLYhFOyfJMZNz+ApXZWQileSUrbh8Yh1J5CJcfIUJFzjfomtOPg0LolY/+9cs/aMU5R
         Oa/WtlDtLV2URQZ/KKewHIWZM7NrcmVL8kooVXp2v9Lzz8HMzKuholF3ME/JS8RR3x7S
         xIDpvwJgNvYBWM2EHGXg4G6I8tdQqqEAXHdbjHS5tu62V3hftqcuTtbfHDjkjxPIYOmc
         UzJ9W1ccZChqMPa17vhTR29WfiO9ZNYeL5kNWAHhApKZs5SsJ4X12l4rzK4G8PVFxkad
         ks2A==
X-Gm-Message-State: AFqh2kopxCRYJzb23rsFfuVq7NqZ4YGsnuLVwXGbGZdzf7QwaFcQ7pj7
        yx0+BPO4EiW92MUfmEa3/t/kL6Fw37HWzeWuwaw=
X-Google-Smtp-Source: AMrXdXvzLJzrj3ZSrGoIQ3+3Nul/7vLcBF+MEuPQhr+3sftu+gy/rfCzdj/8DJuLSBXIuqqwEft1n25PFMK22oMEea4=
X-Received: by 2002:a05:600c:1c90:b0:3d2:1d51:2476 with SMTP id
 k16-20020a05600c1c9000b003d21d512476mr2253182wms.77.1672874487318; Wed, 04
 Jan 2023 15:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20230104231127.2634648-1-nphamcs@gmail.com>
In-Reply-To: <20230104231127.2634648-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 4 Jan 2023 15:21:16 -0800
Message-ID: <CAKEwX=MY0C_9aH7Py5We1-z9Au6qnOsX1AmSE3ZXDrff8RnKfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] cachestat: a new syscall for page cache state of files
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 3:11 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Changelog:
> v5:
>   * Separate first patch into its own series.
>     (suggested by Andrew Morton)
>   * Expose filemap_cachestat() to non-syscall usage
>     (patch 2) (suggested by Brian Foster).
>   * Fix some build errors from last version.
>     (patch 2)
>   * Explain eviction and recent eviction in the draft man page and
>     documentation (suggested by Andrew Morton).
>     (patch 2)
> v4:
>   * Refactor cachestat and move it to mm/filemap.c (patch 3)
>     (suggested by Brian Foster)
>   * Remove redundant checks (!folio, access_ok)
>     (patch 3) (suggested by Matthew Wilcox and Al Viro)
>   * Fix a bug in handling multipages folio.
>     (patch 3) (suggested by Matthew Wilcox)
>   * Add a selftest for shmem files, which can be used to test huge
>     pages (patch 4) (suggested by Johannes Weiner)
> v3:
>   * Fix some minor formatting issues and build errors.
>   * Add the new syscall entry to missing architecture syscall tables.
>     (patch 3).
>   * Add flags argument for the syscall. (patch 3).
>   * Clean up the recency refactoring (patch 2) (suggested by Yu Zhao)
>   * Add the new Kconfig (CONFIG_CACHESTAT) to disable the syscall.
>     (patch 3) (suggested by Josh Triplett)
> v2:
>   * len == 0 means query to EOF. len < 0 is invalid.
>     (patch 3) (suggested by Brian Foster)
>   * Make cachestat extensible by adding the `cstat_size` argument in the
>     syscall (patch 3)
>
> There is currently no good way to query the page cache state of large
> file sets and directory trees. There is mincore(), but it scales poorly:
> the kernel writes out a lot of bitmap data that userspace has to
> aggregate, when the user really doesn not care about per-page information
> in that case. The user also needs to mmap and unmap each file as it goes
> along, which can be quite slow as well.
>
> This series of patches introduces a new system call, cachestat, that
> summarizes the page cache statistics (number of cached pages, dirty
> pages, pages marked for writeback, evicted pages etc.) of a file, in a
> specified range of bytes. It also include a selftest suite that tests some
> typical usage
>
> This interface is inspired by past discussion and concerns with fincore,
> which has a similar design (and as a result, issues) as mincore.
> Relevant links:
>
> https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04207.html
> https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04209.html
>
> For comparison with mincore, I ran both syscalls on a 2TB sparse file:
>
> Using mincore:
> real    0m37.510s
> user    0m2.934s
> sys     0m34.558s
>
> Using cachestat:
> real    0m0.009s
> user    0m0.000s
> sys     0m0.009s
>
> This series should be applied on top of:
>
> workingset: fix confusion around eviction vs refault container
> https://lkml.org/lkml/2023/1/4/1066
>
> This series consist of 3 patches:
>
> Nhat Pham (3):
>   workingset: refactor LRU refault to expose refault recency check
>   cachestat: implement cachestat syscall
>   selftests: Add selftests for cachestat
>
>  MAINTAINERS                                   |   7 +
>  arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
>  arch/arm/tools/syscall.tbl                    |   1 +
>  arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl           |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
>  include/linux/fs.h                            |   3 +
>  include/linux/swap.h                          |   1 +
>  include/linux/syscalls.h                      |   3 +
>  include/uapi/asm-generic/unistd.h             |   5 +-
>  include/uapi/linux/mman.h                     |   9 +
>  init/Kconfig                                  |  10 +
>  kernel/sys_ni.c                               |   1 +
>  mm/filemap.c                                  | 143 ++++++++++
>  mm/workingset.c                               | 129 ++++++---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/cachestat/.gitignore  |   2 +
>  tools/testing/selftests/cachestat/Makefile    |   8 +
>  .../selftests/cachestat/test_cachestat.c      | 259 ++++++++++++++++++
>  27 files changed, 555 insertions(+), 39 deletions(-)
>  create mode 100644 tools/testing/selftests/cachestat/.gitignore
>  create mode 100644 tools/testing/selftests/cachestat/Makefile
>  create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c
>
>
> base-commit: 1440f576022887004f719883acb094e7e0dd4944
> prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
> --
> 2.30.2

Oops, I think I accidentally sent out v5 twice :(

Please ignore the first set of emails and review this one only,

LKML link for convenience:
https://lkml.org/lkml/2023/1/4/1095
