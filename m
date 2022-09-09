Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4B5B347D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiIIJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiIIJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C233429;
        Fri,  9 Sep 2022 02:49:51 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MPB2G4w2yzlVkj;
        Fri,  9 Sep 2022 17:45:58 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:49 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:49 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Zhiqi Song <songzhiqi1@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 06/10] crypto: hisilicon/hpre - support hpre capability
Date:   Fri, 9 Sep 2022 17:47:00 +0800
Message-ID: <20220909094704.32099-7-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220909094704.32099-1-qianweili@huawei.com>
References: <20220909094704.32099-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqi Song <songzhiqi1@huawei.com>

Read some hpre device configuration info from capability
register, instead of fixed macros.

Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h        |   8 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 134 ++++++++++++++++----
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  53 +++++++-
 3 files changed, 157 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index 9a0558ed82f9..9f0b94c8e03d 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -22,7 +22,8 @@ enum {
 	HPRE_CLUSTER0,
 	HPRE_CLUSTER1,
 	HPRE_CLUSTER2,
-	HPRE_CLUSTER3
+	HPRE_CLUSTER3,
+	HPRE_CLUSTERS_NUM_MAX
 };
 
 enum hpre_ctrl_dbgfs_file {
@@ -42,9 +43,6 @@ enum hpre_dfx_dbgfs_file {
 	HPRE_DFX_FILE_NUM
 };
 
-#define HPRE_CLUSTERS_NUM_V2		(HPRE_CLUSTER3 + 1)
-#define HPRE_CLUSTERS_NUM_V3		1
-#define HPRE_CLUSTERS_NUM_MAX		HPRE_CLUSTERS_NUM_V2
 #define HPRE_DEBUGFS_FILE_NUM (HPRE_DEBUG_FILE_NUM + HPRE_CLUSTERS_NUM_MAX - 1)
 
 struct hpre_debugfs_file {
@@ -105,5 +103,5 @@ struct hpre_sqe {
 struct hisi_qp *hpre_create_qp(u8 type);
 int hpre_algs_register(struct hisi_qm *qm);
 void hpre_algs_unregister(struct hisi_qm *qm);
-
+bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg);
 #endif
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 2aa91a4f77da..ad1475feb313 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -51,6 +51,12 @@ struct hpre_ctx;
 #define HPRE_ECC_HW256_KSZ_B	32
 #define HPRE_ECC_HW384_KSZ_B	48
 
+/* capability register mask */
+#define HPRE_DRV_RSA_MASK_CAP          BIT(0)
+#define HPRE_DRV_DH_MASK_CAP           BIT(1)
+#define HPRE_DRV_ECDH_MASK_CAP         BIT(2)
+#define HPRE_DRV_X25519_MASK_CAP       BIT(5)
+
 typedef void (*hpre_cb)(struct hpre_ctx *ctx, void *sqe);
 
 struct hpre_rsa_ctx {
@@ -2070,22 +2076,75 @@ static struct kpp_alg curve25519_alg = {
 	},
 };
 
+static int hpre_register_rsa(struct hisi_qm *qm)
+{
+	int ret;
+
+	if (!hpre_check_alg_support(qm, HPRE_DRV_RSA_MASK_CAP))
+		return 0;
 
-static int hpre_register_ecdh(void)
+	rsa.base.cra_flags = 0;
+	ret = crypto_register_akcipher(&rsa);
+	if (ret)
+		dev_err(&qm->pdev->dev, "failed to register rsa (%d)!\n", ret);
+
+	return ret;
+}
+
+static void hpre_unregister_rsa(struct hisi_qm *qm)
+{
+	if (!hpre_check_alg_support(qm, HPRE_DRV_RSA_MASK_CAP))
+		return;
+
+	crypto_unregister_akcipher(&rsa);
+}
+
+static int hpre_register_dh(struct hisi_qm *qm)
 {
 	int ret;
 
-	ret = crypto_register_kpp(&ecdh_nist_p192);
+	if (!hpre_check_alg_support(qm, HPRE_DRV_DH_MASK_CAP))
+		return 0;
+
+	ret = crypto_register_kpp(&dh);
 	if (ret)
+		dev_err(&qm->pdev->dev, "failed to register dh (%d)!\n", ret);
+
+	return ret;
+}
+
+static void hpre_unregister_dh(struct hisi_qm *qm)
+{
+	if (!hpre_check_alg_support(qm, HPRE_DRV_DH_MASK_CAP))
+		return;
+
+	crypto_unregister_kpp(&dh);
+}
+
+static int hpre_register_ecdh(struct hisi_qm *qm)
+{
+	int ret;
+
+	if (!hpre_check_alg_support(qm, HPRE_DRV_ECDH_MASK_CAP))
+		return 0;
+
+	ret = crypto_register_kpp(&ecdh_nist_p192);
+	if (ret) {
+		dev_err(&qm->pdev->dev, "failed to register ecdh_nist_p192 (%d)!\n", ret);
 		return ret;
+	}
 
 	ret = crypto_register_kpp(&ecdh_nist_p256);
-	if (ret)
+	if (ret) {
+		dev_err(&qm->pdev->dev, "failed to register ecdh_nist_p256 (%d)!\n", ret);
 		goto unregister_ecdh_p192;
+	}
 
 	ret = crypto_register_kpp(&ecdh_nist_p384);
-	if (ret)
+	if (ret) {
+		dev_err(&qm->pdev->dev, "failed to register ecdh_nist_p384 (%d)!\n", ret);
 		goto unregister_ecdh_p256;
+	}
 
 	return 0;
 
@@ -2096,52 +2155,73 @@ static int hpre_register_ecdh(void)
 	return ret;
 }
 
-static void hpre_unregister_ecdh(void)
+static void hpre_unregister_ecdh(struct hisi_qm *qm)
 {
+	if (!hpre_check_alg_support(qm, HPRE_DRV_ECDH_MASK_CAP))
+		return;
+
 	crypto_unregister_kpp(&ecdh_nist_p384);
 	crypto_unregister_kpp(&ecdh_nist_p256);
 	crypto_unregister_kpp(&ecdh_nist_p192);
 }
 
+static int hpre_register_x25519(struct hisi_qm *qm)
+{
+	int ret;
+
+	if (!hpre_check_alg_support(qm, HPRE_DRV_X25519_MASK_CAP))
+		return 0;
+
+	ret = crypto_register_kpp(&curve25519_alg);
+	if (ret)
+		dev_err(&qm->pdev->dev, "failed to register x25519 (%d)!\n", ret);
+
+	return ret;
+}
+
+static void hpre_unregister_x25519(struct hisi_qm *qm)
+{
+	if (!hpre_check_alg_support(qm, HPRE_DRV_X25519_MASK_CAP))
+		return;
+
+	crypto_unregister_kpp(&curve25519_alg);
+}
+
 int hpre_algs_register(struct hisi_qm *qm)
 {
 	int ret;
 
-	rsa.base.cra_flags = 0;
-	ret = crypto_register_akcipher(&rsa);
+	ret = hpre_register_rsa(qm);
 	if (ret)
 		return ret;
 
-	ret = crypto_register_kpp(&dh);
+	ret = hpre_register_dh(qm);
 	if (ret)
 		goto unreg_rsa;
 
-	if (qm->ver >= QM_HW_V3) {
-		ret = hpre_register_ecdh();
-		if (ret)
-			goto unreg_dh;
-		ret = crypto_register_kpp(&curve25519_alg);
-		if (ret)
-			goto unreg_ecdh;
-	}
-	return 0;
+	ret = hpre_register_ecdh(qm);
+	if (ret)
+		goto unreg_dh;
+
+	ret = hpre_register_x25519(qm);
+	if (ret)
+		goto unreg_ecdh;
+
+	return ret;
 
 unreg_ecdh:
-	hpre_unregister_ecdh();
+	hpre_unregister_ecdh(qm);
 unreg_dh:
-	crypto_unregister_kpp(&dh);
+	hpre_unregister_dh(qm);
 unreg_rsa:
-	crypto_unregister_akcipher(&rsa);
+	hpre_unregister_rsa(qm);
 	return ret;
 }
 
 void hpre_algs_unregister(struct hisi_qm *qm)
 {
-	if (qm->ver >= QM_HW_V3) {
-		crypto_unregister_kpp(&curve25519_alg);
-		hpre_unregister_ecdh();
-	}
-
-	crypto_unregister_kpp(&dh);
-	crypto_unregister_akcipher(&rsa);
+	hpre_unregister_x25519(qm);
+	hpre_unregister_ecdh(qm);
+	hpre_unregister_dh(qm);
+	hpre_unregister_rsa(qm);
 }
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 36177c437c56..407cdd9d8413 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -77,8 +77,6 @@
 #define HPRE_QM_AXI_CFG_MASK		GENMASK(15, 0)
 #define HPRE_QM_VFG_AX_MASK		GENMASK(7, 0)
 #define HPRE_BD_USR_MASK		GENMASK(1, 0)
-#define HPRE_CLUSTER_CORE_MASK_V2	GENMASK(3, 0)
-#define HPRE_CLUSTER_CORE_MASK_V3	GENMASK(7, 0)
 #define HPRE_PREFETCH_CFG		0x301130
 #define HPRE_SVA_PREFTCH_DFX		0x30115C
 #define HPRE_PREFETCH_ENABLE		(~(BIT(0) | BIT(30)))
@@ -154,6 +152,23 @@ enum hpre_cap_type {
 	HPRE_RESET_MASK_CAP,
 	HPRE_OOO_SHUTDOWN_MASK_CAP,
 	HPRE_CE_MASK_CAP,
+	HPRE_CLUSTER_NUM_CAP,
+	HPRE_CORE_TYPE_NUM_CAP,
+	HPRE_CORE_NUM_CAP,
+	HPRE_CLUSTER_CORE_NUM_CAP,
+	HPRE_CORE_ENABLE_BITMAP_CAP,
+	HPRE_DRV_ALG_BITMAP_CAP,
+	HPRE_DEV_ALG_BITMAP_CAP,
+	HPRE_CORE1_ALG_BITMAP_CAP,
+	HPRE_CORE2_ALG_BITMAP_CAP,
+	HPRE_CORE3_ALG_BITMAP_CAP,
+	HPRE_CORE4_ALG_BITMAP_CAP,
+	HPRE_CORE5_ALG_BITMAP_CAP,
+	HPRE_CORE6_ALG_BITMAP_CAP,
+	HPRE_CORE7_ALG_BITMAP_CAP,
+	HPRE_CORE8_ALG_BITMAP_CAP,
+	HPRE_CORE9_ALG_BITMAP_CAP,
+	HPRE_CORE10_ALG_BITMAP_CAP
 };
 
 static const struct hisi_qm_cap_info hpre_basic_info[] = {
@@ -165,6 +180,23 @@ static const struct hisi_qm_cap_info hpre_basic_info[] = {
 	{HPRE_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xBFFFFE},
 	{HPRE_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x22, 0xBFFFFE},
 	{HPRE_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
+	{HPRE_CLUSTER_NUM_CAP, 0x313c, 20, GENMASK(3, 0), 0x0,  0x4, 0x1},
+	{HPRE_CORE_TYPE_NUM_CAP, 0x313c, 16, GENMASK(3, 0), 0x0, 0x2, 0x2},
+	{HPRE_CORE_NUM_CAP, 0x313c, 8, GENMASK(7, 0), 0x0, 0x8, 0xA},
+	{HPRE_CLUSTER_CORE_NUM_CAP, 0x313c, 0, GENMASK(7, 0), 0x0, 0x2, 0xA},
+	{HPRE_CORE_ENABLE_BITMAP_CAP, 0x3140, 0, GENMASK(31, 0), 0x0, 0xF, 0x3FF},
+	{HPRE_DRV_ALG_BITMAP_CAP, 0x3144, 0, GENMASK(31, 0), 0x0, 0x03, 0x27},
+	{HPRE_DEV_ALG_BITMAP_CAP, 0x3148, 0, GENMASK(31, 0), 0x0, 0x03, 0x7F},
+	{HPRE_CORE1_ALG_BITMAP_CAP, 0x314c, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE2_ALG_BITMAP_CAP, 0x3150, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE3_ALG_BITMAP_CAP, 0x3154, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE4_ALG_BITMAP_CAP, 0x3158, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE5_ALG_BITMAP_CAP, 0x315c, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE6_ALG_BITMAP_CAP, 0x3160, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE7_ALG_BITMAP_CAP, 0x3164, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE8_ALG_BITMAP_CAP, 0x3168, 0, GENMASK(31, 0), 0x0, 0x7F, 0x7F},
+	{HPRE_CORE9_ALG_BITMAP_CAP, 0x316c, 0, GENMASK(31, 0), 0x0, 0x10, 0x10},
+	{HPRE_CORE10_ALG_BITMAP_CAP, 0x3170, 0, GENMASK(31, 0), 0x0, 0x10, 0x10}
 };
 
 static const struct hpre_hw_error hpre_hw_errors[] = {
@@ -282,6 +314,17 @@ static struct dfx_diff_registers hpre_diff_regs[] = {
 	},
 };
 
+bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
+{
+	u32 cap_val;
+
+	cap_val = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_DRV_ALG_BITMAP_CAP, qm->cap_ver);
+	if (alg & cap_val)
+		return true;
+
+	return false;
+}
+
 static int hpre_diff_regs_show(struct seq_file *s, void *unused)
 {
 	struct hisi_qm *qm = s->private;
@@ -350,14 +393,12 @@ MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63), 0(default)");
 
 static inline int hpre_cluster_num(struct hisi_qm *qm)
 {
-	return (qm->ver >= QM_HW_V3) ? HPRE_CLUSTERS_NUM_V3 :
-		HPRE_CLUSTERS_NUM_V2;
+	return hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CLUSTER_NUM_CAP, qm->cap_ver);
 }
 
 static inline int hpre_cluster_core_mask(struct hisi_qm *qm)
 {
-	return (qm->ver >= QM_HW_V3) ?
-		HPRE_CLUSTER_CORE_MASK_V3 : HPRE_CLUSTER_CORE_MASK_V2;
+	return hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CORE_ENABLE_BITMAP_CAP, qm->cap_ver);
 }
 
 struct hisi_qp *hpre_create_qp(u8 type)
-- 
2.33.0

