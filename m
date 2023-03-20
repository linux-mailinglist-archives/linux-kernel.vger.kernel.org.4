Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780106C0949
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCTDUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCTDT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:19:57 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29484168B5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:19:51 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230320031949epoutp03d31f8c720fe5d63242f19522a21d3542~OAm_ZEGDy1277912779epoutp03c
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230320031949epoutp03d31f8c720fe5d63242f19522a21d3542~OAm_ZEGDy1277912779epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679282389;
        bh=v/ZddSulWTEJ8HQ/jkuFUPRKQ6i17lFyLtrKLMjI/ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO61vWmH33Ol8W7wH3BsxThGudNjMgyssAhzqYkCpOlK1V6BraN5A1v1Q5JhA1OKq
         KNpL0H9tYbHk9J8nYvWCFucmtmk2Kg8lWTbZ7fFldPIovRuf+ud6mlKkTOD5BKwlx7
         Mvzdkhn2c4+OTp5PQcn01MJmb0HeaVXePAXyBA9o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230320031949epcas1p4460142fb245b8ff91b3751df2ff4d938~OAm_KqP9F1698116981epcas1p4D;
        Mon, 20 Mar 2023 03:19:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pg0N41CZVz4x9Q7; Mon, 20 Mar
        2023 03:19:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.7B.55531.4D0D7146; Mon, 20 Mar 2023 12:19:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epcas1p4e2a38d0d56cec1bca48e46e1130fe8db~OAm87HozU1698116981epcas1p4z;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230320031947epsmtrp2fa3c576bf7a9aaf2777ec8927f88e4b9~OAm86X0Qn1098210982epsmtrp2N;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-19-6417d0d41cb4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.58.18071.3D0D7146; Mon, 20 Mar 2023 12:19:47 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epsmtip15b49070f7630e474e364ddfd751bc29b~OAm8zaLDz1384813848epsmtip1x;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v5 2/3] extcon: Add extcon_alloc_muex to simplify extcon
 register function
Date:   Mon, 20 Mar 2023 12:19:38 +0900
Message-Id: <20230320031939.28862-3-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320031939.28862-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmvu6VC+IpBkc62S1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGdP3LmUpOCVfMXXXJOYGxkmSXYycHBICJhJzTm1k
        6WLk4hAS2MEocXzbcUYI5xOjxLKtu5kgnG+MEjumfGKFaXlz9SIzRGIvo8Tp+WugnF+MEr9P
        7GYDqWIT0JDYc7EByObgEBEolDjcnw0SZhZQk3iwaiM7iC0sECPx4UcvI0gJi4CqxO2pYCfx
        ClhJPFl3kwVil7xE978/YDangLXExeOfGCFqBCVOznzCAjFSXqJ562ywEyQEdrFLzL77kRmi
        2UWi+/87qKOFJV4d38IOYUtJfH63lw3CTpdYeeUOVDxH4vX9dkYI21ji3du1zCC3MQtoSqzf
        pQ8RVpTY+XsuI8RePol3X3tYQUokBHglOtqEIEqUJbofvGCCsCUlFj+9AzXRQ2L9rHXQwO1j
        lJh2+T3LBEaFWUjemYXknVkImxcwMq9iFEstKM5NTy02LDCER3Byfu4mRnC60zLdwTjx7Qe9
        Q4xMHIyHGCU4mJVEeP0WiKYI8aYkVlalFuXHF5XmpBYfYjQFhvVEZinR5Hxgws0riTc0sTQw
        MTMysTC2NDZTEucVtz2ZLCSQnliSmp2aWpBaBNPHxMEp1cCUXt/6cZXANOcpRZ4dO+ac3nfY
        r/pGf6zQyxfT1++8XRd5flOFI3dI3SZHpSPtq+bXKx9d4nRx5Tkm3o8PauN6/Xy9Fk4yF41e
        /fH9Jc5nOxW/GW76vu4y09564TaDl+7RW9w3/hM60Ltfu7esWXGtiN6JRZ7J/n23irf+iNiy
        0eW0xcVP83Yty2i43a4R/EOK64ZHVP3NRyUx9lyW0s7Ltkw6esIr//u9+KqHmzjb1hXqWTH9
        kf8wlTnvQpuc3JxVLZtv/XnUdG3l1Vf2zhf0nTjklrEp2hxf12JmVGrIx9TsG8MeUye/u/SF
        D8/eTbfl2iQF3j87WjCPX22tw69w37zEv6XdTJxL35wx9slSYinOSDTUYi4qTgQA1acs4gAE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO7lC+IpBlOP6FmcWLOIyeL6l+es
        Fpd3zWGzuN24gs2BxaNvyypGj8+b5AKYorhsUlJzMstSi/TtErgypu9dylJwSr5i6q5JzA2M
        kyS7GDk5JARMJN5cvcjcxcjFISSwm1HiwYQFbBAJSYmzyx+xdzFyANnCEocPF0PU/GCUuPpy
        BSNIDZuAhsSeiw1g9SICxRIXDixmAbGZBdQkHqzayA5iCwtESUy6PoMFZA6LgKrE7alge3kF
        rCSerLvJArFKXqL73x8wm1PAWuLi8U+MIOVCQDW/+zMgygUlTs58AjVdXqJ562zmCYwCs5Ck
        ZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyUWpo7GLev+qB3iJGJg/EQ
        owQHs5IIr98C0RQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4
        OKUamOqyS2/laWqy7V1wNObc/WSeqREd96ZtbY96F9FW/Us1+laF5w/71lvylZEzThRKlIU2
        8q1qOBz58px4nmRPQOefgvJlTzbPXXBoIYOXvaSCFNOFm2sfzyyurI3eWqdTeUzl4Or8x0Hx
        O13PR8UuiGrZVFescW1/jpXEWXam5hOsOgzpOW9bTmqYXf1+4sryT67RQb27pE119/REaRpY
        Ltdh7a3cYbtwV0jdPz+VTbai2q3se937OcwWqQUctb7bdys9pub+lTWnXxUlsQesFJ+TUd9S
        KpJu8ndlausn3g17Fjg6daQGqeQ4Rnjczl1zpuXRiYd+V9ct+7LoX9err6cibt0+9SuaLb/l
        jlSuEktxRqKhFnNRcSIAnuqZULkCAAA=
X-CMS-MailID: 20230320031947epcas1p4e2a38d0d56cec1bca48e46e1130fe8db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230320031947epcas1p4e2a38d0d56cec1bca48e46e1130fe8db
References: <20230320031939.28862-1-bw365.lee@samsung.com>
        <CGME20230320031947epcas1p4e2a38d0d56cec1bca48e46e1130fe8db@epcas1p4.samsung.com>
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
 drivers/extcon/extcon.c | 109 ++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 48 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 402d674e2896..86290afa35fb 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1130,6 +1130,63 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
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
+	if (!edev)
+		return -EINVAL;
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
@@ -1181,53 +1238,9 @@ int extcon_dev_register(struct extcon_dev *edev)
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
@@ -1295,7 +1308,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 		kfree(edev->d_attrs_muex);
 		kfree(edev->attrs_muex);
 	}
-err_muex:
+err_alloc_muex:
 	for (index = 0; index < edev->max_supported; index++)
 		kfree(edev->cables[index].attr_g.name);
 	if (edev->max_supported)
-- 
2.35.1

