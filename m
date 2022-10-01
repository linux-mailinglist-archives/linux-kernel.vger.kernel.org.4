Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA65F1C6F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJANmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJANmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:42:43 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A989AC8
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:42:40 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u9-20020a5edd49000000b006a0f03934e9so4469562iop.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ARZ4bkJfeRcRAEqYpLLHyXYXuRHzWrlhgSGhuIyIbVM=;
        b=7e3e+SvY9l7sbV2JuaVWxxF4appxJlphUg8E16TPvjTkgy1TrfPwVDTwpeGD9p9kYr
         W93RxsmjmWwTQmDhCe4VigSXHkT/yp5zwfJNPg46GU/llBpACrcO9QKccqDMXtiaypEg
         zHvYd/+y6kh/7ekzG4cNJoHcAvzJ9eLNoGoH12ODOCeD8hTVy0MK6IqbaJoTZ848Ympk
         Z/bjIoBHVk1+EWstyYqQwooKTeHOrqwWkZweUgpsmUjCrJyrJusFQbqbwfQZngghAwX6
         9JAZD1P/G45T8fIuaQN95DYNjQ2Km8Mo/xQk1ngFke4k9N9h2/O/x4y3qWVFYoHKbTf+
         Admg==
X-Gm-Message-State: ACrzQf1EnG16orVcdpPrkIzkaGQDjsYHwqCJOjhb+NHtm79uCYb2egRb
        L7q4kZkU/WM+wg7Qo+3vyyI6Lx1F0O7TwES8mynVt5kJWjnE
X-Google-Smtp-Source: AMsMyM7Avfm3fQHnfLpKiL064lDMFFnWY3+6ROrrgTHOFmLdpgkl7dt8l6A62MGlV+rT5r9u3v8sghhcWaEkhlxMUeSBeFeDclbe
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:2f6:5f42:89ed with SMTP id
 i6-20020a056e0212c600b002f65f4289edmr6326494ilm.153.1664631759856; Sat, 01
 Oct 2022 06:42:39 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:42:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba699305e9f94839@google.com>
Subject: [syzbot] BUG: corrupted list in kobject_cleanup
From:   syzbot <syzbot+430e395e8c74123e1918@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16ee7ddf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=430e395e8c74123e1918
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+430e395e8c74123e1918@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff00010248a8a0, but was dead4ead00000000. (next=ffff0000f3429438)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3061 Comm: syz-executor.3 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
lr : __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
sp : ffff80001281bb90
x29: ffff80001281bb90 x28: ffff0000c8b4b500 x27: 0000000000000000
x26: ffff80000d30cf28 x25: ffff80000d309000 x24: 0000000000000008
x23: 0000000000000003 x22: ffff80000d56ad28 x21: 0000000000000000
x20: ffff00010248a8a0 x19: ffff00010248a898 x18: 00000000000000c0
x17: 20747562202c3061 x16: ffff80000db49158 x15: ffff0000c8b4b500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c8b4b500
x11: ff808000081c1630 x10: 0000000000000000 x9 : bf3d65c85afff700
x8 : bf3d65c85afff700 x7 : ffff800008195d30 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000000000001 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 kobj_kset_leave lib/kobject.c:175 [inline]
 __kobject_del+0xa8/0x1f8 lib/kobject.c:592
 kobject_cleanup+0xfc/0x280 lib/kobject.c:664
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x94/0xf8 lib/kobject.c:721
 nilfs_sysfs_delete_segctor_group fs/nilfs2/sysfs.c:700 [inline]
 nilfs_sysfs_delete_device_group+0x50/0x7c fs/nilfs2/sysfs.c:1044
 destroy_nilfs+0x4c/0xa0 fs/nilfs2/the_nilfs.c:89
 nilfs_put_super+0x84/0x9c fs/nilfs2/super.c:480
 generic_shutdown_super+0x8c/0x190 fs/super.c:491
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: d4210000 9001b460 912e4800 94a768fa (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
