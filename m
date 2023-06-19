Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E997349AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFSBSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFSBSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:18:03 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44DE1B5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:18:00 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230619011756epoutp0194712075fcfb883439fe6bef72ef477c~p6piqkVOZ0218602186epoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:17:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230619011756epoutp0194712075fcfb883439fe6bef72ef477c~p6piqkVOZ0218602186epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687137476;
        bh=OleBLvtikVcBHuH8IDNEgE039JVPKNisZ9aLSJ3hOFY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uUWjEbNOYrZBVsKR6SvsyRHr+Tzm+SKq6OcbDSQsPwOGN9VbOALLdOVioWInjHwuQ
         G9tjqiDh0CGLklFvYQs1rB+TKHWbLMTxd9lPbERwvoklQnOVqHx41kBXCIpu4atd8H
         vgCE+QJ8n3HslVaIpRV5UW/9vHGRWo/69f6HnDgM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230619011756epcas5p49e7808cd190e4707f5c73efab94995bb~p6ph6JEVs1902519025epcas5p4a;
        Mon, 19 Jun 2023 01:17:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QksMQ2zqcz4x9Q0; Mon, 19 Jun
        2023 01:17:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.9D.58203.2CCAF846; Mon, 19 Jun 2023 10:17:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268~p6mAmrEJA0421404214epcas5p3L;
        Mon, 19 Jun 2023 01:13:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230619011354epsmtrp22f0aa82bf7f77d011a0707e0336d55d1~p6mAl07Yn1345013450epsmtrp2d;
        Mon, 19 Jun 2023 01:13:54 +0000 (GMT)
X-AuditID: b6c32a4b-c55fd7000001e35b-8e-648facc291aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.81.64355.1DBAF846; Mon, 19 Jun 2023 10:13:54 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230619011352epsmtip1ec693ec61f4bed0d0c8c3f920ba79937~p6l-P13IR2286522865epsmtip1P;
        Mon, 19 Jun 2023 01:13:52 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org, wsa@kernel.org,
        vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min Li <min15.li@samsung.com>
Subject: [PATCH v4] block: add capacity validation in bdev_add_partition()
Date:   Mon, 19 Jun 2023 09:12:14 +0000
Message-Id: <20230619091214.31615-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhu6hNf0pBi8miVmsvtvPZvFgv71F
        8+L1bBY3jr9jtpj7+hKLxcrVR5ks9t7Stri8aw6bxfJVHUwWZyd8YLXYeecEs8XvH0Cxu/vn
        MlrcWHeVxYHPY/MKLY/LZ0s9Nq3qZPPYP3cNu8fumw1sHn1bVjF6fN4kF8AelW2TkZqYklqk
        kJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SvkkJZYk4pUCggsbhY
        Sd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE748Wbj4wFT7kr
        bl/2b2DcxtnFyMkhIWAi8fd9L0sXIxeHkMBuRonGl0cYIZxPjBL/VmxkgXNWv5nFAtPy6dJM
        NojETkaJvtnt7BDOc0aJ13fPMncxcnCwCShLbFvqA9IgItDBKLHlKNg+ZoE4iUtdnewgtrCA
        l0Tnvi9sIDaLgKrEzmWHmUFsXgFLiV8n5kAtk5fYf/AsVFxQ4uTMJywQc+QlmrfOZgbZKyHQ
        yiEx6+NeNogGF4nr+79DNQtLvDq+hR3ClpL4/A6khgPILpZ4+SMMIlwjsfvbbSYI21pi2/p1
        TCAlzAKaEut36UOEZSWmnlrHBLGWT6L39xOocl6JHfNgbCWJvxfOMULYEhKL9z9khbA9JE6/
        PABWIyQQKzH1cA/LBEb5WUi+mYXkm1kImxcwMq9ilEwtKM5NTy02LTDOSy2HR2tyfu4mRnCi
        1fLewfjowQe9Q4xMHIyHGCU4mJVEeIP29qUI8aYkVlalFuXHF5XmpBYfYjQFBvFEZinR5Hxg
        qs8riTc0sTQwMTMzM7E0NjNUEue9eL03RUggPbEkNTs1tSC1CKaPiYNTqoFp/r6Me58Mn2za
        fme/lu/+d4Kfox/k8XNoty03tN+nfW+T5kdVj20ykccuB1/myrMV9xJOOn101ZU99mw9WjsX
        zPT1Or7UcPHPb3WzuBmO1/kxX7GrXXfqSd6BftFDRe9tVuzKjF1mcmYOTz6/7sHFH+RORLlv
        SNm1LLCivuf841Itj5tNcq/uvjKVqFrwc9JVBe7X675JHf48+YV7JLNUcduedn+9P7PNGvy2
        /D/05qNEmdr735cD5bfOd3Evnd4V925ZQnyVPG9CAs8D+aj1Ju/FNIqN16x9G9zxaSnn603H
        566cevTOsr/ffrza9rR8umP1RM+Pf5ZwbXR1PxkrsMu/rqYtSCk2Ucw8gCntmRJLcUaioRZz
        UXEiACYdgX49BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnO6l1f0pBtdfM1qsvtvPZvFgv71F
        8+L1bBY3jr9jtpj7+hKLxcrVR5ks9t7Stri8aw6bxfJVHUwWZyd8YLXYeecEs8XvH0Cxu/vn
        MlrcWHeVxYHPY/MKLY/LZ0s9Nq3qZPPYP3cNu8fumw1sHn1bVjF6fN4kF8AexWWTkpqTWZZa
        pG+XwJXx4s1HxoKn3BW3L/s3MG7j7GLk5JAQMJH4dGkmG4gtJLCdUeLw5xqIuITE+Xm/2CBs
        YYmV/56zdzFyAdU8ZZTY1bCVsYuRg4NNQFli21IfkLiIwCRGifsXXrOCNDALJEh0/DjEDmIL
        C3hJdO77AjaIRUBVYueyw8wgNq+ApcSvE3NYIBbIS+w/eBYqLihxcuYTFog58hLNW2czT2Dk
        m4UkNQtJagEj0ypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4GDXCtrBuGz9X71DjEwcjIcY
        JTiYlUR4g/b2pQjxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFw
        SjUwWamL8195qLNFyv/c4zu6ZnFhppPeWXbPDuGzYd2yetWB55mRJYWz/4iItGouEeVd23hO
        Y99/A584YeOkg6e0am89uf3qiojo3mUL1X3s3vOGH0phyWi1+H1+DWPP/wnH1rj2zivTm3qK
        26TNPXfSys0BfusP+EYmvjnxSHvKXEtex8/B3clvp2fclZgmvrVY4re5sEO18sxfxddXr9J8
        +P9TmMnEgn5rsb0HsreX2cckPDtup7jtaW2Suv0h174ct30WPu9n7i1v1P16yGBa/p1Cx2+3
        7s9TiZBw8GEJuMX3K2va6l65zxaL1kelTwmetp49wVRP87Gs8wRBpRVFLOse1WXvszWQ9XM5
        cmuGEktxRqKhFnNRcSIAMiTDTeUCAAA=
X-CMS-MailID: 20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268
References: <CGME20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268@epcas5p3.samsung.com>
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

In the function bdev_add_partition(),there is no check that the start
and end sectors exceed the size of the disk before calling add_partition.
When we call the block's ioctl interface directly to add a partition,
and the capacity of the disk is set to 0 by driver,the command will
continue to execute.

Signed-off-by: Min Li <min15.li@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
Changes from v1:

- Check for overflows of the start + length value
- Place the capacity check at the beginning of the function.

Changes from v2:

- Place the assignment on the first line and merge the two lines into one

Changes from v3:

- Modify the singed name
---
 block/partitions/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..b511f88bf558 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -436,10 +436,21 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length)
 {
+	sector_t capacity = get_capacity(disk), end;
 	struct block_device *part;
 	int ret;
 
 	mutex_lock(&disk->open_mutex);
+	if (check_add_overflow(start, length, &end)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (start >= capacity || end > capacity) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!disk_live(disk)) {
 		ret = -ENXIO;
 		goto out;
-- 
2.34.1

