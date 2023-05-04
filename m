Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5095A6F770A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjEDUcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEDUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:32:19 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094031156B;
        Thu,  4 May 2023 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230734;
        bh=QcIbf0/W/0tjmDJfN3K1x8lHrFbEPUWzJFa8s3c9fPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al4b3prNPOgFLIry5QRsiV7BMrgdJB5bp4bmx7Pos2w5P+YZsuggLjjbLG62RauMe
         RKuV7lps9ytKmdR7YJFSU0zi1AzzhbJ1BhCVHXCp3PLa+JCVK9SCFV+fHAcfb77EsW
         BMX3wqtdhQ2BybtmbZAHGLkMJv3aTFNUoeVukyGNmRl726XcDfprt7Hp5G+vXNzt2s
         xKJudcCUTE3Zcdr70kARY9RRTvDPV+H2pZtTIo48xW3VgUUEb3BoYJzqPcYJwPupZ+
         AfsvwbTpjT0+oIZ4cEIvbxW3htx/Vux+3hxP18amRC5bEI/vi9t/3x9Y0ZAGlyZ/3b
         /RhxNuB7YQnkA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yp64TWz11jK;
        Thu,  4 May 2023 16:05:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 13/13] bio.h: Fix parentheses around macro parameter use
Date:   Thu,  4 May 2023 16:05:27 -0400
Message-Id: <20230504200527.1935944-14-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses around macro parameter use in the following
patterns to ensure operator precedence behaves as expected:

- "x++" is changed for "(x)++",
- x->member is changed for (x)->member,
- &x is changed for &(x).
- "x = y" is changed for "x = (y)", because "y" can be an expression
  containing a comma if it is the result of the expansion of a macro such
  as #define eval(...) __VA_ARGS__, which would cause unexpected operator
  precedence. This use-case is far-fetched, but we have to choose one
  way or the other (with or without parentheses) for consistency.

Remove useless parentheses in the following macro argument usage
patterns:

- m((x)) is changed for m(x),
- m((x), y) is changed for m(x, y) because comma has lowest operator
  precedence, making the extra parentheses useless,

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org
---
 include/linux/bio.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b3e7529ff55e..f09aea290511 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -20,7 +20,7 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 }
 
 #define bio_prio(bio)			(bio)->bi_ioprio
-#define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
+#define bio_set_prio(bio, prio)		((bio)->bi_ioprio = (prio))
 
 #define bio_iter_iovec(bio, iter)				\
 	bvec_iter_bvec((bio)->bi_io_vec, (iter))
@@ -37,7 +37,7 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_iovec(bio)		bio_iter_iovec((bio), (bio)->bi_iter)
 
 #define bvec_iter_sectors(iter)	((iter).bi_size >> 9)
-#define bvec_iter_end_sector(iter) ((iter).bi_sector + bvec_iter_sectors((iter)))
+#define bvec_iter_end_sector(iter) ((iter).bi_sector + bvec_iter_sectors(iter))
 
 #define bio_sectors(bio)	bvec_iter_sectors((bio)->bi_iter)
 #define bio_end_sector(bio)	bvec_iter_end_sector((bio)->bi_iter)
@@ -93,7 +93,7 @@ static inline bool bio_next_segment(const struct bio *bio,
  * before it got to the driver and the driver won't own all of it
  */
 #define bio_for_each_segment_all(bvl, bio, iter) \
-	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
+	for (bvl = bvec_init_iter_all(&(iter)); bio_next_segment(bio, &(iter)); )
 
 static inline void bio_advance_iter(const struct bio *bio,
 				    struct bvec_iter *iter, unsigned int bytes)
@@ -145,17 +145,17 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
-	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
+		((bvl = bio_iter_iovec(bio, iter)), 1);			\
+	     bio_advance_iter_single(bio, &(iter), (bvl).bv_len))
 
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
-#define __bio_for_each_bvec(bvl, bio, iter, start)		\
+#define __bio_for_each_bvec(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
-	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
+		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, iter)), 1);	\
+	     bio_advance_iter_single(bio, &(iter), (bvl).bv_len))
 
 /* iterate over multi-page bvec */
 #define bio_for_each_bvec(bvl, bio, iter)			\
@@ -167,7 +167,7 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
-	     i < (bio)->bi_vcnt; i++, bvl++)
+	     i < (bio)->bi_vcnt; (i)++, (bvl)++)
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
@@ -548,7 +548,7 @@ static inline void bio_list_init(struct bio_list *bl)
 #define BIO_EMPTY_LIST	{ NULL, NULL }
 
 #define bio_list_for_each(bio, bl) \
-	for (bio = (bl)->head; bio; bio = bio->bi_next)
+	for (bio = (bl)->head; bio; bio = (bio)->bi_next)
 
 static inline unsigned bio_list_size(const struct bio_list *bl)
 {
@@ -702,7 +702,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 
 #define bio_for_each_integrity_vec(_bvl, _bio, _iter)			\
 	for_each_bio(_bio)						\
-		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
+		bip_for_each_vec(_bvl, (_bio)->bi_integrity, _iter)
 
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
-- 
2.25.1

