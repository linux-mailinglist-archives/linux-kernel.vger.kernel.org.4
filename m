Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F83623266
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiKISZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKISZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:25:48 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FED2DE8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:25:48 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso11758569iox.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fGqAIeMuhrwXfptcLbIlluni1y5fNYxkg7mqkWbCqw=;
        b=I8IlSr3/ccooTuHV2G8zVWdm9stI9w2W31m/kW1wRiRBUvkEF80da43rdhD707B6gd
         fruvu0ACsd4IBQgTKea/iUlDUjbNId5UEgBo/RIdK01YGaDNiMmtS/YHa9kLuMvZOcpb
         KBhxW5KajYMZjOziT+ztsAVHmRlh6vrvR2sRmYUrSOZIKmDqU6sJ8rFLJ29/6ZlxWVGi
         KLkKi1aO12f1f9tK1utpf7/TOaGdRoda/YcjuijIwKxuNMJBXz75szOJsuwwuHYNs0CD
         JqsyiGmLLPq/zxxU80JQUe8007XSlJQd6teYzVyS3ZOKKtssH4V+5DddAnFYkxZvLz4K
         kOvw==
X-Gm-Message-State: ACrzQf0MzupFzi6fRM5Al1gUcV7JNKnyelcNOuuii0luWRu08AC8Q/fa
        A0eAtO7rBa9vWqwFqzE6qba2ux8tc3pdtvgSDY2EhkTSak6c
X-Google-Smtp-Source: AMsMyM5VSP02eDnDxeF9p9H+9ItHHOlHZltrqLdAkXdQwNZctajHd6PnT+o9/jbh0Fh90oK/DnP735XMapA8BWJqdWW52dpASwPk
MIME-Version: 1.0
X-Received: by 2002:a92:d283:0:b0:300:ddde:c31f with SMTP id
 p3-20020a92d283000000b00300dddec31fmr1890492ilp.246.1668018347394; Wed, 09
 Nov 2022 10:25:47 -0800 (PST)
Date:   Wed, 09 Nov 2022 10:25:47 -0800
In-Reply-To: <00000000000090655b05a2ff399a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000134d6205ed0dc953@google.com>
Subject: Re: [syzbot] memory leak in drm_vma_node_allow
From:   syzbot <syzbot+04639d98c75c52e41b8a@syzkaller.appspotmail.com>
To:     11115066@vivo.com, airlied@gmail.com, airlied@linux.ie,
        anant.thazhemadam@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, igormtorrente@gmail.com,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
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

HEAD commit:    f141df371335 Merge tag 'audit-pr-20221107' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123bdcd1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7ebe38e4b66a7b
dashboard link: https://syzkaller.appspot.com/bug?extid=04639d98c75c52e41b8a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ec0c1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120cc3e1880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d056ae4a8f32/disk-f141df37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02fdf71b87b4/vmlinux-f141df37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14078d70a64d/bzImage-f141df37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04639d98c75c52e41b8a@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810f65f0c0 (size 64):
  comm "syz-executor402", pid 3630, jiffies 4294948375 (age 13.410s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 94 b3 05 81 88 ff ff  ................
  backtrace:
    [<ffffffff814cfce0>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff826b5bd2>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff826b5bd2>] drm_vma_node_allow+0x32/0x120 drivers/gpu/drm/drm_vma_manager.c:274
    [<ffffffff8269bbda>] drm_gem_handle_create_tail+0x10a/0x250 drivers/gpu/drm/drm_gem.c:377
    [<ffffffff826e45e9>] drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:432 [inline]
    [<ffffffff826e45e9>] drm_gem_shmem_dumb_create+0xb9/0x200 drivers/gpu/drm/drm_gem_shmem_helper.c:534
    [<ffffffff826cb557>] drm_mode_create_dumb+0x117/0x150 drivers/gpu/drm/drm_dumb_buffers.c:96
    [<ffffffff8269d094>] drm_ioctl_kernel+0x144/0x260 drivers/gpu/drm/drm_ioctl.c:788
    [<ffffffff8269d49c>] drm_ioctl+0x2ec/0x4f0 drivers/gpu/drm/drm_ioctl.c:891
    [<ffffffff81602aec>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602aec>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602aec>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602aec>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608245>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608245>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd


