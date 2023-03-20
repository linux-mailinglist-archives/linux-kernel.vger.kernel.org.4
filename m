Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865136C094A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCTDUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCTDT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:19:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD96168BD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:19:51 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230320031949epoutp011432e2dc172844f49259850a762b9b31~OAm_OnroK2587325873epoutp01Y
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230320031949epoutp011432e2dc172844f49259850a762b9b31~OAm_OnroK2587325873epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679282389;
        bh=n8qYCuhn70pfO+KBPCeDayPqzV8taksYowQoEHyjQh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IThrBbDbNmoMsgu6yLv5ZIiI4iJCw6PM9EANn+q93MVftH24NowQe4MAZQ7PF93t9
         1ja+RQyBQfuh3N6fCSbZgxeZ1iq9tFObiJ1KVbO1z1J69RswyhbarBTzAhF5X4oPSw
         H0Ny69CdMeNiDVhV0zTJVZ5FwAJERBkZPzx5nOiU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230320031948epcas1p4a1adcae9c3a55962318ae0b9d52b3316~OAm99MBQh1698116981epcas1p4A;
        Mon, 20 Mar 2023 03:19:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pg0N41CH2z4x9Q5; Mon, 20 Mar
        2023 03:19:48 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.7B.55531.4D0D7146; Mon, 20 Mar 2023 12:19:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epcas1p17117b8bc458903348e9b29061d00b343~OAm8-GNYq2336023360epcas1p1g;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230320031947epsmtrp19c14567f6ce0d20c6d1caae174f0bf6a~OAm8_b6ik2582625826epsmtrp1j;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
X-AuditID: b6c32a35-00ffd7000000d8eb-18-6417d0d47965
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.58.18071.3D0D7146; Mon, 20 Mar 2023 12:19:47 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epsmtip119eea3f84b8bbcb5a90fa04cb0ceb533~OAm81HF6S1384113841epsmtip1v;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v5 3/3] extcon: Add extcon_alloc_groups to simplify extcon
 register function
Date:   Mon, 20 Mar 2023 12:19:39 +0900
Message-Id: <20230320031939.28862-4-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320031939.28862-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmge6VC+IpBt2d7BYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0Nd
        Q0sLcyWFvMTcVFslF58AXbfMHKBFSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        swK94sTc4tK8dL281BIrQwMDI1OgwoTsjEldnYwFO4UrVk16wdTA2CLQxcjJISFgItGz+Dlz
        FyMXh5DADkaJX1+nQjmfGCXmXX7HBOF8Y5RYf20iM0zLuvvtbCC2kMBeRonva9Mgin4xSty9
        dpMFJMEmoCGx52IDUBEHh4hAocTh/myQMLOAmsSDVRvZQWxhgTiJjZeawWwWAVWJt8snMoHY
        vAJWEm83bWKB2CUv0f3vD5jNKWAtcfH4J0aIGkGJkzOfsEDMlJdo3job7GoJgV3sEgtfvYA6
        1EXi+uKtTBC2sMSr41vYIWwpiZf9bVB2usTKK3eg7ByJ1/fbGSFsY4l3b9cyg9zPLKApsX6X
        PkRYUWLn77mMEHv5JN597WEFKZEQ4JXoaBOCKFGW6H7wAmqrpMTip3cYIUo8JG7ez4eEVB+j
        RMvDDawTGBVmIflmFpJvZiEsXsDIvIpRLLWgODc9tdiwwBAev8n5uZsYwclOy3QH48S3H/QO
        MTJxMB5ilOBgVhLh9VsgmiLEm5JYWZValB9fVJqTWnyI0RQY1hOZpUST84HpNq8k3tDE0sDE
        zMjEwtjS2ExJnFfc9mSykEB6YklqdmpqQWoRTB8TB6dUA1PXBcdlOutyHRaYXA6drq8TeeVp
        VGlu/fb0HFvlr0K1NyZvfZDOU7SudWJXZ/SihhnXD8+c/en1ot62Hx/713z7G5ls4aTwjvPe
        mnaJHI8fRmcVzZ15+pfXMHNfatnJK9X2aEr1oVnTGfaYcZxZG7B5+tU9SuWqib0LdF6bb5iz
        zZSpPOVp/Kltr9QXfvtv4ZP5I13i8yOJzpSo+7O5n9fo3Np3w/6JbH5tfvGHnCdf9JRr9zxl
        u5RwJnt2+Pf9Jbt4Pm3MiV49RWta7bUJl26/+2DsyLeQ0VT/XvbSSYIL380tqeVm3Btfqrhq
        Gss+XWbNpUpla8IWM2xOlco2mWyl+G+5g66H95QYVW3Fs2uVWIozEg21mIuKEwG4tqCH/wMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnO7lC+IpBnfXG1icWLOIyeL6l+es
        Fpd3zWGzuN24gs2BxaNvyypGj8+b5AKYorhsUlJzMstSi/TtErgyJnV1MhbsFK5YNekFUwNj
        i0AXIyeHhICJxLr77WxdjFwcQgK7GSW6lr1jhUhISpxd/oi9i5EDyBaWOHy4GKLmB6PE/5N/
        WUBq2AQ0JPZcbGADsUUEiiUuHFgMFmcWUJN4sGojO4gtLBAjcbHvD1gNi4CqxNvlE5lAbF4B
        K4m3mzaxQOySl+j+9wfM5hSwlrh4/BMjyF4hoJrf/RkQ5YISJ2c+gRovL9G8dTbzBEaBWUhS
        s5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5LLc0djNtXfdA7xMjEwXiI
        UYKDWUmE12+BaIoQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwc
        nFINTFnLV28+qfajaMuCXA7mkzxP3vw83/9vhc/Dak+nsKulEldylOKaN5+Zd9eZb+blX2u1
        12qoBOvGXIvgapjPVxIfMCVl8e51DMYzVnDf/8lokuO3SUefbZ5D6Mfu8lSxBI0F4ndNH0ck
        Hr0UyHHl7V6ZK/dfpJmX+C0zfXM5zeOca2z2Vf5ZG15pT1eSDj9VnlKxybLx4RmW5+HrpdJz
        k2b+NnuuscWle+E//WfbJ4ktbwt8kvfjjE532YuV9uy7JHbcbd1t9qH9wJFtqw2s2N0Y+liW
        nF8rfFic/0RIx/qLL/oad3c9FxNLYwtlcTAwjVlap3B5sdatm99XfWW4c8pLUI+XYaPnp4JT
        TOyce5VYijMSDbWYi4oTAaEXIha6AgAA
X-CMS-MailID: 20230320031947epcas1p17117b8bc458903348e9b29061d00b343
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230320031947epcas1p17117b8bc458903348e9b29061d00b343
References: <20230320031939.28862-1-bw365.lee@samsung.com>
        <CGME20230320031947epcas1p17117b8bc458903348e9b29061d00b343@epcas1p1.samsung.com>
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
 drivers/extcon/extcon.c | 61 ++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 86290afa35fb..26a84bed0874 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1187,6 +1187,42 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
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
+	if (!edev)
+		return -EINVAL;
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
@@ -1242,28 +1278,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (ret < 0)
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
+	if (ret < 0)
+		goto err_alloc_groups;
 
 	spin_lock_init(&edev->lock);
 	if (edev->max_supported) {
-- 
2.35.1

