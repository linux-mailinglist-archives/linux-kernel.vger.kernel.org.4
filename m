Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3D5BCC53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiISM6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:58:40 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F7A44F;
        Mon, 19 Sep 2022 05:58:39 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id c3so29795178vsc.6;
        Mon, 19 Sep 2022 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=oqyriXhw9iwWn5iMmwsKanhUI67k1U3DDEYvOYpbhWI=;
        b=gmIUyuVLwKJq30NkpHMaADTCmrgyHVY7P6VCFjXB9aOYI9Rs/Kt98CuCTSjLQVw7eb
         BC/RDjSjHV2yuWGfuM81QTgIOn3PzwFAIuOHlwOoXSU1Zmk9QaoMkaVq8ppSy7xZfRPT
         rwoAnFIgwxwfSD7cnxJpzvGThcAK/cwMRbP9aACr4HX10fUV1CJEu4ENvMTD6ni4e1Xk
         3gl7apy+i+GwNhkrv/m65RGZJUkY4W/LYVPwnP0EJdbUp/dO5IUzznfXM2oxX1HzTmM3
         mrBRYK8/mxX9b+ik/PtMkLlIgaEmbWwGhGVgaSfJlsogRua8bQLXXJa2l0gRkyJQncBe
         YUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=oqyriXhw9iwWn5iMmwsKanhUI67k1U3DDEYvOYpbhWI=;
        b=B8i6mb4PdZHVd58FGewahJU5YT1cOe41sTB/91NsDEbp22Pg9bwpQ+yyFe+9lEd1A2
         jmr2cg9PGwrTP1brDb5XA1JCoIGabrz/Cz9HFa7v9Y0U+3PbXpAy4bMjEeswL/iEQwip
         iVVIH+VRLaZ7MEkGhn7Q1G5IJZ2ieV/IZ1snHmd2+4eAgNqBpAeur/Py+ootJMArik1l
         7rPE9yh4/mRn67gFhIMAmLUhpsUVRHH0lLHZQXgCAbK5CwjClGUKzneRX0Zcm7CJbyyO
         ttXcKS5uT0mHdcV7AhofJa4H6ZMzM4QVNSMoE7KfX13ua+B+iNfZpf0KYdbcg20zTs8u
         CvCA==
X-Gm-Message-State: ACrzQf2sM/AkCK7GtlkjygPQhgQ97rshbrmru7A1bmFhuX5YHzkXEtgz
        EPOFlsA2tLql9SyAMHsalTKLhZarne91CoH37jmMw/+JCQU=
X-Google-Smtp-Source: AMsMyM7BVV+DB1uz3YO5kQfjW/cHJa7XI5lehnoeilggrBWMVEob/pQo13f238/PpP74i7d33HL4fVqU8GVKZLYyAlQ=
X-Received: by 2002:a67:8c43:0:b0:398:6815:d340 with SMTP id
 o64-20020a678c43000000b003986815d340mr5982456vsd.42.1663592318223; Mon, 19
 Sep 2022 05:58:38 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Mon, 19 Sep 2022 20:58:27 +0800
Message-ID: <CAB7eexLVxfJb6RJQaJwvGeYwU+rjMKA2ZPC6b-1sWtcUyxj0jw@mail.gmail.com>
Subject: KASAN: out-of-bounds Read in digitv_ctrl_msg
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
triggered.

HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
git tree: upstream

kernel config: https://pastebin.com/raw/xtrgsXP3
console output: https://pastebin.com/raw/cEM9u2rq

Sorry for failing to extract the reproducer. But on other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

==================================================================
BUG: KASAN: out-of-bounds in digitv_ctrl_msg+0x200/0x270
drivers/media/usb/dvb-usb/digitv.c:44
Read of size 18446744073709551615 at addr ffffc9000238fbd1 by task
syz-executor.4/8977

CPU: 0 PID: 8977 Comm: syz-executor.4 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x18a/0x66d mm/kasan/report.c:433
 kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13b/0x190 mm/kasan/generic.c:189
 memcpy+0x20/0x60 mm/kasan/shadow.c:65
 digitv_ctrl_msg+0x200/0x270 drivers/media/usb/dvb-usb/digitv.c:44
 digitv_i2c_xfer+0x241/0x3b0 drivers/media/usb/dvb-usb/digitv.c:73
 __i2c_transfer drivers/i2c/i2c-core-base.c:2109 [inline]
 __i2c_transfer+0x4c2/0x16a0 drivers/i2c/i2c-core-base.c:2074
 i2c_smbus_xfer_emulated+0x1be/0xf00 drivers/i2c/i2c-core-smbus.c:469
 __i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:607 [inline]
 __i2c_smbus_xfer+0x504/0x10b0 drivers/i2c/i2c-core-smbus.c:553
 i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:545 [inline]
 i2c_smbus_xfer+0x100/0x380 drivers/i2c/i2c-core-smbus.c:535
 i2cdev_ioctl_smbus+0x496/0x830 drivers/i2c/i2c-dev.c:348
 i2cdev_ioctl+0x3cc/0x7b0 drivers/i2c/i2c-dev.c:467
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcf784a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf78bf8bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcf7859c340 RCX: 00007fcf784a80fd
RDX: 00000000200003c0 RSI: 0000000000000720 RDI: 0000000000000003
RBP: 00007fcf7850b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffeabc59d2f R14: 00007ffeabc59ed0 R15: 00007fcf78bf8d80
 </TASK>

The buggy address belongs to stack of task syz-executor.4/8977
 and is located at offset 177 in frame:
 i2c_smbus_xfer_emulated+0x0/0xf00 drivers/i2c/i2c-core-smbus.c:315

This frame has 3 objects:
 [32, 64) 'msg'
 [96, 130) 'msgbuf1'
 [176, 211) 'msgbuf0'

The buggy address belongs to the virtual mapping at
 [ffffc90002388000, ffffc90002391000) created by:
 kernel_clone+0xe7/0x1040 kernel/fork.c:2673

The buggy address belongs to the physical page:
page:ffffea000165d400 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x59750
memcg:ffff88801ed70d02
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88801ed70d02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 62, tgid 62
(kworker/u6:2), ts 245371815797, free_ts 242367217728
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2525 [inline]
 prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
 get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
 __alloc_pages+0x321/0x710 mm/page_alloc.c:5515
 alloc_pages+0x117/0x2f0 mm/mempolicy.c:2270
 vm_area_alloc_pages mm/vmalloc.c:2958 [inline]
 __vmalloc_area_node mm/vmalloc.c:3026 [inline]
 __vmalloc_node_range+0xb2c/0x1320 mm/vmalloc.c:3196
 alloc_thread_stack_node kernel/fork.c:312 [inline]
 dup_task_struct kernel/fork.c:977 [inline]
 copy_process+0x4608/0x6f80 kernel/fork.c:2087
 kernel_clone+0xe7/0x1040 kernel/fork.c:2673
 user_mode_thread+0xad/0xe0 kernel/fork.c:2742
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
 worker_thread+0x623/0x1070 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x410 mm/page_alloc.c:3476
 kasan_depopulate_vmalloc_pte+0x5c/0x70 mm/kasan/shadow.c:372
 apply_to_pte_range mm/memory.c:2633 [inline]
 apply_to_pmd_range mm/memory.c:2677 [inline]
 apply_to_pud_range mm/memory.c:2713 [inline]
 apply_to_p4d_range mm/memory.c:2749 [inline]
 __apply_to_page_range+0x66e/0xf50 mm/memory.c:2783
 kasan_release_vmalloc+0xa2/0xb0 mm/kasan/shadow.c:486
 __purge_vmap_area_lazy+0x880/0x1c10 mm/vmalloc.c:1753
 drain_vmap_area_work+0x52/0xe0 mm/vmalloc.c:1782
 process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
 worker_thread+0x623/0x1070 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffffc9000238fa80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000238fb00: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 f2 f2 f2 f2
>ffffc9000238fb80: 00 00 00 00 02 f2 f2 f2 f2 f2 00 00 00 00 03 f3
                                                 ^
 ffffc9000238fc00: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000238fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
