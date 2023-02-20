Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A669C50F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBTFqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjBTFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:45:53 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CCBDBC5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:45:51 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220054547epoutp03c5937f86feaee31f31e7e78e112c7cae~Fcibrbr6V0620706207epoutp03v
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220054547epoutp03c5937f86feaee31f31e7e78e112c7cae~Fcibrbr6V0620706207epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676871947;
        bh=Lomkw3wOGq30Z8bGw0g7vY7CMRkAMEbVBey5jm8G6Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXxAMwvNA4yN6Sl0+4FH4g98ZhhbR7qBm1Y6tcty637GyecRZlKWmTv8k22ZQfrOY
         qr/qN/Nj+IkrR92CZBlROcj8fBmHJATU4p3BqIy4hySTVnbo5qUBnQsvDq4qrTaKQ+
         yRSUU6JQMa/Bo4s0+nGw6Fw8oqcWBYOwJyO33x0g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230220054547epcas1p189575adc2ceea9b747fb1b5c1891de5f~FcibWe71Q2217522175epcas1p1_;
        Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.222]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PKrxQ2Xqcz4x9Q9; Mon, 20 Feb
        2023 05:45:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.F9.12562.A0903F36; Mon, 20 Feb 2023 14:45:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epcas1p3ab4b1281f464c72a7b5ed8681a8b087f~FciZ1eVcr1540615406epcas1p3f;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220054545epsmtrp2fc038af6876d068e3afaf5df7136443a~FciZ0GU780986209862epsmtrp2C;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-7f-63f3090a2bbc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.5A.05839.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epsmtip14c1317fc0a019a6d360c1b1b4dca9823~FciZsjDQ82594925949epsmtip1t;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 3/4] extcon: Added extcon_alloc_muex to simplify extcon
 register function
Date:   Mon, 20 Feb 2023 14:45:12 +0900
Message-Id: <20230220054513.27385-4-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230220054513.27385-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmri4X5+dkgxvzBSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGWcnvWAvmCpfMXf2UvYGxncSXYycHBICJhI/Hl9l
        7WLk4hAS2MEo0b1wIhuE84lRYmnDTnYI5xujxJLHk9lgWvb/XAeV2Mso8ejDFWYI5xejxIIj
        11hBqtgENCT2XGwA6uDgEBEolDjcnw0SZhZQk3iwaiM7iC0sECex4sFjFhCbRUBVYuPeR2Bx
        XgEriSctF5ghlslLdP/7A1bDKWAt8e/5IjaIGkGJkzOfsEDMlJdo3jobqn4Xu8SGD9EQtovE
        tf7b7BC2sMSr41ugbCmJz+/2Qj2TLrHyyh2oeI7E6/vtjBC2scS7t2uZQc5nFtCUWL9LHyKs
        KLHz91xGiLV8Eu++9rCClEgI8Ep0tAlBlChLdD94wQRhS0osfnoHaqKHxILuzWAXCwn0MUpM
        6ZOcwKgwC8kzs5A8Mwth8QJG5lWMYqkFxbnpqcWGBUbw+E3Oz93ECE52WmY7GCe9/aB3iJGJ
        g/EQowQHs5IIr/ShD8lCvCmJlVWpRfnxRaU5qcWHGE2BQT2RWUo0OR+YbvNK4g1NLA1MzIxM
        LIwtjc2UxHnFbU8mCwmkJ5akZqemFqQWwfQxcXBKNTDFs8wuPn/W3HjiRUe7mntFGSIn/O/s
        2KV/+Z7FSa1ak1NBjz8YPpwveYuxeU74K+VvvMunPQhpz9DLyz7MeENMeprcL/djBw+Izd/2
        1/Nhgvp28TU5z4U/b22b4xq1tMYn2PFT+FWWuAc7MnRyjt3il+dPklohsF/z2OI+veU6BTsU
        haoXVYt18q73PVtaFrSxbPHBTsPLwh5LJrjsEFSVn6N3YVvZubrDy6PXN1+oSJ+gYVT3yC/N
        /0RYxup5F6s+GHcsmHquQNczQ08tnefv6i39a0zPlVnlVE6cOz+X6cKP5dtZf5c8PLxjJ4/V
        iguffcWFfuns3PMueyXLlFcnffeZ/O1f921hvFu+mnOpEktxRqKhFnNRcSIAod9d/f8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnC4n5+dkg03PtSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZZye9YC+YKl8xd/ZS9gbG
        dxJdjJwcEgImEvt/rmPvYuTiEBLYzSix9N9KNoiEpMTZ5Y+AEhxAtrDE4cPFEDU/GCUaVzcz
        gtSwCWhI7LnYAFYvIlAsceHAYhYQm1lATeLBqo3sILawQIzEo+s/mEFsFgFViY17H4HFeQWs
        JJ60XGCG2CUv0f3vD1gvp4C1xL/ni8BmCgHVtE2ezAxRLyhxcuYTqPnyEs1bZzNPYBSYhSQ1
        C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4MDU0tzBuH3VB71DjEwcjIcY
        JTiYlUR4pQ99SBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
        U6qBKTtaekXw5M6QOz+bLuQG/6teffXEtLqqz13Liz8/dVGs5My93rBiZlz9wz3Jxg+tH7/7
        0cUWHBhtbZmkv2/JnZaf07NWXhD443Ri6dppRZMVtM+IvMg8yqXqnRPKlvaDI3nXKrWPk2M+
        xEd5hAcf4hJofnVoUeOy4inmEhP/fn7LGca8/oDg+oBq4Qt2K4OeHby4pqyd7Vht8dIrRWtK
        lSQ+rmSa5DpduJbzkrhIEfOxNIcK3d0twbpOxZGlj35+sTubpfko89QeljOT8uReccYHr5PL
        Fl3fsf+T/6nG892e7+022naeCZK5sj3zYqC4IE/Wrhc5h3yDIoxKG3/YbJSwCf2z+tCfwkyP
        0wKnlViKMxINtZiLihMBSRFhDLsCAAA=
X-CMS-MailID: 20230220054545epcas1p3ab4b1281f464c72a7b5ed8681a8b087f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p3ab4b1281f464c72a7b5ed8681a8b087f
References: <20230220054513.27385-1-bw365.lee@samsung.com>
        <CGME20230220054545epcas1p3ab4b1281f464c72a7b5ed8681a8b087f@epcas1p3.samsung.com>
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
index 3c2f540785e8..2aec34909843 100644
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
@@ -1176,53 +1230,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (ret)
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
+	if (ret)
+		goto err_alloc_muex;
 
 	if (edev->max_supported) {
 		edev->extcon_dev_type.groups =
@@ -1290,7 +1300,7 @@ int extcon_dev_register(struct extcon_dev *edev)
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

