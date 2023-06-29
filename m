Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6215741E45
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF2CaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjF2CaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:30:20 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC01BE4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 19:30:17 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230629023013epoutp04f348cd7d4f926c62f8357a6b46c52268~tAFf-lqck1008310083epoutp04h
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:30:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230629023013epoutp04f348cd7d4f926c62f8357a6b46c52268~tAFf-lqck1008310083epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688005813;
        bh=O0eE20a/HBLrMkmuqgRHpbrSQmDarVAefptM3rzo4z0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=D8LxJ7EuCARRvHVwIfAvZAXav6hNeKXSuZUB+jC8DGyiVZqTSe1UDjsM1nLuvPRHb
         bEniHV/G3wHePvhl7mKKt0IlfQCdPZmunawPxrUhojG+HtvbkJRVJCoxp/nzc51tpB
         NX/rj6MrJOrjeYiP9qGtNTJH3Drms1u+oy0JWqik=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230629023012epcas5p3968fe95b7c0c53814dd746ed98ab439f~tAFfJLSvk1161911619epcas5p3T;
        Thu, 29 Jun 2023 02:30:12 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qs2VB2XMbz4x9Pp; Thu, 29 Jun
        2023 02:30:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.2F.55522.2BCEC946; Thu, 29 Jun 2023 11:30:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230629022807epcas5p23765f81f547eed72135c802f83543908~tADqpu1Kv1886318863epcas5p2L;
        Thu, 29 Jun 2023 02:28:07 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230629022807epsmtrp234c155afb9c8e0754095ca248174a1ea~tADqo5-qo2057720577epsmtrp2K;
        Thu, 29 Jun 2023 02:28:07 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-b7-649cecb2f931
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.FC.64355.73CEC946; Thu, 29 Jun 2023 11:28:07 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230629022805epsmtip2899b981322b7361e068a71d950dddce6~tADpTf30f1947319473epsmtip2P;
        Thu, 29 Jun 2023 02:28:05 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Min Li <min15.li@samsung.com>
Subject: [PATCH v4] block: add check that partition length needs to be
 aligned with block size
Date:   Thu, 29 Jun 2023 10:26:23 +0000
Message-Id: <20230629102623.7410-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmuu6mN3NSDH5vEbJYfbefzeLBfnuL
        5sXr2SxuHH/HbDH39SUWi5WrjzJZ7L2lbXF51xw2i+WrOpgszk74wGqxYOMjRovfP4BiN9Zd
        ZXHg9di8Qsvj8tlSj02rOtk89s9dw+6x+2YDm0ffllWMHp83yQWwR2XbZKQmpqQWKaTmJeen
        ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCdqqRQlphTChQKSCwuVtK3synK
        Ly1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzujZfYGtoF+4Yt+0+8wN
        jGv5uxg5OSQETCT+3NnCDGILCexmlHjVxNTFyAVkf2KU+DVlDgucM/fWZRaYjnt7p7NCdOxk
        lGje4ApR9JxR4u+MvexdjBwcbALKEtuW+oDUiAikSSzt+MkGYjMLlEn8vHQNbJuwQILEnJeN
        bCDlLAKqEn+agkDCvAIWEtv/b2SGWCUvsf/gWWaIuKDEyZlPWCDGyEs0b50NVfOXXeLpEzkI
        20Wi7cF8NghbWOLV8S3sELaUxOd3e8FWSQgUS7z8EQYRrpHY/e02E4RtLbFt/TomkBJmAU2J
        9bv0IcKyElNPrWOC2Mon0fv7CVQ5r8SOeTC2ksTfC+cYIWwJicX7H7JCbPKQ2LNYGRJOsRJn
        599mnMAoPwvJL7OQ/DILYfECRuZVjJKpBcW56anFpgWGeanl8ChNzs/dxAhOq1qeOxjvPvig
        d4iRiYPxEKMEB7OSCO/tN7NThHhTEiurUovy44tKc1KLDzGaAsN3IrOUaHI+MLHnlcQbmlga
        mJiZmZlYGpsZKonzHj7TmyIkkJ5YkpqdmlqQWgTTx8TBKdXApHjI3tJVVXGBKuO3lFhnxk/9
        S/jWmOzZHjs97J+38Lnodvsy3WtMqTJn14QZLlQ8+dFb5npMwpvOaaWX8x/uXr/za2bvVz8+
        7y2pH/7lrtDgevJj081rNyZEr6g5ecc2+67vBO57B+/cry3NfHU3TIC77WtN4z+P3bIev7+9
        UJB5anBpf73b2882e7v3LXlpoLAxQOjVlxSvEwJHY5ale05dkRlmd8gwg4v3ajfXNDmlY+nS
        1ZP5xGZwsxsZXJWff63RMePK7vfdsR+D/F4+SEvxLW88FFZmvdLx1mXmvNqXKpP+uhpkTq5e
        vz3l3yfhdWdNYxm+LHR/rf6Nt+r5tDMKPasahU78ctJaaBXxS4mlOCPRUIu5qDgRALM4NLc0
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK75mzkpBotfcFmsvtvPZvFgv71F
        8+L1bBY3jr9jtpj7+hKLxcrVR5ks9t7Stri8aw6bxfJVHUwWZyd8YLVYsPERo8XvH0CxG+uu
        sjjwemxeoeVx+Wypx6ZVnWwe++euYffYfbOBzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy
        enZfYCvoF67YN+0+cwPjWv4uRk4OCQETiXt7p7OC2EIC2xklnq4thIhLSJyf94sNwhaWWPnv
        OXsXIxdQzVNGiYVP2lm6GDk42ASUJbYt9QExRQRyJFZ89wcpZxaokrg6dR8TSFhYIE5iyS51
        EJNFQFXiT1MQSAWvgIXE9v8bmSGGy0vsP3iWGSIuKHFy5hMWiCnyEs1bZzNPYOSbhSQ1C0lq
        ASPTKkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzg4NYK2sG4bP1fvUOMTByMhxglOJiVRHhv
        v5mdIsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cBkbHXv
        zpbFfwK+NgvO59a5uCvoyw42W4aJDJc43h3fkhtyxH+z5oF8v+5ENivhV1V9QVJOqvdkv1nf
        ETU4nlJ9+TJ3MRf/shkb3C8v2aT+QHql1uus8hfrnlbKekZ+/fY5avnNl21ebJNsOa682XNV
        i/1Q5uyFqWsXL6iLCTieeU19w+Mt574bGZUt278nKmdpxKvZCp7t3z6Ff7+bOSPnVo5Phrfh
        Z6EVTnuPfw12VHvYvV7xxeEXCVMehRYFhZqoTm1OEf3huFI9sCv00FMGgUq/ydNaE+SmfTdt
        nap7MI7nVmvZREWpl+fSun72h2y+e3rHA5Yv4UuX361r/pjjn/4kKOttGd/7KTw3njnKKLEU
        ZyQaajEXFScCAEOmG4/dAgAA
X-CMS-MailID: 20230629022807epcas5p23765f81f547eed72135c802f83543908
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230629022807epcas5p23765f81f547eed72135c802f83543908
References: <CGME20230629022807epcas5p23765f81f547eed72135c802f83543908@epcas5p2.samsung.com>
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
---
 block/ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3be11941fb2d..a8061c2fcae0 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -16,9 +16,10 @@
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
+	unsigned int blksz = bdev_logical_block_size(bdev);
 	struct gendisk *disk = bdev->bd_disk;
 	struct blkpg_partition p;
-	long long start, length;
+	sector_t start, length;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -33,14 +34,17 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
+	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+		return -EINVAL;
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

