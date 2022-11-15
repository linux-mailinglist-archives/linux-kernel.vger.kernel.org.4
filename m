Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26587629B20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiKONuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiKONth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:49:37 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864526AD1;
        Tue, 15 Nov 2022 05:49:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBSGL1hhXz4f3kJw;
        Tue, 15 Nov 2022 21:49:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9jnmHNjrPFIAg--.61645S14;
        Tue, 15 Nov 2022 21:49:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v3 10/10] block: don't allow a disk link holder to itself
Date:   Tue, 15 Nov 2022 22:10:54 +0800
Message-Id: <20221115141054.1051801-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9jnmHNjrPFIAg--.61645S14
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kCFy5Xw1kuF1fWrWDXFb_yoWrurWkpr
        1jqr4UGr48Jr1UXF4UAr1UJr1UJrW8AF48Jr17Xr1DJF15W3WUZr1UJrWUAr15Jr4Yqr17
        tw4DXw18tryUKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

After creating a dm device, then user can reload such dm with itself,
and dead loop will be triggered because dm keep looking up to itself.

Test procedures:

1) dmsetup create test --table "xxx sda", assume dm-0 is created
2) dmsetup suspend test
3) dmsetup reload test --table "xxx dm-0"
4) dmsetup resume test

Test result:

BUG: TASK stack guard page was hit at 00000000736a261f (stack is 000000008d12c88d..00000000c8dd82d5)
stack guard page: 0000 [#1] PREEMPT SMP
CPU: 29 PID: 946 Comm: systemd-udevd Not tainted 6.1.0-rc3-next-20221101-00006-g17640ca3b0ee #1295
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
RIP: 0010:dm_prepare_ioctl+0xf/0x1e0
Code: da 48 83 05 4a 7c 99 0b 01 41 89 c4 eb cd e8 b8 1f 40 00 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 48 83 05 a1 5a 99 0b 01 <41> 56 49 89 d6 41 55 4c 8d af 90 02 00 00 9
RSP: 0018:ffffc90002090000 EFLAGS: 00010206
RAX: ffff8881049d6800 RBX: ffff88817e589000 RCX: 0000000000000000
RDX: ffffc90002090010 RSI: ffffc9000209001c RDI: ffff88817e589000
RBP: 00000000484a101d R08: 0000000000000000 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000005331
R13: 0000000000005331 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fddf9609200(0000) GS:ffff889fbfd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000208fff8 CR3: 0000000179043000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dm_blk_ioctl+0x50/0x1c0
 ? dm_prepare_ioctl+0xe0/0x1e0
 dm_blk_ioctl+0x88/0x1c0
 dm_blk_ioctl+0x88/0x1c0
 ......(a lot of same lines)
 dm_blk_ioctl+0x88/0x1c0
 dm_blk_ioctl+0x88/0x1c0
 blkdev_ioctl+0x184/0x3e0
 __x64_sys_ioctl+0xa3/0x110
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fddf7306577
Code: b3 66 90 48 8b 05 11 89 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 88 8
RSP: 002b:00007ffd0b2ec318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00005634ef478320 RCX: 00007fddf7306577
RDX: 0000000000000000 RSI: 0000000000005331 RDI: 0000000000000007
RBP: 0000000000000007 R08: 00005634ef4843e0 R09: 0000000000000080
R10: 00007fddf75cfb38 R11: 0000000000000246 R12: 00000000030d4000
R13: 0000000000000000 R14: 0000000000000000 R15: 00005634ef48b800
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dm_prepare_ioctl+0xf/0x1e0
Code: da 48 83 05 4a 7c 99 0b 01 41 89 c4 eb cd e8 b8 1f 40 00 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 48 83 05 a1 5a 99 0b 01 <41> 56 49 89 d6 41 55 4c 8d af 90 02 00 00 9
RSP: 0018:ffffc90002090000 EFLAGS: 00010206
RAX: ffff8881049d6800 RBX: ffff88817e589000 RCX: 0000000000000000
RDX: ffffc90002090010 RSI: ffffc9000209001c RDI: ffff88817e589000
RBP: 00000000484a101d R08: 0000000000000000 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000005331
R13: 0000000000005331 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fddf9609200(0000) GS:ffff889fbfd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000208fff8 CR3: 0000000179043000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fix the problem by forbidding a disk to create link to itself.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/holder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/holder.c b/block/holder.c
index 3332142bb867..37d18c13d958 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -65,6 +65,9 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk->slave_dir))
 		return -EINVAL;
 
+	if (bdev->bd_disk == disk)
+		return -EINVAL;
+
 	/*
 	 * del_gendisk drops the initial reference to bd_holder_dir, so we
 	 * need to keep our own here to allow for cleanup past that point.
-- 
2.31.1

