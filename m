Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750B7420A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjF2Gtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjF2GtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:49:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989DD2D52
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:49:12 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230629064908epoutp03b34fbafaa94188da700ccdf68f10b371~tDnkj7Em22507725077epoutp03X
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230629064908epoutp03b34fbafaa94188da700ccdf68f10b371~tDnkj7Em22507725077epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688021348;
        bh=KEpV/SR7y0dLoMKT0bZXWc67BvkeWQIdOruf7uuQ4ZA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZFlwTvt+QAg75S4wkBhao5iElvEXV9mFlH/JmQo6tg7cQ3LlJhcVaX9/a1NOdSj5T
         StArv0llErKSXLZQbVlW9ElxnT5V832Gk4Dto2/LOKjqykPdja0C0YBKIiRtOmDaSI
         9bWE/U9bv+hQs9P/8Yiz1QYcSG7aU25UQoHZ4E7Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230629064908epcas5p40d0c100961b82debe6e742d08f3db5ba~tDnkBsHPj1752417524epcas5p4c;
        Thu, 29 Jun 2023 06:49:08 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Qs8Dy2KlJz4x9Px; Thu, 29 Jun
        2023 06:49:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.35.55173.2692D946; Thu, 29 Jun 2023 15:49:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1~tDUpsFQG-2800828008epcas5p2I;
        Thu, 29 Jun 2023 06:27:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230629062728epsmtrp2f7f3edcfa873ad996c2bb7067cf9c52a~tDUprEaJV3223132231epsmtrp2d;
        Thu, 29 Jun 2023 06:27:28 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-74-649d296246d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.B7.30535.0542D946; Thu, 29 Jun 2023 15:27:28 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230629062727epsmtip1ca4ed67758bcd5b83b2a1396a6185aba~tDUoSgo3u1157711577epsmtip1O;
        Thu, 29 Jun 2023 06:27:27 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Min Li <min15.li@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
Date:   Thu, 29 Jun 2023 14:25:17 +0000
Message-Id: <20230629142517.121241-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmpm6S5twUgzl3+S1W3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWT6/OYrLYe0vb4vKuOWwWy1d1MFmcnfCB1WLBxkeMFr9/
        AMVurLvK4sDnsXmFlsfls6Uem1Z1snnsn7uG3WP3zQY2j97md2wefVtWMXp83iQXwBGVbZOR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLSSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj543p
        zAUtIhXzmhpZGxhnCXQxcnJICJhI7L53mqmLkYtDSGAPo8SRDTNZIZxPjBKPls6Fcr4xSjw4
        2MkC09K8ciIjiC0ksJdRYvcaMYii54wSB1oXAs3i4GATUJbYttQHpEZEIE1iacdPNpAaZoG5
        jBIXF7YxgSSEBRIkNp/+wAZiswioSkx4NA9sAa+AlcT0H+2MEMvkJfYfPMsMEReUODnzCVgN
        M1C8eetsZpChEgJTOSSOPJnFBNHgIvHy6BRWCFtY4tXxLewQtpTE53d72UCOkxAolnj5Iwwi
        XCOx+9ttqFZriW3r14HdzyygKbF+lz5EWFZi6ql1TBBr+SR6fz+BKueV2DEPxlaS+HvhHNTJ
        EhKL9z+EusBDYvvJ86yQsIqV+Db3KusERvlZSL6ZheSbWQibFzAyr2KUSi0ozk1PTTYtMNTN
        Sy2HR2xyfu4mRnDa1QrYwbh6w1+9Q4xMHIyHGCU4mJVEeG+/mZ0ixJuSWFmVWpQfX1Sak1p8
        iNEUGMYTmaVEk/OBiT+vJN7QxNLAxMzMzMTS2MxQSZz3nntnipBAemJJanZqakFqEUwfEwen
        VAPTmso9Ih+OqLE/NJxw/eOb3VdvPbDcu4/rlNOpE4cdTAts3sidvOzi92DB55kaXPO+8yXw
        uPyTvGNnu3TCdevt8xjeTEu5UuRofHZZ0uw4y5ibe57onGefJ95txu3s0jL3+kWFK11Tl2++
        4uPu9Co1WLtXUvrtr9YPIRka8+6KKHrYOrxJVI5vCxXnrZ5z5YVOlndUftLuSqu0kzvr7EPF
        uNrNnf/Iv1r3+viu71yVLoeibWa4sBQfUta83mO9egbb1CN+H9YqzrZb6yTvtvWiw8lpbRzX
        RUI2fJkdNd3q2CLWh7oHOTydvwrcLzJ/4i/ns3OJ+seLAg5Z60wSP6aGnG5S6fzyQb5hl7zd
        Z4lIJZbijERDLeai4kQA6EKnVkQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnG6AytwUgzlXFCxW3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWT6/OYrLYe0vb4vKuOWwWy1d1MFmcnfCB1WLBxkeMFr9/
        AMVurLvK4sDnsXmFlsfls6Uem1Z1snnsn7uG3WP3zQY2j97md2wefVtWMXp83iQXwBHFZZOS
        mpNZllqkb5fAlbHzxnTmghaRinlNjawNjLMEuhg5OSQETCSaV05kBLGFBHYzSmx/bQsRl5A4
        P+8XG4QtLLHy33P2LkYuoJqnjBLXDt8Fcjg42ASUJbYt9QExRQRyJFZ89wcpYRZYyChxe/pL
        VpBeYYE4ia9tXWDzWQRUJSY8mscCYvMKWElM/9HOCDFfXmL/wbPMEHFBiZMzn4DVMAPFm7fO
        Zp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB4a+ltYNxz6oP
        eocYmTgYDzFKcDArifDefjM7RYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6Yklqdmp
        qQWpRTBZJg5OqQamMxeYThjtebJG6d22zQeaZlo3ST9UEPV9PvPX2afbXx+vfcDLteH/TukX
        OYesLzKlbny16oGypscH7hUFV/gXyHA1l+menG2bc8/3y8+uz73LlCeJ77x2gG1D0JwN/+YI
        sF7/bn7VJOsVW2J5stDSCeyChlNvTf679NPXcL6yhoUHDHP3njixfkLqVdGU3W+yme+9LZi4
        /9z1WXoKs/t1H0xrNtofuPtzw59triaFLCx7riZ+ENj9b3lS5gJXjnePWfz9DJ5prrP4kbn5
        Q9bNI0dn7gq62/xh/fddD1Z6lMfdPz/Z/lppe06KRP0bzY5N7Jl6tlV18VIL/VKLNrpfSoxX
        dFg/9dn5CWw2zfb5mnlKLMUZiYZazEXFiQD7Hgea7gIAAA==
X-CMS-MailID: 20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1
References: <CGME20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling add partition or resize partition, there is no check
on whether the length is aligned with the logical block size.
If the logical block size of the disk is larger than 512 bytes,
then the partition size maybe not the multiple of the logical block size,
and when the last sector is read, bio_truncate() will adjust the bio size,
resulting in an IO error if the size of the read command is smaller than
the logical block size.If integrity data is supported, this will also
result in a null pointer dereference when calling bio_integrity_free.

Cc: stable@vger.kernel.org
Signed-off-by: Min Li <min15.li@samsung.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

---
Changes from v1:

- Add a space after /* and before */.
- Move length alignment check before the "start = p.start >> SECTOR_SHIFT"
- Move check for p.start being aligned together with this length alignment check.

Changes from v2:

- Add the assignment on the first line and merge the two lines into one.

Changes from v3:

- Change the blksz to unsigned int.
- Add check if p.start and p.length are negative.

Changes from v4:

- Remove the local variable blksz and use bdev_logical_block_size(bdev) directly.
---
 block/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3be11941fb2d..0e8723c1a807 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -18,7 +18,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 {
 	struct gendisk *disk = bdev->bd_disk;
 	struct blkpg_partition p;
-	long long start, length;
+	sector_t start, length;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -33,14 +33,17 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
+	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+		return -EINVAL;
+	/* Check that the partition is aligned to the block size */
+	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))
+		return -EINVAL;
+
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
-		/* check if partition is aligned to blocksize */
-		if (p.start & (bdev_logical_block_size(bdev) - 1))
-			return -EINVAL;
 		return bdev_add_partition(disk, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
 		return bdev_resize_partition(disk, p.pno, start, length);
-- 
2.34.1

