Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8845BE197
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiITJLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiITJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:30 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21CD5E31C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091123euoutp016e35022a0abdb023f48e8a067e81e646~WhpRFlKma1166211662euoutp01m
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220920091123euoutp016e35022a0abdb023f48e8a067e81e646~WhpRFlKma1166211662euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665083;
        bh=v7x+EWE7AU8pVOFbPrGq7P6msqFnukbvssEB0p3yuvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUpMGbyi2ZVydLLgdg6ymZwkDPlRrA1SAEuKGYCW1wfCkFgH089sutlNkM+1xD10v
         PSakf7P8ByZet1Ei+BijwC0QzpuTiJqg06yJAt/qUFOzbbdOyPM5JVZR7ymSe5b8OY
         LRvsTdajZXLYEvE50zALU7Jg3KE4OblWLWIq+AYQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220920091121eucas1p103009200aafc074a4cce236c7c679199~WhpPPo5Zi2943429434eucas1p1i;
        Tue, 20 Sep 2022 09:11:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B5.7E.07817.9B389236; Tue, 20
        Sep 2022 10:11:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220920091121eucas1p26eed14714ff34e2489bc9adb40fd1250~WhpO06NM21326413264eucas1p2F;
        Tue, 20 Sep 2022 09:11:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091121eusmtrp1c83228127090016395d1eae78540352c~WhpOz-7Oe0149701497eusmtrp1b;
        Tue, 20 Sep 2022 09:11:21 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-0c-632983b91a15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.43.10862.9B389236; Tue, 20
        Sep 2022 10:11:21 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091120eusmtip15e511ee5d7f407eefa560381f7bf2446~WhpOe4QOy1211712117eusmtip1i;
        Tue, 20 Sep 2022 09:11:20 +0000 (GMT)
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
        Adam Manzanares <a.manzanares@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Date:   Tue, 20 Sep 2022 11:11:07 +0200
Message-Id: <20220920091119.115879-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SYUwTZxj2u7ter93KzgLxi25s1BgDc9Uxf3xBFAxuHvJj08XF+KPsKDfE
        Aboenc7+GNCKUCaiLFYKDsSNQt0Gax2zFkxTUlGrIbOyUCpjk9apyboRWqAyzWyPZf573/d5
        nvd5ny8fhctnRCupssoqTlPJlitIKTFwNTb6hkOfod5gs2ci03A66rtxFUcXJk+Q6PTfMRwt
        3hrF0VC4TYT8LgeGBrtOYaj3ggdDwT4zjp4Yf8VQaMyMoaGJ15HvcjuJOrpDYtRcF8XReHMI
        oNlvDGL0rT9EoGsTq/JSGN+dQsZhnhQzvltaxmZtIBn7158zTn81yRzXh0nGcXRKxPx1ZYxk
        mi5aAWP36phZWxpzzNWIvSfbK80p4crLPuU067d8KN3n9c8QBz2ph89N94iqQbXcCCgK0huh
        zfiSEUgpOd0D4N0nEZHQRACs+aWGFJpZAO1zXxJGIEkoOkZ8mABYANQvLOBxQE4/BHB4bF18
        LUlnwpoGcXycQpfCaLQfxPk4HcThlGUSiwPJdDE843QmlhL0GtjyszUhkNHZ8MGdY0AwexW2
        3p5PzCX0JtjuNJACZzm83hpMaPFnHP2PbXjcANI3JHC6RzgI0tvgoieACXUyfDRyUSzUL0Nv
        yxdLaXQwNL64JDYAeMLRRwoPswk23SyPlzidAfsurxfoW2Fosh4TGElw/M/lwglJ8NSACRfG
        MlhfJxfYCuiIBZdMIfTVti+ZMvDB3ad4M0g3PxfG/FwY8/++nQC3ghWclq8o5fisSu6Qkmcr
        eG1lqVJ9oMIGnv1K79ORyCVgeTSjdAOMAm4AKVyRIjO8m6GWy0rYz45wmgNFGm05x7vBKopQ
        rJCpy/pZOV3KVnEfc9xBTvMfilGSldXYnvHWjXmD6Mz+wVRy2dtop9y01qB7XBjklWztjvm3
        VH5Lka7GfX9XgaTTMmrd0Jt/iFX+4ArMa/v3Zw9Zknaz6rPfnaSzi7MKXlut2kFEU9OYV5bt
        eqFLceToJ3UerXMheD/3n47+rN9U3+f/7ry3d862oMxZezpX5MSlbtb3jukjhabQNdMytT06
        cDuneXW3ize2ndvWEDNNv3i4YS57dI02efuegisqSZVJZf9DEbgeILXhSF5j5+N1bn1aVyi/
        fWDzxGbeEbiWYizOOZ6u+qC+tzZ8D4R/KtSdt9APv9LzkeLGrbk3i2Ld7xMn80tiW0LTw7ub
        itTeSwadR0Hw+9g3M3ENz/4Li2TSMQQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7o7mzWTDXZ+57GYfljRYv2pY8wW
        q+/2s1lM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZPFk/Sxmi79d95gsnl6dxWSx
        95a2xeVdc9gs5i97ym4xoe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDiIel694e+ycdZfd4/LZ
        Uo9NqzrZPDYvqffYfbOBzaO3+R2bx87W+6we7/ddZfPo27KK0WPz6WqPz5vkPNoPdDMF8Ebp
        2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZZy++ZGl
        4KhoxcLHK1gbGBuEuhg5OSQETCTmH7/M1MXIxSEksJRRom3fbiaIhITE7YVNjBC2sMSfa11s
        EEXPGSXuPvoKVMTBwSagJdHYyQ5SIyKQK3F48wSwXmaBL8wSL9sDQWxhgQSJd8ebWEFsFgFV
        ickXV4HV8wpYSby40g41X15i5qXvYHFOAWuJObtb2EBsIaCajlmb2SDqBSVOznzCAjFfXqJ5
        62zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREY19uO/dyyg3Hlq496
        hxiZOBgPMUpwMCuJ8Lb4ayYL8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4wseSVxBuaGZga
        mphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAZnhBZHDivft6hY/Irq5n7+G2m
        uaZUah6YbJcg9tvfdtnUdTI+Ci091YZsz/YfYLvhuSvw0lPth/stcveY6uySni50Ny7h3rnX
        syeYPDy/3tzOU7jl8KmiynT9H4mOPRx2NzjCUgo/r8sV76xfpWw381dqQcYNI0dHOYfgqf+7
        2LdVNwjM/Ll7z52KtocXUnRsN/7YW/DRaeb/9l8as/gsHpycvHGWtLCgxKyLNmdYHMM6Bbd9
        Of3M+NwureerS89dsDyx55zw5fdLWr27ZK8VGqw+ceCzsfGPA/w2vxjv8ofrVjJo7lbT1GRq
        8F8w3/TL2q3H1/zYI2LgK6A32f7DZ6uZJ7+GyuQHct2+8n63EktxRqKhFnNRcSIAXeSXOHQD
        AAA=
X-CMS-MailID: 20220920091121eucas1p26eed14714ff34e2489bc9adb40fd1250
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091121eucas1p26eed14714ff34e2489bc9adb40fd1250
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091121eucas1p26eed14714ff34e2489bc9adb40fd1250
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091121eucas1p26eed14714ff34e2489bc9adb40fd1250@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt bdev_nr_zones and disk_zone_no functions so that they can
also work for non-power-of-2 zone sizes.

As the existing deployments assume that a device zone size is a power of
2 number of sectors, power-of-2 optimized calculation is used for those
devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 13 +++++++++----
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a264621d4905..dce9c95b4bcd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,17 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * bdev_nr_zones - Get number of zones
  * @bdev:	Target device
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int bdev_nr_zones(struct block_device *bdev)
 {
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	sector_t capacity = bdev_nr_sectors(bdev);
 
 	if (!bdev_is_zoned(bdev))
 		return 0;
-	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
-		ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(bdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8038c5fbde40..6c6bf4dd5709 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -674,9 +674,15 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
 
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return sector >> ilog2(disk->queue->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-- 
2.25.1

