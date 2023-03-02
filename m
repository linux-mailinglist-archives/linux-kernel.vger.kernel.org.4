Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308276A7D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCBJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCBJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:02:07 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEF43B22E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:01:54 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230302090151epoutp042ed3ce725306f975551a142d1b2a6d07~IjqeE1BDN2133421334epoutp04e
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:01:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230302090151epoutp042ed3ce725306f975551a142d1b2a6d07~IjqeE1BDN2133421334epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677747711;
        bh=cbn41A/zllFF1Fxp+oBfssVf1kqTC7m5c7lzXzDOAsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdKJd1v2L/SQ0vNu8n4r2pPUuUJwA0CZpPnq2AjkaAOeA7FghHVlkye6E0j5ZNxMm
         9chXSX/61QQRiGGz6aEhE7SXU1TV/ZwIKbEHcxTh1R3BJ/SHzQuxzW1cLffkbjDkk8
         gIv5q8j5O1hOZKr/aFNZHz2D9vnUTEKKbog5lVVw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230302090150epcas1p3cb76ae87d181fa893073265dc441d7c4~Ijqdsfv660385703857epcas1p37;
        Thu,  2 Mar 2023 09:01:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PS4q20BdTz4x9QL; Thu,  2 Mar
        2023 09:01:50 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.7D.55531.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epcas1p31a7f99d83947be1d6f06141b352ce041~IjqcjwIPC0385703857epcas1p3x;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302090149epsmtrp251ed4e49ec22ea642c4cdd9447ab8bdd~IjqcjChmv3164931649epsmtrp2c;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-11-640065fdf7d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.4E.18071.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epsmtip2d0019787bb27da33a379e45bcdc60600~IjqcUzDiw0725207252epsmtip2F;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v4 3/4] extcon: Added extcon_alloc_muex to simplify extcon
 register function
Date:   Thu,  2 Mar 2023 18:01:42 +0900
Message-Id: <20230302090143.46678-4-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302090143.46678-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmnu7fVIYUgweLrS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGecO/mYqWCpf8bBtA2sD4w+JLkZODgkBE4kby2+z
        dDFycQgJ7GCU2HnjBiuE84lRYkfrG3YI5xujRPvupawwLR1HTrBBJPYySjw+uQiq/xejxNbt
        rcwgVWwCGhJ7LjYAVXFwiAgUShzuzwYJMwuoSTxYtZEdxBYWiJM4/nQbmM0ioCqx6ukvNhCb
        V8BKYv/WqewQy+Qluv/9YQGxOQWsJd5M7mKBqBGUODnzCQvETHmJ5q2zmUFukBDYxy5xfX4f
        G0Szi8S/eddZIGxhiVfHt0ANlZL4/G4vVE26xMord6DiORKv77czQtjGEu/ermUGuZ9ZQFNi
        /S59iLCixM7fcxkh9vJJvPvawwpSIiHAK9HRJgRRoizR/eAFE4QtKbH46R2oiR4SC9cvhgZV
        H6PEw0N32CcwKsxC8s4sJO/MQti8gJF5FaNYakFxbnpqsWGBITyGk/NzNzGCE56W6Q7GiW8/
        6B1iZOJgPMQowcGsJMK78PafZCHelMTKqtSi/Pii0pzU4kOMpsDAnsgsJZqcD0y5eSXxhiaW
        BiZmRiYWxpbGZkrivOK2J5OFBNITS1KzU1MLUotg+pg4OKUamO6Vhfw511z4pm1G7YzZ2zSn
        7DbxWDbzR3qL6s2r/96u9lYtdz0uvdLnzI+cbap7GKzzuV/IbgnYxnj9e3mOj6aR460ZZUnt
        hYGaKwr8dkQnNjD/43k39+h23SOvtjYoPSzQmaG9+a/k7OlVtcrJURfeeZ+ZzOhTzv024UBa
        9Kxek8ss/uZ12RW5z3caPGuKuaC6inUew0ydPxKdrhGXZ9//ZfPt4j0ewfadHm79Uz98WPBq
        9Y7S5OJ3ss9X7DU5tH1ewntm9pa7a7I+6zwv/9WwxiK56cspE67ofLG4mcdrrG8ZXVNetIBP
        s0eqw6Mt80zowXsa/x4cmPJ88fFqlwPL73xb/the94yJZXRvW5YSS3FGoqEWc1FxIgAcfUqD
        AQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO7fVIYUgy/blS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZ5w7+ZipYKl/xsG0DawPj
        D4kuRk4OCQETiY4jJ9i6GLk4hAR2M0pc2zaFBSIhKXF2+SP2LkYOIFtY4vDhYoiaH4wSHyZ2
        MIPUsAloSOy52MAGYosIFEtcOLAYrJdZQE3iwaqN7CC2sECMxPkFH8FqWARUJVY9/QVm8wpY
        SezfOpUdYpe8RPe/P2C9nALWEm8md4HZQkA101/tY4GoF5Q4OfMJ1Hx5ieats5knMArMQpKa
        hSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcGBqae5g3L7qg94hRiYOxkOM
        EhzMSiK8C2//SRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
        U6qBaddJw09//unU7dqYpXVzsnr0rtRL60sDd6qna1nOPBzz5VvTEsemu37hAn3NF37/9197
        cN+jk0u+rl14b7OHbJBY1+QnGZqMgW4z/DakzZBoW70wW+DbwaVJR2M2/5X6fVBDMFdiStZf
        k4SDtozunUs/JsbkHxb4ynlkw/Tb7BdO8Ggs3+1oYHI2omeixLmnirLu6zUtriv1HWlbbdgQ
        b7NBSF1vTc3BqRxspnOMVy3UO9G47PSde9nLs5xku1c9srj339FM6vS8xSozTtdFHLVabJFc
        vyFL/tmPsE29V2sZA/P89j/8XWCo0NX04uf2k5sV9/1pisid+nq2aF7eO4Hz9WsnPNaVilXj
        dJZ+dFGJpTgj0VCLuag4EQCbuW0ruwIAAA==
X-CMS-MailID: 20230302090149epcas1p31a7f99d83947be1d6f06141b352ce041
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p31a7f99d83947be1d6f06141b352ce041
References: <20230302090143.46678-1-bw365.lee@samsung.com>
        <CGME20230302090149epcas1p31a7f99d83947be1d6f06141b352ce041@epcas1p3.samsung.com>
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
index 49605e96bedd..321988231806 100644
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
 	if (edev->max_supported)
-- 
2.35.1

