Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B874CD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGJGrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGJGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:47:43 -0400
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBABDF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:47:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688971659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YsPE8Ph2i63iXfOKdYTTEJ0Ca9a6Ddgy8hiayl5gTk0=;
        b=cuhHBIOJFOhrK+U5yrcp1YrFeAYfgbRaVbi8wFSIIzRiiGXomhszlXZtXWc7bW8MiaoKu1
        H5YLR+XnbL0xBwrUoV4G2YBymHze1pRvf6IGkzG0lFOIFELKWgLKMD6LfGfZqu4ShmuHbt
        J1XrC5UgdJZ4fDCmyqOnFNlJYPeO3os=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush requests
Date:   Mon, 10 Jul 2023 14:47:04 +0800
Message-ID: <20230710064705.1847287-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
data sequence and post-flush sequence need to be done for this request.

The rq->flush.seq should record what sequences have been done (or don't
need to be done). So in this case, pre-flush doesn't need to be done,
we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.

Of course, this doesn't cause any problem in fact, since pre-flush and
post-flush sequence do the same thing for now.

But we'd better fix this value, and the next patch will depend on this
value to be correct.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4826d2d61a23..094a6adb2718 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -448,7 +448,7 @@ bool blk_insert_flush(struct request *rq)
 		 * the post flush, and then just pass the command on.
 		 */
 		blk_rq_init_flush(rq);
-		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
+		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
 		spin_lock_irq(&fq->mq_flush_lock);
 		fq->flush_data_in_flight++;
 		spin_unlock_irq(&fq->mq_flush_lock);
-- 
2.41.0

