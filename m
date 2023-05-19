Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F8709035
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjESHNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjESHNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:13:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9D10D0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 00:13:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3941c3ba226so1823929b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684480415; x=1687072415;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egSzj1GevLMUbPHUEJPsVJawKF57WYXztEr3RntCX4U=;
        b=bi+CyzjOeaeMIaBjkopMtvhqJHFRAggtf57TONQVSG8LlJa/4/Ddk1dpVvG255WIZL
         HL5GWIfBf6HD3dXEmiWoD/K8dTlvO4WMdhovhe5HhZrI1z9N6DA12V1owZOruNFyqUEY
         yuo4GgSrNEy6/QQ/rBhpVlDWKlhY/Uuy4ewX02UoG/bdKJnjXh0Mk1mBBCjwux4z9x9x
         0Ssice4/rrIAXzeXsbSDMhza5bO4bpsQ5+mDwPeAwxyETVOYizPHeXq/D2qHgaA8xX98
         A06DDthsqwi6iLtIbjC6Idyq6WNINDJJJPlbiNTWcRo+4FS1+Jbcl6ZvSxMlxEbLHA+s
         ujxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684480415; x=1687072415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egSzj1GevLMUbPHUEJPsVJawKF57WYXztEr3RntCX4U=;
        b=Z2PYoj5JgmwDhtHU1qDQRDdbpSqIM7ceMbIoO94hUXSqvEuFhRZ29223BpW7HzeKDs
         pe+H4UA+5HGBoq1u3jqfnHLFAAUMc/br2Fif2zO4NHh2sVkkpEN2mbTdKb6IOXOoygMW
         eDumKMBNjrb44ywCRVYk2WYzuyUMBU95init+1hS9WARGAOe1kCO/x0XJIx84RnpIv5T
         Ps9Z42KsraNlxBfAy7sKyeLVhT/3zgQzdBqDfws3WUEgfGamOfOB0fa6zk19G/X+l0Eo
         BKsvl/CN/kXyV6mjvQaeUvkJB0NXMF6vYLIEiVbA3D2SuMzDvnj+umHZRusVbnHqK7Hr
         2AaQ==
X-Gm-Message-State: AC+VfDz4qQk3KE2K/4m4FpL8RE7vmt53TbsObiBXwpDNGZrx37HEKYvQ
        aYqEsq/YMsbPKD0F1WVCeeeJTKZZTqAzHBq3QbfbDoAt7kkvkMYf
X-Google-Smtp-Source: ACHHUZ5UXpBqr+hcH7v5FWkYUdqANhvm/PpRdWEm8OFW/juz4P7B+HEjMpbK52AGsK22EWA0M9XI9ddYvIPnE+xQo34=
X-Received: by 2002:a05:6808:3c5:b0:38d:1597:71f1 with SMTP id
 o5-20020a05680803c500b0038d159771f1mr768246oie.31.1684480414968; Fri, 19 May
 2023 00:13:34 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Fri, 19 May 2023 15:13:23 +0800
Message-ID: <CAFcO6XMJC=u5aASRNCqfVi7tJwDJBYGCw5i13M-R8zXdB9-8Ew@mail.gmail.com>
Subject: A null-ptr-deref bug in f2fs_write_end_io
To:     Jaegeuk Kim <jaegeuk@kernel.org>, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there is a null-ptr-deref  bug in f2fs_write_end_io in
fs/f2fs/data.c, I reproduce it in the latest kernel too.

#Quick description
When a thread always calls F2FS_IOC_RESIZE_FS to  resize fs, if resize
fs is failed, f2fs kernel thread would  invoke callback function to
update
f2fs io info, it would call  f2fs_write_end_io and may trigger
null-ptr-deref in NODE_MAPPING.
```
static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
{
return sbi->node_inode->i_mapping;
}
```
there is deref in sbi.

#crash log
----------------------------------------
general protection fault, probably for non-canonical address
0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 17 Comm: ksoftirqd/0 Not tainted 6.4.0-rc1 #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 b3 07 00 00 48 8b
44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89 f8 48 c1 e8 03 <80> 3c
18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 84 10 04 00 00 e8 10
RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
RAX: 0000000000000006 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: ffff888013d18000 RSI: ffffffff83a93a4d RDI: 0000000000000030
RBP: ffffea00009e6900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea00009e6900
R13: 0000000000000000 R14: ffff88802a3cec48 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555faf194000 CR3: 00000000251bd000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x5cc/0x1690 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x8ef kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:939 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 b3 07 00 00 48 8b
44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89 f8 48 c1 e8 03 <80> 3c
18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 84 10 04 00 00 e8 10
RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
RAX: 0000000000000006 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: ffff888013d18000 RSI: ffffffff83a93a4d RDI: 0000000000000030
RBP: ffffea00009e6900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea00009e6900
R13: 0000000000000000 R14: ffff88802a3cec48 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555faf194000 CR3: 00000000251bd000 CR4: 0000000000750ef0
PKRU: 55555554
-----------------------

# new crash log in latest kernel
---------------------
[  193.695164][ T8174] loop0: detected capacity change from 0 to 264192
[  193.696467][ T8174] F2FS-fs (loop0): Magic Mismatch,
valid(0xf2f52010) - read(0x0)
[  193.696875][ T8174] F2FS-fs (loop0): Can't find valid F2FS
filesystem in 2th superblock
[  193.698363][ T8174] F2FS-fs (loop0): invalid crc_offset: 0
[  193.700454][ T8174] F2FS-fs (loop0): Disable nat_bits due to
incorrect cp_ver (4542359912962316977, 0)
[  193.716594][ T8174] F2FS-fs (loop0): Try to recover 2th superblock, ret: 0
[  193.717102][ T8174] F2FS-fs (loop0): Mounted with checkpoint
version = 3e17dab1
[  193.743330][ T8174] F2FS-fs (loop0): For resize: curseg of type 0: 46 ==> 4
[  193.743904][ T8174] F2FS-fs (loop0): For resize: curseg of type 3: 52 ==> 6
[  193.745690][ T8174] F2FS-fs (loop0): For resize: curseg of type 4: 50 ==> 8
[  193.746108][ T8174] F2FS-fs (loop0): For resize: curseg of type 5: 48 ==> 10
[  193.751857][ T8174] F2FS-fs (loop0): resize_fs failed, should run
fsck to repair!
[  193.780283][    C0] general protection fault, probably for
non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
[  193.781027][    C0] KASAN: null-ptr-deref in range
[0x0000000000000030-0x0000000000000037]
[  193.781572][    C0] CPU: 0 PID: 17 Comm: ksoftirqd/0 Not tainted
6.4.0-rc2-00163-g2d1bcbc6cd70-dirty #17
[  193.782201][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[  193.782727][    C0] RIP: 0010:f2fs_write_end_io+0x727/0x1050
[  193.783083][    C0] Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f
85 b3 07 00 00 48 8b 44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89
f8 48 c1 e8 03 <80> 3c 18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 0
[  193.784268][    C0] RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
[  193.784629][    C0] RAX: 0000000000000006 RBX: dffffc0000000000
RCX: 0000000000000100
[  193.785109][    C0] RDX: ffff888013d18000 RSI: ffffffff83a9588d
RDI: 0000000000000030
[  193.785576][    C0] RBP: ffffea000143e740 R08: 0000000000000001
R09: 0000000000000000
[  193.786051][    C0] R10: 0000000000000000 R11: 0000000000000000
R12: ffffea000143e740
[  193.786571][    C0] R13: 0000000000000000 R14: ffff888041423738
R15: 0000000000000000
[  193.787055][    C0] FS:  0000000000000000(0000)
GS:ffff88802ca00000(0000) knlGS:0000000000000000
[  193.787620][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  193.787997][    C0] CR2: 000056056fd87000 CR3: 000000001b546000
CR4: 00000000000006f0
[  193.788585][    C0] Call Trace:
[  193.788863][    C0]  <TASK>
[  193.789115][    C0]  ? bio_uninit+0x1b7/0x410
[  193.789509][    C0]  ? f2fs_write_end+0xa80/0xa80
[  193.790053][    C0]  bio_endio+0x5af/0x6c0
[  193.790522][    C0]  blk_update_request+0x5cc/0x1690
[  193.791171][    C0]  blk_mq_end_request+0x59/0x4c0
[  193.791695][    C0]  lo_complete_rq+0x1c6/0x280
[  193.792247][    C0]  blk_complete_reqs+0xad/0xe0
[  193.792759][    C0]  __do_softirq+0x1d4/0x8ef
[  193.793312][    C0]  ? __irq_exit_rcu+0x190/0x190
[  193.793805][    C0]  run_ksoftirqd+0x31/0x60
[  193.794183][    C0]  smpboot_thread_fn+0x659/0x9e0
[  193.794576][    C0]  ? sort_range+0x30/0x30
[  193.794900][    C0]  kthread+0x33e/0x440
[  193.795263][    C0]  ? kthread_complete_and_exit+0x40/0x40
[  193.795907][    C0]  ret_from_fork+0x1f/0x30
[  193.796324][    C0]  </TASK>
[  193.796689][    C0] Modules linked in:
[  193.797189][    C0] ---[ end trace 0000000000000000 ]---
[  193.797635][    C0] RIP: 0010:f2fs_write_end_io+0x727/0x1050
[  193.798182][    C0] Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f
85 b3 07 00 00 48 8b 44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89
f8 48 c1 e8 03 <80> 3c 18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 0
[  193.799559][    C0] RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
[  193.799945][    C0] RAX: 0000000000000006 RBX: dffffc0000000000
RCX: 0000000000000100
[  193.800329][    C0] RDX: ffff888013d18000 RSI: ffffffff83a9588d
RDI: 0000000000000030
[  193.800666][    C0] RBP: ffffea000143e740 R08: 0000000000000001
R09: 0000000000000000
[  193.801047][    C0] R10: 0000000000000000 R11: 0000000000000000
R12: ffffea000143e740
[  193.801503][    C0] R13: 0000000000000000 R14: ffff888041423738
R15: 0000000000000000
[  193.802069][    C0] FS:  0000000000000000(0000)
GS:ffff88802ca00000(0000) knlGS:0000000000000000
[  193.802804][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  193.803356][    C0] CR2: 000056056fd87000 CR3: 000000001b546000
CR4: 00000000000006f0
[  193.804046][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  193.804748][    C0] Kernel Offset: disabled
[  193.805086][    C0] Rebooting in 86400 seconds..
----------------------------

If needed, I would provide reproduce.

Regards,
 butt3rflyh4ck.



-- 
Active Defense Lab of Venustech
