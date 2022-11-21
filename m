Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DDF632900
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKUQIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKUQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:08:51 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B9FC5B61
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:08:50 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w9-20020a056e021c8900b0030247910269so8701578ill.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRtF/7G+l7epFRHts1bcn9egmT7R8SSB4Y+ewG7hPuc=;
        b=4hAyPB8K4H1Ihp6IQPmMXG10u+d1h10xDhvjGS8VwgDZf8W5NudiQEdq12xr/P+Iwi
         AkiuVRd/0LrmXII5TMt9gBveJ19lXFvQay40+o8ChWFMKB+N4r3/yTRY9mtMJf5m6w2w
         f1xAI9WLeQxeRYZbH/PEzft0auS4baMlyqkAYvOQhVfeGflQiQAD1eIpBMUnhR3zknaR
         EfyLgQqDI2Wwq0w6/iXpFyb8hU/lZ0zCkXanv1CBfLL2Pkal+69JMVq5K3I23RK5VQ6x
         ygJDdiB7sg/DoC0Irnr1kPyzOzV66UsAKZGXgrb6aeQb9VeUTotKaMGLt+cHoMrfXUA3
         gDeQ==
X-Gm-Message-State: ANoB5plLMarVMBAtjc0oGs5MorFG9+wn+WclEAV/pK90otBm40zFXaim
        KdlGsrjbQVPWmRWvrMnMPvA8a7umQGJh5NZT0m67YaHEXOKj
X-Google-Smtp-Source: AA0mqf75ZfOjsU8OI3y+wawtTrScE+Uvt6LleEz39iHh+6x6XAkzYqCeiGVl1bisjjoKNgV6BfvFixWeANz2HuHb99EEvi8rRx3z
MIME-Version: 1.0
X-Received: by 2002:a02:9627:0:b0:375:1998:9e4f with SMTP id
 c36-20020a029627000000b0037519989e4fmr1816061jai.136.1669046929469; Mon, 21
 Nov 2022 08:08:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 08:08:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058348b05edfd45ff@google.com>
Subject: [syzbot] WARNING: refcount bug in p9_client_walk
From:   syzbot <syzbot+2600f43a81c05675a9ae@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, edumazet@google.com,
        ericvh@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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

Hello,

syzbot found the following issue on:

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1519526e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=2600f43a81c05675a9ae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ff2aed880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b38365880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2600f43a81c05675a9ae@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 3083 at lib/refcount.c:28 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 3083 Comm: syz-executor181 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
lr : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
sp : ffff800012e7b9b0
x29: ffff800012e7b9b0 x28: ffff0000c6b51a40 x27: 0000000020000040
x26: 0000000000010002 x25: 0000000000000000 x24: ffff0000cd574088
x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000ca9ffc0c
x20: 0000000000000003 x19: ffff80000d98f000 x18: 00000000000001cc
x17: 0000000000000000 x16: ffff80000dc18158 x15: ffff0000c6b51a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6b51a40
x11: ff808000081c6510 x10: 0000000000000000 x9 : 2060ebe174811d00
x8 : 2060ebe174811d00 x7 : ffff800008165f54 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcc8 x1 : 0000000100000000 x0 : 0000000000000026
Call trace:
 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 p9_fid_put include/net/9p/client.h:275 [inline]
 p9_client_walk+0x2a4/0x2e8 net/9p/client.c:1190
 v9fs_vfs_lookup+0xa0/0x37c fs/9p/vfs_inode.c:777
 __lookup_slow+0x14c/0x204 fs/namei.c:1685
 lookup_slow+0x44/0x68 fs/namei.c:1702
 walk_component+0x178/0x1b0 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0xc4/0x208 fs/namei.c:2474
 filename_lookup+0xf8/0x264 fs/namei.c:2503
 user_path_at_empty+0x5c/0x114 fs/namei.c:2876
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3380 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x28c/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 1078
hardirqs last  enabled at (1077): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (1077): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (1078): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (1070): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (1059): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
