Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC81736219
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFTDPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFTDOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:14:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13DE42;
        Mon, 19 Jun 2023 20:14:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlWvr49lVz4f4WX0;
        Tue, 20 Jun 2023 11:14:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLOmGZFkMPZpMA--.49085S4;
        Tue, 20 Jun 2023 11:14:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, jack@suse.cz, jinpu.wang@ionos.com,
        dchinner@redhat.com, hare@suse.de, trix@redhat.com,
        bvanassche@acm.org, yukuai3@huawei.com, willy@infradead.org,
        yi.zhang@huawei.com, dsterba@suse.com, brauner@kernel.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yangerkun@huawei.com
Subject: [PATCH -next] reiserfs: fix blkdev_put() warning from release_journal_dev()
Date:   Tue, 20 Jun 2023 19:13:22 +0800
Message-Id: <20230620111322.1014775-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLOmGZFkMPZpMA--.49085S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4rWr13urWkWFyfCr4Durg_yoW5XrWDpa
        1rCF40kryjvF1DJa1xZws7WrWrXa9YkayUGrsIkrZaya1Syw17Gw4xKr17G3yv9FZ5Kw15
        Xw4UA39akr1ktr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
        Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7sRi38nUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

In journal_init_dev(), if super bdev is used as 'j_dev_bd', then
blkdev_get_by_dev() is called with NULL holder, otherwise, holder will
be journal. However, later in release_journal_dev(), blkdev_put() is
called with journal unconditionally, cause following warning:

WARNING: CPU: 1 PID: 5034 at block/bdev.c:617 bd_end_claim block/bdev.c:617 [inline]
WARNING: CPU: 1 PID: 5034 at block/bdev.c:617 blkdev_put+0x562/0x8a0 block/bdev.c:901
RIP: 0010:blkdev_put+0x562/0x8a0 block/bdev.c:901
Call Trace:
 <TASK>
 release_journal_dev fs/reiserfs/journal.c:2592 [inline]
 free_journal_ram+0x421/0x5c0 fs/reiserfs/journal.c:1896
 do_journal_release fs/reiserfs/journal.c:1960 [inline]
 journal_release+0x276/0x630 fs/reiserfs/journal.c:1971
 reiserfs_put_super+0xe4/0x5c0 fs/reiserfs/super.c:616
 generic_shutdown_super+0x158/0x480 fs/super.c:499
 kill_block_super+0x64/0xb0 fs/super.c:1422
 deactivate_locked_super+0x98/0x160 fs/super.c:330
 deactivate_super+0xb1/0xd0 fs/super.c:361
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1247
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xadc/0x2a30 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix this problem by passing in NULL holder in this case.

Reported-by: syzbot+04625c80899f4555de39@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=04625c80899f4555de39
Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/reiserfs/journal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 62beee3c62b6..479aa4a57602 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2589,7 +2589,12 @@ static void release_journal_dev(struct super_block *super,
 			       struct reiserfs_journal *journal)
 {
 	if (journal->j_dev_bd != NULL) {
-		blkdev_put(journal->j_dev_bd, journal);
+		void *holder = NULL;
+
+		if (journal->j_dev_bd->bd_dev != super->s_dev)
+			holder = journal;
+
+		blkdev_put(journal->j_dev_bd, holder);
 		journal->j_dev_bd = NULL;
 	}
 }
-- 
2.39.2

