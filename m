Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A905B55FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiILIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiILIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672952DAA9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082215euoutp015fb9ac4f47a5984a418cc6f31ffbdfbf~UD0E8-dTe1404314043euoutp01U
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220912082215euoutp015fb9ac4f47a5984a418cc6f31ffbdfbf~UD0E8-dTe1404314043euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970935;
        bh=BWkW98eOYak4zoJYsjIHeJX+UtNkNe/AaFvL+9lXLPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dc4I6CFYbomyy5b0qJYMbsieJzFdgHiUDL7hiZOk2cKCrFi8k/SX/RQ38n9RHxKmF
         rf+QrdVkmrojUBOqhafy+QFyoDpFLd+P9EgBFkBaLTtt9emr2AOKz7PcBPuvKocUrD
         /5A6TwcQRwxyj+N7PMoEYegcXuT5U5ebWqCDAL4I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082213eucas1p2f46e7a125861f32b6781e8a09d5f8eb4~UD0DIBvFE2083820838eucas1p2T;
        Mon, 12 Sep 2022 08:22:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E9.98.29727.53CEE136; Mon, 12
        Sep 2022 09:22:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e~UD0CdqmFI1461814618eucas1p1o;
        Mon, 12 Sep 2022 08:22:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220912082212eusmtrp2c8b581788d5d7886c123129df284080b~UD0CcrZHl3082830828eusmtrp2g;
        Mon, 12 Sep 2022 08:22:12 +0000 (GMT)
X-AuditID: cbfec7f2-7932da800001741f-fc-631eec35cae0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.33.10862.43CEE136; Mon, 12
        Sep 2022 09:22:12 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082212eusmtip2ed666c70861a0e51ee5767060b80e032~UD0CGqnNM2388123881eusmtip2h;
        Mon, 12 Sep 2022 08:22:12 +0000 (GMT)
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
Subject: [PATCH v13 06/13] null_blk: allow zoned devices with non power-of-2
 zone sizes
Date:   Mon, 12 Sep 2022 10:21:57 +0200
Message-Id: <20220912082204.51189-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87qmb+SSDeZ1CVisP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
        3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InisklJzcksSy3St0vgyth+
        eBJzwS/piqWL+1gbGK+IdzFyckgImEic2fmbFcQWEljBKDHlnUgXIxeQ/YVRYsGJCYwQzmdG
        ie//prDBdMxY9poJomM5o8TRz8wQRS8ZJe6dnwKU4OBgE9CSaOxkB6kREUiX+D79HRNIDbPA
        HSaJpkMvGEESwgKREodfbAAbyiKgKrF2zz+wOK+ApUTv8TvsEMvkJWZe+g5mcwpYSbxe1QpV
        IyhxcuYTFhCbGaimeetssCMkBDZzSqw/vZcZotlF4sf6lSwQtrDEq+NboIbKSPzfOZ8Jwq6W
        eHrjN1RzC6NE/871bCAfSAhYS/SdyQExmQU0Jdbv0ocod5RoWTOPHaKCT+LGW0GIE/gkJm2b
        zgwR5pXoaBOCqFaS2PnzCdRSCYnLTXOgjvGQaGj7wD6BUXEWkmdmIXlmFsLeBYzMqxjFU0uL
        c9NTiw3zUsv1ihNzi0vz0vWS83M3MQLT4el/xz/tYJz76qPeIUYmDsZDjBIczEoivCyG0slC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamJI+a+64xVvD
        l9TlunTj0RNSSg0iHx/cmNz4ZXGJ2/LQ0tcz+G5I2ItL7J0n8dNzqs/Kp8yNgqt528M9E3XF
        JvxnDHRwqljefOSF8sN6ZxfBu+X/25pETdIcNtmUPlJbePe3uLd//+MvZxYUH/872X16Ua/H
        tb2G7m7XWZJ7ohqmK82O3CZh0sc7feKTWLvoHbmPNKKFYwwuyH+eu7jWVz/3W7Oa3kyxS89u
        ifo8+HW3tOr40kLleoHVJZ6i64XE+DZcrmqUXt39nFHvSNEPlpX1XfldD6QvVTzKnhezcnrv
        5e4TF3lSz/PMNnjv+eS3/9yVscxybcq6mV5PFV5yfbjLvuSjf/Pewy+37svyU2Ipzkg01GIu
        Kk4EACa4u8b2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7omb+SSDS5MlLdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H98CTmgl/SFUsX97E2MF4R72Lk
        5JAQMJGYsew1E4gtJLCUUWL6OQOIuITE7YVNjBC2sMSfa11sEDXPGSUerJDpYuTgYBPQkmjs
        ZAcJiwjkSnxe+QOohIuDWeANk8SXJZPAZgoLhEv0/P8OVsQioCqxds8/sJm8ApYSvcfvsEPM
        l5eYeQmihlPASuL1qlZGiF2WEme/3WCHqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKt
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzcbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4WQyl
        k4V4UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5H5g68kriDc0MTA1NzCwNTC3NjJXEeT0LOhKF
        BNITS1KzU1MLUotg+pg4OKUamDZZXnHcZ8xcKr2+sbe3XGLW7O+Hve8x/ZLb7OF+kD+o7Mvs
        krwzRxOFuS7uuScvPpMrc9/1HQ8/hx4K7b66MHvFg9rbE0Sa/i77+X/2Z3a1jY/5rVKc39Vv
        P71c8Mjp+LhQtU+bKxK5rCe8/2+wVuvF4aYpE9atfPLd7euvpcs23Pty4/enaCOT6wwVVlfT
        7k9U8PSLl4xdG3FJs/bV9Kovy3RKJrQLfP4WvUJ7e8Wso59K76//8yx+ZeGbKycu1jk8zb/J
        6j5j2taKbe1XN5jNPCGWEBfcxmKosHYJ/+5Mx/cfFtoJ3evzLnlw3i1kz/o9H1YLRKZI3hX6
        Kh9qomo26bfqd7Fzh1NecBw13FDWrsRSnJFoqMVcVJwIAIZeR6plAwAA
X-CMS-MailID: 20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the power-of-2(po2) based calculation with zone size to be generic
in null_zone_no with optimization for po2 zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for po2 zone sizes as this function is
called only during the initialization and will not be invoked in the hot
path.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c     |  5 ++---
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 18 +++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..3b24125d8594 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1976,9 +1976,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("Invalid zero zone size\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..f63b6bed1bb3 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -83,6 +83,7 @@ struct nullb_device {
 	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
+	unsigned int zone_size_sects_shift;
 	bool need_zone_res_mgmt;
 	spinlock_t zone_res_lock;
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..015f6823706c 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -16,7 +16,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (dev->zone_size_sects_shift)
+		return sect >> dev->zone_size_sects_shift;
+
+	return div64_u64(sect, dev->zone_size_sects);
 }
 
 static inline void null_lock_zone_res(struct nullb_device *dev)
@@ -65,10 +68,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
@@ -86,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
 
+	if (is_power_of_2(dev->zone_size_sects))
+		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
+	else
+		dev->zone_size_sects_shift = 0;
+
+	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
+					      dev->zone_size_sects);
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
-- 
2.25.1

