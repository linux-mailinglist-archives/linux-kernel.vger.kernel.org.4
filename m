Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18A5B5609
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiILIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiILIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC022F013
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:40 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082221euoutp0136f650a9d8d966c3f68e9c0939d4046f~UD0LHMidX1403214032euoutp01j
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220912082221euoutp0136f650a9d8d966c3f68e9c0939d4046f~UD0LHMidX1403214032euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970941;
        bh=6KLZnW+r2Lo4etQGdD1QpBP8NjREYU10ycW8QMjCE4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3ibfGuEJlfcE5s0+VTQlqOY7VR1EQfosWYbHsv2oP9FsVuz7+HasQkgw5BTsTnyu
         agI93ys1VvGREaUK1NYPknnnxVFsXrz/DbOL0SpdMkoDNBUhyTiwXxrjpAoXaCTiJb
         LaKot/CTKhd9GMU/Py2IPkJGvGeNkz66F8Ulp/gw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082212eucas1p227cff65cf4d38a4326b690c0955c4dad~UD0CRIaG83149631496eucas1p2I;
        Mon, 12 Sep 2022 08:22:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F7.98.29727.43CEE136; Mon, 12
        Sep 2022 09:22:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220912082211eucas1p2d7cbc34d8ba679e525442128698a1116~UD0BaXdfk0134901349eucas1p24;
        Mon, 12 Sep 2022 08:22:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220912082211eusmtrp1a506910c09c509ba02e69c14d0927f7b~UD0BZjqKh1301813018eusmtrp1h;
        Mon, 12 Sep 2022 08:22:11 +0000 (GMT)
X-AuditID: cbfec7f2-7932da800001741f-f8-631eec345fe9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.2F.07473.33CEE136; Mon, 12
        Sep 2022 09:22:11 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082211eusmtip12c21b3997194ab192c3022a7c08b005b~UD0BBbxCs0841308413eusmtip1V;
        Mon, 12 Sep 2022 08:22:11 +0000 (GMT)
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
Subject: [PATCH v13 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Mon, 12 Sep 2022 10:21:56 +0200
Message-Id: <20220912082204.51189-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87omb+SSDU7sE7ZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlTG7
        ZRtbwRaRit2n37A2MP4U6GLk5JAQMJHYdLSFvYuRi0NIYAWjxJuDL9ggnC+MEl9+r2WGcD4z
        Ssw+85QNpmXymTlMILaQwHJGicY/ZRBFLxkl5hx9xtLFyMHBJqAl0djJDlIjIpAu8X36OyaQ
        GmaBO0wSTYdeMIIkhAWiJX7c6GQFsVkEVCWuvusCs3kFLCVO73jMCrFMXmLmpe9ggzgFrCRe
        r2plhKgRlDg58wkLiM0MVNO8dTbYpRIC2zklrk9byQTR7CLR9nAOO4QtLPHq+BYoW0bi9OQe
        Fgi7WuLpjd9QzS2MEv0717OBfCAhYC3RdyYHxGQW0JRYv0sfIuooMfkZI4TJJ3HjrSDEBXwS
        k7ZNZ4YI80p0tAlBzFaS2PnzCdROCYnLTXOgdnpIdO04xDKBUXEWkl9mIfllFsLaBYzMqxjF
        U0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLT4el/xz/tYJz76qPeIUYmDsZDjBIczEoivCyG
        0slCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamPIizkas
        4mBpsP50WuPctvaHu/p27og2U5mebnn634VZ6VWyaVysvi9r2u41uefH1544ovB0YuVmucyM
        i2vWV0xmF+xQD878Lee6SNqLX0U65F60bvbKgk96JRlFu46lfqvawGe+5kKil/iDL5uPPzEw
        2Bqb9XxKWimnr1RZikaU1t5tM7MYF2ruTvwUm9vLuqKf7RPbii2O31Zvm/PTwvdg54TCCtEe
        zr/frxh1L7F1zjc5N/FfV/gc/xXvdXduK9KJfuwSs1xQmvuFVbWv+Lmjmg8cW5SqZj7rbsuJ
        XG9/8vKJJyL+L78JOC/98Vt2q9eWiJJDj5lqO3RWvF1z4eDGNt4vPfsvKlycWVPDpsRSnJFo
        qMVcVJwIAI3fKHv2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7rGb+SSDY7+EbVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzG7ZRtbwRaRit2n37A2MP4U6GLk
        5JAQMJGYfGYOUxcjF4eQwFJGiWd7P7BAJCQkbi9sYoSwhSX+XOtigyh6zihxfPU/oCIODjYB
        LYnGTnaQGhGBXInPK3+A1TALvGGS+LJkEhNIQlggUuLO3IVgRSwCqhJX33Wxgti8ApYSp3c8
        ZoVYIC8x89J3sBpOASuJ16tawRYLAdWc/XaDHaJeUOLkzCdgxzED1Tdvnc08gVFgFpLULCSp
        BYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjd9uxn5t3MM579VHvECMTB+MhRgkOZiUR
        XhZD6WQh3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgemj7ySeEMzA1NDEzNLA1NLM2MlcV7P
        go5EIYH0xJLU7NTUgtQimD4mDk6pBibJ5eof5ijMiUs+dUUlI3T+MtMDM1r/3+OaFX+x3PxM
        3zqhxvpP9ySyf3zi3aghPG/fBd3jgUqhG27vbOub3+qkPo+ZaXvfH8F9YjP5eb9POOwRuccr
        LfPi31MHVvTfX/X3oOSlv5H/xOUX7P6sZpMYkMxvt93nXMzshHLlokkng9c+fBRvrPbDUbYq
        ds5Kw7DbNw482hnYEp5efXfVHLPcl9tduN02bg7Zsvfgs21aH+JUb0/v89vmGy2X8cKg6oY6
        f0zK8mZXm0+cJeturVO50+aY7v+u/6r4/7P2mk9MCr75SM06XRrZJi6abXZgxqwF566I/H3M
        vOR38Ym3Aqdc1mV1nZRJDmQr/dsslvhAiaU4I9FQi7moOBEAzfaJO2cDAAA=
X-CMS-MailID: 20220912082211eucas1p2d7cbc34d8ba679e525442128698a1116
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082211eucas1p2d7cbc34d8ba679e525442128698a1116
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082211eucas1p2d7cbc34d8ba679e525442128698a1116
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082211eucas1p2d7cbc34d8ba679e525442128698a1116@eucas1p2.samsung.com>
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

Remove the condition which disallows non-power_of_2 zone size ZNS drive
to be updated and use generic method to calculate number of zones
instead of relying on log and shift based calculation on zone size.

The power_of_2 calculation has been replaced directly with generic
calculation without special handling. Both modified functions are not
used in hot paths, they are only used during initialization &
revalidation of the ZNS device.

As rounddown macro from math.h does not work for 32 bit architectures,
round down operation is open coded.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..fe1d715d61cc 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
-		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
-		status = -ENODEV;
-		goto free_data;
-	}
 
 	disk_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +175,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +191,9 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/* Round down the sector value to the nearest zone start */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1

