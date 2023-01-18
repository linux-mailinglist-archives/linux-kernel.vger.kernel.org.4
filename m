Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382B4671038
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjARBkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjARBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:39:06 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19451C58;
        Tue, 17 Jan 2023 17:39:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NxT1w1hQqz4f3vdb;
        Wed, 18 Jan 2023 09:39:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOqxTcdjBACUBw--.30342S14;
        Wed, 18 Jan 2023 09:39:02 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v4 13/14] blk-mq: use switch/case to improve readability in blk_mq_try_issue_list_directly
Date:   Wed, 18 Jan 2023 17:37:25 +0800
Message-Id: <20230118093726.3939160-13-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOqxTcdjBACUBw--.30342S14
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry5WF4kGw43ur15uw13CFg_yoWkZFb_ur
        929rZ7JFs8KF15XrZYka12yFnrK34kJF1xuFW7tF95WF1IgFs8Gw15JF1YqrZrGay7Ca4r
        Wry5ZrnYkr1xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jcjjkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use switch/case handle error as other function do to improve
readability in blk_mq_try_issue_list_directly.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index afd4f0c3166b..bc6d7e411b1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2802,18 +2802,22 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq, list_empty(list));
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				blk_mq_request_bypass_insert(rq, false,
-							list_empty(list));
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		} else
+		switch (ret) {
+		case BLK_STS_OK:
 			queued++;
+			break;
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
+			blk_mq_request_bypass_insert(rq, false,
+						     list_empty(list));
+			goto out;
+		default:
+			blk_mq_end_request(rq, ret);
+			break;
+		}
 	}
 
+out:
 	if (ret != BLK_STS_OK)
 		blk_mq_commit_rqs(hctx, queued, false);
 }
-- 
2.30.0

