Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C971E61593E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKBDG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKBDGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:06:24 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC54123E93;
        Tue,  1 Nov 2022 20:06:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app2 (Coremail) with SMTP id by_KCgA3PSGf3mFjz_9cBw--.7456S4;
        Wed, 02 Nov 2022 11:06:17 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v3 2/2] blk-mq: use if-else instead of goto in blk_mq_alloc_cached_request()
Date:   Wed,  2 Nov 2022 11:06:05 +0800
Message-Id: <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667358114.git.nickyc975@zju.edu.cn>
References: <cover.1667358114.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgA3PSGf3mFjz_9cBw--.7456S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4Dtw4DWry3ZFW7Cw4xtFb_yoW8Gry5pF
        sxJa4qvFWFgF1xuF4rAa1fJF4rCF1rGF9rC34fAwn5Z3y5Gr4Utr1fArWFqFWSyFZ3CFWx
        Kr4DCas5uF18XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUOlksUUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgQCB1ZdtcNYxwAAsh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if-else is more readable than goto here.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 453ad445a6bd..6ffca7af5b6f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -544,25 +544,26 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 
 	if (!plug)
 		return NULL;
+
 	if (rq_list_empty(plug->cached_rq)) {
 		if (plug->nr_ios == 1)
 			return NULL;
 		rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
-		if (rq)
-			goto got_it;
-		return NULL;
-	}
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
+		if (!rq)
+			return NULL;
+	} else {
+		rq = rq_list_peek(&plug->cached_rq);
+		if (!rq || rq->q != q)
+			return NULL;
 
-	if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
-		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
-		return NULL;
+		if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
+			return NULL;
+		if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
+			return NULL;
+
+		plug->cached_rq = rq_list_next(rq);
+	}
 
-	plug->cached_rq = rq_list_next(rq);
-got_it:
 	rq->cmd_flags = opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
-- 
2.31.1

