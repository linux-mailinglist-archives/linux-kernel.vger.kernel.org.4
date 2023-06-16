Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC29732876
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbjFPHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbjFPHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:09:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5147A35A8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:09:42 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230616070939epoutp032cf580f3b43af4933a8b729d5e4ae44b~pEgxc59T20808608086epoutp03z
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:09:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230616070939epoutp032cf580f3b43af4933a8b729d5e4ae44b~pEgxc59T20808608086epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686899379;
        bh=ESo4Qrt4/UzE/PV3aK8PFaKJ3Kztgy5rxcClb0hRKmc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jnXAOL2dM+MhjPSMkYXqlPLmvKiLfVbeuucEjd1t2hY4M8nXBp4qeHdkGQI3nvnwR
         MoEhS3g81fYMK2I5XfOOzFImdM1oOb7D+tmdCteKpqFwC32xNed8x1aYKAgu+4QnVc
         p1Np0pQgm6Aj5N/0WjMYKrs+Z3HHx/EDNaKAmeew=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230616070939epcas5p14d6eff9fa2c61884ebf49ea566b64ce7~pEgw0I_8D0795507955epcas5p1h;
        Fri, 16 Jun 2023 07:09:39 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qj9Jc60MBz4x9Px; Fri, 16 Jun
        2023 07:09:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.F6.44881.0BA0C846; Fri, 16 Jun 2023 16:09:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230616030739epcas5p31e705be33bf080f988702d42534ad32f~pBNek5lzt0688706887epcas5p3t;
        Fri, 16 Jun 2023 03:07:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230616030739epsmtrp283d0995d1319be1df91759e62bebc516~pBNej8Gzx0328103281epsmtrp2h;
        Fri, 16 Jun 2023 03:07:39 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-79-648c0ab0f079
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.31.27706.BF1DB846; Fri, 16 Jun 2023 12:07:39 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230616030738epsmtip2e4561c1f033fd4eb8ba466cd88c6fa6e~pBNdM9Vog3041530415epsmtip2w;
        Fri, 16 Jun 2023 03:07:38 +0000 (GMT)
From:   "min15.li" <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org, wsa@kernel.org,
        vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "min15.li" <min15.li@samsung.com>
Subject: [PATCH v2] block: add capacity validation in bdev_add_partition()
Date:   Fri, 16 Jun 2023 11:05:57 +0000
Message-Id: <20230616110557.12106-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmhu4Grp4Ug5aj+har7/azWTzYb2/R
        vHg9m8WN4++YLea+vsRisXL1USaLvbe0LS7vmsNmsXxVB5PF2QkfWC123jnBbPH7B1Ds7v65
        jBY31l1lceDz2LxCy+Py2VKPTas62Tz2z13D7rH7ZgObR9+WVYwenzfJBbBHZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2rpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOeLetkbXgCGfF
        z+tSDYzX2bsYOTkkBEwkPvYtYwaxhQR2M0p037TpYuQCsj8xSmx4OpsdwvnGKLGnezojTMfU
        Lf2sEB17GSXuTneGsJ8DFZ0Bi7MJqEsc+HgUbIOIQAejxJajnCA2s0CSxIxlv9lAbGEBL4l5
        L06C1bMIqErMnnkUbD6vgKVE994PzBC75CX2HzzLDBEXlDg58wkLxBx5ieats5lBjpMQ6OWQ
        aPz9HOo4F4nZn34zQdjCEq+Ob4F6U0ri87u9QIs5gOxiiZc/wiDCNRK7v92GKreW2LZ+HRNI
        CbOApsT6XfoQYVmJqafWMUGs5ZPo/f0EqpxXYsc8GFtJ4u+Fc1AXSEgs3v+QFWKTh8T2fnNI
        6MRKPPzWxjKBUX4WkmdmIXlmFsLiBYzMqxglUwuKc9NTi00LjPJSy+Fxmpyfu4kRnGK1vHYw
        PnzwQe8QIxMH4yFGCQ5mJRHeZSe6UoR4UxIrq1KL8uOLSnNSiw8xmgJDeCKzlGhyPjDJ55XE
        G5pYGpiYmZmZWBqbGSqJ86rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYJq9atWkggNLL9eHTm95
        7jAn5O2sNebKZ5hMJE0vPTzIVzR/P3+aUOSi896WF/IiRea73r7rcOLa9tDfEovKfly8fK3y
        QODah19vcjS7G+2wEUuq2yTfNP9KvLWyyR61ymnMq2KnNodz3Xj7uN64tuuTt8Aqp0WB8Xo6
        5lvbgm2f6z+YKvio69rJlXV7bsyRflrwaMaByjUlviU7XqxLnvT9/5ZVsU+qb/tlmi1dKMnH
        2Rn1ZULRnowrldc+Pz767SPjtmPdktmf3WxmOj/dtmhrLp/yVNmzwlbK/lo5TD9V52hd2a4i
        sN3x5v10tuMlPzZ/1ptl6LO2dfe/oAmvP79qEImetynbMCRh707Od6mWSizFGYmGWsxFxYkA
        KjEAsToEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvO7vi90pBnMuKlisvtvPZvFgv71F
        8+L1bBY3jr9jtpj7+hKLxcrVR5ks9t7Stri8aw6bxfJVHUwWZyd8YLXYeecEs8XvH0Cxu/vn
        MlrcWHeVxYHPY/MKLY/LZ0s9Nq3qZPPYP3cNu8fumw1sHn1bVjF6fN4kF8AexWWTkpqTWZZa
        pG+XwJXxblsja8ERzoqf16UaGK+zdzFyckgImEhM3dLP2sXIxSEksJtRYu/fG0wQCQmJ8/N+
        sUHYwhIr/z1nhyh6yijxc8ljFpAEm4C6xIGPR8ESIgKTGCXuX3jNCpJgFkiRuLK0E2yFsICX
        xLwXJ8HiLAKqErNnHmUEsXkFLCW6935ghtggL7H/4FlmiLigxMmZT1gg5shLNG+dzTyBkW8W
        ktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCA19Lcwfj9lUf9A4xMnEw
        HmKU4GBWEuFddqIrRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQam5Cm5T9f9zVm4+/eUCVfEVobNunN4+9S5/3/sYXkXeu38kxJml57D/yp1uWWOr93r
        6Kh95LzZ151WK51OaLnu223RKe0csvlW1OSW2woNxVZyjBt/Zzz5HuvTvIYhLK22eQpDa8bb
        GweUD2+1jNl0q7yGYRtvkf+6fy/kM3o6fit76Gws7elo/h8zcY6N0s951/ru9q/7+/H9ruCO
        TLVI+9XiB14IRH0WvVi2pWvqJPHz8hpsFl9+exnvS7p39l/x2b2nrHL4TspFJTLKGpRmL52e
        8PvWWbvOD1nyVyziLyfk6eybKfu5Y/pDrf/ravQ+zPvTu6XryLQ1U1ilrq05rp/7JnvC/q9s
        Glz/VFek2SixFGckGmoxFxUnAgChOTjy6wIAAA==
X-CMS-MailID: 20230616030739epcas5p31e705be33bf080f988702d42534ad32f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230616030739epcas5p31e705be33bf080f988702d42534ad32f
References: <CGME20230616030739epcas5p31e705be33bf080f988702d42534ad32f@epcas5p3.samsung.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
v1->v2: check for overflows of the start + length value and put
the capacity check at the beginning of the function.

Signed-off-by: min15.li <min15.li@samsung.com>
---
 block/partitions/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..3546b43d5124 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -438,8 +438,20 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 {
 	struct block_device *part;
 	int ret;
+	sector_t end;
+	sector_t capacity = get_capacity(disk);
 
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

