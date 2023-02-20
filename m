Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6A69C510
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjBTFqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBTFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:45:53 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316ACD50B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:45:51 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220054547epoutp03a71e9c13552cace11a977d2132304065~Fciblhrh20689906899epoutp03Z
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220054547epoutp03a71e9c13552cace11a977d2132304065~Fciblhrh20689906899epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676871947;
        bh=15QEWNO/YBw7mVP+MxhNzSlTSz4ta3BdtNp9n1HdAJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYT1e+EFvJoj9heuhExsaJ5z1ISzeVoyPoky3K/wcvrJbzAp3i/ryh09uAPEPIP7t
         mdudYHuqGcC9rhL8SfMgButAkWY4wtuOW21Kgd44ygXUMbxZKZsyCluySyyr690JPG
         PZvwpcPGjJhPlfj+dzrbx0oCBBbNQqYB9gE+uUEI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230220054547epcas1p3bbd0305c4f4844a56fdd838a4fd683f1~FcibFpyhr1540715407epcas1p3t;
        Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PKrxQ09VSz4x9QB; Mon, 20 Feb
        2023 05:45:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.A5.37890.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925~FciZ0mNeM1540715407epcas1p3q;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220054545epsmtrp273db62166c22ca59eee32c0ca130556a~FciZz7K3Z0972009720epsmtrp2i;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
X-AuditID: b6c32a38-bbd3aa8000029402-14-63f30909823a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.5A.05839.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epsmtip106c71a61c85c67776e2da3f7d27f1905~FciZqv6Ut2598425984epsmtip1k;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to simplify extcon
 register function
Date:   Mon, 20 Feb 2023 14:45:11 +0900
Message-Id: <20230220054513.27385-3-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230220054513.27385-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmni4n5+dkg0uzrS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGR8b5rEXHJKr2DZlAnsD4xGJLkZODgkBE4n3jQfY
        uhi5OIQEdjBKXFx4kwXC+cQocfLTBqjMN0aJ6ct72GFaPm37zAJiCwnsZZT48k8UougXo8Sm
        xWvAEmwCGhJ7LjYAdXNwiAgUShzuzwYJMwuoSTxYtRFsjrBAgsTcvgVsIDaLgKrEpZN3mUDK
        eQWsJPpWuEKskpfo/vcHbCKngLXEv+eLwMp5BQQlTs58wgIxUl6ieetsZpATJAT2sUu8OHGT
        CaLZReL6wrdQtrDEq+NboO6Xkvj8bi8bhJ0usfLKHah4jsTr++2MELaxxLu3a5lB7mEW0JRY
        v0sfIqwosfP3XEaIvXwS7772sIKUSAjwSnS0CUGUKEt0P3gBtVVSYvHTO1ATPSQmnTvBCgm1
        PkaJG6fLJzAqzELyzSwk38xCWLyAkXkVo1hqQXFuemqxYYEJPHqT83M3MYJTnZbFDsa5bz/o
        HWJk4mA8xCjBwawkwit96EOyEG9KYmVValF+fFFpTmrxIUZTYFBPZJYSTc4HJtu8knhDE0sD
        EzMjEwtjS2MzJXFecduTyUIC6YklqdmpqQWpRTB9TBycUg1MpkVKthxn7zAs7nerMDNps+hb
        KiazhOPHVD4uo5X8czrc1seWLBBX+Smu9PKRO/ucygj5WcucOlKvlTT+0N/tVp6tOrXT6IQs
        T8yCIt3VMp9v3nfji954jYvf+JB3nFefz8PJ24o+7Tz2Xe6xNNP1q276m31sZW76Tzy5PtH+
        we6PVvFBDU/XP7zYPEvG0pz9x7Sal+cz8iTPyGbUapd6n/JwfLv8kl3iu5Nbc6zvCgZJHbFi
        d+NosujYHh8Y6vZP2d6VT9VUeKbv0pVed+Y3nI+U/pG/7qq7U0P97tRzxxtZ5A/U+M87/+n0
        k0SF77O8hY7GKs9eOj3l7tM9sv9rGQ89yDt16f61+j2xtQuUWIozEg21mIuKEwG0gBYU/gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnC4n5+dkgwX/NCxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZHxvmsRcckqvYNmUCewPj
        EYkuRk4OCQETiU/bPrN0MXJxCAnsZpTYs6KFCSIhKXF2+SP2LkYOIFtY4vDhYoiaH4wSy3e8
        ZAepYRPQkNhzsYENxBYRKJa4cGAxC4jNLKAm8WDVRrAaYYE4iS+bWllBbBYBVYlLJ+8ygczk
        FbCS6FvhCrFKXqL73x+wVk4Ba4l/zxeBjRQCKmmbPJkZxOYVEJQ4OfMJ1Hh5ieats5knMArM
        QpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcFhqae5g3L7qg94hRiYO
        xkOMEhzMSiK80oc+JAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgm
        y8TBKdXAJLMqvqFw+oQ9l1iEZlUrb8suKP+4sHGDzK2C/9sPH8x/WLGG80/z/unbeO9wfX1+
        7QNn4PG9P5bN8wvR4mG73//vicmih+r2X1/JiGa8b5NQPJWx/LObMOMfo40/+Oc9+NrxyTgp
        iD0uuV57g27fd353y33B25t5V8V5ytpLzd1xsabScWL5bU9Z3SuZLdOlKr62L7EwWhlX07FB
        5diUji2N39iELXcEHWjNuOSx993+qzYFcV0hf15rbtieWJKg1/tL8fnuHqGvGZpVlysvME7t
        /aNR7G/5YeXUJwJOsTZs4h/d3pW5XU53FeObIz7tGXvr4vo6r+DViWIasysmNyw2vc1V1v9v
        bZmeRZumEktxRqKhFnNRcSIA3v7DwLoCAAA=
X-CMS-MailID: 20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925
References: <20230220054513.27385-1-bw365.lee@samsung.com>
        <CGME20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cable allocation part is functionalized from extcon_dev_register.

Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 104 +++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index adcf01132f70..3c2f540785e8 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1070,6 +1070,61 @@ void extcon_dev_free(struct extcon_dev *edev)
 }
 EXPORT_SYMBOL_GPL(extcon_dev_free);
 
+/**
+ * extcon_alloc_cables() - alloc the cables for extcon device
+ * @edev:	extcon device which has cables
+ *
+ * Returns 0 if success or error number if fail.
+ */
+static int extcon_alloc_cables(struct extcon_dev *edev)
+{
+	int index;
+	char *str;
+	struct extcon_cable *cable;
+
+	if (!edev->max_supported)
+		return 0;
+
+	edev->cables = kcalloc(edev->max_supported,
+			       sizeof(struct extcon_cable),
+			       GFP_KERNEL);
+	if (!edev->cables)
+		return -ENOMEM;
+
+	for (index = 0; index < edev->max_supported; index++) {
+		cable = &edev->cables[index];
+
+		str = kasprintf(GFP_KERNEL, "cable.%d", index);
+		if (!str) {
+			for (index--; index >= 0; index--) {
+				cable = &edev->cables[index];
+				kfree(cable->attr_g.name);
+			}
+			return -ENOMEM;
+		}
+
+		cable->edev = edev;
+		cable->cable_index = index;
+		cable->attrs[0] = &cable->attr_name.attr;
+		cable->attrs[1] = &cable->attr_state.attr;
+		cable->attrs[2] = NULL;
+		cable->attr_g.name = str;
+		cable->attr_g.attrs = cable->attrs;
+
+		sysfs_attr_init(&cable->attr_name.attr);
+		cable->attr_name.attr.name = "name";
+		cable->attr_name.attr.mode = 0444;
+		cable->attr_name.show = cable_name_show;
+
+		sysfs_attr_init(&cable->attr_state.attr);
+		cable->attr_state.attr.name = "state";
+		cable->attr_state.attr.mode = 0444;
+		cable->attr_state.show = cable_state_show;
+	}
+
+	return 0;
+}
+
 /**
  * extcon_dev_register() - Register an new extcon device
  * @edev:	the extcon device to be registered
@@ -1117,50 +1172,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	dev_set_name(&edev->dev, "extcon%lu",
 			(unsigned long)atomic_inc_return(&edev_no));
 
-	if (edev->max_supported) {
-		char *str;
-		struct extcon_cable *cable;
-
-		edev->cables = kcalloc(edev->max_supported,
-				       sizeof(struct extcon_cable),
-				       GFP_KERNEL);
-		if (!edev->cables) {
-			ret = -ENOMEM;
-			goto err_sysfs_alloc;
-		}
-		for (index = 0; index < edev->max_supported; index++) {
-			cable = &edev->cables[index];
-
-			str = kasprintf(GFP_KERNEL, "cable.%d", index);
-			if (!str) {
-				for (index--; index >= 0; index--) {
-					cable = &edev->cables[index];
-					kfree(cable->attr_g.name);
-				}
-				ret = -ENOMEM;
-
-				goto err_alloc_cables;
-			}
-
-			cable->edev = edev;
-			cable->cable_index = index;
-			cable->attrs[0] = &cable->attr_name.attr;
-			cable->attrs[1] = &cable->attr_state.attr;
-			cable->attrs[2] = NULL;
-			cable->attr_g.name = str;
-			cable->attr_g.attrs = cable->attrs;
-
-			sysfs_attr_init(&cable->attr_name.attr);
-			cable->attr_name.attr.name = "name";
-			cable->attr_name.attr.mode = 0444;
-			cable->attr_name.show = cable_name_show;
-
-			sysfs_attr_init(&cable->attr_state.attr);
-			cable->attr_state.attr.name = "state";
-			cable->attr_state.attr.mode = 0444;
-			cable->attr_state.show = cable_state_show;
-		}
-	}
+	ret = extcon_alloc_cables(edev);
+	if (ret)
+		goto err_alloc_cables;
 
 	if (edev->max_supported && edev->mutually_exclusive) {
 		char *name;
@@ -1282,7 +1296,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 err_alloc_cables:
 	if (edev->max_supported)
 		kfree(edev->cables);
-err_sysfs_alloc:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_dev_register);
-- 
2.35.1

