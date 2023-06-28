Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD3740775
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjF1BI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjF1BIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:08:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638E1BD4;
        Tue, 27 Jun 2023 18:08:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrNkn4Xqfz4f3nTp;
        Wed, 28 Jun 2023 09:08:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKsfiJtk9u_GMg--.34640S6;
        Wed, 28 Jun 2023 09:08:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, logang@deltatee.com, hch@lst.de, song@kernel.org,
        shli@fb.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawwe.com
Subject: [PATCH -next v2 2/2] md/raid5-cache: fix null-ptr-deref in r5l_reclaim_thread()
Date:   Wed, 28 Jun 2023 09:07:56 +0800
Message-Id: <20230628010756.70649-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628010756.70649-1-yukuai1@huaweicloud.com>
References: <20230628010756.70649-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKsfiJtk9u_GMg--.34640S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fuw1rtw1UXr4Uuw1ftFb_yoW5tw48pa
        1Sg3y3Ww48urWfAFnrWr1Dur4F93sF934xG3y5Cwn2yr13Xry8Ja47CayUZFy5JFW8Ary3
        XrZ8tF48WrnrtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

r5l_reclaim_thread() already check that 'conf->log' is not NULL in the
beginning, however, r5c_do_reclaim() and r5l_do_reclaim() will
dereference 'conf->log' again, which will cause null-ptr-deref if
'conf->log' is set to NULL from r5l_exit_log() concurrently.

Fix this problem by don't dereference 'conf->log' again in
r5c_do_reclaim() and r5c_do_reclaim().

Fixes: a39f7afde358 ("md/r5cache: write-out phase and reclaim support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5-cache.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 083288e36949..ba6fc146d265 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1148,10 +1148,9 @@ static void r5l_run_no_space_stripes(struct r5l_log *log)
  * for write through mode, returns log->next_checkpoint
  * for write back, returns log_start of first sh in stripe_in_journal_list
  */
-static sector_t r5c_calculate_new_cp(struct r5conf *conf)
+static sector_t r5c_calculate_new_cp(struct r5l_log *log)
 {
 	struct stripe_head *sh;
-	struct r5l_log *log = conf->log;
 	sector_t new_cp;
 	unsigned long flags;
 
@@ -1159,12 +1158,12 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
 		return log->next_checkpoint;
 
 	spin_lock_irqsave(&log->stripe_in_journal_lock, flags);
-	if (list_empty(&conf->log->stripe_in_journal_list)) {
+	if (list_empty(&log->stripe_in_journal_list)) {
 		/* all stripes flushed */
 		spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
 		return log->next_checkpoint;
 	}
-	sh = list_first_entry(&conf->log->stripe_in_journal_list,
+	sh = list_first_entry(&log->stripe_in_journal_list,
 			      struct stripe_head, r5c);
 	new_cp = sh->log_start;
 	spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
@@ -1173,10 +1172,8 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
 
 static sector_t r5l_reclaimable_space(struct r5l_log *log)
 {
-	struct r5conf *conf = log->rdev->mddev->private;
-
 	return r5l_ring_distance(log, log->last_checkpoint,
-				 r5c_calculate_new_cp(conf));
+				 r5c_calculate_new_cp(log));
 }
 
 static void r5l_run_no_mem_stripe(struct r5l_log *log)
@@ -1419,9 +1416,9 @@ void r5c_flush_cache(struct r5conf *conf, int num)
 	}
 }
 
-static void r5c_do_reclaim(struct r5conf *conf)
+static void r5c_do_reclaim(struct r5l_log *log)
 {
-	struct r5l_log *log = conf->log;
+	struct r5conf *conf = log->rdev->mddev->private;
 	struct stripe_head *sh;
 	int count = 0;
 	unsigned long flags;
@@ -1496,7 +1493,6 @@ static void r5c_do_reclaim(struct r5conf *conf)
 
 static void r5l_do_reclaim(struct r5l_log *log)
 {
-	struct r5conf *conf = log->rdev->mddev->private;
 	sector_t reclaim_target = xchg(&log->reclaim_target, 0);
 	sector_t reclaimable;
 	sector_t next_checkpoint;
@@ -1525,7 +1521,7 @@ static void r5l_do_reclaim(struct r5l_log *log)
 				    log->io_list_lock);
 	}
 
-	next_checkpoint = r5c_calculate_new_cp(conf);
+	next_checkpoint = r5c_calculate_new_cp(log);
 	spin_unlock_irq(&log->io_list_lock);
 
 	if (reclaimable == 0 || !write_super)
@@ -1554,7 +1550,7 @@ static void r5l_reclaim_thread(struct md_thread *thread)
 
 	if (!log)
 		return;
-	r5c_do_reclaim(conf);
+	r5c_do_reclaim(log);
 	r5l_do_reclaim(log);
 }
 
-- 
2.39.2

