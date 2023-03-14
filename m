Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1166B8E29
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCNJHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCNJHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:07:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456452915E;
        Tue, 14 Mar 2023 02:07:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PbSN525JLz4f3mVc;
        Tue, 14 Mar 2023 17:07:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R9VORBk1nWZEw--.18813S4;
        Tue, 14 Mar 2023 17:07:35 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     djwong@kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: [PATCH] xfs: fix possible assert failed in xfs_fs_put_super() when do cpu offline
Date:   Tue, 14 Mar 2023 17:06:49 +0800
Message-Id: <20230314090649.326642-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R9VORBk1nWZEw--.18813S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4kAr4fGr45Ww4rZr4UXFb_yoW5GrWDpr
        ZxCr4UGr4kAr9rAw43Ar4DtFy8Xa1DAFW5Cw1xJFy2yFn8Gw1Yv34IkFW7JFy7Wr4fXr12
        qry5X3yIg3s5taUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

There's a issue when do cpu offline test:
CPU: 48 PID: 1168152 Comm: umount Kdump: loaded Tainted: G L
pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
pc : assfail+0x8c/0xb4
lr : assfail+0x38/0xb4
sp : ffffa00033ce7c40
x29: ffffa00033ce7c40 x28: ffffa00014794f30
x27: ffffa00014f6ca20 x26: 1fffe0120b2e2030
x25: ffff009059710188 x24: ffff00886c0a4650
x23: 1fffe0110d8148ca x22: ffff009059710180
x21: ffffa00015155680 x20: ffff00886c0a4000
x19: 0000000000000001 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000007 x14: 1fffe00304cef265
x13: ffff00182642b200 x12: ffff8012d37757bf
x11: 1fffe012d37757be x10: ffff8012d37757be
x9 : ffffa00010603a0c x8 : 0000000041b58ab3
x7 : ffff94000679cf44 x6 : 00000000ffffffc0
x5 : 0000000000000021 x4 : 00000000ffffffca
x3 : 1ffff40002a27ee1 x2 : 0000000000000004
x1 : 0000000000000000 x0 : ffffa0001513f000
Call trace:
 assfail+0x8c/0xb4
 xfs_destroy_percpu_counters+0x98/0xa4
 xfs_fs_put_super+0x1a0/0x2a4
 generic_shutdown_super+0x104/0x2c0
 kill_block_super+0x8c/0xf4
 deactivate_locked_super+0xa4/0x164
 deactivate_super+0xb0/0xdc
 cleanup_mnt+0x29c/0x3ec
 __cleanup_mnt+0x1c/0x30
 task_work_run+0xe0/0x200
 do_notify_resume+0x244/0x320
 work_pending+0xc/0xa0

We analyzed the data in vmcore is correct. But triggered above issue.
As f689054aace2 ("percpu_counter: add percpu_counter_sum_all interface")
commit describes there is a small race window between the online CPUs traversal
of percpu_counter_sum and the CPU offline callback. This means percpu_counter_sum()
may return incorrect result during cpu offline.
To solve above issue use percpu_counter_sum_all() interface to make sure
result is correct to prevent false triggering of assertions.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/xfs/xfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2479b5cbd75e..c0ce66f966ee 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1076,7 +1076,7 @@ xfs_destroy_percpu_counters(
 	percpu_counter_destroy(&mp->m_ifree);
 	percpu_counter_destroy(&mp->m_fdblocks);
 	ASSERT(xfs_is_shutdown(mp) ||
-	       percpu_counter_sum(&mp->m_delalloc_blks) == 0);
+	       percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
 	percpu_counter_destroy(&mp->m_delalloc_blks);
 	percpu_counter_destroy(&mp->m_frextents);
 }
-- 
2.31.1

