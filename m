Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFE5E80E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiIWRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIWRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:36:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933F1514D0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:31 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173629euoutp023ffc709b399b038a685d80b493cd0e6c~XjeIFLExR3258632586euoutp02J
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220923173629euoutp023ffc709b399b038a685d80b493cd0e6c~XjeIFLExR3258632586euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954589;
        bh=7l7TBEteecx3AwNFd/S2Kb1j8sryOvSWXnFBoTvrBTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GeP5caYNIA0zJKZ3xKcHslKtlxZQ7Dqae1CBO3Ht9SjRi3R/YR+5ePSyWjBELajAi
         3ojFlUYBZYrQNngUMPUrI0CXDzWemU0EwFjbEEOY9bDouEok61n2Vi4FJa3qlSTqw2
         Ro2AmvKAE6D17EBQHvpdkw8PVpDSDTfx+QE8qFgI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173627eucas1p1ff1805506d496509b0b02acd06fb440c~XjeGBXmV61386913869eucas1p1L;
        Fri, 23 Sep 2022 17:36:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BF.1F.07817.A9EED236; Fri, 23
        Sep 2022 18:36:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923173626eucas1p2e06c400ad3c18fe8f33c0b4ab1a25bf0~XjeFYwQ4O2090620906eucas1p2p;
        Fri, 23 Sep 2022 17:36:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923173626eusmtrp187736ea990ce7390114c40622ac154b9~XjeFX9u8c1032310323eusmtrp1a;
        Fri, 23 Sep 2022 17:36:26 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-35-632dee9ad0cd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.78.07473.A9EED236; Fri, 23
        Sep 2022 18:36:26 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173625eusmtip190df0be3e8ba67115133d440c9dc35fd~XjeE-W8SQ0836708367eusmtip1T;
        Fri, 23 Sep 2022 17:36:25 +0000 (GMT)
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
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 06/13] null_blk: allow zoned devices with non power-of-2
 zone sizes
Date:   Fri, 23 Sep 2022 19:36:11 +0200
Message-Id: <20220923173618.6899-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djPc7qz3ukmGzR9NbdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9JounV2cxWey9pW1x
        edccNov5y56yW0xo+8pscWPCU0aLz0tb2C3W3HzKYnHilrSDsMflK94eO2fdZfe4fLbUY9Oq
        TjaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAG8UVw2Kak5
        mWWpRfp2CVwZjRP+MBe8kqk4sfU3UwPjLokuRk4OCQETiRfrJjJ1MXJxCAmsYJT49fk2G4Tz
        hVGi5e0NdgjnM6PExwf3GGFaDixYANWynFFixtwnjBDOS6CqeddZuxg5ONgEtCQaO9lBGkQE
        0iWOb70JNolZYBuzxJ/j68BqhAUiJT6384LUsAioSsy/2sUMYvMKWEhs/jWPGWKZvMTMS9/Z
        Qco5BSwl+htrIEoEJU7OfMICYjMDlTRvnc0MMl5C4BSnxPIzT5lB6iUEXCROdddBjBGWeHV8
        CzuELSNxenIPC4RdLfH0xm+o3hZGif6d69kgeq0l+s7kgJjMApoS63fpQ5Q7SsyZeR2qgk/i
        xltBiAv4JCZtmw61lFeio00IolpJYufPJ1BLJSQuN82BWuohcWTPdcYJjIqzkPwyC8kvsxD2
        LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYIE//O/5lB+PyVx/1DjEycTAeYpTg
        YFYS4U25qJssxJuSWFmVWpQfX1Sak1p8iFGag0VJnJdthlaykEB6YklqdmpqQWoRTJaJg1Oq
        gak81kZxla/l0sy4PYWPufnLHLar9N+LzhbeqXGbw9v4wRLdhhUac+Zpm3e3Lf/wyKOtr3T/
        Iceb2kvfuaz2SHspHdr07FLtQbdXnw/cqO0rePT1vYnCs0OpxQ9yHrft/Ry+n/fjo6ZXRs7u
        C81z9L0f7fwltO4Kj/aTL3+LZvpOdtvTdEl3+q/KS6xL9G6s2cn85odBwsd/GySLDJWm2hzL
        0p1e9fKdx9X2ORz2Tw4J/NoZ5K7LcF5L1uBr0L7VuSeatu0smj375cb+a7nfDR/oX9JdGlvN
        uzh9i3yasL5K0hPzV6v+fcxLXC/iGjQtyZBD7PUNqYz9pz3Ta/con5/wuCH4cbST57YNRQKd
        kiVKLMUZiYZazEXFiQCDgrhs/wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7qz3ukmG5xr4rFYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9JounV2cxWey9pW1x
        edccNov5y56yW0xo+8pscWPCU0aLz0tb2C3W3HzKYnHilrSDsMflK94eO2fdZfe4fLbUY9Oq
        TjaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAG8UXo2Rfml
        JakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZjRP+MBe8kqk4
        sfU3UwPjLokuRk4OCQETiQMLFjB1MXJxCAksZZT4cOQHG0RCQuL2wiZGCFtY4s+1LjaIoueM
        Et+mdwF1cHCwCWhJNHayg9SICORKHFt7jxWkhlngGLPEtK/rmEASwgLhEleuXgIrYhFQlZh/
        tYsZxOYVsJDY/GseM8QCeYmZl76zg8zkFLCU6G+sAQkLAZWcX/yIHaJcUOLkzCcsIDYzUHnz
        1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwnrcd+7l5B+O8Vx/1
        DjEycTAeYpTgYFYS4U25qJssxJuSWFmVWpQfX1Sak1p8iNEU6OyJzFKiyfnAhJJXEm9oZmBq
        aGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cAkpnLk5469v1Q0JgYd6irdV8Ni
        NVVyroO6wxVrpvr0Q9sdAxgvz9C6uddj7qNzX96LblOz3lPeHmTuV1bbW/bz4pU65gdW5neq
        8xil2H1Ezhme5M00deCWztTmlPlaIjsr/8rCe8p8oYdms8/IOeT//JyIsjLnDlOJsMnNp56E
        3jpW/2KS1MtKKS3W/5Uff+7b4n235rjXxRKfz7/f1Ts9Lr+3J/mNiPNC4f7NB5Zp7WQLvptR
        dkh+uk3GXyuX8zprTE7O3J1Y7rgs6NbFUxO2/XdZtPU439ykf/z7qs9MnswtfGaSa0mL+IKt
        m5WWOK0o6khu3Kdf3dZSLHiS68a66gd3t230u8Dg9DfGb4mfEktxRqKhFnNRcSIAqv51w3AD
        AAA=
X-CMS-MailID: 20220923173626eucas1p2e06c400ad3c18fe8f33c0b4ab1a25bf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173626eucas1p2e06c400ad3c18fe8f33c0b4ab1a25bf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173626eucas1p2e06c400ad3c18fe8f33c0b4ab1a25bf0
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173626eucas1p2e06c400ad3c18fe8f33c0b4ab1a25bf0@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

