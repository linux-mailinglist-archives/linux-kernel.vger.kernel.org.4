Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9E6BFBC7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCRROa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCRROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:14:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567AB149AA;
        Sat, 18 Mar 2023 10:14:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a32so8135833ljr.9;
        Sat, 18 Mar 2023 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679159660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6gVXR7MyV0dGeKTkzI0XUj6QXrFR6902YeCKHs1ZQM=;
        b=mdenNH8Nyexs6YyB62R/BZLhJHWiUS4++a1cZgCzO3QzqQ13iScjbNS8+W9Nxo9Z9o
         nScggbnS6OkYgx2/QfjKc9S82cp+l+kNMyaGGh0C1QAyLO0d8SUZcgcMTIEaNmChWl6v
         u1Hs51u4M9GmZ+BAZRYB+F5sYcp6/ZoiDnI07OOR1QmpifluKrnBqpFdiLZbjQnpnaU4
         de2By0/MmkKVHh0Wjm45cKM6/zOGETPSD4zkBo/LghjDi4FI6Hq1r+g+K93M57C/YAFT
         JaoT2+1axMz5zCIHevO/igMIB7A+U4i3J4UBjIojSr1foZN5eFiLKDU4VO6jrPi7amJg
         f1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679159660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6gVXR7MyV0dGeKTkzI0XUj6QXrFR6902YeCKHs1ZQM=;
        b=Qwbj0opkqzxaFimEAWluWj9UjWU8nd/uhbKmCdrKIK62jeASoDoFUN/Zr3mv8meusD
         HkTmCfYz7vzyykDstFhGlvUmqPbrIjjfWGVFjzyEEzMMuIAig9T2e62ZWHmwKYH7/KSU
         79w/OIWy+2+spgN0hedtpl5iw1ZIr+rS9Tw1DBoj+C8zy4oiEZIvOzuGnubUBIU11TVk
         YOOpxjowkiWe1Pfn9UDa5JHkDaMfwGODfRraY08J1W/aRkEEg4O9T1nX2U+sTWq0W6Tk
         Eh1Bwk7ttxbFMjjw+lKyQQQhbq/RrdRM4gPT70HQgWaR8jHUqVOC3BTC63lXBl51jRjB
         wkug==
X-Gm-Message-State: AO0yUKU75/te4mKybJn00AX6gkTtwmbdjgzx7ti0G/BCdCT5yTHJVKw1
        pJsOVg0K1+um+Ceb9aG4sdA=
X-Google-Smtp-Source: AK7set8khjgdJDLOjsL60JsKr969nfrsBSBbcfsEBMv6ZZISnKH1yfHmoQD7kzYtX9KchAV/GxaTnA==
X-Received: by 2002:a2e:7d15:0:b0:298:b065:c29b with SMTP id y21-20020a2e7d15000000b00298b065c29bmr4403516ljc.38.1679159660245;
        Sat, 18 Mar 2023 10:14:20 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e80c9000000b0029573844d03sm929221ljg.109.2023.03.18.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:14:19 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] nvmem: u-boot-env: post-process "ethaddr" env variable
Date:   Sat, 18 Mar 2023 18:13:56 +0100
Message-Id: <20230318171356.29515-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318171356.29515-1-zajec5@gmail.com>
References: <20230318171356.29515-1-zajec5@gmail.com>
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

U-Boot environment variables are stored in ASCII format so "ethaddr"
requires parsing into binary to make it work with Ethernet interfaces.

This includes support for indexes to support #nvmem-cell-cells = <1>.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/Kconfig      |  1 +
 drivers/nvmem/u-boot-env.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index a2afba11c890..b291b27048c7 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -340,6 +340,7 @@ config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
 	select CRC32
+	select GENERIC_NET_UTILS
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 29b1d87a3c51..ee9fd9989b6e 100644
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
@@ -70,6 +72,25 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void *buf, size_t bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(buf, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(buf, mac);
+
+	return 0;
+}
+
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
@@ -101,6 +122,11 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		if (!strcmp(var, "ethaddr")) {
+			priv->cells[idx].raw_len = strlen(value);
+			priv->cells[idx].bytes = ETH_ALEN;
+			priv->cells[idx].read_post_process = u_boot_env_read_post_process_ethaddr;
+		}
 	}
 
 	if (WARN_ON(idx != priv->ncells))
-- 
2.34.1

