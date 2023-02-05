Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023B68AFE0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBENL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBENLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:11:25 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2B11647
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:11:22 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id e16-20020a6b5010000000b00719041c51ebso5641733iob.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 05:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWrwv0lMtgE87dw/JVjoClgzMFoeV1YlFC1QbuXuALU=;
        b=iuOmRk8yx99fghu2AsaU6I1qOP4e6rnXxHlpAz/c6GVMhu7Ob70ujZM3Hmak45EoUB
         I2WX5AJZiSM+YN9cWRvSHSLK0nsU/ORyGbs2m+ifN6Dnp9Etn3Dm+m+jtfx7gYEApZZ1
         xvkwN+AdawTclAD+EgdsPnsjer+p4YJIVLMFrJLhApRfGbWGj+DPB+WQaBTqYuSGXyLs
         gyejer0omYGS31hx1xZjdN0htsFDnIonj3A/KUa5otGQiHWOMD+mb38BDq2tMq5TrrJH
         cpSv+DMZYVH4TwDuTR5hjZYiokfkiAQln+8Ii+/EF4JqENqmFjCcDpfIRF1f6bTAcraf
         9bDg==
X-Gm-Message-State: AO0yUKW+h2dPQ4TNGBAvsCxzicY+WbvgDZlMruar0CPKnKy26kHBi39/
        odbt+e2niuJfK8pOPoaNKzGjwY01ryzqQVtJmfuc0vO9rZBF
X-Google-Smtp-Source: AK7set+Bk20RwN21Ar95OOB1CdjMnytO/o9BuoIKy8eA04s+Fbmv+z/19Upf18pINCjhxSpTObzdg6IOAg/RujUFrhPgsabtR6q2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2bd0:b0:71e:38b3:c5bc with SMTP id
 s16-20020a0566022bd000b0071e38b3c5bcmr3455159iov.52.1675602681834; Sun, 05
 Feb 2023 05:11:21 -0800 (PST)
Date:   Sun, 05 Feb 2023 05:11:21 -0800
In-Reply-To: <20230205123357.1610-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2b13d05f3f3a66c@google.com>
Subject: Re: [syzbot] general protection fault in __blk_rq_map_sg
From:   syzbot <syzbot+0bbf896c8341c8e137c2@syzkaller.appspotmail.com>
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
KASAN: slab-out-of-bounds Read in sg_next

==================================================================
BUG: KASAN: slab-out-of-bounds in __sg_flags include/linux/scatterlist.h:79 [inline]
BUG: KASAN: slab-out-of-bounds in sg_is_chain include/linux/scatterlist.h:89 [inline]
BUG: KASAN: slab-out-of-bounds in sg_next+0xaf/0xc0 lib/scatterlist.c:29
Read of size 8 at addr ffff88801733b380 by task syz-executor.3/5840

CPU: 1 PID: 5840 Comm: syz-executor.3 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 __sg_flags include/linux/scatterlist.h:79 [inline]
 sg_is_chain include/linux/scatterlist.h:89 [inline]
 sg_next+0xaf/0xc0 lib/scatterlist.c:29
 blk_next_sg block/blk-merge.c:459 [inline]
 __blk_bvec_map_sg block/blk-merge.c:500 [inline]
 __blk_bios_map_sg block/blk-merge.c:548 [inline]
 __blk_rq_map_sg+0x34a/0xfd0 block/blk-merge.c:575
 scsi_alloc_sgtables+0x23c/0xf70 drivers/scsi/scsi_lib.c:1049
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1604 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1738
 blk_mq_dispatch_rq_list+0x710/0x23f0 block/blk-mq.c:2056
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x95e/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
 blk_mq_sched_dispatch_requests+0x10a/0x190 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0x2b7/0x480 block/blk-mq.c:2174
 __blk_mq_delay_run_hw_queue+0x5f7/0x700 block/blk-mq.c:2250
 blk_mq_run_hw_queue+0x3b5/0x560 block/blk-mq.c:2298
 blk_mq_sched_insert_requests+0x1d9/0xb30 block/blk-mq-sched.c:493
 blk_mq_dispatch_plug_list block/blk-mq.c:2758 [inline]
 blk_mq_flush_plug_list+0x39c/0xe10 block/blk-mq.c:2800
 __blk_flush_plug block/blk-core.c:1150 [inline]
 blk_finish_plug block/blk-core.c:1174 [inline]
 blk_finish_plug+0xbb/0x170 block/blk-core.c:1171
 __iomap_dio_rw+0xf85/0x1d80 fs/iomap/direct-io.c:602
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f453ec8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f453f980168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f453edac050 RCX: 00007f453ec8c0c9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000005
RBP: 00007f453ece7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffda01936ef R14: 00007f453f980300 R15: 0000000000022000
 </TASK>

Allocated by task 5840:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x175/0x320 mm/slub.c:3476
 mempool_alloc+0x158/0x360 mm/mempool.c:398
 __sg_alloc_table+0x248/0x380 lib/scatterlist.c:318
 sg_alloc_table_chained+0x9f/0x1f0 lib/sg_pool.c:133
 scsi_alloc_sgtables+0x1d3/0xf70 drivers/scsi/scsi_lib.c:1041
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1604 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1738
 blk_mq_dispatch_rq_list+0x710/0x23f0 block/blk-mq.c:2056
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x95e/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
 blk_mq_sched_dispatch_requests+0x10a/0x190 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0x2b7/0x480 block/blk-mq.c:2174
 __blk_mq_delay_run_hw_queue+0x5f7/0x700 block/blk-mq.c:2250
 blk_mq_run_hw_queue+0x3b5/0x560 block/blk-mq.c:2298
 blk_mq_sched_insert_requests+0x1d9/0xb30 block/blk-mq-sched.c:493
 blk_mq_dispatch_plug_list block/blk-mq.c:2758 [inline]
 blk_mq_flush_plug_list+0x39c/0xe10 block/blk-mq.c:2800
 __blk_flush_plug block/blk-core.c:1150 [inline]
 blk_finish_plug block/blk-core.c:1174 [inline]
 blk_finish_plug+0xbb/0x170 block/blk-core.c:1171
 __iomap_dio_rw+0xf85/0x1d80 fs/iomap/direct-io.c:602
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801733b280
 which belongs to the cache sgpool-8 of size 256
The buggy address is located 0 bytes to the right of
 allocated 256-byte region [ffff88801733b280, ffff88801733b380)

The buggy address belongs to the physical page:
page:ffffea00005ccec0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1733b
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88814526f500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x192820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5839, tgid 5837 (syz-executor.3), ts 93322224247, free_ts 93320303745
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4328
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5594
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x28e/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x30a/0x320 mm/slub.c:3476
 mempool_alloc+0x158/0x360 mm/mempool.c:398
 __sg_alloc_table+0x248/0x380 lib/scatterlist.c:318
 sg_alloc_table_chained+0x9f/0x1f0 lib/sg_pool.c:133
 scsi_alloc_sgtables+0x1d3/0xf70 drivers/scsi/scsi_lib.c:1041
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1604 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1738
 blk_mq_dispatch_rq_list+0x710/0x23f0 block/blk-mq.c:2056
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x95e/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3390 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3485
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1304 [inline]
 put_page include/linux/mm.h:1373 [inline]
 generic_pipe_buf_release+0x23d/0x2b0 fs/pipe.c:210
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 iov_iter_revert.part.0+0x402/0x730 lib/iov_iter.c:935
 iov_iter_revert+0x4c/0x60 lib/iov_iter.c:919
 __iomap_dio_rw+0x16cb/0x1d80 fs/iomap/direct-io.c:610
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff88801733b280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801733b300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801733b380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88801733b400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801733b480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=166ef3ad480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=0bbf896c8341c8e137c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173f904b480000

