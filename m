Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0569A757
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjBQIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjBQIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:48:10 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD6F3645A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:48:07 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230217084804epoutp01c55767a351b657f083eef004a2f704d8~EkFuvrQvF1217012170epoutp01R
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230217084804epoutp01c55767a351b657f083eef004a2f704d8~EkFuvrQvF1217012170epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676623684;
        bh=mkN+m3nU5kJKUPNLUDoUi3aY8MfrFcT8Rpq3baj3b5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rlq2ohw3HYy6e3zqJiYaJTMCJnMubkIPipMsgnjtST/m2UBcLJcgh5FhkxDNOR4XH
         qfGAQMhdWqJN1/EwO6bBTDO0rbqSgv7nkOKFq1wl6RbqfL7VnPYYo612WQLf+sl7z7
         GIKI7JY62GJdvMERVHG1f8P+KIJ4I+52uDKlRojc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230217084804epcas1p35bd433c9b33050b31085765ec47c1c34~EkFueAYGR1965219652epcas1p3K;
        Fri, 17 Feb 2023 08:48:04 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.240]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PJ57763ZLz4x9Pt; Fri, 17 Feb
        2023 08:48:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.F0.52037.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epcas1p17f034701f5bf98ef2650f2ec27cd2d35~EkFtmXUAC1582215822epcas1p18;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230217084803epsmtrp2ba027930c5e6c13326996a894e4d329e~EkFtlr3h13026830268epsmtrp2S;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
X-AuditID: b6c32a37-55fff7000001cb45-fa-63ef3f43500f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.55.05839.34F3FE36; Fri, 17 Feb 2023 17:48:03 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230217084803epsmtip204b9046a4a576329fe051bba405dd69a~EkFteSOSl2114021140epsmtip2U;
        Fri, 17 Feb 2023 08:48:03 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH 4/4] extcon: added extcon_alloc_groups to simplify extcon
 register function
Date:   Fri, 17 Feb 2023 17:46:13 +0900
Message-Id: <20230217084613.25359-5-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230217084613.25359-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmga6z/ftkgzMXDS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGXffbWMtmCRccfz7VuYGxo/8XYwcHBICJhLPdmp0
        MXJxCAnsYJSYfmQBI4TziVHiTccbJgjnG6PEgQ17mbsYOcE6fq66xw6R2AvUMuUEG4Tzi1Hi
        4JObYFVsAhoSey42sIHsEBEolDjcnw0SZhZQk3iwaiM7iC0sECuxauF3sBIWAVWJifP5QMK8
        AlYS37onsUPskpfo/veHBcTmFLCW+Lv3JitEjaDEyZlPWCBGyks0b53NDHKChMA2don21t1s
        EM0uEpMOP2CEsIUlXh3fAjVUSuLzu71QNekSK6/cgYrnSLy+3w5Vbyzx7u1aZpDbmAU0Jdbv
        0ocIK0rs/D2XEWIvn8S7rz2skFDklehoE4IoUZbofvCCCcKWlFj89A7URA+J2Y9awE4WEuhj
        lOi+UjKBUWEWkm9mIflmFsLiBYzMqxjFUguKc9NTiw0LjOHRm5yfu4kRnOq0zHcwTnv7Qe8Q
        IxMH4yFGCQ5mJRHeTTffJAvxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGCyzSuJNzSxNDAx
        MzKxMLY0NlMS5xW3PZksJJCeWJKanZpakFoE08fEwSnVwBS9z/r6tXu2fdU19c7JbLyHtyas
        nrl/SejblSus5I46HwrVObPu42R7/u6rNjGG9k8F+BPMeh61/Zo1JW+Z0ooGz+qmPcKm97xL
        5wXqHPz47/6MebXH74WGXf+wO2yfplvH8tMlr87vak05eL7O4n38wxmLRHjCZrX/DL4X6nc1
        V2Z1dbcdt97uVbtz3x3bd3fTsvcOL07enHyGTSotsqQzckXMCrH2+xJ39bZNtkhZ/vnI+6LU
        R6fqUgPt5T5EbfFJadsV/Fx98jVVZ0PelHpPS7UorvdTJhgvrnyuHvP2o906nugMjcVz3W4F
        ec7dn8Ey4Yfb6dTdyXm3tvrNPDPtuMZT97/fq2TeJ8jb356hxFKckWioxVxUnAgAQHh5N/4D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvK6z/ftkg8alMhYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6Mu++2sRZMEq44/n0rcwPj
        R/4uRk4OCQETiZ+r7rGD2EICuxkl3n9nh4hLSpxd/gjI5gCyhSUOHy7uYuQCKvnBKHGz8xoT
        SA2bgIbEnosNbCC2iECxxIUDi1lAbGYBNYkHqzaC9QoLREs83CwCYrIIqEpMnM8HUsErYCXx
        rXsS1CZ5ie5/f8A6OQWsJf7uvckKUi4EVHN6EjdEuaDEyZlPoIbLSzRvnc08gVFgFpLULCSp
        BYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxggNSS3MH4/ZVH/QOMTJxMB5ilOBg
        VhLh3XTzTbIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFIN
        TGL8vGpWP+fYHUjJnq6V92N5x+8WsZebXQ7Wn9oaWB7yjcfpgWVFeGMHl1pxVbeNiNwx87uM
        vfUmOeWT5dwVVs2w+fur70+5zsLpCywulD9MsPf1Kfub/XbR2ooJn4XNF075ktHc1CXwJDf4
        XtsB9QrW+w5HzxSujDNgahZK01nV/mZ3huLnnAenNGZyHPq3sKo5pvjd3SV1u1nlshg6uZ+I
        nW96vzXnxL+N0+Sj/kn+4b4bkKognPR6x9L/bNOvfDgsavf3280NAT+89rvNcbmwU0prz/ec
        kgm2D95eOWXtz8bauVJ22oNXiT92rpltfIjL/wq//FPvF6HvlQo3FPduUbBv+bj6ZP2OstW/
        UpVYijMSDbWYi4oTAZce6du3AgAA
X-CMS-MailID: 20230217084803epcas1p17f034701f5bf98ef2650f2ec27cd2d35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p17f034701f5bf98ef2650f2ec27cd2d35
References: <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p17f034701f5bf98ef2650f2ec27cd2d35@epcas1p1.samsung.com>
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
 drivers/extcon/extcon.c | 57 +++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 93cab4fe178e..9336d0d7589a 100644
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
@@ -1232,28 +1265,8 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (extcon_alloc_muex(edev))
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
+	if (extcon_alloc_groups(edev))
+		goto err_alloc_groups;
 
 	spin_lock_init(&edev->lock);
 	if (edev->max_supported) {
-- 
2.35.1

