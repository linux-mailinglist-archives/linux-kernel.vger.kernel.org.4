Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C924649338
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLKIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 03:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiLKIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 03:45:38 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64112623
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 00:45:35 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so3124319ilt.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 00:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5qgcerx3Vj6Wa6NeDWtuCgq/K/ALlOEmy7+WWRKZ4M=;
        b=Qy8QIoJTBn5g2x1u5MkyUu88/M+AD9yWGD4iO+VuFqne67QksUyMRio3WlJCjDvwww
         6MSuSRaHtMWzpdqbpr9SHYfQjuyRcPg/FbiEKIDTMGN2uTAlnCXWjXPJCBdhW+zwXZ2d
         cj1uJKprQSh81nJk+jdsdblX+6ehILHcXQrh04BY+Dx4nFgScB2BUscDvFeWDXx1euTr
         wvcPorhOaVSs45F74Ve/1GYWZjctyxB0r1rXHaipT0N3HyTFxW6r1ceA2aTDtb3AROn4
         2EMtZWcSbincD3mIdNtym+FUIJqa7SvAv8cLAAjdu7+kF4TYKPwnrPqLyd0qJfeCNHBe
         64BQ==
X-Gm-Message-State: ANoB5pnAlsrwx35IrzTEkoV4xqzN3Eb23tQsYGdgHL5K8J+lTgk2saGh
        mvnzt2ERHpl0M35ng81jMevmLYwRkHOo0OV2IVK+2j8HuRa/
X-Google-Smtp-Source: AA0mqf6JuYcddMUyQ/erCSxEFnAPqYSVM3gYrUn9lylBQ32nF5BTKgcXAY0RBeKgVSYyy88U6/6hh4uld36/nSxDTNTVSZgvQWlZ
MIME-Version: 1.0
X-Received: by 2002:a92:d0f:0:b0:300:c3d4:e9f5 with SMTP id
 15-20020a920d0f000000b00300c3d4e9f5mr36073009iln.317.1670748334581; Sun, 11
 Dec 2022 00:45:34 -0800 (PST)
Date:   Sun, 11 Dec 2022 00:45:34 -0800
In-Reply-To: <0000000000007e22cb05dd7cbada@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdf1b505ef896889@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 do_page_fault (3)
From:   syzbot <syzbot+2845b2dfa28dec36e215@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, boqun.feng@gmail.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=127e776d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=2845b2dfa28dec36e215
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1578ffdf880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/59313e0459cb/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1afee1432fbe/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2845b2dfa28dec36e215@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0:  H: s:?? f:pn e:-32768 p:0 [(none)] preempt_count+0x10/0x24 arch/arm64/include/asm/preempt.h:12
BUG: sleeping function called from invalid context at arch/arm64/mm/fault.c:599
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3596, name: syz-executor.0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by syz-executor.0/3596:
 #0: ffff0000d0712d10 (&type->i_mutex_dir_key#8){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff0000d0712d10 (&type->i_mutex_dir_key#8){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff0000d0712d10 (&type->i_mutex_dir_key#8){.+.+}-{3:3}, at: path_openat+0x2e4/0x11c4 fs/namei.c:3711
 #1: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x10/0x4c include/linux/rcupdate.h:303
 #2: ffff0000d51feb48 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #2: ffff0000d51feb48 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x1ec/0x79c arch/arm64/mm/fault.c:589
CPU: 1 PID: 3596 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __might_resched+0x208/0x218 kernel/sched/core.c:9908
 __might_sleep+0x48/0x78 kernel/sched/core.c:9837
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:599
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 pid_nr include/linux/pid.h:185 [inline]
 dump_holder fs/gfs2/glock.c:2337 [inline]
 gfs2_dump_glock+0x518/0x904 fs/gfs2/glock.c:2447
 gfs2_consist_inode_i+0x68/0x88 fs/gfs2/util.c:465
 gfs2_dirent_scan+0x2dc/0x3b4 fs/gfs2/dir.c:602
 gfs2_dirent_search+0x134/0x494 fs/gfs2/dir.c:850
 gfs2_dir_search+0x58/0x130 fs/gfs2/dir.c:1650
 gfs2_lookupi+0x23c/0x354 fs/gfs2/inode.c:323
 __gfs2_lookup+0x5c/0x1dc fs/gfs2/inode.c:870
 gfs2_atomic_open+0x74/0x148 fs/gfs2/inode.c:1274
 atomic_open fs/namei.c:3276 [inline]
 lookup_open fs/namei.c:3384 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x67c/0x11c4 fs/namei.c:3711
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Unable to handle kernel paging request at virtual address 000003fda9bf7ccd
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004

