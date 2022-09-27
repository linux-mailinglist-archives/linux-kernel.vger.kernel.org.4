Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D405EBCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiI0IIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiI0IHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:07:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFAF115F4F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so13659828wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jr5Ecya7f02Fy9CIGIZnQgyLjyPGQt48d5jJk43FDzM=;
        b=Mm2IYXWGR3i4bhPLVB250tX4UA4BJrhVqkDuPBa1KmH/+H/eFBj6zZolMHehqCbCA5
         TalfO5YAyj/n4xEPcpWdcYqsDQyOeQFKXm1360mBdmVVCjVZDB8ehWAa/lXZTbnb8tOW
         foEkus/QYTZfyPdq4rCTS3Tn4x3E2ndSMgU4a0283pPc1/jU5/po0ZzrAuCdv2jGv/IK
         lSjI0fSgDBIrZaO802iKoiY9UUyEauKYk6JaLNXrD3tYo87bnNNH3gCruKK+Gg5CaDL9
         N3b4NMmVaakQAc659RCTOPHiVM/UO9+kOCddm3cwGiRPtKsdZLg90kBKmpwsk34IlYND
         xaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jr5Ecya7f02Fy9CIGIZnQgyLjyPGQt48d5jJk43FDzM=;
        b=krIX8datHDvJb1ezba6tsWAZ2vq3tHvqmsva5AVVarBBOuvspIEpbxkQHoXJacOdtH
         B8oQrPWSTpHPOYUfWBJTZN3x3CiF7vk0IgnUZjsCVFHY8tP8I6opo6JT2KLVHnK5px/L
         dVeOR0rmFuYBzgsaudN5kFtVDbaukLfRym4qO2MY8VuBk/bP3KONv3pZLeyDYzy8TNuQ
         8YARrn5sma5Xq0RwpCu9fBwh9+jO/8pQljfdsu5HeDHTqGCZVQgTdu/4JpDH1MCAcji+
         N3k8QRcAnPxo9mXig836nQRKm4BR3L+OipduAjtO72o+iFM1YhcCJ/vecr0XUN9C65E5
         /JJg==
X-Gm-Message-State: ACrzQf1/zGMZE7jGoWt1I67K8jJjrUYlHfTl5dyBQP4DIcKgYlC+/XE4
        /KRTI11FyQ9/DRaLT4YmPJSUDA==
X-Google-Smtp-Source: AMsMyM4xeb2ui8ScXMiCcZETxM3gurxx5G1LnboZaBDbE488+ugYP5X6i28MYocTqeW4RB74MNLGPw==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr16064878wrb.581.1664265670856;
        Tue, 27 Sep 2022 01:01:10 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p4-20020a1c5444000000b003a5c7a942edsm13357199wmi.28.2022.09.27.01.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:01:10 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT 4/5] crypto: rockchip: support the new crypto IP for rk3568/rk3588
Date:   Tue, 27 Sep 2022 08:00:47 +0000
Message-Id: <20220927080048.3151911-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927080048.3151911-1-clabbe@baylibre.com>
References: <20220927080048.3151911-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip rk3568 and rk3588 have a common crypto offloader IP.
This driver adds support for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/Kconfig               |  28 +
 drivers/crypto/rockchip/Makefile              |   5 +
 drivers/crypto/rockchip/rk3588_crypto.c       | 646 ++++++++++++++++++
 drivers/crypto/rockchip/rk3588_crypto.h       | 221 ++++++
 drivers/crypto/rockchip/rk3588_crypto_ahash.c | 346 ++++++++++
 .../crypto/rockchip/rk3588_crypto_skcipher.c  | 340 +++++++++
 6 files changed, 1586 insertions(+)
 create mode 100644 drivers/crypto/rockchip/rk3588_crypto.c
 create mode 100644 drivers/crypto/rockchip/rk3588_crypto.h
 create mode 100644 drivers/crypto/rockchip/rk3588_crypto_ahash.c
 create mode 100644 drivers/crypto/rockchip/rk3588_crypto_skcipher.c

diff --git a/drivers/crypto/rockchip/Kconfig b/drivers/crypto/rockchip/Kconfig
index 1010d897d9ef..84ca1081fd0c 100644
--- a/drivers/crypto/rockchip/Kconfig
+++ b/drivers/crypto/rockchip/Kconfig
@@ -26,3 +26,31 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
 	  Say y to enable Rockchip crypto debug stats.
 	  This will create /sys/kernel/debug/rk3288_crypto/stats for displaying
 	  the number of requests per algorithm and other internal stats.
+
+config CRYPTO_DEV_ROCKCHIP2
+	tristate "Rockchip's cryptographic offloader V2"
+	depends on OF && ARCH_ROCKCHIP
+	depends on PM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_AES
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SM3
+	select CRYPTO_HASH
+	select CRYPTO_SKCIPHER
+	select CRYPTO_ENGINE
+
+	help
+	  This driver interfaces with the hardware crypto offloader present
+	  on RK3568 and RK3588.
+
+config CRYPTO_DEV_ROCKCHIP2_DEBUG
+	bool "Enable Rockchip V2 crypto stats"
+	depends on CRYPTO_DEV_ROCKCHIP2
+	depends on DEBUG_FS
+	help
+	  Say y to enable Rockchip crypto debug stats.
+	  This will create /sys/kernel/debug/rk3588_crypto/stats for displaying
+	  the number of requests per algorithm and other internal stats.
diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/Makefile
index 785277aca71e..2132d8326223 100644
--- a/drivers/crypto/rockchip/Makefile
+++ b/drivers/crypto/rockchip/Makefile
@@ -3,3 +3,8 @@ obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rk_crypto.o
 rk_crypto-objs := rk3288_crypto.o \
 		  rk3288_crypto_skcipher.o \
 		  rk3288_crypto_ahash.o
+
+obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP2) += rk_crypto2.o
+rk_crypto2-objs := rk3588_crypto.o \
+		  rk3588_crypto_skcipher.o \
+		  rk3588_crypto_ahash.o
diff --git a/drivers/crypto/rockchip/rk3588_crypto.c b/drivers/crypto/rockchip/rk3588_crypto.c
new file mode 100644
index 000000000000..121cde1fd18c
--- /dev/null
+++ b/drivers/crypto/rockchip/rk3588_crypto.c
@@ -0,0 +1,646 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hardware cryptographic offloader for rk3568/rk3588 SoC
+ *
+ * Copyright (c) 2022, Corentin Labbe <clabbe@baylibre.com>
+ */
+
+#include "rk3588_crypto.h"
+#include <linux/clk.h>
+#include <linux/crypto.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+
+static struct rockchip_ip rocklist = {
+	.dev_list = LIST_HEAD_INIT(rocklist.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(rocklist.lock),
+};
+
+struct rk_crypto_dev *get_rk_crypto(void)
+{
+	struct rk_crypto_dev *first;
+
+	spin_lock(&rocklist.lock);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk_crypto_dev, list);
+	list_rotate_left(&rocklist.dev_list);
+	spin_unlock(&rocklist.lock);
+	return first;
+}
+
+static const struct rk_variant rk3568_variant = {
+	.num_clks = 4,
+};
+
+static const struct rk_variant rk3588_variant = {
+	.num_clks = 4,
+};
+
+static int rk_crypto_get_clks(struct rk_crypto_dev *dev)
+{
+	int i, j, err;
+	unsigned long cr;
+
+	dev->num_clks = devm_clk_bulk_get_all(dev->dev, &dev->clks);
+	if (dev->num_clks < dev->variant->num_clks) {
+		dev_err(dev->dev, "Missing clocks, got %d instead of %d\n",
+			dev->num_clks, dev->variant->num_clks);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dev->num_clks; i++) {
+		cr = clk_get_rate(dev->clks[i].clk);
+		for (j = 0; j < ARRAY_SIZE(dev->variant->rkclks); j++) {
+			if (dev->variant->rkclks[j].max == 0)
+				continue;
+			if (strcmp(dev->variant->rkclks[j].name, dev->clks[i].id))
+				continue;
+			if (cr > dev->variant->rkclks[j].max) {
+				err = clk_set_rate(dev->clks[i].clk,
+						   dev->variant->rkclks[j].max);
+				if (err)
+					dev_err(dev->dev, "Fail downclocking %s from %lu to %lu\n",
+						dev->variant->rkclks[j].name, cr,
+						dev->variant->rkclks[j].max);
+				else
+					dev_info(dev->dev, "Downclocking %s from %lu to %lu\n",
+						 dev->variant->rkclks[j].name, cr,
+						 dev->variant->rkclks[j].max);
+			}
+		}
+	}
+	return 0;
+}
+
+static int rk_crypto_enable_clk(struct rk_crypto_dev *dev)
+{
+	int err;
+
+	err = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
+	if (err)
+		dev_err(dev->dev, "Could not enable clock clks\n");
+
+	return err;
+}
+
+static void rk_crypto_disable_clk(struct rk_crypto_dev *dev)
+{
+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+}
+
+/*
+ * Power management strategy: The device is suspended until a request
+ * is handled. For avoiding suspend/resume yoyo, the autosuspend is set to 2s.
+ */
+static int rk_crypto_pm_suspend(struct device *dev)
+{
+	struct rk_crypto_dev *rkdev = dev_get_drvdata(dev);
+
+	rk_crypto_disable_clk(rkdev);
+	reset_control_assert(rkdev->rst);
+
+	return 0;
+}
+
+static int rk_crypto_pm_resume(struct device *dev)
+{
+	struct rk_crypto_dev *rkdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = rk_crypto_enable_clk(rkdev);
+	if (ret)
+		return ret;
+
+	reset_control_deassert(rkdev->rst);
+	return 0;
+}
+
+static const struct dev_pm_ops rk_crypto_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk_crypto_pm_suspend, rk_crypto_pm_resume, NULL)
+};
+
+static int rk_crypto_pm_init(struct rk_crypto_dev *rkdev)
+{
+	int err;
+
+	pm_runtime_use_autosuspend(rkdev->dev);
+	pm_runtime_set_autosuspend_delay(rkdev->dev, 2000);
+
+	err = pm_runtime_set_suspended(rkdev->dev);
+	if (err)
+		return err;
+	pm_runtime_enable(rkdev->dev);
+	return err;
+}
+
+static void rk_crypto_pm_exit(struct rk_crypto_dev *rkdev)
+{
+	pm_runtime_disable(rkdev->dev);
+}
+
+static irqreturn_t rk_crypto_irq_handle(int irq, void *dev_id)
+{
+	struct rk_crypto_dev *rkc  = platform_get_drvdata(dev_id);
+	u32 v;
+
+	v = readl(rkc->reg + RK_CRYPTO_DMA_INT_ST);
+	writel(v, rkc->reg + RK_CRYPTO_DMA_INT_ST);
+
+	rkc->status = 1;
+	if (v & 0xF8) {
+		dev_warn(rkc->dev, "DMA Error\n");
+		rkc->status = 0;
+	}
+	complete(&rkc->complete);
+
+	return IRQ_HANDLED;
+}
+
+static struct rk_crypto_template rk_cipher_algs[] = {
+	{
+		.type = CRYPTO_ALG_TYPE_SKCIPHER,
+		.alg.skcipher = {
+			.base.cra_name		= "ecb(aes)",
+			.base.cra_driver_name	= "ecb-aes-rk2",
+			.base.cra_priority	= 300,
+			.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+			.base.cra_blocksize	= AES_BLOCK_SIZE,
+			.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+			.base.cra_alignmask	= 0x0f,
+			.base.cra_module	= THIS_MODULE,
+
+			.init			= rk_cipher_tfm_init,
+			.exit			= rk_cipher_tfm_exit,
+			.min_keysize		= AES_MIN_KEY_SIZE,
+			.max_keysize		= AES_MAX_KEY_SIZE,
+			.setkey			= rk_aes_setkey,
+			.encrypt		= rk_aes_ecb_encrypt,
+			.decrypt		= rk_aes_ecb_decrypt,
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_SKCIPHER,
+		.alg.skcipher = {
+			.base.cra_name		= "cbc(aes)",
+			.base.cra_driver_name	= "cbc-aes-rk2",
+			.base.cra_priority	= 300,
+			.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+			.base.cra_blocksize	= AES_BLOCK_SIZE,
+			.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+			.base.cra_alignmask	= 0x0f,
+			.base.cra_module	= THIS_MODULE,
+
+			.init			= rk_cipher_tfm_init,
+			.exit			= rk_cipher_tfm_exit,
+			.min_keysize		= AES_MIN_KEY_SIZE,
+			.max_keysize		= AES_MAX_KEY_SIZE,
+			.ivsize			= AES_BLOCK_SIZE,
+			.setkey			= rk_aes_setkey,
+			.encrypt		= rk_aes_cbc_encrypt,
+			.decrypt		= rk_aes_cbc_decrypt,
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk_mode = RK_CRYPTO_MD5,
+		.alg.hash = {
+			.init = rk_ahash_init,
+			.update = rk_ahash_update,
+			.final = rk_ahash_final,
+			.finup = rk_ahash_finup,
+			.export = rk_ahash_export,
+			.import = rk_ahash_import,
+			.digest = rk_ahash_digest,
+			.halg = {
+				.digestsize = MD5_DIGEST_SIZE,
+				.statesize = sizeof(struct md5_state),
+				.base = {
+					.cra_name = "md5",
+					.cra_driver_name = "rk2-md5",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA1_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk_ahash_ctx),
+					.cra_alignmask = 3,
+					.cra_init = rk_cra_hash_init,
+					.cra_exit = rk_cra_hash_exit,
+					.cra_module = THIS_MODULE,
+				}
+			}
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk_mode = RK_CRYPTO_SHA1,
+		.alg.hash = {
+			.init = rk_ahash_init,
+			.update = rk_ahash_update,
+			.final = rk_ahash_final,
+			.finup = rk_ahash_finup,
+			.export = rk_ahash_export,
+			.import = rk_ahash_import,
+			.digest = rk_ahash_digest,
+			.halg = {
+				.digestsize = SHA1_DIGEST_SIZE,
+				.statesize = sizeof(struct sha1_state),
+				.base = {
+					.cra_name = "sha1",
+					.cra_driver_name = "rk2-sha1",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA1_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk_ahash_ctx),
+					.cra_alignmask = 3,
+					.cra_init = rk_cra_hash_init,
+					.cra_exit = rk_cra_hash_exit,
+					.cra_module = THIS_MODULE,
+				}
+			}
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk_mode = RK_CRYPTO_SHA256,
+		.alg.hash = {
+			.init = rk_ahash_init,
+			.update = rk_ahash_update,
+			.final = rk_ahash_final,
+			.finup = rk_ahash_finup,
+			.export = rk_ahash_export,
+			.import = rk_ahash_import,
+			.digest = rk_ahash_digest,
+			.halg = {
+				.digestsize = SHA256_DIGEST_SIZE,
+				.statesize = sizeof(struct sha256_state),
+				.base = {
+					.cra_name = "sha256",
+					.cra_driver_name = "rk2-sha256",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA256_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk_ahash_ctx),
+					.cra_alignmask = 3,
+					.cra_init = rk_cra_hash_init,
+					.cra_exit = rk_cra_hash_exit,
+					.cra_module = THIS_MODULE,
+				}
+			}
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk_mode = RK_CRYPTO_SHA384,
+		.alg.hash = {
+			.init = rk_ahash_init,
+			.update = rk_ahash_update,
+			.final = rk_ahash_final,
+			.finup = rk_ahash_finup,
+			.export = rk_ahash_export,
+			.import = rk_ahash_import,
+			.digest = rk_ahash_digest,
+			.halg = {
+				.digestsize = SHA384_DIGEST_SIZE,
+				.statesize = sizeof(struct sha512_state),
+				.base = {
+					.cra_name = "sha384",
+					.cra_driver_name = "rk2-sha384",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA384_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk_ahash_ctx),
+					.cra_alignmask = 3,
+					.cra_init = rk_cra_hash_init,
+					.cra_exit = rk_cra_hash_exit,
+					.cra_module = THIS_MODULE,
+				}
+			}
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk_mode = RK_CRYPTO_SHA512,
+		.alg.hash = {
+			.init = rk_ahash_init,
+			.update = rk_ahash_update,
+			.final = rk_ahash_final,
+			.finup = rk_ahash_finup,
+			.export = rk_ahash_export,
+			.import = rk_ahash_import,
+			.digest = rk_ahash_digest,
+			.halg = {
+				.digestsize = SHA512_DIGEST_SIZE,
+				.statesize = sizeof(struct sha512_state),
+				.base = {
+					.cra_name = "sha512",
+					.cra_driver_name = "rk2-sha512",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA512_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk_ahash_ctx),
+					.cra_alignmask = 3,
+					.cra_init = rk_cra_hash_init,
+					.cra_exit = rk_cra_hash_exit,
+					.cra_module = THIS_MODULE,
+				}
+			}
+		}
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk_mode = RK_CRYPTO_SM3,
+		.alg.hash = {
+			.init = rk_ahash_init,
+			.update = rk_ahash_update,
+			.final = rk_ahash_final,
+			.finup = rk_ahash_finup,
+			.export = rk_ahash_export,
+			.import = rk_ahash_import,
+			.digest = rk_ahash_digest,
+			.halg = {
+				.digestsize = SM3_DIGEST_SIZE,
+				.statesize = sizeof(struct sm3_state),
+				.base = {
+					.cra_name = "sm3",
+					.cra_driver_name = "rk2-sm3",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SM3_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk_ahash_ctx),
+					.cra_alignmask = 3,
+					.cra_init = rk_cra_hash_init,
+					.cra_exit = rk_cra_hash_exit,
+					.cra_module = THIS_MODULE,
+				}
+			}
+		}
+	},
+};
+
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
+static int rk_crypto_debugfs_show(struct seq_file *seq, void *v)
+{
+	struct rk_crypto_dev *dd;
+	unsigned int i;
+
+	spin_lock(&rocklist.lock);
+	list_for_each_entry(dd, &rocklist.dev_list, list) {
+		seq_printf(seq, "%s %s requests: %lu\n",
+			   dev_driver_string(dd->dev), dev_name(dd->dev),
+			   dd->nreq);
+	}
+	spin_unlock(&rocklist.lock);
+
+	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
+		if (!rk_cipher_algs[i].dev)
+			continue;
+		switch (rk_cipher_algs[i].type) {
+		case CRYPTO_ALG_TYPE_SKCIPHER:
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
+				   rk_cipher_algs[i].alg.skcipher.base.cra_driver_name,
+				   rk_cipher_algs[i].alg.skcipher.base.cra_name,
+				   rk_cipher_algs[i].stat_req, rk_cipher_algs[i].stat_fb);
+			seq_printf(seq, "\tfallback due to length: %lu\n",
+				   rk_cipher_algs[i].stat_fb_len);
+			seq_printf(seq, "\tfallback due to alignment: %lu\n",
+				   rk_cipher_algs[i].stat_fb_align);
+			seq_printf(seq, "\tfallback due to SGs: %lu\n",
+				   rk_cipher_algs[i].stat_fb_sgdiff);
+			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
+				   rk_cipher_algs[i].alg.hash.halg.base.cra_driver_name,
+				   rk_cipher_algs[i].alg.hash.halg.base.cra_name,
+				   rk_cipher_algs[i].stat_req, rk_cipher_algs[i].stat_fb);
+			break;
+		}
+	}
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(rk_crypto_debugfs);
+#endif
+
+static void register_debugfs(struct rk_crypto_dev *crypto_dev)
+{
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
+	/* Ignore error of debugfs */
+	rocklist.dbgfs_dir = debugfs_create_dir("rk3588_crypto", NULL);
+	rocklist.dbgfs_stats = debugfs_create_file("stats", 0444,
+						   rocklist.dbgfs_dir,
+						   &rocklist,
+						   &rk_crypto_debugfs_fops);
+#endif
+}
+
+static int rk_crypto_register(struct rk_crypto_dev *rkc)
+{
+	unsigned int i, k;
+	int err = 0;
+
+	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
+		rk_cipher_algs[i].dev = rkc;
+		switch (rk_cipher_algs[i].type) {
+		case CRYPTO_ALG_TYPE_SKCIPHER:
+			dev_info(rkc->dev, "Register %s as %s\n",
+				 rk_cipher_algs[i].alg.skcipher.base.cra_name,
+				 rk_cipher_algs[i].alg.skcipher.base.cra_driver_name);
+			err = crypto_register_skcipher(&rk_cipher_algs[i].alg.skcipher);
+			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			dev_info(rkc->dev, "Register %s as %s\n",
+				 rk_cipher_algs[i].alg.hash.halg.base.cra_name,
+				 rk_cipher_algs[i].alg.hash.halg.base.cra_driver_name);
+			err = crypto_register_ahash(&rk_cipher_algs[i].alg.hash);
+			break;
+		default:
+			dev_err(rkc->dev, "unknown algorithm\n");
+		}
+		if (err)
+			goto err_cipher_algs;
+	}
+	return 0;
+
+err_cipher_algs:
+	for (k = 0; k < i; k++) {
+		if (rk_cipher_algs[i].type == CRYPTO_ALG_TYPE_SKCIPHER)
+			crypto_unregister_skcipher(&rk_cipher_algs[k].alg.skcipher);
+		else
+			crypto_unregister_ahash(&rk_cipher_algs[i].alg.hash);
+	}
+	return err;
+}
+
+static void rk_crypto_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
+		if (rk_cipher_algs[i].type == CRYPTO_ALG_TYPE_SKCIPHER)
+			crypto_unregister_skcipher(&rk_cipher_algs[i].alg.skcipher);
+		else
+			crypto_unregister_ahash(&rk_cipher_algs[i].alg.hash);
+	}
+}
+
+static const struct of_device_id crypto_of_id_table[] = {
+	{ .compatible = "rockchip,rk3568-crypto",
+	  .data = &rk3568_variant,
+	},
+	{ .compatible = "rockchip,rk3588-crypto",
+	  .data = &rk3588_variant,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, crypto_of_id_table);
+
+static int rk_crypto_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rk_crypto_dev *rkc, *first;
+	int err = 0;
+
+	rkc = devm_kzalloc(&pdev->dev, sizeof(*rkc), GFP_KERNEL);
+	if (!rkc) {
+		err = -ENOMEM;
+		goto err_crypto;
+	}
+
+	rkc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, rkc);
+
+	rkc->variant = of_device_get_match_data(&pdev->dev);
+	if (!rkc->variant) {
+		dev_err(&pdev->dev, "Missing variant\n");
+		return -EINVAL;
+	}
+
+	rkc->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(rkc->rst)) {
+		err = PTR_ERR(rkc->rst);
+		goto err_crypto;
+	}
+
+	rkc->tl = dma_alloc_coherent(rkc->dev,
+				     sizeof(struct rk_crypto_lli) * MAX_LLI,
+				     &rkc->t_phy, GFP_KERNEL);
+	if (!rkc->tl) {
+		dev_err(rkc->dev, "Cannot get DMA memory for task\n");
+		err = -ENOMEM;
+		goto err_crypto;
+	}
+
+	reset_control_assert(rkc->rst);
+	usleep_range(10, 20);
+	reset_control_deassert(rkc->rst);
+
+	rkc->reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rkc->reg)) {
+		err = PTR_ERR(rkc->reg);
+		goto err_crypto;
+	}
+
+	err = rk_crypto_get_clks(rkc);
+	if (err)
+		goto err_crypto;
+
+	rkc->irq = platform_get_irq(pdev, 0);
+	if (rkc->irq < 0) {
+		dev_err(&pdev->dev, "control Interrupt is not available.\n");
+		err = rkc->irq;
+		goto err_crypto;
+	}
+
+	err = devm_request_irq(&pdev->dev, rkc->irq,
+			       rk_crypto_irq_handle, IRQF_SHARED,
+			       "rk-crypto", pdev);
+
+	if (err) {
+		dev_err(&pdev->dev, "irq request failed.\n");
+		goto err_crypto;
+	}
+
+	rkc->engine = crypto_engine_alloc_init(&pdev->dev, true);
+	crypto_engine_start(rkc->engine);
+	init_completion(&rkc->complete);
+
+	err = rk_crypto_pm_init(rkc);
+	if (err)
+		goto err_pm;
+
+	err = pm_runtime_resume_and_get(&pdev->dev);
+
+	spin_lock(&rocklist.lock);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk_crypto_dev, list);
+	list_add_tail(&rkc->list, &rocklist.dev_list);
+	spin_unlock(&rocklist.lock);
+
+	if (!first) {
+		dev_info(dev, "Registers crypto algos\n");
+		err = rk_crypto_register(rkc);
+		if (err) {
+			dev_err(dev, "Fail to register crypto algorithms");
+			goto err_register_alg;
+		}
+
+		register_debugfs(rkc);
+	}
+
+	return 0;
+
+err_register_alg:
+	rk_crypto_pm_exit(rkc);
+err_pm:
+	crypto_engine_exit(rkc->engine);
+err_crypto:
+	dev_err(dev, "Crypto Accelerator not successfully registered\n");
+	return err;
+}
+
+static int rk_crypto_remove(struct platform_device *pdev)
+{
+	struct rk_crypto_dev *crypto_tmp = platform_get_drvdata(pdev);
+	struct rk_crypto_dev *first;
+
+	spin_lock_bh(&rocklist.lock);
+	list_del(&crypto_tmp->list);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk_crypto_dev, list);
+	spin_unlock_bh(&rocklist.lock);
+
+	if (!first) {
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
+		debugfs_remove_recursive(rocklist.dbgfs_dir);
+#endif
+		rk_crypto_unregister();
+	}
+	rk_crypto_pm_exit(crypto_tmp);
+	crypto_engine_exit(crypto_tmp->engine);
+	return 0;
+}
+
+static struct platform_driver crypto_driver = {
+	.probe		= rk_crypto_probe,
+	.remove		= rk_crypto_remove,
+	.driver		= {
+		.name	= "rk3588-crypto",
+		.pm		= &rk_crypto_pm_ops,
+		.of_match_table	= crypto_of_id_table,
+	},
+};
+
+module_platform_driver(crypto_driver);
+
+MODULE_DESCRIPTION("Rockchip Crypto Engine cryptographic offloader");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corentin Labbe <clabbe@baylibre.com>");
diff --git a/drivers/crypto/rockchip/rk3588_crypto.h b/drivers/crypto/rockchip/rk3588_crypto.h
new file mode 100644
index 000000000000..91139a4dade8
--- /dev/null
+++ b/drivers/crypto/rockchip/rk3588_crypto.h
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <crypto/aes.h>
+#include <crypto/engine.h>
+#include <crypto/internal/des.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/md5.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+
+#define RK_CRYPTO_CLK_CTL	0x0000
+#define RK_CRYPTO_RST_CTL	0x0004
+
+#define RK_CRYPTO_DMA_INT_EN	0x0008
+/* values for RK_CRYPTO_DMA_INT_EN */
+#define RK_CRYPTO_DMA_INT_LISTDONE	BIT(0)
+
+#define RK_CRYPTO_DMA_INT_ST	0x000C
+/* values in RK_CRYPTO_DMA_INT_ST are the same than in RK_CRYPTO_DMA_INT_EN */
+
+#define RK_CRYPTO_DMA_CTL	0x0010
+#define RK_CRYPTO_DMA_CTL_START	BIT(0)
+
+#define RK_CRYPTO_DMA_LLI_ADDR	0x0014
+
+#define RK_CRYPTO_FIFO_CTL	0x0040
+
+#define RK_CRYPTO_BC_CTL	0x0044
+#define RK_CRYPTO_AES		(0 << 8)
+#define RK_CRYPTO_MODE_ECB	(0 << 4)
+#define RK_CRYPTO_MODE_CBC	(1 << 4)
+
+#define RK_CRYPTO_HASH_CTL	0x0048
+#define RK_CRYPTO_HW_PAD	BIT(2)
+#define RK_CRYPTO_SHA1		(0 << 4)
+#define RK_CRYPTO_MD5		(1 << 4)
+#define RK_CRYPTO_SHA224	(3 << 4)
+#define RK_CRYPTO_SHA256	(2 << 4)
+#define RK_CRYPTO_SHA384	(9 << 4)
+#define RK_CRYPTO_SHA512	(8 << 4)
+#define RK_CRYPTO_SM3		(4 << 4)
+
+#define RK_CRYPTO_AES_ECB_MODE		(RK_CRYPTO_AES | RK_CRYPTO_MODE_ECB)
+#define RK_CRYPTO_AES_CBC_MODE		(RK_CRYPTO_AES | RK_CRYPTO_MODE_CBC)
+#define RK_CRYPTO_AES_CTR_MODE		3
+#define RK_CRYPTO_AES_128BIT_key	(0 << 2)
+#define RK_CRYPTO_AES_192BIT_key	(1 << 2)
+#define RK_CRYPTO_AES_256BIT_key	(2 << 2)
+
+#define RK_CRYPTO_DEC			BIT(1)
+#define RK_CRYPTO_ENABLE		BIT(0)
+
+#define RK_CRYPTO_CH0_IV_0		0x0100
+
+#define RK_CRYPTO_KEY0			0x0180
+#define RK_CRYPTO_KEY1			0x0184
+#define RK_CRYPTO_KEY2			0x0188
+#define RK_CRYPTO_KEY3			0x018C
+#define RK_CRYPTO_KEY4			0x0190
+#define RK_CRYPTO_KEY5			0x0194
+#define RK_CRYPTO_KEY6			0x0198
+#define RK_CRYPTO_KEY7			0x019C
+
+#define RK_CRYPTO_CH0_PC_LEN_0		0x0280
+
+#define RK_CRYPTO_CH0_IV_LEN		0x0300
+
+#define RK_CRYPTO_HASH_DOUT_0	0x03A0
+#define RK_CRYPTO_HASH_VALID	0x03E4
+
+#define CRYPTO_AES_VERSION	0x0680
+#define CRYPTO_DES_VERSION	0x0684
+#define CRYPTO_SM4_VERSION	0x0688
+#define CRYPTO_HASH_VERSION	0x068C
+#define CRYPTO_HMAC_VERSION	0x0690
+#define CRYPTO_RNG_VERSION	0x0694
+#define CRYPTO_PKA_VERSION	0x0698
+#define CRYPTO_CRYPTO_VERSION	0x06F0
+
+#define RK_LLI_DMA_CTRL_SRC_INT		BIT(10)
+#define RK_LLI_DMA_CTRL_DST_INT		BIT(9)
+#define RK_LLI_DMA_CTRL_LIST_INT	BIT(8)
+#define RK_LLI_DMA_CTRL_LAST		BIT(0)
+
+#define RK_LLI_STRING_LAST		BIT(2)
+#define RK_LLI_STRING_FIRST		BIT(1)
+#define RK_LLI_CIPHER_START		BIT(0)
+
+#define RK_MAX_CLKS 4
+
+/* there are no hw limit, but we need to choose a maximum of descriptor to allocate */
+#define MAX_LLI 20
+
+struct rk_crypto_lli {
+	__le32 src_addr;
+	__le32 src_len;
+	__le32 dst_addr;
+	__le32 dst_len;
+	__le32 user;
+	__le32 iv;
+	__le32 dma_ctrl;
+	__le32 next;
+};
+
+/*
+ * struct rockchip_ip - struct for managing a list of RK crypto instance
+ * @dev_list:		Used for doing a list of rk_crypto_dev
+ * @lock:		Control access to dev_list
+ * @dbgfs_dir:		Debugfs dentry for statistic directory
+ * @dbgfs_stats:	Debugfs dentry for statistic counters
+ */
+struct rockchip_ip {
+	struct list_head	dev_list;
+	spinlock_t		lock; /* Control access to dev_list */
+	struct dentry		*dbgfs_dir;
+	struct dentry		*dbgfs_stats;
+};
+
+struct rk_clks {
+	const char *name;
+	unsigned long max;
+};
+
+struct rk_variant {
+	int num_clks;
+	struct rk_clks rkclks[RK_MAX_CLKS];
+};
+
+struct rk_crypto_dev {
+	struct list_head		list;
+	struct device			*dev;
+	struct clk_bulk_data		*clks;
+	int				num_clks;
+	struct reset_control		*rst;
+	void __iomem			*reg;
+	int				irq;
+	const struct rk_variant *variant;
+	unsigned long nreq;
+	struct crypto_engine *engine;
+	struct completion complete;
+	int status;
+	struct rk_crypto_lli *tl;
+	dma_addr_t t_phy;
+};
+
+/* the private variable of hash */
+struct rk_ahash_ctx {
+	struct crypto_engine_ctx enginectx;
+	/* for fallback */
+	struct crypto_ahash		*fallback_tfm;
+};
+
+/* the private variable of hash for fallback */
+struct rk_ahash_rctx {
+	struct rk_crypto_dev		*dev;
+	struct ahash_request		fallback_req;
+	u32				mode;
+	int nrsgs;
+};
+
+/* the private variable of cipher */
+struct rk_cipher_ctx {
+	struct crypto_engine_ctx enginectx;
+	unsigned int			keylen;
+	u8				key[AES_MAX_KEY_SIZE];
+	u8				iv[AES_BLOCK_SIZE];
+	struct crypto_skcipher *fallback_tfm;
+};
+
+struct rk_cipher_rctx {
+	struct rk_crypto_dev		*dev;
+	u8 backup_iv[AES_BLOCK_SIZE];
+	u32				mode;
+	struct skcipher_request fallback_req;   // keep at the end
+};
+
+struct rk_crypto_template {
+	u32 type;
+	u32 rk_mode;
+	struct rk_crypto_dev           *dev;
+	union {
+		struct skcipher_alg	skcipher;
+		struct ahash_alg	hash;
+	} alg;
+	unsigned long stat_req;
+	unsigned long stat_fb;
+	unsigned long stat_fb_len;
+	unsigned long stat_fb_sglen;
+	unsigned long stat_fb_align;
+	unsigned long stat_fb_sgdiff;
+};
+
+struct rk_crypto_dev *get_rk_crypto(void);
+
+int rk_cipher_tfm_init(struct crypto_skcipher *tfm);
+void rk_cipher_tfm_exit(struct crypto_skcipher *tfm);
+int rk_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
+		  unsigned int keylen);
+int rk_aes_ecb_encrypt(struct skcipher_request *req);
+int rk_aes_ecb_decrypt(struct skcipher_request *req);
+int rk_aes_cbc_encrypt(struct skcipher_request *req);
+int rk_aes_cbc_decrypt(struct skcipher_request *req);
+
+int rk_ahash_init(struct ahash_request *req);
+int rk_ahash_update(struct ahash_request *req);
+int rk_ahash_final(struct ahash_request *req);
+int rk_ahash_finup(struct ahash_request *req);
+int rk_ahash_import(struct ahash_request *req, const void *in);
+int rk_ahash_export(struct ahash_request *req, void *out);
+int rk_ahash_digest(struct ahash_request *req);
+int rk_cra_hash_init(struct crypto_tfm *tfm);
+void rk_cra_hash_exit(struct crypto_tfm *tfm);
diff --git a/drivers/crypto/rockchip/rk3588_crypto_ahash.c b/drivers/crypto/rockchip/rk3588_crypto_ahash.c
new file mode 100644
index 000000000000..9776c777bd7c
--- /dev/null
+++ b/drivers/crypto/rockchip/rk3588_crypto_ahash.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Crypto acceleration support for Rockchip RK3588
+ *
+ * Copyright (c) 2022 Corentin Labbe <clabbe@baylibre.com>
+ */
+#include <asm/unaligned.h>
+#include <linux/iopoll.h>
+#include "rk3588_crypto.h"
+
+static bool rk_ahash_need_fallback(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.hash);
+	struct scatterlist *sg;
+
+	sg = areq->src;
+	while (sg) {
+		if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
+			return true;
+		}
+		if (sg->length % 4) {
+			algt->stat_fb_sglen++;
+			return true;
+		}
+		sg = sg_next(sg);
+	}
+	return false;
+}
+
+static int rk_ahash_digest_fb(struct ahash_request *areq)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct rk_ahash_ctx *tfmctx = crypto_ahash_ctx(tfm);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.hash);
+
+	algt->stat_fb++;
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+	rctx->fallback_req.result = areq->result;
+
+	return crypto_ahash_digest(&rctx->fallback_req);
+}
+
+static int zero_message_process(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.hash);
+	int digestsize = crypto_ahash_digestsize(tfm);
+
+	switch (algt->rk_mode) {
+	case RK_CRYPTO_SHA1:
+		memcpy(req->result, sha1_zero_message_hash, digestsize);
+		break;
+	case RK_CRYPTO_SHA256:
+		memcpy(req->result, sha256_zero_message_hash, digestsize);
+		break;
+	case RK_CRYPTO_SHA384:
+		memcpy(req->result, sha384_zero_message_hash, digestsize);
+		break;
+	case RK_CRYPTO_SHA512:
+		memcpy(req->result, sha512_zero_message_hash, digestsize);
+		break;
+	case RK_CRYPTO_MD5:
+		memcpy(req->result, md5_zero_message_hash, digestsize);
+		break;
+	case RK_CRYPTO_SM3:
+		memcpy(req->result, sm3_zero_message_hash, digestsize);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int rk_ahash_init(struct ahash_request *req)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_init(&rctx->fallback_req);
+}
+
+int rk_ahash_update(struct ahash_request *req)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->fallback_req.nbytes = req->nbytes;
+	rctx->fallback_req.src = req->src;
+
+	return crypto_ahash_update(&rctx->fallback_req);
+}
+
+int rk_ahash_final(struct ahash_request *req)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->fallback_req.result = req->result;
+
+	return crypto_ahash_final(&rctx->fallback_req);
+}
+
+int rk_ahash_finup(struct ahash_request *req)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = req->nbytes;
+	rctx->fallback_req.src = req->src;
+	rctx->fallback_req.result = req->result;
+
+	return crypto_ahash_finup(&rctx->fallback_req);
+}
+
+int rk_ahash_import(struct ahash_request *req, const void *in)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_import(&rctx->fallback_req, in);
+}
+
+int rk_ahash_export(struct ahash_request *req, void *out)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_export(&rctx->fallback_req, out);
+}
+
+int rk_ahash_digest(struct ahash_request *req)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct rk_crypto_dev *dev;
+	struct crypto_engine *engine;
+
+	if (rk_ahash_need_fallback(req))
+		return rk_ahash_digest_fb(req);
+
+	if (!req->nbytes)
+		return zero_message_process(req);
+
+	dev = get_rk_crypto();
+
+	rctx->dev = dev;
+	engine = dev->engine;
+
+	return crypto_transfer_hash_request_to_engine(engine, req);
+}
+
+static int rk_hash_prepare(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct rk_crypto_dev *rkc = rctx->dev;
+	int ret;
+
+	ret = dma_map_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+	if (ret <= 0)
+		return -EINVAL;
+
+	rctx->nrsgs = ret;
+
+	return 0;
+}
+
+static int rk_hash_unprepare(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct rk_crypto_dev *rkc = rctx->dev;
+
+	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsgs, DMA_TO_DEVICE);
+	return 0;
+}
+
+static int rk_hash_run(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.hash);
+	struct scatterlist *sgs = areq->src;
+	struct rk_crypto_dev *rkc = rctx->dev;
+	struct rk_crypto_lli *dd = &rkc->tl[0];
+	int ddi = 0;
+	int err = 0;
+	unsigned int len = areq->nbytes;
+	unsigned int todo;
+	u32 v;
+	int i;
+
+	err = pm_runtime_resume_and_get(rkc->dev);
+	if (err)
+		return err;
+
+	dev_dbg(rkc->dev, "%s %s len=%d\n", __func__,
+		crypto_tfm_alg_name(areq->base.tfm), areq->nbytes);
+
+	algt->stat_req++;
+	rkc->nreq++;
+
+	rctx->mode = algt->rk_mode;
+	rctx->mode |= 0xffff0000;
+	rctx->mode |= RK_CRYPTO_ENABLE | RK_CRYPTO_HW_PAD;
+	writel(rctx->mode, rkc->reg + RK_CRYPTO_HASH_CTL);
+
+	while (sgs && len > 0) {
+		dd = &rkc->tl[ddi];
+
+		todo = min(sg_dma_len(sgs), len);
+		dd->src_addr = sg_dma_address(sgs);
+		dd->src_len = todo;
+		dd->dst_addr = 0;
+		dd->dst_len = 0;
+		dd->dma_ctrl = ddi << 24;
+		dd->iv = 0;
+		dd->next = rkc->t_phy + sizeof(struct rk_crypto_lli) * (ddi + 1);
+
+		if (ddi == 0)
+			dd->user = RK_LLI_CIPHER_START | RK_LLI_STRING_FIRST;
+		else
+			dd->user = 0;
+
+		len -= todo;
+		dd->dma_ctrl |= RK_LLI_DMA_CTRL_SRC_INT;
+		if (len == 0) {
+			dd->user |= RK_LLI_STRING_LAST;
+			dd->dma_ctrl |= RK_LLI_DMA_CTRL_LAST;
+		}
+		dev_dbg(rkc->dev, "HASH SG %d sglen=%d user=%x dma=%x mode=%x len=%d todo=%d phy=%llx\n",
+			ddi, sgs->length, dd->user, dd->dma_ctrl, rctx->mode, len, todo, rkc->t_phy);
+
+		sgs = sg_next(sgs);
+		ddi++;
+	}
+	dd->next = 1;
+	writel(RK_CRYPTO_DMA_INT_LISTDONE | 0x7F, rkc->reg + RK_CRYPTO_DMA_INT_EN);
+
+	writel(rkc->t_phy, rkc->reg + RK_CRYPTO_DMA_LLI_ADDR);
+
+	reinit_completion(&rkc->complete);
+	rkc->status = 0;
+
+	writel(RK_CRYPTO_DMA_CTL_START | 1 << 16, rkc->reg + RK_CRYPTO_DMA_CTL);
+
+	wait_for_completion_interruptible_timeout(&rkc->complete,
+						  msecs_to_jiffies(2000));
+	if (!rkc->status) {
+		dev_err(rkc->dev, "DMA timeout\n");
+		err = -EFAULT;
+		goto theend;
+	}
+
+	readl_poll_timeout_atomic(rkc->reg + RK_CRYPTO_HASH_VALID, v, v == 1,
+				  10, 1000);
+
+	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
+		v = readl(rkc->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
+		put_unaligned_le32(be32_to_cpu(v), areq->result + i * 4);
+	}
+
+theend:
+	pm_runtime_put_autosuspend(rkc->dev);
+
+	local_bh_disable();
+	crypto_finalize_hash_request(engine, breq, err);
+	local_bh_enable();
+
+	return 0;
+}
+
+int rk_cra_hash_init(struct crypto_tfm *tfm)
+{
+	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
+	const char *alg_name = crypto_tfm_alg_name(tfm);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.hash);
+
+	/* for fallback */
+	tctx->fallback_tfm = crypto_alloc_ahash(alg_name, 0,
+						CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(tctx->fallback_tfm)) {
+		dev_err(algt->dev->dev, "Could not load fallback driver.\n");
+		return PTR_ERR(tctx->fallback_tfm);
+	}
+
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct rk_ahash_rctx) +
+				 crypto_ahash_reqsize(tctx->fallback_tfm));
+
+	tctx->enginectx.op.do_one_request = rk_hash_run;
+	tctx->enginectx.op.prepare_request = rk_hash_prepare;
+	tctx->enginectx.op.unprepare_request = rk_hash_unprepare;
+
+	return 0;
+}
+
+void rk_cra_hash_exit(struct crypto_tfm *tfm)
+{
+	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_ahash(tctx->fallback_tfm);
+}
diff --git a/drivers/crypto/rockchip/rk3588_crypto_skcipher.c b/drivers/crypto/rockchip/rk3588_crypto_skcipher.c
new file mode 100644
index 000000000000..e1d3be04e985
--- /dev/null
+++ b/drivers/crypto/rockchip/rk3588_crypto_skcipher.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hardware cryptographic offloader for rk3568/rk3588 SoC
+ *
+ * Copyright (c) 2022 Corentin Labbe <clabbe@baylibre.com>
+ */
+#include <crypto/scatterwalk.h>
+#include "rk3588_crypto.h"
+
+static int rk_cipher_need_fallback(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.skcipher);
+	struct scatterlist *sgs, *sgd;
+	unsigned int stodo, dtodo, len;
+	unsigned int bs = crypto_skcipher_blocksize(tfm);
+
+	if (!req->cryptlen)
+		return true;
+
+	len = req->cryptlen;
+	sgs = req->src;
+	sgd = req->dst;
+	while (sgs && sgd) {
+		if (!IS_ALIGNED(sgs->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
+			return true;
+		}
+		if (!IS_ALIGNED(sgd->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
+			return true;
+		}
+		stodo = min(len, sgs->length);
+		if (stodo % bs) {
+			algt->stat_fb_len++;
+			return true;
+		}
+		dtodo = min(len, sgd->length);
+		if (dtodo % bs) {
+			algt->stat_fb_len++;
+			return true;
+		}
+		if (stodo != dtodo) {
+			algt->stat_fb_sgdiff++;
+			return true;
+		}
+		len -= stodo;
+		sgs = sg_next(sgs);
+		sgd = sg_next(sgd);
+	}
+	return false;
+}
+
+static int rk_cipher_fallback(struct skcipher_request *areq)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct rk_cipher_ctx *op = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(areq);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.skcipher);
+	int err;
+
+	algt->stat_fb++;
+
+	skcipher_request_set_tfm(&rctx->fallback_req, op->fallback_tfm);
+	skcipher_request_set_callback(&rctx->fallback_req, areq->base.flags,
+				      areq->base.complete, areq->base.data);
+	skcipher_request_set_crypt(&rctx->fallback_req, areq->src, areq->dst,
+				   areq->cryptlen, areq->iv);
+	if (rctx->mode & RK_CRYPTO_DEC)
+		err = crypto_skcipher_decrypt(&rctx->fallback_req);
+	else
+		err = crypto_skcipher_encrypt(&rctx->fallback_req);
+	return err;
+}
+
+static int rk_cipher_handle_req(struct skcipher_request *req)
+{
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
+	struct rk_crypto_dev *rkc;
+	struct crypto_engine *engine;
+
+	if (rk_cipher_need_fallback(req))
+		return rk_cipher_fallback(req);
+
+	rkc = get_rk_crypto();
+
+	engine = rkc->engine;
+	rctx->dev = rkc;
+
+	return crypto_transfer_skcipher_request_to_engine(engine, req);
+}
+
+int rk_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
+		  unsigned int keylen)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct rk_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+	ctx->keylen = keylen;
+	memcpy(ctx->key, key, keylen);
+
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
+}
+
+int rk_aes_ecb_encrypt(struct skcipher_request *req)
+{
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
+
+	rctx->mode = RK_CRYPTO_AES_ECB_MODE;
+	return rk_cipher_handle_req(req);
+}
+
+int rk_aes_ecb_decrypt(struct skcipher_request *req)
+{
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
+
+	rctx->mode = RK_CRYPTO_AES_ECB_MODE | RK_CRYPTO_DEC;
+	return rk_cipher_handle_req(req);
+}
+
+int rk_aes_cbc_encrypt(struct skcipher_request *req)
+{
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
+
+	rctx->mode = RK_CRYPTO_AES_CBC_MODE;
+	return rk_cipher_handle_req(req);
+}
+
+int rk_aes_cbc_decrypt(struct skcipher_request *req)
+{
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
+
+	rctx->mode = RK_CRYPTO_AES_CBC_MODE | RK_CRYPTO_DEC;
+	return rk_cipher_handle_req(req);
+}
+
+static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
+{
+	struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(areq);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct scatterlist *sgs, *sgd;
+	int err = 0;
+	int ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int len = areq->cryptlen;
+	unsigned int todo;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.skcipher);
+	struct rk_crypto_dev *rkc = rctx->dev;
+	struct rk_crypto_lli *dd = &rkc->tl[0];
+	u32 m, v;
+	u32 *rkey = (u32 *)ctx->key;
+	u32 *riv = (u32 *)areq->iv;
+	int i;
+	unsigned int offset;
+
+	err = pm_runtime_resume_and_get(rkc->dev);
+	if (err)
+		return err;
+
+	algt->stat_req++;
+	rkc->nreq++;
+
+	m = rctx->mode | RK_CRYPTO_ENABLE;
+	switch (ctx->keylen) {
+	case AES_KEYSIZE_128:
+		m |= RK_CRYPTO_AES_128BIT_key;
+		break;
+	case AES_KEYSIZE_192:
+		m |= RK_CRYPTO_AES_192BIT_key;
+		break;
+	case AES_KEYSIZE_256:
+		m |= RK_CRYPTO_AES_256BIT_key;
+		break;
+	}
+	/* the upper bits are a write enable mask, so we need to write 1 to all
+	 * upper 16 bits to allow write to the 16 lower bits
+	 */
+	m |= 0xffff0000;
+
+	dev_dbg(rkc->dev, "%s %s len=%u keylen=%u mode=%x\n", __func__,
+		crypto_tfm_alg_name(areq->base.tfm),
+		areq->cryptlen, ctx->keylen, m);
+	sgs = areq->src;
+	sgd = areq->dst;
+
+	while (sgs && sgd && len) {
+		ivsize = crypto_skcipher_ivsize(tfm);
+		if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
+			if (rctx->mode & RK_CRYPTO_DEC) {
+				offset = sgs->length - ivsize;
+				scatterwalk_map_and_copy(rctx->backup_iv, sgs,
+							 offset, ivsize, 0);
+			}
+		}
+
+		if (sgs == sgd) {
+			err = dma_map_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
+			if (err != 1) {
+				dev_err(rkc->dev, "Invalid sg number %d\n", err);
+				err = -EINVAL;
+				goto theend;
+			}
+		} else {
+			err = dma_map_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+			if (err != 1) {
+				dev_err(rkc->dev, "Invalid sg number %d\n", err);
+				err = -EINVAL;
+				goto theend;
+			}
+			err = dma_map_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
+			if (err != 1) {
+				dev_err(rkc->dev, "Invalid sg number %d\n", err);
+				err = -EINVAL;
+				dma_unmap_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+				goto theend;
+			}
+		}
+		err = 0;
+		writel(m, rkc->reg + RK_CRYPTO_BC_CTL);
+
+		for (i = 0; i < ctx->keylen / 4; i++) {
+			v = cpu_to_be32(rkey[i]);
+			writel(v, rkc->reg + RK_CRYPTO_KEY0 + i * 4);
+		}
+
+		if (ivsize) {
+			for (i = 0; i < ivsize / 4; i++)
+				writel(cpu_to_be32(riv[i]),
+				       rkc->reg + RK_CRYPTO_CH0_IV_0 + i * 4);
+			writel(ivsize, rkc->reg + RK_CRYPTO_CH0_IV_LEN);
+		}
+		if (!sgs->length) {
+			sgs = sg_next(sgs);
+			sgd = sg_next(sgd);
+			continue;
+		}
+
+		/* The hw support multiple descriptor, so why this driver use
+		 * only one descritor ?
+		 * Using one descriptor per SG seems the way to do and it works
+		 * but only when doing encryption.
+		 * With decryption it always fail on second descriptor.
+		 * Probably the HW dont know how to use IV.
+		 */
+		todo = min(sg_dma_len(sgs), len);
+		len -= todo;
+		dd->src_addr = sg_dma_address(sgs);
+		dd->src_len = todo;
+		dd->dst_addr = sg_dma_address(sgd);
+		dd->dst_len = todo;
+		dd->iv = 0;
+		dd->next = 1;
+
+		dd->user = RK_LLI_CIPHER_START | RK_LLI_STRING_FIRST | RK_LLI_STRING_LAST;
+		dd->dma_ctrl |= RK_LLI_DMA_CTRL_DST_INT | RK_LLI_DMA_CTRL_LAST;
+
+		writel(RK_CRYPTO_DMA_INT_LISTDONE | 0x7F, rkc->reg + RK_CRYPTO_DMA_INT_EN);
+
+		writel(rkc->t_phy, rkc->reg + RK_CRYPTO_DMA_LLI_ADDR);
+
+		reinit_completion(&rkc->complete);
+		rkc->status = 0;
+
+		writel(RK_CRYPTO_DMA_CTL_START | 1 << 16, rkc->reg + RK_CRYPTO_DMA_CTL);
+
+		wait_for_completion_interruptible_timeout(&rkc->complete,
+							  msecs_to_jiffies(10000));
+		if (sgs == sgd) {
+			dma_unmap_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
+		}
+
+		if (!rkc->status) {
+			dev_err(rkc->dev, "DMA timeout\n");
+			err = -EFAULT;
+			goto theend;
+		}
+		if (areq->iv && ivsize > 0) {
+			offset = sgd->length - ivsize;
+			if (rctx->mode & RK_CRYPTO_DEC) {
+				memcpy(areq->iv, rctx->backup_iv, ivsize);
+				memzero_explicit(rctx->backup_iv, ivsize);
+			} else {
+				scatterwalk_map_and_copy(areq->iv, sgd, offset,
+							 ivsize, 0);
+			}
+		}
+		sgs = sg_next(sgs);
+		sgd = sg_next(sgd);
+	}
+theend:
+	writel(0xffff0000, rkc->reg + RK_CRYPTO_BC_CTL);
+	pm_runtime_put_autosuspend(rkc->dev);
+
+	local_bh_disable();
+	crypto_finalize_skcipher_request(engine, areq, err);
+	local_bh_enable();
+	return 0;
+}
+
+int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
+{
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	const char *name = crypto_tfm_alg_name(&tfm->base);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk_crypto_template *algt = container_of(alg, struct rk_crypto_template, alg.skcipher);
+
+	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->fallback_tfm)) {
+		dev_err(algt->dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
+			name, PTR_ERR(ctx->fallback_tfm));
+		return PTR_ERR(ctx->fallback_tfm);
+	}
+
+	tfm->reqsize = sizeof(struct rk_cipher_rctx) +
+		crypto_skcipher_reqsize(ctx->fallback_tfm);
+
+	ctx->enginectx.op.do_one_request = rk_cipher_run;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+void rk_cipher_tfm_exit(struct crypto_skcipher *tfm)
+{
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	memzero_explicit(ctx->key, ctx->keylen);
+	crypto_free_skcipher(ctx->fallback_tfm);
+}
-- 
2.35.1

