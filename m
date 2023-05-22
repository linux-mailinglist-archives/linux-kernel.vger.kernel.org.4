Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76570CD89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjEVWKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjEVWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:10:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89607B3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:10:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso2536870b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684793404; x=1687385404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhk/FFw49fszGKvEVhYvbvMP+dTpGvDn5zl+3/9L1Dc=;
        b=fblWw9UzbFxiy0IdFHcyiEwVDIdKvIAKrQRPskBGENxPURLIOwwaK7n1zvySgU7WzL
         VU8Vfr1s05BDJeWnx6GvlwtigLtu+eqhdhxMauzwVoEmiW/RcmEFcKMqrypOtXnRwUeV
         Vx8ZBImfDyJb1VIqxhV1vDoDsK4UvJ1KJ+MUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684793404; x=1687385404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhk/FFw49fszGKvEVhYvbvMP+dTpGvDn5zl+3/9L1Dc=;
        b=AkfZluBRGI+QinS4sn0PXC8UTb+hQKYKflPUhIqbq7lf9SqYdRMAnQphMrNwUliPeo
         QhDnnrjheFRC+WjDdpo2RqavEX0QMv5+qFY6iFrORpjlNwaxRf1LpCHv9FjtctLy2Z87
         HFCeTwzhXxz+vx0zlBudwOZgK6KdarY/Pl7ONabriOFVUJ5yKVsELmvimc03mADHiLtK
         j+yiTvlsnnysm4Dj1qI64QkGeJ5WOhtC9+EqDldboBrmTJc3JpfAWenv5E+rZT79lgHZ
         wtaMNmhibw4F2BuwsPBfdwrx5Tu6dAUpzEG7lA3B14XArBfLfyT0cmVya3hh3CPoJ6kP
         fQyA==
X-Gm-Message-State: AC+VfDyg2bhXqJw2i7hc1d2CAWX+6ppbB/MsSaLszuc17vcC49JlRZge
        QpCD/ENeU/0gXb7bXqF1PQ5iTA==
X-Google-Smtp-Source: ACHHUZ5WRtvEBtYahpKG6aPeTI5eHL+V7B6L6O9jAUq/08MWwaaWRvizWzszQGPZBbFKrv/0tLK8Kg==
X-Received: by 2002:a17:902:ea0f:b0:1ad:c736:2090 with SMTP id s15-20020a170902ea0f00b001adc7362090mr14394226plg.3.1684793403998;
        Mon, 22 May 2023 15:10:03 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:7ecd:bb34:d662:f45a])
        by smtp.gmail.com with UTF8SMTPSA id v4-20020a170902b7c400b001ab2b4105ddsm5308998plz.60.2023.05.22.15.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 15:10:03 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v7 5/5] loop: Add support for provision requests
Date:   Mon, 22 May 2023 15:09:55 -0700
Message-ID: <20230522221000.603769-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522163710.GA11607@frogsfrogsfrogs>
References: <20230522163710.GA11607@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 9:37 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> If someone calls fallocate(UNSHARE_RANGE) on a loop bdev, shouldn't
> there be a way to pass that through to the fallocate call to the backing
> file?
>
> --D
>

Yeah, I think we could add a REQ_UNSHARE bit (similar to REQ_NOUNMAP) to pass down the intent to the backing file (and possibly beyond...).

I took a stab at implementing it as a follow up patch so that there's less review churn on the current series. If it looks good, I can add it to the end of the series (or incorporate this into the existing block and loop patches):

From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Mon, 22 May 2023 14:18:15 -0700
Subject: [PATCH] block: Pass unshare intent via REQ_OP_PROVISION

Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
annotate unshare requests to underlying layers. Layers that support
FALLOC_FL_UNSHARE will be able to use this as an indicator of which
fallocate() mode to use.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/blk-lib.c           |  6 +++++-
 block/fops.c              |  6 +++++-
 drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
 include/linux/blk_types.h |  3 +++
 include/linux/blkdev.h    |  3 ++-
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3cff5fb654f5..bea6f5a700b3 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -350,6 +350,7 @@ EXPORT_SYMBOL(blkdev_issue_secure_erase);
  * @sector:	start sector
  * @nr_sects:	number of sectors to provision
  * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @flags:	controls detailed behavior
  *
  * Description:
  *  Issues a provision request to the block device for the range of sectors.
@@ -357,7 +358,7 @@ EXPORT_SYMBOL(blkdev_issue_secure_erase);
  *  underlying storage pool to allocate space for this block range.
  */
 int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp)
+		sector_t nr_sects, gfp_t gfp, unsigned flags)
 {
 	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	unsigned int max_sectors = bdev_max_provision_sectors(bdev);
@@ -380,6 +381,9 @@ int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_iter.bi_size = req_sects << SECTOR_SHIFT;
 
+		if (flags & BLKDEV_UNSHARE_RANGE)
+			bio->bi_opf |= REQ_UNSHARE;
+
 		sector += req_sects;
 		nr_sects -= req_sects;
 		if (!nr_sects) {
diff --git a/block/fops.c b/block/fops.c
index be2e41f160bf..6848756f0557 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -659,7 +659,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	case FALLOC_FL_KEEP_SIZE:
 	case FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE:
 		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
-					       len >> SECTOR_SHIFT, GFP_KERNEL);
+					       len >> SECTOR_SHIFT, GFP_KERNEL,
+					       (mode &
+						FALLOC_FL_UNSHARE_RANGE) ?
+						       BLKDEV_UNSHARE_RANGE :
+						       0);
 		break;
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7fe1a6629754..c844b145d666 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -306,6 +306,30 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
+static bool validate_fallocate_mode(struct loop_device *lo, int mode)
+{
+	bool ret = true;
+
+	switch (mode) {
+	case FALLOC_FL_PUNCH_HOLE:
+	case FALLOC_FL_ZERO_RANGE:
+		if (!bdev_max_discard_sectors(lo->lo_device))
+			ret = false;
+		break;
+	case 0:
+	case FALLOC_FL_UNSHARE_RANGE:
+		if (!bdev_max_provision_sectors(lo->lo_device))
+			ret = false;
+		break;
+
+	default:
+		ret = false;
+	}
+
+	return ret;
+}
+
+
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 			int mode)
 {
@@ -316,11 +340,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	struct file *file = lo->lo_backing_file;
 	int ret;
 
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE) &&
-	    !bdev_max_discard_sectors(lo->lo_device))
-		return -EOPNOTSUPP;
-
-	if (mode == 0 && !bdev_max_provision_sectors(lo->lo_device))
+	if (!validate_fallocate_mode(lo, mode))
 		return -EOPNOTSUPP;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
@@ -493,7 +513,10 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_PROVISION:
-		return lo_fallocate(lo, rq, pos, 0);
+		return lo_fallocate(lo, rq, pos,
+				    (rq->cmd_flags & REQ_UNSHARE) ?
+					    FALLOC_FL_UNSHARE_RANGE :
+					    0);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b7bb0226fdee..1a536fd897cb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -423,6 +423,8 @@ enum req_flag_bits {
 	 */
 	/* for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	/* for REQ_OP_PROVISION: */
+	__REQ_UNSHARE,		/* unshare blocks */
 
 	__REQ_NR_BITS,		/* stops here */
 };
@@ -451,6 +453,7 @@ enum req_flag_bits {
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
+#define REQ_UNSHARE	(__force blk_opf_t)(1ULL << __REQ_UNSHARE)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 462ce586d46f..60c09b0d3fc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1049,10 +1049,11 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 
 extern int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask);
+		sector_t nr_sects, gfp_t gfp_mask, unsigned int flags);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
+#define BLKDEV_UNSHARE_RANGE	(1 << 2)  /* unshare range on provision */
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
-- 
2.39.2

