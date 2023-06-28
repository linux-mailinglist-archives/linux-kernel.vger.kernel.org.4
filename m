Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55D740BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjF1I4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:56:31 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21520 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjF1Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:32:33 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230628060406epoutp046f0a12486222ea8b734c4ca949fbf8b9~svW94rc2j2153821538epoutp04g
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:04:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230628060406epoutp046f0a12486222ea8b734c4ca949fbf8b9~svW94rc2j2153821538epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687932246;
        bh=1J0GA8jA4OUCQy/o7Wr1UV/l6aUJqp3vp4GqzSVMq34=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gHWPpnzdNaowUfBnb8O12Ax06bsrdSv5UTqpOu/v2/Eipj3ml94JDfujC7cyMrDsH
         QWU1OY1rDWBwDxMFGP3578ovVOn6E0FIHhzSSTODN3+P2+nBIrgIkmMzuX8hWC+54B
         m2TBewcIXGc5mKgqZkPmP0UrM6viTufHceFwgTQw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230628060406epcas5p1b07b2ffdedda603499d565a0c801a436~svW9hDb5i0452904529epcas5p1Q;
        Wed, 28 Jun 2023 06:04:06 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QrWHS5QZBz4x9Q0; Wed, 28 Jun
        2023 06:04:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.51.06099.45DCB946; Wed, 28 Jun 2023 15:04:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230628051122epcas5p45d70f2c36ce91b60863f702de1534321~suo63XkqC1272712727epcas5p4X;
        Wed, 28 Jun 2023 05:11:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230628051122epsmtrp104a14031214eb43558622326ce5397d0~suo62c5y60727707277epsmtrp1R;
        Wed, 28 Jun 2023 05:11:22 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-e4-649bcd5436b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.AE.34491.AF0CB946; Wed, 28 Jun 2023 14:11:22 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230628051120epsmtip2557b4491a4e53bf72b782da715fa63f3~suo5chpNN2817628176epsmtip2r;
        Wed, 28 Jun 2023 05:11:20 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Min Li <min15.li@samsung.com>
Subject: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Date:   Wed, 28 Jun 2023 13:09:41 +0000
Message-Id: <20230628130941.10690-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmum7I2dkpBhc3qVmsvtvPZvFgv71F
        8+L1bBY3jr9jtpj7+hKLxcrVR5ks9t7Stri8aw6bxfJVHUwWZyd8YLX4dP4Cm8XvH0CxG+uu
        sjjwemxeoeVx+Wypx6ZVnWwe++euYffYfbOBzaNvyypGj8+b5ALYo7JtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BOVVIoS8wpBQoFJBYXK+nb2RTl
        l5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2y+MY2x4KxgxZ89m9gb
        GGfwdTFyckgImEgcODOfrYuRi0NIYDejxOU/a1hBEkICnxglug+KQyS+MUosfHmUHabj7LbV
        jBBFexkltl43gyh6ziixZMZloAQHB5uAssS2pT4gNSICaRJLO36ygdjMAoUSP751MIPYwgIJ
        EvNfbWQCsVkEVCU6z3WCLeYVsJRYu/MoM8QueYn9B88yQ8QFJU7OfMICMUdeonnrbKiaRg6J
        viMSELaLxMT//6DiwhKvjm+BullK4mV/GzvIaRICxRIvf4RBhGskdn+7zQRhW0tsW7+OCaSE
        WUBTYv0ufYiwrMTUU+uYILbySfT+fgJVziuxYx6MrSTx98I5RghbQmLx/oesELaHxLl/d1kg
        IRUrMbXnIMsERvlZSJ6ZheSZWQibFzAyr2KUTC0ozk1PLTYtMM5LLYdHanJ+7iZGcGrV8t7B
        +OjBB71DjEwcjIcYJTiYlUR4xX5MTxHiTUmsrEotyo8vKs1JLT7EaAoM4YnMUqLJ+cDknlcS
        b2hiaWBiZmZmYmlsZqgkznvxem+KkEB6YklqdmpqQWoRTB8TB6dUA5O+ceETtv2bi3Q1ZSd1
        nnqz/LHp5M1HNx/KUfm58DnzusuR5y7+eDRFbcmCv7x2/v/vB/979POH06amS99udCz+b85o
        9jPk0Irz+yV+tPG/fTHF8d2VO3HCsjW7OGc4uqo2vJzddcj/wi+2+d5f6jJXvVvxwPFb3svw
        U3NsTQ5lp1RMl/3f4XG7IUWA2ezewz9/DK9P+yn6PmbXbPUd/zUXCik8Tn8fWjdJ+D3L65j+
        j6vvlzkYRlvETHh4tKX+5fLJ7qlMrFMbDu22P7N78hxWDZMSl48a8k7MJ/9armJl6hTLky6O
        cpBTj7612mmVnoJz11GLNQd+6U+W9L11Kv9cyO/8K8u/zpW4lvxZ2vkYsxJLcUaioRZzUXEi
        ANGY6Uw2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO6vA7NTDFbvFrFYfbefzeLBfnuL
        5sXr2SxuHH/HbDH39SUWi5WrjzJZ7L2lbXF51xw2i+WrOpgszk74wGrx6fwFNovfP4BiN9Zd
        ZXHg9di8Qsvj8tlSj02rOtk89s9dw+6x+2YDm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBl
        bL4xjbHgrGDFnz2b2BsYZ/B1MXJySAiYSJzdtpqxi5GLQ0hgN6PEtK5djBAJCYnz836xQdjC
        Eiv/PWeHKHrKKNF8+D6Qw8HBJqAssW2pD4gpIpAjseK7P0g5s0CpxNbbTewgtrBAHFB4KguI
        zSKgKtF5rpMVxOYVsJRYu/MoM8R4eYn9B88yQ8QFJU7OfMICMUdeonnrbOYJjHyzkKRmIUkt
        YGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHOpamjsYt6/6oHeIkYmD8RCjBAez
        kgiv2I/pKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqY
        cl3/3Zhi0nH7hdtxju23HwkdeJ4Ua/ttyrTMnNbny9imbr8nIyP7ZvF2yYlppnemV85TDeOU
        kNgUs/XX67WBfVn2HDMk95/Z1GpyRVXmDuPFQLkgnXU3gj8vC/56+inXfv3j2/rvXJiZs1FX
        acM02zO/s+wS/GZdlM60NhGvXcD/t7NbZHaGSOcnm1llYqybnFU3n8jl7473OuCjnv/1ettx
        Xvu2vcoWXNIpQZmfF+y4/nR2wH61jlUNhp0/yqqX2q1nEQ1ZfXlX1w/esNVNfMvW9hqZCYRe
        3d599T+/jrGHip3I/7zjx2qNzHITn109dn7itBJF189me7e8flV9okVT8E/kwn2vTZ8+9Ptg
        rcRSnJFoqMVcVJwIAFGzsWPkAgAA
X-CMS-MailID: 20230628051122epcas5p45d70f2c36ce91b60863f702de1534321
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230628051122epcas5p45d70f2c36ce91b60863f702de1534321
References: <CGME20230628051122epcas5p45d70f2c36ce91b60863f702de1534321@epcas5p4.samsung.com>
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

Signed-off-by: Min Li <min15.li@samsung.com>

---
Changes from v1:

- Add a space after /* and before */.
- Move length alignment check before the "start = p.start >> SECTOR_SHIFT"
- Move check for p.start being aligned together with this length alignment check.

Changes from v2:

- Add the assignment on the first line and merge the two lines into one.
- Use IS_ALIGNED function to check alignment.
---
 block/ioctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3be11941fb2d..1a351132bf4e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -16,9 +16,9 @@
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
+	long long blksz = bdev_logical_block_size(bdev), start, length;
 	struct gendisk *disk = bdev->bd_disk;
 	struct blkpg_partition p;
-	long long start, length;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -33,14 +33,15 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
+	/* Check that the partition is aligned to the block size */
+	if (!IS_ALIGNED(p.start | p.length, blksz))
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

