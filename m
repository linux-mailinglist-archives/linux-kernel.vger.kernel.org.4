Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED4068ABF5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjBDSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBDSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:44:49 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565601E2AD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:44:48 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id q12-20020a6b8e0c000000b0071d8eef7c67so4868092iod.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjDmyxyUOZHic8lE/M6XOn+LVM1uE2SOfT+VAvURm50=;
        b=z/p6WqNBMgUV118uolJPJbZQP3EksaHmcfE2EjWPnccQ3hihnxgUixIRlZqkJf6uid
         SkMWFotM44TEJH7dPKszaUdLXEWfp7o3WdmkPRTv/yzat6tMTdoUIAHIaiyY1F6RV03F
         +U5ZRzG8i5Wibbr54N8/kNUYVjrLtRpHjPAflTqaWaTGJbBr3nQdKHrd7qlhCskou+9N
         hmMy5fp+LEqTomWOASIeotHTnO3zHzNbbXmFGaqrsldWzdLRE2N+qOpsKopK0Ui4H/Na
         X2FFm0QfKfEoDRhEIdPEaDpAs409UB7CcFbTFxECa/hGkrdC78znVZgzvvNr7WEoZMmu
         iGYw==
X-Gm-Message-State: AO0yUKU1tlh7iVCiWLGl6Q9k0UxJfpoqdCAJq2fifmQO32sMmlFi5Ukx
        ku0Jcm9RqE7EtL+YzRxYrr31qPrbI6dd69qTiLCovhIsVXcw
X-Google-Smtp-Source: AK7set+ctDut9VRnha6EN7M82mdSuigd92RolP49OoaMAuvYGb2SBuzWLFtbmNAO+k3nZsPLRvQMH3iGoyUqY2tEBKNKPtr3OkD4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10e5:b0:3ad:c6ff:66f with SMTP id
 g5-20020a05663810e500b003adc6ff066fmr3393954jae.11.1675536287596; Sat, 04 Feb
 2023 10:44:47 -0800 (PST)
Date:   Sat, 04 Feb 2023 10:44:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b04d205f3e431d1@google.com>
Subject: [syzbot] general protection fault in __blk_rq_map_sg
From:   syzbot <syzbot+0bbf896c8341c8e137c2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    80bd9028feca Add linux-next specific files for 20230131
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17126969480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=904dc2f450eaad4a
dashboard link: https://syzkaller.appspot.com/bug?extid=0bbf896c8341c8e137c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1534e75d480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/924618188238/disk-80bd9028.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a03cf86e545/vmlinux-80bd9028.xz
kernel image: https://storage.googleapis.com/syzbot-assets/568e80043a41/bzImage-80bd9028.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bbf896c8341c8e137c2@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5252 Comm: syz-executor.2 Not tainted 6.2.0-rc6-next-20230131-syzkaller-09515-g80bd9028feca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:sg_assign_page include/linux/scatterlist.h:109 [inline]
RIP: 0010:sg_set_page include/linux/scatterlist.h:139 [inline]
RIP: 0010:__blk_bvec_map_sg block/blk-merge.c:501 [inline]
RIP: 0010:__blk_bios_map_sg block/blk-merge.c:548 [inline]
RIP: 0010:__blk_rq_map_sg+0x36e/0xfd0 block/blk-merge.c:575
Code: 38 e8 36 5f 1a 00 48 89 c3 e8 9e 62 88 fd 48 8b 44 24 20 80 38 00 0f 85 fe 0b 00 00 48 8b 04 24 48 89 18 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 f3 0b 00 00 4c 8b 74 24 30 31 ff 48 8b 2b 41
RSP: 0018:ffffc9000428edf8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888019293a80 RSI: ffffffff83fc5382 RDI: 0000000000000007
RBP: ffff888021114bb8 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000a00
FS:  00007f50df7a5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50df784718 CR3: 0000000077767000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scsi_alloc_sgtables+0x236/0xf70 drivers/scsi/scsi_lib.c:1048
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1603 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1737
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
RIP: 0033:0x7f50dea8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50df7a5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f50debabf80 RCX: 00007f50dea8c0c9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f50deae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000001ff01 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffbb4e322f R14: 00007f50df7a5300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sg_assign_page include/linux/scatterlist.h:109 [inline]
RIP: 0010:sg_set_page include/linux/scatterlist.h:139 [inline]
RIP: 0010:__blk_bvec_map_sg block/blk-merge.c:501 [inline]
RIP: 0010:__blk_bios_map_sg block/blk-merge.c:548 [inline]
RIP: 0010:__blk_rq_map_sg+0x36e/0xfd0 block/blk-merge.c:575
Code: 38 e8 36 5f 1a 00 48 89 c3 e8 9e 62 88 fd 48 8b 44 24 20 80 38 00 0f 85 fe 0b 00 00 48 8b 04 24 48 89 18 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 f3 0b 00 00 4c 8b 74 24 30 31 ff 48 8b 2b 41
RSP: 0018:ffffc9000428edf8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888019293a80 RSI: ffffffff83fc5382 RDI: 0000000000000007
RBP: ffff888021114bb8 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000a00
FS:  00007f50df7a5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdfee5f5d8 CR3: 0000000077767000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	38 e8                	cmp    %ch,%al
   2:	36 5f                	ss pop %rdi
   4:	1a 00                	sbb    (%rax),%al
   6:	48 89 c3             	mov    %rax,%rbx
   9:	e8 9e 62 88 fd       	callq  0xfd8862ac
   e:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  13:	80 38 00             	cmpb   $0x0,(%rax)
  16:	0f 85 fe 0b 00 00    	jne    0xc1a
  1c:	48 8b 04 24          	mov    (%rsp),%rax
  20:	48 89 18             	mov    %rbx,(%rax)
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 f3 0b 00 00    	jne    0xc28
  35:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  3a:	31 ff                	xor    %edi,%edi
  3c:	48 8b 2b             	mov    (%rbx),%rbp
  3f:	41                   	rex.B


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
