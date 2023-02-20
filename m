Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD68369C50D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBTFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBTFpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:45:52 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51496C14B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:45:49 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220054547epoutp01d93b85319fe64847ea5e8684bf2f103e~FcibU0Dt12911729117epoutp017
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220054547epoutp01d93b85319fe64847ea5e8684bf2f103e~FcibU0Dt12911729117epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676871947;
        bh=lNPksCGpheSqXVu55qAf+P0bJ2VIXVru95h9wl5NU28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCGdJnvhJw9Gy/sXdwdojODrmr+cdjnC3/OP5NgNjg6FoH2CKSR3Bu8x+5G+SsLqg
         O754Oz2r04krCOjK06bslW27DaY3UrMhwhA48vRqOZeliLHLEoQeqmyxFDac6MdIBc
         F7G/o0XeBqlJO/CmgE0aRX/Rk4ovtkEyfNqvsc44=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230220054547epcas1p2695e6ad99af607f325f4aab6da708f2e~Fcia-VGsF1742417424epcas1p2o;
        Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PKrxQ2ghfz4x9Q7; Mon, 20 Feb
        2023 05:45:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.DC.55531.A0903F36; Mon, 20 Feb 2023 14:45:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epcas1p1b26d2a04a170dab4517e09bd6cf09c3f~FciZ2oWJY1974419744epcas1p1L;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220054545epsmtrp22e61a1b18f5835cd5d3740a68e40ec09~FciZ1_eoJ0972009720epsmtrp2j;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-58-63f3090ab484
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.77.17995.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epsmtip114bcfb45fbc387c9de05bf0c7567a728~FciZuNwbS2561925619epsmtip13;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 4/4] extcon: Added extcon_alloc_groups to simplify extcon
 register function
Date:   Mon, 20 Feb 2023 14:45:13 +0900
Message-Id: <20230220054513.27385-5-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230220054513.27385-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmri4X5+dkg8MPBC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGU83X2Au6BGumPRhFXsD4zP+LkZODgkBE4nWk9OZ
        QGwhgR2MEtc/pncxcgHZnxglvi14wwqR+Mwo8edeLUzDuYaJ7BBFuxgl+pY+YoNwfjFKzNjU
        wgZSxSagIbHnYgOQzcEhIlAocbg/GyTMLKAm8WDVRnYQW1ggQeLsl39gm1kEVCW6j3awgNi8
        AlYS/3ouM0Esk5fo/vcHLM4pYC3x7/kiNogaQYmTM5+wQMyUl2jeOpsZ5AYJgV3sEnfO/gDb
        KyHgIvH5UTTEHGGJV8e3sEPYUhKf3+1lg7DTJVZeuQMVz5F4fb+dEcI2lnj3di0zyBhmAU2J
        9bv0IcKKEjt/z2WEWMsn8e5rDyvEJl6JjjYhiBJlie4HL6Cul5RY/PQO1EQPicZFE1ghIdXH
        KPG49zzLBEaFWUi+mYXkm1kImxcwMq9iFEstKM5NTy02LDCER29yfu4mRnCq0zLdwTjx7Qe9
        Q4xMHIyHGCU4mJVEeKUPfUgW4k1JrKxKLcqPLyrNSS0+xGgKDOuJzFKiyfnAZJtXEm9oYmlg
        YmZkYmFsaWymJM4rbnsyWUggPbEkNTs1tSC1CKaPiYNTqoGpVvnES9eZFvqVD5+a5d9ce0SZ
        UzsjJrPy17TSsIIUN/3d/2QZjwhtqHhZE1/wbnLI2bV3Ki4V2XxSrpNXTM2fcM3wr2BEXviK
        7iZjhean5Wt7Ujcuna5XJ/mmbJWk/aMrTwrXbz587/caj6w7K6o0a6aVc0Yk8i/+f3jrinfK
        K411+FQlM3tadzPlPOmdxs2h9GdmeGzz40WmodIMshZfZmVUvFwWVTIp9oGwg/JUzStJCnZ+
        9ZPcjT36lavntqgnLc/+zSe7J/Jp/rdp8SUXop8HzL0gtyVqSpbsr42PV3LaL59b8txQ7QiT
        kZ/nvUfHwnImljLX/ctXOXNts27lw/lCPfk98zK/afeFCyixFGckGmoxFxUnAgAfrUsm/gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnC4n5+dkg7YjOhYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6Mp5svMBf0CFdM+rCKvYHx
        GX8XIyeHhICJxLmGiexdjFwcQgI7GCV+LZ/KApGQlDi7/BFQggPIFpY4fLgYouYHo8Tk/ovs
        IDVsAhoSey42sIHYIgLFEhcOLAbrZRZQk3iwaiNYjbBAnMSztVuYQWwWAVWJ7qMdYDW8AlYS
        /3ouM0Hskpfo/vcHLM4pYC3x7/kisJlCQDVtkyczQ9QLSpyc+QRqvrxE89bZzBMYBWYhSc1C
        klrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4MLW0djDuWfVB7xAjEwfjIUYJ
        DmYlEV7pQx+ShXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCU
        amDq5mLzPruh/k6gHottkKjZ0UnFJ9r1NF/w/jk/W2hv/q+pHvf7+cOtTshfiNlyr/BGupW/
        iGfvgf8xE9o6DY6/Y2py1jN+U+nRkOzce13v7hrF6deST32fEuaWavdiN8d67odTI3mVOSq3
        RD2YsyhALtqoq8nnj+9Wn5S3U1cfKbt4YG/JkRwXZelk6VPed5eskM69NH3B3J815T9bD1ss
        dlA+Lc1yy3p9d+IVrgo5/8/LYqftOz1HeNEKuQN/J7X5TY24oGwYc5PxQI2uwLXjLEeNRfj5
        gyMiWDPuPX59SY955bwZ/2f1ufD4+LRJRb3ZZHPng8Pb2/sFvuiZW+Y61taeVX74yNtsRujL
        C1+UWIozEg21mIuKEwH+zzqCuwIAAA==
X-CMS-MailID: 20230220054545epcas1p1b26d2a04a170dab4517e09bd6cf09c3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p1b26d2a04a170dab4517e09bd6cf09c3f
References: <20230220054513.27385-1-bw365.lee@samsung.com>
        <CGME20230220054545epcas1p1b26d2a04a170dab4517e09bd6cf09c3f@epcas1p1.samsung.com>
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
index 2aec34909843..919d77539039 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1179,6 +1179,39 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
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
@@ -1234,28 +1267,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (ret)
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
+	if (ret)
+		goto err_alloc_groups;
 
 	spin_lock_init(&edev->lock);
 	if (edev->max_supported) {
-- 
2.35.1

