Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DF5E80F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiIWRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiIWRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:37:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCFC153A40
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173635euoutp016125189819c1b20d94e73b905c09e7fb~XjeOJU_Hz0810708107euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923173635euoutp016125189819c1b20d94e73b905c09e7fb~XjeOJU_Hz0810708107euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954595;
        bh=WU1oSYYifuddX9yyjx4QFQJb3f/txF5tBxB5+RepGko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dG14cCngW8i+T7xaFBtMjfsbBsepQOsGKy8TBEfBO1tvCVFxDvhjOwYRjfIZHjTMe
         bSskj1PB1FEn2lqwO2SLocw3avHJIsdQx0QPZBTwac3jRwep/ygAClx5mggZg1Xz8R
         f6aAjrm3GPSq279AH+VJOodgQNswssLUM8XmM/Ns=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173634eucas1p15d0c1608b4c0efd95f989e325a915af0~XjeM1-aSI2513525135eucas1p1r;
        Fri, 23 Sep 2022 17:36:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.6E.29727.2AEED236; Fri, 23
        Sep 2022 18:36:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923173632eucas1p1a4b8cba427f5caf649009073233f8c76~XjeLimBqq2513525135eucas1p1q;
        Fri, 23 Sep 2022 17:36:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923173632eusmtrp13854486833f22d618200f13baf4c2cd5~XjeLh37De1032310323eusmtrp1d;
        Fri, 23 Sep 2022 17:36:32 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-39-632deea2fe1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.78.07473.0AEED236; Fri, 23
        Sep 2022 18:36:32 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173632eusmtip211f1590d2e57e40d00dcceafdff445f6~XjeLM6tMh2300023000eusmtip2m;
        Fri, 23 Sep 2022 17:36:32 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v15 12/13] dm: introduce DM_EMULATED_ZONES target feature
 flag
Date:   Fri, 23 Sep 2022 19:36:17 +0200
Message-Id: <20220923173618.6899-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxjNfbf0Pao1rwXlBjZ1zZbNGlDTLXtmzK0bi88tmbC4P6aL0rQv
        gGuLebUTdHPoGJudCgFFWnUah8WWkSatAkWrTY1tAdFoLaHyu5ZAWURn1yzMAePxWOZ/5zvf
        Od/5vptLQGl/SiZRot/LsHqVViYUCVr903eyL0xlq9ebL5KUo8sPqebBaiFV/3QaUs977kLK
        M3U6hYp43Rh17UItRtmab2FUzGGB1IxpCKM8D9dSoY4zQuqcdQynaqqSkEpcrMSp3yJjAir4
        MOt9CR168AnttgzidKjHSDvtR4S0q/E7+mqkQki7fxhOoZ9cDwvp45ftgHZ1H6ATzpX0j96f
        sfyl20W5GkZb8jXDrttUKCr+OzwC93StKJtzVMEKMCM1AYJA5JtoqGa3CYgIKXkJIH98AvLF
        nwD1VB8GJpA6XyQAehaUcJgzjEejGC9qAujJIwvkRXGABp6u4qYKSTk6dATn6HSyCAWuRHBO
        D8lWDFWZ3QKukUbmozrfwEKAgHwN3bDehZxXTG5Eo64lfNYqZL7/F87RqfN09aFvOFpMSlCn
        ObYwBc5Lvr9yemFnRDpS0U2PE+O9eciXOAF4nIYmA5dxHr+EuuuOCnh8AI31PV80VwJU7XYI
        +Vd5Bx2/reUgJNcgR8c6Xq5E8X+CGK9YhvoeS/gVlqHa1lOQp8Xopyopr5Yh93RsMRSh0OEz
        i6E06h3tBzXgFcsLx1heOMbyf+55AO0ggzEadEWMYYOe2ZdjUOkMRn1RjrpU5wTz/697NvCs
        HZyd/CPHBzAC+AAioCxdrLmXrZaKNary/Qxbuos1ahmDD2QRAlmGWNggV0vJItVe5iuG2cOw
        /3UxIjWzArPoT1kVO77tvX2j5zOb7eTnU72e8daymY/v7wisVuV88G5By+tJrE3rqls/NNK8
        NNkuz2//dVL5yC/PDA5Hx28yJWz67i/f2rxP1jWRa49GZkuHjykGO+dqP5w56FzeONd0KaMt
        t+OLJdvrt06fAyA9YcPPV86qw9YHmvhI24nCky97P5ImC6+ZjNtqvE3Drk/LJeHHZZpdv3sV
        oq2s5mD5yuz9TPJVZZqCCDesWbuFMd3bpsP63IG8+omjWXlvl29WVL7XMNBfXMZODCk7PcrR
        RF80ris4Zl/xS1bLxvydDdY3mr1Xg2rflgJX7GzIJsfCLY2xO2ZU4V+9aQRnZQJDsWqDHLIG
        1b/TLN9G7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7oL3ukmGyzeb2Kx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8uvqAueCUWMX/9W3MDYx/hboYOTkkBEwk
        nj96xNTFyMUhJLCUUeL9la+sEAkJidsLmxghbGGJP9e62CCKnjNKHDp1n7mLkYODTUBLorGT
        HaRGRCBX4tjae6wgNcwCR5gk2nbfB0sIC/hJLGq9AWazCKhK7F92HqyXV8BS4uFmboj58hIz
        L31nBwlzAoX7G2tAwkICFhLnFz8C6+QVEJQ4OfMJC4jNDFTevHU28wRGgVlIUrOQpBYwMq1i
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNdtx35u3sE479VHvUOMTByMhxglOJiVRHhTLuom
        C/GmJFZWpRblxxeV5qQWH2I0Bbp6IrOUaHI+MGHklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUw8Zutv11bxcCZvtZkrdK8HZuvz+lo+uhzbbpmYJ2At8dfngtB
        SatnHd3rkTX7RXxnu1Dah8m+su7LLOomfVhScsBrVWZbsPt7ZzvutoJVE7ee3mBbGr7baGuk
        7nPec2mhGYu3qSdJXOUp6s7o47eP+OR8k1v1OnNNfVC+e6nwfaVH74rKOJWE1i8Rzqtwui9t
        cnHuEps1E/eWqbgJWu07ftC3dP1/fb5Jhb9O3dlouGT1ik8Fx44umftlkUTecYGFXK1ezucy
        reQebymqObJkgvT6G/+y5iwUen6V/eQ6d5EmZ51r/wMjhS1vro3Wu785QNVL1HvXYl3Db9zz
        Lvy8p/P9fJrhvwOevvMMZ/9oVmIpzkg01GIuKk4EAHsGhVBgAwAA
X-CMS-MailID: 20220923173632eucas1p1a4b8cba427f5caf649009073233f8c76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173632eucas1p1a4b8cba427f5caf649009073233f8c76
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173632eucas1p1a4b8cba427f5caf649009073233f8c76
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173632eucas1p1a4b8cba427f5caf649009073233f8c76@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

