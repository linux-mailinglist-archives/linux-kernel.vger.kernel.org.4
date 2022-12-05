Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0931642D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiLEQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiLEQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:45:28 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 15CB22098B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:44:19 -0800 (PST)
Received: (qmail 622662 invoked by uid 1000); 5 Dec 2022 11:44:18 -0500
Date:   Mon, 5 Dec 2022 11:44:18 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+73a8d1eac3883b38173b@syzkaller.appspotmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, balbi@kernel.org,
        gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: invalid-free in gadgetfs_kill_sb
Message-ID: <Y44f4hGqxUVIn/fk@rowland.harvard.edu>
References: <000000000000c6f44205ef112f5a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c6f44205ef112f5a@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:19:38AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=146ed1d5880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
> dashboard link: https://syzkaller.appspot.com/bug?extid=73a8d1eac3883b38173b
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+73a8d1eac3883b38173b@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3509 [inline]
> BUG: KASAN: double-free or invalid-free in kfree+0xe0/0x3e4 mm/slub.c:4562
> 
> CPU: 0 PID: 3915 Comm: syz-executor.1 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
...
> [<ffffffff8046d302>] kfree+0xe0/0x3e4 mm/slub.c:4562
> [<ffffffff81df6dae>] gadgetfs_kill_sb+0x56/0x68 drivers/usb/gadget/legacy/inode.c:2088
> [<ffffffff804ce138>] deactivate_locked_super+0x9a/0x11a fs/super.c:332
> [<ffffffff804cf982>] vfs_get_super fs/super.c:1160 [inline]
> [<ffffffff804cf982>] get_tree_single+0x11e/0x12e fs/super.c:1177
> [<ffffffff81df60f4>] gadgetfs_get_tree+0x26/0x30 drivers/usb/gadget/legacy/inode.c:2067
> [<ffffffff804cc844>] vfs_get_tree+0x4a/0x19c fs/super.c:1497
> [<ffffffff80522e36>] do_new_mount fs/namespace.c:2994 [inline]
> [<ffffffff80522e36>] path_mount+0xe9c/0x14dc fs/namespace.c:3324
> [<ffffffff80524014>] do_mount fs/namespace.c:3337 [inline]
> [<ffffffff80524014>] __do_sys_mount fs/namespace.c:3545 [inline]
> [<ffffffff80524014>] sys_mount+0x360/0x3ee fs/namespace.c:3522
> [<ffffffff80005716>] ret_from_syscall+0x0/0x2
...

So task 3915 is trying to mount a superblock that probably is 
concurrently being unmounted.  Why does that cause the filesystem code 
to deactivate it before it has been fully activated?

> Freed by task 3916:
...
>  kfree+0xe0/0x3e4 mm/slub.c:4562
>  gadgetfs_kill_sb+0x56/0x68 drivers/usb/gadget/legacy/inode.c:2088
>  deactivate_locked_super+0x9a/0x11a fs/super.c:332
>  deactivate_super fs/super.c:363 [inline]
>  deactivate_super+0x80/0x94 fs/super.c:359
>  cleanup_mnt+0x220/0x2c0 fs/namespace.c:1143
>  __cleanup_mnt+0x1c/0x26 fs/namespace.c:1150
>  task_work_run+0xdc/0x154 kernel/task_work.c:164
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  do_notify_resume+0x894/0xa56 arch/riscv/kernel/signal.c:320
>  ret_from_exception+0x0/0x10

Presumably this trace comes from the first unmount.

It certainly looks like inode.c is getting confused because its 
->kill_sb() callback is invoked a second time before the second 
->get_tree() callback has completed.  Which suggests that the problem 
may lie in the filesystem code rather than the USB code.  Maybe it 
doesn't handle this race between mount and unmount.

Al, can you suggest anything?

Alan Stern
