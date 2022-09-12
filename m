Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6E5B55FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiILIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiILIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD2275F7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082212euoutp01682c45f77d947456615ab28bfa486fb2~UD0ChSQsz1429114291euoutp01G
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220912082212euoutp01682c45f77d947456615ab28bfa486fb2~UD0ChSQsz1429114291euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970932;
        bh=ObXXkVs0jGDKCmEhpNVJ0p5o0WckGSN2AWqGCJVENLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzugWKerNpXqGXcJ1AEQRItPDAfM9ZCJ5fvNR9mZbFBBxtwipAXBVF7pOT724huXq
         ofAQ5PIZo9mQeC5nhlzMu8KL+mh17x21p4jmxhWECusajguRtWYjn/1TRU4r9gURjC
         zoaLzJrctaV8DhwX2p3g2xyRAUrU0UchV8Ht3xVw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082209eucas1p2069cce282a374a5a253ecba71b2b97d9~UDz-xGiYK3082430824eucas1p2D;
        Mon, 12 Sep 2022 08:22:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0C.46.07817.13CEE136; Mon, 12
        Sep 2022 09:22:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220912082209eucas1p2747fa09635df54a6c76821585776672f~UDz-Rgzrq2521325213eucas1p2J;
        Mon, 12 Sep 2022 08:22:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220912082209eusmtrp115ccb9dbe793be17fad981d513ee7bf9~UDz-QtHke1301813018eusmtrp1X;
        Mon, 12 Sep 2022 08:22:09 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-ab-631eec31ac18
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.2F.07473.13CEE136; Mon, 12
        Sep 2022 09:22:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082208eusmtip2a0feeb2bf2cebe4277077635b3fe4c0e~UDz_6zPMg2614326143eusmtip22;
        Mon, 12 Sep 2022 08:22:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        linux-nvme@lists.infradead.org, pankydev8@gmail.com,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org,
        bvanassche@acm.org, gost.dev@samsung.com, dm-devel@redhat.com,
        hare@suse.de, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v13 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Mon, 12 Sep 2022 10:21:54 +0200
Message-Id: <20220912082204.51189-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qGb+SSDaZsUrVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlfGs
        fwF7wWv1iv5LG9gbGHcodDFyckgImEgsubaRqYuRi0NIYAWjxObVrVDOF0aJe9v/M0M4nxkl
        /n34ywzTsubTWajEckaJk5vmMkI4LxklLj1/DdTPwcEmoCXR2MkO0iAikC7xffo7sLHMAneY
        JJoOvWAESQgLxEgs23SDBcRmEVCVWLXlN1icV8BS4sj540wQ2+QlZl76DjaIU8BK4vWqVqga
        QYmTM5+A9TID1TRvnQ12kYTAdk6JzWu/sYAcISHgInFpiiLEHGGJV8e3sEPYMhKnJ/ewQNjV
        Ek9v/IbqbWGU6N+5ng2i11qi70wOiMksoCmxfpc+RLmjxJkv+5ghKvgkbrwVhLiAT2LStulQ
        YV6JjjYhiGoliZ0/n0AtlZC43DQHaqmHxONju9kmMCrOQvLLLCS/zELYu4CReRWjeGppcW56
        arFRXmq5XnFibnFpXrpecn7uJkZgQjz97/iXHYzLX33UO8TIxMF4iFGCg1lJhJfFUDpZiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1P3G5OTwZMTeDUs
        Y/yvZSgp/1vQ+olr5ryUl1FfK06+vZrvE7hr/X67zsDdq8UWPrU8vdNH8MZGlrAniv0Sl1TT
        MjN7pFYoBeRNPz1Bd1f5pVSxo80tRv/O1UybfPt0ZN81ncOrNcQCtobkL5go+mllvuK5w7cM
        9p157Pfw71erTS/Eus++vLWeedKVSZsY3plmz3DVCnFVFZoarvDh7SrT/Xei3mx8JV9z5+i7
        itglp/f6GJqvLbU+NPvW18ceNZdtii563u4r1Dr5e5nHveJVxx4wf740bXnRv0d/rz7sX7fo
        vdm5nNJ/YXGM/hY5WlscLOpXX9dbqJHM99jQv8f/oS7zpfQlRzUVvwk472r7rcRSnJFoqMVc
        VJwIAGXly8j3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7qGb+SSDU7/ZbNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/GsfwF7wWv1iv5LG9gbGHcodDFy
        ckgImEis+XSWuYuRi0NIYCmjxPk5R1khEhIStxc2MULYwhJ/rnWxQRQ9Z5TY/O8XUIKDg01A
        S6Kxkx2kRkQgV+Lzyh9gNcwCb5gkviyZxASSEBaIkni27iDYUBYBVYlVW36DDeUVsJQ4cv44
        E8QCeYmZl76DDeIUsJJ4vaoVrEYIqObstxvsEPWCEidnPmEBsZmB6pu3zmaewCgwC0lqFpLU
        AkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRu+3Yz807GOe9+qh3iJGJg/EQowQHs5II
        L4uhdLIQb0piZVVqUX58UWlOavEhRlOguycyS4km5wPTR15JvKGZgamhiZmlgamlmbGSOK9n
        QUeikEB6YklqdmpqQWoRTB8TB6dUA5PpzKily17tcr02zW7huo2hi2Z3hEevuBZrM61z98yf
        yzh+6Df+uWITOrHos/X7LU/reo0e3av8Nr9l12vezXflvvh8PBGWaru/IIBj8cZFCvs3V9/d
        kPflDn9aY3aSD4/lpNVH3dQfJk8Nvq7msqjazfpN/O/sOVHVxTPF3vJ4tbC7sMraJYru6LrW
        G9bKGr02xfi9XLJJ7E2vKSabX7VodqgeYvP9Irh3K0sha7Re+GfTTS9rL9SfO6Fxon5flMat
        Uw1aO29MzyiyYNldqHFBLyhM9PfaqNYwzgqtH0ITtpn5PGxacccvmf3NHP6PTFZfWqxqtMRv
        vJv28qDy83VLSpsevbO9wfJrzf//j3SUWIozEg21mIuKEwHIh7jNZwMAAA==
X-CMS-MailID: 20220912082209eucas1p2747fa09635df54a6c76821585776672f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082209eucas1p2747fa09635df54a6c76821585776672f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082209eucas1p2747fa09635df54a6c76821585776672f
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082209eucas1p2747fa09635df54a6c76821585776672f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking if a given sector is aligned to a zone is a common
operation that is performed for zoned devices. Add
bdev_is_zone_start helper to check for this instead of opencoding it
everywhere.

Convert the calculations on zone size to be generic instead of relying on
power-of-2(po2) based arithmetic in the block layer using the helpers
wherever possible.

The only hot path affected by this change for zoned devices with po2
zone size is in blk_check_zone_append() but bdev_is_zone_start() helper is
used to optimize the calculation for po2 zone sizes.

Finally, allow zoned devices with non po2 zone sizes provided that their
zone capacity and zone size are equal. The main motivation to allow zoned
devices with non po2 zone size is to remove the unmapped LBA between
zone capcity and zone size for devices that cannot have a po2 zone
capacity.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      | 24 ++++++++++++++++++------
 include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fe6b27e3a513..291149289178 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -560,7 +560,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
 	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dce9c95b4bcd..6806c69c81dc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!bdev_is_zone_start(bdev, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
@@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zero zone size", disk->disk_name);
+			return -ENODEV;
+		}
+
+		/*
+		 * Non power-of-2 zone size support was added to remove the
+		 * gap between zone capacity and zone size. Though it is technically
+		 * possible to have gaps in a non power-of-2 device, Linux requires
+		 * the zone size to be equal to zone capacity for non power-of-2
+		 * zoned devices.
+		 */
+		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
+			pr_err("%s: Invalid zone capacity %lld with non power-of-2 zone size %lld",
+			       disk->disk_name, zone->capacity, zone->len);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 84e7881262e3..d0d66a0db224 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -704,6 +704,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return div64_u64(sector, zone_sectors);
 }
 
+static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
+						   sector_t sec)
+{
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	u64 remainder = 0;
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	if (is_power_of_2(zone_sectors))
+		return sec & (zone_sectors - 1);
+
+	div64_u64_rem(sec, zone_sectors, &remainder);
+	return remainder;
+}
+
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
+{
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return bdev_offset_from_zone_start(bdev, sec) == 0;
+}
+
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 {
 	if (!blk_queue_is_zoned(disk->queue))
@@ -748,6 +772,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
 }
+
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
-- 
2.25.1

