Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD587615884
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKBCxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKBCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:52:59 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 51341220FF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:52:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [61.164.42.140])
        by mail-app2 (Coremail) with SMTP id by_KCgB3ffVv22FjEPFcBw--.14956S4;
        Wed, 02 Nov 2022 10:52:44 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 2/2] blk-mq: use if-else instead of goto in blk_mq_alloc_cached_request()
Date:   Wed,  2 Nov 2022 10:52:30 +0800
Message-Id: <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667356813.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667356813.git.nickyc975@zju.edu.cn>
References: <cover.1667356813.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgB3ffVv22FjEPFcBw--.14956S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4kZF15XFWfWFyUKF45Wrg_yoW8Jw15pF
        sxJa4qvFWFgF1xuF4Fya1fJF4rAF1rGF9rC34fAwn8Z34rGr4UJr1fArWFqFWSyFZ7CFWx
        Krs8Gas5uF18XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
        z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU_WrJUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAAHs+
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if-else is more readable than goto here.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
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

