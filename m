Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44B5B6577
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIMCRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIMCR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:17:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D7F52DC8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:17:23 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220913021717epoutp03d175c9035d86260e0d8d76fa06ea03f5~USetqU5B61878318783epoutp03n
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220913021717epoutp03d175c9035d86260e0d8d76fa06ea03f5~USetqU5B61878318783epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663035437;
        bh=Xt7hBHJ8yjIMNZ5a6dx+1Kpdxo8fCDNlliLsKLUIwqE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SkO4ZnaZnfXLoAzPIvyaSuv2EjFZ46IBtI7OM1T0CThRLEPgzDwbS/NT41MxWMi+C
         cLmNcLlAXTQbI9ELv1/sUKNXfyQYELHwixClSB0IGOl0AtmFOOKXoj0uF+vuQACuv+
         Ek+BEz5m7Jb8GZXnoqofxPXy66xjexio/vDjXk9k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220913021717epcas2p35671f76683ee8654419379007f9a1d1d~USetCwYmX1085410854epcas2p37;
        Tue, 13 Sep 2022 02:17:17 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MRRth54Ddz4x9QH; Tue, 13 Sep
        2022 02:17:16 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.13.22030.C28EF136; Tue, 13 Sep 2022 11:17:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f~USesKx-Ov2691926919epcas2p1x;
        Tue, 13 Sep 2022 02:17:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220913021716epsmtrp2f5e56514f37f5343a264f431a9037b5b~USesJ7bNd0127801278epsmtrp2a;
        Tue, 13 Sep 2022 02:17:16 +0000 (GMT)
X-AuditID: b6c32a48-8a1ff7000001560e-fb-631fe82c60a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.E6.14392.C28EF136; Tue, 13 Sep 2022 11:17:16 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220913021715epsmtip1077428d37017a885dab362bf7f27bc27~USer4WVE52418424184epsmtip1J;
        Tue, 13 Sep 2022 02:17:15 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Mon, 12 Sep 2022 23:00:00 +0900
Message-Id: <20220912140000.95483-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmma7OC/lkg+M31C0ezNvGZrG37QS7
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVnc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mB1+PyFW+Py329TB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn0X6gmymAIyrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoZCWFssScUqBQ
        QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbSLt2C
        DpmKbfPfsjQwbhHvYuTkkBAwkXjc18ncxcjFISSwg1Fi9f5TUM4nRolNZ+ewQjjfGCWerf3M
        CNMy6XI3C4gtJLCXUWLdnEiIoh+MEgtWX2QCSbAJaEisOXaICSQhIrCCSaJn0yewBLOAmsTn
        u8vAuoUFwiTOL3zADmKzCKhKfNw8A6yGV8BS4l77dhaIbfISixp+Q8UFJU7OfMICMUdeonnr
        bLBbJQQmckjc3PcTqsFF4szFqewQtrDEq+NboGwpic/v9rJB2MUSP96sZoJobmCUWNp+jBki
        YSwx61k70J8cQBs0Jdbv0gcxJQSUJY7cgtrLJ9Fx+C87RJhXoqNNCKJRSeLM3NtQYQmJg7Nz
        IMIeEv17T7JBwipWYtWbd2wTGOVnIXlmFpJnZiGsXcDIvIpRLLWgODc9tdiowAQep8n5uZsY
        wYlWy2MH4+y3H/QOMTJxMB5ilOBgVhLh3a4qnyzEm5JYWZValB9fVJqTWnyI0RQYvBOZpUST
        84GpPq8k3tDE0sDEzMzQ3MjUwFxJnNdFmzFZSCA9sSQ1OzW1ILUIpo+Jg1OqgcnQfd39r64r
        7vJbmjPwG92K3HX0edK8VUvMZDk+fv5SNNkmle2E48LKuOXH/oT0TFX/dDnnlIXggvi5GtMM
        jAuCEpm3z2c47Cf6QuhmqfC71JvmH6InppT9OcnbtmxGY6h/nEf6k4+eB3rC503e3LLvVKLd
        qh+yOSI2p16FRBnmqsX9dD6VkWZt0Nj3S6vXuO7w4urql1zckwszr+/3VQlceGFy5Y/bMx/u
        ENZf/zbBTczapaVIb8o2w07zZ5rNt/sehH6weM5St+px5TvT0FcHGyYXLlubuHqT1bmloXxh
        3HfiBV65f2fkc+E8tDNQMHuPUcqZsFv1zqa2Ku/r7m57bNH0+IOoZoNHbUBAixJLcUaioRZz
        UXEiAKl7qB89BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnK7OC/lkg85pLBYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEcVlk5Ka
        k1mWWqRvl8CVsbRLt6BDpmLb/LcsDYxbxLsYOTkkBEwkJl3uZuli5OIQEtjNKDH18BRWiISE
        xP/FTUwQtrDE/ZYjrBBF3xgl/m28zgySYBPQkFhz7BATSEJEYBuTxN0PJ9lAEswCahKf7y5j
        AbGFBUIkWlb9ZAexWQRUJT5ungE2lVfAUuJe+3YWiA3yEosafkPFBSVOznzCAjFHXqJ562zm
        CYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERz+Wpo7GLev+qB3
        iJGJg/EQowQHs5II73ZV+WQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YW
        pBbBZJk4OKUamDb4iOQf+zn/6oKsypPNEczXDn/X+j3HqilnqXDPQkeZnR+Frkx0Ug9wsPq0
        zN+Ge054SqVv4TYO2dc7s4yPCT70rtspVLjt5d3sZ2VZffvtnrS6V88p3XrDadmn0/cnrmz0
        vrNx7aPqlq4Xz8U3nHaeoBdu1+7IGcVzblWMBndW4BOxPV5zM1tfZBdenXj4wv8WsYML3k/i
        u9I5VSD04H6/7qdb7hrrTba9ttpVJfuoxA7BuCfr9tSn9V08pazhdClIp+vAAy21LfUd57xu
        V+/xO1wpFmA708Zemq+c4UJI4pops8wKzIRezH3WcHz+oY8zORbMrjGR7pj74MrEs0Xv7iv+
        P3ozx5WDxbzhyUklluKMREMt5qLiRABaMWZW7gIAAA==
X-CMS-MailID: 20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f
References: <CGME20220913021716epcas2p1efd3b034f92e0e6df1544f067acbe73f@epcas2p1.samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ufs_hba_variant_ops about vendor error in check_error.
It need to reset when occurred ah8 related error.
At that time could not recovery with pwr cmd.
So add vendor error check function at ufs_hba_variant_ops.

Change-Id: I24c76a372931e702b357c86a5dc36e93ce4b5fda
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd-priv.h |  7 +++++++
 drivers/ufs/core/ufshcd.c      |  2 ++
 drivers/ufs/host/ufs-exynos.c  | 19 +++++++++++++++++++
 include/ufs/ufshcd.h           |  1 +
 4 files changed, 29 insertions(+)

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
index eced97538082..b351b8e48b08 100644
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
@@ -1376,6 +1380,20 @@ static void exynos_ufs_hibern8_notify(struct ufs_hba *hba,
 	}
 }
 
+static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool *queue_eh_work)
+{
+	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
+
+	if (ufshcd_is_auto_hibern8_supported(hba)) {
+		val = hci_readl(ufs, HCI_AH8_STATE);
+
+		if (val & HCI_AH8_STATE_ERROR) {
+			 ufshcd_set_link_broken(hba);
+			 queue_eh_work = true;
+		}
+	}
+}
+
 static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	enum ufs_notify_change_status status)
 {
@@ -1569,6 +1587,7 @@ static const struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
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

