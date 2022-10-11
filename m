Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74AB5FB088
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJKKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJKKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:35:45 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D793FA3D;
        Tue, 11 Oct 2022 03:35:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n74so15936639yba.11;
        Tue, 11 Oct 2022 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rzNvOa8WOi+xWhHnQNhl0uCO6UkhnZs85X0a5U4+CDc=;
        b=G9tHwmr+QOZzP1yLiAoiV3OwKXLthy7aZVbCSAJG+5fPT2rlbwwsrHnv3VdMhuqBx+
         SzzAzjndmAJ+0BQKjUnLKBiuR+FUSFGQEyX0D5Sk87NfcppMy9Fh4W8SFNuGUjFGq1rE
         O6C4lRxB3B8Cvez7IVZaeUUxua2QnsQq6EOIkAwP7/FrrCQdI3muRnbijf//kX3+rWHm
         Sk7ZPYk7+Y2DQyJKu7EFCr/i0qQRzNpCn5uUMyvwyCedn/TfUoaFjBg7XcjKFuDvBfAs
         NZcg24r1HYZ4u/MpbaBaR8zh42B/D+Ucm4iKenRfPhCS+N0Y4wUVqiXWTQUubfJt9O/d
         iUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzNvOa8WOi+xWhHnQNhl0uCO6UkhnZs85X0a5U4+CDc=;
        b=O1MEmCqGd4dUi79U2DMwX0LAu5VIGjozXlEbrcV6Ycpt75g3eOD5pZAHrFk16P63qt
         09GUH13vmSY1fXczglsqkSEtRV+KjTa0fCAn6lbx35Je6rDLtoWI6+bwyrgQC8qZg5Gm
         5S2mdC6YI0j4m/f94iBPeHfgUIuwB69d3Z//p//YWByD6EmzHydFnjQodiqbm0oiKB2i
         GmQFq4DW62VuQZbpaZxhWQ1mUCON3jWeBmFmcYzcIkhwiYNX4NERnS4onlVvnCqSeIpt
         w0hkMqtRndTrL3S54w1wJUAMMi4jPguwdHyuTe1CVmcgXUbT6Gx5EvJZHW3mWAW8FdaJ
         bGkg==
X-Gm-Message-State: ACrzQf37OpDbpCNosIrJHzuy/+Lt695aKtnrORsrdvtxZX6lsaydbF4a
        XWz87mu3tq2zKgnohE3T1ocaGNnk0rpGNjYsR8A=
X-Google-Smtp-Source: AMsMyM74MLBWBesjZsfBsEbm3HZVQuMkixrssVnqNSPNqo3bsKC1KzMkWid2BXKdSRwpamIc7nSYHJ5qHenj3cGqAk4=
X-Received: by 2002:a5b:842:0:b0:6a3:cf26:755d with SMTP id
 v2-20020a5b0842000000b006a3cf26755dmr20833901ybq.608.1665484539728; Tue, 11
 Oct 2022 03:35:39 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 11 Oct 2022 12:35:29 +0200
Message-ID: <CAKXUXMzmfeF9K4SkUcR2i6T+ZqEXvwod4hOzCPfQowMJULy7eg@mail.gmail.com>
Subject: Observed recent memory leak in __anon_vma_prepare
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maple-tree@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>
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

Dear Liam, dear Matthew, dear all,

The reproducer for the 'memory leak in __anon_vma_prepare' bug (see
https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3113810b9abd3dfeb581759df93d3171d1a90f18)
is reproducible, it is triggering the memory leak on the current
mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
build config is a x86_64 defconfig.

My git bisection showed that:

524e00b36e8c547f5582eef3fb645a8d9fc5e3df is the first bad commit
commit 524e00b36e8c547f5582eef3fb645a8d9fc5e3df
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Tue Sep 6 19:48:48 2022 +0000

The git bisect log is below, note that the commits 7fdbd37da5c6,
d0cf3dd47f0d and 0c563f148043 are marked good in the git bisect as
they caused bugs "BUG: Bad rss-counter state mm: ... type:MM_ANONPAGES
val:2". This bug report might have overshadowed the actual issue, and
hence the bug might have been introduced earlier, but was only visible
once the Bad rss-counter state bug disappeared.


git bisect start
# bad: [60bb8154d1d77042a5d43d335a68fdb202302cbe] Merge tag
'xfs-6.1-for-linus' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad 60bb8154d1d77042a5d43d335a68fdb202302cbe
# good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect good 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
# good: [ff6862c23d2e83d12d1759bf4337d41248fb4dc8] Merge tag
'arm-drivers-6.1' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good ff6862c23d2e83d12d1759bf4337d41248fb4dc8
# good: [e8bc52cb8df80c31c73c726ab58ea9746e9ff734] Merge tag
'driver-core-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect good e8bc52cb8df80c31c73c726ab58ea9746e9ff734
# good: [4899a36f91a9f9b06878471096bd143e7253006d] Merge tag
'powerpc-6.1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 4899a36f91a9f9b06878471096bd143e7253006d
# good: [0e0073eb1b60f4ec6faecea034a6772fe1409a88] Merge tag
'hyperv-next-signed-20221009' of
git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux
git bisect good 0e0073eb1b60f4ec6faecea034a6772fe1409a88
# bad: [2f3568017268fc34eb0b6b4b3163c0f2e619fde6] kasan: move
kasan_get_*_meta to generic.c
git bisect bad 2f3568017268fc34eb0b6b4b3163c0f2e619fde6
# good: [354ed597442952fb680c9cafc7e4eb8a76f9514c] mm: multi-gen LRU:
kill switch
git bisect good 354ed597442952fb680c9cafc7e4eb8a76f9514c
# bad: [b3541d912a84dc40cabb516f2deeac9ae6fa30da] mm: delete unused
MMF_OOM_VICTIM flag
git bisect bad b3541d912a84dc40cabb516f2deeac9ae6fa30da
# bad: [67e7c16764c3cbf84a57d441fba3474217ac08d6] mm/mmap: change
do_brk_munmap() to use do_mas_align_munmap()
git bisect bad 67e7c16764c3cbf84a57d441fba3474217ac08d6
# good: [e15e06a8392321a19d8ebdbdd7643b7fa8874c17]
lib/test_maple_tree: add testing for maple tree
git bisect good e15e06a8392321a19d8ebdbdd7643b7fa8874c17
# bad: [3b0e81a1cdc9afbddb0543d08e38edb4e33c4baf] mmap: change zeroing
of maple tree in __vma_adjust()
git bisect bad 3b0e81a1cdc9afbddb0543d08e38edb4e33c4baf
# good: [7fdbd37da5c6ff002dc6d15e89a7708c2df4928e] mm/mmap: use the
maple tree for find_vma_prev() instead of the rbtree
git bisect good 7fdbd37da5c6ff002dc6d15e89a7708c2df4928e
# good: [d0cf3dd47f0d5d3bc366063f455215b99b06d62b] damon: convert
__damon_va_three_regions to use the VMA iterator
git bisect good d0cf3dd47f0d5d3bc366063f455215b99b06d62b
# bad: [524e00b36e8c547f5582eef3fb645a8d9fc5e3df] mm: remove rb tree.
git bisect bad 524e00b36e8c547f5582eef3fb645a8d9fc5e3df
# good: [0c563f148043569c81724ee0f9c5bad5a36b115a] proc: remove VMA
rbtree use from nommu
git bisect good 0c563f148043569c81724ee0f9c5bad5a36b115a
# first bad commit: [524e00b36e8c547f5582eef3fb645a8d9fc5e3df] mm:
remove rb tree.


If there is more information needed or other bisection to be done,
please let me know.

Best regards,

Lukas
