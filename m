Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F25BE1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiITJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiITJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:48 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645A561D71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091135euoutp010aac89d9bc500ce566d53a9ce22e70a3~WhpcUbxiq1026310263euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220920091135euoutp010aac89d9bc500ce566d53a9ce22e70a3~WhpcUbxiq1026310263euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665095;
        bh=WU1oSYYifuddX9yyjx4QFQJb3f/txF5tBxB5+RepGko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT/R/vPkgsgLP1yhxWiayeCp2EqGA7axBQqWkCLJVdc1heEEWDUSVZv1nEY+9uhVp
         rlr6ojgNcAzV1Z6WXLxLAR0AqfcODWIQvsY9YfgG0YoCzec0Ced5Ocvpl+rIYexOPe
         mta2gSYUNf6y4L27h17LRHPQ2fRQH0GPbZd47ILA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091133eucas1p2c4ffaf50753e9ec7145a62405cfa23a6~Whpakuw_Y0517105171eucas1p2x;
        Tue, 20 Sep 2022 09:11:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 01.8E.07817.5C389236; Tue, 20
        Sep 2022 10:11:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220920091133eucas1p1ce01c88d47ce934b2995bea6a6bc55df~WhpZ2Bov12880428804eucas1p11;
        Tue, 20 Sep 2022 09:11:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091133eusmtrp1131e24aecc587efb26f7d3c70f606bbf~WhpZ1MDPb0212802128eusmtrp18;
        Tue, 20 Sep 2022 09:11:33 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-33-632983c5040c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.53.10862.5C389236; Tue, 20
        Sep 2022 10:11:33 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091132eusmtip25851d6192aac89607d2eee7bdc5fb02c~WhpZg0twE2175621756eusmtip2g;
        Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v14 12/13] dm: introduce DM_EMULATED_ZONES target feature
 flag
Date:   Tue, 20 Sep 2022 11:11:18 +0200
Message-Id: <20220920091119.115879-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87pHmzWTDda3GlusP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
        5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRXDYpqTmZZalF+nYJXBm/rj5gLjgl
        VvF/fRtzA+NfoS5GTg4JAROJA919LF2MXBxCAisYJdZd6oRyvjBKLDv2iBHC+cwo8fXBZHaY
        lgvNX5lBbCGB5YwSD07ZQhS9ZJT4sW4bUAcHB5uAlkRjJ1i9iEC6xNevG8AGMQtsY5KYPmUR
        WLOwQIDEzXnb2EBsFgFViRnn94LFeQWsJa5e+McKsUxeYual72CDOIHic3a3sEHUCEqcnPmE
        BcRmBqpp3jqbGaJ+NafE2vkyELaLxOlTr6DmCEu8Or4F6gEZidOTe1gg7GqJpzd+M4McJyHQ
        wijRv3M9G8gDEkDL+s7kgJjMApoS63fpQ0QdJU7PzIcw+SRuvBWEOIBPYtK26cwQYV6JjjZo
        2CpJ7Pz5BGqnhMTlpjlQOz0kJi1YxDaBUXEWkldmIXllFsLaBYzMqxjFU0uLc9NTi43yUsv1
        ihNzi0vz0vWS83M3MQJT4Ol/x7/sYFz+6qPeIUYmDsZDjBIczEoivC3+mslCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamIwbFEKnbJ94Y/fGlW0Nvad1
        2jy2LV2o2PvJ61WKmopH36Vzp4QPCW+WWhw3KXORuMOfFSo7Lq1896N6+7rcp/+3hix4+UEl
        l3ODSetB7YWHWhLetauxTQnkdP8plZvj3dE54fakmx9f+b7kUeSd/k7N/sRFtRk/+351nt18
        c/29jb5LLdgaGG1mfr7xYMUC/nU+6qwbpy4SfnYmS/WzwP67rK/ZdW+15c+U7lj641+KfcSD
        FQr+GXxuk26519i/epq0q/ZAjEGcknbjOTu/wul3CvRbbh4w9e1/fmRT2Z7ZSRN/v7dJlEjq
        iVUqSVt4MmrPsbxipdhfypVMfzxPnIw3uLi9szL08imG/k/fXTYqsRRnJBpqMRcVJwIA71y7
        8/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7pHmzWTDb5/Y7ZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+XX3AXHBKrOL/+jbmBsa/Ql2MnBwSAiYS
        F5q/MncxcnEICSxllJj09RwLREJC4vbCJkYIW1jiz7UuNoii54wSLWveADkcHGwCWhKNnewg
        NSICuRKHN09gArGZBY4wSSyeGgNiCwv4SVxeeIMZxGYRUJWYcX4vmM0rYC1x9cI/Voj58hIz
        L30Hm8MJFJ+zu4UNxBYSsJLomLWZDaJeUOLkzCcsEPPlJZq3zmaewCgwC0lqFpLUAkamVYwi
        qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIERu+3Yzy07GFe++qh3iJGJg/EQowQHs5IIb4u/ZrIQ
        b0piZVVqUX58UWlOavEhRlOguycyS4km5wNTRl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6
        YklqdmpqQWoRTB8TB6dUA1Orqsvx6FVxMnc8XuTk8qpVJpyc0RS1rzyMR3TH/KP9bWEfPh6I
        mP7B+p59RvOFfdubAhX39lgf/Rx1NoTzxb3sJckVqyp9NAPlJ9jzvfv3+djD10auX1iW30k3
        +sG25o+Y225Bhb1/2QyPuDZ5PivfYJaqdzw1rDFrz2clbwYPQwbtsM/zT3MLbGBe8/Uyi4Oi
        RMyx+ZzqZZPn2nDf+yP34mXDmStFzu4xHZ73XYMrztydwnNAxrRWTDY/epma1te/XyNFN8e3
        K82fOVH7+UbODoWDbdu4VXXSbV/J3tj/9Yqiz8ofWRvsNXZs43W6cTQh+GrZnfgNEVd8Hnb7
        sb5Zw5HNXul/LWmDxjztYiWW4oxEQy3mouJEAB5D57xhAwAA
X-CMS-MailID: 20220920091133eucas1p1ce01c88d47ce934b2995bea6a6bc55df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091133eucas1p1ce01c88d47ce934b2995bea6a6bc55df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091133eucas1p1ce01c88d47ce934b2995bea6a6bc55df
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091133eucas1p1ce01c88d47ce934b2995bea6a6bc55df@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new target feature flag: DM_EMULATED_ZONES for targets with
a different number of sectors per zone (aka zone size) than the underlying
device zone size.

This target feature flag is introduced as the existing zoned targets assume
that the target and the underlying device have the same zone size.
The new target: dm-po2zoned will use this new target feature flag
as it emulates the zone boundary that is different from the underlying
zoned device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-table.c         | 13 ++++++++++---
 include/linux/device-mapper.h |  9 +++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 38b83c383e8f..8324bd660f09 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1619,13 +1619,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
 	return true;
 }
 
-static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
+/*
+ * Callback function to check for device zone sector across devices. If the
+ * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
+ * should have the same zone sector as the underlying devices.
+ */
+static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
 					   sector_t start, sector_t len, void *data)
 {
 	unsigned int *zone_sectors = data;
 
-	if (!bdev_is_zoned(dev->bdev))
+	if (!bdev_is_zoned(dev->bdev) ||
+	    dm_target_supports_emulated_zones(ti->type))
 		return 0;
+
 	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
 }
 
@@ -1650,7 +1657,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 	if (!zone_sectors)
 		return -EINVAL;
 
-	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
+	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
 		DMERR("%s: zone sectors is not consistent across all zoned devices",
 		      dm_device_name(t->md));
 		return -EINVAL;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index f8e3a96b97b0..8504da98e829 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -294,6 +294,15 @@ struct target_type {
 #define dm_target_supports_mixed_zoned_model(type) (false)
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
+#define DM_TARGET_EMULATED_ZONES	0x00000400
+#define dm_target_supports_emulated_zones(type) \
+	((type)->features & DM_TARGET_EMULATED_ZONES)
+#else
+#define DM_TARGET_EMULATED_ZONES	0x00000000
+#define dm_target_supports_emulated_zones(type) (false)
+#endif
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
-- 
2.25.1

