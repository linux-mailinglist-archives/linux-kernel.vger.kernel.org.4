Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405AA6A7A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCBDhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCBDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:37:06 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7F515E5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:36:54 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230302033652epoutp041feee088f91e2a7c5f9e18b8403dd4b5~IfOuL3XOD2276622766epoutp04t
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:36:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230302033652epoutp041feee088f91e2a7c5f9e18b8403dd4b5~IfOuL3XOD2276622766epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677728212;
        bh=1dHKyuZlL0P4DI+hxJfy4whngOGz/lEMA5DJX2l/rYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKr0M1AWKo+FdVvyk3OHva46NXjOc5NktlkWULsIXYojhv/f/rZJLC8nkqPuhTFUQ
         El6O3/eqDNBL78OxYUASGhH+5XjhBXSH8uIubjD3BB2tjJ8azh/RTDe9R6WN0VokdZ
         o0C1twHk3NS4VHEBve+QV0GRr7PFt+zN+nh2KRsI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230302033651epcas1p10ffa4c70fae14e8159a4154392b8bd9c~IfOtz_A2m2270322703epcas1p15;
        Thu,  2 Mar 2023 03:36:51 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.224]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PRxc31q1Qz4x9Q7; Thu,  2 Mar
        2023 03:36:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.28.54823.3D910046; Thu,  2 Mar 2023 12:36:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epcas1p1a158f2722d598b5d8a198aa748d9d27b~IfOsvXyqa2267922679epcas1p1e;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302033650epsmtrp14016775bdb86c25691841a23aad30839~IfOsutP8U2681726817epsmtrp1A;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
X-AuditID: b6c32a39-d01fc7000000d627-53-640019d34ca2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.90.05839.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epsmtip2ac1e1466aa79ec60fe06ce60c3dbcb56~IfOsjuETd2525725257epsmtip2B;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v3 4/4] extcon: Added extcon_alloc_groups to simplify extcon
 register function
Date:   Thu,  2 Mar 2023 12:36:45 +0900
Message-Id: <20230302033645.23933-5-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302033645.23933-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmvu5lSYYUgyevuSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGfMuRxZMEa64NX0DawPjK/4uRk4OCQETiSe9J9m6
        GLk4hAR2MEr86GyFcj4xSpxZuIwRwvnGKLHw+Fp2mJYFLRdYIRJ7GSV2L9rMBOH8YpTYePc5
        C0gVm4CGxJ6LDUCzODhEBAolDvdng4SZBdQkHqzaCDZIWCBB4mXLZyYQm0VAVWLH3/tsIDav
        gJXE7Pv9LBDL5CW6//0BszkFrCW+vf3BDlEjKHFy5hMWiJnyEs1bZzOD3CAhsItd4srMFjaI
        ZheJ+b+fMULYwhKvjm+B+kBK4mV/G5SdLrHyyh0oO0fi9f12qHpjiXdv1zKD3M8soCmxfpc+
        RFhRYufvuYwQe/kk3n3tYQUpkRDglehoE4IoUZbofvCCCcKWlFj89A7URA+JXfcWQQO0j1Fi
        W88HtgmMCrOQvDMLyTuzEDYvYGRexSiWWlCcm55abFhgCo/g5PzcTYzgdKdluYNx+tsPeocY
        mTgYDzFKcDArifAuvP0nWYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnAxNuXkm8oYmlgYmZ
        kYmFsaWxmZI4r7jtyWQhgfTEktTs1NSC1CKYPiYOTqkGpg3pwkqzfeZeOiE1RbXEgnlH7YrJ
        bruO1BW0vTWdKTVFPnfO+Qn9i0Uvs7rd6OGcfDgnouL4VWY++cKdqZ7TmY5aiN1dcyzxw+Fb
        iQwC5wSW/DNnLZq/c2fQr8XFgZ7GDPG1Mzs+T/07ycs64mD7a48fi25Gxv3qv8j5pkV8a6bx
        5eAL9W9re2buEbnMspaJt6V8Wt+ZPQb7Ss6Jl6w4oHuBK3ReNuvFoLuOuqdO5suvaCh8E3iH
        8R7L+snGav/cL+XPOZTztXC2qUdP3N4Jyg79UU/3TVpXL+GZXiWuX87S3RW8XnpmxK9eszvn
        V24v/PPySMX1f9ts5xRHX9mreXTlwWtM626nTrF0dC3l01NiKc5INNRiLipOBAAu5qXqAAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSvO4lSYYUg2t3NSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZ8y5HFkwRrrg1fQNrA+Mr
        /i5GTg4JAROJBS0XWLsYuTiEBHYzSkx5u4sZIiEpcXb5I/YuRg4gW1ji8OFiiJofjBJ3Fu5k
        BKlhE9CQ2HOxgQ3EFhEolrhwYDELiM0soCbxYNVGsF5hgTiJXScjQcIsAqoSO/7eByvnFbCS
        mH2/nwVilbxE978/YDangLXEt7c/2EFsIaCaPYt6mSHqBSVOznwCNV5eonnrbOYJjAKzkKRm
        IUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHJRamjsYt6/6oHeIkYmD8RCj
        BAezkgjvwtt/koV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLg
        lGpg2r/r81/x6jMzjYRXNCx8ddDgZ/Kdk88+xP7SOj2ZeWPQpJy5K+OnPt9QYrmm4gf382O3
        l86Z3PruUaL32fyljfMcVCuEnvnam2V0rz22qGLCgl+X7255z5Gd1fSDP/jU2dPPp95i6uVh
        s0r5byYnpvjde0tRUQyblXazqXb7LvGAgyklsmlWFqY+dzq7mvgWcZ/Tbtjeol+eU2+x7W9V
        7j4X9kMTRVqu7tkmeeqX0mMej19C1dmPco4UHeXvaZ4xfe3kilvbuyMtLNzyeSfqyWy+VcUZ
        eMyc8XXBidnTjG72Jy9Q36OcfvNNtvwMqTk3brx/Wb20UKLL/dyp5lsv5BLXpJQevjj3UJH7
        +vVP1ZVYijMSDbWYi4oTAZJ+xmO5AgAA
X-CMS-MailID: 20230302033650epcas1p1a158f2722d598b5d8a198aa748d9d27b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302033650epcas1p1a158f2722d598b5d8a198aa748d9d27b
References: <20230302033645.23933-1-bw365.lee@samsung.com>
        <CGME20230302033650epcas1p1a158f2722d598b5d8a198aa748d9d27b@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc groups is functionalized from extcon_dev_register.

Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 58 +++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 287cf6568661..f91f4084da6e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1181,6 +1181,39 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
 	return 0;
 }
 
+/**
+ * extcon_alloc_groups() - alloc the groups for extcon device
+ * @edev:	extcon device
+ *
+ * Returns 0 if success or error number if fail.
+ */
+static int extcon_alloc_groups(struct extcon_dev *edev)
+{
+	int index;
+
+	if (!edev->max_supported)
+		return 0;
+
+	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
+			sizeof(struct attribute_group *),
+			GFP_KERNEL);
+	if (!edev->extcon_dev_type.groups)
+		return -ENOMEM;
+
+	edev->extcon_dev_type.name = dev_name(&edev->dev);
+	edev->extcon_dev_type.release = dummy_sysfs_dev_release;
+
+	for (index = 0; index < edev->max_supported; index++)
+		edev->extcon_dev_type.groups[index] = &edev->cables[index].attr_g;
+
+	if (edev->mutually_exclusive)
+		edev->extcon_dev_type.groups[index] = &edev->attr_g_muex;
+
+	edev->dev.type = &edev->extcon_dev_type;
+
+	return 0;
+}
+
 /**
  * extcon_dev_register() - Register an new extcon device
  * @edev:	the extcon device to be registered
@@ -1236,28 +1269,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (ret < 0)
 		goto err_alloc_muex;
 
-	if (edev->max_supported) {
-		edev->extcon_dev_type.groups =
-			kcalloc(edev->max_supported + 2,
-				sizeof(struct attribute_group *),
-				GFP_KERNEL);
-		if (!edev->extcon_dev_type.groups) {
-			ret = -ENOMEM;
-			goto err_alloc_groups;
-		}
-
-		edev->extcon_dev_type.name = dev_name(&edev->dev);
-		edev->extcon_dev_type.release = dummy_sysfs_dev_release;
-
-		for (index = 0; index < edev->max_supported; index++)
-			edev->extcon_dev_type.groups[index] =
-				&edev->cables[index].attr_g;
-		if (edev->mutually_exclusive)
-			edev->extcon_dev_type.groups[index] =
-				&edev->attr_g_muex;
-
-		edev->dev.type = &edev->extcon_dev_type;
-	}
+	ret = extcon_alloc_groups(edev);
+	if (ret < 0)
+		goto err_alloc_groups;
 
 	spin_lock_init(&edev->lock);
 	if (edev->max_supported) {
-- 
2.35.1

