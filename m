Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C985BE18A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiITJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiITJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:39 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC761B09
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091134euoutp025f6830cb10057fd0cd9fcd0dad563f55~WhpbieGbp2726327263euoutp02G
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220920091134euoutp025f6830cb10057fd0cd9fcd0dad563f55~WhpbieGbp2726327263euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665095;
        bh=VLoCFLXBp82iOTzKgyetXtUrw6dZfbKcf6Fwvb6vl3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plhLH2JGGRzRhQCCxVknrS/2fO+mrJeNr/IzgZGHToS8iTDS1OyR5uzOd1LKbZYXc
         PFtslF1AuNhu+Zvdif/GkNc9nJk/PRFBvudrkviwOUWo3mrUZ9BRBZuo82/EM4ngyN
         piHjdMbvG+HnfeHHS0THILxwU92qjExYds0X8C/A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091132eucas1p258906bd9e7c9bcde2cddfce391c4a8d5~WhpZanmJ73137931379eucas1p2P;
        Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.98.19378.4C389236; Tue, 20
        Sep 2022 10:11:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296~WhpY6EFIs3137931379eucas1p2M;
        Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091132eusmtrp18c66e0aef4e2083a5eb7781af15d74e1~WhpY4-1NW0212802128eusmtrp15;
        Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-d1-632983c471be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.0E.07473.3C389236; Tue, 20
        Sep 2022 10:11:32 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091131eusmtip1e6641e79ecaaeeccfd239bb6f758759d~WhpYkCkHT1070710707eusmtip1t;
        Tue, 20 Sep 2022 09:11:31 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v14 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Tue, 20 Sep 2022 11:11:17 +0200
Message-Id: <20220920091119.115879-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0wTVwDOu2uvR6V4HDjewIxQwyYYEadLXgZxGme5xQSnGUtm/EFTbtjQ
        ImmtsmE2NstvEaw4oBAGzAEDYxELpVCQNJOqaApWkxasGqUOEERWmRIjjnI1+t/3vh/ve1/y
        SJy+zw8n5ZlHWFWmVCEmhLyuwQX7+r9PxMjiLzujkeH6II7a3GUE+u3ZAo5e3bTjqO9pDR+5
        BswYsjTqMPRX2xUMjRv0OHpdfA9DfaPrkKOnlkC/N3kEqDx/HkfeP7UCdN7l4aGroxFbgxnH
        7Z2MWe8WMI6bGqajtYhgLp37mel15RKMOe8+n5ntv0Mwp4ytgLk0lMN4Oz5iCgZKsK8D9woT
        01iF/Cir2rAlVXjIYGnHsuqCsisaTUQuGFlRDAJISG2G1pEavBgISZpqAfDBtXKMOzwHsG1i
        2q94ARzwzGFvI7kVTj4nNAPY132a8Ak0NQngI903xYAkCSoW/lIk8NGhVDqcn28HPj9OdWGw
        sqIR9wkhFAvHXs8uZ3lUNDR19izzIioBOvr/43NlkbD61ovliwKW+NpeLcF5guG16nGeD+NL
        nhOd3AZIGQKg867RH/4SjowWAg6HwCmbUcDh1XDozEkeh3Ogx/nKH9YCWGY2EL4FcKnt1A2F
        D+JUDDT0bODs2+C/N27hnCMIOmeCuScEQV1XpZ8WwcJ8mnOLoXlh3F8KoePXWn8pA51TVlAO
        ovTvjdG/N0b/rrce4K0gjNWolemselMmeyxOLVWqNZnpcbLDyg6w9AeHFm3z3aBlai7OCjAS
        WAEkcXGoSLsrRkaL0qQ//MiqDh9UaRSs2goiSJ44TCSTt0tpKl16hM1g2SxW9VbFyIDwXCxs
        p8s8k3RHfkEpe/msuzIuuy7j05RVZ+ojvy/rPvYiZqNx+HrJVx+f++cnlXuCdsSbarSx7qGo
        OmSik6syjMrJZFeWZ9+iqeDAtF46UfhZwdNZu61UkfxF1OIbSYP3ZXRV8/ZPGlPGdqfs0Goj
        tk4mFiaV2PIekgV5qjdNXY8lylXiPU8Gv3twVG+020sVkrDw4SRvKd9iD5yJHiwz0TXVwrQ5
        pn7L8UcJCWzz2LeBkhadUz6t+zyx3ZJky46aPdtwceWUcY0t4oPzitQPHY/jO/Jvszv259c3
        8eRVVzYnWqjszsvDdyVr/zjwpKgh8rk75/RxwcDeEY1NES7vFV8V89SHpBtjcZVa+j/ndTSZ
        8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7pHmjWTDX69ZbJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLW79nAVDCPr2LKou1sDYwXubsYOTkkBEwk
        GqbcYO1i5OIQEljKKHF52zc2iISExO2FTYwQtrDEn2tdbBBFzxklXs47BtTBwcEmoCXR2MkO
        UiMikCtxePMEJhCbWeAIk8TiqTEgtrBAssSL5TNZQWwWAVWJ7Vt3MYPYvALWEpf3fWOFmC8v
        MfPSd7A5nEDxObtbwG4QErCS6Ji1mQ2iXlDi5MwnLBDz5SWat85mnsAoMAtJahaS1AJGplWM
        IqmlxbnpucWGesWJucWleel6yfm5mxiBEbvt2M/NOxjnvfqod4iRiYPxEKMEB7OSCG+Lv2ay
        EG9KYmVValF+fFFpTmrxIUZToLsnMkuJJucDU0ZeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
        emJJanZqakFqEUwfEwenVAPT5lPleUsOp/OzVwmYzTUr/Kd9xvnFpKKAy1rCL3euObRCeaPn
        mrgN7etzn07s1DUM85XKCLVcf1V8W9aXJ5vnaaz5OCGO4VhAa1rkG5ldLRe925mCwj/y/Xvw
        49qjwAdrjjwq2RAjfG6i7fUb2xd8dmY61bq7cbGtXPrdWwy3K2wi3tWpON9Ws59/1ry9Sz6m
        pE3vM9tTw2DPwMo/G+98ETTXMwo88uULX9YXnTTujit8Hbs6HnwNzXB1kjn7xGLLq+tfun5x
        Z/7sDdl24RTT5rBgO845bo9Cz5w/0/b6Z5t3/W+1qUddTya8eWh2vCVm0lFd9/sTdrec3M8l
        f+1/607vsC7N+JCjm79t5Pq0T4mlOCPRUIu5qDgRALvGQYBhAwAA
X-CMS-MailID: 20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation, and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore.

Currently, this is not a problem as the targets that support zoned devices
such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
and even if they do (such as dm-flakey), they don't modify the
bio->bi_iter.bi_sector of the cloned bio that is used to update the
orig_bio's bi_sector in dm_zone_endio function.

This is a prep patch for the new dm-po2zoned target as it modifies
bi_sector in the endio callback.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7c35dea88ed1..874e1dc9fc26 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1122,10 +1122,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1154,6 +1150,10 @@ static void clone_endio(struct bio *bio)
 		}
 	}
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(bdev_is_zoned(bio->bi_bdev)))
+		dm_zone_endio(io, bio);
+
 	if (static_branch_unlikely(&swap_bios_enabled) &&
 	    unlikely(swap_bios_limit(ti, bio)))
 		up(&md->swap_bios_semaphore);
-- 
2.25.1

