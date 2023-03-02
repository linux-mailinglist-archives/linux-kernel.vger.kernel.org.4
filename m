Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953466A7A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCBDhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCBDhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:37:07 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096D515CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:36:54 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230302033652epoutp01da5b06316e1a1a95952a8f144abe9844~IfOuMKYmI2023720237epoutp01k
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:36:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230302033652epoutp01da5b06316e1a1a95952a8f144abe9844~IfOuMKYmI2023720237epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677728212;
        bh=RlkHcGEoE1hG3usQpYe+zNFdCyZiaVIU2Mr4u85JovI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iocjsdUH2v2JbyWF5NU76+cut4I6geF2Ec7Tx0EsJAwNCGoHup8nK8UX/U1PZGuEB
         U9SljoLronVktk6Mp3VgdD4sx6jVDQ/2gXHmjYojwE+R1pFVGBpcCbRIT4U7kacf1A
         It8NdZFdsWwcgb5Y4mRYNcWWXmwe6Jyzw4RF2SZQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230302033651epcas1p263c4b0a139e0832f457b2ecead1d18ed~IfOt3akDv0032700327epcas1p2v;
        Thu,  2 Mar 2023 03:36:51 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.247]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PRxc304Vcz4x9Q6; Thu,  2 Mar
        2023 03:36:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.28.54823.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epcas1p4b8a23f7c6a931200a9d0270cd00aaf6e~IfOsrdOw03274032740epcas1p4M;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302033650epsmtrp18e5a05f02fe044e531565b0b2a83cf61~IfOsq2-j52681726817epsmtrp1-;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-52-640019d2e3a1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.90.05839.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epsmtip2ea7e7ef29c672c668d8833caaf4598f6~IfOscaBl72452424524epsmtip2X;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v3 3/4] extcon: Added extcon_alloc_muex to simplify extcon
 register function
Date:   Thu,  2 Mar 2023 12:36:44 +0900
Message-Id: <20230302033645.23933-4-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302033645.23933-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmru4lSYYUg5UfTC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGR/3HWMsmCtf0b7wB2sD4yeJLkZODgkBE4kTpw+z
        dzFycQgJ7GCUaHh2ixHC+cQocWvuPyYI5xujxMLZixhhWma9uAKV2Mso8Wj/A6j+X4wS13f3
        s4JUsQloSOy52MDWxcjBISJQKHG4PxskzCygJvFg1UZ2EFtYIE6i/+9nsKEsAqoS6xdMYQOx
        eQWsJO5/OsMGsUxeovvfHxYQm1PAWuLb2x/sEDWCEidnPmGBmCkv0bx1NjPIDRIC+9gldm1c
        AHWpi0TTrHlQg4QlXh3fwg5hS0m87G+DstMlVl65A2XnSLy+3w7Vayzx7u1aZpD7mQU0Jdbv
        0ocIK0rs/D2XEWIvn8S7rz2sICUSArwSHW1CECXKEt0PXjBB2JISi5/eYYQo8ZD4eEIdElJ9
        jBIt2/tYJzAqzELyzSwk38xCWLyAkXkVo1hqQXFuemqxYYEpPIKT83M3MYLTnZblDsbpbz/o
        HWJk4mA8xCjBwawkwrvw9p9kId6UxMqq1KL8+KLSnNTiQ4ymwLCeyCwlmpwPTLh5JfGGJpYG
        JmZGJhbGlsZmSuK84rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqY9i+z3nfn/mXfRw99D54VvH1H
        aX25eMiVmwJdt+YJNVzZXL9cMb/r526D1vULa97lLWZgijt263tI7dXzHWzfsiuTZjO+NT7u
        dNZhTn42w75bmzn3H9CuD72/T5s1uUXIxW7tA7UI8V3yv2ZHJS7e4v9LmWvt+umszad2Gk6X
        VTwn7N2aO1Xf3+aw6Lm8dSz7+C6//HJ6zrxX/s27PZ0DYuy8tmhsnDJvT3tuV3/6trI9KrE9
        6eISdR/7pgq7Ta2pSPzSv/23JU+s29b7c67nWuWyprG8PMAmeGi578u3JyVzGW0mnPEPbXhQ
        UFcc+CZR+MHtn1P1m5c3Xt0w4bH57N2+U86LPbPrXqXXsPThXiWW4oxEQy3mouJEAEeKA2sA
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO4lSYYUg5drlSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZH/cdYyyYK1/RvvAHawPj
        J4kuRk4OCQETiVkvrjB1MXJxCAnsZpS4t3s5M0RCUuLs8kfsXYwcQLawxOHDxRA1PxglpmxY
        zgRSwyagIbHnYgMbiC0iUCxx4cBiFhCbWUBN4sGqjewgtrBAjMTFh3dZQWwWAVWJ9QumgNXz
        ClhJ3P90hg1il7xE978/YL2cAtYS397+AOsVAqrZs6iXGaJeUOLkzCdQ8+UlmrfOZp7AKDAL
        SWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBgamluYNx+6oPeocYmTgY
        DzFKcDArifAuvP0nWYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQYmhUKTuu19p1ZflpqYOH9ChdkkVc42yxM5Vun8O+7dkVnHH17zumKerumbqW37nzxf
        bZ2/y+bfsdLmfs7CiY4ayxvk9s/nvBVfadKz5JrqPruHWXKq7wtVmqYdZ37mlOvO4BcSkXVt
        z59VUz/NfHNo0fdpLidOXJ24oeR2VKrSpk37TFqEwqw+H/1wyXhKzNL1jjFnuDdkvlimF94b
        qvzBsPLe5rRCdem1OQ+a2oU+Tb9z44PFqv4jybtEb2w5viV93TZN+eYcThc1Zv/sp0s2Zdzs
        vLYl71x//F7ta3c72fZvf1/ctlzT6tan6pfl+jNu37wotaRcPzGSY92Bw4lLzmtyPJNuKloo
        rD6nUEclV4mlOCPRUIu5qDgRABII+fa7AgAA
X-CMS-MailID: 20230302033650epcas1p4b8a23f7c6a931200a9d0270cd00aaf6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302033650epcas1p4b8a23f7c6a931200a9d0270cd00aaf6e
References: <20230302033645.23933-1-bw365.lee@samsung.com>
        <CGME20230302033650epcas1p4b8a23f7c6a931200a9d0270cd00aaf6e@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutual exclusive part is functionalized from extcon_dev_register.

Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 106 ++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 388a3d906075..287cf6568661 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1127,6 +1127,60 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
 	return 0;
 }
 
+/**
+ * extcon_alloc_muex() - alloc the mutual exclusive for extcon device
+ * @edev:	extcon device
+ *
+ * Returns 0 if success or error number if fail.
+ */
+static int extcon_alloc_muex(struct extcon_dev *edev)
+{
+	char *name;
+	int index;
+
+	if (!(edev->max_supported && edev->mutually_exclusive))
+		return 0;
+
+	/* Count the size of mutually_exclusive array */
+	for (index = 0; edev->mutually_exclusive[index]; index++)
+		;
+
+	edev->attrs_muex = kcalloc(index + 1,
+				   sizeof(struct attribute *),
+				   GFP_KERNEL);
+	if (!edev->attrs_muex)
+		return -ENOMEM;
+
+	edev->d_attrs_muex = kcalloc(index,
+				     sizeof(struct device_attribute),
+				     GFP_KERNEL);
+	if (!edev->d_attrs_muex) {
+		kfree(edev->attrs_muex);
+		return -ENOMEM;
+	}
+
+	for (index = 0; edev->mutually_exclusive[index]; index++) {
+		name = kasprintf(GFP_KERNEL, "0x%x",
+				 edev->mutually_exclusive[index]);
+		if (!name) {
+			for (index--; index >= 0; index--)
+				kfree(edev->d_attrs_muex[index].attr.name);
+
+			kfree(edev->d_attrs_muex);
+			kfree(edev->attrs_muex);
+			return -ENOMEM;
+		}
+		sysfs_attr_init(&edev->d_attrs_muex[index].attr);
+		edev->d_attrs_muex[index].attr.name = name;
+		edev->d_attrs_muex[index].attr.mode = 0000;
+		edev->attrs_muex[index] = &edev->d_attrs_muex[index].attr;
+	}
+	edev->attr_g_muex.name = muex_name;
+	edev->attr_g_muex.attrs = edev->attrs_muex;
+
+	return 0;
+}
+
 /**
  * extcon_dev_register() - Register an new extcon device
  * @edev:	the extcon device to be registered
@@ -1178,53 +1232,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (ret < 0)
 		goto err_alloc_cables;
 
-	if (edev->max_supported && edev->mutually_exclusive) {
-		char *name;
-
-		/* Count the size of mutually_exclusive array */
-		for (index = 0; edev->mutually_exclusive[index]; index++)
-			;
-
-		edev->attrs_muex = kcalloc(index + 1,
-					   sizeof(struct attribute *),
-					   GFP_KERNEL);
-		if (!edev->attrs_muex) {
-			ret = -ENOMEM;
-			goto err_muex;
-		}
-
-		edev->d_attrs_muex = kcalloc(index,
-					     sizeof(struct device_attribute),
-					     GFP_KERNEL);
-		if (!edev->d_attrs_muex) {
-			ret = -ENOMEM;
-			kfree(edev->attrs_muex);
-			goto err_muex;
-		}
-
-		for (index = 0; edev->mutually_exclusive[index]; index++) {
-			name = kasprintf(GFP_KERNEL, "0x%x",
-					 edev->mutually_exclusive[index]);
-			if (!name) {
-				for (index--; index >= 0; index--) {
-					kfree(edev->d_attrs_muex[index].attr.
-					      name);
-				}
-				kfree(edev->d_attrs_muex);
-				kfree(edev->attrs_muex);
-				ret = -ENOMEM;
-				goto err_muex;
-			}
-			sysfs_attr_init(&edev->d_attrs_muex[index].attr);
-			edev->d_attrs_muex[index].attr.name = name;
-			edev->d_attrs_muex[index].attr.mode = 0000;
-			edev->attrs_muex[index] = &edev->d_attrs_muex[index]
-							.attr;
-		}
-		edev->attr_g_muex.name = muex_name;
-		edev->attr_g_muex.attrs = edev->attrs_muex;
-
-	}
+	ret = extcon_alloc_muex(edev);
+	if (ret < 0)
+		goto err_alloc_muex;
 
 	if (edev->max_supported) {
 		edev->extcon_dev_type.groups =
@@ -1292,7 +1302,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 		kfree(edev->d_attrs_muex);
 		kfree(edev->attrs_muex);
 	}
-err_muex:
+err_alloc_muex:
 	for (index = 0; index < edev->max_supported; index++)
 		kfree(edev->cables[index].attr_g.name);
 err_alloc_cables:
-- 
2.35.1

