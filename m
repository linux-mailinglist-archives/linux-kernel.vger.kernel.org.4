Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3885E80F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiIWRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiIWRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:36:52 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DDE14D333
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173632euoutp011c71b5df29ce0d291f03e8bbbd4a2197~XjeKwYzLW1804318043euoutp01P
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923173632euoutp011c71b5df29ce0d291f03e8bbbd4a2197~XjeKwYzLW1804318043euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954592;
        bh=uWKwk/Zw9bFSyQrcJcSCU7+huozs0FwbWylJN85xRgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYF/8rocAiFLNkVqNyHyBblxVZgb8ckYzFu4hnbYT0N3/EU9vEhUj8T+gI33ft89h
         dqUbc56uHD/484b7LwfDcITGQLVWJIv4rHuDMww8QYNDBb/295h3GYca4bITgwd4J3
         ffBkoe3YPRpc4p/AKooIG6bcMuS5u3FMTs9gKYsk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173630eucas1p1a489121322cbc8d3112fd1dc005e72be~XjeJZVNTw2512925129eucas1p1p;
        Fri, 23 Sep 2022 17:36:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.6E.29727.E9EED236; Fri, 23
        Sep 2022 18:36:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923173629eucas1p27c1ebffb55c2f1a52fad913840b16d02~XjeIYpAeJ3127531275eucas1p2C;
        Fri, 23 Sep 2022 17:36:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220923173629eusmtrp2589da37c46d342f75699d90733786591~XjeIX5tQg1023410234eusmtrp29;
        Fri, 23 Sep 2022 17:36:29 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-34-632dee9e21e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.5F.10862.D9EED236; Fri, 23
        Sep 2022 18:36:29 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173629eusmtip2de3703de13204c51bab5ebfcae6c9dff~XjeIEVREQ1628216282eusmtip2a;
        Fri, 23 Sep 2022 17:36:29 +0000 (GMT)
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Fri, 23 Sep 2022 19:36:14 +0200
Message-Id: <20220923173618.6899-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87rz3ukmG7x4oWSx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2Pd
        kSWsBSt5KnpXvWVuYJzH1cXIySEhYCLxbvJvli5GLg4hgRWMEo9/LGWFcL4wSsxY/4AZwvnM
        KPF+5ik2mJbnk64xQSSWM0rM6rsJ5bxklJjX9ACoioODTUBLorGTHaRBRCBd4vjWm2A2s0A/
        s8TtfbkgJcICsRIHX+eAhFkEVCU+LloPNp9XwFKiceoSVohd8hIzL31nBynnBIr3N9ZAlAhK
        nJz5hAViorxE89bZYHdKCGznlPj++DnUnS4SHVuuMkPYwhKvjm9hh7BlJP7vnM8EYVdLPL3x
        G6q5hVGif+d6sPMlBKwl+s7kgJjMApoS63fpQ5Q7SqyZNYUFooJP4sZbQYgT+CQmbZvODBHm
        lehoE4KoVpLY+fMJ1FIJictNc1ggbA+JKctfMU5gVJyF5JlZSJ6ZhbB3ASPzKkbx1NLi3PTU
        YsO81HK94sTc4tK8dL3k/NxNjMBkePrf8U87GOe++qh3iJGJg/EQowQHs5IIb8pF3WQh3pTE
        yqrUovz4otKc1OJDjNIcLErivGwztJKFBNITS1KzU1MLUotgskwcnFINTM072iOcoxY1+NgF
        L/F/IrX62BnHhvO7k0Ob7giX1kj9+yulk9l8YS5Lw0p93j9rt0TLbun2brpzT+H5gn1OG6T7
        1HWunxXasUG38HvU5YJG29yWudmVNcFK0rbrV4bye4d9EHLdW1I1yVJHJm7xccdYtemVWqEM
        oWbC01fPUdgqeUO9R/vSqwLNLdLTNnyr+XH3uIJymd2bKgZ23dSfybyZv56yu2krnkg31IhQ
        cc1RevPs2bQbwnpH1Wuyc+NOxK95F+8n4Pp35cZHVoULQgWZglqlky4c610go5TE+1Jkxdfk
        VlbX0t2h7BsqDLrYlc5P5RA6usbtUoK/UGP0ceZSB+Frup7NFddV2ZVYijMSDbWYi4oTAfG1
        05b1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7pz3+kmGzx7J2ux/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PdkSWsBSt5KnpXvWVuYJzH1cXI
        ySEhYCLxfNI1pi5GLg4hgaWMEov3HGSCSEhI3F7YxAhhC0v8udbFBlH0nFHi3+N+1i5GDg42
        AS2Jxk52kBoRgVyJY2vvsYLUMAvMZ5b4OvkQG0hCWCBaYv2lmWCDWARUJT4uWg8W5xWwlGic
        uoQVYoG8xMxL39lBZnICxfsba0DCQgIWEucXP2KHKBeUODnzCQuIzQxU3rx1NvMERoFZSFKz
        kKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzdbcd+btnBuPLVR71DjEwcjIcYJTiY
        lUR4Uy7qJgvxpiRWVqUW5ccXleakFh9iNAU6eyKzlGhyPjB55JXEG5oZmBqamFkamFqaGSuJ
        83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MDEk7ytmVecxkAk9ueicifybpGXH9xqtverd+qln
        i4Vn5pvFr2+pbS1vqVQp/mtzaLNMj+G8r28u+i5MbWXPUW9znTlpnYj4fTZfNTHtNI+kKQFz
        Cp5NN87xWX7UqiFPSK+nMVzI/7bqVkZ1kWVZnR/czr7Uf/dzYqdfyeXnH/OUxbPC3hYvz+Hy
        LTNaF3qhRsbGbjNT2surO6YuKPqc8+TRJLZlv5f1Nt7Tfycur7s2o8TJtfTK7xu7Tsf9vffH
        UPaq4puU54/ES7sOn2rnT14nw20698qrnxV3NyhwVQtv8+pyPcRV2FK2LPxEieHeg4fbTaR/
        aT3aOttyBqdU125pQ+1wrq/NUjFTi7ymKLEUZyQaajEXFScCAP6WLIpmAwAA
X-CMS-MailID: 20220923173629eucas1p27c1ebffb55c2f1a52fad913840b16d02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173629eucas1p27c1ebffb55c2f1a52fad913840b16d02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173629eucas1p27c1ebffb55c2f1a52fad913840b16d02
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173629eucas1p27c1ebffb55c2f1a52fad913840b16d02@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the bdev_offset_from_zone_start() helper function to calculate
the offset from zone start instead of using power of 2 based
calculation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-zone.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..ac6fc1293d41 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if (bdev_offset_from_zone_start(md->disk->part0,
+						clone->bi_iter.bi_sector) != zwp_offset)
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -602,11 +603,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask =
-				(sector_t)bdev_zone_sectors(disk->part0) - 1;
-
 			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
+				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
 		}
 
 		return;
-- 
2.25.1

