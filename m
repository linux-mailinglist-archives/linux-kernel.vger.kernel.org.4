Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008D5BE1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiITJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiITJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:38 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861596110C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:34 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091133euoutp01ffa07bd2b85ca97a5d852b8d4f6f1672~WhpZ4hVNq1236412364euoutp01i
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220920091133euoutp01ffa07bd2b85ca97a5d852b8d4f6f1672~WhpZ4hVNq1236412364euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665093;
        bh=uWKwk/Zw9bFSyQrcJcSCU7+huozs0FwbWylJN85xRgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REbfCwsfkouA72M5ZeCA+jHkey7EEBhUm9ivs3bUZ1uacGH1NhFW5VtSZsyMK+LDU
         UfHHx2dzyIaSiFiIPJMTncNv4S70D+ioVRkZNZfchcehqvve6hHTuzjL64ogZSlAdt
         FlP0DKDOupH+74q7iOhdQ8zkdLxcsQSAlC16D1/E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091130eucas1p2a0838123c18e4e17ea3e770248bdfbbf~WhpXhxK5M1326413264eucas1p2N;
        Tue, 20 Sep 2022 09:11:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.2E.29727.2C389236; Tue, 20
        Sep 2022 10:11:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220920091129eucas1p26137d368bf7e2cfc2d585ce41f3cdc86~WhpW2ihrg3137931379eucas1p2G;
        Tue, 20 Sep 2022 09:11:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091129eusmtrp119499d96c3e89392e5cec7a704d0ccbd~WhpW1uUQ30212802128eusmtrp1q;
        Tue, 20 Sep 2022 09:11:29 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-47-632983c2ca6a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.0E.07473.1C389236; Tue, 20
        Sep 2022 10:11:29 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091129eusmtip266122eeddf42e613961d590179a06c75~WhpWgYaD32182421824eusmtip2e;
        Tue, 20 Sep 2022 09:11:29 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Tue, 20 Sep 2022 11:11:15 +0200
Message-Id: <20220920091119.115879-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qHmjWTDfofy1usP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
        3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InisklJzcksSy3St0vgylh3
        ZAlrwUqeit5Vb5kbGOdxdTFyckgImEhsu36OpYuRi0NIYAWjxP0rr9khnC+MEv1PvjFBOJ8Z
        Jbq7p7HBtCz99oYZIrGcUeLkuStMIAkhgZeMEkdbRLsYOTjYBLQkGjvZQcIiAukSX79uYASp
        ZxaYyCzxcPYnFpCEsECsxJmlK8BsFgFVibVfHzCC2LwC1hJbp09mhlgmLzHz0newQZxA8Tm7
        W9ggagQlTs58AtbLDFTTvHU22EESAps5JV4e28cC0ewi0f99JiOELSzx6vgWdghbRuL05B6o
        mmqJpzd+QzW3AP28cz0byAcSQNv6zuSAmMwCmhLrd+lDlDtKHOg7D1XBJ3HjrSDECXwSk7ZN
        Z4YI80p0tAlBVCtJ7Pz5BGqphMTlpjlQSz0kvjTfY53AqDgLyTOzkDwzC2HvAkbmVYziqaXF
        uempxYZ5qeV6xYm5xaV56XrJ+bmbGIEJ8fS/4592MM599VHvECMTB+MhRgkOZiUR3hZ/zWQh
        3pTEyqrUovz4otKc1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTIvzAtf35eZ+
        klv6jvFVq8sKFsuizdPFCruEjxzdvnyxXG3y563ryu7N2ZiwqG2FwskfvEePzk5p+unyw+r+
        0bvqiT7FmrbbaqrnS221yN0pYeAsvLvR5VW45RyZj8XTgwtXeHLYVHZMmWjXfH3u+bnV+myv
        4hyYV5yL/vG4ITHkCvfnGI2KDR6zf7Jbf7zB93Ere752ltlWfz43lm8/hC7M9DP/kGW7V17T
        Sn3VYp8a5j1RjzN4TLcc/Fqx6GF61OebvKY7ZrGUWoQsl4nUdNL01W5fHabP43nwwKLAJSWr
        sy9P9dm602mrznmH7RH9E5JM5DrizpWxBBsu0xSS+t+95LrmSe7GJeFfjr2fpsRSnJFoqMVc
        VJwIAKPF4fj3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7oHmzWTDb7PN7JYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7HuyBLWgpU8Fb2r3jI3MM7j6mLk
        5JAQMJFY+u0NM4gtJLCUUeJscwhEXELi9sImRghbWOLPtS62LkYuoJrnjBL3729g6WLk4GAT
        0JJo7GQHqRERyJU4vHkCE0gNs8B8Zold/96CJYQFoiX6n79mArFZBFQl1n59ADaUV8BaYuv0
        ycwQC+QlZl76DlbPCRSfs7uFDeIgK4mOWZvZIOoFJU7OfMICYjMD1Tdvnc08gVFgFpLULCSp
        BYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjd9uxn5t3MM579VHvECMTB+MhRgkOZiUR
        3hZ/zWQh3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgcmj7ySeEMzA1NDEzNLA1NLM2MlcV7P
        go5EIYH0xJLU7NTUgtQimD4mDk6pBqbl65Inbv8j+1rvj3e28t6PZny3fzj8lZLl97jmddvn
        8PYVlw6+mpmakORT+bnEZqeafmCzwP7Q5XIpUg6zH4qFT9b0zJc5VvGryavH+bh0f9+X0y/9
        JqYuLJH5z3Lkyza1J2f73Iy+O0tbr1xY3njru6NecDdHzdXnD+I+T+6Q1Yz2llvKVGPK8mHB
        ybCLs7OLok8/aemzuaBvK2Zv7fiIX6Ak7+rZ2omtZfPkOmYKT/769n9lYfKKLPW2tuMrN6z3
        6Vv2JHjhV6OahTb+V4oV+5RY1OTqtgm+L3R7s6B/dZmT88IPDg8XzVXOEPPMW/KCLyQkf02f
        c1RLXtC9ZAOWviXdym93PbpgfFTQT4mlOCPRUIu5qDgRAM8iv9dmAwAA
X-CMS-MailID: 20220920091129eucas1p26137d368bf7e2cfc2d585ce41f3cdc86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091129eucas1p26137d368bf7e2cfc2d585ce41f3cdc86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091129eucas1p26137d368bf7e2cfc2d585ce41f3cdc86
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091129eucas1p26137d368bf7e2cfc2d585ce41f3cdc86@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

