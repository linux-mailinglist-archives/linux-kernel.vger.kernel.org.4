Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADDC6A7A1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCBDhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCBDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:37:08 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A9515EB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:36:54 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302033652epoutp031148f5e0b51e3d760f64bd94f1269dda~IfOuAMKY21564315643epoutp03h
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:36:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302033652epoutp031148f5e0b51e3d760f64bd94f1269dda~IfOuAMKY21564315643epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677728212;
        bh=1cwJno1hlXheXEGAd0wLxvI6V4+ez9OblOIQdaj2Jkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPxLpRVe1i9tIuZX30zS8hKAfIfidnTotDLMMb/za+6i0x6Ip9P17rkTllKLXpyyI
         rW/+qMmpZ8/MIApxKRyWBAnEPBclj8ZzjuV2UeBs8uOv+j9aIpOwhM/lEu1Vp6Fm03
         X2uDwhckcVaNJWRaLQ6yo8ktnKzxDEQxSkmtXZdY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230302033651epcas1p4b1702e913fe60b1704cb59ff54fcbfa4~IfOtwYEwH3274032740epcas1p4S;
        Thu,  2 Mar 2023 03:36:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PRxc26PxSz4x9Q8; Thu,  2 Mar
        2023 03:36:50 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.AA.55531.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epcas1p4e59c767f76b459c2e6b9969dfe27cda1~IfOsjs3g70855008550epcas1p4e;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302033650epsmtrp11e7faf8e99a4cac32b5a6ff01d951487~IfOsjGJUw2681726817epsmtrp1_;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-f7-640019d22019
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.7F.17995.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epsmtip27d9d65a00886e1dbed3faae1d92302be~IfOsaYUIA2452424524epsmtip2W;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v3 2/4] extcon: Added extcon_alloc_cables to simplify extcon
 register function
Date:   Thu,  2 Mar 2023 12:36:43 +0900
Message-Id: <20230302033645.23933-3-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302033645.23933-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmnu4lSYYUgzvHDC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGa9uWhU8lqvo2X2BrYHxjkQXIyeHhICJxLfmqYxd
        jFwcQgI7GCXur38F5XxilNjWdZ8NwvnMKPGoYQI7TMv1GZPYIRK7GCXuzn/ADOH8YpT4cP8f
        C0gVm4CGxJ6LDUDtHBwiAoUSh/uzQcLMAmoSD1ZtBBskLJAgsevoQjYQm0VAVaK1YQUriM0r
        YCVxbvE/Johl8hLd//6AjeQUsJb49vYHO0SNoMTJmU9YIGbKSzRvnc0MUb+LXeLnVgEI20Vi
        0/UNjBC2sMSr41ugHpCSeNnfBmWnS6y8cgfKzpF4fb8dqt5Y4t3btcwg5zMLaEqs36UPEVaU
        2Pl7LiPEWj6Jd197WEFKJAR4JTrahCBKlCW6H7yAul5SYvHTO4wQJR4SP+5mQgKqj1GiY18b
        2wRGhVlInpmF5JlZCIsXMDKvYhRLLSjOTU8tNiwwhEdvcn7uJkZwqtMy3cE48e0HvUOMTByM
        hxglOJiVRHgX3v6TLMSbklhZlVqUH19UmpNafIjRFBjUE5mlRJPzgck2ryTe0MTSwMTMyMTC
        2NLYTEmcV9z2ZLKQQHpiSWp2ampBahFMHxMHp1QDU+vGhZ+SHs3UFFjsluMrkyMxac5sjnlz
        kxct67pa22H8b2aI6bfr+gc3NGrWR/xdsEPsd0K6+oaaSM6nSipLbxyv0Vi37urGV2Fbb1bM
        uHtuTkl/++LmnZ9uqBm1LVV5uY9p+WU/F7X88ttLFtQoF35MeeMQ/OK5cF6stMEE9zXmlTJn
        5zBOtXC1+9S06nnFpRnOK8wcRdgS8p72HLsdJTxlzW62ZLtdXp+f/Dav2Pq1koOn/MgBk/M8
        X2dK7HA8YNbQf2vJiv8TnjtXLZ/0LUWJg5EjIEZ9ptXfCR9YZ/idCri+ROYt+4sl5Wc1ArqL
        el5MeX6Fwzi/++Wnta6h3135f8/8bnvlkPxczs1iUwOUWIozEg21mIuKEwGNbCra/gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSvO4lSYYUg2N/ZSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZr25aFTyWq+jZfYGtgfGO
        RBcjJ4eEgInE9RmT2LsYuTiEBHYwStx4/YEdIiEpcXb5IyCbA8gWljh8uBii5gejxIWHO5lA
        atgENCT2XGxgA7FFBIolLhxYzAJiMwuoSTxYtRFsjrBAnMTj8y1gNSwCqhKtDStYQWxeASuJ
        c4v/MUHskpfo/vcHrJdTwFri29sfYL1CQDV7FvUyQ9QLSpyc+QRqvrxE89bZzBMYBWYhSc1C
        klrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4LLW0djDuWfVB7xAjEwfjIUYJ
        DmYlEd6Ft/8kC/GmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp
        1cCkHLz/e0TkjKSu+dFNZSc7W/g/lLTa5ty86ubgfNmn6shaxxtNiuw/b3hc9epTX6eV8JfJ
        su63hJa/zf1HL6XCLm3p/u16JTrxz/28y28jVJe2SSuouDHImP66Wv2XZ13OSacZj8Pf7Gvd
        N+Uk5wuR55uWz6kr9WbVtT9ekiatbyjrtrhSh5kzh/XgGtcpNr0Pltaov/AW3Vi20XXPxtUm
        Ipvnb94xc338N+8fbccybeUPhJhP4co0PN13MfCPHWtOVpKg6VmlrrZp/95Nln/28MWOp3ny
        mrcCr/JJvddpmvDk1c2bD/kPsthurGer2+8ssrL+wv15Pfe2KJ57vV5Ton1v+kE1sYa7N1Ze
        kG5RYinOSDTUYi4qTgQArVOTmroCAAA=
X-CMS-MailID: 20230302033650epcas1p4e59c767f76b459c2e6b9969dfe27cda1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302033650epcas1p4e59c767f76b459c2e6b9969dfe27cda1
References: <20230302033645.23933-1-bw365.lee@samsung.com>
        <CGME20230302033650epcas1p4e59c767f76b459c2e6b9969dfe27cda1@epcas1p4.samsung.com>
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
 drivers/extcon/extcon.c | 106 +++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index adcf01132f70..388a3d906075 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1070,6 +1070,63 @@ void extcon_dev_free(struct extcon_dev *edev)
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
+
+			kfree(edev->cables);
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
@@ -1117,50 +1174,9 @@ int extcon_dev_register(struct extcon_dev *edev)
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
+	if (ret < 0)
+		goto err_alloc_cables;
 
 	if (edev->max_supported && edev->mutually_exclusive) {
 		char *name;
@@ -1282,7 +1298,7 @@ int extcon_dev_register(struct extcon_dev *edev)
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

