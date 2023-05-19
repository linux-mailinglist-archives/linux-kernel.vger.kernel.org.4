Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E761709023
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjESHIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:08:07 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B499C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 00:08:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VizfTZj_1684480078;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VizfTZj_1684480078)
          by smtp.aliyun-inc.com;
          Fri, 19 May 2023 15:08:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix a race of deduplicated compressed images to avoid loops
Date:   Fri, 19 May 2023 15:07:58 +0800
Message-Id: <20230519070758.36779-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After heavily stressing EROFS with several images which include a
hand-crafted image of repeated patttens for more than 46 days, I found
two chains could be linked with each other almost simultaneously and
form a loop, so the entire loop won't be submitted to the device.  As a
consequence, the corresponding file pages will remain locked forever.

It can be _only_ observed on data-deduplicated compressed images.  For
example, consider two chains with five pclusters in total:
	Chain 1:  2->3->4->5    -- The tail pcluster is .;
        Chain 2:  5->1->2       -- The tail pcluster is 2.

Chain 2 could link to Chain 1 with pcluster 5; and Chain 1 could link
to Chain 2 at the same time with pcluster 2  (Note that Chain 2 is
invalid on traditional compressed images without data deduplciation.)

Fix this by checking if the tail of a chain is extended after the chain
itself is attached into another chain.  If so, bail out instead.

Fixes: 267f2492c8f7 ("erofs: introduce multi-reference pclusters (fully-referenced)")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
I plan to stress this patch for a week before upstreaming.

 fs/erofs/zdata.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..88295c73ff90 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -756,13 +756,17 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 	 * type 2, link to the end of an existing open chain, be careful
 	 * that its submission is controlled by the original attached chain.
 	 */
-	if (*owned_head != &pcl->next && pcl != f->tailpcl &&
-	    cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
-		*owned_head = Z_EROFS_PCLUSTER_TAIL;
-		f->mode = Z_EROFS_PCLUSTER_HOOKED;
-		f->tailpcl = NULL;
-		return;
+	if (pcl != f->tailpcl && cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+					*owned_head) == Z_EROFS_PCLUSTER_TAIL) {
+		/* switch to type 3 if our owned chain is attached by others */
+		if (f->tailpcl && f->tailpcl->next != Z_EROFS_PCLUSTER_TAIL) {
+			WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL);
+		} else {
+			*owned_head = Z_EROFS_PCLUSTER_TAIL;
+			f->mode = Z_EROFS_PCLUSTER_HOOKED;
+			f->tailpcl = NULL;
+			return;
+		}
 	}
 	/* type 3, it belongs to a chain, but it isn't the end of the chain */
 	f->mode = Z_EROFS_PCLUSTER_INFLIGHT;
@@ -825,9 +829,6 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			goto err_out;
 		}
 	}
-	/* used to check tail merging loop due to corrupted images */
-	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		fe->tailpcl = pcl;
 	fe->owned_head = &pcl->next;
 	fe->pcl = pcl;
 	return 0;
@@ -867,14 +868,14 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
-		/* used to check tail merging loop due to corrupted images */
-		if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
-			fe->tailpcl = fe->pcl;
-
 		z_erofs_try_to_claim_pcluster(fe);
 	} else if (ret) {
 		return ret;
 	}
+
+	/* detect/avoid loop formed out of chain linking (type 2) */
+	if (fe->pcl->next == Z_EROFS_PCLUSTER_TAIL)
+		fe->tailpcl = fe->pcl;
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
-- 
2.24.4

