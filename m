Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88ED74BD09
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGHJTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 05:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGHJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 05:19:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74291BD2;
        Sat,  8 Jul 2023 02:19:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qyl7f58Kmz4f3nbk;
        Sat,  8 Jul 2023 17:18:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA30JP9KalkALTwNQ--.64171S4;
        Sat, 08 Jul 2023 17:18:55 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, logang@deltatee.com, axboe@kernel.dk
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3] md/raid5-cache: fix a deadlock in r5l_exit_log()
Date:   Sat,  8 Jul 2023 17:17:27 +0800
Message-Id: <20230708091727.1417894-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JP9KalkALTwNQ--.64171S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw45Ar4DAw4UJF1kJFy5Arb_yoW8AF1Upa
        ySqrWaq3y8uFyjvF4DC3WUCFyrCw48KryfGr15Cw4Yva4fWry8Gay8Ka409FWvyr4rtrWI
        vFWFg34rGr10yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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

Commit b13015af94cf ("md/raid5-cache: Clear conf->log after finishing
work") introduce a new problem:

// caller hold reconfig_mutex
r5l_exit_log
 flush_work(&log->disable_writeback_work)
			r5c_disable_writeback_async
			 wait_event
			  /*
			   * conf->log is not NULL, and mddev_trylock()
			   * will fail, wait_event() can never pass.
			   */
 conf->log = NULL

Fix this problem by setting 'config->log' to NULL before wake_up() as it
used to be, so that wait_event() from r5c_disable_writeback_async() can
exist. In the meantime, move forward md_unregister_thread() so that
null-ptr-deref this commit fixed can still be fixed.

Fixes: b13015af94cf ("md/raid5-cache: Clear conf->log after finishing work")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---

Changes in v3:
 - Use a different solution.

 drivers/md/raid5-cache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 47ba7d9e81e1..2eac4a50d99b 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3168,12 +3168,15 @@ void r5l_exit_log(struct r5conf *conf)
 {
 	struct r5l_log *log = conf->log;
 
-	/* Ensure disable_writeback_work wakes up and exits */
-	wake_up(&conf->mddev->sb_wait);
-	flush_work(&log->disable_writeback_work);
 	md_unregister_thread(&log->reclaim_thread);
 
+	/*
+	 * 'reconfig_mutex' is held by caller, set 'confg->log' to NULL to
+	 * ensure disable_writeback_work wakes up and exits.
+	 */
 	conf->log = NULL;
+	wake_up(&conf->mddev->sb_wait);
+	flush_work(&log->disable_writeback_work);
 
 	mempool_exit(&log->meta_pool);
 	bioset_exit(&log->bs);
-- 
2.39.2

