Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CB5BE19A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiITJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiITJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A15AA0A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091124euoutp021f3d1d307b28195a5229b00d26965f94~WhpSJEOyy2672426724euoutp02X
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220920091124euoutp021f3d1d307b28195a5229b00d26965f94~WhpSJEOyy2672426724euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665084;
        bh=Ib6Av2Av5GCR/6bDN1GY9AWmEphSUTGvcmkm6Z8AdQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvW3vNSHRnOTbfvqTR+PPph13VbdRwkTeyFWlx7hnnJYCyTD4scGvMbUQ2tyHS4Zk
         zBYrFi8Qn4xbIThcWRSTKwkJpR6SNhdK2t3wnwzRD5l8tEp37XFP7jFcT6TU7ncL8j
         FTa4UR09ZEB9k0jLK9QihDZ9Sx4ymYSU7DGRfyoI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091123eucas1p2a0be40c803297d993359aa6b51e00fd0~WhpQdv2QH1342313423eucas1p2_;
        Tue, 20 Sep 2022 09:11:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.88.19378.AB389236; Tue, 20
        Sep 2022 10:11:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220920091122eucas1p2934bc26b6c11bdbafa7ebd3004ce72ee~WhpP2euaV1297012970eucas1p2W;
        Tue, 20 Sep 2022 09:11:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091122eusmtrp1e875e9e33691aec42275dfaf50368b78~WhpP1lQ1n0212802128eusmtrp1K;
        Tue, 20 Sep 2022 09:11:22 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-a1-632983ba3a49
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.FD.07473.AB389236; Tue, 20
        Sep 2022 10:11:22 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091122eusmtip1734e9e77c6ca9e0bfb601744df466a73~WhpPgui_61211712117eusmtip1j;
        Tue, 20 Sep 2022 09:11:22 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 02/13] block: rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helper in blkdev.h
Date:   Tue, 20 Sep 2022 11:11:08 +0200
Message-Id: <20220920091119.115879-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djPc7q7mzWTDS54WKw/dYzZYvXdfjaL
        aR9+Mlv8Pnue2WLvu9msFjcP7GSy2LNoEpPFytVHmSyerJ/FbPG36x6TxdOrs5gs9t7Stri8
        aw6bxfxlT9ktJrR9Zbb4vLSF3WLNzacsFiduSTsIeVy+4u2xc9Zddo/LZ0s9Nq3qZPPYvKTe
        Y/fNBjaP3uZ3bB47W++zerzfd5XNo2/LKkaPzaerPT5vkvNoP9DNFMAbxWWTkpqTWZZapG+X
        wJVxpje2oFu8ov31d8YGxnXCXYycHBICJhJvX/9h7GLk4hASWMEosfTMNyYI5wujxPYXXcwQ
        zmdGic8TpzPCtPx6uxSqajmjxKdTvSwQzktGidU737N3MXJwsAloSTR2soM0iAikS3z9ugFs
        B7NAH7PEstUz2UASwkCJtzuPgBWxCKhK/J83kRGkl1fASuJyfzrEMnmJmZe+g5VwClhLzNnd
        AtbKKyAocXLmExYQmxmopnnrbLBLJQR2c0rM3tjBBNHsItHQMZcFwhaWeHV8CzuELSNxenIP
        VLxa4umN31DNLYwS/TvXs4EcIQG0re9MDojJLKApsX6XPkS5o8Sh66cYISr4JG68FYQ4gU9i
        0rbpzBBhXomONiGIaiWJnT+fQC2VkLjcNAdqqYfE5sv/WScwKs5C8swsJM/MQti7gJF5FaN4
        amlxbnpqsXFearlecWJucWleul5yfu4mRmBaPP3v+NcdjCtefdQ7xMjEwXiIUYKDWUmEt8Vf
        M1mINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDUxx7vfeJ
        8OmL329LORy07LXImmtv/bN5ubwOvm6SsBOMTxI5Pfle8PFvy9dFa3XEp9rWZacXzrE/K8Vc
        2eRd9SV24tz3oUtaZkrsEP23OTVQ60Reoe+sotqGe6v39TDvMCpZ+Tzp/CJdW/Mg73SG542C
        0u9lMypC7jl65K6fO2GqUtplxxcRM1rZjq7R/it4+Fz8+qsS3hfjfKezn5j1+ee6Cs49Ds7c
        087c286b5pgUek1vRrOrY0fmtF3+ohWNAjbrQs7LlZ1+XBI6bdLk7S7LZ1cckXE9qLJmWsMp
        wctPPvGaX7qwdblUPvensIAsNq2gt6JcN2et2ijgJsP1MJfZevcrhmMNnyoF2X8GKLEUZyQa
        ajEXFScCADjoY4L6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7q7mjWTDeY8E7ZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9JounV2cxWey9pW1x
        edccNov5y56yW0xo+8ps8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHr3N79g8drbeZ/V4v+8qm0ffllWMHptPV3t83iTn0X6gmymAN0rPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv40xvbEG3eEX76++MDYzr
        hLsYOTkkBEwkfr1dytTFyMUhJLCUUaJ7wmNmiISExO2FTYwQtrDEn2tdbBBFzxkl7m26D9TB
        wcEmoCXR2MkOUiMikCtxePMEsEHMAvOYJc59W8QGUiMskCpx6T0HSA2LgKrE/3kTGUHCvAJW
        Epf70yHGy0vMvPQdbAyngLXEnN0tbCC2EFBJx6zNYDavgKDEyZlPWEBsZqD65q2zmScwCsxC
        kpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYARvO/Zz8w7Gea8+6h1iZOJgPMQo
        wcGsJMLb4q+ZLMSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wBSSVxJvaGZgamhiZmlgamlm
        rCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAdDIoOpL5nHzIOYG9sSal38Q6Fs3iuqLuOlel
        U61h8rLZ7bo7z0fdubQ1VypWrM2q7592q5Jogaq0vd9n9jKbz7NW3N9mKnNswlrWtRt1U06c
        qkjwVnfr41010/pUzwXjXv+7wYsX7JASfZXK9n6PTI2A3LncHpEndS8eWNoFL1i7wum5bfqZ
        XMW9Vzaftmk7cXL9xE/z88QjN9R7JfssnHMxIuK31e9zk+KTvSd93Nnp1NB2PjO+5S6ne3FI
        duLKU7q/Hh0KOPkgy+Hn9OJlx7j/t0dvz1+9oCr2j+2GBd+8j6q+f+t2+ZVBQ/muHelhIXM2
        c3I++OWsr7ZeOnrF6br3cnd+9O3b/iT8ZZmWihJLcUaioRZzUXEiAIS4kK5pAwAA
X-CMS-MailID: 20220920091122eucas1p2934bc26b6c11bdbafa7ebd3004ce72ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091122eucas1p2934bc26b6c11bdbafa7ebd3004ce72ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091122eucas1p2934bc26b6c11bdbafa7ebd3004ce72ee
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091122eucas1p2934bc26b6c11bdbafa7ebd3004ce72ee@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
superfluous NULL check for request queue while we are at it.

This commit has no functional change, and it is a prep patch for allowing
zoned devices with non-power-of-2 zone sizes in the block layer.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 43 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6c6bf4dd5709..6cf43f9384cc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
 	return q->mq_ops;
 }
 
+static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
+{
+	return bdev->bd_queue;	/* this is never NULL */
+}
+
 #ifdef CONFIG_PM
 static inline enum rpm_status queue_rpm_status(struct request_queue *q)
 {
@@ -666,6 +671,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
+static inline bool bdev_is_zoned(struct block_device *bdev)
+{
+	return blk_queue_is_zoned(bdev_get_queue(bdev));
+}
+
+static inline sector_t bdev_zone_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!blk_queue_is_zoned(q))
+		return 0;
+	return q->limits.chunk_sectors;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
@@ -892,11 +911,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
 int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 			unsigned int flags);
 
-static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-{
-	return bdev->bd_queue;	/* this is never NULL */
-}
-
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
@@ -1296,25 +1310,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
-static inline bool bdev_is_zoned(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
-}
-
-static inline sector_t bdev_zone_sectors(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!blk_queue_is_zoned(q))
-		return 0;
-	return q->limits.chunk_sectors;
-}
-
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1

