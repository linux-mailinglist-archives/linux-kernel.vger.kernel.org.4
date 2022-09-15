Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0D5B9F56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIOQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIOQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:00:52 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D552DD8;
        Thu, 15 Sep 2022 09:00:37 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j7so14385760vsr.13;
        Thu, 15 Sep 2022 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=0Pdt+1Ige2oFRjEUxV93B3LnEG6UbwsKtuCYARwaodA=;
        b=QjsYS7gmdcXRIJ7wBYPzZeLPqoFhj2n4S9FRy44DYMQmD4e/Ehhrt+55PTsiD5Yr9A
         wmyVIuBQNco4/7dVB7luzRKBFQVNckuSgMxTb5kqHQ1A2/11T6lOjQZ5cAu2fQePr0kw
         jyhoX1oVH4zi3wW8igDSNxndc7n/VAAIMQz+PWOHqZ1m+oeZXWDqcOPcmu/eLFRvKnxU
         1LNmxIxGamfNe34vZ7V5AYIikFAqeMPa6l0usWiC/OJikSrERIk8q0zX8WsxbGys8nFH
         jK+tFd6quNv7IeEQUmfJlccriXiwb64/6HkuVrMhP4qj6ubcTeKtvE5AiI7xILvUsw7h
         qNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0Pdt+1Ige2oFRjEUxV93B3LnEG6UbwsKtuCYARwaodA=;
        b=epWGDbbb6j82GvKy9ce56zESPUCJRFwLSYyXO8Y9CyWxaKqZsb/2cSfoP6e4vGpojE
         PLa9cE1v0O5CBbznmvWwDyQQOvJFTbtH7X6LS8ykUBFIwQ6BNbnqK4FyW0pK58AVexQj
         F4w0HfxXLBv7pPYqSKrG94HQMCjKg7FqqPfczMg632LnCa/N+CVm+49hBniTQ9Fa8fG7
         ausAXCGRFmc+Nm4ozjKZag25TjREj8BiSF/HomMgr+AVR1/yY55SrE6GhmEViBklonRN
         +rtfeyUdvJiN+F7gh8YOoJSK2cDdj6UXl+5MqQvKjySUo4tUJW5p15e0aynVykggkhd9
         05mQ==
X-Gm-Message-State: ACrzQf01lplypqRFShOrOn57VYP6Kodu2+9OKA+849qbMuM/Ael6F4f9
        6k9lKQczbUFQKUJnOGv/vmS7Uuymk6o+X+zpxPwQC4eipXgbQVt2
X-Google-Smtp-Source: AMsMyM4uTXrmLG2mbxjs7JEThgiHIekXm5KWLIP8CqXpDdfnw31Lapitkg6IklNjkzAVJmW8Zt/GduTGldGEmDKBXr4=
X-Received: by 2002:a67:be16:0:b0:398:c2e4:e01f with SMTP id
 x22-20020a67be16000000b00398c2e4e01fmr251772vsq.33.1663257636504; Thu, 15 Sep
 2022 09:00:36 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Fri, 16 Sep 2022 00:00:25 +0800
Message-ID: <CAB7eex+2SMb8ccwudSJz+2se9E_DQ-t0jKBzqgw+5kJ7tzj5JQ@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Read in gspca_init_transfer
To:     mchehab@kernel.org, chadf@triularity.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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
C reproducer: https://pastebin.com/raw/0z4kf0YY
console output: https://pastebin.com/raw/w9egruEc

Basically, in the c reproducer, we use the gadget module to emulate
attaching a USB device(vendor id: 0x5e3, product id: 0xf191, with the
midi function) and executing some simple sequence of system calls.
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
the trick.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
==================================================================
BUG: KASAN: slab-out-of-bounds in gspca_init_transfer+0x2107/0x2260
drivers/media/usb/gspca/gspca.c:785
Read of size 1 at addr ffff888062754734 by task syz-fuzzer/12015

CPU: 1 PID: 12015 Comm: syz-fuzzer Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0xe5/0x66d mm/kasan/report.c:433
kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
gspca_init_transfer+0x2107/0x2260 drivers/media/usb/gspca/gspca.c:785
gspca_start_streaming+0x62/0xb0 drivers/media/usb/gspca/gspca.c:1360
vb2_start_streaming+0x160/0x4c0
drivers/media/common/videobuf2/videobuf2-core.c:1578
vb2_core_streamon drivers/media/common/videobuf2/videobuf2-core.c:2113 [inline]
vb2_core_streamon+0x1da/0x2c0
drivers/media/common/videobuf2/videobuf2-core.c:2080
__vb2_init_fileio+0xa18/0xcf0
drivers/media/common/videobuf2/videobuf2-core.c:2685
vb2_core_poll+0x4d2/0x7c0 drivers/media/common/videobuf2/videobuf2-core.c:2465
vb2_poll+0x31/0x150 drivers/media/common/videobuf2/videobuf2-v4l2.c:970
vb2_fop_poll+0x10e/0x360 drivers/media/common/videobuf2/videobuf2-v4l2.c:1217
v4l2_poll+0x158/0x220 drivers/media/v4l2-core/v4l2-dev.c:348
vfs_poll include/linux/poll.h:88 [inline]
ep_item_poll.isra.0+0xd8/0x170 fs/eventpoll.c:853
ep_insert fs/eventpoll.c:1522 [inline]
do_epoll_ctl+0x1bc4/0x3080 fs/eventpoll.c:2163
__do_sys_epoll_ctl fs/eventpoll.c:2214 [inline]
__se_sys_epoll_ctl fs/eventpoll.c:2205 [inline]
__x64_sys_epoll_ctl+0x13f/0x1c0 fs/eventpoll.c:2205
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x466938
Code: 10 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 8b 7c 24
08 8b 74 24 0c 8b 54 24 10 4c 8b 54 24 18 b8 e9 00 00 00 0f 05 <89> 44
24 20 c3 cc cc cc 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 44
RSP: 002b:000000c003f6fa88 EFLAGS: 00000206 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000466938
RDX: 000000000000002d RSI: 0000000000000001 RDI: 0000000000000003
RBP: 000000c003f6fad8 R08: 0000000000000000 R09: 0000000000000060
R10: 000000c003f6fac4 R11: 0000000000000206 R12: 0000000000203000
R13: 0000000000000050 R14: 000000c000285a00 R15: 00007fb683bd01f9
</TASK>

Allocated by task 2955:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:437 [inline]
____kasan_kmalloc mm/kasan/common.c:516 [inline]
____kasan_kmalloc mm/kasan/common.c:475 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
kasan_kmalloc include/linux/kasan.h:234 [inline]
__kmalloc+0x1da/0x3f0 mm/slub.c:4424
kmalloc include/linux/slab.h:605 [inline]
kzalloc include/linux/slab.h:733 [inline]
usb_parse_configuration drivers/usb/core/config.c:772 [inline]
usb_get_configuration+0xcc5/0x3ab0 drivers/usb/core/config.c:944
usb_enumerate_device drivers/usb/core/hub.c:2405 [inline]
usb_new_device+0x566/0x750 drivers/usb/core/hub.c:2543
hub_port_connect drivers/usb/core/hub.c:5353 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
port_event drivers/usb/core/hub.c:5653 [inline]
hub_event+0x23bd/0x4260 drivers/usb/core/hub.c:5735
process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888062754700
which belongs to the cache kmalloc-64 of size 64
The buggy address is located 52 bytes inside of
64-byte region [ffff888062754700, ffff888062754740)

The buggy address belongs to the physical page:
page:ffffea000189d500 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x62754
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffffea0001a09b40 dead000000000004 ffff888011c41640
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid
9616, tgid 9616 (modprobe), ts 237373775975, free_ts 237320038612
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2525 [inline]
prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
__alloc_pages+0x321/0x710 mm/page_alloc.c:5515
alloc_pages+0x117/0x2f0 mm/mempolicy.c:2270
alloc_slab_page mm/slub.c:1824 [inline]
allocate_slab mm/slub.c:1969 [inline]
new_slab+0x246/0x3a0 mm/slub.c:2029
___slab_alloc+0xa50/0x1060 mm/slub.c:3031
__slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
slab_alloc_node mm/slub.c:3209 [inline]
slab_alloc mm/slub.c:3251 [inline]
__kmalloc+0x388/0x3f0 mm/slub.c:4420
kmalloc include/linux/slab.h:605 [inline]
kzalloc include/linux/slab.h:733 [inline]
tomoyo_encode2.part.0+0xec/0x3b0 security/tomoyo/realpath.c:45
tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
tomoyo_realpath_from_path+0x186/0x620 security/tomoyo/realpath.c:288
tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
tomoyo_path_perm+0x219/0x420 security/tomoyo/file.c:822
security_inode_getattr+0xcf/0x140 security/security.c:1345
vfs_getattr+0x22/0x60 fs/stat.c:157
vfs_statx+0x170/0x360 fs/stat.c:232
vfs_fstatat+0x8c/0xb0 fs/stat.c:255
page last free stack trace:
create_dummy_stack mm/page_owner.c:67 [inline]
register_dummy_stack+0x65/0xa4 mm/page_owner.c:73
init_page_owner+0x43/0x943 mm/page_owner.c:91
invoke_init_callbacks mm/page_ext.c:112 [inline]
page_ext_init+0x53d/0x550 mm/page_ext.c:419
kernel_init_freeable+0x49d/0x74c init/main.c:1621

Memory state around the buggy address:
ffff888062754600: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
ffff888062754680: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff888062754700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
^
ffff888062754780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
ffff888062754800: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================
