Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B325B5614
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiILIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiILIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D12F646
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082228euoutp02cc106594b957b9cce897f0b4433d5beb~UD0Rl25CA2459324593euoutp02F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220912082228euoutp02cc106594b957b9cce897f0b4433d5beb~UD0Rl25CA2459324593euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970948;
        bh=TpfC5qsHCn42VD0VfMrShkUip45l4QnJQo5SdQLOwtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZPoYBx2dKfdCinH2zMCwcqWzTFokBq8qrH9UUQBXq4wUNW8Kf0Xuuf92lC0AkldG
         T5CTEw7JiJnxKb99dRwV+ptMlCvxVKtVziDnZkUNktSOj0AfFqJEFaccF187RyLCt+
         92x007/LPdEoUwNUc/lZFQ9PwuBMxBcFeRn6Vag8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082217eucas1p2f7bf2d8409887d0b45bb91d5e0838a8b~UD0HPCGjb2080820808eucas1p2G;
        Mon, 12 Sep 2022 08:22:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.A3.19378.93CEE136; Mon, 12
        Sep 2022 09:22:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220912082217eucas1p15e4ba29d1438990db4acf5c3f6ca5d4f~UD0Gx0szG1088110881eucas1p1_;
        Mon, 12 Sep 2022 08:22:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220912082217eusmtrp2054a1249e949edbdccfec0c6c6024005~UD0Gw9xSo3116631166eusmtrp2M;
        Mon, 12 Sep 2022 08:22:17 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-6b-631eec39b733
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.43.10862.93CEE136; Mon, 12
        Sep 2022 09:22:17 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082216eusmtip12dbcb83e6c6a0b4a645929a361eb1f31~UD0GZZdty0898808988eusmtip1i;
        Mon, 12 Sep 2022 08:22:16 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        linux-nvme@lists.infradead.org, pankydev8@gmail.com,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org,
        bvanassche@acm.org, gost.dev@samsung.com, dm-devel@redhat.com,
        hare@suse.de, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v13 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Mon, 12 Sep 2022 10:22:01 +0200
Message-Id: <20220912082204.51189-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87qWb+SSDXbfULVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDIevLnKUvCO
        t2LP7CamBsaZ3F2MnBwSAiYSq5YuZe5i5OIQEljBKPHv9ldGCOcLo8T9eYdYQKqEBD4zSkxf
        5QjTcWv7RiaIouWMEl93NrNDOC8ZJT682QTUwcHBJqAl0djJDtIgIpAu8X36O7AGZoFtTBL3
        H75gBkkIC0RKTPvbwARiswioSsyb3swIYvMKWEk8OryVGWKbvMTMS9/BBnECxV+vaoWqEZQ4
        OfMJ2HXMQDXNW2dD1W/mlHg7RQjCdpHo7jvHBGELS7w6voUdwpaR+L9zPlS8WuLpjd9g/0sI
        tDBK9O9czwbygISAtUTfmRwQk1lAU2L9Ln2IckeJ13enM0FU8EnceCsIcQGfxKRt05khwrwS
        HW1QByhJ7Pz5BGqphMTlpjksELaHxO21b9knMCrOQvLLLCS/zELYu4CReRWjeGppcW56arFx
        Xmq5XnFibnFpXrpecn7uJkZgEjz97/jXHYwrXn3UO8TIxMF4iFGCg1lJhJfFUDpZiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA5PeA77TFkoSQvp2pZH6
        b49wfVVeGLD+9rRTLWvDj3C8YFcrK678JbXmXcPNCkO2Wb43eZbqvxD/GT9HPmHd5QOfv4dH
        XC294sVq8u+391n398Zic/RuvSgPlV1zJOzzCTtVju6lsx823Mts1nGQn7Pmz6y6KX6/Dy+a
        vpPNM7BG98SuhxcOpHxiY97gfcn/4c8mGVlHweDXLxeV/Eh+XGBtXXw42Pif+s4TC1042TND
        7ZSVv26dKiLHl7HuwQvN6Uz5G8o1zSZ3pit/W/T0EPv28tcnZbqLDivFzDSTmFVrI9v/jIcx
        0F39odbpN0fPzumy/nlop5jU/flBj57v/7TEZIUtd/nO67eyGlIvTbBUYinOSDTUYi4qTgQA
        DhdU2/EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7qWb+SSDea8YrNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIevLnKUvCOt2LP7CamBsaZ3F2MnBwSAiYS
        t7ZvZOpi5OIQEljKKDH/yz8WiISExO2FTYwQtrDEn2tdbCC2kMBzRonjt6u7GDk42AS0JBo7
        2UHCIgK5Ep9X/mADmcMscIRJ4u+rFcwgCWGBcInb6w+D2SwCqhLzpjeDzeQVsJJ4dHgrM8R8
        eYmZl76DDeIEir9e1coIsctS4uy3G+wQ9YISJ2c+AbuNGai+eets5gmMArOQpGYhSS1gZFrF
        KJJaWpybnltspFecmFtcmpeul5yfu4kRGLHbjv3csoNx5auPeocYmTgYDzFKcDArifCyGEon
        C/GmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+MGXklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUw7cmqNvL9e3jp6Sfnexp9apbMenLnXMI+mbK3XsvmsuU/DfsX
        MUXB/Sf3EnatbOUzgryLme8v5n2/1GWOF+vuJ6Gpf34svCrVs9LQIYy3UPbcnZMzMrfP13oc
        4qfapeomteDY586pC5q7ZV/ufrbbJSKwWfBtgdGcBTdOWkifmaWjfeL/5aj8Y1cN82Y63ec7
        eLFl5tw90w/sv6v/b93U75rH/3atE/5jE/9Tqundg43fkh4/V5wqVqxTt9T+80INja9eS+z3
        Hmm/GvLw/TXRzOO8JtdTORqXbX0seX1lZk+1fsWfQ4KlZYI1mfyJAWtPc516f9HM4vnNHZn1
        PCmu+2ed2fbx2p8I1oIr93dru79UYinOSDTUYi4qTgQAPQVwpmEDAAA=
X-CMS-MailID: 20220912082217eucas1p15e4ba29d1438990db4acf5c3f6ca5d4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082217eucas1p15e4ba29d1438990db4acf5c3f6ca5d4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082217eucas1p15e4ba29d1438990db4acf5c3f6ca5d4f
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082217eucas1p15e4ba29d1438990db4acf5c3f6ca5d4f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

