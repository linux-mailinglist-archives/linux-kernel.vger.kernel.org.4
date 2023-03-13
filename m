Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AB6B72C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCMJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjCMJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:38:00 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C0E51C99
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:36:29 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id j24-20020a056e02219800b00322f108a4cfso3153438ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700181;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQj21PMomYrbfFU0svJ8oDxvPUY+plOfW2YUGlmSfgw=;
        b=T0xWyAawzzC2f70L6chJ+xZfGs9H6MO6geYZM0xzokjkSFnpmeUf4+31lFa7RxOH9L
         wUolZdlGCu8yYzBifcyjf2789mCf9Gw8jak2e/QE3k/4GNn5efd/1pUCy1TWP1ORjPNN
         kfZeWclwhISft/l90sG97V3ZC6ZZudOExqStXTEvtDbEFcJ3FsLDYuGofM9HeYAIbOGh
         3/Mn6BZo9fwqE19bLQoIO3lY18mI66puWugzOB+ilFJcasU3aSpA6bkySZdQbWp+fLGS
         tD0BbtHACWHekwnHTtvjSOUuV16UIDsuPdipOAxztgDutt1sXeYlBTs8kdxlx7UwHxKv
         b06Q==
X-Gm-Message-State: AO0yUKUHKmXcPY/SORUYSkIQgUItWHTodk9rvJv05OZvoUfCzGYHXnmL
        Sw5uUS92zSTO40l+gJ4j1ntocqTNZZ6expSkTrG7vPGO1hDn
X-Google-Smtp-Source: AK7set9o8s5IaTPxiD6UU2MJ7YohhoVuFWB+qS1+PlM+im8mmkh+coT7K/R/ELuJJjuaoTfCRLwR6OBAUJOdRF9pfS2a86lC4SBx
MIME-Version: 1.0
X-Received: by 2002:a5e:9413:0:b0:745:a722:4a15 with SMTP id
 q19-20020a5e9413000000b00745a7224a15mr15255224ioj.2.1678700181596; Mon, 13
 Mar 2023 02:36:21 -0700 (PDT)
Date:   Mon, 13 Mar 2023 02:36:21 -0700
In-Reply-To: <20230313091434.1789-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002300b05f6c4d86e@google.com>
Subject: Re: [syzbot] [scsi?] WARNING in remove_proc_entry (5)
From:   syzbot <syzbot+04a8437497bcfb4afa95@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in remove_proc_entry

------------[ cut here ]------------
remove_proc_entry: removing non-empty directory 'scsi/ums-sddr09', leaking at least '3'
WARNING: CPU: 1 PID: 5626 at fs/proc/generic.c:718 remove_proc_entry+0x361/0x460 fs/proc/generic.c:718
Modules linked in:
CPU: 1 PID: 5626 Comm: kworker/1:7 Not tainted 6.3.0-rc1-syzkaller-00274-g134231664868-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:remove_proc_entry+0x361/0x460 fs/proc/generic.c:718
Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 be 00 00 00 49 8b 94 24 d8 00 00 00 48 c7 c6 40 ac 5e 8a 48 c7 c7 60 ab 5e 8a e8 5f df 42 ff <0f> 0b e9 6d fe ff ff e8 c3 c2 7a ff 48 c7 c7 c0 68 99 8c e8 f7 e9
RSP: 0018:ffffc90005ec7650 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff92000bd8ecc RCX: 0000000000000000
RDX: ffff888020808000 RSI: ffffffff814bf3a7 RDI: 0000000000000001
RBP: ffff88807c1e4c80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880177e9b40
R13: ffff88807c1e4d38 R14: ffff88823bd68ff8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f209e780ff8 CR3: 0000000029ee1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scsi_proc_hostdir_rm+0x107/0x280 drivers/scsi/scsi_proc.c:206
 scsi_host_dev_release+0xc9/0x3b0 drivers/scsi/hosts.c:346
 device_release+0xa3/0x240 drivers/base/core.c:2436
 kobject_cleanup lib/kobject.c:681 [inline]
 kobject_release lib/kobject.c:712 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c2/0x4d0 lib/kobject.c:729
 put_device+0x1f/0x30 drivers/base/core.c:3697
 usb_unbind_interface+0x1dc/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:542 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:534
 __device_release_driver drivers/base/dd.c:1240 [inline]
 device_release_driver_internal+0x443/0x610 drivers/base/dd.c:1263
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x48a/0xb80 drivers/base/core.c:3775
 usb_disable_device+0x35a/0x7b0 drivers/usb/core/message.c:1420
 usb_disconnect+0x2db/0x8a0 drivers/usb/core/hub.c:2238
 hub_port_connect drivers/usb/core/hub.c:5246 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x1fbf/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x991/0x1710 kernel/workqueue.c:2390
 process_scheduled_works kernel/workqueue.c:2453 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2539
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         13423166 Merge tag 'staging-6.3-rc2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13eabf24c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aef547e348b1ab8
dashboard link: https://syzkaller.appspot.com/bug?extid=04a8437497bcfb4afa95
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a7ceecc80000

