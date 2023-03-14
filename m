Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AF6B97F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCNO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCNO23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:28:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3E2ACE18;
        Tue, 14 Mar 2023 07:28:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E472721C64;
        Tue, 14 Mar 2023 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678804086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zEkV0KKFS11XXVqEf9jhtR2fN1YoNqxonAwEeQxw4s=;
        b=l0QTSYHFh/JivXw+osBjNn21s5R3lRFmR9Oj6r6PZGQHRM/5+BKk1Sp64V6BCAy3lzvs5R
        3aBOzw9tLKmQUHC1MoAelABg3epuWR5hZqVejuwdUvX3Jo3NZBAGkqcs3WcZteYXX1tXnv
        L/PKbobwmaT70QsnpbQXKm3/cbaKuFA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B523C13A26;
        Tue, 14 Mar 2023 14:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c7PSKnaEEGTJHQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Mar 2023 14:28:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 4/4] xen/blkback: move blkif_get_x86_*_req() into blkback.c
Date:   Tue, 14 Mar 2023 15:27:41 +0100
Message-Id: <20230314142741.24917-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230314142741.24917-1-jgross@suse.com>
References: <20230314142741.24917-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the functions blkif_get_x86_32_req() and
blkif_get_x86_64_req() in a header file, as they are used in one place
only.

So move them into the using source file and drop the inline qualifier.

While at it fix some style issues, and simplify the code by variable
reusing and using min() instead of open coding it.

Instead of using barrier() use READ_ONCE() for avoiding multiple reads
of nr_segments.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
V2:
- add const, use unsigned int for loop counters (Roger Pau Monné)
---
 drivers/block/xen-blkback/blkback.c | 104 ++++++++++++++++++++++++++++
 drivers/block/xen-blkback/common.h  |  96 -------------------------
 2 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 243712b59a05..ab6308b2d328 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1072,7 +1072,111 @@ static void end_block_io_op(struct bio *bio)
 	bio_put(bio);
 }
 
+static void blkif_get_x86_32_req(struct blkif_request *dst,
+				 const struct blkif_x86_32_request *src)
+{
+	unsigned int i, n;
+
+	dst->operation = READ_ONCE(src->operation);
+
+	switch (dst->operation) {
+	case BLKIF_OP_READ:
+	case BLKIF_OP_WRITE:
+	case BLKIF_OP_WRITE_BARRIER:
+	case BLKIF_OP_FLUSH_DISKCACHE:
+		dst->u.rw.nr_segments = READ_ONCE(src->u.rw.nr_segments);
+		dst->u.rw.handle = src->u.rw.handle;
+		dst->u.rw.id = src->u.rw.id;
+		dst->u.rw.sector_number = src->u.rw.sector_number;
+		n = min_t(unsigned int, BLKIF_MAX_SEGMENTS_PER_REQUEST,
+			  dst->u.rw.nr_segments);
+		for (i = 0; i < n; i++)
+			dst->u.rw.seg[i] = src->u.rw.seg[i];
+		break;
+
+	case BLKIF_OP_DISCARD:
+		dst->u.discard.flag = src->u.discard.flag;
+		dst->u.discard.id = src->u.discard.id;
+		dst->u.discard.sector_number = src->u.discard.sector_number;
+		dst->u.discard.nr_sectors = src->u.discard.nr_sectors;
+		break;
+
+	case BLKIF_OP_INDIRECT:
+		dst->u.indirect.indirect_op = src->u.indirect.indirect_op;
+		dst->u.indirect.nr_segments =
+			READ_ONCE(src->u.indirect.nr_segments);
+		dst->u.indirect.handle = src->u.indirect.handle;
+		dst->u.indirect.id = src->u.indirect.id;
+		dst->u.indirect.sector_number = src->u.indirect.sector_number;
+		n = min(MAX_INDIRECT_PAGES,
+			INDIRECT_PAGES(dst->u.indirect.nr_segments));
+		for (i = 0; i < n; i++)
+			dst->u.indirect.indirect_grefs[i] =
+				src->u.indirect.indirect_grefs[i];
+		break;
+
+	default:
+		/*
+		 * Don't know how to translate this op. Only get the
+		 * ID so failure can be reported to the frontend.
+		 */
+		dst->u.other.id = src->u.other.id;
+		break;
+	}
+}
 
+static void blkif_get_x86_64_req(struct blkif_request *dst,
+				 struct blkif_x86_64_request *src)
+{
+	int i, n;
+
+	dst->operation = READ_ONCE(src->operation);
+
+	switch (dst->operation) {
+	case BLKIF_OP_READ:
+	case BLKIF_OP_WRITE:
+	case BLKIF_OP_WRITE_BARRIER:
+	case BLKIF_OP_FLUSH_DISKCACHE:
+		dst->u.rw.nr_segments = READ_ONCE(src->u.rw.nr_segments);
+		dst->u.rw.handle = src->u.rw.handle;
+		dst->u.rw.id = src->u.rw.id;
+		dst->u.rw.sector_number = src->u.rw.sector_number;
+		n = min_t(int, BLKIF_MAX_SEGMENTS_PER_REQUEST,
+			  dst->u.rw.nr_segments);
+		for (i = 0; i < n; i++)
+			dst->u.rw.seg[i] = src->u.rw.seg[i];
+		break;
+
+	case BLKIF_OP_DISCARD:
+		dst->u.discard.flag = src->u.discard.flag;
+		dst->u.discard.id = src->u.discard.id;
+		dst->u.discard.sector_number = src->u.discard.sector_number;
+		dst->u.discard.nr_sectors = src->u.discard.nr_sectors;
+		break;
+
+	case BLKIF_OP_INDIRECT:
+		dst->u.indirect.indirect_op = src->u.indirect.indirect_op;
+		dst->u.indirect.nr_segments =
+			READ_ONCE(src->u.indirect.nr_segments);
+		dst->u.indirect.handle = src->u.indirect.handle;
+		dst->u.indirect.id = src->u.indirect.id;
+		dst->u.indirect.sector_number = src->u.indirect.sector_number;
+		n = min(MAX_INDIRECT_PAGES,
+			INDIRECT_PAGES(dst->u.indirect.nr_segments));
+		for (i = 0; i < n; i++)
+			dst->u.indirect.indirect_grefs[i] =
+				src->u.indirect.indirect_grefs[i];
+		break;
+
+	default:
+		/*
+		 * Don't know how to translate this op. Only get the
+		 * ID so failure can be reported to the frontend.
+		 */
+		dst->u.other.id = src->u.other.id;
+		break;
+	}
+}
 
 /*
  * Function to copy the from the ring buffer the 'struct blkif_request'
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index fab8a8dee0da..40f67bfc052d 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -394,100 +394,4 @@ int xen_blkbk_barrier(struct xenbus_transaction xbt,
 struct xenbus_device *xen_blkbk_xenbus(struct backend_info *be);
 void xen_blkbk_unmap_purged_grants(struct work_struct *work);
 
-static inline void blkif_get_x86_32_req(struct blkif_request *dst,
-					struct blkif_x86_32_request *src)
-{
-	int i, n = BLKIF_MAX_SEGMENTS_PER_REQUEST, j;
-	dst->operation = READ_ONCE(src->operation);
-	switch (dst->operation) {
-	case BLKIF_OP_READ:
-	case BLKIF_OP_WRITE:
-	case BLKIF_OP_WRITE_BARRIER:
-	case BLKIF_OP_FLUSH_DISKCACHE:
-		dst->u.rw.nr_segments = src->u.rw.nr_segments;
-		dst->u.rw.handle = src->u.rw.handle;
-		dst->u.rw.id = src->u.rw.id;
-		dst->u.rw.sector_number = src->u.rw.sector_number;
-		barrier();
-		if (n > dst->u.rw.nr_segments)
-			n = dst->u.rw.nr_segments;
-		for (i = 0; i < n; i++)
-			dst->u.rw.seg[i] = src->u.rw.seg[i];
-		break;
-	case BLKIF_OP_DISCARD:
-		dst->u.discard.flag = src->u.discard.flag;
-		dst->u.discard.id = src->u.discard.id;
-		dst->u.discard.sector_number = src->u.discard.sector_number;
-		dst->u.discard.nr_sectors = src->u.discard.nr_sectors;
-		break;
-	case BLKIF_OP_INDIRECT:
-		dst->u.indirect.indirect_op = src->u.indirect.indirect_op;
-		dst->u.indirect.nr_segments = src->u.indirect.nr_segments;
-		dst->u.indirect.handle = src->u.indirect.handle;
-		dst->u.indirect.id = src->u.indirect.id;
-		dst->u.indirect.sector_number = src->u.indirect.sector_number;
-		barrier();
-		j = min(MAX_INDIRECT_PAGES, INDIRECT_PAGES(dst->u.indirect.nr_segments));
-		for (i = 0; i < j; i++)
-			dst->u.indirect.indirect_grefs[i] =
-				src->u.indirect.indirect_grefs[i];
-		break;
-	default:
-		/*
-		 * Don't know how to translate this op. Only get the
-		 * ID so failure can be reported to the frontend.
-		 */
-		dst->u.other.id = src->u.other.id;
-		break;
-	}
-}
-
-static inline void blkif_get_x86_64_req(struct blkif_request *dst,
-					struct blkif_x86_64_request *src)
-{
-	int i, n = BLKIF_MAX_SEGMENTS_PER_REQUEST, j;
-	dst->operation = READ_ONCE(src->operation);
-	switch (dst->operation) {
-	case BLKIF_OP_READ:
-	case BLKIF_OP_WRITE:
-	case BLKIF_OP_WRITE_BARRIER:
-	case BLKIF_OP_FLUSH_DISKCACHE:
-		dst->u.rw.nr_segments = src->u.rw.nr_segments;
-		dst->u.rw.handle = src->u.rw.handle;
-		dst->u.rw.id = src->u.rw.id;
-		dst->u.rw.sector_number = src->u.rw.sector_number;
-		barrier();
-		if (n > dst->u.rw.nr_segments)
-			n = dst->u.rw.nr_segments;
-		for (i = 0; i < n; i++)
-			dst->u.rw.seg[i] = src->u.rw.seg[i];
-		break;
-	case BLKIF_OP_DISCARD:
-		dst->u.discard.flag = src->u.discard.flag;
-		dst->u.discard.id = src->u.discard.id;
-		dst->u.discard.sector_number = src->u.discard.sector_number;
-		dst->u.discard.nr_sectors = src->u.discard.nr_sectors;
-		break;
-	case BLKIF_OP_INDIRECT:
-		dst->u.indirect.indirect_op = src->u.indirect.indirect_op;
-		dst->u.indirect.nr_segments = src->u.indirect.nr_segments;
-		dst->u.indirect.handle = src->u.indirect.handle;
-		dst->u.indirect.id = src->u.indirect.id;
-		dst->u.indirect.sector_number = src->u.indirect.sector_number;
-		barrier();
-		j = min(MAX_INDIRECT_PAGES, INDIRECT_PAGES(dst->u.indirect.nr_segments));
-		for (i = 0; i < j; i++)
-			dst->u.indirect.indirect_grefs[i] =
-				src->u.indirect.indirect_grefs[i];
-		break;
-	default:
-		/*
-		 * Don't know how to translate this op. Only get the
-		 * ID so failure can be reported to the frontend.
-		 */
-		dst->u.other.id = src->u.other.id;
-		break;
-	}
-}
-
 #endif /* __XEN_BLKIF__BACKEND__COMMON_H__ */
-- 
2.35.3

