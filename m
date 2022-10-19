Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA56045C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiJSMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiJSMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:49:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD06BC1E;
        Wed, 19 Oct 2022 05:31:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mspvy6r6pzKHgk;
        Wed, 19 Oct 2022 19:50:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCX0DAq5U9jgItmAA--.58124S7;
        Wed, 19 Oct 2022 19:53:17 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, ebiggers@google.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v5 3/6] blk-wbt: make enable_state more accurate
Date:   Wed, 19 Oct 2022 20:15:15 +0800
Message-Id: <20221019121518.3865235-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
References: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX0DAq5U9jgItmAA--.58124S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47CF4Utw47WFyfZw4xWFg_yoW8AFW5pa
        srGrW7KrnFgFn7Za1xA3W7JrWfCa1jyF45Gay5Zr1SgF15urW2v3WvkrWUXFnYvFW3Ca1I
        g34DJr9rJa4jvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
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

Currently, if user disable wbt through sysfs, 'enable_state' will be
'WBT_STATE_ON_MANUAL', which will be confusing. Add a new state
'WBT_STATE_OFF_MANUAL' to cover that case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-wbt.c |  7 ++++++-
 block/blk-wbt.h | 12 +++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index c5a8c10028a0..4680691a96bc 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -435,8 +435,13 @@ void wbt_set_min_lat(struct request_queue *q, u64 val)
 	struct rq_qos *rqos = wbt_rq_qos(q);
 	if (!rqos)
 		return;
+
 	RQWB(rqos)->min_lat_nsec = val;
-	RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
+	if (val)
+		RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
+	else
+		RQWB(rqos)->enable_state = WBT_STATE_OFF_MANUAL;
+
 	wbt_update_limits(RQWB(rqos));
 }
 
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7e44eccc676d..7fe98638fff5 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -28,13 +28,15 @@ enum {
 };
 
 /*
- * Enable states. Either off, or on by default (done at init time),
- * or on through manual setup in sysfs.
+ * If current state is WBT_STATE_ON/OFF_DEFAULT, it can be covered to any other
+ * state, if current state is WBT_STATE_ON/OFF_MANUAL, it can only be covered
+ * to WBT_STATE_OFF/ON_MANUAL.
  */
 enum {
-	WBT_STATE_ON_DEFAULT	= 1,
-	WBT_STATE_ON_MANUAL	= 2,
-	WBT_STATE_OFF_DEFAULT
+	WBT_STATE_ON_DEFAULT	= 1,	/* on by default */
+	WBT_STATE_ON_MANUAL	= 2,	/* on manually by sysfs */
+	WBT_STATE_OFF_DEFAULT	= 3,	/* off by default */
+	WBT_STATE_OFF_MANUAL	= 4,	/* off manually by sysfs */
 };
 
 struct rq_wb {
-- 
2.31.1

