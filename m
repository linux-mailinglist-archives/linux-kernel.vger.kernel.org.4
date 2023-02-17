Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FAF69A75A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBQIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBQIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:48:10 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7434022
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:48:06 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230217084804epoutp0380bc4c25d913b1703b77e21e4b1f2d57~EkFu8RlvC1849418494epoutp03D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230217084804epoutp0380bc4c25d913b1703b77e21e4b1f2d57~EkFu8RlvC1849418494epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676623685;
        bh=VWFXNTIw9nK2J03yx4ldB4NgMy/4kPQyO7bFGTxkKQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6E8dDkstBxi1DJYDFTtolXmrkaEsc/Ghw4mrn5LOkkcI0KB9HFnNXMrwHeEExvu5
         Oz4nJmMotDBuQD4Nx4p/Hmqdg+m+yYIk2hLZcAWXw1+JsnJwjfH9tv9swUvlrs7R0g
         TChqSfWapUUm6LDaYLTxrng7toCrLMYGReSPRpbI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230217084804epcas1p3794f56a4da6fafe70a45faa7dbfec7cd~EkFurI5Yw1965819658epcas1p3K;
        Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.224]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PJ5775R9Tz4x9Q3; Fri, 17 Feb
        2023 08:48:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.26.54823.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epcas1p29ef858c842b18de89f1b034acb26086a~EkFtkI0z60793207932epcas1p2n;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230217084803epsmtrp12ec72081f370337f74c9e2fce3da3506~EkFtjYfy21579015790epsmtrp1h;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-9f-63ef3f43cea8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.92.17995.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epsmtip21745654c993e2f869c8abd4518f6ed98~EkFtbLcz52512425124epsmtip2H;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH 2/4] extcon: added extcon_alloc_cables to simplify extcon
 register function
Date:   Fri, 17 Feb 2023 17:46:11 +0900
Message-Id: <20230217084613.25359-3-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230217084613.25359-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmnq6z/ftkg0WTdSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGbOm72Uq2CJXcf7QIcYGxt0SXYycHBICJhIL7u1n
        72Lk4hAS2MEocfPrckYI5xOjxNz+X8wQzmdGiVln5rPCtGxb/A6qahejxP1fN6CcX4wSGy/9
        ZgapYhPQkNhzsYGti5GDQ0SgUOJwfzZImFlATeLBqo3sILawQKzEmlcLWEBsFgFVicnv3oIt
        4BWwkpi6bQ8jxDJ5ie5/f8BqOAWsJf7uvQlVIyhxcuYTFoiZ8hLNW2czQ9TvY5eYeFQWZK2E
        gIvEkUUZEGFhiVfHt7BD2FISL/vboOx0iZVX7kDZORKv77dDrTWWePd2LTPIGGYBTYn1u/Qh
        wooSO3/PZYTYyifx7msPK8QmXomONiGIEmWJ7gcvmCBsSYnFT+9ATfSQ2PlvExskoPoYJe40
        7GObwKgwC8kzs5A8Mwth8wJG5lWMYqkFxbnpqcWGBabw+E3Oz93ECE52WpY7GKe//aB3iJGJ
        g/EQowQHs5II76abb5KFeFMSK6tSi/Lji0pzUosPMZoCg3ois5Rocj4w3eaVxBuaWBqYmBmZ
        WBhbGpspifOK255MFhJITyxJzU5NLUgtgulj4uCUamBqkma5pxt+dUNhtqP/rmtRTzXZG3s0
        khU+S+2rLtnfyTZj/6XeZbefVYbc2lY39y7njUXLNcrdVPkmFdeYVZuyLpFzCmuabKyWuXCB
        15LsU2uzO0uSFgTI9nkZ2vwQctz4Z1X6zBMPVmyLm5G3Qn1d3SnJ/5+D9NZILhcRZ9NrVzGv
        7F0app+enDCtbe754pALKyPXdk38X/gh+NezJ39CrP+dDLBfuuXTrll/ozZKn+89ataYc1vj
        QmcB57v9Ritnr1nNtOTRGi0+x4nSr1anC9v1yezZdPZyVXr87aWRL5M07aY8E7xkvejNrplP
        2tOCnsmo1C4VU8tx9Jvj1PNl1pHP/7aXLHzhxvl3Xf1EJZbijERDLeai4kQAuTx0Rf8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSvK6z/ftkg1M7JS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZs6bvZSrYIldx/tAhxgbG
        3RJdjJwcEgImEtsWv2PsYuTiEBLYwShxddliJoiEpMTZ5Y/Yuxg5gGxhicOHiyFqfjBKHJjz
        lBWkhk1AQ2LPxQY2EFtEoFjiwoHFLCA2s4CaxINVG9lBbGGBaIlH3cfB4iwCqhKT370F6+UV
        sJKYum0PI8QueYnuf3/AajgFrCX+7r3JCrJXCKjm9CRuiHJBiZMzn0CNl5do3jqbeQKjwCwk
        qVlIUgsYmVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHpZbWDsY9qz7oHWJk4mA8
        xCjBwawkwrvp5ptkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGphSHs3IPrnoTsbcmeWM20WlTQJXLzmc+vBxuGNW67OtyfP3/P5het1YWORHEvf0lDqO
        XS8YlnfnxbdPq9iRtCmmI4L7399DrPVXnv5ac7dyRU6HBb+aiu59HWl3ex+za/mSu67uY2GO
        6zhTf5Gtf/7SSwcKlPI92kyOmV7clR825ckH9WBFg01zXm82NJg6aU+4idFk7TdlsSlyabce
        830932WXbDdve72GPL9214qdLw63Km7JaH12+5iH5cM7FytXlD6tZb54SmnOe5bYOaZL+KNd
        kybveHh+mvydDK/H5gFiy7bu3+vII9bIKt3uoS/McOTA9s6ikA8vi0VvvGVdWRoUuIvrpe25
        ijvM+ZFKLMUZiYZazEXFiQChrkaGugIAAA==
X-CMS-MailID: 20230217084803epcas1p29ef858c842b18de89f1b034acb26086a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p29ef858c842b18de89f1b034acb26086a
References: <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p29ef858c842b18de89f1b034acb26086a@epcas1p2.samsung.com>
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
 drivers/extcon/extcon.c | 103 ++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index adcf01132f70..28058a1d2745 100644
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
@@ -1117,50 +1172,8 @@ int extcon_dev_register(struct extcon_dev *edev)
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
+	if (extcon_alloc_cables(edev))
+		goto err_alloc_cables;
 
 	if (edev->max_supported && edev->mutually_exclusive) {
 		char *name;
@@ -1282,7 +1295,7 @@ int extcon_dev_register(struct extcon_dev *edev)
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

