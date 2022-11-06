Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12961E790
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKFX0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiKFX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:26:41 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814364E6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:26:41 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso6201652iot.15
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 15:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1YaNYCdo24vX+f9IK4Gqu+nnyXE2CukaBelu6GETlc=;
        b=sIUhvBQiA/tVbNpHtqE8WHY9f8icqL/pnmKBCPJx697Inc86cHzGbwQ+inz0UhkMwU
         QBs3Hi5KZH2vNrsYbbmE3/hdM1Ath7aaJIEgGgiB7D0yTOx0HGRFMvuvkXnHjzglpr6H
         iCJvK97ChjiKc6GEyVCbCyrDJtsgUReyyiejmTrcOUyyBaKhgyLvRwLePZSGAwg7nA96
         kO/vHv/Zxrx7+3JcG3al8lse2/RhTsz4/qzMtqOiNRTBTQcN9fC5cOsPR8wBwIAoPCI2
         31urSqP2knm2t5qA2Az1EA2iv9MESM0oYvKeiUP+1nInUXD8oXT5GNngyeS+rmUv2RRh
         6iuw==
X-Gm-Message-State: ACrzQf3kqpvKpg7CRU+kBLiIzvClSePYHRta4ZvoFD/vLIa2vLDwf0Ok
        vz9N1SGJZTYYL3YVLigg6oFtMi3Jf8Fue9T+JjJ96pomI/lm
X-Google-Smtp-Source: AMsMyM6gkJ+m2iSL6eptVCxUdBe9QfRCvp7DplW7qrneq6rszdy7UuFsjNIeCwAO/TtmqQh5Qi732/JvKcWSvX/sj+VyI1QhAnus
MIME-Version: 1.0
X-Received: by 2002:a02:742e:0:b0:375:a423:c6dd with SMTP id
 o46-20020a02742e000000b00375a423c6ddmr8083748jac.287.1667777200404; Sun, 06
 Nov 2022 15:26:40 -0800 (PST)
Date:   Sun, 06 Nov 2022 15:26:40 -0800
In-Reply-To: <000000000000eb2d6c05e35a0d73@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009842e105ecd5a37e@google.com>
Subject: Re: [syzbot] memory leak in xas_create
From:   syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, code@siddh.me, deyu@sz.edu.cn,
        dvyukov@google.com, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, zokeefe@google.com
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

HEAD commit:    2f5065a0bc9d Merge tag 'acpi-6.1-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12351e76880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7da85296f1024c6a
dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110bbf39880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fff099880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e34093711ff/disk-2f5065a0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73117023c3a9/vmlinux-2f5065a0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c708621825f8/bzImage-2f5065a0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff88810fd216c0 (size 576):
  comm "syz-executor159", pid 3686, jiffies 4295064650 (age 50.150s)
  hex dump (first 32 bytes):
    06 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    20 85 98 0f 81 88 ff ff d8 16 d2 0f 81 88 ff ff   ...............
  backtrace:
    [<ffffffff844153c6>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff84418039>] xas_create+0x3b9/0x800 lib/xarray.c:679
    [<ffffffff84418520>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff8159f11c>] collapse_file+0x13c/0x2730 mm/khugepaged.c:1725
    [<ffffffff815a1b28>] hpage_collapse_scan_file+0x418/0x9a0 mm/khugepaged.c:2156
    [<ffffffff815a4001>] madvise_collapse+0x211/0x5e0 mm/khugepaged.c:2611
    [<ffffffff8153ba2d>] madvise_vma_behavior+0x5dd/0x1030 mm/madvise.c:1076
    [<ffffffff81537257>] madvise_walk_vmas+0x127/0x1d0 mm/madvise.c:1250
    [<ffffffff81537eb0>] do_madvise.part.0+0x1c0/0x2b0 mm/madvise.c:1429
    [<ffffffff8153c6e8>] do_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __do_sys_madvise mm/madvise.c:1442 [inline]
    [<ffffffff8153c6e8>] __se_sys_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __x64_sys_madvise+0x98/0xa0 mm/madvise.c:1440
    [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810fd21480 (size 576):
  comm "syz-executor159", pid 3686, jiffies 4295064650 (age 50.150s)
  hex dump (first 32 bytes):
    00 07 00 00 00 00 00 00 c0 16 d2 0f 81 88 ff ff  ................
    20 85 98 0f 81 88 ff ff 98 14 d2 0f 81 88 ff ff   ...............
  backtrace:
    [<ffffffff844153c6>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff84418039>] xas_create+0x3b9/0x800 lib/xarray.c:679
    [<ffffffff84418520>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff8159f11c>] collapse_file+0x13c/0x2730 mm/khugepaged.c:1725
    [<ffffffff815a1b28>] hpage_collapse_scan_file+0x418/0x9a0 mm/khugepaged.c:2156
    [<ffffffff815a4001>] madvise_collapse+0x211/0x5e0 mm/khugepaged.c:2611
    [<ffffffff8153ba2d>] madvise_vma_behavior+0x5dd/0x1030 mm/madvise.c:1076
    [<ffffffff81537257>] madvise_walk_vmas+0x127/0x1d0 mm/madvise.c:1250
    [<ffffffff81537eb0>] do_madvise.part.0+0x1c0/0x2b0 mm/madvise.c:1429
    [<ffffffff8153c6e8>] do_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __do_sys_madvise mm/madvise.c:1442 [inline]
    [<ffffffff8153c6e8>] __se_sys_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __x64_sys_madvise+0x98/0xa0 mm/madvise.c:1440
    [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810fd21240 (size 576):
  comm "syz-executor159", pid 3686, jiffies 4295064650 (age 50.150s)
  hex dump (first 32 bytes):
    00 06 00 00 00 00 00 00 c0 16 d2 0f 81 88 ff ff  ................
    20 85 98 0f 81 88 ff ff 58 12 d2 0f 81 88 ff ff   .......X.......
  backtrace:
    [<ffffffff844153c6>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff84418039>] xas_create+0x3b9/0x800 lib/xarray.c:679
    [<ffffffff84418520>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff8159f11c>] collapse_file+0x13c/0x2730 mm/khugepaged.c:1725
    [<ffffffff815a1b28>] hpage_collapse_scan_file+0x418/0x9a0 mm/khugepaged.c:2156
    [<ffffffff815a4001>] madvise_collapse+0x211/0x5e0 mm/khugepaged.c:2611
    [<ffffffff8153ba2d>] madvise_vma_behavior+0x5dd/0x1030 mm/madvise.c:1076
    [<ffffffff81537257>] madvise_walk_vmas+0x127/0x1d0 mm/madvise.c:1250
    [<ffffffff81537eb0>] do_madvise.part.0+0x1c0/0x2b0 mm/madvise.c:1429
    [<ffffffff8153c6e8>] do_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __do_sys_madvise mm/madvise.c:1442 [inline]
    [<ffffffff8153c6e8>] __se_sys_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __x64_sys_madvise+0x98/0xa0 mm/madvise.c:1440
    [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810fd24d80 (size 576):
  comm "syz-executor159", pid 3686, jiffies 4295064650 (age 50.150s)
  hex dump (first 32 bytes):
    00 05 00 00 00 00 00 00 c0 16 d2 0f 81 88 ff ff  ................
    20 85 98 0f 81 88 ff ff 98 4d d2 0f 81 88 ff ff   ........M......
  backtrace:
    [<ffffffff844153c6>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff84418039>] xas_create+0x3b9/0x800 lib/xarray.c:679
    [<ffffffff84418520>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff8159f11c>] collapse_file+0x13c/0x2730 mm/khugepaged.c:1725
    [<ffffffff815a1b28>] hpage_collapse_scan_file+0x418/0x9a0 mm/khugepaged.c:2156
    [<ffffffff815a4001>] madvise_collapse+0x211/0x5e0 mm/khugepaged.c:2611
    [<ffffffff8153ba2d>] madvise_vma_behavior+0x5dd/0x1030 mm/madvise.c:1076
    [<ffffffff81537257>] madvise_walk_vmas+0x127/0x1d0 mm/madvise.c:1250
    [<ffffffff81537eb0>] do_madvise.part.0+0x1c0/0x2b0 mm/madvise.c:1429
    [<ffffffff8153c6e8>] do_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __do_sys_madvise mm/madvise.c:1442 [inline]
    [<ffffffff8153c6e8>] __se_sys_madvise mm/madvise.c:1440 [inline]
    [<ffffffff8153c6e8>] __x64_sys_madvise+0x98/0xa0 mm/madvise.c:1440
    [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory

