Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6495B6911
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiIMHyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIMHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:54:15 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AD5A3C2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:54:11 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220913075409epoutp0297925801d94ca44823ab9081b67de583~UXE072ix52848728487epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220913075409epoutp0297925801d94ca44823ab9081b67de583~UXE072ix52848728487epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663055649;
        bh=ERW53Oyymk9MuhMw46n630lKTvxMsEdOQBltMJN71Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjUuMY4ohrDDPQ3+WkK1ONS+2vrqkCaogyfAHJHI8buV86TpkmLAisur7bI2tVnKU
         r8enVo9Vsslg8pZxwMYPHjJmBE5Q+EQ8uZ8LLrM21CsZaPQF3OyCR7R2inMdJP5rnx
         9c5xvZ1hKSGtFOlsN8cgg3MN1eZno9ifVtbXB4a4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220913075408epcas2p4c597f06c76143fd96c6ac562226437a9~UXE0UeNZM2256922569epcas2p4h;
        Tue, 13 Sep 2022 07:54:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MRbMN0080z4x9QK; Tue, 13 Sep
        2022 07:54:07 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.CC.18832.F1730236; Tue, 13 Sep 2022 16:54:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3~UXEzc_oPO1025310253epcas2p1_;
        Tue, 13 Sep 2022 07:54:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220913075407epsmtrp13ec1c6fd71bb474ae86cce8a4a77e406~UXEzcLYCO3251432514epsmtrp1-;
        Tue, 13 Sep 2022 07:54:07 +0000 (GMT)
X-AuditID: b6c32a45-cdfff70000014990-b7-6320371f2995
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.FA.18644.F1730236; Tue, 13 Sep 2022 16:54:07 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220913075407epsmtip16590d1e0c89026163947332c542ddcb7~UXEzQ-Rac3034330343epsmtip1I;
        Tue, 13 Sep 2022 07:54:07 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v2] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Tue, 13 Sep 2022 04:37:03 +0900
Message-Id: <20220912193703.102267-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <sc.suh@samsung.com; hy50.seo@samsung.com;>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmma68uUKyQVuTlcWDedvYLF7+vMpm
        cfBhJ4vF16XPWC2mffjJbLF68QMWi0U3tjFZ3NxylMXi8q45bBbd13ewWSw//o/Jgdvj8hVv
        jwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNoP9DNFMAelW2TkZqYklqkkJqXnJ+SmZduq+Qd
        HO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SjkkJZYk4pUCggsbhYSd/Opii/tCRVISO/
        uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y/uph8wF/TIVEyeuZG9g3CDexcjJ
        ISFgIvFz5R2mLkYuDiGBHYwSN+asgXI+MUqcmLaKFcL5zCgxZeknFpiWFxuPQ1XtYpR4+OYl
        G4Tzg1Fi38SXrCBVbAIaEmuOHQKrEgFJfL24ggkkwSygJvH57jKwUcICYRLnTk9hA7FZBFQl
        zj/bBGbzClhJTF62jQlinbzEoobfYDangIVE/7cpzBA1ghInZz5hgZgpL9G8dTYzyDIJgYkc
        EtN372PvYuQAclwk7qzQgZgjLPHq+BZ2CFtK4mV/G5RdLPHjzWomiN4GRoml7ceYIRLGErOe
        tTOCzGEW0JRYv0sfYqSyxJFbUGv5JDoO/4XaxCvR0SYE0agkcWbubaiwhMTB2TkQYQ+Jxy8O
        MUOCqptRYv+cA8wTGBVmIXlmFpJnZiHsXcDIvIpRLLWgODc9tdiowBAew8n5uZsYwWlWy3UH
        4+S3H/QOMTJxMB5ilOBgVhLh3a4qnyzEm5JYWZValB9fVJqTWnyI0RQY1BOZpUST84GJPq8k
        3tDE0sDEzMzQ3MjUwFxJnNdVmzFZSCA9sSQ1OzW1ILUIpo+Jg1Oqgcm6/7r1PVWZkgVTLzdO
        YjLkfrF6beUXoVfnJ81tSpzK9DivuviOvOK+c894F8x6t2HG6m2vfGvE8476xJzuXPr+hKXU
        DbnCGcazqx3dMld3FTBFyjm0CCzbq6N1qn3l+3sS7I+v/y76vy7wquelW+6snmWp/2Yzx97e
        dOW95Uc9pUmP2xKPbeqql7h2+qfVy9rFOW/1Ug+Lz1G2O3mpIuLzXMWjyytkLD7e3rbkYavK
        Gt6SuRnsSbNZvfuOXzmo+9rvWvJhzfCW+ZIXSxRj5CW8nh3TPLvV45m9d/csps9BYmvz+ma1
        u21ZfuQTswGr4FZ250kX7/vb57wV8k0OOvvhvu72xalP6yY7lz5cukJIiaU4I9FQi7moOBEA
        x6Ej/TwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK68uUKywbpj8hYP5m1js3j58yqb
        xcGHnSwWX5c+Y7WY9uEns8XqxQ9YLBbd2MZkcXPLURaLy7vmsFl0X9/BZrH8+D8mB26Py1e8
        PSYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwB7FJdNSmpOZllqkb5dAlfG9lMPmQv6
        ZSomTlzJ3sC4QbyLkZNDQsBE4sXG40xdjFwcQgI7GCX2zL7ODpGQkPi/uIkJwhaWuN9yhBXE
        FhL4xijx+KEiiM0moCGx5tghsGYRgRYmidbXr5hBEswCahKf7y5jAbGFBUIkrky6wgZiswio
        Spx/tgnM5hWwkpi8bBvUAnmJRQ2/wWxOAQuJ/m9TmCGWmUv8eAhh8woISpyc+YQFYr68RPPW
        2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOCK0tHYw7ln1
        Qe8QIxMH4yFGCQ5mJRHe7aryyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1O
        TS1ILYLJMnFwSjUwufj8UPZdZvpz2k6mRS/tvmp3S69bIK1SFMdeevxva1OQQtLO1VEOFVqC
        1022TM0T+1cSpv3HoEiIt153+tbtpw5pf5BnrnRbVmJ9hbf8Pvv5pn/1XBMPsB25sed7U63L
        2j+evxgfqpQnRch7f75zXeH/1PabaaILbwuZzhYpqGjvkv/TxXAqhSuo7ciLZZwfVrjMi736
        wqrF5PVxE7cfT76e+rqR6VSuf6dIa3FBs3WOe3Tj+4V2rSxb5Ld5BGaqWa0/x8iqtO7QyZ/b
        xBtXpUmeWpx30/WD6BW5sppL7hlSQr9i4kzdq/Jlfxp+LDwvU69vdvrcj6uftp+cxSgTetvt
        /IvQ7clVQt8/LF6ixFKckWioxVxUnAgAz/1nofcCAAA=
X-CMS-MailID: 20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3
References: <sc.suh@samsung.com; hy50.seo@samsung.com;>
        <CGME20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3@epcas2p1.samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ufs_hba_variant_ops about vendor error in check_error.
It need to reset when occurred ah8 related error.
At that time could not recovery with pwr cmd.
So add vendor error check function at ufs_hba_variant_ops.

v1->v2
fixed warm message of auto build test

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd-priv.h |  7 +++++++
 drivers/ufs/core/ufshcd.c      |  2 ++
 drivers/ufs/host/ufs-exynos.c  | 20 ++++++++++++++++++++
 include/ufs/ufshcd.h           |  1 +
 4 files changed, 30 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d00dba17297d..6172da4d3484 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -221,6 +221,13 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
+					       bool *queue_eh_work)
+{
+	if (hba->vops & hba->vops->check_int_error)
+		hba->vops->check_int_error(hba, queue_eh_work);
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7c15cbc737b4..39ee5192f26a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6542,6 +6542,8 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 		queue_eh_work = true;
 	}
 
+	ufshcd_vops_check_int_error(hba, &queue_eh_work);
+
 	if (queue_eh_work) {
 		/*
 		 * update the transfer error masks to sticky bits, let's do this
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index eced97538082..5d9db6870a66 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -67,6 +67,10 @@
 #define CLK_CTRL_EN_MASK	(REFCLK_CTRL_EN |\
 				 UNIPRO_PCLK_CTRL_EN |\
 				 UNIPRO_MCLK_CTRL_EN)
+
+#define HCI_AH8_STATE		0x50C
+#define HCI_AH8_STATE_ERROR	BIT(16)
+
 /* Device fatal error */
 #define DFES_ERR_EN		BIT(31)
 #define DFES_DEF_L2_ERRS	(UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF |\
@@ -1376,6 +1380,21 @@ static void exynos_ufs_hibern8_notify(struct ufs_hba *hba,
 	}
 }
 
+static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool *queue_eh_work)
+{
+	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
+	u32 val;
+
+	if (ufshcd_is_auto_hibern8_supported(hba)) {
+		val = hci_readl(ufs, HCI_AH8_STATE);
+
+		if (val & HCI_AH8_STATE_ERROR) {
+			ufshcd_set_link_broken(hba);
+			*queue_eh_work = true;
+		}
+	}
+}
+
 static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	enum ufs_notify_change_status status)
 {
@@ -1569,6 +1588,7 @@ static const struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
 	.setup_xfer_req			= exynos_ufs_specify_nexus_t_xfer_req,
 	.setup_task_mgmt		= exynos_ufs_specify_nexus_t_tm_req,
 	.hibern8_notify			= exynos_ufs_hibern8_notify,
+	.check_int_error		= exynos_ufs_check_int_error,
 	.suspend			= exynos_ufs_suspend,
 	.resume				= exynos_ufs_resume,
 };
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 24c97e0772bb..40078c4b9f55 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -335,6 +335,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	void	(*check_int_error)(struct ufs_hba *hba, bool *queue_eh_work);
 };
 
 /* clock gating state  */
-- 
2.26.0

