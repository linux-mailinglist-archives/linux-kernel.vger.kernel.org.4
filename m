Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0369B839
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBRFjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBRFjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:39:05 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB016186C;
        Fri, 17 Feb 2023 21:38:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTmwnP9GPytewv4uy0q/pLyqKDhX6Pc6UTjBiwMeWrnRTfrcy7hBAVY1Ms0yCNo8TegOaSCko8Apk+55JWTnjPVkJpxcvSAX4bjeT4OCKq8bRy/BvuV4fa/0sqZ0kkL84gHyGHuRVZrKJxdFKT4BAb7/u2OoIJUgJMdCqhz4VcJY8UVAz0+F344RuwUQOtsd8TpLaliSaA/wxuXvf4GZftLy9LGepXSfn+j3hI5HVJ1IQVjGuB4UVYXhC4T8UB1RW2ZCnjcUJfzcl4MzRPLSn61ghl57IVIS3OMvRdEDZFXjERA2S5jtRuLHjUl9nM4/bxFpJX27fyfNkSgKzrxOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34M+MqEVnwtgnx+FsZw3ShwkroQnD+0fMUTtwz2eDiA=;
 b=FdfkRV5GpP+ScL3laiOolFd8swBG/kpvH8Al97kvnfn5nBixBN2xuBSXqHVVVI75eixQhfX8OKZRDZtOdll6f0SAPQa2ZjPPyYG9cFyOuJ5reTdUmvjcH8mixJ5gxLYEgFUmkvATmkevpuU2cX/Xb2lpQqU4LmbChV81rtSHsLWb/zeNRez/FTfYwlz3r8muRNMdRLa1EcnlSqzYFd+FrKJWjSKa5byXnCRvIWE79R4NMsRWaHsr7WOa681aJWU4aCZQ47HTij9+l+gNHWhcY9elmc/X0BJO6Np7MIPsYhv+tn5xmVyRLrZrFpylxeHG444NGu0gK/zCzGXopZ0dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34M+MqEVnwtgnx+FsZw3ShwkroQnD+0fMUTtwz2eDiA=;
 b=RaatzI1OMaDBUG3BXW0buVflbphriNGQ7zpZtNcPhOAztOZnlkKj9sm74dmBTxnFtD46OO/gBWOXgQwNl4bl0Y0K5RtPaJkKH2rT5vlFf+Dnr0c4IcmMZNzvtimamujfK93LLFGVXGXr0RasNfH2ywdzz+VeqVsOgyhNiY9k0HU=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 05:38:46 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::42) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Sat, 18 Feb 2023 05:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.18 via Frontend Transport; Sat, 18 Feb 2023 05:38:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 23:38:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 21:38:43 -0800
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 23:38:40 -0600
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: [PATCH 3/4] crypto: xilinx: Add ZynqMP RSA driver
Date:   Sat, 18 Feb 2023 11:08:08 +0530
Message-ID: <20230218053809.1780-4-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230218053809.1780-1-harsha.harsha@amd.com>
References: <20230218053809.1780-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fcbf8f-a52b-4e48-48ba-08db117266b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sw+1xYFMj3GyEjfvkQ/chwq1GCyVYZd803O5aFDpDx9uso9JvT07UzjqVtKmIE//wQBNZe7xiXSB6+iT/Hjf43cE5lVgMKhxrFwc0UD22OjlAZttLJgMLNj2ReXxsenAAgrLy3swZlJoDgRKHB3PikFZNUO+x1sA4lfWbAC4aL8iPK8/IA4LBeidAgAtBj4icU/VT/1ohyHGTgGyQjfX0R9MeXIeEbZiWPVS+bZSVdkpTrMwQhTO7pB5po7SfNB9b7CTBUmcBDf31Jyaz2w+jzCc4tzf4wk603YjJ5l+OA58S/pzOI84cdt1YrcoizdfPgfVvVgT0vid7EbS+OEtJtjQBq5a4ZsFo8S0JaqnnLDeW9N8bnER65AwiA4OPMtlJGe666zkoEEuvRxwBqPldTPpmSsFqBsxxOEg9GBHVOtpXpJO+zbv/pzBInZfyqhppODaygseDm86JRx/PXCsqaxObOkMuxIooWjcXuArrErcdq/MwoVK4lU4p3eSprX8CQ3EHTsJKllUMQUOcisFu1VSlbCrUkKwH4eUl7K9AgTIaYyJcxYibH8GMp0ax8/8vuAUB6SfFVSq6t3xJC54Mkh+hQxjOzx/PdpxKb1ccm5Emg4v3YysN/yNw9TpLIaDfUvcMVEbc68JxFgWAX/9EGD2dG7SBvknOs1CXLTeTv3SF6XtSgXgjrKm7xXQEKEcPl+zEUeezTeONi9RGhAke4HFoR/QejuEbF5WyZQGdDENQIvhG23f2i7yPAsABWM2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(8676002)(82310400005)(70206006)(70586007)(81166007)(110136005)(316002)(54906003)(356005)(2906002)(82740400003)(36756003)(44832011)(30864003)(5660300002)(8936002)(41300700001)(40480700001)(36860700001)(6666004)(1076003)(186003)(26005)(83380400001)(86362001)(426003)(336012)(47076005)(2616005)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 05:38:44.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fcbf8f-a52b-4e48-48ba-08db117266b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds RSA driver support for the ZynqMP SoC.
ZynqMP SoC has RSA engine used for encryption and decryption.
The flow is
RSA encrypt/decrypt request from Userspace ->
ZynqMP RSA driver -> Firmware driver -> RSA Hardware Engine

RSA Hardware engine supports 2048, 3072 and 4096 keysizes are supported.
So RSA operations using these key sizes are done by hardware engine.
Software fallback is being used for other key sizes.

Signed-off-by: Harsha Harsha <harsha.harsha@amd.com>
Co-developed-by: Dhaval Shah <dhaval.r.shah@amd.com>
Signed-off-by: Dhaval Shah <dhaval.r.shah@amd.com>
---
 drivers/crypto/Kconfig             |  10 +
 drivers/crypto/xilinx/Makefile     |   1 +
 drivers/crypto/xilinx/xilinx-rsa.c | 489 +++++++++++++++++++++++++++++
 3 files changed, 500 insertions(+)
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index dfb103f81a64..1ff19bfe8a13 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -695,6 +695,16 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
 	  This will create /sys/kernel/debug/rk3288_crypto/stats for displaying
 	  the number of requests per algorithm and other internal stats.
 
+config CRYPTO_DEV_XILINX_RSA
+	tristate "Support for Xilinx ZynqMP RSA hardware accelerator"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select CRYPTO_ENGINE
+	select CRYPTO_AKCIPHER
+	help
+	  Xilinx processors have RSA hardware accelerator used for signature
+	  generation and verification. This driver interfaces with RSA
+	  hardware accelerator. Select this if you want to use the ZynqMP
+	  module for RSA algorithms.
 
 config CRYPTO_DEV_ZYNQMP_AES
 	tristate "Support for Xilinx ZynqMP AES hw accelerator"
diff --git a/drivers/crypto/xilinx/Makefile b/drivers/crypto/xilinx/Makefile
index 730feff5b5f2..819d82486a5d 100644
--- a/drivers/crypto/xilinx/Makefile
+++ b/drivers/crypto/xilinx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += zynqmp-aes-gcm.o
 obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_SHA3) += zynqmp-sha.o
+obj-$(CONFIG_CRYPTO_DEV_XILINX_RSA) += xilinx-rsa.o
diff --git a/drivers/crypto/xilinx/xilinx-rsa.c b/drivers/crypto/xilinx/xilinx-rsa.c
new file mode 100644
index 000000000000..148a2a59ab89
--- /dev/null
+++ b/drivers/crypto/xilinx/xilinx-rsa.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/crypto.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <crypto/engine.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/scatterwalk.h>
+
+#define XILINX_DMA_BIT_MASK	32U
+#define XILINX_RSA_MAX_KEY_SIZE	1024
+#define XILINX_RSA_BLOCKSIZE	64
+
+/* Key size in bytes */
+#define XSECURE_RSA_2048_KEY_SIZE	(2048U / 8U)
+#define XSECURE_RSA_3072_KEY_SIZE	(3072U / 8U)
+#define XSECURE_RSA_4096_KEY_SIZE	(4096U / 8U)
+
+enum xilinx_akcipher_op {
+	XILINX_RSA_DECRYPT = 0,
+	XILINX_RSA_ENCRYPT,
+	XILINX_RSA_SIGN,
+	XILINX_RSA_VERIFY
+};
+
+struct xilinx_rsa_drv_ctx {
+	struct akcipher_alg alg;
+	struct device *dev;
+	struct crypto_engine *engine;
+	int (*xilinx_rsa_xcrypt)(struct akcipher_request *req);
+};
+
+/*
+ * 1st variable must be of struct crypto_engine_ctx type
+ */
+struct xilinx_rsa_tfm_ctx {
+	struct crypto_engine_ctx engine_ctx;
+	struct device *dev;
+	struct crypto_akcipher *fbk_cipher;
+	u8 *e_buf;
+	u8 *n_buf;
+	u8 *d_buf;
+	unsigned int key_len; /* in bits */
+	unsigned int e_len;
+	unsigned int n_len;
+	unsigned int d_len;
+};
+
+struct xilinx_rsa_req_ctx {
+	enum xilinx_akcipher_op op;
+};
+
+static int zynqmp_rsa_xcrypt(struct akcipher_request *req)
+{
+	struct xilinx_rsa_req_ctx *rq_ctx = akcipher_request_ctx(req);
+	unsigned int len, offset, diff = req->dst_len - req->src_len;
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct xilinx_rsa_tfm_ctx *tctx = akcipher_tfm_ctx(tfm);
+	dma_addr_t dma_addr;
+	char *kbuf, *buf;
+	size_t dma_size;
+	u8 padding = 0;
+	int ret;
+
+	if (rq_ctx->op == XILINX_RSA_ENCRYPT) {
+		padding = tctx->e_len % 2;
+		buf = tctx->e_buf;
+		len = tctx->e_len;
+	} else {
+		buf = tctx->d_buf;
+		len = tctx->d_len;
+	}
+
+	dma_size = req->dst_len + tctx->n_len + len + padding;
+	offset = dma_size - len;
+
+	kbuf = dma_alloc_coherent(tctx->dev, dma_size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	scatterwalk_map_and_copy(kbuf + diff, req->src, 0, req->src_len, 0);
+	memcpy(kbuf + req->dst_len, tctx->n_buf, tctx->n_len);
+
+	memcpy(kbuf + offset, buf, len);
+
+	ret = zynqmp_pm_rsa(dma_addr, tctx->n_len, rq_ctx->op);
+	if (ret < 0)
+		goto out;
+
+	sg_copy_from_buffer(req->dst, sg_nents(req->dst), kbuf, req->dst_len);
+
+out:
+	dma_free_coherent(tctx->dev, dma_size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int xilinx_rsa_decrypt(struct akcipher_request *req)
+{
+	struct xilinx_rsa_req_ctx *rctx = akcipher_request_ctx(req);
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	struct xilinx_rsa_drv_ctx *drv_ctx;
+
+	rctx->op = XILINX_RSA_DECRYPT;
+	drv_ctx = container_of(alg, struct xilinx_rsa_drv_ctx, alg);
+
+	return crypto_transfer_akcipher_request_to_engine(drv_ctx->engine, req);
+}
+
+static int xilinx_rsa_encrypt(struct akcipher_request *req)
+{
+	struct xilinx_rsa_req_ctx *rctx = akcipher_request_ctx(req);
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	struct xilinx_rsa_drv_ctx *drv_ctx;
+
+	rctx->op = XILINX_RSA_ENCRYPT;
+	drv_ctx = container_of(alg, struct xilinx_rsa_drv_ctx, alg);
+
+	return crypto_transfer_akcipher_request_to_engine(drv_ctx->engine, req);
+}
+
+static unsigned int xilinx_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct xilinx_rsa_tfm_ctx *tctx = akcipher_tfm_ctx(tfm);
+
+	return tctx->n_len;
+}
+
+static inline int xilinx_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
+					       const u8 *buf, size_t sz)
+{
+	int nskip;
+
+	for (nskip = 0; nskip < sz; nskip++)
+		if (buf[nskip])
+			break;
+
+	*kplen = sz - nskip;
+	*kpbuf = kmemdup(buf + nskip, *kplen, GFP_KERNEL);
+	if (!*kpbuf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int xilinx_check_key_length(unsigned int len)
+{
+	if (len < 8 || len > 4096)
+		return -EINVAL;
+	return 0;
+}
+
+static void xilinx_rsa_free_key_bufs(struct xilinx_rsa_tfm_ctx *ctx)
+{
+	/* Clean up old key data */
+	kfree_sensitive(ctx->e_buf);
+	ctx->e_buf = NULL;
+	ctx->e_len = 0;
+	kfree_sensitive(ctx->n_buf);
+	ctx->n_buf = NULL;
+	ctx->n_len = 0;
+	kfree_sensitive(ctx->d_buf);
+	ctx->d_buf = NULL;
+	ctx->d_len = 0;
+}
+
+static int xilinx_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
+			     unsigned int keylen, bool private)
+{
+	struct xilinx_rsa_tfm_ctx *tctx = akcipher_tfm_ctx(tfm);
+	struct rsa_key raw_key;
+	int ret;
+
+	if (private)
+		ret = rsa_parse_priv_key(&raw_key, key, keylen);
+	else
+		ret = rsa_parse_pub_key(&raw_key, key, keylen);
+	if (ret)
+		goto n_key;
+
+	ret = xilinx_copy_and_save_keypart(&tctx->n_buf, &tctx->n_len,
+					   raw_key.n, raw_key.n_sz);
+	if (ret)
+		goto key_err;
+
+	/* convert to bits */
+	tctx->key_len = tctx->n_len << 3;
+	if (xilinx_check_key_length(tctx->key_len)) {
+		ret = -EINVAL;
+		goto key_err;
+	}
+
+	ret = xilinx_copy_and_save_keypart(&tctx->e_buf, &tctx->e_len,
+					   raw_key.e, raw_key.e_sz);
+	if (ret)
+		goto key_err;
+
+	if (private) {
+		ret = xilinx_copy_and_save_keypart(&tctx->d_buf, &tctx->d_len,
+						   raw_key.d, raw_key.d_sz);
+		if (ret)
+			goto key_err;
+	}
+
+	return 0;
+
+key_err:
+	xilinx_rsa_free_key_bufs(tctx);
+n_key:
+	return ret;
+}
+
+static int xilinx_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
+				   unsigned int keylen)
+{
+	struct xilinx_rsa_tfm_ctx *tfm_ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	tfm_ctx->fbk_cipher->base.crt_flags &= ~CRYPTO_TFM_REQ_MASK;
+	tfm_ctx->fbk_cipher->base.crt_flags |= (tfm->base.crt_flags &
+						CRYPTO_TFM_REQ_MASK);
+
+	ret = crypto_akcipher_set_priv_key(tfm_ctx->fbk_cipher, key, keylen);
+	if (ret)
+		return ret;
+
+	return xilinx_rsa_setkey(tfm, key, keylen, true);
+}
+
+static int xilinx_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+				  unsigned int keylen)
+{
+	struct xilinx_rsa_tfm_ctx *tfm_ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	tfm_ctx->fbk_cipher->base.crt_flags &= ~CRYPTO_TFM_REQ_MASK;
+	tfm_ctx->fbk_cipher->base.crt_flags |= (tfm->base.crt_flags &
+						CRYPTO_TFM_REQ_MASK);
+
+	ret = crypto_akcipher_set_pub_key(tfm_ctx->fbk_cipher, key, keylen);
+	if (ret)
+		return ret;
+
+	return xilinx_rsa_setkey(tfm, key, keylen, false);
+}
+
+static int xilinx_fallback_check(struct xilinx_rsa_tfm_ctx *tfm_ctx,
+				 struct akcipher_request *areq)
+{
+	int need_fallback = 0;
+
+	if (tfm_ctx->n_len != XSECURE_RSA_2048_KEY_SIZE &&
+	    tfm_ctx->n_len != XSECURE_RSA_3072_KEY_SIZE &&
+	    tfm_ctx->n_len != XSECURE_RSA_4096_KEY_SIZE)
+		need_fallback = 1;
+
+	if (areq->src_len > areq->dst_len)
+		need_fallback = 1;
+
+	return need_fallback;
+}
+
+static int handle_rsa_req(struct crypto_engine *engine,
+			  void *req)
+{
+	struct akcipher_request *areq = container_of(req,
+						     struct akcipher_request,
+						     base);
+	struct crypto_akcipher *akcipher = crypto_akcipher_reqtfm(req);
+	struct akcipher_alg *cipher_alg = crypto_akcipher_alg(akcipher);
+	struct xilinx_rsa_tfm_ctx *tfm_ctx = akcipher_tfm_ctx(akcipher);
+	struct xilinx_rsa_req_ctx *rq_ctx = akcipher_request_ctx(areq);
+	struct akcipher_request *subreq = akcipher_request_ctx(req);
+	struct xilinx_rsa_drv_ctx *drv_ctx;
+	int need_fallback, err;
+
+	drv_ctx = container_of(cipher_alg, struct xilinx_rsa_drv_ctx, alg);
+
+	need_fallback = xilinx_fallback_check(tfm_ctx, areq);
+	if (need_fallback) {
+		akcipher_request_set_tfm(subreq, tfm_ctx->fbk_cipher);
+
+		akcipher_request_set_callback(subreq, areq->base.flags,
+					      NULL, NULL);
+		akcipher_request_set_crypt(subreq, areq->src, areq->dst,
+					   areq->src_len, areq->dst_len);
+
+		if (rq_ctx->op == XILINX_RSA_ENCRYPT)
+			err = crypto_akcipher_encrypt(subreq);
+		else if (rq_ctx->op == XILINX_RSA_DECRYPT)
+			err = crypto_akcipher_decrypt(subreq);
+	} else {
+		err = drv_ctx->xilinx_rsa_xcrypt(areq);
+	}
+
+	crypto_finalize_akcipher_request(engine, areq, err);
+
+	return 0;
+}
+
+static int xilinx_rsa_init(struct crypto_akcipher *tfm)
+{
+	struct xilinx_rsa_tfm_ctx *tfm_ctx =
+		(struct xilinx_rsa_tfm_ctx *)akcipher_tfm_ctx(tfm);
+	struct akcipher_alg *cipher_alg = crypto_akcipher_alg(tfm);
+	struct xilinx_rsa_drv_ctx *drv_ctx;
+
+	drv_ctx = container_of(cipher_alg, struct xilinx_rsa_drv_ctx, alg);
+	tfm_ctx->dev = drv_ctx->dev;
+
+	tfm_ctx->engine_ctx.op.do_one_request = handle_rsa_req;
+	tfm_ctx->engine_ctx.op.prepare_request = NULL;
+	tfm_ctx->engine_ctx.op.unprepare_request = NULL;
+	tfm_ctx->fbk_cipher = crypto_alloc_akcipher(drv_ctx->alg.base.cra_name,
+						    0,
+						    CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(tfm_ctx->fbk_cipher)) {
+		pr_err("%s() Error: failed to allocate fallback for %s\n",
+		       __func__, drv_ctx->alg.base.cra_name);
+		return PTR_ERR(tfm_ctx->fbk_cipher);
+	}
+
+	akcipher_set_reqsize(tfm, sizeof(struct xilinx_rsa_req_ctx));
+
+	return 0;
+}
+
+static void xilinx_rsa_exit(struct crypto_akcipher *tfm)
+{
+	struct xilinx_rsa_tfm_ctx *tfm_ctx =
+			(struct xilinx_rsa_tfm_ctx *)akcipher_tfm_ctx(tfm);
+
+	xilinx_rsa_free_key_bufs(tfm_ctx);
+
+	if (tfm_ctx->fbk_cipher) {
+		crypto_free_akcipher(tfm_ctx->fbk_cipher);
+		tfm_ctx->fbk_cipher = NULL;
+	}
+	memzero_explicit(tfm_ctx, sizeof(struct xilinx_rsa_tfm_ctx));
+}
+
+struct xilinx_rsa_drv_ctx zynqmp_rsa_drv_ctx = {
+	.xilinx_rsa_xcrypt = zynqmp_rsa_xcrypt,
+	.alg = {
+		.init = xilinx_rsa_init,
+		.set_pub_key = xilinx_rsa_set_pub_key,
+		.set_priv_key = xilinx_rsa_set_priv_key,
+		.max_size = xilinx_rsa_max_size,
+		.decrypt = xilinx_rsa_decrypt,
+		.encrypt = xilinx_rsa_encrypt,
+		.sign = xilinx_rsa_decrypt,
+		.verify = xilinx_rsa_encrypt,
+		.exit = xilinx_rsa_exit,
+		.base = {
+			.cra_name = "rsa",
+			.cra_driver_name = "zynqmp-rsa",
+			.cra_priority = 200,
+			.cra_flags = CRYPTO_ALG_TYPE_AKCIPHER |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY |
+				     CRYPTO_ALG_ALLOCATES_MEMORY |
+				     CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize = XILINX_RSA_BLOCKSIZE,
+			.cra_ctxsize = sizeof(struct xilinx_rsa_tfm_ctx),
+			.cra_alignmask = 15,
+			.cra_module = THIS_MODULE,
+		},
+	}
+};
+
+static struct xlnx_feature rsa_feature_map[] = {
+	{
+		.family = ZYNQMP_FAMILY_CODE,
+		.subfamily = ALL_SUB_FAMILY_CODE,
+		.feature_id = PM_SECURE_RSA,
+		.data = &zynqmp_rsa_drv_ctx,
+	},
+	{ /* sentinel */ }
+};
+
+static int xilinx_rsa_probe(struct platform_device *pdev)
+{
+	struct xilinx_rsa_drv_ctx *rsa_drv_ctx;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/* Verify the hardware is present */
+	rsa_drv_ctx = xlnx_get_crypto_dev_data(rsa_feature_map);
+	if (IS_ERR(rsa_drv_ctx)) {
+		dev_err(dev, "RSA is not supported on the platform\n");
+		return PTR_ERR(rsa_drv_ctx);
+	}
+
+	ret = dma_set_mask_and_coherent(dev,
+					DMA_BIT_MASK(XILINX_DMA_BIT_MASK));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration");
+		return ret;
+	}
+
+	rsa_drv_ctx->engine = crypto_engine_alloc_init(dev, 1);
+	if (!rsa_drv_ctx->engine) {
+		dev_err(dev, "Cannot alloc RSA engine\n");
+		return -ENOMEM;
+	}
+
+	ret = crypto_engine_start(rsa_drv_ctx->engine);
+	if (ret) {
+		dev_err(dev, "Cannot start RSA engine\n");
+		goto out;
+	}
+
+	rsa_drv_ctx->dev = dev;
+	platform_set_drvdata(pdev, rsa_drv_ctx);
+
+	ret = crypto_register_akcipher(&rsa_drv_ctx->alg);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register akcipher alg.\n");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	crypto_engine_exit(rsa_drv_ctx->engine);
+
+	return ret;
+}
+
+static int xilinx_rsa_remove(struct platform_device *pdev)
+{
+	struct xilinx_rsa_drv_ctx *rsa_drv_ctx;
+
+	rsa_drv_ctx = platform_get_drvdata(pdev);
+
+	crypto_engine_exit(rsa_drv_ctx->engine);
+
+	crypto_unregister_akcipher(&rsa_drv_ctx->alg);
+
+	return 0;
+}
+
+static struct platform_driver xilinx_rsa_driver = {
+	.probe = xilinx_rsa_probe,
+	.remove = xilinx_rsa_remove,
+	.driver = {
+		.name = "xilinx_rsa",
+	},
+};
+
+static int __init xilinx_rsa_driver_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	ret = platform_driver_register(&xilinx_rsa_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(xilinx_rsa_driver.driver.name,
+					       0, NULL, 0);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		platform_driver_unregister(&xilinx_rsa_driver);
+	}
+
+	return ret;
+}
+
+static void __exit xilinx_rsa_driver_exit(void)
+{
+	platform_driver_unregister(&xilinx_rsa_driver);
+}
+
+device_initcall(xilinx_rsa_driver_init);
+module_exit(xilinx_rsa_driver_exit);
+
+MODULE_DESCRIPTION("Xilinx RSA hw acceleration support.");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Harsha <harsha.harsha@amd.com>");
-- 
2.36.1

