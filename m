Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656CD5BE19E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiITJLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiITJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B65AA25
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091126euoutp02567fac29dd3ba1badd02aabbb1ac25a4~WhpTaqhx82699126991euoutp02C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220920091126euoutp02567fac29dd3ba1badd02aabbb1ac25a4~WhpTaqhx82699126991euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665086;
        bh=g6cvHUHFMmZ6M5VNskOyX2H4LfFCLQXpA5oOFFm3IYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3PG13idMwZiCWwSj1rCD3Vu8eGEhO2eJ33fWIybj5CPJLTIY3PHrv7kW/VVD8oNj
         8tuWMk9VpfIgXoEtjXlT7H0QzeoUwmlCW+jURlujAz0KrRTtDuu36st+yOzbtPCCM9
         qIUn+kp2PMG2cDK0ZAf369E3pF3hp+SuXPVceNJs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220920091124eucas1p102ad33837cae27d699ac953192547133~WhpRVTGFa0663106631eucas1p15;
        Tue, 20 Sep 2022 09:11:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.7E.07817.BB389236; Tue, 20
        Sep 2022 10:11:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220920091123eucas1p26623d067c9a2d36d4f3b29b77c6d937a~WhpQ0a95g1342313423eucas1p2A;
        Tue, 20 Sep 2022 09:11:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220920091123eusmtrp26710eecbd8e562a5cb4a9ac136b8583e~WhpQzVwYj2413024130eusmtrp2H;
        Tue, 20 Sep 2022 09:11:23 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-15-632983bb847f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1E.FD.07473.BB389236; Tue, 20
        Sep 2022 10:11:23 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091123eusmtip22af2dafe4828f945165c1b6928bc58bd~WhpQjceU22352523525eusmtip2-;
        Tue, 20 Sep 2022 09:11:23 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Tue, 20 Sep 2022 11:11:09 +0200
Message-Id: <20220920091119.115879-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87q7mzWTDa4ut7RYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlXF+
        9x6mgpUaFXcnf2JvYPyo0MXIySEhYCKx8vU91i5GLg4hgRWMEl+O/mWEcL4wSrw8uZEJwvnM
        KHHqySFWmJZ1l6YzQySWM0ocuPIdynnJKNF74wpbFyMHB5uAlkRjJztIg4hAusTXrxvAxjIL
        TGSWeDj7EwtIQlggRuLz839MIDaLgKrE15nNYHFeASuJ568XQG2Tl5h56TvYIE4Ba4k5u1vY
        IGoEJU7OfAJWzwxU07x1NtgREgLbOSU2tHexQTS7SLz48w9qkLDEq+Nb2CFsGYn/O+czQdjV
        Ek9v/IZqbmGU6N+5HuwDCaBtfWdyQExmAU2J9bv0IcodJY6cuAtVwSdx460gxAl8EpO2gQIF
        JMwr0dEmBFGtJLHz5xOopRISl5vmsEDYHhJzzm9jnsCoOAvJM7OQPDMLYe8CRuZVjOKppcW5
        6anFRnmp5XrFibnFpXnpesn5uZsYgSnx9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRHeFn/NZCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MAuXPX8bcddXf
        esT3TlFBTHt5Vq3fLbunF21CvuWv8Qn6NTH3lZJLy8QH9y5sraqs3za3UZ6fv8AqdI3jrpZ/
        cx/duyOV9mGXc+2z02WNOm5PK997zrWbuWOV2Ym1eZfyP/zWb62bUtleYzfbecLsc2ITv3hG
        fbphOfO12WWVzbJ7EhPZTr3ZEWPyb/GysvX5nM4VIr9ydwotv7n142/L+g8zrm2cLdg65wHf
        +Rm/Jxn5rRS/s0XqXvHe7G0CJrdnek+f6sf47OkBu/2XkxdP1Vv884Du/29plXrLjwduPjbh
        y3YWP7XrKVfuP+/Rb9He5/WbxbTnyALF3p+yYiF33rz2VfGutmZYs+RjuIii/QUlluKMREMt
        5qLiRACFxZWi+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7q7mzWTDZ5eELNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F+9x6mgpUaFXcnf2JvYPyo0MXI
        ySEhYCKx7tJ05i5GLg4hgaWMEm9//WWESEhI3F7YBGULS/y51sUGUfScUeL56g1ADgcHm4CW
        RGMnO0iNiECuxOHNE5hAapgF5jNL7Pr3FiwhLBAlMfndBFYQm0VAVeLrzGYWEJtXwEri+esF
        rBAL5CVmXvoOVs8pYC0xZ3cLG4gtBFTTMWszG0S9oMTJmU/AepmB6pu3zmaewCgwC0lqFpLU
        AkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRu+3Yz807GOe9+qh3iJGJg/EQowQHs5II
        b4u/ZrIQb0piZVVqUX58UWlOavEhRlOguycyS4km5wPTR15JvKGZgamhiZmlgamlmbGSOK9n
        QUeikEB6YklqdmpqQWoRTB8TB6dUA9MkrhR+r+Sm47+2Nf3aaeNpr7XXfWfPetnNLVEtPILz
        XjCmzjDQY9+yqvJp34wN4QcNn68UEPmoJyl5Sfr6wdvz5rREpOf47qmLuVrS3OutO2fu8Qtp
        Hh9nKSWoPHNj8/4mbbyvOeZDSHr5l1r7+xZu+s9NRJdYGr39/v7zmpeq1jXZrCe+SJd93HM5
        c+9rpVN1WaHr0s6HHU8zfBRV917F9sZimel+V9adzZuyOjMywcRZynD5BA2e5fd+Liixa3j7
        Yb72O/8yOf3Aq6YKGTEpXuFzjrwJWtJ23ED8SlXlWwm3nxeFty91P70uc5XY5m+K/wLkJURK
        NuXwW7zLeWi9PMRgWTZj7OaPWtenJCmxFGckGmoxFxUnAgC96tQqZwMAAA==
X-CMS-MailID: 20220920091123eucas1p26623d067c9a2d36d4f3b29b77c6d937a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091123eucas1p26623d067c9a2d36d4f3b29b77c6d937a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091123eucas1p26623d067c9a2d36d4f3b29b77c6d937a
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091123eucas1p26623d067c9a2d36d4f3b29b77c6d937a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      | 24 ++++++++++++++++++------
 include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4d0dd0e9e46d..735f63b6159a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -559,7 +559,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
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
index 6cf43f9384cc..e29799076298 100644
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

