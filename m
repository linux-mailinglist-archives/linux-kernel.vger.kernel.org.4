Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388766316A1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 22:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKTVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 16:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 16:51:43 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37D1DDCA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 13:51:41 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id c4-20020a056e020bc400b0030098df879dso7383816ilu.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 13:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7wGAMcIVofRqI8zstaVUtFUGyhqG2P4qJdj3ueLM4o=;
        b=aCmkiEGZ9/kywI+yQYzlv/gAOZwFBinn+SvWxvDgo2kScwxjUqr94EWzfC4esSjy7a
         VVQFHuDKRNiHso73DpHgX28HhnVLklZOqSHmj5XvoECcqrIfSjhDk/2+c1zcoGKcsSeF
         0Usye0yxMcFcmdkkkxHa+x+p3Jve7/qd20t1UErrIRgeJ5WugChKHYS2NUMZ2ZQRETyi
         hdMf9nm4mZgwzBoVXJKUQ9EzCSKmbkIqMI0KeygRPBYqQZGzl6v2MDUZuzYOB6o9Ufvc
         p0YbNyCnJgE/DBYezWlouq9VDFt7g2O2ayceFnpeMUZq59O2JNNtOkr4D+lJ1497vmgM
         aXtw==
X-Gm-Message-State: ANoB5pnqEIQotUWAXmuVy1IFklltDrBucbTWyN5zY1uQtUc8dxeL7xkU
        Q/ARYVfksCyKIJsKZnSI2cMaAsZGqY/zxKKaDhplS5bQxr9h
X-Google-Smtp-Source: AA0mqf4LjfznLu+pROq3l3HGoPzd1ylEPt85FP+WIzNnbDOpRogNEd6sqoStItjFPSN1tOTF/VK31QwUhgWB/uACPn6zjREmMcmH
MIME-Version: 1.0
X-Received: by 2002:a6b:c844:0:b0:6db:fe34:6948 with SMTP id
 y65-20020a6bc844000000b006dbfe346948mr190016iof.209.1668981101039; Sun, 20
 Nov 2022 13:51:41 -0800 (PST)
Date:   Sun, 20 Nov 2022 13:51:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa181605ededf1fa@google.com>
Subject: [syzbot] memory leak in binder_transaction (2)
From:   syzbot <syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com>
To:     arve@android.com, brauner@kernel.org, cmllamas@google.com,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
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

HEAD commit:    59d0d52c30d4 AMerge tag 'netfs-fixes-20221115' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a7b445880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=435fb8cdd395f932
dashboard link: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114a3b35880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/854c98a663e0/disk-59d0d52c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/233c8e05ab54/vmlinux-59d0d52c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7254f9286f1d/bzImage-59d0d52c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811b0bbe00 (size 32):
  comm "syz-executor.1", pid 4041, jiffies 4294986632 (age 15.340s)
  hex dump (first 32 bytes):
    00 be 0b 1b 81 88 ff ff 00 be 0b 1b 81 88 ff ff  ................
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ed530>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
    [<ffffffff8396b973>] kmalloc include/linux/slab.h:553 [inline]
    [<ffffffff8396b973>] kzalloc include/linux/slab.h:689 [inline]
    [<ffffffff8396b973>] binder_transaction+0xc53/0x3f20 drivers/android/binder.c:3128
    [<ffffffff8396f213>] binder_thread_write+0x5d3/0x1790 drivers/android/binder.c:3975
    [<ffffffff839726cb>] binder_ioctl_write_read drivers/android/binder.c:5034 [inline]
    [<ffffffff839726cb>] binder_ioctl+0x22fb/0x3a30 drivers/android/binder.c:5321
    [<ffffffff8161f20c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8161f20c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8161f20c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8161f20c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff848802d5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848802d5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
