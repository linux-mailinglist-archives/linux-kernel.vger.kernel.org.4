Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061EF64ED4D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiLPO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiLPO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002B860345;
        Fri, 16 Dec 2022 06:58:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 676BF5D097;
        Fri, 16 Dec 2022 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671202722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1aJf8gXHaJ+X80/r6maMNPs5igiWeM8Bd/SEgyLpuA=;
        b=X4OcY5RzrJYhO+F6Pv8Xntji3GFS9qqfvMdZDVzhk5OGM5gkqQdbyKjUs+gLMU5wdBr20y
        Sxg/cuBju/PlS9J4M2tR4pMwjUW2YTrGYAsyVU/TDbstIrOSLYQOe+h8ztyBlsDXwnNNvy
        0bGgYExlshlxwyNzTjGhy/V6tbfp68I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A5E8138FD;
        Fri, 16 Dec 2022 14:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3TMRDaKHnGPZeAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 16 Dec 2022 14:58:42 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH 4/4] xen/blkback: move blkif_get_x86_*_req() into blkback.c
Date:   Fri, 16 Dec 2022 15:58:16 +0100
Message-Id: <20221216145816.27374-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216145816.27374-1-jgross@suse.com>
References: <20221216145816.27374-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/block/xen-blkback/blkback.c | 104 ++++++++++++++++++++++++++++
 drivers/block/xen-blkback/common.h  |  96 -------------------------
 2 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 243712b59a05..7561fdb72c13 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1072,7 +1072,111 @@ static void end_block_io_op(struct bio *bio)
 	bio_put(bio);
 }
 
+static void blkif_get_x86_32_req(struct blkif_request *dst,
+				 struct blkif_x86_32_request *src)
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

