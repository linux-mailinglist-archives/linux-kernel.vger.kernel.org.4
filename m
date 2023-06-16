Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67547732703
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbjFPGDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbjFPGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:03:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB32D5F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 649A361324
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BEEC433C8;
        Fri, 16 Jun 2023 06:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686895424;
        bh=GZc7By0mJeVIkZQ9yAj/BUXxa2lJWfByQzhT8rhH0EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4k8/qrDxfZcC0jfnV+CpWjNKwnbLPV/M0TfLNr3tFIPEa5n68xNnRZz7J5Wi5ZLT
         tMN5gmgr02gV8glI6C6CT05ygiWuPkZvYsK9ukpmlSORnJXWILOCBZi6m/O/0Dx3bs
         sjOVvOyBWxl9tj0/ACwhq/UASBdmm6GMaNTI6kJjI5FVWfwvmi8Jeo4sKSQUUc7IU+
         cy5d3/81tb1SdqhdwMGpzpvwYj4C0KQcGbSmTIar2sbnnovn8eGlsgyLjdhRno3Dqz
         yDAa0ldP5EFXAcLyuJRqbY5owxmIxuCaa0/5uxq+8wDc6XO6zw6cj5wA03o3wq+oPF
         R86pe1A5PTw2Q==
Date:   Thu, 15 Jun 2023 23:03:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid mmap vs
 set_compress_option case
Message-ID: <20230616060342.GB181948@sol.localdomain>
References: <20230529104709.2560779-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529104709.2560779-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, May 29, 2023 at 06:47:09PM +0800, Chao Yu wrote:
> Compression option in inode should not be changed after they have
> been used, however, it may happen in below race case:
> 
> Thread A				Thread B
> - f2fs_ioc_set_compress_option
>  - check f2fs_is_mmap_file()
>  - check get_dirty_pages()
>  - check F2FS_HAS_BLOCKS()
> 					- f2fs_file_mmap
> 					 - set_inode_flag(FI_MMAP_FILE)
> 					- fault
> 					 - do_page_mkwrite
> 					  - f2fs_vm_page_mkwrite
> 					  - f2fs_get_block_locked
> 					 - fault_dirty_shared_page
> 					  - set_page_dirty
>  - update i_compress_algorithm
>  - update i_log_cluster_size
>  - update i_cluster_size
> 
> Avoid such race condition by covering f2fs_file_mmap() w/ inode lock,
> meanwhile add mmap file check condition in f2fs_may_compress() as well.
> 
> Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
> Signed-off-by: Chao Yu <chao@kernel.org>

This patch causes the following deadlock report:

[    9.622928] ======================================================
[    9.623484] WARNING: possible circular locking dependency detected
[    9.624054] 6.4.0-rc1-00039-g18a87f3eaef5 #12 Tainted: G                T
[    9.624672] ------------------------------------------------------
[    9.625242] xfs_io/2440 is trying to acquire lock:
[    9.625682] ffff888103a2c888 (&sb->s_type->i_mutex_key#11){+.+.}-{3:3}, at: f2fs_file_mmap+0x53/0xc0
[    9.626523]
[    9.626523] but task is already holding lock:
[    9.627058] ffff888103d0e8c0 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x72/0x1c0
[    9.627797]
[    9.627797] which lock already depends on the new lock.
[    9.627797]
[    9.628528]
[    9.628528] the existing dependency chain (in reverse order) is:
[    9.629210]
[    9.629210] -> #1 (&mm->mmap_lock){++++}-{3:3}:
[    9.629761]        lock_acquire+0xcb/0x2d0
[    9.630147]        __might_fault+0x6f/0xa0
[    9.630526]        _copy_to_user+0x27/0x90
[    9.630915]        fiemap_fill_next_extent+0xbe/0x130
[    9.631378]        f2fs_fiemap+0x223/0x5c0
[    9.631757]        do_vfs_ioctl+0x6d5/0x860
[    9.632150]        __x64_sys_ioctl+0x4a/0xd0
[    9.632547]        do_syscall_64+0x39/0x90
[    9.632935]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    9.633444]
[    9.633444] -> #0 (&sb->s_type->i_mutex_key#11){+.+.}-{3:3}:
[    9.634104]        check_prev_add+0x93/0xbd0
[    9.634500]        __lock_acquire+0xc27/0x11e0
[    9.634918]        lock_acquire+0xcb/0x2d0
[    9.635297]        down_write+0x3d/0x100
[    9.635660]        f2fs_file_mmap+0x53/0xc0
[    9.636053]        mmap_region+0x20b/0x920
[    9.636433]        do_mmap+0x345/0x570
[    9.636781]        vm_mmap_pgoff+0xa1/0x1c0
[    9.637179]        ksys_mmap_pgoff+0xa0/0xc0
[    9.637574]        __x64_sys_mmap+0x32/0x60
[    9.637970]        do_syscall_64+0x39/0x90
[    9.638348]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    9.638864]
[    9.638864] other info that might help us debug this:
[    9.638864]
[    9.639582]  Possible unsafe locking scenario:
[    9.639582]
[    9.640128]        CPU0                    CPU1
[    9.640545]        ----                    ----
[    9.640971]   lock(&mm->mmap_lock);
[    9.641298]                                lock(&sb->s_type->i_mutex_key#11);
[    9.641953]                                lock(&mm->mmap_lock);
[    9.642500]   lock(&sb->s_type->i_mutex_key#11);
[    9.642930]
[    9.642930]  *** DEADLOCK ***
[    9.642930]
[    9.643469] 1 lock held by xfs_io/2440:
[    9.643830]  #0: ffff888103d0e8c0 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x72/0x1c0
[    9.644600]
[    9.644600] stack backtrace:
[    9.645012] CPU: 0 PID: 2440 Comm: xfs_io Tainted: G                T  6.4.0-rc1-00039-g18a87f3eaef5 #12
[    9.645869] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.2-1-1 04/01/2014
[    9.646697] Call Trace:
[    9.646933]  <TASK>
[    9.647137]  dump_stack_lvl+0x4e/0x90
[    9.647483]  dump_stack+0x14/0x20
[    9.647800]  print_circular_bug+0x2eb/0x440
[    9.648188]  check_noncircular+0x124/0x140
[    9.648568]  check_prev_add+0x93/0xbd0
[    9.648923]  ? add_chain_cache+0x10e/0x470
[    9.649304]  __lock_acquire+0xc27/0x11e0
[    9.649670]  lock_acquire+0xcb/0x2d0
[    9.650013]  ? f2fs_file_mmap+0x53/0xc0
[    9.650372]  down_write+0x3d/0x100
[    9.650696]  ? f2fs_file_mmap+0x53/0xc0
[    9.651059]  f2fs_file_mmap+0x53/0xc0
[    9.651402]  mmap_region+0x20b/0x920
[    9.651739]  do_mmap+0x345/0x570
[    9.652053]  vm_mmap_pgoff+0xa1/0x1c0
[    9.652397]  ksys_mmap_pgoff+0xa0/0xc0
[    9.652747]  __x64_sys_mmap+0x32/0x60
[    9.653098]  do_syscall_64+0x39/0x90
[    9.653432]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    9.653904] RIP: 0033:0x7f1366f92b62
[    9.654237] Code: e4 e8 b2 4b 01 00 66 90 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef 4
[    9.655918] RSP: 002b:00007ffd5de38f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[    9.656601] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f1366f92b62
[    9.657256] RDX: 0000000000000001 RSI: 0000000000020000 RDI: 0000000000000000
[    9.657909] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
[    9.658558] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
[    9.659215] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000020000
[    9.659867]  </TASK>

