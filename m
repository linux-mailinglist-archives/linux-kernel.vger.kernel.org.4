Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305145BAC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiIPLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiIPLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:23:38 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7706B662;
        Fri, 16 Sep 2022 04:23:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MTWqm4tFKzlCjt;
        Fri, 16 Sep 2022 19:21:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOzXCRjdyK5Aw--.60594S7;
        Fri, 16 Sep 2022 19:23:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v3 3/5] md/raid10: prevent unnecessary calls to wake_up() in fast path
Date:   Fri, 16 Sep 2022 19:34:26 +0800
Message-Id: <20220916113428.774061-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916113428.774061-1-yukuai1@huaweicloud.com>
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOzXCRjdyK5Aw--.60594S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyDKw1xCFyxWryfWrykXwb_yoW8Wr1fpw
        sFgFyFvry5AF98tw4UJFWUuas8K34ktayIkFZ2k3s7ZFn8tF9akF1UJa4qkryjgrZ3uryU
        ZFn0krW3Aw4UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, wake_up() is called unconditionally in fast path such as
raid10_make_request(), which will cause lock contention under high
concurrency:

raid10_make_request
 wake_up
  __wake_up_common_lock
   spin_lock_irqsave

Improve performance by only call wake_up() if waitqueue is not empty
in allow_barrier() and raid10_make_request().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index df435d693637..cf452c25e1e5 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -274,6 +274,12 @@ static void put_buf(struct r10bio *r10_bio)
 	lower_barrier(conf);
 }
 
+static void wake_up_barrier(struct r10conf *conf)
+{
+	if (wq_has_sleeper(&conf->wait_barrier))
+		wake_up(&conf->wait_barrier);
+}
+
 static void reschedule_retry(struct r10bio *r10_bio)
 {
 	unsigned long flags;
@@ -1015,7 +1021,7 @@ static void allow_barrier(struct r10conf *conf)
 {
 	if ((atomic_dec_and_test(&conf->nr_pending)) ||
 			(conf->array_freeze_pending))
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 }
 
 static void freeze_array(struct r10conf *conf, int extra)
@@ -1891,7 +1897,7 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
 	__make_request(mddev, bio, sectors);
 
 	/* In case raid10d snuck in to freeze_array */
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 	return true;
 }
 
-- 
2.31.1

