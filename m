Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04416F968C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjEGCKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 22:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjEGCJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 22:09:59 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BE1A135
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 19:09:55 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-331632be774so142618335ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 19:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683425394; x=1686017394;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCGzJlBD2yd7BzlCvbT+sUV6P4yQZ0ASIhuFr1gnVdE=;
        b=j3YOlgOvJ0yHaVxri/2OM9gt77WLv3uBig4teHdJXQdRz/0T3uAcPjZ9vpIgicJQp8
         k/4E9h0RIBCVpY84z8xhykj2+GQrF53+/vSBgu/lbZQTBy63HzN+aGwyb+7tOqXEoSxC
         mbRtS8Tj77N5hBQdS9/WPaDP+e7IYRKAxjHi/B2M0OVmP111lS/wNbymhlWhDyQjSSpr
         YSuBxAqeqc3WCmE+vvPAx0zC2jbzyhApF7kmjr+EiHKu6bzIjMmaKb14XjXF9bOHodgy
         9xbG6m3DVYGUcudOMtzpolhLS+YIMa0qSad4S9ASpILQQOZtA30TwAzKBYEOAOMGiXXT
         tauQ==
X-Gm-Message-State: AC+VfDymiFEbztU76Fgj0fHWqv8KZu5G6h7GSjBLZd1eXzo2xWsPEuZk
        0GOhtwvWNVhW2rsYWjvN8RcD+OBBQYjcGSDr5wQQ9QF6fRUT
X-Google-Smtp-Source: ACHHUZ6q7CZqAawekgqiGpPOxPk/hFxS6An45eYFHRNysdsldbZPaItMHXTnyrZ9hjvK1w7PuN9UH7lCN0jfeVk1BF1g4psq+DbT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:36e5:b0:416:57cb:ccac with SMTP id
 t37-20020a05663836e500b0041657cbccacmr3015882jau.2.1683425394358; Sat, 06 May
 2023 19:09:54 -0700 (PDT)
Date:   Sat, 06 May 2023 19:09:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3003605fb110424@google.com>
Subject: [syzbot] [nfc?] WARNING in __do_kernel_fault (3)
From:   syzbot <syzbot+a373a8ad351dacac270c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7df047b3f0aa Merge tag 'vfio-v6.4-rc1' of https://github.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c4d222280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=771c565ea138992b
dashboard link: https://syzkaller.appspot.com/bug?extid=a373a8ad351dacac270c
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a373a8ad351dacac270c@syzkaller.appspotmail.com

------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 00003609183bf5b0
x14: 000000000000014b x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 00006d5cf25a0f34
x14: 00000000000001df x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000000ba0 x12: 00000000000003e0
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000000c15 x12: 0000000000000407
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffef9cd3a8
x14: 0000000000000287 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000a8932093e75e
x14: 0000000000000226 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000a4b961bb5246
x14: 00000000000001f0 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 1 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 1 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b1f130240e68
x14: 000000000000007a x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000000e5e x12: 00000000000004ca
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000000ed3 x12: 00000000000004f1
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 105335 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000000f4b x12: 0000000000000519
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : ffff00007f9b7c88 x4 : 0000000000000000 x3 : ffff800075617000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000000fc0 x12: 0000000000000540
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000001035 x12: 0000000000000567
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000a538ce5d25da
x14: 00000000000002cd x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 000000000000111f x12: 00000000000005b5
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000001194 x12: 00000000000005dc
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 0000b0ae79ca6714
x14: 000000000000016f x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 000000000000127e x12: 000000000000062a
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b2b63376c440
x14: 000000000000000b x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b32e90bdb2fe
x14: 00000000000000f5 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 132479 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 0 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 0 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 00000000000013e0 x12: 00000000000006a0
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : ffff00007f9b7c88 x4 : 0000000000000000 x3 : ffff800075617000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 1 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 1 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 00000000fffffffb
x17: 6564207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a3eccf8 x13: 0000000000001455 x12: 00000000000006c7
x11: 2073736572646461 x10: ffff80000a49ccf8 x9 : 00000000ffffe000
x8 : ffff80000a3eccf8 x7 : ffff80000a49ccf8 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 1 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 1 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b295e87cb626
x14: 0000000000000283 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 1 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 1 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b4e3fcb2fda4
x14: 0000000000000254 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 1 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 1 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b541ee160f64
x14: 000000000000007a x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fbff0000236abf00
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
 do_bad_area arch/arm64/mm/fault.c:479 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:733
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:867
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 nfc_llcp_find_local net/nfc/llcp_core.c:286 [inline]
 nfc_llcp_unregister_device+0x34/0x10c net/nfc/llcp_core.c:1611
 nfc_unregister_device+0x74/0xb0 net/nfc/core.c:1179
 nci_unregister_device+0xb8/0xe8 net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x1c/0x40 drivers/nfc/virtual_ncidev.c:163
 __fput+0x78/0x258 fs/file_table.c:321
 ____fput+0x10/0x1c fs/file_table.c:349
 task_work_run+0x6c/0xc4 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x214/0x144c arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address dead000000000110
WARNING: CPU: 1 PID: 6668 at arch/arm64/mm/fault.c:374 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
Modules linked in:
CPU: 1 PID: 6668 Comm: syz-executor.0 Tainted: G        W          6.3.0-syzkaller-12570-g7df047b3f0aa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:374
sp : ffff80000aff39f0
x29: ffff80000aff39f0 x28: fbff0000236abf00 x27: 0000000000000000
x26: 0000000045585401 x25: fbff0000236acae0 x24: 0000000000000000
x23: 0000000080400009 x22: 0000000000000025 x21: dead000000000110
x20: ffff80000aff3ab0 x19: 0000000097c18004 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b0ad84a4ea00
x14: 0000000000000215 x13: ffff800009fbaed8 x12: ffff80000a3bfef0
x11: 0000000000000001 x10: 5e80d0bfb87b43ed x9 : 5d8fca8ff35a965c
x8 : fbff0000236ace88 x7 : 0000000000000004 x6 : 0000000000000190
x5 : 00000000000f0510 x4 : 0000000000f0000f x3 : 000000000000ffff
x2 : 0000000000000

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
