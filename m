Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBE63A1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiK1HAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1HAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:00:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BC2DFC;
        Sun, 27 Nov 2022 23:00:17 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d6so15907011lfs.10;
        Sun, 27 Nov 2022 23:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJWjxLIZ+Li8orVpVlkA5rNx5NNvxzopWHGhybrJ+vg=;
        b=Tyb/aNzeI0/O97kORWdBoPLZO+TZxvW1az2Kk+utIvANkQEGC1Jw6dVuplT0gmcUW+
         Hjwdumc6BFqk5p0FWAstJXFvewXzANBRypRYIIP95TB4JflyiM5PTiLuoc7ZlVRhn8NE
         zq3Az0F5N9NqxrfzuJJ8nMx19uRmHNDKKnj8mzLLhBOoWhIeYaCx3w1mxI1VWGrpC5Z/
         yVtdrpZu7vY7yGsLuEUYtqF6+bftMvvOQc6tHpG9Ag3eb/VFYppm+ZBG2n5uPu7cRb17
         /2CeWoXW7CjUaMyf5Z7cwRnuaG1TFSjfOiMMFw6yfmi49YkkGVlcx9EdC8e1lH0f1Gd3
         5I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJWjxLIZ+Li8orVpVlkA5rNx5NNvxzopWHGhybrJ+vg=;
        b=69mZX5JaN01kp+5mc46qERAxcKcWaHBN0BLmAF5yBuM8B9iJXZALwg/LEd1OooIISW
         PzQLaF/EwwO2Bv+Dzn7lXINEr6hp04NKeXCFGLH1xesLyNPp6w/M2Kwi9D41pU2rleyb
         dP6oSZcNTsa4feod/iyuPy32ZxHjF4Xe9iCSta/CZSzG44/rhiWA+3ecwAHVhQ/HpjpN
         Kc0aLuOzOX+BbVf/CHT713slU7EeZAcBI2HS+XFPqCF4jFjG8XON+sHQt5WMdQKv88pe
         9JzM2+1IuYY5kd4hpFVNfqU1/APD7hpNh4ZrbIDav/ZHzUp3AW9a09g5GUQssOlwsVTE
         1pGQ==
X-Gm-Message-State: ANoB5pmlC8ntMwnKH24OOYZcJkA2QAwUNPetl9bn0iN73xHlebP99RNL
        hnQ/bG1zJx4eqTu648adGQU=
X-Google-Smtp-Source: AA0mqf6MDwAz9//kkzdVgCtw2+Ffvol7C4TGrXdX4s+wwD0HRr9r+8MCg2EpImrmXN6Xn32kNpiJSg==
X-Received: by 2002:a19:6b1a:0:b0:4b4:3313:feaf with SMTP id d26-20020a196b1a000000b004b43313feafmr16169443lfa.365.1669618816051;
        Sun, 27 Nov 2022 23:00:16 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e780c000000b002770a7e320esm1129686ljc.81.2022.11.27.23.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 23:00:15 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] nvmem: u-boot-env: reformat MAC in "ethaddr" cell when reading
Date:   Mon, 28 Nov 2022 07:59:23 +0100
Message-Id: <20221128065923.1180-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128065923.1180-1-zajec5@gmail.com>
References: <20221128065923.1180-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVMEM consumers expect MAC in a byte-based format (see e.g.
nvmem_get_mac_address()). U-Boot environment data stores all values in
ASCII form.

Add post processing callback detecting "ethaddr" reads and reformat data
as expected. This fixes Ethernet drivers reading MAC from NVMEM devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: select GENERIC_NET_UTILS & drop unused "priv" variable
---
 drivers/nvmem/Kconfig      |  1 +
 drivers/nvmem/u-boot-env.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 755f551426b5..34fb0ba36b80 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -326,6 +326,7 @@ config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
 	select CRC32
+	select GENERIC_NET_UTILS
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 2a87dda45188..e30ce4f7ea20 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
@@ -70,6 +72,22 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int u_boot_env_cell_post_process(void *context, struct nvmem_cell_entry *cell,
+					const char *id, void *buf, size_t *len)
+{
+	if (!strcmp(cell->name, "ethaddr")) {
+		u8 mac[ETH_ALEN];
+
+		if (mac_pton(buf, mac)) {
+			ether_addr_copy(buf, mac);
+			if (len)
+				*len = ETH_ALEN;
+		}
+	}
+
+	return 0;
+}
+
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
@@ -179,6 +197,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct nvmem_config config = {
 		.name = "u-boot-env",
 		.reg_read = u_boot_env_read,
+		.cell_post_process = u_boot_env_cell_post_process,
 	};
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-- 
2.34.1

