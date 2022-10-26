Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958360DC28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiJZHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJZHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:34:47 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B718DFF3;
        Wed, 26 Oct 2022 00:34:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4My0rF53QRz6T6mt;
        Wed, 26 Oct 2022 15:32:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCntOYO41hjqLzeAA--.4330S4;
        Wed, 26 Oct 2022 15:34:40 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: [PATCH] blktrace:use '__blk_trace_remove' helper in 'blk_trace_remove_queue'
Date:   Wed, 26 Oct 2022 15:56:31 +0800
Message-Id: <20221026075631.682100-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCntOYO41hjqLzeAA--.4330S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1ktFykWry3XF45Xr4ruFg_yoWDJFc_ZF
        yUW3Wxtr43Cr90qr4fAFsIq3Wqq34jvFyFya45tFW5A3ZrXrn8G3ZxZwsIgrZ09r4kWa4U
        Jry3t34UGF1YyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbr8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

After '60a9bb9048f9' and 'dcd1a59c62dc' commit 'blk_trace_remove_queue' is do
the same job with '__blk_trace_remove', so just call '__blk_trace_remove'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/blktrace.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a995ea1ef849..115ae18e479d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1609,19 +1609,7 @@ device_initcall(init_blk_tracer);
 
 static int blk_trace_remove_queue(struct request_queue *q)
 {
-	struct blk_trace *bt;
-
-	bt = rcu_replace_pointer(q->blk_trace, NULL,
-				 lockdep_is_held(&q->debugfs_mutex));
-	if (bt == NULL)
-		return -EINVAL;
-
-	blk_trace_stop(bt);
-
-	put_probe_ref();
-	synchronize_rcu();
-	blk_trace_free(q, bt);
-	return 0;
+	return __blk_trace_remove(q);
 }
 
 /*
-- 
2.31.1

