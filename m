Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12965693B54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 01:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBMAZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 19:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMAZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 19:25:52 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C4CDDA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 16:25:51 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id j14-20020a056e02218e00b0031530fae00fso2696242ila.15
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 16:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84tGHx2dc/bSnFn3PlEGqqtj4JokcAjpVRmrBLqOmcE=;
        b=mAuzNpq+5IdcHnA8K/hYdy1LuUqIoeUP1oWTv/EBssYTNRuBTFkXpaN9REqL4wzyZ8
         e0DS63qjNTNrbhyyON93TzXnO+RDDsryOINpHPMgq4+M48/JmjtzammMDQA4lOadTeOt
         DVeCxYx65rPmX/n4/J4QFUfz/YGiRbOkHZoxyMkHXM11Wp2LBFxKGHKRiFIltCIan9LS
         4R6GOn5tlJdxjKs2UrWaqZSVUOE68Ns43SwPFh6xIKf/EM9BPcrwaXLmq1wK65v+GYfk
         vF96IGVbS/dpmFWa1MOq/3U/kB8mZKaW4JIz3OOzKEreJrWgiTeYjEXraPTyM1OC7dAM
         LUpw==
X-Gm-Message-State: AO0yUKWgLo7f+cOgmv3CZf7uKFCzBVz4JqWH7fjWUJHEc3AhgKRJcuYR
        uURBT0Mage/kVUGdwoQkE23OTItHwnjT+47SD/x5zkphkg41
X-Google-Smtp-Source: AK7set/i/sqqOGmFgt09qN5g0QG296Hn7EN5R+rfjDiPS0pT2DEFht5FIA7XeWf7TPT1DR3hy94RqOs9wseDFLSxY9YOyTvodlwT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:889:b0:313:b6f1:e839 with SMTP id
 z9-20020a056e02088900b00313b6f1e839mr11390107ils.89.1676247950456; Sun, 12
 Feb 2023 16:25:50 -0800 (PST)
Date:   Sun, 12 Feb 2023 16:25:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a47fd205f489e34b@google.com>
Subject: [syzbot] memory leak in vma_node_allow
From:   syzbot <syzbot+58ea3177ba8bd0a5d8ee@syzkaller.appspotmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0983f6bf2bfc Merge tag 'devicetree-fixes-for-6.2-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134dab4d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e55e71813900595
dashboard link: https://syzkaller.appspot.com/bug?extid=58ea3177ba8bd0a5d8ee
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15052a83480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13073cfb480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dfe2e2ac7b39/disk-0983f6bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd09e355e210/vmlinux-0983f6bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8409e5f10fab/bzImage-0983f6bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58ea3177ba8bd0a5d8ee@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.168' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810f1c75c0 (size 64):
  comm "syz-executor750", pid 5060, jiffies 4294945258 (age 13.860s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 d6 e4 04 81 88 ff ff  ................
  backtrace:
    [<ffffffff81508f84>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1062
    [<ffffffff82787cca>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff82787cca>] vma_node_allow+0x3a/0x150 drivers/gpu/drm/drm_vma_manager.c:255
    [<ffffffff8276788e>] drm_gem_handle_create_tail+0x10e/0x250 drivers/gpu/drm/drm_gem.c:377
    [<ffffffff8278ed4d>] drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:432 [inline]
    [<ffffffff8278ed4d>] drm_gem_shmem_dumb_create+0xbd/0x200 drivers/gpu/drm/drm_gem_shmem_helper.c:534
    [<ffffffff82753a5b>] drm_mode_create_dumb+0x11b/0x150 drivers/gpu/drm/drm_dumb_buffers.c:96
    [<ffffffff82768e28>] drm_ioctl_kernel+0x148/0x260 drivers/gpu/drm/drm_ioctl.c:788
    [<ffffffff82769230>] drm_ioctl+0x2f0/0x500 drivers/gpu/drm/drm_ioctl.c:891
    [<ffffffff81642600>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81642600>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81642600>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81642600>] __x64_sys_ioctl+0x100/0x140 fs/ioctl.c:856
    [<ffffffff8498c889>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8498c889>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109662d80 (size 64):
  comm "syz-executor750", pid 5060, jiffies 4294945258 (age 13.870s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 d6 e4 04 81 88 ff ff  ................
  backtrace:
    [<ffffffff81508f84>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1062
    [<ffffffff82787cca>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff82787cca>] vma_node_allow+0x3a/0x150 drivers/gpu/drm/drm_vma_manager.c:255
    [<ffffffff8276788e>] drm_gem_handle_create_tail+0x10e/0x250 drivers/gpu/drm/drm_gem.c:377
    [<ffffffff8278ed4d>] drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:432 [inline]
    [<ffffffff8278ed4d>] drm_gem_shmem_dumb_create+0xbd/0x200 drivers/gpu/drm/drm_gem_shmem_helper.c:534
    [<ffffffff82753a5b>] drm_mode_create_dumb+0x11b/0x150 drivers/gpu/drm/drm_dumb_buffers.c:96
    [<ffffffff82768e28>] drm_ioctl_kernel+0x148/0x260 drivers/gpu/drm/drm_ioctl.c:788
    [<ffffffff82769230>] drm_ioctl+0x2f0/0x500 drivers/gpu/drm/drm_ioctl.c:891
    [<ffffffff81642600>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81642600>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81642600>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81642600>] __x64_sys_ioctl+0x100/0x140 fs/ioctl.c:856
    [<ffffffff8498c889>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8498c889>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109662900 (size 64):
  comm "syz-executor750", pid 5069, jiffies 4294945834 (age 8.110s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 ce 8f 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff81508f84>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1062
    [<ffffffff82787cca>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff82787cca>] vma_node_allow+0x3a/0x150 drivers/gpu/drm/drm_vma_manager.c:255
    [<ffffffff8276788e>] drm_gem_handle_create_tail+0x10e/0x250 drivers/gpu/drm/drm_gem.c:377
    [<ffffffff8278ed4d>] drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:432 [inline]
    [<ffffffff8278ed4d>] drm_gem_shmem_dumb_create+0xbd/0x200 drivers/gpu/drm/drm_gem_shmem_helper.c:534
    [<ffffffff82753a5b>] drm_mode_create_dumb+0x11b/0x150 drivers/gpu/drm/drm_dumb_buffers.c:96
    [<ffffffff82768e28>] drm_ioctl_kernel+0x148/0x260 drivers/gpu/drm/drm_ioctl.c:788
    [<ffffffff82769230>] drm_ioctl+0x2f0/0x500 drivers/gpu/drm/drm_ioctl.c:891
    [<ffffffff81642600>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81642600>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81642600>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81642600>] __x64_sys_ioctl+0x100/0x140 fs/ioctl.c:856
    [<ffffffff8498c889>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8498c889>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109662940 (size 64):
  comm "syz-executor750", pid 5069, jiffies 4294945834 (age 8.110s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 ce 8f 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff81508f84>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1062
    [<ffffffff82787cca>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff82787cca>] vma_node_allow+0x3a/0x150 drivers/gpu/drm/drm_vma_manager.c:255
    [<ffffffff8276788e>] drm_gem_handle_create_tail+0x10e/0x250 drivers/gpu/drm/drm_gem.c:377
    [<ffffffff8278ed4d>] drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:432 [inline]
    [<ffffffff8278ed4d>] drm_gem_shmem_dumb_create+0xbd/0x200 drivers/gpu/drm/drm_gem_shmem_helper.c:534
    [<ffffffff82753a5b>] drm_mode_create_dumb+0x11b/0x150 drivers/gpu/drm/drm_dumb_buffers.c:96
    [<ffffffff82768e28>] drm_ioctl_kernel+0x148/0x260 drivers/gpu/drm/drm_ioctl.c:788
    [<ffffffff82769230>] drm_ioctl+0x2f0/0x500 drivers/gpu/drm/drm_ioctl.c:891
    [<ffffffff81642600>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81642600>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81642600>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81642600>] __x64_sys_ioctl+0x100/0x140 fs/ioctl.c:856
    [<ffffffff8498c889>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8498c889>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
