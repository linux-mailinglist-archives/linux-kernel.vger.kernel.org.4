Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8186B87D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCNBq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCNBqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4222DF4;
        Mon, 13 Mar 2023 18:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EEF0615A3;
        Tue, 14 Mar 2023 01:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D369BC433EF;
        Tue, 14 Mar 2023 01:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678758343;
        bh=lUwslns07tkovWoIqT/d7LUtwroTIyrT+CAXrTpapwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLMslZCHYY6RInH2vRVl6aHsfCfvrWDsYOX2yrPg5BGzx7Ei2Lj+16qA7GqDIVvQS
         +yIEhMKlqA8n151LnWrOHxOcSGW51y3jRdTS0v8hyC/+nTwPpurX/EJ/3qsx0aaW2A
         f4IRW7tiy/n0FMuk0dUNSk/vlFEy2Wql09pmE81QFrEOMDC3P8DNM3hr6TvyCL2Es7
         KXLwyrqCd6jF3S3HWCDGMszQNNCjgWNPxcms1rva42u2pjJyP1dIC4/HPWK2oB/ItP
         zDMM+PwNHENt9JRFk/ceUx5oY5VRm1De5iUjkcqojBcDDoJf2t6x5CiH555cDA/qou
         b9LwbBQI4rzxQ==
Date:   Mon, 13 Mar 2023 18:45:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     dchinner@redhat.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, lkp@intel.com, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is BUG: soft lockup in __cleanup_mnt
 in v6.3-rc1 kernel
Message-ID: <20230314014543.GC11394@frogsfrogsfrogs>
References: <ZA1FIM2hG/ePMHYR@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA1FIM2hG/ePMHYR@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 11:21:04AM +0800, Pengfei Xu wrote:
> Hi Dave Chinner and kernel expert,
> 
> Greeting!

<cough> Please cc the xfs list with xfs bug reports.

Have you tried 6.3-rc2?

--D

> Platform: x86 platforms
> 
> There is BUG: soft lockup in __cleanup_mnt in v6.3-rc1 kernel.
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230311_022102___cleanup_mnt
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/repro.c
> v6.3-rc1 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/fe15c26ee26efa11741a7b632e9f23b01aca4cc6_dmesg.log
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/bisect_info.log
> 
> "
> [   28.803497] XFS (loop0): Corruption of in-memory data (0x8) detected at _xfs_buf_ioapply+0x67d/0x690 (fs/xfs/xfs_buf.c:1553).  Shutting down filesystem.
> [   28.804766] XFS (loop0): Please unmount the filesystem and rectify the problem(s)
> [   56.372468] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [repro:523]
> [   56.372847] Modules linked in:
> [   56.372985] irq event stamp: 22822
> [   56.373141] hardirqs last  enabled at (22821): [<ffffffff8300086e>] irqentry_exit+0x3e/0xa0
> [   56.373512] hardirqs last disabled at (22822): [<ffffffff82ffe853>] sysvec_apic_timer_interrupt+0x13/0xe0
> [   56.373923] softirqs last  enabled at (9032): [<ffffffff83023a3c>] __do_softirq+0x31c/0x49c
> [   56.374276] softirqs last disabled at (8975): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
> [   56.374623] CPU: 1 PID: 523 Comm: repro Not tainted 6.3.0-rc1-fe15c26ee26e+ #1
> [   56.374924] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   56.375386] RIP: 0010:rcu_read_lock_sched_held+0x4b/0x80
> [   56.375621] Code: 8d 7d f7 e8 c7 fe ff ff 84 c0 74 19 0f b6 45 f7 48 8b 4d f8 65 48 33 0c 25 28 00 00 00 75 38 c9 c3 cc cc cc cc be ff ff ff ff <48> c7 c7 20 3e f6 83 e8 89 ec de 01 89 c2 b8 01 00 00 00 85 d2 75
> [   56.376376] RSP: 0018:ffffc9000102fbe0 EFLAGS: 00000246
> [   56.376597] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [   56.376891] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> [   56.377192] RBP: ffffc9000102fbf0 R08: 0000000000000001 R09: 0000000000000000
> [   56.377486] R10: ffff88800d01d418 R11: 0000000000000000 R12: ffff88800b0d1158
> [   56.377780] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   56.378082] FS:  00007fc887d10740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> [   56.378414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.378655] CR2: 00007faaae519018 CR3: 000000000d3e2004 CR4: 0000000000770ee0
> [   56.378950] PKRU: 55555554
> [   56.379069] Call Trace:
> [   56.379178]  <TASK>
> [   56.379276]  lock_acquire+0x2ad/0x320
> [   56.379444]  ? lock_release+0x141/0x2e0
> [   56.379615]  ? write_comp_data+0x2f/0x90
> [   56.379799]  _raw_spin_lock+0x36/0x50
> [   56.379962]  ? xfs_ail_push_all_sync+0x73/0x110
> [   56.380169]  xfs_ail_push_all_sync+0x73/0x110
> [   56.380360]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   56.380591]  xfs_reclaim_inodes+0xb8/0x140
> [   56.380779]  xfs_unmount_flush_inodes+0x63/0x80
> [   56.380987]  xfs_unmountfs+0x69/0x1f0
> [   56.381152]  xfs_fs_put_super+0x5a/0x120
> [   56.381331]  ? __pfx_xfs_fs_put_super+0x10/0x10
> [   56.381534]  generic_shutdown_super+0xac/0x240
> [   56.381740]  kill_block_super+0x43/0x80
> [   56.381917]  deactivate_locked_super+0x52/0xb0
> [   56.382112]  deactivate_super+0xb3/0xd0
> [   56.382282]  cleanup_mnt+0x15e/0x1e0
> [   56.382451]  __cleanup_mnt+0x1f/0x30
> [   56.382613]  task_work_run+0xb6/0x120
> [   56.382783]  exit_to_user_mode_prepare+0x200/0x210
> [   56.383000]  syscall_exit_to_user_mode+0x2d/0x60
> [   56.383205]  do_syscall_64+0x4a/0x90
> [   56.383368]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   56.383593] RIP: 0033:0x7fc887e3c7db
> [   56.383751] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
> [   56.384500] RSP: 002b:00007ffc1a5bd1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> [   56.384815] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc887e3c7db
> [   56.385114] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc1a5bd290
> [   56.385407] RBP: 00007ffc1a5be2d0 R08: 0000000001d0a333 R09: 0000000000000009
> [   56.385700] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
> [   56.385994] R13: 00007ffc1a5be410 R14: 0000000000000000 R15: 0000000000000000
> [   56.386299]  </TASK>
> [   56.386400] Kernel panic - not syncing: softlockup: hung tasks
> [   56.386643] CPU: 1 PID: 523 Comm: repro Tainted: G             L     6.3.0-rc1-fe15c26ee26e+ #1
> [   56.387000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   56.387461] Call Trace:
> [   56.387569]  <IRQ>
> [   56.387662]  dump_stack_lvl+0xa9/0x110
> [   56.387834]  dump_stack+0x19/0x20
> [   56.387980]  panic+0x4fd/0x520
> [   56.388119]  ? watchdog_timer_fn+0x31e/0x390
> [   56.388315]  watchdog_timer_fn+0x337/0x390
> [   56.388497]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [   56.388710]  __hrtimer_run_queues+0x2ed/0x820
> [   56.388924]  hrtimer_interrupt+0x134/0x2d0
> [   56.389111]  __sysvec_apic_timer_interrupt+0x9c/0x290
> [   56.389331]  sysvec_apic_timer_interrupt+0xab/0xe0
> [   56.389535]  </IRQ>
> [   56.389628]  <TASK>
> [   56.389722]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [   56.389940] RIP: 0010:rcu_read_lock_sched_held+0x4b/0x80
> [   56.390166] Code: 8d 7d f7 e8 c7 fe ff ff 84 c0 74 19 0f b6 45 f7 48 8b 4d f8 65 48 33 0c 25 28 00 00 00 75 38 c9 c3 cc cc cc cc be ff ff ff ff <48> c7 c7 20 3e f6 83 e8 89 ec de 01 89 c2 b8 01 00 00 00 85 d2 75
> [   56.390909] RSP: 0018:ffffc9000102fbe0 EFLAGS: 00000246
> [   56.391129] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [   56.391422] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> [   56.391715] RBP: ffffc9000102fbf0 R08: 0000000000000001 R09: 0000000000000000
> [   56.392009] R10: ffff88800d01d418 R11: 0000000000000000 R12: ffff88800b0d1158
> [   56.392303] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   56.392607]  lock_acquire+0x2ad/0x320
> [   56.392773]  ? lock_release+0x141/0x2e0
> [   56.392941]  ? write_comp_data+0x2f/0x90
> [   56.393122]  _raw_spin_lock+0x36/0x50
> [   56.393285]  ? xfs_ail_push_all_sync+0x73/0x110
> [   56.393483]  xfs_ail_push_all_sync+0x73/0x110
> [   56.393672]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   56.393900]  xfs_reclaim_inodes+0xb8/0x140
> [   56.394087]  xfs_unmount_flush_inodes+0x63/0x80
> [   56.394285]  xfs_unmountfs+0x69/0x1f0
> [   56.394450]  xfs_fs_put_super+0x5a/0x120
> [   56.394627]  ? __pfx_xfs_fs_put_super+0x10/0x10
> [   56.394829]  generic_shutdown_super+0xac/0x240
> [   56.395030]  kill_block_super+0x43/0x80
> [   56.395207]  deactivate_locked_super+0x52/0xb0
> [   56.395403]  deactivate_super+0xb3/0xd0
> [   56.395574]  cleanup_mnt+0x15e/0x1e0
> [   56.395739]  __cleanup_mnt+0x1f/0x30
> [   56.395902]  task_work_run+0xb6/0x120
> [   56.396071]  exit_to_user_mode_prepare+0x200/0x210
> [   56.396282]  syscall_exit_to_user_mode+0x2d/0x60
> [   56.396487]  do_syscall_64+0x4a/0x90
> [   56.396648]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   56.396865] RIP: 0033:0x7fc887e3c7db
> [   56.397020] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
> [   56.397761] RSP: 002b:00007ffc1a5bd1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> [   56.398072] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc887e3c7db
> [   56.398365] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc1a5bd290
> [   56.398658] RBP: 00007ffc1a5be2d0 R08: 0000000001d0a333 R09: 0000000000000009
> [   56.398951] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
> [   56.399244] R13: 00007ffc1a5be410 R14: 0000000000000000 R15: 0000000000000000
> [   56.399546]  </TASK>
> [   56.399792] Kernel Offset: disabled
> [   56.399972] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
> "
> 
> I used the key word "__cleanup_mnt" to bisect, I knew there was other BUG
> info in dmesg with "bisect good" commit log.
> 
> Anyway, just provided the bad commit and hope it's helpful:
> "
> bd4f5d09cc93c8ca51e4efea86ac90a4bb553d6e
> xfs: refactor the filestreams allocator pick functions
> "
> It's just a suspected commit, reverted above commit on top of v6.3-rc1 and
> no "__cleanup_mnt" related BUG but generated the other BUG info in dmesg.
> 
> There was no this issue report yet in syzbot:
> https://syzkaller.appspot.com/upstream
> 
> I tried that, installed the xfs fixed patch for below issue on top of v6.3-rc1:
> https://lore.kernel.org/lkml/20230226223403.GU360264@dread.disaster.area/
> "__cleanup_mnt" BUG issue still existed.
> Related dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/v6.3-rc1_xfs_patch_another_cleanup_mnt_issue.log
> So it should be different than previous xfs related issue.
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
> make
> make install
> 
> Thanks!
> BR.
