Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2340B66B4F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjAPAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjAPAeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:34:24 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C894C2F
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 16:34:24 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id s17-20020a0566022bd100b00704c01f38abso148556iov.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 16:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gms77sXyp4PM9SsI09aImaGSdmPJK2f/lIA2WbC1zTY=;
        b=M4QoP8sDSTwA97ZJMjp8Cd7SeQlNWS9PXBp26wNVdIZ/GcwDCzCb0KLESVlWe+RX8H
         uZCPt7nKzmDk6QoV6G119E4mSwxxNCQmM+LFj4c/9HT9FF+ggpcGXorRY9g00ZtvLEfT
         XzAas1N8s9M1i1mNqclqRoo2rxw05b+2vAI3SEE5BhKFYZUC+0s+S5Au7vm+rkq53Z8x
         q+T6tSuThF3+PX3HRxi1vxhy+e/yLELu708ZZXMd+V9sbuE6Y/BHcpBWEYDe0+kOkQIF
         ltR410lucCjz3kaM8xCvYyweau3sz5lRO1AaaMApNrUYeSqJqKcp1QCwC1EVDu0SNNi4
         Hqrw==
X-Gm-Message-State: AFqh2krqFLany8CQxOgwfjsREDUbXdYk+y6+h4BRZQoVJFo+JPPd5hAx
        jWbq9P5n2yzrRVoz3DSC+E8n8M6a3NwOy6UzQOdr4btTeA17
X-Google-Smtp-Source: AMrXdXvPDjNMwFySN+NdVXgigaWdobbJeVsL1mNw/gZJpeOyFBxKUfwKwGQzTm4Rvgtet40YJlKLsgxChqapVTEJaMr5XZ9nFDl+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:27c:b0:38a:757f:14b4 with SMTP id
 x28-20020a056638027c00b0038a757f14b4mr9076418jaq.307.1673829263312; Sun, 15
 Jan 2023 16:34:23 -0800 (PST)
Date:   Sun, 15 Jan 2023 16:34:23 -0800
In-Reply-To: <20230116000718.1809-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a78f3405f256be8b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
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
WARNING: ODEBUG bug in __io_put_task

IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
------------[ cut here ]------------
ODEBUG: free active (active state 1) object: ffff88802a236ca8 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 899 at lib/debugobjects.c:509 debug_print_object+0x194/0x2c0 lib/debugobjects.c:509
Modules linked in:
CPU: 0 PID: 899 Comm: kworker/0:2 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events io_fallback_req_func
RIP: 0010:debug_print_object+0x194/0x2c0 lib/debugobjects.c:509
Code: df 48 89 fe 48 c1 ee 03 80 3c 16 00 0f 85 c7 00 00 00 48 8b 14 dd c0 dc a6 8a 50 4c 89 ee 48 c7 c7 80 d0 a6 8a e8 40 76 ae 05 <0f> 0b 58 83 05 0e 25 66 0a 01 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90004aef950 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88801eba3a80 RSI: ffffffff8166972c RDI: fffff5200095df1c
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8a4dd0a0
R13: ffffffff8aa6d580 R14: ffff888070a92da8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005639964dc950 CR3: 000000007dcca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:996 [inline]
 debug_check_no_obj_freed+0x305/0x420 lib/debugobjects.c:1027
 slab_free_hook mm/slub.c:1756 [inline]
 slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xec/0x4e0 mm/slub.c:3809
 put_task_struct_many include/linux/sched/task.h:125 [inline]
 __io_put_task+0x155/0x1e0 io_uring/io_uring.c:729
 io_put_task io_uring/io_uring.h:328 [inline]
 __io_req_complete_post+0x7ec/0xd20 io_uring/io_uring.c:982
 io_req_complete_post+0xf1/0x1a0 io_uring/io_uring.c:998
 io_req_task_complete+0x189/0x260 io_uring/io_uring.c:1636
 io_poll_task_func+0xa95/0x1220 io_uring/poll.c:347
 io_fallback_req_func+0xfd/0x204 io_uring/io_uring.c:252
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17a99c7a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1145447e480000

