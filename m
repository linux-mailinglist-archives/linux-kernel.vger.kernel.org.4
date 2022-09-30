Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16925F0315
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiI3C5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiI3C5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:57:10 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD627104628;
        Thu, 29 Sep 2022 19:57:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mdvwl5L4xzlBC4;
        Fri, 30 Sep 2022 10:55:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAnenP_WjZjTFJvBg--.12213S9;
        Fri, 30 Sep 2022 10:57:07 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, hch@infradead.org, ebiggers@kernel.org,
        paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v4 5/6] elevator: add new field flags in struct elevator_queue
Date:   Fri, 30 Sep 2022 11:19:05 +0800
Message-Id: <20220930031906.4164306-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenP_WjZjTFJvBg--.12213S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17WF1ruF4fuFW8tr47Arb_yoW8XrWUp3
        Z3Gws8K3yqqF4Uur4DJ3W3Wa4ay34v9rnxur4kA34UKF17GrW3WF18CF1UJF48trs7JFsF
        vF18tayjvFyUCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

There are only one flag to indicate that elevator is registered currently,
prepare to add a flag to disable wbt if default elevator is bfq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/elevator.c | 6 ++----
 block/elevator.h | 4 +++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 20e70fd3f77f..9e12706e8d8c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -512,7 +512,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
-		e->registered = 1;
+		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
 	}
 	return error;
 }
@@ -523,11 +523,9 @@ void elv_unregister_queue(struct request_queue *q)
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (e && e->registered) {
+	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
-
-		e->registered = 0;
 	}
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index 3f0593b3bf9d..ed574bf3e629 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -100,10 +100,12 @@ struct elevator_queue
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
-	unsigned int registered:1;
+	unsigned long flags;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
+#define ELEVATOR_FLAG_REGISTERED 0
+
 /*
  * block elevator interface
  */
-- 
2.31.1

