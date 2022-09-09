Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7D5B348A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiIIJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiIIJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:50:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DEA45040;
        Fri,  9 Sep 2022 02:49:56 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MPB3n6CHVznV5r;
        Fri,  9 Sep 2022 17:47:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:53 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:53 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Zhiqi Song <songzhiqi1@huawei.com>,
        Wenkai Lin <linwenkai6@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 10/10] crypto: hisilicon - support get algs by the capability register
Date:   Fri, 9 Sep 2022 17:47:04 +0800
Message-ID: <20220909094704.32099-11-qianweili@huawei.com>
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

The value of qm algorithm can change dynamically according to the
value of the capability register.

Add xxx_set_qm_algs() function to obtain the algs that the
hardware device supported from the capability register and set
them into usr mode attribute files.

Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 10 +--
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 83 +++++++++++++++++++--
 drivers/crypto/hisilicon/qm.c               |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c    | 71 +++++++++++++++++-
 drivers/crypto/hisilicon/zip/zip_main.c     | 75 +++++++++++++++++--
 5 files changed, 222 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index ac7fabf65865..ef02dadd6217 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -51,11 +51,11 @@ struct hpre_ctx;
 #define HPRE_ECC_HW256_KSZ_B	32
 #define HPRE_ECC_HW384_KSZ_B	48
 
-/* capability register mask */
-#define HPRE_DRV_RSA_MASK_CAP          BIT(0)
-#define HPRE_DRV_DH_MASK_CAP           BIT(1)
-#define HPRE_DRV_ECDH_MASK_CAP         BIT(2)
-#define HPRE_DRV_X25519_MASK_CAP       BIT(5)
+/* capability register mask of driver */
+#define HPRE_DRV_RSA_MASK_CAP		BIT(0)
+#define HPRE_DRV_DH_MASK_CAP		BIT(1)
+#define HPRE_DRV_ECDH_MASK_CAP		BIT(2)
+#define HPRE_DRV_X25519_MASK_CAP	BIT(5)
 
 typedef void (*hpre_cb)(struct hpre_ctx *ctx, void *sqe);
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 407cdd9d8413..471e5ca720f5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -118,6 +118,8 @@
 #define HPRE_DFX_COMMON2_LEN		0xE
 #define HPRE_DFX_CORE_LEN		0x43
 
+#define HPRE_DEV_ALG_MAX_LEN	256
+
 static const char hpre_name[] = "hisi_hpre";
 static struct dentry *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
@@ -133,6 +135,38 @@ struct hpre_hw_error {
 	const char *msg;
 };
 
+struct hpre_dev_alg {
+	u32 alg_msk;
+	const char *alg;
+};
+
+static const struct hpre_dev_alg hpre_dev_algs[] = {
+	{
+		.alg_msk = BIT(0),
+		.alg = "rsa\n"
+	}, {
+		.alg_msk = BIT(1),
+		.alg = "dh\n"
+	}, {
+		.alg_msk = BIT(2),
+		.alg = "ecdh\n"
+	}, {
+		.alg_msk = BIT(3),
+		.alg = "ecdsa\n"
+	}, {
+		.alg_msk = BIT(4),
+		.alg = "sm2\n"
+	}, {
+		.alg_msk = BIT(5),
+		.alg = "x25519\n"
+	}, {
+		.alg_msk = BIT(6),
+		.alg = "x448\n"
+	}, {
+		/* sentinel */
+	}
+};
+
 static struct hisi_qm_list hpre_devices = {
 	.register_to_crypto	= hpre_algs_register,
 	.unregister_from_crypto	= hpre_algs_unregister,
@@ -325,6 +359,35 @@ bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
 	return false;
 }
 
+static int hpre_set_qm_algs(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	char *algs, *ptr;
+	u32 alg_msk;
+	int i;
+
+	if (!qm->use_sva)
+		return 0;
+
+	algs = devm_kzalloc(dev, HPRE_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
+	if (!algs)
+		return -ENOMEM;
+
+	alg_msk = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_DEV_ALG_BITMAP_CAP, qm->cap_ver);
+
+	for (i = 0; i < ARRAY_SIZE(hpre_dev_algs); i++)
+		if (alg_msk & hpre_dev_algs[i].alg_msk)
+			strcat(algs, hpre_dev_algs[i].alg);
+
+	ptr = strrchr(algs, '\n');
+	if (ptr)
+		*ptr = '\0';
+
+	qm->uacce->algs = algs;
+
+	return 0;
+}
+
 static int hpre_diff_regs_show(struct seq_file *s, void *unused)
 {
 	struct hisi_qm *qm = s->private;
@@ -1073,15 +1136,13 @@ static void hpre_debugfs_exit(struct hisi_qm *qm)
 
 static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
+	int ret;
+
 	if (pdev->revision == QM_HW_V1) {
 		pci_warn(pdev, "HPRE version 1 is not supported!\n");
 		return -EINVAL;
 	}
 
-	if (pdev->revision >= QM_HW_V3)
-		qm->algs = "rsa\ndh\necdh\nx25519\nx448\necdsa\nsm2";
-	else
-		qm->algs = "rsa\ndh";
 	qm->mode = uacce_mode;
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
@@ -1097,7 +1158,19 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qm_list = &hpre_devices;
 	}
 
-	return hisi_qm_init(qm);
+	ret = hisi_qm_init(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to init hpre qm configures!\n");
+		return ret;
+	}
+
+	ret = hpre_set_qm_algs(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to set hpre algs!\n");
+		hisi_qm_uninit(qm);
+	}
+
+	return ret;
 }
 
 static int hpre_show_last_regs_init(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e4a506d02d23..30fdf0673f00 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3484,7 +3484,6 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 
 	uacce->is_vf = pdev->is_virtfn;
 	uacce->priv = qm;
-	uacce->algs = qm->algs;
 
 	if (qm->ver == QM_HW_V1)
 		uacce->api_ver = HISI_QM_API_VER_BASE;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 84233a489c74..3705412bac5f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -115,6 +115,14 @@
 
 #define SEC_ALG_BITMAP_SHIFT		32
 
+#define SEC_CIPHER_BITMAP		(GENMASK_ULL(5, 0) | GENMASK_ULL(16, 12) | \
+					GENMASK(24, 21))
+#define SEC_DIGEST_BITMAP		(GENMASK_ULL(11, 8) | GENMASK_ULL(20, 19) | \
+					GENMASK_ULL(42, 25))
+#define SEC_AEAD_BITMAP			(GENMASK_ULL(7, 6) | GENMASK_ULL(18, 17) | \
+					GENMASK_ULL(45, 43))
+#define SEC_DEV_ALG_MAX_LEN		256
+
 struct sec_hw_error {
 	u32 int_msk;
 	const char *msg;
@@ -125,6 +133,11 @@ struct sec_dfx_item {
 	u32 offset;
 };
 
+struct sec_dev_alg {
+	u64 alg_msk;
+	const char *algs;
+};
+
 static const char sec_name[] = "hisi_sec2";
 static struct dentry *sec_debugfs_root;
 
@@ -161,6 +174,18 @@ static const struct hisi_qm_cap_info sec_basic_info[] = {
 	{SEC_CORE4_ALG_BITMAP_HIGH, 0x3170, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
 };
 
+static const struct sec_dev_alg sec_dev_algs[] = { {
+		.alg_msk = SEC_CIPHER_BITMAP,
+		.algs = "cipher\n",
+	}, {
+		.alg_msk = SEC_DIGEST_BITMAP,
+		.algs = "digest\n",
+	}, {
+		.alg_msk = SEC_AEAD_BITMAP,
+		.algs = "aead\n",
+	},
+};
+
 static const struct sec_hw_error sec_hw_errors[] = {
 	{
 		.int_msk = BIT(0),
@@ -1052,11 +1077,41 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	return ret;
 }
 
+static int sec_set_qm_algs(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	char *algs, *ptr;
+	u64 alg_mask;
+	int i;
+
+	if (!qm->use_sva)
+		return 0;
+
+	algs = devm_kzalloc(dev, SEC_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
+	if (!algs)
+		return -ENOMEM;
+
+	alg_mask = sec_get_alg_bitmap(qm, SEC_DEV_ALG_BITMAP_HIGH, SEC_DEV_ALG_BITMAP_LOW);
+
+	for (i = 0; i < ARRAY_SIZE(sec_dev_algs); i++)
+		if (alg_mask & sec_dev_algs[i].alg_msk)
+			strcat(algs, sec_dev_algs[i].algs);
+
+	ptr = strrchr(algs, '\n');
+	if (ptr)
+		*ptr = '\0';
+
+	qm->uacce->algs = algs;
+
+	return 0;
+}
+
 static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
+	int ret;
+
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
-	qm->algs = "cipher\ndigest\naead";
 	qm->mode = uacce_mode;
 	qm->sqe_size = SEC_SQE_SIZE;
 	qm->dev_name = sec_name;
@@ -1079,7 +1134,19 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = SEC_QUEUE_NUM_V1 - SEC_PF_DEF_Q_NUM;
 	}
 
-	return hisi_qm_init(qm);
+	ret = hisi_qm_init(qm);
+	if (ret) {
+		pci_err(qm->pdev, "Failed to init sec qm configures!\n");
+		return ret;
+	}
+
+	ret = sec_set_qm_algs(qm);
+	if (ret) {
+		pci_err(qm->pdev, "Failed to set sec algs!\n");
+		hisi_qm_uninit(qm);
+	}
+
+	return ret;
 }
 
 static void sec_qm_uninit(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index a8aedddac67a..c863435e8c75 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -74,6 +74,12 @@
 #define HZIP_AXI_SHUTDOWN_ENABLE	BIT(14)
 #define HZIP_WR_PORT			BIT(11)
 
+#define HZIP_DEV_ALG_MAX_LEN		256
+#define HZIP_ALG_ZLIB_BIT		GENMASK(1, 0)
+#define HZIP_ALG_GZIP_BIT		GENMASK(3, 2)
+#define HZIP_ALG_DEFLATE_BIT		GENMASK(5, 4)
+#define HZIP_ALG_LZ77_BIT		GENMASK(7, 6)
+
 #define HZIP_BUF_SIZE			22
 #define HZIP_SQE_MASK_OFFSET		64
 #define HZIP_SQE_MASK_LEN		48
@@ -114,6 +120,26 @@ struct zip_dfx_item {
 	u32 offset;
 };
 
+struct zip_dev_alg {
+	u32 alg_msk;
+	const char *algs;
+};
+
+static const struct zip_dev_alg zip_dev_algs[] = { {
+		.alg_msk = HZIP_ALG_ZLIB_BIT,
+		.algs = "zlib\n",
+	}, {
+		.alg_msk = HZIP_ALG_GZIP_BIT,
+		.algs = "gzip\n",
+	}, {
+		.alg_msk = HZIP_ALG_DEFLATE_BIT,
+		.algs = "deflate\n",
+	}, {
+		.alg_msk = HZIP_ALG_LZ77_BIT,
+		.algs = "lz77_zstd\n",
+	},
+};
+
 static struct hisi_qm_list zip_devices = {
 	.register_to_crypto	= hisi_zip_register_to_crypto,
 	.unregister_from_crypto	= hisi_zip_unregister_from_crypto,
@@ -388,6 +414,35 @@ bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
 	return false;
 }
 
+static int hisi_zip_set_qm_algs(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	char *algs, *ptr;
+	u32 alg_mask;
+	int i;
+
+	if (!qm->use_sva)
+		return 0;
+
+	algs = devm_kzalloc(dev, HZIP_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
+	if (!algs)
+		return -ENOMEM;
+
+	alg_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_DEV_ALG_BITMAP, qm->cap_ver);
+
+	for (i = 0; i < ARRAY_SIZE(zip_dev_algs); i++)
+		if (alg_mask & zip_dev_algs[i].alg_msk)
+			strcat(algs, zip_dev_algs[i].algs);
+
+	ptr = strrchr(algs, '\n');
+	if (ptr)
+		*ptr = '\0';
+
+	qm->uacce->algs = algs;
+
+	return 0;
+}
+
 static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
@@ -1071,12 +1126,10 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 
 static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
+	int ret;
+
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
-	if (pdev->revision >= QM_HW_V3)
-		qm->algs = "zlib\ngzip\ndeflate\nlz77_zstd";
-	else
-		qm->algs = "zlib\ngzip";
 	qm->mode = uacce_mode;
 	qm->sqe_size = HZIP_SQE_SIZE;
 	qm->dev_name = hisi_zip_name;
@@ -1100,7 +1153,19 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = HZIP_QUEUE_NUM_V1 - HZIP_PF_DEF_Q_NUM;
 	}
 
-	return hisi_qm_init(qm);
+	ret = hisi_qm_init(qm);
+	if (ret) {
+		pci_err(qm->pdev, "Failed to init zip qm configures!\n");
+		return ret;
+	}
+
+	ret = hisi_zip_set_qm_algs(qm);
+	if (ret) {
+		pci_err(qm->pdev, "Failed to set zip algs!\n");
+		hisi_qm_uninit(qm);
+	}
+
+	return ret;
 }
 
 static void hisi_zip_qm_uninit(struct hisi_qm *qm)
-- 
2.33.0

