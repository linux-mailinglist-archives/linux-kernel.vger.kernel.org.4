Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAED6F77B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEDVCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjEDVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:02:14 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2EE1734;
        Thu,  4 May 2023 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230734;
        bh=1jfyZJuK4k9g5CEpe8gCUedeSdOIfbCNOZJDVvTtWOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tc4yMe+dNevzwFlfwp6HT3GKbEIZ6zDHUt7WxxxM2l5wvdmhFhE9c2ghavf7lfuXS
         yUOE9TorFjIilwout/zxZzthJA7GU5yXGedxPlWJ74oWHfbnpweJw+vaj+pn/56sDb
         KH+wazgLGkoJ6Bg/zeJ3vxNWomkPYz6NRNSMYWI5B1Kdo8/SUQmylzqb9EmiiuxKak
         Sq8X+1DXrgbHEkZ7qYTavuig7dN1ZoNTYXWb14q1N8jptcqJRQL0IFUP4+a5u/TXdw
         uPh0Bi7AIGDnVvnBt+jv2S25RvMgLq99tCBREknHhixsLetxD70RhzKQhrelXcsDQE
         Z535jfxloZg1w==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yp4cDXz11wl;
        Thu,  4 May 2023 16:05:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro parameter use
Date:   Thu,  4 May 2023 16:05:26 -0400
Message-Id: <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following macro parameter usage patterns in blk-mq.h for
consistency, ensuring that operator precedence is respected:

Added parentheses:

- x->member is changed for (x)->member,
- x.member is changed for (x).member,
- flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT is changed for
  (flags) >> BLK_MQ_F_ALLOC_POLICY_START_BIT.
- "x = y" is changed for "x = (y)", because "y" can be an expression
  containing a comma if it is the result of the expansion of a macro such
  as #define eval(...) __VA_ARGS__, which would cause unexpected operator
  precedence. This use-case is far-fetched, but we have to choose one
  way or the other (with or without parentheses) for consistency.

Removed parentheses:

- m((x)) is changed for m(x) (the extra parentheses are useless),
- m(x, (y), (z)) is changed for m(x, y, z), because comma is the lowest
  priority operator, and thus the extra parentheses are useless,
- v[(x)] is changed for v[x], because the extra parentheses are useless
  given that [] already surrounds an expression,
- "(i) = 0" is changed for "i = 0", because "i" is an lvalue, which
  makes the extra parentheses useless.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 include/linux/blk-mq.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..4de6ad92530c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -223,13 +223,13 @@ static inline unsigned short req_get_ioprio(struct request *req)
 
 #define rq_list_add(listptr, rq)	do {		\
 	(rq)->rq_next = *(listptr);			\
-	*(listptr) = rq;				\
+	*(listptr) = (rq);				\
 } while (0)
 
 #define rq_list_add_tail(lastpptr, rq)	do {		\
 	(rq)->rq_next = NULL;				\
-	**(lastpptr) = rq;				\
-	*(lastpptr) = &rq->rq_next;			\
+	**(lastpptr) = (rq);				\
+	*(lastpptr) = &(rq)->rq_next;			\
 } while (0)
 
 #define rq_list_pop(listptr)				\
@@ -251,11 +251,11 @@ static inline unsigned short req_get_ioprio(struct request *req)
 })
 
 #define rq_list_for_each(listptr, pos)			\
-	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
+	for (pos = rq_list_peek(listptr); pos; pos = rq_list_next(pos))
 
 #define rq_list_for_each_safe(listptr, pos, nxt)			\
-	for (pos = rq_list_peek((listptr)), nxt = rq_list_next(pos);	\
-		pos; pos = nxt, nxt = pos ? rq_list_next(pos) : NULL)
+	for (pos = rq_list_peek(listptr), nxt = rq_list_next(pos);	\
+		pos; pos = (nxt), nxt = (pos) ? rq_list_next(pos) : NULL)
 
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
@@ -692,10 +692,10 @@ enum {
 	BLK_MQ_CPU_WORK_BATCH	= 8,
 };
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
-	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
+	(((flags) >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
 		((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1))
 #define BLK_ALLOC_POLICY_TO_MQ_FLAG(policy) \
-	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
+	(((policy) & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
 		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
 
 #define BLK_MQ_NO_HCTX_IDX	(-1U)
@@ -948,11 +948,11 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 }
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
-	xa_for_each(&(q)->hctx_table, (i), (hctx))
+	xa_for_each(&(q)->hctx_table, i, hctx)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
-	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
-	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
+	for (i = 0; (i) < (hctx)->nr_ctx &&				\
+	     ({ ctx = (hctx)->ctxs[i]; 1; }); (i)++)
 
 static inline void blk_mq_cleanup_rq(struct request *rq)
 {
@@ -1013,20 +1013,20 @@ struct req_iterator {
 };
 
 #define __rq_for_each_bio(_bio, rq)	\
-	if ((rq->bio))			\
-		for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
+	if ((rq)->bio)			\
+		for (_bio = (rq)->bio; _bio; _bio = (_bio)->bi_next)
 
 #define rq_for_each_segment(bvl, _rq, _iter)			\
-	__rq_for_each_bio(_iter.bio, _rq)			\
-		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
+	__rq_for_each_bio((_iter).bio, _rq)			\
+		bio_for_each_segment(bvl, (_iter).bio, (_iter).iter)
 
 #define rq_for_each_bvec(bvl, _rq, _iter)			\
-	__rq_for_each_bio(_iter.bio, _rq)			\
-		bio_for_each_bvec(bvl, _iter.bio, _iter.iter)
+	__rq_for_each_bio((_iter).bio, _rq)			\
+		bio_for_each_bvec(bvl, (_iter).bio, (_iter).iter)
 
 #define rq_iter_last(bvec, _iter)				\
-		(_iter.bio->bi_next == NULL &&			\
-		 bio_iter_last(bvec, _iter.iter))
+		((_iter).bio->bi_next == NULL &&		\
+		 bio_iter_last(bvec, (_iter).iter))
 
 /*
  * blk_rq_pos()			: the current sector
-- 
2.25.1

