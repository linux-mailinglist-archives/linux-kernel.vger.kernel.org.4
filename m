Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999AD600D75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJQLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJQLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:11:47 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8F58DC0;
        Mon, 17 Oct 2022 04:11:42 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 207so12857913ybn.1;
        Mon, 17 Oct 2022 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cR7RKyrnpCdX42yUtcjjGzfAur5/uF+2PLfIPET1Tlw=;
        b=YdHqVTugx78jHxO5u8NvhOYRFr8iJDvqsMG4XFaUTx4MSbl5JC40GjWVqdC9hOQA8s
         KaIj1LattbsGf+nvKE+0k5M+KDaKDJzt2AnLr5bSERQcuBCnrLMgLf8057/4i/nJZSl+
         D2txtDN0THcqnUIDHQmJM/WOnbRLACb/FHn97S7PzrQeHFTOQ5PWqencCiudcarSfaK1
         ac7U0Fbmz8FAEOL3XR/ZcrjpTZ0BTHn4nZnaq300rifosvfmGw1YgCCqGad37adQMG0w
         3m4cekCOVw0mMkIkUnE8zcdB3IugQ1599oj0Tz6vHaXwFwhFSzkzIF+Hvrv6VokZDZ3G
         QGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cR7RKyrnpCdX42yUtcjjGzfAur5/uF+2PLfIPET1Tlw=;
        b=JBPdT7Wf4OuSkfkhggx9+PyCb/hVohic21rIZKY1Novmw/3je386fACcKYgNBKpdyV
         Pd8Z1s0QSYz9Hqj5A7YtBYo+G+xqP9BpBUBd2q4AiFLN7PkXCZ3B82vsFWhxduKYfDVi
         Mdz2d8EKhH72DgVgoKS44mcVOrJzoQW0yeQ6uCMNornHe0xK903Gw1H209Pu03+NNIud
         U1GWMPBPzUEbJ2/GyNg/xEU3t32rSgkWrMx5XWHCwX4vv3wUHYiLSl/xv3zPBAHGnESI
         iC/op4UvbhVqRcoeZJaZBUIH9hp6ikGp3M0L1mBxJ2NkRMweKO25GU8wrPugOy3mnpzw
         v7tg==
X-Gm-Message-State: ACrzQf0B0ZlCQKTZmKhHX5hdj8r2/Nvw/C/eJpmUnEmyFpYQ0dNvgWDu
        ZDzT1sq00Og3VJ5qhsEl0PLYe53R7W4WC7VbxIkdoEXw
X-Google-Smtp-Source: AMsMyM4QnJl8FDbDY9WXmrWaSRdFNE3iWXQ/D7bDXNd06gKLOLWArZ2kSkfa2hTRu6akRhzLSebyE8fKe4SsNrqaQlw=
X-Received: by 2002:a25:b95:0:b0:6c2:53a8:3711 with SMTP id
 143-20020a250b95000000b006c253a83711mr8622318ybl.27.1666005101496; Mon, 17
 Oct 2022 04:11:41 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 17 Oct 2022 13:11:30 +0200
Message-ID: <CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com>
Subject: Observed memory leak in hugetlb_reserve_pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Dear Mike,

The reproducer for the 'memory leak in hugetlb_reserve_pages' bug (see
https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3469603f4a0da86b581cc979bd6c6663b46ceb1b)
is reproducible, it is triggering the memory leak on the current
mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
build config is a x86_64 defconfig with some syzkaller-recommended
debug options.

I build the kernel with:

make O=$BUILD defconfig && make O=$BUILD kvm_guest.config && \
./scripts/kconfig/merge_config.sh -O $BUILD -r $BUILD/.config
kernel/configs/syzkaller-recommended.config && \
make O=$BUILD -j`nproc`

My syzkaller-recommended.config is:

CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_CONFIGFS_FS=y
CONFIG_SECURITYFS=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_KASAN=y
CONFIG_KASAN_INLINE=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_LOCKDEP=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_PROVE_RCU=y
CONFIG_DEBUG_VM=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_WQ_WATCHDOG=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
CONFIG_RCU_CPU_STALL_TIMEOUT=100


My git bisection showed that the first bad commit is
[bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69] hugetlb: allocate vma lock
for all sharable vmas.


Full git bisect report:

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
# good: [2f3568017268fc34eb0b6b4b3163c0f2e619fde6] kasan: move
kasan_get_*_meta to generic.c
git bisect good 2f3568017268fc34eb0b6b4b3163c0f2e619fde6
# good: [a57ae9ef9e1a20b68ae841a8cab7aff3f000ed9d] mm/page_alloc:
update comments for rmqueue()
git bisect good a57ae9ef9e1a20b68ae841a8cab7aff3f000ed9d
# bad: [dc914858561c424978307561492fcf3145b8b525] Merge tag
'nfsd-6.1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect bad dc914858561c424978307561492fcf3145b8b525
# good: [70442fc54e6889a2a77f0e9554e8188a1557f00e] Merge tag
'x86_mm_for_v6.1_rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 70442fc54e6889a2a77f0e9554e8188a1557f00e
# good: [c91bdc9358992856721ff77887202a7e80b7ab22] mm: memcontrol:
don't allocate cgroup swap arrays when memcg is disabled
git bisect good c91bdc9358992856721ff77887202a7e80b7ab22
# good: [7d37539037c2fca70346fbedc219f655253d5cff] fuse: implement ->tmpfile()
git bisect good 7d37539037c2fca70346fbedc219f655253d5cff
# good: [131a79b474e973f023c5c75e2323a940332103be] hugetlb: fix vma
lock handling during split vma and range unmapping
git bisect good 131a79b474e973f023c5c75e2323a940332103be
# bad: [27bc50fc90647bbf7b734c3fc306a5e61350da53] Merge tag
'mm-stable-2022-10-08' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 27bc50fc90647bbf7b734c3fc306a5e61350da53
# bad: [bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69] hugetlb: allocate
vma lock for all sharable vmas
git bisect bad bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69
# good: [ecfbd733878da48ed03a5b8a9c301366a03e3cca] hugetlb: take
hugetlb vma_lock when clearing vma_lock->vma pointer
git bisect good ecfbd733878da48ed03a5b8a9c301366a03e3cca
# first bad commit: [bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69]
hugetlb: allocate vma lock for all sharable vmas


If there is more information needed, please let me know.

Best regards,

Lukas
