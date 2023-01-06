Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221065FCD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjAFId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAFId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:33:26 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53E676CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:33:23 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083321euoutp018ad9827a9eb4363a0857256a26e941c1~3qy5BRGPb1990819908euoutp01A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083321euoutp018ad9827a9eb4363a0857256a26e941c1~3qy5BRGPb1990819908euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994001;
        bh=mYUOjDUgV5uRZr8FSI2sN9uglijkdaYClIStHAMPSkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmeTtBF5gK5bztpCTGGZApS6CQVXo9uIwcf3KtFV9+4tNaM0IfiDRBHi8xxwu8SKG
         IeVjhxHeDcvSWZSGlFkTk70SzePsOGpxp4y5eqRVSjh7jKqoyJQLa5aGP1URdpjuWQ
         TltkqGJuqrZml32qlhsDnXSEpmn5p3T65m6Jqfp0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230106083320eucas1p2d90ff0852e090e65aca5fa311795922e~3qy3_jx7W0127301273eucas1p2-;
        Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.43.43884.0DCD7B36; Fri,  6
        Jan 2023 08:33:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f~3qy3k3X6I2244622446eucas1p12;
        Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230106083320eusmtrp1ca7857a1c230a82c8c50a2ca90d049a8~3qy3kPC_x2166121661eusmtrp1h;
        Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
X-AuditID: cbfec7f5-271ff7000000ab6c-44-63b7dcd0381b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E7.C6.23420.0DCD7B36; Fri,  6
        Jan 2023 08:33:20 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083319eusmtip2fc156a9b99243a61ab87bd75fb6194fb~3qy3WgiZY2797827978eusmtip2g;
        Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Date:   Fri,  6 Jan 2023 09:33:12 +0100
Message-Id: <20230106083317.93938-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87oX7mxPNti9T8li9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oLpuU1JzMstQifbsErowPy7cxF8wXqVhxdjNTA+NlgS5GTg4JAROJ3xP62LoYuTiE
        BFYwStx/9IIRwvnCKPHozCdmCOczo8TerQeZYFounF0PVbWcUWLD5ulQ/S8YJd7v/QPUwsHB
        JqAl0djJDtIgIiAssb+jlQWkhllgM5PE7d9rGUESwgLREqdm72AFsVkEVCX+9xwAs3kFLCXW
        fp3PCLFNXmLmpe9ggzgFrCSeT1/DBFEjKHFy5hMWEJsZqKZ562xmiPpuTolVZ5QhbBeJ09d3
        QM0Rlnh1fAs7hC0jcXpyDwuEXS3x9MZvsDclBFoYJfp3rmcDeUBCwFqi70wOiMksoCmxfpc+
        RLmjxLo955ggKvgkbrwVhLiAT2LStunMEGFeiY42IYhqJYmdP59ALZWQuNw0B2qph8SDydvZ
        JjAqzkLyyywkv8xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYEo7/e/41x2M
        K1591DvEyMTBeIhRgoNZSYS3rH9bshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeGVvnJwsJpCeW
        pGanphakFsFkmTg4pRqYpt9otLnWcNB4Q42cgHL/z0DhszXPereFZGS4MbVfvCgtskSf8eK8
        4EqLyFcsAj+zAwsXnFKZZ5GUy71X6k3BgbB1v3K4mcP3sTgfn7di8s7ZUbkREidmWrrVfCj4
        o39li0eBwZQDnisUks+9/pXdYL7+waOGvJXH3sxyP7jhscUiodD0nroULveZhZk/mudHx85U
        UvbONP8/a9USxoqvD66/bGEpNdZs1gubfK21r+vSi3ll650ubbW6zlvcMb9jf1lt1u61Tza2
        3Zn4Z27jnZoJla73ZnO0FmdMSLnEejGRq213y+eQpX6bvU/uOf238pWCycv38//2L7k861zS
        gdonxmeONTw8xTul859yghJLcUaioRZzUXEiAFtCPzPYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7oX7mxPNjjUz2qx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLmwd2MlnsWTSJyWLl6qNMFmdefmax2HtL2+LyrjlsFvOXPWW3+Ly0hd3i
        xC1pB16Py1e8PS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n9Ti70tHj/b6rbB59W1Yxemw+Xe3x
        eZNcAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        XsaH5duYC+aLVKw4u5mpgfGyQBcjJ4eEgInEhbPrGbsYuTiEBJYySjTeecwGkZCQuL2wiRHC
        Fpb4c62LDaLoGaPEt43fWLsYOTjYBLQkGjvZQWpEgGr2d7SygNQwCxxkkng25TszSEJYIFLi
        zKkDYDaLgKrE/54DrCA2r4ClxNqv86EWyEvMvPQdbBCngJXE8+lrmEBsIaCajo+9bBD1ghIn
        Zz5hAbGZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5mxiB8bft
        2M/NOxjnvfqod4iRiYPxEKMEB7OSCG9Z/7ZkId6UxMqq1KL8+KLSnNTiQ4ymQHdPZJYSTc4H
        JoC8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamI6lXqrWu+PBt
        NXv77vPNgrDOTcvVy6QP/nTfJaI450CtzxZrrRXfk7bKSlQJrX/39Nn3bVKbbgmbTDxXY6t6
        d99e4xxhH+t/hmmx/h8ffDI8edp76SJ7q+6SWQKJZ3bMWTuL585LBvdXLU6x86+1rWb4Uv3t
        QtzX5ddu8Dsmvbk/w6j5xsQvcWlOrPy3z2Se1t3+WYerV31d8OLUbo+8W2cFf00Ne364Y+/V
        T84Gu+SXhDCGxIXGP3v4ifPpnfc3mI1nS6l3n08JWnDiZAnjnnaTRuuQnsnppyoj/1hp1/R+
        XZDhPHWJUI53EHv3/8ytDw4/imFUFN0/22JZ/IJXm3V+SvUcerqhYY3jpJ1fUpVYijMSDbWY
        i4oTASPl4khIAwAA
X-CMS-MailID: 20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding to check for zone start, add a helper to improve
readability and store the logic in one place.

bdev_offset_from_zone_start() will be used later in the series.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      |  4 ++--
 include/linux/blkdev.h | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..0405b3144e7a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -573,7 +573,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
 	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index db829401d8d0..614b575be899 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -277,10 +277,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!bdev_is_zone_start(bdev, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0e40b014c40b..04b7cbfd7a2a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -715,6 +715,7 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
 }
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
@@ -1304,6 +1305,23 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return q->limits.chunk_sectors;
 }
 
+static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
+						   sector_t sec)
+{
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	return sec & (bdev_zone_sectors(bdev) - 1);
+}
+
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
+{
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return bdev_offset_from_zone_start(bdev, sec) == 0;
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->limits.dma_alignment : 511;
-- 
2.25.1

