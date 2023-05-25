Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C371106F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjEYQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjEYQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:07:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69FE49;
        Thu, 25 May 2023 09:07:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-534696e4e0aso1240183a12.0;
        Thu, 25 May 2023 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030833; x=1687622833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWZsHpXy1reSPbmQ+Wl/GDJfJxHbLyy2WnBiRjEBIYw=;
        b=oXxLgDgNC9j5hTNgSrZluoy9euriUEYaoIVeUe20WEsYBhUa4nzsaHe5wQZxd5bI/7
         63G2HQPd+4TmUT+qTKbJwBAsoSTflRhHIStkRbrTbN6C335O3BOadW9CnirZusNvMjnT
         XP9jvauZur198A6vQvl1UgVZTpdSnouhCNW/3i5fUTujqb8NJEQNV6GUL8V6v/pIvjbG
         XLOFsEa0auYNKH16AqAU3dBUKuGLvG0Q9OYjgqT0XeckxllvzAiGP20AibSffNTYb4qE
         vlTFaMmuQ0zJUftojOu6HnYkyUbLerrr8O5+9wAGfhDrJYHGa8BbMukW2at3OntIabaW
         x03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030833; x=1687622833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWZsHpXy1reSPbmQ+Wl/GDJfJxHbLyy2WnBiRjEBIYw=;
        b=DTKr9/qJ5rdaGJkh9CEdgbS6j46bQGEvi3lZ4wkjou+QJ1RB2MJy0D0MoJqv1+iA6r
         KMD9ONnLRKPBcIb7XJ4uVU72T8xJtpveh+mritA29iNMGkjgmpT3/OUYEYt5BTGUiLT+
         524nkM09dU+mkV5ChO3kgjwCfmzvVWnvO+2QRRHmTCarY7EHYJeaLlYY4AwLCoM+FB6s
         43BWv6a/D4rXrxaU6Y7w+sMAzHs0Yb8LqLOvPKqqCr5eVivYziaYYKRUwUauwg6YsAC/
         xSJOA/lTkC7Bmf7sREcO2Hb+k+o/s4u4576j2Sy1F1id0DEl2qvXNwHgK/lKLe0ChRKo
         B4Mw==
X-Gm-Message-State: AC+VfDw31dEVb/Rf6uuH75ZL0zKXfB5nH6fC2d81OymZDNLOV/eazykP
        59o4z2ZOlMmHKvhdZ4YGmBj1nvePGj4kL+oc7eM8Mg==
X-Google-Smtp-Source: ACHHUZ4UOYMj/p5nkrQEoctOXqUbf5xHSVoDDGseC48uqBq1GtsNJjzwxmsvimpRdESx4alxzWjiFg==
X-Received: by 2002:a17:902:db11:b0:1a6:77b8:23e0 with SMTP id m17-20020a170902db1100b001a677b823e0mr2467787plx.60.1685030832474;
        Thu, 25 May 2023 09:07:12 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.202])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902b11800b001aad4be4503sm1627132plr.2.2023.05.25.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:07:12 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
Date:   Fri, 26 May 2023 00:04:30 +0800
Message-Id: <20230525160446.43800-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525160446.43800-1-mmyangfl@gmail.com>
References: <20230525160446.43800-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon ADVCA Subsystem contains various cryptographic devices, including
symmetric key ciphers, hash functions, RSA algorithms, as well as key
ladder and OTP memory.

This patch adds symmetric key cipher driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/crypto/hisilicon/Kconfig              |    8 +
 drivers/crypto/hisilicon/Makefile             |    1 +
 drivers/crypto/hisilicon/advca/Makefile       |    1 +
 .../crypto/hisilicon/advca/hisi-advca-muc.c   | 1536 +++++++++++++++++
 4 files changed, 1546 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/advca/Makefile
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-muc.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index e8690c223584..99279a9ec6b1 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -1,5 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+config CRYPTO_DEV_HISI_ADVCA
+	tristate "Support for Hisilicon ADVCA Subsystem"
+	depends on ARCH_HISI || COMPILE_TEST
+	select CRYPTO_SKCIPHER
+	help
+	  Support for Hisilicon ADVCA (Advanced Conditional Access) Subsystem,
+	  which can be found on HiSilicon STB SoCs, such as Hi37xx.
+
 config CRYPTO_DEV_HISI_SEC
 	tristate "Support for Hisilicon SEC crypto block cipher accelerator"
 	select CRYPTO_SKCIPHER
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index fc51e0edec69..37600b94e1d9 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_HISI_ADVCA) += advca/
 obj-$(CONFIG_CRYPTO_DEV_HISI_HPRE) += hpre/
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
diff --git a/drivers/crypto/hisilicon/advca/Makefile b/drivers/crypto/hisilicon/advca/Makefile
new file mode 100644
index 000000000000..3f64b4a24e9e
--- /dev/null
+++ b/drivers/crypto/hisilicon/advca/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CRYPTO_DEV_HISI_ADVCA) += hisi-advca-muc.o
diff --git a/drivers/crypto/hisilicon/advca/hisi-advca-muc.c b/drivers/crypto/hisilicon/advca/hisi-advca-muc.c
new file mode 100644
index 000000000000..c2706fa4c818
--- /dev/null
+++ b/drivers/crypto/hisilicon/advca/hisi-advca-muc.c
@@ -0,0 +1,1536 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MutiCipher - cipher for multiple blocks (i.e. DMA)
+ *
+ * Copyright (c) 2023 David Yang
+ */
+
+#include <crypto/aes.h>
+#include <crypto/des.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
+#include <linux/string.h>
+
+/******** hardware definitions ********/
+
+#define MUC_CHAN0_DATA_OUT0	0x00  /* till 3 (0x0c) */
+#define MUC_CHANn_IV_OUT0(n)	(0x10 + 0x10 * (n))  /* till 3 (0x1c) */
+#define MUC_CHANn_KEY0(n)	(0x90 + 0x20 * (n))  /* till 7 (0xac) */
+
+#define MUC_SEC_CHAN_CFG	0x824
+#define  MUC_SEC_CHANn_BIT(n)		BIT(n)
+
+#define MUC_CHAN0_CTRL		0x1000
+#define MUC_CHAN0_IV_IN0	0x1004  /* till 3 (0x1010) */
+#define MUC_CHAN0_DATA_IN0	0x1014  /* till 3 (0x1020) */
+
+#define MUC_CHANn_IN_BUF_NUM(n)		(0x1000 + 0x80 * (n) + 0x00)  /* list size */
+#define MUC_CHANn_IN_BUF_CNT(n)		(0x1000 + 0x80 * (n) + 0x04)  /* available, write delta+ */
+#define MUC_CHANn_IN_EMPTY_CNT(n)	(0x1000 + 0x80 * (n) + 0x08)  /* used, write delta- */
+#define MUC_CHANn_INT_IN_CNT_CFG(n)	(0x1000 + 0x80 * (n) + 0x0c)
+#define MUC_CHANn_CTRL(n)		(0x1000 + 0x80 * (n) + 0x10)
+#define MUC_CHANn_SRC_LST_ADDR(n)	(0x1000 + 0x80 * (n) + 0x14)  /* list addr */
+#define MUC_CHANn_IN_AGE_TIMER(n)	(0x1000 + 0x80 * (n) + 0x18)
+#define MUC_CHANn_IN_AGE_CNT(n)		(0x1000 + 0x80 * (n) + 0x1c)
+#define MUC_CHANn_SRC_LST_PTR(n)	(0x1000 + 0x80 * (n) + 0x20)  /* list offset */
+#define MUC_CHANn_SRC_ADDR(n)		(0x1000 + 0x80 * (n) + 0x24)  /* addr + offset */
+#define MUC_CHANn_SRC_LENGTH(n)		(0x1000 + 0x80 * (n) + 0x28)  /* len - offset */
+#define MUC_CHANn_IN_LEFT(n)		(0x1000 + 0x80 * (n) + 0x2c)
+#define MUC_CHANn_IN_LEFT_WORD0(n)	(0x1000 + 0x80 * (n) + 0x30)  /* till 2 (0x38) */
+
+#define MUC_CHANn_OUT_BUF_NUM(n)	(0x1000 + 0x80 * (n) + 0x3c)
+#define MUC_CHANn_OUT_BUF_CNT(n)	(0x1000 + 0x80 * (n) + 0x40)
+#define MUC_CHANn_OUT_FULL_CNT(n)	(0x1000 + 0x80 * (n) + 0x44)
+#define MUC_CHANn_INT_OUT_CNT_CFG(n)	(0x1000 + 0x80 * (n) + 0x48)
+#define MUC_CHANn_DST_LST_ADDR(n)	(0x1000 + 0x80 * (n) + 0x4c)
+#define MUC_CHANn_OUT_AGE_TIMER(n)	(0x1000 + 0x80 * (n) + 0x50)
+#define MUC_CHANn_OUT_AGE_CNT(n)	(0x1000 + 0x80 * (n) + 0x54)
+#define MUC_CHANn_DST_LST_PTR(n)	(0x1000 + 0x80 * (n) + 0x58)
+#define MUC_CHANn_DST_ADDR(n)		(0x1000 + 0x80 * (n) + 0x5c)
+#define MUC_CHANn_DST_LENGTH(n)		(0x1000 + 0x80 * (n) + 0x60)
+#define MUC_CHANn_OUT_LEFT(n)		(0x1000 + 0x80 * (n) + 0x64)
+#define MUC_CHANn_OUT_LEFT_WORD0(n)	(0x1000 + 0x80 * (n) + 0x68)  /* till 2 (0x70) */
+
+/* for CTRL reg */
+#define MUC_DECRYPT		BIT(0)
+#define MUC_MODE		GENMASK(3, 1)  /* other: as 0 */
+#define  MUC_MODE_ECB			0
+#define  MUC_MODE_CBC			1
+#define  MUC_MODE_CFB			2
+#define  MUC_MODE_OFB			3
+#define  MUC_MODE_CTR			4  /* not for DES */
+#define MUC_ALG			GENMASK(5, 4)  /* other: as 0 */
+#define  MUC_ALG_DES			0
+#define  MUC_ALG_DES3_EDE		1
+#define  MUC_ALG_AES			2
+#define MUC_WIDTH		GENMASK(7, 6)  /* other: as 0 */
+#define  MUC_WIDTH_BLOCK		0
+#define  MUC_WIDTH_8B			1
+#define  MUC_WIDTH_1B			2
+#define MUC_CHAN0_IV_CHANGE	BIT(8)
+#define MUC_KEY			GENMASK(10, 9)  /* other: as 0 */
+#define  MUC_KEY_AES_128B		0
+#define  MUC_KEY_AES_192B		1
+#define  MUC_KEY_AES_256B		2
+#define  MUC_KEY_DES			0
+#define  MUC_KEY_DES3_EDE_3KEY		0
+#define  MUC_KEY_DES3_EDE_2KEY		3
+#define MUC_KEY_FROM_MKL	BIT(13)
+#define MUC_KEY_ID		GENMASK(16, 14)
+#define MUC_WEIGHT		GENMASK(31, 22)
+
+/* for BUF_NUM / BUF_CNT reg */
+#define MUC_MAX_BUF_NUM	GENMASK(15, 0)
+
+#define MUC_INT_STATUS			0x1400
+#define  MUC_INT_CHANn_IN_BUF(n)		BIT(n)
+#define  MUC_INT_CHAN0_DATA_DISPOSE		BIT(8)
+#define  MUC_INT_CHANn_OUT_BUF(n)		BIT(8 + n)
+#define MUC_INT_CFG			0x1404
+#define  MUC_INT_SEC_EN				BIT(30)  /* can't set w/ TEE */
+#define  MUC_INT_NSEC_EN			BIT(31)  /* useless w/o TEE */
+#define MUC_INT_RAW			0x1408
+#define MUC_RST_STATUS			0x140c
+#define  MUC_STATE_VALID			BIT(0)
+#define MUC_CHAN0_CFG			0x1410
+#define  MUC_CHAN0_START			BIT(0)
+#define  MUC_CHAN0_BUSY				BIT(1)
+#define MUC_SRC_ADDR_SMMU_BYPASS	0x1418
+#define  MUC_ADDR_SMMU_BYPASS(n)		BIT(n - 1)
+#define MUC_DST_ADDR_SMMU_BYPASS	0x141c
+
+#define MUC_CHAN_PKG1		0u  /* only register operations */
+#define MUC_CHAN_PKGn_MIN	1u  /* support DMA ring buffer */
+#define MUC_CHAN_NUM		8u
+
+#define MUC_IV_SIZE	16u
+#define MUC_BLOCK_SIZE	16u
+#define MUC_KEY_SIZE	32u
+#define MUC_BUF_SIZE	16u
+
+struct hica_muc_buf {
+	__le32 addr;
+	__le32 flags;
+#define MUC_BUF_FLAG_DUMMY		BIT(20)
+#define MUC_BUF_FLAG_SET_IV		BIT(21)
+#define MUC_BUF_FLAG_END_OF_LIST	BIT(22)
+	__le32 len;
+/* max is GENMASK(19, 0), but choose multiples of block size for safety */
+#define MUC_BUF_MAX_LEN	0xffff0u
+	__le32 iv_addr;
+} __packed;
+static_assert(sizeof(struct hica_muc_buf) == MUC_BUF_SIZE);
+
+/******** driver definitions ********/
+
+#define MUC_SHORT_CRYPT_LEN 256
+#define MUC_LIST_SIZE PAGE_SIZE
+
+struct hica_muc_key_map {
+	unsigned int alg;
+	unsigned int key;
+	unsigned int len;
+} hica_muc_key_maps[] = {
+	{      MUC_ALG_AES,      MUC_KEY_AES_256B,   AES_KEYSIZE_256 },
+	{      MUC_ALG_AES,      MUC_KEY_AES_192B,   AES_KEYSIZE_192 },
+	{      MUC_ALG_AES,      MUC_KEY_AES_128B,   AES_KEYSIZE_128 },
+	{      MUC_ALG_DES,           MUC_KEY_DES,      DES_KEY_SIZE },
+	{ MUC_ALG_DES3_EDE, MUC_KEY_DES3_EDE_3KEY, DES3_EDE_KEY_SIZE },
+	{ MUC_ALG_DES3_EDE, MUC_KEY_DES3_EDE_2KEY,  2 * DES_KEY_SIZE },
+	{ }
+};
+
+struct hica_muc_ctrl {
+	unsigned int		: 1;
+	unsigned int mode	: 3;
+	unsigned int alg	: 2;
+	unsigned int width	: 2;
+	unsigned int		: 1;
+	unsigned int key	: 2;
+};
+
+struct hica_muc_alg {
+	struct skcipher_alg alg;
+	struct hica_muc_ctrl ctrl;
+	struct hica_muc_priv *priv;
+};
+
+struct hica_muc_tmpl {
+	struct hica_muc_ctrl ctrl;
+
+	unsigned int min_keysize;
+	unsigned int max_keysize;
+	unsigned int ivsize;
+	unsigned int chunksize;
+	unsigned int blocksize;
+
+	const char *alg_name;
+	const char *mode_name;
+};
+
+struct hica_muc_chan {
+	void __iomem *base;
+	unsigned int chn;
+
+	struct device *dev;
+
+	/* NULL: idle, IS_ERR(): invalid or processing, other: busy */
+	struct skcipher_request *req;
+
+	union {
+		/* for channel 0 */
+		struct {
+			void *buf;
+			unsigned int size;
+		};
+
+		/* for channel n */
+		struct {
+			struct hica_muc_buf *src_list;
+			struct hica_muc_buf *dst_list;
+			void *iv;
+
+			dma_addr_t src_list_addr;
+			dma_addr_t dst_list_addr;
+			dma_addr_t iv_addr;
+			dma_addr_t pad_addr;
+
+			unsigned int num;
+		};
+	};
+};
+
+struct hica_muc_priv {
+	void __iomem *base;
+
+	struct device *dev;
+	struct hica_muc_alg *algs;
+	unsigned int algs_num;
+
+	struct reset_control *rst;
+	struct clk_bulk_data *clks;
+	unsigned int clks_num;
+	int irqs[2];
+
+	struct task_struct *task;
+	struct completion cond;
+
+	struct hica_muc_chan chans[MUC_CHAN_NUM];
+};
+
+struct hica_muc_tfm_ctx {
+	struct hica_muc_priv *priv;
+	struct hica_muc_ctrl ctrl;
+
+	unsigned int ivsize;
+	unsigned int chunksize;
+	unsigned int keysize;
+
+	u8 key[MUC_KEY_SIZE] __aligned(4);
+};
+
+struct hica_sg_iter {
+	struct scatterlist *sg;
+	unsigned int sg_offset;
+	unsigned int offset;
+};
+
+struct hica_muc_req_ctx {
+	struct hica_muc_tfm_ctx *tfm;
+
+	bool decrypt;
+
+	union {
+		/* for channel 0 */
+		struct {
+			unsigned int offset;
+		};
+
+		/* for channel n */
+		struct {
+			unsigned int runlen;
+			bool eof;
+
+			int src_nents;
+			int dst_nents;
+
+			struct hica_sg_iter src;
+			struct hica_sg_iter dst;
+
+		};
+	};
+};
+
+static bool extra_check;
+module_param(extra_check, bool, 0644);
+
+static unsigned int disable_num;
+static unsigned int disable[MUC_CHAN_NUM];
+module_param_array(disable, uint, &disable_num, 0);
+
+static bool hica_muc_chn_disabled(unsigned int chn)
+{
+	for (unsigned int i = 0; i < disable_num; i++)
+		if (chn == disable[i])
+			return true;
+
+	return false;
+}
+
+static bool hica_muc_req_is_short(const struct skcipher_request *req)
+{
+	return req->cryptlen <= MUC_SHORT_CRYPT_LEN;
+}
+
+static inline void hica_readl_seq(void *buf, const void __iomem *addr,
+				  unsigned int len)
+{
+	for (unsigned int i = 0; i < len; i += sizeof(u32))
+		*(u32 *) (buf + i) = readl_relaxed(addr + i);
+}
+
+static inline void hica_writel_seq(const void *buf, void __iomem *addr,
+				   unsigned int len)
+{
+	for (unsigned int i = 0; i < len; i += sizeof(u32))
+		writel_relaxed(*(const u32 *) (buf + i), addr + i);
+}
+
+static inline void hica_setl_seq(u32 value, void __iomem *addr,
+				 unsigned int len)
+{
+	for (unsigned int i = 0; i < len; i += sizeof(u32))
+		writel_relaxed(value, addr + i);
+}
+
+static inline bool hica_sg_iter_valid(struct hica_sg_iter *iter)
+{
+	return iter->sg && iter->sg_offset >= sg_dma_len(iter->sg);
+}
+
+static inline unsigned int hica_sg_iter_len(struct hica_sg_iter *iter)
+{
+	return sg_dma_len(iter->sg) - iter->sg_offset;
+}
+
+static inline dma_addr_t hica_sg_iter_dma_address(struct hica_sg_iter *iter)
+{
+	return sg_dma_address(iter->sg) + iter->sg_offset;
+}
+
+static inline bool hica_sg_iter_inc(struct hica_sg_iter *iter, unsigned int len)
+{
+	if (iter->sg) {
+		iter->sg_offset += len;
+		if (iter->sg_offset >= sg_dma_len(iter->sg)) {
+			iter->sg = sg_next(iter->sg);
+			iter->sg_offset = 0;
+		}
+	}
+	iter->offset += len;
+
+	return !!iter->sg;
+}
+
+static inline void hica_sg_iter_init(struct hica_sg_iter *iter,
+				     struct scatterlist *sg)
+{
+	iter->sg = sg;
+	iter->sg_offset = 0;
+	iter->offset = 0;
+}
+
+/*
+ * (Observed) Rules:
+ *  - buf list end with MUC_BUF_FLAG_END_OF_LIST
+ *  - request length must be multiples of chunksize
+ *  - if IV set, request length must be exactly chunksize
+ *  - (3)DES cannot correctly handle < 4-byte dst buffer at the end of request
+ */
+static unsigned int
+hica_muc_buf_append(struct hica_muc_buf *list, unsigned int ptr,
+		    struct hica_sg_iter *iter, struct hica_muc_chan *chan,
+		    struct skcipher_request *req, bool dst)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+	unsigned int pkg;
+
+	for (pkg = 0; iter->offset < r_ctx->runlen && pkg < chan->num; pkg++) {
+		struct hica_muc_buf *buf = &list[ptr];
+		unsigned int req_remain = r_ctx->runlen - iter->offset;
+		unsigned int sg_remain;
+		dma_addr_t addr;
+		unsigned int len;
+		unsigned int flags;
+
+		if (iter->offset >= req->cryptlen) {
+			/* pad for stream cipher mode (CFB/OFB...) */
+			sg_remain = 0;
+			addr = chan->pad_addr;
+			len = req_remain;
+			flags = MUC_BUF_FLAG_END_OF_LIST;
+		} else {
+			/* push one buf entry */
+			if (WARN_ON(!hica_sg_iter_valid(iter)))
+				return -EFAULT;
+
+			sg_remain = hica_sg_iter_len(iter);
+			addr = hica_sg_iter_dma_address(iter);
+			len = min3(sg_remain, req_remain, MUC_BUF_MAX_LEN);
+			flags = len == req_remain ?
+				MUC_BUF_FLAG_END_OF_LIST : 0;
+		}
+
+		/* split IV set request */
+		if (!dst && ctx->ctrl.mode != MUC_MODE_ECB &&
+		    iter->offset < ctx->chunksize &&
+		    iter->offset + len >= ctx->chunksize) {
+			len = ctx->chunksize - iter->offset;
+			flags = MUC_BUF_FLAG_SET_IV | MUC_BUF_FLAG_END_OF_LIST;
+			buf->iv_addr = cpu_to_le32(chan->iv_addr);
+		}
+
+		buf->addr = cpu_to_le32(addr);
+		buf->len = cpu_to_le32(len);
+		buf->flags = cpu_to_le32(flags);
+
+		pr_debug("%s %u: %s %4u +%4u (%4u) %x\n", __func__,
+			 chan->chn, dst ? "dst" : "src",
+			 req_remain, len, sg_remain, flags >> 20);
+
+		ptr++;
+		if (ptr >= chan->num)
+			ptr = 0;
+
+		hica_sg_iter_inc(iter, len);
+	}
+
+	return pkg;
+}
+
+/******** channel ********/
+
+static void
+hica_muc_chan_ctrl(struct hica_muc_chan *chan, struct skcipher_request *req,
+		   bool key_from_mkl)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+	void __iomem *ctrl = chan->base + (chan->chn == MUC_CHAN_PKG1 ?
+					   MUC_CHAN0_CTRL :
+					   MUC_CHANn_CTRL(chan->chn));
+	u32 val;
+
+	val = readl_relaxed(ctrl);
+
+	if (r_ctx->decrypt)
+		val |= MUC_DECRYPT;
+	else
+		val &= ~MUC_DECRYPT;
+
+	val &= ~MUC_MODE;
+	val |= (ctx->ctrl.mode << 1) & MUC_MODE;
+
+	val &= ~MUC_ALG;
+	val |= (ctx->ctrl.alg << 4) & MUC_ALG;
+
+	val &= ~MUC_WIDTH;
+	val |= (ctx->ctrl.width << 6) & MUC_WIDTH;
+
+	if (chan->chn == MUC_CHAN_PKG1 && ctx->ctrl.mode != MUC_MODE_ECB)
+		val |= MUC_CHAN0_IV_CHANGE;
+	else
+		val &= ~MUC_CHAN0_IV_CHANGE;
+
+	val &= ~MUC_KEY;
+	val |= (ctx->ctrl.key << 9) & MUC_KEY;
+
+	if (key_from_mkl)
+		val |= MUC_KEY_FROM_MKL;
+	else {
+		val &= ~MUC_KEY_FROM_MKL;
+		val &= ~MUC_KEY_ID;
+		val |= (chan->chn << 14) & MUC_KEY_ID;
+	}
+
+	writel_relaxed(val, ctrl);
+
+	pr_debug("%s %u: ctrl %x, alg %u, mod %u, key %u, len %u\n",
+		 __func__, chan->chn, val, ctx->ctrl.alg, ctx->ctrl.mode,
+		 ctx->ctrl.key, req->cryptlen);
+}
+
+static void
+hica_muc_chan_iv_get(struct hica_muc_chan *chan, struct skcipher_request *req)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+
+	if (ctx->ctrl.mode == MUC_MODE_ECB)
+		return;
+
+	hica_readl_seq(req->iv, chan->base + MUC_CHANn_IV_OUT0(chan->chn),
+		       ctx->ivsize);
+}
+
+static int
+hica_muc_chan_run_0(struct hica_muc_chan *chan, struct skcipher_request *req)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+	u32 val;
+
+	if (readl(chan->base + MUC_CHAN0_CFG) & MUC_CHAN0_BUSY)
+		return 0;
+
+	if (WARN_ON(r_ctx->offset > chan->size))
+		return -EFAULT;
+
+	/* get previous block */
+	if (r_ctx->offset)
+		hica_readl_seq(chan->buf + r_ctx->offset - ctx->chunksize,
+			       chan->base + MUC_CHAN0_DATA_OUT0,
+			       ctx->chunksize);
+
+	/* set next block */
+	if (r_ctx->offset >= req->cryptlen)
+		return -ENODATA;
+
+	if (ctx->ctrl.mode != MUC_MODE_ECB && r_ctx->offset == ctx->chunksize) {
+		val = readl_relaxed(chan->base + MUC_CHAN0_CTRL);
+		val &= ~MUC_CHAN0_IV_CHANGE;
+		writel_relaxed(val, chan->base + MUC_CHAN0_CTRL);
+	}
+
+	hica_writel_seq(chan->buf + r_ctx->offset,
+			chan->base + MUC_CHAN0_DATA_OUT0, ctx->chunksize);
+
+	/* emit request */
+	writel(MUC_CHAN0_START, chan->base + MUC_CHAN0_CFG);
+
+	r_ctx->offset += ctx->chunksize;
+	return 0;
+}
+
+static void _hica_muc_chan_unprepare_0(struct hica_muc_chan *chan,
+				       struct skcipher_request *req, int ret)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+
+	/* output */
+	if (!ret) {
+		hica_muc_chan_iv_get(chan, req);
+		scatterwalk_map_and_copy(chan->buf, req->dst, 0, req->cryptlen,
+					 1);
+	}
+
+	/* erase */
+	hica_setl_seq(0, chan->base + MUC_CHAN0_DATA_IN0, ctx->chunksize);
+	if (ctx->ctrl.mode != MUC_MODE_ECB)
+		hica_setl_seq(0, chan->base + MUC_CHAN0_IV_IN0, ctx->ivsize);
+	memzero_explicit(chan->buf, req->cryptlen);
+}
+
+static int _hica_muc_chan_prepare_0(struct hica_muc_chan *chan,
+				    struct skcipher_request *req)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+
+	if (WARN_ON(req->cryptlen > chan->size))
+		return -EINVAL;
+
+	if (ctx->ctrl.mode != MUC_MODE_ECB)
+		hica_writel_seq(req->iv, chan->base + MUC_CHAN0_IV_IN0,
+				ctx->ivsize);
+
+	r_ctx->offset = 0;
+	scatterwalk_map_and_copy(chan->buf, req->src, 0, req->cryptlen, 0);
+
+	return 0;
+}
+
+static void
+hica_muc_chan_report_n(struct hica_muc_chan *chan, bool unprepare)
+{
+	const char *dir = unprepare ? "unprepare" : "  prepare";
+
+	pr_debug("channel %u: %s, ctrl %x\n", chan->chn, dir,
+		 readl_relaxed(chan->base + MUC_CHANn_CTRL(chan->chn)));
+	pr_debug("channel %u: %s, src, left %u, list (%u) %u<- %3u ->%u\n",
+		 chan->chn, dir,
+		 readw_relaxed(chan->base + MUC_CHANn_IN_LEFT(chan->chn)) >> 24,
+		 readw_relaxed(chan->base + MUC_CHANn_IN_BUF_NUM(chan->chn)),
+		 readw_relaxed(chan->base + MUC_CHANn_IN_EMPTY_CNT(chan->chn)),
+		 readw_relaxed(chan->base + MUC_CHANn_SRC_LST_PTR(chan->chn)),
+		 readw_relaxed(chan->base + MUC_CHANn_IN_BUF_CNT(chan->chn)));
+	pr_debug("channel %u: %s, dst, left %u, list (%u) %u<- %3u ->%u\n",
+		 chan->chn, dir,
+		 readw_relaxed(chan->base +
+			       MUC_CHANn_OUT_LEFT(chan->chn)) >> 24,
+		 readw_relaxed(chan->base + MUC_CHANn_OUT_BUF_NUM(chan->chn)),
+		 readw_relaxed(chan->base + MUC_CHANn_OUT_FULL_CNT(chan->chn)),
+		 readw_relaxed(chan->base + MUC_CHANn_DST_LST_PTR(chan->chn)),
+		 readw_relaxed(chan->base + MUC_CHANn_OUT_BUF_CNT(chan->chn)));
+}
+
+static int
+hica_muc_chan_run_n(struct hica_muc_chan *chan, struct skcipher_request *req)
+{
+	struct device *dev = chan->dev;
+	unsigned int size = 2 * sizeof(chan->src_list[0]) * chan->num;
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+
+	bool src_eof = r_ctx->src.offset >= r_ctx->runlen;
+	unsigned int src_pkg = readl_relaxed(chan->base +
+					     MUC_CHANn_IN_BUF_CNT(chan->chn));
+	bool src_todo;
+	unsigned int src_ptr;
+
+	bool dst_eof = r_ctx->dst.offset >= r_ctx->runlen;
+	unsigned int dst_pkg = readl_relaxed(chan->base +
+					     MUC_CHANn_OUT_BUF_CNT(chan->chn));
+	bool dst_todo;
+	unsigned int dst_ptr;
+
+	void __iomem *reg;
+	u32 val;
+
+	if (!src_pkg && !dst_pkg && r_ctx->eof) {
+		pr_debug("%s %u: all set\n", __func__, chan->chn);
+		return -ENODATA;
+	}
+
+	pr_debug("%s %u: src has %u, dst has %u\n", __func__, chan->chn,
+		 src_pkg, dst_pkg);
+	if ((src_pkg && dst_pkg) || r_ctx->eof)
+		return 0;
+
+	barrier();
+
+	if (src_eof && dst_eof && !src_pkg) {
+		/*
+		 * Handle the very annoying EOF quirk, in which:
+		 *  - All src buffers are proccessed, but;
+		 *  - The last dst buffer cannot be proccessed.
+		 *
+		 * Though all observed quirks are only happened under (3)DES and
+		 * buf len < 4, the following fixup routine does not rely on
+		 * this hypothesis.
+		 */
+		pr_debug("%s %u: reach EOF\n", __func__, chan->chn);
+		r_ctx->eof = true;
+
+		/* first, get IV out */
+		hica_muc_chan_iv_get(chan, req);
+
+		/*
+		 * if no dst buffer left, no stuck happened (and we are
+		 * finished)
+		 */
+		if (!dst_pkg)
+			return -ENODATA;
+
+		/* check OUT_LEFT_LEN to see if it's really stucked */
+		if (!(readl_relaxed(chan->base +
+				    MUC_CHANn_OUT_LEFT(chan->chn)) >> 24))
+			/* nothing; maybe it's still proccessing */
+			return 0;
+
+		/* stucked; issue one more request to drive the hardware */
+		src_todo = true;
+		dst_todo = true;
+	} else {
+		if (!src_pkg && src_eof)
+			pr_debug("%s %u: src done\n", __func__, chan->chn);
+		if (!dst_pkg && dst_eof)
+			pr_debug("%s %u: dst done\n", __func__, chan->chn);
+
+		src_todo = !src_pkg && !src_eof;
+		dst_todo = !dst_pkg && !dst_eof;
+	}
+
+	/* read ring buffer status */
+	if (src_todo) {
+		reg = chan->base + MUC_CHANn_IN_EMPTY_CNT(chan->chn);
+		val = readw_relaxed(reg);
+		if (val)
+			writew_relaxed(val, reg);
+
+		if (extra_check) {
+			reg = chan->base + MUC_CHANn_SRC_LST_ADDR(chan->chn);
+			val = readl_relaxed(reg);
+			if (WARN_ON(val != chan->src_list_addr))
+				writel_relaxed(chan->src_list_addr, reg);
+
+			reg = chan->base + MUC_CHANn_IN_BUF_NUM(chan->chn);
+			val = readw_relaxed(reg);
+			if (WARN_ON(val != chan->num))
+				writew_relaxed(chan->num, reg);
+		}
+
+		src_ptr = readw_relaxed(chan->base +
+					MUC_CHANn_SRC_LST_PTR(chan->chn));
+		if (WARN_ON(src_ptr >= chan->num))
+			return -EIO;
+	}
+
+	if (dst_todo) {
+		reg = chan->base + MUC_CHANn_OUT_FULL_CNT(chan->chn);
+		val = readw_relaxed(reg);
+		if (val)
+			writew_relaxed(val, reg);
+
+		if (extra_check) {
+			reg = chan->base + MUC_CHANn_DST_LST_ADDR(chan->chn);
+			val = readl_relaxed(reg);
+			if (WARN_ON(val != chan->dst_list_addr))
+				writel_relaxed(chan->dst_list_addr, reg);
+
+			reg = chan->base + MUC_CHANn_OUT_BUF_NUM(chan->chn);
+			val = readw_relaxed(reg);
+			if (WARN_ON(val != chan->num))
+				writew_relaxed(chan->num, reg);
+		}
+
+		dst_ptr = readw_relaxed(chan->base +
+					MUC_CHANn_DST_LST_PTR(chan->chn));
+		if (WARN_ON(dst_ptr >= chan->num))
+			return -EIO;
+	}
+
+	/* set buffers */
+	dma_sync_single_for_cpu(dev, chan->src_list_addr, size, DMA_TO_DEVICE);
+	if (!r_ctx->eof) {
+		if (!src_todo)
+			src_pkg = 0;
+		else
+			src_pkg = hica_muc_buf_append(chan->src_list, src_ptr,
+						      &r_ctx->src, chan, req,
+						      false);
+		if (!dst_todo)
+			dst_pkg = 0;
+		else
+			dst_pkg = hica_muc_buf_append(chan->dst_list, dst_ptr,
+						      &r_ctx->dst, chan, req,
+						      true);
+	} else {
+		struct hica_muc_buf *buf;
+
+		buf = &chan->src_list[src_ptr];
+		buf->addr = cpu_to_le32(chan->pad_addr);
+		buf->len = cpu_to_le32(MUC_BLOCK_SIZE);
+		buf->flags = cpu_to_le32(MUC_BUF_FLAG_END_OF_LIST);
+		src_pkg = 1;
+
+		dst_ptr += dst_pkg;
+		if (dst_ptr >= chan->num)
+			dst_ptr -= chan->num;
+		buf = &chan->dst_list[dst_ptr];
+		buf->addr = cpu_to_le32(chan->pad_addr);
+		buf->len = cpu_to_le32(MUC_BLOCK_SIZE);
+		buf->flags = cpu_to_le32(MUC_BUF_FLAG_END_OF_LIST);
+		dst_pkg = 1;
+	}
+	dma_sync_single_for_device(dev, chan->src_list_addr, size,
+				   DMA_TO_DEVICE);
+
+	/* emit request */
+	if (dst_todo) {
+		writew(dst_pkg, chan->base +
+				MUC_CHANn_INT_OUT_CNT_CFG(chan->chn));
+		writew(dst_pkg, chan->base + MUC_CHANn_OUT_BUF_CNT(chan->chn));
+	}
+	if (src_todo) {
+		writew(src_pkg, chan->base +
+				MUC_CHANn_INT_IN_CNT_CFG(chan->chn));
+		writew(src_pkg, chan->base + MUC_CHANn_IN_BUF_CNT(chan->chn));
+	}
+
+	if (!r_ctx->eof)
+		pr_debug("%s %u: put src %u, dst %u\n", __func__, chan->chn,
+			 src_pkg, dst_pkg);
+	else
+		pr_debug("%s %u: dealing with stuck\n", __func__, chan->chn);
+	return 0;
+}
+
+static void _hica_muc_chan_unprepare_n(struct hica_muc_chan *chan,
+				       struct skcipher_request *req, int ret)
+{
+	struct device *dev = chan->dev;
+	bool bidirectional = req->src == req->dst;
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+
+	hica_muc_chan_report_n(chan, true);
+
+	/* output */
+	if (!ret)
+		dma_sync_sg_for_cpu(dev, req->dst, r_ctx->dst_nents,
+				    DMA_FROM_DEVICE);
+
+	dma_unmap_sg(dev, req->src, r_ctx->src_nents,
+		     bidirectional ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE);
+	if (!bidirectional)
+		dma_unmap_sg(dev, req->dst, r_ctx->dst_nents, DMA_FROM_DEVICE);
+
+	/* erase */
+	if (ctx->ctrl.mode != MUC_MODE_ECB)
+		memzero_explicit(chan->iv, MUC_IV_SIZE);
+}
+
+static int _hica_muc_chan_prepare_n(struct hica_muc_chan *chan,
+				    struct skcipher_request *req)
+{
+	struct device *dev = chan->dev;
+	bool bidirectional = req->src == req->dst;
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+	int src_nents;
+	int dst_nents;
+	u32 val;
+
+	src_nents = sg_nents_for_len(req->src, req->cryptlen);
+	if (src_nents < 0)
+		return src_nents;
+	if (!bidirectional) {
+		dst_nents = sg_nents_for_len(req->dst, req->cryptlen);
+		if (dst_nents < 0)
+			return dst_nents;
+	}
+
+	src_nents = dma_map_sg(dev, req->src, src_nents,
+			       bidirectional ? DMA_BIDIRECTIONAL :
+					       DMA_TO_DEVICE);
+	if (src_nents <= 0) {
+		dev_err(dev, "error mapping src\n");
+		return -EIO;
+	}
+	if (bidirectional)
+		dst_nents = src_nents;
+	else {
+		dst_nents = dma_map_sg(dev, req->dst, dst_nents,
+				       DMA_FROM_DEVICE);
+		if (dst_nents <= 0) {
+			dev_err(dev, "error mapping dst\n");
+			dma_unmap_sg(dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return -EIO;
+		}
+	}
+
+	r_ctx->src_nents = src_nents;
+	r_ctx->dst_nents = dst_nents;
+
+	/* pad request length to multiples of chunksize */
+	r_ctx->runlen = ALIGN(req->cryptlen, ctx->chunksize);
+
+	r_ctx->eof = false;
+	hica_sg_iter_init(&r_ctx->src, req->src);
+	hica_sg_iter_init(&r_ctx->dst, req->dst);
+
+	hica_muc_chan_report_n(chan, false);
+
+	/* setup ring buffers */
+	writel_relaxed(chan->src_list_addr,
+		       chan->base + MUC_CHANn_SRC_LST_ADDR(chan->chn));
+	writew_relaxed(chan->num, chan->base + MUC_CHANn_IN_BUF_NUM(chan->chn));
+	writew_relaxed(0, chan->base + MUC_CHANn_IN_AGE_CNT(chan->chn));
+
+	writel_relaxed(chan->dst_list_addr,
+		       chan->base + MUC_CHANn_DST_LST_ADDR(chan->chn));
+	writew_relaxed(chan->num,
+		       chan->base + MUC_CHANn_OUT_BUF_NUM(chan->chn));
+	writew_relaxed(0, chan->base + MUC_CHANn_OUT_AGE_CNT(chan->chn));
+
+	/* erase in case of not being 0 */
+	writel_relaxed(0, chan->base + MUC_CHANn_IN_LEFT(chan->chn));
+	val = readw_relaxed(chan->base + MUC_CHANn_OUT_BUF_CNT(chan->chn));
+	if (val)
+		writew_relaxed(0x10000 - val,
+			       chan->base + MUC_CHANn_OUT_BUF_CNT(chan->chn));
+
+	/* setup data */
+	if (ctx->ctrl.mode != MUC_MODE_ECB) {
+		memcpy(chan->iv, req->iv, MUC_IV_SIZE);
+		dma_sync_single_for_device(dev, chan->iv_addr, MUC_IV_SIZE,
+					   DMA_TO_DEVICE);
+	}
+	dma_sync_sg_for_device(dev, req->src, r_ctx->src_nents, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+/* must not emit any interrupt if error occurs */
+static int
+hica_muc_chan_run(struct hica_muc_chan *chan, struct skcipher_request *req)
+{
+	return chan->chn == MUC_CHAN_PKG1 ? hica_muc_chan_run_0(chan, req) :
+					    hica_muc_chan_run_n(chan, req);
+}
+
+static int
+hica_muc_chan_unprepare(struct hica_muc_chan *chan,
+			struct skcipher_request *req, int ret)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+
+	if (ctx->keysize)
+		hica_setl_seq(0, chan->base + MUC_CHANn_KEY0(chan->chn),
+			      ctx->keysize);
+
+	if (chan->chn == MUC_CHAN_PKG1)
+		_hica_muc_chan_unprepare_0(chan, req, ret);
+	else
+		_hica_muc_chan_unprepare_n(chan, req, ret);
+
+	if (ctx->ctrl.mode != MUC_MODE_ECB)
+		hica_setl_seq(0, chan->base + MUC_CHANn_IV_OUT0(chan->chn),
+			      ctx->ivsize);
+
+	return ret;
+}
+
+/* return 0 if stopped, -EBUSY if not finished, otherwise error */
+static int hica_muc_chan_run_or_unprepare(struct hica_muc_chan *chan,
+					  struct skcipher_request *req)
+{
+	int ret = hica_muc_chan_run(chan, req);
+
+	if (!ret)
+		/* fed */
+		return -EBUSY;
+
+	return hica_muc_chan_unprepare(chan, req, ret == -ENODATA ? 0 : ret);
+}
+
+static int hica_muc_chan_prepare(struct hica_muc_chan *chan,
+				 struct skcipher_request *req)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct hica_muc_tfm_ctx *ctx = r_ctx->tfm;
+	int ret;
+
+	ret = chan->chn == MUC_CHAN_PKG1 ? _hica_muc_chan_prepare_0(chan, req) :
+					   _hica_muc_chan_prepare_n(chan, req);
+	if (ret)
+		return ret;
+
+	hica_muc_chan_ctrl(chan, req, !ctx->keysize);
+	if (ctx->keysize)
+		hica_writel_seq(ctx->key,
+				chan->base + MUC_CHANn_KEY0(chan->chn),
+				ctx->keysize);
+
+	return 0;
+}
+
+static int
+hica_muc_chan_init(struct hica_muc_chan *chan, struct hica_muc_priv *priv,
+		   unsigned int chn)
+{
+	void __iomem *base = priv->base;
+	struct device *dev = priv->dev;
+	unsigned int src_ptr;
+	unsigned int dst_ptr;
+
+	chan->base = base;
+	chan->chn = chn;
+	chan->dev = dev;
+	chan->req = NULL;
+
+	if (chn == MUC_CHAN_PKG1) {
+		chan->size = MUC_SHORT_CRYPT_LEN;
+
+		chan->buf = devm_kmalloc(dev, chan->size, GFP_KERNEL);
+		if (!chan->buf)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	chan->num = min(MUC_LIST_SIZE / 2 / sizeof(chan->src_list[0]),
+			MUC_MAX_BUF_NUM);
+
+	src_ptr = readw_relaxed(base + MUC_CHANn_SRC_LST_PTR(chn));
+	dst_ptr = readw_relaxed(base + MUC_CHANn_DST_LST_PTR(chn));
+	if (src_ptr >= chan->num || dst_ptr >= chan->num) {
+		dev_err(dev,
+			"cannot setup channel %u, src ptr %u, dst ptr %u\n",
+			chn, src_ptr, dst_ptr);
+		dev_err(dev, "why device didn't reset?\n");
+		return -EINVAL;
+	}
+
+	chan->src_list = dmam_alloc_attrs(dev, MUC_LIST_SIZE,
+					  &chan->src_list_addr,
+					  GFP_KERNEL | __GFP_ZERO, 0);
+	if (!chan->src_list)
+		return -ENOMEM;
+	chan->iv = dmam_alloc_attrs(dev, MUC_IV_SIZE + MUC_BLOCK_SIZE,
+				    &chan->iv_addr, GFP_KERNEL, 0);
+	if (!chan->iv)
+		return -ENOMEM;
+
+	chan->dst_list = (void *) chan->src_list + MUC_LIST_SIZE / 2;
+	chan->dst_list_addr = chan->src_list_addr + MUC_LIST_SIZE / 2;
+	chan->pad_addr = chan->iv_addr + MUC_IV_SIZE;
+
+	return 0;
+}
+
+/******** irq ********/
+
+static unsigned int hica_muc_process(struct hica_muc_priv *priv)
+{
+	unsigned int mask = 0;
+
+	for (unsigned int chn = 0; chn < MUC_CHAN_NUM; chn++) {
+		struct hica_muc_chan *chan = &priv->chans[chn];
+		struct skcipher_request *req = chan->req;
+
+		if (IS_ERR_OR_NULL(req))
+			continue;
+
+		req = xchg(&chan->req, ERR_PTR(-EBUSY));
+		if (req == ERR_PTR(-EBUSY))
+			continue;
+
+		if (!IS_ERR_OR_NULL(req)) {
+			int ret = hica_muc_chan_run_or_unprepare(chan, req);
+
+			pr_debug("%s %u: returned %d\n", __func__, chn, ret);
+			mask |= BIT(chn);
+
+			if (ret != -EBUSY) {
+				if (ret)
+					dev_err(priv->dev,
+						"channel %u got unexpected ret %d\n",
+						chn, ret);
+				skcipher_request_complete(req, ret);
+				req = NULL;
+			}
+		}
+
+		WRITE_ONCE(chan->req, req);
+	}
+
+	return mask;
+}
+
+static int hica_muc_thread(void *data)
+{
+	struct hica_muc_priv *priv = data;
+
+	while (1) {
+		bool timeout;
+		unsigned int mask;
+
+		timeout = wait_for_completion_interruptible_timeout(&priv->cond,
+						msecs_to_jiffies(3000)) <= 0;
+		if (kthread_should_stop())
+			break;
+		reinit_completion(&priv->cond);
+
+		mask = hica_muc_process(priv);
+		if (mask && timeout)
+			dev_info(priv->dev, "interrupt gone, channels %x\n",
+				 mask);
+	}
+
+	return 0;
+}
+
+static irqreturn_t hica_muc_handle(int irq, void *dev_id)
+{
+	struct hica_muc_priv *priv = dev_id;
+	u32 val;
+
+	/* clear interrupts */
+	val = readl_relaxed(priv->base + MUC_INT_STATUS);
+	if (!val)
+		return IRQ_NONE;
+	writel_relaxed(val, priv->base + MUC_INT_RAW);
+
+	/* feed channel 0 quickly */
+	if (val == MUC_INT_CHAN0_DATA_DISPOSE) {
+		struct hica_muc_chan *chan = &priv->chans[MUC_CHAN_PKG1];
+		struct skcipher_request *req;
+		int ret = 0;
+
+		req = xchg(&chan->req, ERR_PTR(-EBUSY));
+		if (req == ERR_PTR(-EBUSY))
+			return IRQ_HANDLED;
+
+		if (!IS_ERR_OR_NULL(req))
+			ret = hica_muc_chan_run_0(chan, req);
+
+		/* be ready for next interrupt */
+		smp_store_mb(chan->req, req);
+
+		if (!ret)
+			/* fed */
+			return IRQ_HANDLED;
+	}
+
+	/* go cleaning */
+	complete(&priv->cond);
+	return IRQ_HANDLED;
+}
+
+/******** skcipher_alg ********/
+
+static int des_check_weakkey_half(const u8 *key)
+{
+	for (int i = 1; i < DES_KEY_SIZE / 2; i++)
+		if ((key[i] ^ key[0]) >> 1)
+			return 0;
+	return -EINVAL;
+}
+
+static int des_check_weakkey(const u8 *key)
+{
+	return des_check_weakkey_half(key) ?:
+	       des_check_weakkey_half(key + DES_KEY_SIZE / 2);
+}
+
+static unsigned int hica_muc_key_encode(unsigned int alg, unsigned int len)
+{
+	for (int i = 0; hica_muc_key_maps[i].len; i++)
+		if (hica_muc_key_maps[i].alg == alg &&
+		    hica_muc_key_maps[i].len == len)
+				return hica_muc_key_maps[i].key;
+
+	return 0;
+}
+
+static int hica_muc_alg_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			       unsigned int keylen)
+{
+	struct hica_muc_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	if (keylen > MUC_KEY_SIZE)
+		return -EINVAL;
+
+	switch (ctx->ctrl.alg) {
+	case MUC_ALG_AES:
+		if (aes_check_keylen(keylen))
+			return -EINVAL;
+		break;
+	case MUC_ALG_DES:
+		if (keylen != DES_KEY_SIZE)
+			return -EINVAL;
+		if (des_check_weakkey(key))
+			return -EINVAL;
+		break;
+	case MUC_ALG_DES3_EDE:
+		if (keylen != DES3_EDE_KEY_SIZE)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ctx->ctrl.key = hica_muc_key_encode(ctx->ctrl.alg, keylen);
+	memcpy(ctx->key, key, keylen);
+	ctx->keysize = keylen;
+
+	return 0;
+}
+
+static int hica_muc_alg_encdec(struct skcipher_request *req, bool decrypt)
+{
+	struct hica_muc_req_ctx *r_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct hica_muc_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct hica_muc_priv *priv = ctx->priv;
+	struct hica_muc_chan *chan;
+	int ret;
+
+	/* get an idle channel */
+	for (unsigned int chn = hica_muc_req_is_short(req) ? MUC_CHAN_PKG1 :
+							     MUC_CHAN_PKGn_MIN;
+	     chn < MUC_CHAN_NUM; chn++) {
+		struct skcipher_request *old = NULL;
+
+		chan = &priv->chans[chn];
+		if (try_cmpxchg_acquire(&chan->req, &old, ERR_PTR(-EBUSY)))
+			goto next;
+	}
+	return -EBUSY;
+
+next:
+	r_ctx->tfm = ctx;
+	r_ctx->decrypt = decrypt;
+
+	ret = hica_muc_chan_prepare(chan, req);
+	if (ret) {
+		WRITE_ONCE(chan->req, NULL);
+		pr_debug("%s %u: returned %d\n", __func__, chan->chn, ret);
+		return ret;
+	}
+
+	/* save req and wake up task thread */
+	smp_store_mb(chan->req, req);
+	complete(&priv->cond);
+	pr_debug("%s %u: started\n", __func__, chan->chn);
+	return -EINPROGRESS;
+}
+
+static int hica_muc_alg_encrypt(struct skcipher_request *req)
+{
+	return hica_muc_alg_encdec(req, false);
+}
+
+static int hica_muc_alg_decrypt(struct skcipher_request *req)
+{
+	return hica_muc_alg_encdec(req, true);
+}
+
+static int hica_muc_alg_init(struct crypto_skcipher *tfm)
+{
+	struct hica_muc_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct hica_muc_alg *p_alg = container_of(alg, typeof(*p_alg), alg);
+
+	/* avoid pointer chain */
+	ctx->ivsize = crypto_skcipher_alg_ivsize(alg);
+	ctx->chunksize = crypto_skcipher_alg_chunksize(alg);
+	if (ctx->ivsize > MUC_IV_SIZE || ctx->chunksize > MUC_BLOCK_SIZE)
+		return -EINVAL;
+
+	ctx->priv = p_alg->priv;
+	ctx->ctrl = p_alg->ctrl;
+	ctx->keysize = 0;
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct hica_muc_req_ctx));
+	return 0;
+}
+
+static int hica_muc_alg_register(struct hica_muc_alg *p_alg,
+				 const struct hica_muc_tmpl *tmpl,
+				 struct hica_muc_priv *priv)
+{
+	struct crypto_alg *base = &p_alg->alg.base;
+
+	*p_alg = (typeof(*p_alg)) {
+		.alg = {
+			.setkey = hica_muc_alg_setkey,
+			.encrypt = hica_muc_alg_encrypt,
+			.decrypt = hica_muc_alg_decrypt,
+			.init = hica_muc_alg_init,
+
+			.min_keysize = tmpl->min_keysize,
+			.max_keysize = tmpl->max_keysize,
+			.ivsize = tmpl->ivsize,
+			.chunksize = tmpl->chunksize,
+
+			.base = {
+				.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+					     CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY |
+					     CRYPTO_ALG_OPTIONAL_KEY,
+				.cra_blocksize = tmpl->blocksize,
+				.cra_ctxsize = sizeof(struct hica_muc_tfm_ctx),
+				.cra_alignmask = 0,
+
+				.cra_priority = 400,
+				.cra_module = THIS_MODULE,
+			},
+		},
+		.ctrl = tmpl->ctrl,
+		.priv = priv,
+	};
+
+	snprintf(base->cra_name, sizeof(base->cra_name), "%s(%s)",
+		 tmpl->mode_name, tmpl->alg_name);
+	snprintf(base->cra_driver_name, sizeof(base->cra_driver_name),
+		 "hisi-advca-%s-%s", tmpl->mode_name, tmpl->alg_name);
+
+	return crypto_register_skcipher(&p_alg->alg);
+}
+
+#define hica_muc_tmpl_define(_ALG, _MODE, _alg, _mode, minkey, maxkey) { \
+	.ctrl = { \
+		.alg = MUC_ALG_##_ALG, \
+		.mode = MUC_MODE_##_MODE, \
+		.width = MUC_WIDTH_BLOCK, \
+	}, \
+\
+	.min_keysize = minkey, \
+	.max_keysize = maxkey, \
+	.ivsize = _ALG##_BLOCK_SIZE, \
+	.chunksize = _ALG##_BLOCK_SIZE, \
+	.blocksize = _ALG##_BLOCK_SIZE, \
+\
+	.alg_name = #_alg, \
+	.mode_name = #_mode, \
+}
+
+#define hica_muc_tmpl_define_aes(_MODE, _mode) \
+	hica_muc_tmpl_define(AES, _MODE, aes, _mode, AES_MIN_KEY_SIZE, \
+			     AES_MAX_KEY_SIZE)
+#define hica_muc_tmpl_define_des(_MODE, _mode) \
+	hica_muc_tmpl_define(DES, _MODE, des, _mode, DES_KEY_SIZE, DES_KEY_SIZE)
+#define hica_muc_tmpl_define_des3_ede(_MODE, _mode) \
+	hica_muc_tmpl_define(DES3_EDE, _MODE, des3_ede, _mode, \
+			     DES3_EDE_KEY_SIZE, DES3_EDE_KEY_SIZE)
+
+static const struct hica_muc_tmpl hica_muc_tmpls[] = {
+	hica_muc_tmpl_define_aes(ECB, ecb),
+	hica_muc_tmpl_define_aes(CBC, cbc),
+	hica_muc_tmpl_define_aes(CFB, cfb),
+	hica_muc_tmpl_define_aes(OFB, ofb),
+	hica_muc_tmpl_define_aes(CTR, ctr),
+
+	hica_muc_tmpl_define_des(ECB, ecb),
+	hica_muc_tmpl_define_des(CBC, cbc),
+	hica_muc_tmpl_define_des(CFB, cfb),
+	hica_muc_tmpl_define_des(OFB, ofb),
+	/* does not support ctr-des, hardware will recognize as ecb-des */
+
+	hica_muc_tmpl_define_des3_ede(ECB, ecb),
+	hica_muc_tmpl_define_des3_ede(CBC, cbc),
+	hica_muc_tmpl_define_des3_ede(CFB, cfb),
+	hica_muc_tmpl_define_des3_ede(OFB, ofb),
+	/* does not support ctr-des3_ede, hardware will recognize as ecb-des3_ede */
+};
+
+/******** device ********/
+
+static void hica_muc_remove(struct platform_device *pdev)
+{
+	struct hica_muc_priv *priv = platform_get_drvdata(pdev);
+
+	for (int i = priv->algs_num; i > 0; ) {
+		i--;
+		crypto_unregister_skcipher(&priv->algs[i].alg);
+	}
+
+	kthread_stop(priv->task);
+
+	clk_bulk_disable_unprepare(priv->clks_num, priv->clks);
+	reset_control_assert(priv->rst);
+}
+
+static int hica_muc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hica_muc_priv *priv;
+	char status[MUC_CHAN_NUM + 1] = {};
+	unsigned int chn_mask = 0;
+	u32 val;
+	int ret;
+
+	/* acquire resources */
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_clk_bulk_get_all(dev, &priv->clks);
+	if (ret < 0)
+		return ret;
+	priv->clks_num = ret;
+
+	priv->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	priv->irqs[0] = ret;
+	priv->irqs[1] = platform_get_irq_optional(pdev, 1);
+
+	priv->algs_num = ARRAY_SIZE(hica_muc_tmpls);
+	priv->algs = devm_kmalloc_array(dev, priv->algs_num,
+					sizeof(priv->algs[0]), GFP_KERNEL);
+	if (!priv->algs)
+		return -ENOMEM;
+
+	init_completion(&priv->cond);
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+	dev_set_drvdata(dev, priv);
+
+	/* bring up device */
+	ret = reset_control_assert(priv->rst);
+	if (ret)
+		return ret;
+	ret = clk_bulk_prepare_enable(priv->clks_num, priv->clks);
+	if (ret)
+		goto err_rst;
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		goto err_clk;
+
+	if (!(readl(priv->base + MUC_RST_STATUS) & MUC_STATE_VALID)) {
+		msleep(20);
+		if (!(readl(priv->base + MUC_RST_STATUS) & MUC_STATE_VALID)) {
+			dev_err(dev, "cannot bring up device\n");
+			ret = -ENODEV;
+			goto err_clk;
+		}
+	}
+
+	/* clear all interrupts */
+	writel_relaxed(~0, priv->base + MUC_INT_RAW);
+
+	/* must set this before enabling interrupts */
+	val = readl_relaxed(priv->base + MUC_SEC_CHAN_CFG);
+	for (unsigned int chn = 0; chn < MUC_CHAN_NUM; chn++)
+		val |= MUC_SEC_CHANn_BIT(chn);
+	writel(val, priv->base + MUC_SEC_CHAN_CFG);
+
+	/* enable interrupts */
+	val = readl_relaxed(priv->base + MUC_INT_CFG);
+	for (unsigned int chn = MUC_CHAN_PKGn_MIN; chn < MUC_CHAN_NUM; chn++) {
+		val |= MUC_INT_CHANn_IN_BUF(chn);
+		val |= MUC_INT_CHANn_OUT_BUF(chn);
+	}
+	val |= MUC_INT_CHAN0_DATA_DISPOSE;
+	val |= MUC_INT_SEC_EN;
+	val |= MUC_INT_NSEC_EN;
+	writel(val, priv->base + MUC_INT_CFG);
+
+	/* test channels */
+	val = readl_relaxed(priv->base + MUC_INT_CFG);
+	for (unsigned int chn = 0; chn < MUC_CHAN_NUM; chn++) {
+		bool ok = val & MUC_INT_CHANn_OUT_BUF(chn);
+		bool enabled = !hica_muc_chn_disabled(chn);
+
+		if (ok && enabled) {
+			status[chn] = 'y';
+			chn_mask |= BIT(chn);
+		} else
+			status[chn] = ok ? '#' : enabled ? 'n' : '!';
+	}
+
+	dev_info(dev, "channel status: %s\n", status);
+	if (!chn_mask) {
+		dev_err(dev, "cannot enable any channels\n");
+		ret = -ENODEV;
+		goto err_clk;
+	}
+
+	/* clear bypass */
+	val = readl_relaxed(priv->base + MUC_SRC_ADDR_SMMU_BYPASS);
+	val &= ~GENMASK(7, 0);
+	writel_relaxed(val, priv->base + MUC_SRC_ADDR_SMMU_BYPASS);
+
+	val = readl_relaxed(priv->base + MUC_DST_ADDR_SMMU_BYPASS);
+	val &= ~GENMASK(7, 0);
+	writel_relaxed(val, priv->base + MUC_DST_ADDR_SMMU_BYPASS);
+
+	/* register irq */
+	for (int i = 0; i < ARRAY_SIZE(priv->irqs) && priv->irqs[i] > 0; i++) {
+		ret = devm_request_irq(dev, priv->irqs[i], hica_muc_handle,
+				       IRQF_SHARED, pdev->name, priv);
+		if (ret)
+			goto err_clk;
+	}
+
+	/* setup channels */
+	for (unsigned int chn = 0; chn < MUC_CHAN_NUM; chn++)
+		if (!(chn_mask & BIT(chn)))
+			priv->chans[chn].req = ERR_PTR(-EINVAL);
+		else {
+			ret = hica_muc_chan_init(&priv->chans[chn], priv, chn);
+			if (ret)
+				goto err_clk;
+		}
+
+	/* pressure on one channel to detect bug */
+	if (!(chn_mask & (chn_mask - 1)) || extra_check)
+		chn_mask = 0;
+	else {
+		chn_mask &= ~BIT(__fls(chn_mask));
+		for (unsigned int chn = 0; chn < MUC_CHAN_NUM; chn++)
+			if (chn_mask & BIT(chn))
+				priv->chans[chn].req = ERR_PTR(-EBUSY);
+	}
+	/* commit all writes before access */
+	smp_wmb();
+
+	/* register algs */
+	priv->task = kthread_create(hica_muc_thread, priv, dev->driver->name);
+	if (IS_ERR(priv->task)) {
+		ret = PTR_ERR(priv->task);
+		goto err_clk;
+	}
+	wake_up_process(priv->task);
+
+	for (int i = 0; i < priv->algs_num; i++) {
+		ret = hica_muc_alg_register(&priv->algs[i], &hica_muc_tmpls[i],
+					    priv);
+		if (ret) {
+			while (i > 0) {
+				i--;
+				crypto_unregister_skcipher(&priv->algs[i].alg);
+			}
+			goto err_task;
+		}
+	}
+
+	barrier();
+	if (chn_mask)
+		for (unsigned int chn = 0; chn < MUC_CHAN_NUM; chn++)
+			if (chn_mask & BIT(chn))
+				priv->chans[chn].req = NULL;
+
+	return 0;
+
+err_task:
+	kthread_stop(priv->task);
+err_clk:
+	clk_bulk_disable_unprepare(priv->clks_num, priv->clks);
+err_rst:
+	reset_control_assert(priv->rst);
+	return ret;
+}
+
+static const struct of_device_id hica_muc_of_match[] = {
+	{ .compatible = "hisilicon,advca-cipher", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hica_muc_of_match);
+
+static struct platform_driver hica_muc_driver = {
+	.probe = hica_muc_probe,
+	.remove_new = hica_muc_remove,
+	.driver = {
+		.name = "hisi-advca-muc",
+		.of_match_table = hica_muc_of_match,
+	},
+};
+
+module_platform_driver(hica_muc_driver);
+
+MODULE_DESCRIPTION("HiSilicon Advanced Conditional Access Subsystem - MutiCipher");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-- 
2.39.2

