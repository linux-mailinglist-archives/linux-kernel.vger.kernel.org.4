Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2C5BA488
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIPCHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIPCHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:07:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E746239
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:07:06 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220916020704epoutp01f3e9a6a078226db6ed7818e17c456e4d~VNRpA7-8o0144501445epoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:07:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220916020704epoutp01f3e9a6a078226db6ed7818e17c456e4d~VNRpA7-8o0144501445epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663294024;
        bh=dIE6n6B/JTYadhxIQ3uaS2kqdQe8Fv4KYHNiQIu+LxA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XayJD26hfMinfLgAEY3LmPZe3VMkruP9NqsfxG2uUHyqw8gwPgiXq2wFXX44hl9vK
         Ix1DPDOEkwAYVqtzxO4DmDUgZ7GuHl0aDh1zgPJfAEKeOBJxVLkf5IMFeYB+hM4M4b
         /tmJRUuNxVIpPJIKYDv2C6jRReUvLSVB/DodgyJ4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220916020703epcas2p104c73e4cc0fc9a23e9727f6f8eff7e46~VNRofYr-80916609166epcas2p1T;
        Fri, 16 Sep 2022 02:07:03 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MTHWW1FlHz4x9QR; Fri, 16 Sep
        2022 02:07:03 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.A5.06255.74AD3236; Fri, 16 Sep 2022 11:07:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220916020702epcas2p2c4f7c7bcc1507db171b40aa45d7fa7d9~VNRndE7Gc1762517625epcas2p2s;
        Fri, 16 Sep 2022 02:07:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220916020702epsmtrp208c5667f05db7b731aaa3056a670f1ae~VNRnb-Rlq1884618846epsmtrp2o;
        Fri, 16 Sep 2022 02:07:02 +0000 (GMT)
X-AuditID: b6c32a48-f77ff7000000186f-0e-6323da4780ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.96.18644.64AD3236; Fri, 16 Sep 2022 11:07:02 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220916020702epsmtip26a609f5b3c8775b019cf720184bf757c~VNRnPsiL52062520625epsmtip2J;
        Fri, 16 Sep 2022 02:07:02 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v3] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Thu, 15 Sep 2022 22:49:56 +0900
Message-Id: <20220915134956.90086-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmqa77LeVkgxO72C0ezNvGZvHy51U2
        i4MPO1ksvi59xmox7cNPZovVix+wWCy6sY3J4uaWoywWl3fNYbPovr6DzWL58X9MDtwel694
        e0xYdIDR4/v6DjaPj09vsXj0bVnF6PF5k5xH+4FupgD2qGybjNTElNQihdS85PyUzLx0WyXv
        4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAblRTKEnNKgUIBicXFSvp2NkX5pSWpChn5
        xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGR/mf2Aq2CBT8fjDO9YGxpPiXYyc
        HBICJhJ3vi9h72Lk4hAS2MEoMXlaBwuE84lR4tj3G1CZz4wS3We2McG07LjdzgqR2MUocWvt
        CUYI5wejxIV5D1hBqtgENCTWHDvEBJIQAUl8vbgCrJ1ZQE3i891lLCC2sECYxMOmFewgNouA
        qsSJ3TfAmnkFLCUebzwDtU5eYlHDbyaIuKDEyZlPWCDmyEs0b53NDLJAQuAvu8SJJZ+BHA4g
        x0XiTX8cRK+wxKvjW9ghbCmJz+/2skHYxRI/3qxmguhtYJRY2n6MGSJhLDHrWTsjyBxmAU2J
        9bv0IUYqSxy5BbWWT6Lj8F92iDCvREebEESjksSZubehwhISB2fnQJgeEtNeioBUCAnESsw9
        eIx1AqP8LCSvzELyyiyErQsYmVcxiqUWFOempxYbFZjA4zQ5P3cTIziVannsYJz99oPeIUYm
        DsZDjBIczEoivH0hCslCvCmJlVWpRfnxRaU5qcWHGE2BgTuRWUo0OR+YzPNK4g1NLA1MzMwM
        zY1MDcyVxHldtBmThQTSE0tSs1NTC1KLYPqYODilGphEjoZucnMrftuhY3/G5vPtiUlFl+q9
        JPJln87z+LS+riSl3/V5bNltU++rXK45zlzZFowcR40Tkh0v7ePytXHWn1x67vm7q9o9B5Mi
        mIUdSif3yOk4e31+sC/8RG9Q86/Fr45P+7mQdcniM/fauLP2vAkRuemplOf/xnBieWRJ5IRf
        38VTZCaK3tt08b68A8u0Fe8LjohoJPJJPIjps/XerVR4YsIafr1LConhbQWf9pUdPNi7TdSe
        dV9ppehK7rcb+q3lpojL84SXP5Tza/zSKBA0vV9Coel+sfeUC8fY5yXvD1qisWqSQsjvzZME
        PuSKOpz9t5fjQdP9zzesg08Fbb6QfT/1R7rhFOENMUosxRmJhlrMRcWJAESem4AuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvK7bLeVkg4YlshYP5m1js3j58yqb
        xcGHnSwWX5c+Y7WY9uEns8XqxQ9YLBbd2MZkcXPLURaLy7vmsFl0X9/BZrH8+D8mB26Py1e8
        PSYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwB7FJdNSmpOZllqkb5dAlfGh/kfmAo2
        yFQ8/vCOtYHxpHgXIyeHhICJxI7b7axdjFwcQgI7GCV6Gl+yQyQkJP4vbmKCsIUl7rccYQWx
        hQS+MUp8+lgPYrMJaEisOXaICaRZRKCFSaL19StmkASzgJrE57vLWEBsYYEQiaYJu8GaWQRU
        JU7svgFm8wpYSjzeeAZqgbzEoobfTBBxQYmTM5+wQMyRl2jeOpt5AiPfLCSpWUhSCxiZVjFK
        phYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAe4ltYOxj2rPugdYmTiYDzEKMHBrCTC2xei
        kCzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU1jOahMR
        zYwFXHvecp2U+parn5nxa9nD11POlUyuXnnrwH2L4y+WnTwTLZ2y0zGuyrT5wPHoyr3fcpNe
        /nnPJ7IoKvZ42Yyjofyhzr8s16hcmLHR/c6KW3q9F1bzRF44myRm/G++dUj0s2U3ZzI+ezEz
        YJ6emHDm6SNWVyNN1S68c9grrTLF+OPttolFn5RMDBYWX9PJnrtlp6bG4eWdbsKTnn2t5r/C
        u+tJ4xFlDm41DmvdnovXbdfdTpMo9UgvXvy6f07Iql7NkzUfucM1+nZfWPD6t0qoysN3F2R3
        7Snim+7T8NpSaWGijz9L4auXCSXyx8qvu22cMrF4QoI9r0NtfYzJolmKZ89KGd8Ve6jEUpyR
        aKjFXFScCADIRe9s3wIAAA==
X-CMS-MailID: 20220916020702epcas2p2c4f7c7bcc1507db171b40aa45d7fa7d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220916020702epcas2p2c4f7c7bcc1507db171b40aa45d7fa7d9
References: <CGME20220916020702epcas2p2c4f7c7bcc1507db171b40aa45d7fa7d9@epcas2p2.samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

v2->v3
fixed operator error

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd-priv.h |  7 +++++++
 drivers/ufs/core/ufshcd.c      |  2 ++
 drivers/ufs/host/ufs-exynos.c  | 20 ++++++++++++++++++++
 include/ufs/ufshcd.h           |  1 +
 4 files changed, 30 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d00dba17297d..a615f3533d75 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -221,6 +221,13 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
+					       bool *queue_eh_work)
+{
+	if (hba->vops && hba->vops->check_int_error)
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

