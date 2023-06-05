Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FF72323D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjFEV1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjFEV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:27:36 -0400
Received: from out-56.mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B410F103
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:27:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686000452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gR7sUcc0CCd73W0AJgJf+Yzlzd7UVNwd4CA1FDhxHHo=;
        b=BRykaURFluVQKF9N0nRDgPlDzZQ4diAlXAvqoPlyzBOELkX8ONXeQQgZPQN2Q++5rbh21T
        8mB/wDQdLjVU/sPq6OZ7G5icjNRpCZk9oTNzDt5bWel5jlrLTzNUNTeGdx7VQLV7UjLqPX
        tO7uzSCyb9VBMuA5/WfDwVwkJavw5F4=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 4/5] block: Change memcpy_(to|from)_bvec to pass bvec by value
Date:   Mon,  5 Jun 2023 17:27:16 -0400
Message-Id: <20230605212717.2570570-4-kent.overstreet@linux.dev>
In-Reply-To: <20230605212717.2570570-1-kent.overstreet@linux.dev>
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small code size decrease; memcpy_from_bvec() is inlined so
there's no benefit to passing the bvec by referene, but taking a pointer
to it may inhibit optimization in the caller.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 block/blk-map.c               | 2 +-
 block/bounce.c                | 4 ++--
 drivers/block/floppy.c        | 4 ++--
 drivers/block/ps3disk.c       | 2 +-
 drivers/block/zram/zram_drv.c | 4 ++--
 drivers/md/dm-log-writes.c    | 2 +-
 drivers/scsi/aha1542.c        | 2 +-
 include/linux/bvec.h          | 8 ++++----
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 524d84011f..50540d0a22 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -447,7 +447,7 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	struct bio_vec bvec;
 
 	bio_for_each_segment_all(bvec, bio, iter) {
-		memcpy_from_bvec(p, &bvec);
+		memcpy_from_bvec(p, bvec);
 		p += bvec.bv_len;
 	}
 
diff --git a/block/bounce.c b/block/bounce.c
index e701832d76..1dc6716084 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -92,7 +92,7 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 			 * been modified by the block layer, so use the original
 			 * copy, bounce_copy_vec already uses tovec->bv_len
 			 */
-			memcpy_to_bvec(&tovec, page_address(fromvec.bv_page) +
+			memcpy_to_bvec(tovec, page_address(fromvec.bv_page) +
 				       tovec.bv_offset);
 		}
 		bio_advance_iter(from, &from_iter, tovec.bv_len);
@@ -249,7 +249,7 @@ struct bio *__blk_queue_bounce(struct bio *bio_orig, struct request_queue *q)
 
 		if (rw == WRITE) {
 			flush_dcache_page(to->bv_page);
-			memcpy_from_bvec(page_address(bounce_page), to);
+			memcpy_from_bvec(page_address(bounce_page), *to);
 		}
 		to->bv_page = bounce_page;
 	}
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index cec2c20f5e..039e4ebfad 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2483,9 +2483,9 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 		}
 
 		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
-			memcpy_to_bvec(&bv, dma_buffer);
+			memcpy_to_bvec(bv, dma_buffer);
 		else
-			memcpy_from_bvec(dma_buffer, &bv);
+			memcpy_from_bvec(dma_buffer, bv);
 
 		remaining -= size;
 		dma_buffer += size;
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 36d7b36c60..73db9ca530 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -86,7 +86,7 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 
 	rq_for_each_segment(bvec, req, iter) {
 		if (gather)
-			memcpy_from_bvec(dev->bounce_buf + offset, &bvec);
+			memcpy_from_bvec(dev->bounce_buf + offset, bvec);
 		else
 			memcpy_to_bvec(&bvec, dev->bounce_buf + offset);
 	}
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6d90f1ba5..b68ae64a99 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1396,7 +1396,7 @@ static int zram_bvec_read_partial(struct zram *zram, struct bio_vec *bvec,
 		return -ENOMEM;
 	ret = zram_read_page(zram, page, index, NULL);
 	if (likely(!ret))
-		memcpy_to_bvec(bvec, page_address(page) + offset);
+		memcpy_to_bvec(*bvec, page_address(page) + offset);
 	__free_page(page);
 	return ret;
 }
@@ -1548,7 +1548,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 
 	ret = zram_read_page(zram, page, index, bio);
 	if (!ret) {
-		memcpy_from_bvec(page_address(page) + offset, bvec);
+		memcpy_from_bvec(page_address(page) + offset, *bvec);
 		ret = zram_write_page(zram, page, index);
 	}
 	__free_page(page);
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index f17a6cf228..7772466d0a 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -744,7 +744,7 @@ static int log_writes_map(struct dm_target *ti, struct bio *bio)
 		}
 
 		dst = kmap_local_page(page);
-		memcpy_from_bvec(dst, &bv);
+		memcpy_from_bvec(dst, bv);
 		kunmap_local(dst);
 		block->vecs[i].bv_page = page;
 		block->vecs[i].bv_len = bv.bv_len;
diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index 9503996c63..5db9e31352 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -450,7 +450,7 @@ static int aha1542_queuecommand(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 		struct bio_vec bv;
 
 		rq_for_each_segment(bv, rq, iter) {
-			memcpy_from_bvec(buf, &bv);
+			memcpy_from_bvec(buf, bv);
 			buf += bv.bv_len;
 		}
 	}
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ebf8b612ba..ee5965fedf 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -257,9 +257,9 @@ static inline void *bvec_kmap_local(struct bio_vec *bvec)
  *
  * Must be called on single-page bvecs only.
  */
-static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
+static inline void memcpy_from_bvec(char *to, struct bio_vec bvec)
 {
-	memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
+	memcpy_from_page(to, bvec.bv_page, bvec.bv_offset, bvec.bv_len);
 }
 
 /**
@@ -268,9 +268,9 @@ static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
  *
  * Must be called on single-page bvecs only.
  */
-static inline void memcpy_to_bvec(struct bio_vec *bvec, const char *from)
+static inline void memcpy_to_bvec(struct bio_vec bvec, const char *from)
 {
-	memcpy_to_page(bvec->bv_page, bvec->bv_offset, from, bvec->bv_len);
+	memcpy_to_page(bvec.bv_page, bvec.bv_offset, from, bvec.bv_len);
 }
 
 /**
-- 
2.40.1

