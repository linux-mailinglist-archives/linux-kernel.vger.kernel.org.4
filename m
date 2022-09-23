Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A65E80F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiIWRhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiIWRgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:36:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62415222F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:34 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173633euoutp02c3003de79d80692a99ecbfef1dc4922c~XjeL8TMFi2792727927euoutp02A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220923173633euoutp02c3003de79d80692a99ecbfef1dc4922c~XjeL8TMFi2792727927euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954593;
        bh=mYF3BflLJSX6KlMqYwCikWQ6QWnNIFxRzvAPPTHfZ4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuQrzx4sIW4o+NBRCp86K6arW0t0JQgqeMAGt9Cti/XKmgp8BMtRw08snkw8yp38f
         mNee7EYxfela7GPPrfO+TZ45+lKHLIt/zReuNkPu/nAAhC34v3Y2hi71KghH0ZRKwD
         +HjNMKD0vXt4Rn7k73yRfdvsr90hCYrhAp36adzE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220923173631eucas1p270e18bb3079ae98a1dabe39d5c523112~XjeJ3s-8e2090220902eucas1p2j;
        Fri, 23 Sep 2022 17:36:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8A.97.19378.E9EED236; Fri, 23
        Sep 2022 18:36:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923173630eucas1p2bae6918f0c165051464e62c5172a80e0~XjeJaXYe12090620906eucas1p2q;
        Fri, 23 Sep 2022 17:36:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220923173630eusmtrp237cccf5026ff5eaef52d2f5f142c38f2~XjeJZrk661023410234eusmtrp2_;
        Fri, 23 Sep 2022 17:36:30 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-c0-632dee9e0e20
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.5F.10862.E9EED236; Fri, 23
        Sep 2022 18:36:30 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173630eusmtip22323d39c07b74819b2046f769f84a3ef~XjeJFAcbY2300023000eusmtip2l;
        Fri, 23 Sep 2022 17:36:30 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Fri, 23 Sep 2022 19:36:15 +0200
Message-Id: <20220923173618.6899-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87rz3ukmG6xcZmOx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGV8WP6XrWAN
        X8X8DxcYGxgvcXcxcnJICJhI9J9+wdrFyMUhJLCCUeLY9pdsEM4XRomHy6dDOZ8ZJSZNvsYM
        07Lr9QJ2iMRyRon2zdcYIZyXjBIbzk4GynBwsAloSTR2soM0iAikSxzfehOsgVngJZPEg9N3
        WUASwgKREo8eXACbyiKgKrGou5EJpJdXwFJi8m5HiGXyEjMvfQcbyQkU7m+sAQnzCghKnJz5
        BGwKM1BJ89bZzCDjJQQ2c0rc/HyPBaLXReL3nLtQRwtLvDq+hR3ClpH4v3M+E4RdLfH0xm+o
        5hZGif6d69lAlkkIWEv0nckBMZkFNCXW79KHKHeU2POtlRWigk/ixltBiBP4JCZtm84MEeaV
        6GgTgqhWktj58wnUUgmJy01zoA7zkNi7/iPLBEbFWUiemYXkmVkIexcwMq9iFE8tLc5NTy02
        zkst1ytOzC0uzUvXS87P3cQITIKn/x3/uoNxxauPeocYmTgYDzFKcDArifCmXNRNFuJNSays
        Si3Kjy8qzUktPsQozcGiJM7LNkMrWUggPbEkNTs1tSC1CCbLxMEp1cC0rK30/gwXTonKFr3/
        tjs0du+6oncv9j/zRQXNo21zGa0Yd4ml5f86brWttOGw3LLlG5oeJznn/vZs36G2tp3x4Wnj
        G0rfouff4r7Q7py7yq70V7Ot9/OQzW8+qqfzND0KN1sjV7DIM1c/98KnPc/27b5y8UbrrVVV
        G3LfWoda21SuPup6VmO+foPe1K8XLx+f5Fl93Z7RUePYwwWuq9ecOGb+Wl63a8syzY/KQo0N
        um2Tg72PCL+akvO8ZfpJdu0Koaagd22CRoqteuafDTbsXNrycJLPJC9Pk19b/f2PZ/GE6nZe
        6NjG3vQ2WH1HeNVhv3VbEhkTv7o6lp98FhB5XKJh+eRZ2/j+ZE1e53JBiaU4I9FQi7moOBEA
        wEKFZvEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7rz3ukmG7TvVbJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI+LP/LVrCGr2L+hwuMDYyXuLsYOTkkBEwk
        dr1ewN7FyMUhJLCUUWLK/3/MEAkJidsLmxghbGGJP9e62CCKnjNKXDy9DMjh4GAT0JJo7GQH
        qRERyJU4tvYeK0gNs8B3JomrzVfZQWqEBcIlts4wAalhEVCVWNTdyAQS5hWwlJi82xFivLzE
        zEvfwao5gcL9jTUgYSEBC4nzix+BTecVEJQ4OfMJC4jNDFTevHU28wRGgVlIUrOQpBYwMq1i
        FEktLc5Nzy020itOzC0uzUvXS87P3cQIjNZtx35u2cG48tVHvUOMTByMhxglOJiVRHhTLuom
        C/GmJFZWpRblxxeV5qQWH2I0Bbp6IrOUaHI+MF3klcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUw+SzfFNuwhLX13NGVG56JCEf5Bm+2673H7fouS3POXOsZCSwL
        VbMnhF8y+3tsPmuAzsNX1uv6u2znpid/6Fbbd/dvut/hnOq7Boz/Jj/e0xtq97HfvXDn2cnP
        zzHufsnw5Jfnjrip8pF9/47PvMXG4zOv6ch6ji1z8+pXPzPkfRkzZX/OVLeHrtyMlq++lyX+
        izwfkbUrwWCbxb+SOaE/zEXOBd38e/zp8dsts7dNYPs43UlNN/jTzw+/I4x3fDmtXC+UdPKU
        WkHHs6TDfycUyya+OOoaamG848ivKy47D8kflLHoKhBoy/F/77lgG2/XgkcTjk7k2m6lsik1
        LIdpzbepPBUtLz7zvLPdtbrsBocSS3FGoqEWc1FxIgDY+CU0XwMAAA==
X-CMS-MailID: 20220923173630eucas1p2bae6918f0c165051464e62c5172a80e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173630eucas1p2bae6918f0c165051464e62c5172a80e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173630eucas1p2bae6918f0c165051464e62c5172a80e0
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173630eucas1p2bae6918f0c165051464e62c5172a80e0@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
the block layer now supports it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e42016359a77..38b83c383e8f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, start)) {
 			DMERR("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			      dm_device_name(ti->table->md),
 			      (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, len)) {
 			DMERR("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			      dm_device_name(ti->table->md),
 			      (unsigned long long)len,
@@ -1647,8 +1647,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1

