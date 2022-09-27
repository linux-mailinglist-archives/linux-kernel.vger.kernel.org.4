Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5A5EBCC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiI0IIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiI0IHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:07:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A3107582
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l18so1712636wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=66ISj6OAwBdZy2WsaubsZZCEn9jiwURYi2fgqCIpC8s=;
        b=1mqntLJxFl8NL2Eg+2hgPmHlQC9P332VFuEA4I5cg7lCW8RiNRotgeet1cvFVizxT7
         Lnw2h3k1leHID1TT7fALHv5NVlS77N+oOVIooyILUJPpq0e4DpVxiq6RtylXUGaH4x3l
         NH3CetRm4L+2bMxE67XiVAaclpmbFuYpubyXxywFvK5BqG8pgIeH6s7hmUVCZjj4jTpe
         L5JnGg1/Bs+VKCl2gI44hO2/0TjpGO+rLt1XPBBgW0+M4u6R3ZMIU86Dp1l3yh6z6nPJ
         lNKulyDwWNx275A3Vd0lLOz7B4837DbEsuozSM4/z4o0SvC9bxWE+iUbGu/xIlG8H0dO
         Zy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=66ISj6OAwBdZy2WsaubsZZCEn9jiwURYi2fgqCIpC8s=;
        b=QNbDaQ0DkIl2x/AM4YAQKBHjL2KwaVdRmYX8zIv3E67UZ7BbKRnkJUh9IbgABQIrK2
         Ifo6dYvHj9L8NJdumfwz14FzmiHlDStqxByMqlVzrii+reOIn8rxlMIFTT2HX+q5h6lB
         i1MpT0Fr5UaaazhZZS8Ri4Gycp64St3JWRlur2q3HnADmCJ8t5FGVT79H76B6ZZ4b+Lr
         KvaERrOWISA6+Q7IalK6F6081yh4TTSFwK85+UXcm/O6g2QRcCu2WTUB+ucZFizmt8oK
         VGW3cvOIPRWJ8bIvSAsPv4aFh4bJ9qZV+1qjpYWyd5Fs0ZViqnOOg41Z0axxwxNbQ+po
         wAiw==
X-Gm-Message-State: ACrzQf1n3qbJl1hf/NHWjA6RYM8CAtRJfwDxSxQj9MRtsqwwQdzoDcWA
        5aUhJ2KO+JFmQW3AHRyn9mSYbg==
X-Google-Smtp-Source: AMsMyM44jzPbkv/qWHVlKZx1LuvcjcsjkuXaATAdw37jBdECmPALd0aMe5J1f3w/V2LKB3PJT3Zdzg==
X-Received: by 2002:a05:6000:1f9d:b0:22a:fc9b:435c with SMTP id bw29-20020a0560001f9d00b0022afc9b435cmr15644239wrb.667.1664265667657;
        Tue, 27 Sep 2022 01:01:07 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p4-20020a1c5444000000b003a5c7a942edsm13357199wmi.28.2022.09.27.01.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:01:07 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT 1/5] crypto: rockchip: move kconfig to its dedicated directory
Date:   Tue, 27 Sep 2022 08:00:44 +0000
Message-Id: <20220927080048.3151911-2-clabbe@baylibre.com>
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

Move all rockchip kconfig in its own subdirectory.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig          | 32 ++------------------------------
 drivers/crypto/Makefile         |  2 +-
 drivers/crypto/rockchip/Kconfig | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 31 deletions(-)
 create mode 100644 drivers/crypto/rockchip/Kconfig

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 2947888d3b82..96c5b8060db0 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -646,6 +646,8 @@ config CRYPTO_DEV_QCOM_RNG
 	  To compile this driver as a module, choose M here. The
 	  module will be called qcom-rng. If unsure, say N.
 
+source "drivers/crypto/rockchip/Kconfig"
+
 config CRYPTO_DEV_VMX
 	bool "Support for VMX cryptographic acceleration instructions"
 	depends on PPC64 && VSX
@@ -666,36 +668,6 @@ config CRYPTO_DEV_IMGTEC_HASH
 	  hardware hash accelerator. Supporting MD5/SHA1/SHA224/SHA256
 	  hashing algorithms.
 
-config CRYPTO_DEV_ROCKCHIP
-	tristate "Rockchip's Cryptographic Engine driver"
-	depends on OF && ARCH_ROCKCHIP
-	depends on PM
-	select CRYPTO_ECB
-	select CRYPTO_CBC
-	select CRYPTO_DES
-	select CRYPTO_AES
-	select CRYPTO_ENGINE
-	select CRYPTO_LIB_DES
-	select CRYPTO_MD5
-	select CRYPTO_SHA1
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	select CRYPTO_SKCIPHER
-
-	help
-	  This driver interfaces with the hardware crypto accelerator.
-	  Supporting cbc/ecb chainmode, and aes/des/des3_ede cipher mode.
-
-config CRYPTO_DEV_ROCKCHIP_DEBUG
-	bool "Enable Rockchip crypto stats"
-	depends on CRYPTO_DEV_ROCKCHIP
-	depends on DEBUG_FS
-	help
-	  Say y to enable Rockchip crypto debug stats.
-	  This will create /sys/kernel/debug/rk3288_crypto/stats for displaying
-	  the number of requests per algorithm and other internal stats.
-
-
 config CRYPTO_DEV_ZYNQMP_AES
 	tristate "Support for Xilinx ZynqMP AES hw accelerator"
 	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 116de173a66c..7a9c627a09c6 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_CRYPTO_DEV_PPC4XX) += amcc/
 obj-$(CONFIG_CRYPTO_DEV_QAT) += qat/
 obj-$(CONFIG_CRYPTO_DEV_QCE) += qce/
 obj-$(CONFIG_CRYPTO_DEV_QCOM_RNG) += qcom-rng.o
-obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
+obj-y += rockchip/
 obj-$(CONFIG_CRYPTO_DEV_S5P) += s5p-sss.o
 obj-$(CONFIG_CRYPTO_DEV_SA2UL) += sa2ul.o
 obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
diff --git a/drivers/crypto/rockchip/Kconfig b/drivers/crypto/rockchip/Kconfig
new file mode 100644
index 000000000000..1010d897d9ef
--- /dev/null
+++ b/drivers/crypto/rockchip/Kconfig
@@ -0,0 +1,28 @@
+config CRYPTO_DEV_ROCKCHIP
+	tristate "Rockchip's Cryptographic Engine driver"
+	depends on OF && ARCH_ROCKCHIP
+	depends on PM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_DES
+	select CRYPTO_AES
+	select CRYPTO_ENGINE
+	select CRYPTO_LIB_DES
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	select CRYPTO_SKCIPHER
+
+	help
+	  This driver interfaces with the hardware crypto accelerator.
+	  Supporting cbc/ecb chainmode, and aes/des/des3_ede cipher mode.
+
+config CRYPTO_DEV_ROCKCHIP_DEBUG
+	bool "Enable Rockchip crypto stats"
+	depends on CRYPTO_DEV_ROCKCHIP
+	depends on DEBUG_FS
+	help
+	  Say y to enable Rockchip crypto debug stats.
+	  This will create /sys/kernel/debug/rk3288_crypto/stats for displaying
+	  the number of requests per algorithm and other internal stats.
-- 
2.35.1

