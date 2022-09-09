Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF835B3487
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIIJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiIIJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:50:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A684D268;
        Fri,  9 Sep 2022 02:49:59 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB1d6KzmzZcnL;
        Fri,  9 Sep 2022 17:45:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:51 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:51 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 08/10] crypto: hisilicon/zip - support zip capability
Date:   Fri, 9 Sep 2022 17:47:02 +0800
Message-ID: <20220909094704.32099-9-qianweili@huawei.com>
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

Add function 'hisi_zip_alg_support' to get device configuration
information from capability registers, instead of determining whether
to register an algorithm based on hardware platform's version.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip.h        |   1 +
 drivers/crypto/hisilicon/zip/zip_crypto.c |  67 +++++++++++---
 drivers/crypto/hisilicon/zip/zip_main.c   | 102 +++++++++++++++-------
 3 files changed, 128 insertions(+), 42 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index f289656e9ac0..f2e6da3240ae 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -84,4 +84,5 @@ struct hisi_zip_sqe {
 int zip_create_qps(struct hisi_qp **qps, int qp_num, int node);
 int hisi_zip_register_to_crypto(struct hisi_qm *qm);
 void hisi_zip_unregister_from_crypto(struct hisi_qm *qm);
+bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index a7f6884c3ab3..6608971d10cd 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -39,6 +39,9 @@
 #define HZIP_ALG_PRIORITY			300
 #define HZIP_SGL_SGE_NR				10
 
+#define HZIP_ALG_ZLIB				GENMASK(1, 0)
+#define HZIP_ALG_GZIP				GENMASK(3, 2)
+
 static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
 static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {
 	0x1f, 0x8b, 0x08, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x03
@@ -756,6 +759,28 @@ static struct acomp_alg hisi_zip_acomp_zlib = {
 	}
 };
 
+static int hisi_zip_register_zlib(struct hisi_qm *qm)
+{
+	int ret;
+
+	if (!hisi_zip_alg_support(qm, HZIP_ALG_ZLIB))
+		return 0;
+
+	ret = crypto_register_acomp(&hisi_zip_acomp_zlib);
+	if (ret)
+		dev_err(&qm->pdev->dev, "failed to register to zlib (%d)!\n", ret);
+
+	return ret;
+}
+
+static void hisi_zip_unregister_zlib(struct hisi_qm *qm)
+{
+	if (!hisi_zip_alg_support(qm, HZIP_ALG_ZLIB))
+		return;
+
+	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
+}
+
 static struct acomp_alg hisi_zip_acomp_gzip = {
 	.init			= hisi_zip_acomp_init,
 	.exit			= hisi_zip_acomp_exit,
@@ -770,27 +795,45 @@ static struct acomp_alg hisi_zip_acomp_gzip = {
 	}
 };
 
-int hisi_zip_register_to_crypto(struct hisi_qm *qm)
+static int hisi_zip_register_gzip(struct hisi_qm *qm)
 {
 	int ret;
 
-	ret = crypto_register_acomp(&hisi_zip_acomp_zlib);
-	if (ret) {
-		pr_err("failed to register to zlib (%d)!\n", ret);
-		return ret;
-	}
+	if (!hisi_zip_alg_support(qm, HZIP_ALG_GZIP))
+		return 0;
 
 	ret = crypto_register_acomp(&hisi_zip_acomp_gzip);
-	if (ret) {
-		pr_err("failed to register to gzip (%d)!\n", ret);
-		crypto_unregister_acomp(&hisi_zip_acomp_zlib);
-	}
+	if (ret)
+		dev_err(&qm->pdev->dev, "failed to register to gzip (%d)!\n", ret);
 
 	return ret;
 }
 
-void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
+static void hisi_zip_unregister_gzip(struct hisi_qm *qm)
 {
+	if (!hisi_zip_alg_support(qm, HZIP_ALG_GZIP))
+		return;
+
 	crypto_unregister_acomp(&hisi_zip_acomp_gzip);
-	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
+}
+
+int hisi_zip_register_to_crypto(struct hisi_qm *qm)
+{
+	int ret = 0;
+
+	ret = hisi_zip_register_zlib(qm);
+	if (ret)
+		return ret;
+
+	ret = hisi_zip_register_gzip(qm);
+	if (ret)
+		hisi_zip_unregister_zlib(qm);
+
+	return ret;
+}
+
+void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
+{
+	hisi_zip_unregister_zlib(qm);
+	hisi_zip_unregister_gzip(qm);
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 6ed10ec05a73..a8aedddac67a 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -20,18 +20,6 @@
 #define HZIP_QUEUE_NUM_V1		4096
 
 #define HZIP_CLOCK_GATE_CTRL		0x301004
-#define COMP0_ENABLE			BIT(0)
-#define COMP1_ENABLE			BIT(1)
-#define DECOMP0_ENABLE			BIT(2)
-#define DECOMP1_ENABLE			BIT(3)
-#define DECOMP2_ENABLE			BIT(4)
-#define DECOMP3_ENABLE			BIT(5)
-#define DECOMP4_ENABLE			BIT(6)
-#define DECOMP5_ENABLE			BIT(7)
-#define HZIP_ALL_COMP_DECOMP_EN		(COMP0_ENABLE | COMP1_ENABLE | \
-					 DECOMP0_ENABLE | DECOMP1_ENABLE | \
-					 DECOMP2_ENABLE | DECOMP3_ENABLE | \
-					 DECOMP4_ENABLE | DECOMP5_ENABLE)
 #define HZIP_DECOMP_CHECK_ENABLE	BIT(16)
 #define HZIP_FSM_MAX_CNT		0x301008
 
@@ -76,10 +64,6 @@
 #define HZIP_SRAM_ECC_ERR_NUM_SHIFT	16
 #define HZIP_SRAM_ECC_ERR_ADDR_SHIFT	24
 #define HZIP_CORE_INT_MASK_ALL		GENMASK(12, 0)
-#define HZIP_COMP_CORE_NUM		2
-#define HZIP_DECOMP_CORE_NUM		6
-#define HZIP_CORE_NUM			(HZIP_COMP_CORE_NUM + \
-					 HZIP_DECOMP_CORE_NUM)
 #define HZIP_SQE_SIZE			128
 #define HZIP_PF_DEF_Q_NUM		64
 #define HZIP_PF_DEF_Q_BASE		0
@@ -194,6 +178,21 @@ enum zip_cap_type {
 	ZIP_RESET_MASK_CAP,
 	ZIP_OOO_SHUTDOWN_MASK_CAP,
 	ZIP_CE_MASK_CAP,
+	ZIP_CLUSTER_NUM_CAP,
+	ZIP_CORE_TYPE_NUM_CAP,
+	ZIP_CORE_NUM_CAP,
+	ZIP_CLUSTER_COMP_NUM_CAP,
+	ZIP_CLUSTER_DECOMP_NUM_CAP,
+	ZIP_DECOMP_ENABLE_BITMAP,
+	ZIP_COMP_ENABLE_BITMAP,
+	ZIP_DRV_ALG_BITMAP,
+	ZIP_DEV_ALG_BITMAP,
+	ZIP_CORE1_ALG_BITMAP,
+	ZIP_CORE2_ALG_BITMAP,
+	ZIP_CORE3_ALG_BITMAP,
+	ZIP_CORE4_ALG_BITMAP,
+	ZIP_CORE5_ALG_BITMAP,
+	ZIP_CAP_MAX
 };
 
 static struct hisi_qm_cap_info zip_basic_cap_info[] = {
@@ -205,6 +204,21 @@ static struct hisi_qm_cap_info zip_basic_cap_info[] = {
 	{ZIP_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x7FE, 0x7FE},
 	{ZIP_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x2, 0x7FE},
 	{ZIP_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
+	{ZIP_CLUSTER_NUM_CAP, 0x313C, 28, GENMASK(3, 0), 0x1, 0x1, 0x1},
+	{ZIP_CORE_TYPE_NUM_CAP, 0x313C, 24, GENMASK(3, 0), 0x2, 0x2, 0x2},
+	{ZIP_CORE_NUM_CAP, 0x313C, 16, GENMASK(7, 0), 0x8, 0x8, 0x5},
+	{ZIP_CLUSTER_COMP_NUM_CAP, 0x313C, 8, GENMASK(7, 0), 0x2, 0x2, 0x2},
+	{ZIP_CLUSTER_DECOMP_NUM_CAP, 0x313C, 0, GENMASK(7, 0), 0x6, 0x6, 0x3},
+	{ZIP_DECOMP_ENABLE_BITMAP, 0x3140, 16, GENMASK(15, 0), 0xFC, 0xFC, 0x1C},
+	{ZIP_COMP_ENABLE_BITMAP, 0x3140, 0, GENMASK(15, 0), 0x3, 0x3, 0x3},
+	{ZIP_DRV_ALG_BITMAP, 0x3144, 0, GENMASK(31, 0), 0xF, 0xF, 0xF},
+	{ZIP_DEV_ALG_BITMAP, 0x3148, 0, GENMASK(31, 0), 0xF, 0xF, 0xFF},
+	{ZIP_CORE1_ALG_BITMAP, 0x314C, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
+	{ZIP_CORE2_ALG_BITMAP, 0x3150, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
+	{ZIP_CORE3_ALG_BITMAP, 0x3154, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
+	{ZIP_CORE4_ALG_BITMAP, 0x3158, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
+	{ZIP_CORE5_ALG_BITMAP, 0x315C, 0, GENMASK(31, 0), 0xA, 0xA, 0x2A},
+	{ZIP_CAP_MAX, 0x317c, 0, GENMASK(0, 0), 0x0, 0x0, 0x0}
 };
 
 enum {
@@ -363,6 +377,17 @@ int zip_create_qps(struct hisi_qp **qps, int qp_num, int node)
 	return hisi_qm_alloc_qps_node(&zip_devices, qp_num, 0, node, qps);
 }
 
+bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
+{
+	u32 cap_val;
+
+	cap_val = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_DRV_ALG_BITMAP, qm->cap_ver);
+	if ((alg & cap_val) == alg)
+		return true;
+
+	return false;
+}
+
 static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
@@ -421,6 +446,7 @@ static void hisi_zip_enable_clock_gate(struct hisi_qm *qm)
 static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 {
 	void __iomem *base = qm->io_base;
+	u32 dcomp_bm, comp_bm;
 
 	/* qm user domain */
 	writel(AXUSER_BASE, base + QM_ARUSER_M_CFG_1);
@@ -458,8 +484,11 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	}
 
 	/* let's open all compression/decompression cores */
-	writel(HZIP_DECOMP_CHECK_ENABLE | HZIP_ALL_COMP_DECOMP_EN,
-	       base + HZIP_CLOCK_GATE_CTRL);
+	dcomp_bm = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+				       ZIP_DECOMP_ENABLE_BITMAP, qm->cap_ver);
+	comp_bm = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
+				      ZIP_COMP_ENABLE_BITMAP, qm->cap_ver);
+	writel(HZIP_DECOMP_CHECK_ENABLE | dcomp_bm | comp_bm, base + HZIP_CLOCK_GATE_CTRL);
 
 	/* enable sqc,cqc writeback */
 	writel(SQC_CACHE_ENABLE | CQC_CACHE_ENABLE | SQC_CACHE_WB_ENABLE |
@@ -678,18 +707,23 @@ DEFINE_SHOW_ATTRIBUTE(hisi_zip_regs);
 
 static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 {
+	u32 zip_core_num, zip_comp_core_num;
 	struct device *dev = &qm->pdev->dev;
 	struct debugfs_regset32 *regset;
 	struct dentry *tmp_d;
 	char buf[HZIP_BUF_SIZE];
 	int i;
 
-	for (i = 0; i < HZIP_CORE_NUM; i++) {
-		if (i < HZIP_COMP_CORE_NUM)
+	zip_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CORE_NUM_CAP, qm->cap_ver);
+	zip_comp_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CLUSTER_COMP_NUM_CAP,
+						qm->cap_ver);
+
+	for (i = 0; i < zip_core_num; i++) {
+		if (i < zip_comp_core_num)
 			scnprintf(buf, sizeof(buf), "comp_core%d", i);
 		else
 			scnprintf(buf, sizeof(buf), "decomp_core%d",
-				  i - HZIP_COMP_CORE_NUM);
+				  i - zip_comp_core_num);
 
 		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
 		if (!regset)
@@ -702,7 +736,7 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 
 		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
 		debugfs_create_file("regs", 0444, tmp_d, regset,
-				     &hisi_zip_regs_fops);
+				    &hisi_zip_regs_fops);
 	}
 
 	return 0;
@@ -822,10 +856,13 @@ static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
 	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
 	struct qm_debug *debug = &qm->debug;
 	void __iomem *io_base;
+	u32 zip_core_num;
 	int i, j, idx;
 
-	debug->last_words = kcalloc(core_dfx_regs_num * HZIP_CORE_NUM +
-			com_dfx_regs_num, sizeof(unsigned int), GFP_KERNEL);
+	zip_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CORE_NUM_CAP, qm->cap_ver);
+
+	debug->last_words = kcalloc(core_dfx_regs_num * zip_core_num + com_dfx_regs_num,
+				    sizeof(unsigned int), GFP_KERNEL);
 	if (!debug->last_words)
 		return -ENOMEM;
 
@@ -834,7 +871,7 @@ static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
 		debug->last_words[i] = readl_relaxed(io_base);
 	}
 
-	for (i = 0; i < HZIP_CORE_NUM; i++) {
+	for (i = 0; i < zip_core_num; i++) {
 		io_base = qm->io_base + core_offsets[i];
 		for (j = 0; j < core_dfx_regs_num; j++) {
 			idx = com_dfx_regs_num + i * core_dfx_regs_num + j;
@@ -861,6 +898,7 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 {
 	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
 	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
+	u32 zip_core_num, zip_comp_core_num;
 	struct qm_debug *debug = &qm->debug;
 	char buf[HZIP_BUF_SIZE];
 	void __iomem *base;
@@ -874,15 +912,18 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 		val = readl_relaxed(qm->io_base + hzip_com_dfx_regs[i].offset);
 		if (debug->last_words[i] != val)
 			pci_info(qm->pdev, "com_dfx: %s \t= 0x%08x => 0x%08x\n",
-				hzip_com_dfx_regs[i].name, debug->last_words[i], val);
+				 hzip_com_dfx_regs[i].name, debug->last_words[i], val);
 	}
 
-	for (i = 0; i < HZIP_CORE_NUM; i++) {
-		if (i < HZIP_COMP_CORE_NUM)
+	zip_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CORE_NUM_CAP, qm->cap_ver);
+	zip_comp_core_num = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_CLUSTER_COMP_NUM_CAP,
+						qm->cap_ver);
+	for (i = 0; i < zip_core_num; i++) {
+		if (i < zip_comp_core_num)
 			scnprintf(buf, sizeof(buf), "Comp_core-%d", i);
 		else
 			scnprintf(buf, sizeof(buf), "Decomp_core-%d",
-				  i - HZIP_COMP_CORE_NUM);
+				  i - zip_comp_core_num);
 		base = qm->io_base + core_offsets[i];
 
 		pci_info(qm->pdev, "==>%s:\n", buf);
@@ -892,7 +933,8 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 			val = readl_relaxed(base + hzip_dump_dfx_regs[j].offset);
 			if (debug->last_words[idx] != val)
 				pci_info(qm->pdev, "%s \t= 0x%08x => 0x%08x\n",
-					hzip_dump_dfx_regs[j].name, debug->last_words[idx], val);
+					 hzip_dump_dfx_regs[j].name,
+					 debug->last_words[idx], val);
 		}
 	}
 }
-- 
2.33.0

