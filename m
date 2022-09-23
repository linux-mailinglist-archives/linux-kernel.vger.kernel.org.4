Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF0D5E80E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiIWRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIWRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:36:29 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76414D327
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173623euoutp0272f5fef14c15b6a1b2e079504b42b9f1~XjeC8KWqs2792727927euoutp02x
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220923173623euoutp0272f5fef14c15b6a1b2e079504b42b9f1~XjeC8KWqs2792727927euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954583;
        bh=v7x+EWE7AU8pVOFbPrGq7P6msqFnukbvssEB0p3yuvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFnvurnr4lidaIhXJBa3jnmsAlfaLFIZfQTx/tr1T0alj4M44JwnrX5CKVZ//Ed0w
         1pdVZG8EIRdIq79vsKwMP4o74ZUZlAuGBr49+RQs+HrOOcbGgJvOXHt7JIKkZQie3B
         OSwYLrSY8BWJVDeEoWdvKuZf6BwaMqru6bYPlZwo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173621eucas1p17d30e53271c0a8d1a6f8cd3aef28ecc2~XjeA48gU12513525135eucas1p1k;
        Fri, 23 Sep 2022 17:36:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.1F.07817.59EED236; Fri, 23
        Sep 2022 18:36:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923173620eucas1p2ba21805261fe5ad86c38c0f52daeaa3a~XjeAXaocG2090220902eucas1p2f;
        Fri, 23 Sep 2022 17:36:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220923173620eusmtrp2d1dfa588e7f09e828991d9b888e7353a~XjeAWS-Vr1023410234eusmtrp23;
        Fri, 23 Sep 2022 17:36:20 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-29-632dee952942
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.5F.10862.49EED236; Fri, 23
        Sep 2022 18:36:20 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173620eusmtip23695d8acf12f1f42b8f948364ae14283~Xjd-_-sLF2221022210eusmtip2b;
        Fri, 23 Sep 2022 17:36:20 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Date:   Fri, 23 Sep 2022 19:36:06 +0200
Message-Id: <20220923173618.6899-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djP87pT3+kmG0z8K2Ex/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZPL06i8li
        7y1ti8u75rBZzF/2lN1iQttXZosbE54yWnxe2sJusebmUxaLE7ekHUQ8Ll/x9tg56y67x+Wz
        pR6bVnWyeWxeUu+x+2YDm0dv8zs2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4I3i
        sklJzcksSy3St0vgyjh98yNLwVHRioWPV7A2MDYIdTFyckgImEjseH6drYuRi0NIYAWjxK2P
        c1khnC+MEt/Xb2WEcD4zSsw9uY0NpmXp7X0sEInljBLv/11lgnBeMkr8nbgYqJ+Dg01AS6Kx
        kx2kQUQgXeL41pvsIDXMAo+YJbbd+c0EkhAWSJJY+76NEcRmEVCVWPaljRnE5hWwkHj06iPU
        NnmJmZe+s4PM5BSwlOhvrIEoEZQ4OfMJC4jNDFTSvHU2M8h8CYFznBJzpzUwg9RLCLhIXO4o
        gxgjLPHq+BZ2CFtG4v/O+UwQdrXE0xu/oXpbGCX6d65ng+i1lug7kwNiMgtoSqzfpQ9R7iix
        Yns3I0QFn8SNt4IQF/BJTNo2HWopr0RHGzRwlSR2/nwCtVRC4nLTHBaIEg+JnWsDJzAqzkLy
        yiwkr8xCWLuAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYKI8/e/4lx2My1991DvE
        yMTBeIhRgoNZSYQ35aJushBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFethlayUIC6YklqdmpqQWp
        RTBZJg5OqQamous8yazrJ6gnb2xx3RDm6bbPxzaiqEjqLcuG9sP2da52K04t/rjBsaKj+cHU
        ELXiJ1GODCbz7c8dfJrdVWbj++riN4V5ZtNj7F884Xr3V/j1/5K850m7w66IPm7+s6S3fKu0
        LWdxnWfUg64lHc+sH/+eqct8Y7qTCv/Rb6JbM5Ub51r/keQRSNhlqr/O2Dw2odY14PCiV6su
        XD41Qch566WZEkrOMdbvJOODXvlzXe78max2jz+Dc8HMk5M27y9e7OGxumnDws0v5B8Uvb7G
        nDCxNp7n899/O+9tLrunE7RjoZSI5c2LJddnc3FslNNLrdjBxXjQMHde9m2lGJmUXD09q909
        i1TX3Xe9+bBaiaU4I9FQi7moOBEAcv0nEQMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7pT3ukmG2z7b2gx/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZPL06i8li
        7y1ti8u75rBZzF/2lN1iQttXZosbE54yWnxe2sJusebmUxaLE7ekHUQ8Ll/x9tg56y67x+Wz
        pR6bVnWyeWxeUu+x+2YDm0dv8zs2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4I3S
        synKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzh98yNL
        wVHRioWPV7A2MDYIdTFyckgImEgsvb2PpYuRi0NIYCmjRPOqFjaIhITE7YVNjBC2sMSfa11s
        EEXPGSX2HPrF2sXIwcEmoCXR2MkOUiMikCtxbO09VpAaZoEvzBK7L21hBUkICyRI3Pi7lxnE
        ZhFQlVj2pQ3M5hWwkHj06iPUMnmJmZe+s4PM5BSwlOhvrAEJCwGVnF/8iB2iXFDi5MwnLCA2
        M1B589bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMK63Hfu5ZQfj
        ylcf9Q4xMnEwHmKU4GBWEuFNuaibLMSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wMSSVxJv
        aGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXApGBVE9AbM7VIKufo1csf
        Lp6JE9ZflLIvyOGewGoJKXuZWy+uJ//t1MhwW+zUwnZ4oW573X2v76fTZJ8YzVv4e1vCjWh/
        p9NBD6TPLHZ1v6Gxi71wd9kMJ4NI1pZGv8npDoIx34uSGIv0vvj+1MpmU72lnPFVuFLt7Z/8
        R3N1v6btjfJba7Iwv3S1l+Lcn5FrxVLk93hnmDgVa/w5ZZaQNyf6IvfE4LufdNVfss8veKHW
        NsnkW3rNW+mejMmrLwSe3H1d8D+bxJ+J3bet1bdvjNkhNEGns/6QQ4d8ZfmB2ao256aVF+d4
        JF88I274TqBiz3KTuoOS4ifYq7bxvWB85iDx89uyhI3HGfNmCgcosRRnJBpqMRcVJwIAhzAU
        vXQDAAA=
X-CMS-MailID: 20220923173620eucas1p2ba21805261fe5ad86c38c0f52daeaa3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173620eucas1p2ba21805261fe5ad86c38c0f52daeaa3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173620eucas1p2ba21805261fe5ad86c38c0f52daeaa3a
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173620eucas1p2ba21805261fe5ad86c38c0f52daeaa3a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

