Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31A5B560D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiILIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiILIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93A2F385
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082228euoutp02895f4477d800663c846d97458b317401~UD0RXLMRd2713727137euoutp02E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220912082228euoutp02895f4477d800663c846d97458b317401~UD0RXLMRd2713727137euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970948;
        bh=GhIDPZWMIafgE/mAZSnmKlimhg+oN7vlIbCtEzY8HQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AV9yORWBrycSC01OVCnrzGIp/7Bu8LSn42rQfrrEpM0mqaWIo/aa+jy6ukslgqtcm
         b0nWX9uWyhxKWy8PMqQsEtYx/QMAQlJ3hlgGNjpTWbLKZIsFifUR3bpfSWNY9Ikpz5
         21rjyosSDyMfWEc3udRZdrpwJDZpYX/SQyBUdDlY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082216eucas1p217f198775cbabf54dbb8af06c3a07c73~UD0Gdw1oP2081220812eucas1p2V;
        Mon, 12 Sep 2022 08:22:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.98.29727.83CEE136; Mon, 12
        Sep 2022 09:22:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220912082216eucas1p1d3068e7578a88007515c2f4f5ebcc2a8~UD0FqyqF71768417684eucas1p1V;
        Mon, 12 Sep 2022 08:22:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220912082216eusmtrp278adcdd0eae8192ad23f86c36bcfd1d7~UD0Fp6fEE3116631166eusmtrp2H;
        Mon, 12 Sep 2022 08:22:16 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-0d-631eec381941
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.33.10862.73CEE136; Mon, 12
        Sep 2022 09:22:15 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082215eusmtip1f09a8a5eff3926ebd36906443d538437~UD0FVcuxy1289112891eusmtip1d;
        Mon, 12 Sep 2022 08:22:15 +0000 (GMT)
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
Subject: [PATCH v13 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Mon, 12 Sep 2022 10:22:00 +0200
Message-Id: <20220912082204.51189-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7oWb+SSDebc1LNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlfFq
        9nS2gtfcFVNWTGZtYHzK2cXIySEhYCJx5dgJ5i5GLg4hgRWMEn9fTmCEcL4wShw4+ZcdwvnM
        KHFrTTszTMvEO5OgEssZJRbeOM4G4bxklJh44CJrFyMHB5uAlkRjJztIg4hAusT36e+YQGqY
        Be4wSTQdesEIkhAWiJWYdfUTG4jNIqAqsfvENbAGXgErieazzUwQ2+QlZl76DhbnBIq/XtXK
        CFEjKHFy5hMWEJsZqKZ562yo6zZzSuzYXwdhu0h83XMZao6wxKvjW9ghbBmJ/zvnQ8WrJZ7e
        +A0OAAmBFkaJ/p3r2UAekBCwlug7kwNiMgtoSqzfpQ9R7iixoKWBGaKCT+LGW0GIC/gkJm2b
        DhXmlehoE4KoVpLY+fMJ1FIJictNc1ggbA+JJT8nME9gVJyF5JdZSH6ZhbB3ASPzKkbx1NLi
        3PTUYsO81HK94sTc4tK8dL3k/NxNjMCEePrf8U87GOe++qh3iJGJg/EQowQHs5IIL4uhdLIQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkGJg21Ne6Z8d+X
        GayQ9GpbeHIt97kNosvvbGU9eeT2G5NWp66uA4z3jH5IR155n7W65SH3zBP9FrMObc6/W1nU
        /rCkcx7bo+Yvmbnzizrmf3xoqX6ToSr664W/E3e0V4s6hu/X9T4yl2GeX9Fq2fNTdFNbwpqa
        6t2OLhXrfb9xykfJlbvK9kRn7Wrb8ehz995L/2yvLZ6jseJrQEt3g2mPq8vdL0bOx999+MDg
        KZdcUB/acOh+/16rYx3LO16mTAubtKDDo8z2kqJzzWfhddd0ja78KpPNPm+z/EREdMRjLt2T
        ++6+Tjrru1R9Uvb2MHbrs8nHEw/fP3F7pqqfW93ewCWND2btiTHqnjZb8bxA2iQlluKMREMt
        5qLiRABUnFax9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7rmb+SSDVZMsrFYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/Fq9nS2gtfcFVNWTGZtYHzK2cXI
        ySEhYCIx8c4k9i5GLg4hgaWMEh0rn7FCJCQkbi9sYoSwhSX+XOtigyh6zijRsOMoUBEHB5uA
        lkRjJztIjYhArsTnlT/AapgF3jBJfFkyiQkkISwQLdG//zGYzSKgKrH7xDWwBl4BK4nms81M
        EAvkJWZe+g4W5wSKv17VCrZYSMBS4uy3G1D1ghInZz5hAbGZgeqbt85mnsAoMAtJahaS1AJG
        plWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0bvt2M8tOxhXvvqod4iRiYPxEKMEB7OSCC+L
        oXSyEG9KYmVValF+fFFpTmrxIUZToLsnMkuJJucD00deSbyhmYGpoYmZpYGppZmxkjivZ0FH
        opBAemJJanZqakFqEUwfEwenVAOTbcVLziRN27crviYpx0vqvRLgnqgxp1ly0YR3HTvkPm4W
        7lWZka+1tuXTj7VX/YrXOoa+TY00P5hRqs6vYblgDWty5cuuMG2pL29K71/JOflZJmSf0Q9B
        xmIT/QJ/vi2dc1Nfli1dKhK8vbq779LUw7/nLrNaXlL8XHjf5s2bw8T29S6YkqUrbG3H8CnD
        /bz0XemOjZkScz76RbAqFTx6ekJzqcSVv3LC53uc9N+bdr79Wjjrz4e+C273Z70987WmtyDp
        2HOL9n+7A4Qk99z/pXK3cAfno/orvzXvMZS4RDee1o89snN98JtZWTaT9h2b+5ahpfKFk2vJ
        g/cnua7wqfP+vpPx4V3cu4sXzrczKrEUZyQaajEXFScCALp6AFFnAwAA
X-CMS-MailID: 20220912082216eucas1p1d3068e7578a88007515c2f4f5ebcc2a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082216eucas1p1d3068e7578a88007515c2f4f5ebcc2a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082216eucas1p1d3068e7578a88007515c2f4f5ebcc2a8
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082216eucas1p1d3068e7578a88007515c2f4f5ebcc2a8@eucas1p1.samsung.com>
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

Use the bdev_offset_from_zone_start() helper function to calculate
the offset from zone start instead of using power of 2 based
calculation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

