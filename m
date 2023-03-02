Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F66A7D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCBJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCBJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:02:06 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BC26878
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:01:53 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302090151epoutp031538d46fbf84e6798f503c674344ae68~Ijqd1KeeD1833818338epoutp03E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:01:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302090151epoutp031538d46fbf84e6798f503c674344ae68~Ijqd1KeeD1833818338epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677747711;
        bh=6DcQ0Jug42gkmSPVW+jMowJJ54RpvUbXthnGbsypBM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQreRKQGt2WMMBhofaNxG42uuhCIQ2MhAKGXm7h8pmKRZ7sLTwikxhh7MGIBax0gZ
         Um9j/rXpPfJfi9jMpUR2GUFEueWVzEnTtlRSiVgo2w6tf2ept3nh7DIZRzHHD0RWb5
         Uv45USrGXp5dURYkH1R7etnGCiJVkzbkiw/RBBe8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230302090150epcas1p174cb16f20311e5904e1afa45fbc03d04~IjqdhmHnq0635206352epcas1p1d;
        Thu,  2 Mar 2023 09:01:50 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PS4q20bhXz4x9QN; Thu,  2 Mar
        2023 09:01:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.CB.54823.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4~IjqcjAbTE0383503835epcas1p3P;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302090149epsmtrp1160764b2a7349b876aa2c53ab129ec7d~IjqciMo_n0666306663epsmtrp1w;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-b4-640065fd3dad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.2E.31821.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epsmtip2cac8c43d983d9d26f18f1a83086fd80b~IjqcY8Ogq0723807238epsmtip2E;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v4 4/4] extcon: Added extcon_alloc_groups to simplify extcon
 register function
Date:   Thu,  2 Mar 2023 18:01:43 +0900
Message-Id: <20230302090143.46678-5-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302090143.46678-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmvu7fVIYUg9n3zS1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGU0npQqmCFdcbm1la2B8xd/FyMkhIWAiceHhB7Yu
        Ri4OIYEdjBJnVqyCcj4xSqxafIsdwvnMKHH952kWmJbtLxqZIRK7GCVObFgD1fKLUWLb71Y2
        kCo2AQ2JPRcbgGwODhGBQonD/dkgYWYBNYkHqzayg9jCAgkSHf87wcpZBFQllq96xQxi8wpY
        Sdx9fZYRYpm8RPe/P2CLOQWsJd5M7mKBqBGUODnzCQvETHmJ5q2zwQ6SENjFLvHs9XSoZheJ
        q09vMUHYwhKvjm9hh7ClJF72t0HZ6RIrr9yBsnMkXt9vh+o1lnj3di0zyP3MApoS63fpQ4QV
        JXb+nssIsZdP4t3XHlaQEgkBXomONiGIEmWJ7gcvoLZKSix+egdqoodE070eRkhQ9TFK/H3+
        mWUCo8IsJO/MQvLOLITNCxiZVzGKpRYU56anFhsWmMIjODk/dxMjON1pWe5gnP72g94hRiYO
        xkOMEhzMSiK8C2//SRbiTUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cCEm1cSb2hiaWBiZmRi
        YWxpbKYkzituezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgckmtKQ644gyf6LcHevYf6ZVf/1TlrGc
        LTU+9+Oqdf1HQ753J+4IbOcXNNDdJb2t40G93Mqd7Jtar2c5660zmp2T3hezf3eHwJcjM18G
        /jNQffLjvOA9d/eLExlqLTbkFPNfmDhhr5GboGelcKvqU4lbr9geCPYw7A7snys+mSd205r8
        tiVhSobe216G8pb5eu52Kn0wcWPv0g/V11/E/1mw8HZauhbT4ia+A2buWmbHV5ScfmzV8Ctq
        ffH9AMPl0/Lnnfy+UqY9le9Fmeb20r17J76yb9nnqX1OPPFi94uz3m3drC6FU3rfCPT1rNn/
        8afve/7o6EUbPkfZn32peunYo3+Hf+qtUC0vXeKvWKLEUpyRaKjFXFScCABfesZqAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSvO7fVIYUg1VbVCxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZTSelCqYIV1xubWVrYHzF
        38XIySEhYCKx/UUjcxcjF4eQwA5GiasH7jBBJCQlzi5/xN7FyAFkC0scPlwMUfODUeLro0WM
        IDVsAhoSey42sIHYIgLFEhcOLGYBsZkF1CQerNrIDmILC8RJnLjyEmwmi4CqxPJVr5hBbF4B
        K4m7r88yQuySl+j+9wesl1PAWuLN5C4wWwioZvqrfSwQ9YISJ2c+gZovL9G8dTbzBEaBWUhS
        s5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5LLa0djHtWfdA7xMjEwXiI
        UYKDWUmEd+HtP8lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJx
        cEo1MF3cFN1z4dcmlisv9lSEX7ybl38+l4dNJmx22WqeiNd9sVGKa1q8/AN17bbfjNg6/csC
        gbNrk36+qJEX4BFZmTdJsqf9msVK8/fTIjdfiiiyfGMqYNc3e73g3bviWROTm7WWFCl8eM2y
        Pi5GpqwyadXv+U0Hw2/vmlksyBhoGFfzZpLpuox/30VuxS5wna4597PX0/8Gl936Jr6N/X/D
        Ks27zTGpI/2ewLnLX52kP8lw3PzbkNbnf+uPl1pN7MPd9/STLXI+7gzdt+jTFd+kmcaPpcIu
        Jj7u5vTkzJTaeCTAvTkocVb5Ua3ou54V2nc4DuT6PT4b4/2wsbDr54lNW959YZtikej6apb4
        VX3u90osxRmJhlrMRcWJAAcaYsy6AgAA
X-CMS-MailID: 20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4
References: <20230302090143.46678-1-bw365.lee@samsung.com>
        <CGME20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4@epcas1p3.samsung.com>
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
index 321988231806..c366a7988daf 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1181,6 +1181,39 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
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
@@ -1236,28 +1269,9 @@ int extcon_dev_register(struct extcon_dev *edev)
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

