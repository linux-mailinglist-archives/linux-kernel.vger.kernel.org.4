Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3C6C094C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCTDUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCTDT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:19:59 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DF168BF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:19:52 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230320031950epoutp0444293e5625c1cda210ac40332ebf86ed~OAm-TQzng0263502635epoutp04r
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:19:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230320031950epoutp0444293e5625c1cda210ac40332ebf86ed~OAm-TQzng0263502635epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679282390;
        bh=xrEvdUuMxzcMej7Qy4wHwy7MJJB2yIz5OFPTHnqfDbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMBKWwvuWQ8lHWV2h7iR3V5PkQGPHnG2Bkq94TZB8VK4c472GJx+C0I+aQSvTvG8E
         eb1A7ZMjJhXkpNUcsvTtYMlH3j99rTHKjJp4p/E+VKh/78/w4J1sZHtqMpAJE6KtPF
         YegcOEuv7/ugIHrLbimQTGbNLoBocf+LrEOrOadM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230320031949epcas1p3d7e1ab45cf4ac8f1ebf2f059aa4c683b~OAm_12Vgv0336603366epcas1p3K;
        Mon, 20 Mar 2023 03:19:49 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.227]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pg0N46nsFz4x9Pv; Mon, 20 Mar
        2023 03:19:48 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.1B.52037.4D0D7146; Mon, 20 Mar 2023 12:19:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epcas1p370cac9b65ba7267554e3c342a858bb43~OAm877k5t0336603366epcas1p3B;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230320031947epsmtrp2f666b0a47491b133d15e26d15300c01c~OAm86FZSU1098210982epsmtrp2M;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-c6-6417d0d4da40
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.58.18071.3D0D7146; Mon, 20 Mar 2023 12:19:47 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epsmtip155b824429a4144296d81064ca9b171a4~OAm8xsBqw1384113841epsmtip1u;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v5 1/3] extcon: Add extcon_alloc_cables to simplify extcon
 register function
Date:   Mon, 20 Mar 2023 12:19:37 +0900
Message-Id: <20230320031939.28862-2-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320031939.28862-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmge6VC+IpBp/Xs1mcWLOIyeL6l+es
        Fpd3zWGzuN24gs2BxaNvyypGj8+b5AKYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM96vechS0K9QsebIXPYGxpeSXYycHBICJhJ33l1m
        72Lk4hAS2MEo8e7gQSYI5xOjxI0vaxghnG+MEre//mOGaZk68xJUYi+jRNOUHqj+X4wS8zr6
        GUGq2AQ0JPZcbGDrYuTgEBEolDjcnw0SZhZQk3iwaiM7iC0sECfx/d03VhCbRUBV4tq+pywg
        5bwCVhLfZslB7JKX6P73hwXE5hSwlrh4/BPYdF4BQYmTM5+wQIyUl2jeOpsZ5AQJgV3sEpcm
        dDNCNLtI/Fp0mh3CFpZ4dXwLlC0l8fndXjYIO11i5ZU7UPEcidf326F6jSXevV3LDHIPs4Cm
        xPpd+hBhRYmdv+cyQuzlk3j3tYcVpERCgFeio00IokRZovvBCyYIW1Ji8dM7jBAlHhIrzoID
        XUigj1Fi1RHnCYwKs5A8MwvJM7MQ9i5gZF7FKJZaUJybnlpsWGAMj97k/NxNjOBUp2W+g3Ha
        2w96hxiZOBgPMUpwMCuJ8PotEE0R4k1JrKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnAZJtXEm9o
        YmlgYmZkYmFsaWymJM4rbnsyWUggPbEkNTs1tSC1CKaPiYNTqoHp2OeX24pOJPQHP89Z/M46
        dIGXwsLTeVadO+eprw2fd9u1+O1kfrY3R4ILWgzWMBTXdkf3KGoq3ph5huXJpyDRa36ZbnJz
        1F6zbMqpzU2T3F4j/oP1Vj2rxHvt2UzxMXymG7IVYv2d1pVdeeld+XnuQjvfTR84FU25visH
        +Yc+Lpl/R6R4696a0GcbDmmUP2hL3Hsjarfv8hMzklM2pZp87hCfcJ61wq7kDvuScOUAKeEk
        yfqrz7JLN2S83VbufKfLT+PBxJSILwobVNUjDnjO2n5j/lHbHwd46+b4ahQ/sRHhSi1hSPr7
        sjupcU5kIlf+nOVdWoIf/2u5/Uw7Imalcr5Jeq5UwAyG84XG+UosxRmJhlrMRcWJAFnJfjb+
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO7lC+IpBi+/6FicWLOIyeL6l+es
        Fpd3zWGzuN24gs2BxaNvyypGj8+b5AKYorhsUlJzMstSi/TtErgy3q95yFLQr1Cx5shc9gbG
        l5JdjJwcEgImElNnXmLsYuTiEBLYzSgxo/MJC0RCUuLs8kfsXYwcQLawxOHDxRA1Pxgl3l85
        wA5SwyagIbHnYgMbiC0iUCxx4cBisF5mATWJB6s2gtUIC8RILF91CayGRUBV4tq+pywgM3kF
        rCS+zZKDWCUv0f3vD1grp4C1xMXjnxhBSoSASn73Z4CEeQUEJU7OfAI1XV6ieets5gmMArOQ
        pGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREclFqaOxi3r/qgd4iRiYPx
        EKMEB7OSCK/fAtEUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGpi6th7WCzzA5FbcdonNavuZX/F66ref1DeI9r3M1/t2O63511/Dt9Gej9iWOO52YS57
        5ezjGlnV2OZTcmyVbcTClDcC/G/9rI7FRWyNf85beivC8mevcjFj9e3lgS2Bn5cm1sq6bZuy
        YXf3uzu5VsVz2eKbhTuTH9xpDPtm6eq32WSvhKyOeLZM+H6X9rK/zyd7p5rOvyerwHwgK3TV
        3xj+yPhtV2+sKbLmSGmZ5GemtG33Ar9+wfM2kRVZoty8J25vc1pzxmPZw7qLN84GyUXLei+4
        cU91Z7mqurzTNcn6w6Zl127uKPWaIHgu31Hp8hP21inrFyztOPw/V8oqT+6fxNJUM0PD7q6f
        +9crK7EUZyQaajEXFScCAPFGm325AgAA
X-CMS-MailID: 20230320031947epcas1p370cac9b65ba7267554e3c342a858bb43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230320031947epcas1p370cac9b65ba7267554e3c342a858bb43
References: <20230320031939.28862-1-bw365.lee@samsung.com>
        <CGME20230320031947epcas1p370cac9b65ba7267554e3c342a858bb43@epcas1p3.samsung.com>
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
 drivers/extcon/extcon.c | 111 +++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 46 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index adcf01132f70..402d674e2896 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1070,6 +1070,66 @@ void extcon_dev_free(struct extcon_dev *edev)
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
+	if (!edev)
+		return -EINVAL;
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
@@ -1117,50 +1177,9 @@ int extcon_dev_register(struct extcon_dev *edev)
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
@@ -1279,10 +1298,10 @@ int extcon_dev_register(struct extcon_dev *edev)
 err_muex:
 	for (index = 0; index < edev->max_supported; index++)
 		kfree(edev->cables[index].attr_g.name);
-err_alloc_cables:
 	if (edev->max_supported)
 		kfree(edev->cables);
-err_sysfs_alloc:
+err_alloc_cables:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_dev_register);
-- 
2.35.1

