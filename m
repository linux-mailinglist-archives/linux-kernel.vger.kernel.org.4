Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC169A758
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjBQIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBQIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:48:10 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19B35247
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:48:07 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230217084805epoutp01d4cd46d855a2b070a5ab86beda1e3533~EkFvL6EWG1426814268epoutp01V
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:48:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230217084805epoutp01d4cd46d855a2b070a5ab86beda1e3533~EkFvL6EWG1426814268epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676623685;
        bh=3Q1QvMlS4mEXN1/iWE6lHKK6DzCnawz/nukzULRBOh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbNr+m0HUdCtwG5HEHC+wEUoLrBw+xT+jWxFkYyQImW/DJGE1S22wUwI9ZBOEfGAM
         9JcYFtHgdBskkDC/dKJsiWzU7LT6PN7oTYSmt7a6xlwTtdlKihlOVaOzkccbif+Zr+
         /WMMBiKZPRaQc6+SILYeVKysqRq3ZQqKxyjTpIvY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230217084804epcas1p1d11976b5290b777901c541215133b61e~EkFu0zdaO1582215822epcas1p1-;
        Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PJ577647pz4x9Pt; Fri, 17 Feb
        2023 08:48:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.F0.52037.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epcas1p2d5e3ca2fbadd5fde7f58a8ae1940d53f~EkFtkUy0s0318103181epcas1p26;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230217084803epsmtrp238a22aa69251596d7e8ffebd937a97f5~EkFtjl-cH3026830268epsmtrp2R;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-fb-63ef3f4396c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.92.17995.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epsmtip29cd3511e9e6eff58b3aac830d7bbecd8~EkFtc2UfE2511925119epsmtip2O;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH 3/4] extcon: added extcon_alloc_muex to simplify extcon
 register function
Date:   Fri, 17 Feb 2023 17:46:12 +0900
Message-Id: <20230217084613.25359-4-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230217084613.25359-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmga6z/ftkg1c3DS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGctfvGIvmCtfcfVbC3sD42+JLkZODgkBE4lzbxax
        djFycQgJ7GCUuLlgNwuE84lR4sbqeUwQzmdGiTuT9jHBtLQsfwKV2MUo8W7pBWYI5xejxILv
        r1hAqtgENCT2XGxg62Lk4BARKJQ43J8NEmYWUJN4sGojO4gtLBAt8ef/QjYQm0VAVWL15nNg
        C3gFrCQe9Gxjg1gmL9H97w/YSE4Ba4m/e2+yQtQISpyc+YQFYqa8RPPW2WA3SAjsY5fo/rWC
        BWSvhICLxJLPGhBzhCVeHd/CDmFLSXx+txdqfrrEyit3oOI5Eq/vtzNC2MYS796uZQYZwyyg
        KbF+lz5EWFFi5++5jBBr+STefe1hhdjEK9HRJgRRoizR/eAFNKgkJRY/vQM10UNi9s3n0GDr
        Y5Q4eXAW0wRGhVlIvpmF5JtZCJsXMDKvYhRLLSjOTU8tNiwwhkdwcn7uJkZwutMy38E47e0H
        vUOMTByMhxglOJiVRHg33XyTLMSbklhZlVqUH19UmpNafIjRFBjWE5mlRJPzgQk3ryTe0MTS
        wMTMyMTC2NLYTEmcV9z2ZLKQQHpiSWp2ampBahFMHxMHp1QDU+2yr6s2T1sef2tnydeWyxY7
        Hr3f/MOTxVCuVjS3YbFcYcgSLXG50r7f6aUlhbpOS7cY2btO4vghmhtkWvdLpKVZtr5LNbDH
        40PLjYVC2z4utHi/b07RyZSNz9dWzn3FUzHnwZVyp6RbFilCzDcnH5RdkDzNTlXu9jKj3eas
        pQeNFH7uVKgNS+bW8dfepii3YtZK02t1AWt8PYprzga8qK3m/fjyaAL/ematHL2oCzf3f0me
        zh690N5qTcorXqWjq9Rdp72wCDH7ePTCKkVLhuN9smtuapm80+fIWX9XUNQxwiyF488VU9kz
        vD+1uhmkV+4r/S/FeObwfRPDeEOr/EPi4q+jnr/4w8avVlWrxFKckWioxVxUnAgAzuriPwAE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSvK6z/ftkg293pCxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZy1+8Yi+YK19x9VsLewPj
        b4kuRk4OCQETiZblT5i6GLk4hAR2MEpcWTqRDSIhKXF2+SP2LkYOIFtY4vDhYpCwkMAPRomX
        D+VBbDYBDYk9FxvAykUEiiUuHFjMAmIzC6hJPFi1kR3EFhaIlPjw/TVYDYuAqsTqzeeYQGxe
        ASuJBz3boFbJS3T/+wPWyylgLfF3701WkLVCQDWnJ3FDlAtKnJz5BGq8vETz1tnMExgFZiFJ
        zUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgotbR2MO5Z9UHvECMTB+Mh
        RgkOZiUR3k033yQL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvE
        wSnVwBT+SsEkK7OLabK13QZGD32zi83z327a9DdEemP0TIU3ifyF++dv/JK34WrX2jZhNc6/
        MlUhWy8sPq8oJC367PAy1njJzZniqx/Vbavp+NP94Yinosbe+6HfLux02aP9xHLd5suXHwQs
        l7CW3G8wIbQ82/RY+5YfrTN2szZe+SHra24Q3r77Y8NOk8VlLpOZL202Xrn8/ZqFu7pCaj/8
        VnX4URvJk9vpcOdeC9dpUfkef63jEX/0Hzypj95ifyCSLcOUK7HqTg23SYpsUoeMy+0JcnZ8
        97I5ptUveCcx+zHvhjffVgjrVCUI5F15z7piwvxWdqtVfk+k+IQZVzmdXPcoLH8SbyTnwkl1
        jzlWZyuxFGckGmoxFxUnAgCEneDDuQIAAA==
X-CMS-MailID: 20230217084803epcas1p2d5e3ca2fbadd5fde7f58a8ae1940d53f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p2d5e3ca2fbadd5fde7f58a8ae1940d53f
References: <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p2d5e3ca2fbadd5fde7f58a8ae1940d53f@epcas1p2.samsung.com>
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
 drivers/extcon/extcon.c | 105 ++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 28058a1d2745..93cab4fe178e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1125,6 +1125,60 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
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
@@ -1175,53 +1229,8 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (extcon_alloc_cables(edev))
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
+	if (extcon_alloc_muex(edev))
+		goto err_alloc_muex;
 
 	if (edev->max_supported) {
 		edev->extcon_dev_type.groups =
@@ -1289,7 +1298,7 @@ int extcon_dev_register(struct extcon_dev *edev)
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

