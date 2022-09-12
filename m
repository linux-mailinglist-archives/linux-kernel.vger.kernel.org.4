Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB95B5611
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiILIYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiILIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C582E686
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:40 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082221euoutp01ec117b60f162599c43683cf5093dd054~UD0K7CXog1523515235euoutp01-
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220912082221euoutp01ec117b60f162599c43683cf5093dd054~UD0K7CXog1523515235euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970941;
        bh=WU1oSYYifuddX9yyjx4QFQJb3f/txF5tBxB5+RepGko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipIQozPnSN7Wv/n9k8gEXbNJs4lR6f6Y+mL3KdD+V600SJ+m873bWDyd9Wd3V7Wyc
         9jdEsXitreiKp3faSrYGhTdJ4Cz7GSLTrn3f8lu0EzwbZv6AXf+gEHMifpZr5VIhlz
         QxctGOoWfa/JV8bkEsgH7iAY0TWnmrn0rSyhykuc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220912082220eucas1p1402aa614a51566e2ee2e71ffbf935a8f~UD0JXW-uL1769017690eucas1p1V;
        Mon, 12 Sep 2022 08:22:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.56.07817.B3CEE136; Mon, 12
        Sep 2022 09:22:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220912082219eucas1p28467ed150230da8a65e4c957975fe438~UD0I7Dey-2083820838eucas1p2f;
        Mon, 12 Sep 2022 08:22:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220912082219eusmtrp266415810c8995ef489f25a93864d6eae~UD0I6NLGZ3116631166eusmtrp2T;
        Mon, 12 Sep 2022 08:22:19 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-e0-631eec3b1050
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.43.10862.B3CEE136; Mon, 12
        Sep 2022 09:22:19 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082219eusmtip1336c390f7f0bc0eb05deaa3e17686406~UD0ImHDEQ1320313203eusmtip1n;
        Mon, 12 Sep 2022 08:22:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        linux-nvme@lists.infradead.org, pankydev8@gmail.com,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org,
        bvanassche@acm.org, gost.dev@samsung.com, dm-devel@redhat.com,
        hare@suse.de, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v13 12/13] dm: introduce DM_EMULATED_ZONES target feature
 flag
Date:   Mon, 12 Sep 2022 10:22:03 +0200
Message-Id: <20220912082204.51189-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djP87rWb+SSDdbfsrRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDJ+XX3AXHBK
        rOL/+jbmBsa/Ql2MnBwSAiYSW9/vYOxi5OIQEljBKDH573I2COcLo8SXja+gnM+MEmubZ7LB
        tOzcdYMJIrGcUeL2m21Q/S8ZJWZvWgKU4eBgE9CSaOxkB2kQEUiX+D79HVgDs8A2Jon7D18w
        gySEBQIkVn85CDaVRUBVYtfjKWANvAJWEk+2zoXaJi8x89J3sDgnUPz1qlZGiBpBiZMzn7CA
        2MxANc1bZzODLJAQWM0p8WfZUiaIZheJ/Quns0DYwhKvjm9hh7BlJP7vnA9VUy3x9MZvqOYW
        Ron+nevZQD6QELCW6DuTA2IyC2hKrN+lD1HuKHF632Z2iAo+iRtvBSFO4JOYtG06M0SYV6Kj
        DRq8ShI7fz6BWiohcblpDtQxHhJrFt5gn8CoOAvJM7OQPDMLYe8CRuZVjOKppcW56anFRnmp
        5XrFibnFpXnpesn5uZsYgYnw9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFeFkPpZCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1M62bl2lzNrfjrs+7vQZ/j
        z6N6E88xaMnGXQ7Zl//htc6R4oYTqkLy+4oe7fVr067KcdinPXmTf3znktQPfyRV5n80O7g9
        8VBXhLVI74vkGuVTPssuRNVe2rZjYvmav9Y8K1Okg2cwBrxPiP2yrPHY891CHkk+S+/s1dSN
        WcNytUOm43pMp2mYlmPVzYs2kWmJJT56fSX3OBNDj2evfsN7eNduiZLfRlXdVpkT2rVPf51d
        mSFh0s03d7vio2u7Tgcfti8LXcpefH/i79yZ0hMtX65RY3B1nf5Mg7mmgNPeTWjbjRCdDAbR
        W9vWKqvKNyzmCKt6t4vjorw3a1D1k8TCi0XR/QllwVo//5S2syixFGckGmoxFxUnAgDX21HR
        8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7rWb+SSDb58lLJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+XX3AXHBKrOL/+jbmBsa/Ql2MnBwSAiYS
        O3fdYAKxhQSWMkqsPsQDEZeQuL2wiRHCFpb4c62LDaLmOaPEksuhXYwcHGwCWhKNnewgYRGB
        XInPK38AlXBxMAscYZL4+2oFM0hCWMBP4uS3iywgNouAqsSux1PAGngFrCSebJ3LBjFfXmLm
        pe9gcU6g+OtVrYwQuywlzn67AVUvKHFy5hOwOcxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMB43Xbs55YdjCtffdQ7xMjEwXiIUYKDWUmEl8VQOlmINyWx
        siq1KD++qDQntfgQoynQ3ROZpUST84EJI68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1
        OzW1ILUIpo+Jg1OqgWlf9+4Eo3qWWWsvOcrFxV17yrzlZ9xNfaP0A+wnH4U/trFenaJy6IhL
        UMyqr9HXRM/HqNyYpbzsmPAc8bfzTs7fcLpz39Tg7D/Zwdw6D7fwNkyfflMlyYn3Y7Lq5s/u
        2z9wv36XId284uGdaULta2ryTsifkeyOqtirPFVs7qFDlg8Sb//pZsrZX6co13LlRddxVhnP
        SXcs5i6btPileUCa8uby/KWmn6oOnn526OqF+zW2bqtY20988li4pfn6W+//xVd/NcuudPbn
        OeO0q0yf5UnkxG32M+c8+LFm2UcLC5ltj3bwvDy+bPmnBcmpD/dH5z8siGNlm7Nwxdfp1yKP
        Psj8mFwVYOV5bnv5ju9CU5RYijMSDbWYi4oTAcuK/MhgAwAA
X-CMS-MailID: 20220912082219eucas1p28467ed150230da8a65e4c957975fe438
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082219eucas1p28467ed150230da8a65e4c957975fe438
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082219eucas1p28467ed150230da8a65e4c957975fe438
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082219eucas1p28467ed150230da8a65e4c957975fe438@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

