Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695865F275
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjAERTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjAERSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:18:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F35C90D;
        Thu,  5 Jan 2023 09:11:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i9so53629905edj.4;
        Thu, 05 Jan 2023 09:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaNtjFyAXugDAWX/bR32Dva5wigb85ST8Ayk+tDoGms=;
        b=Jc/IGmb5ZhCXE5QR+3vxXRLGLCxIDNy2+fy0f2wmt8y0c9AMwje0Uo+hYkNeWMSZMR
         DxiFw3QRh2bqGnGySwQK2GRJHcvJ6kcg4eJzLbRmcpyP5WSiY71zRV8A8aRv9fUN1hZu
         gdhDQKZSNSoa05nkLCVrvZLUoxG+0Gf/Y48w/QhMqbA09GTpYUUhki0MN/CRE6vNYTMR
         /ykxnHm9vtwZqAzTTuFU1kAmAHysvdf97xqQdGDZXWBTYF4mz8BKIQVrX3dnc1G73RC/
         zLdR2FQK3JxOZo74xaVXkzq91PzMowGeYVWhuSJqlrvTRYRnSctpYjxogelIlyCXbXpa
         NaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaNtjFyAXugDAWX/bR32Dva5wigb85ST8Ayk+tDoGms=;
        b=CThrm4Qg6CCq18ID+lqb0AFwnT55HWmOox+roUc0ipEsPtS7GtCOGBA7cpTrnfznTC
         EHFGvhdBI5waPon+DJVWlESWJeu94sJWPfAiPUtuggvYWXogNidEEGKGIjKb1foqnQoR
         BculdsgiJ8XMXa8cZvH3M5RkSJTge4qwi6Do7DemV2rydEj7XBgCSGQw2kpV/qKf0Nt4
         ibXcnWqXdR0LNwO8dD6JVHpMsZtqxCnIN0mEIC7zsJoY79qvAyVDChmV2+O5M6A4xogW
         Cc9Zw9X+sgvXqQ8w3LeINS2gUJJRhl05MaNYJ/dw4FbcGawNXuMKrExK4v6EeCC64ytZ
         N1SQ==
X-Gm-Message-State: AFqh2ko8hJISE/BlPW7u/+wF9dUKMVaSlnv9K4YqaGC4pXsMwKgzvDtK
        lS2+kcuMa3iD9M2Jk+M26vc=
X-Google-Smtp-Source: AMrXdXv5zDOsStIlsnwT9M02nEHELn4C8qBhZMwS49BaMy0TTTD9iNc3SDUbaUdl9yMz/XOGOycK+w==
X-Received: by 2002:a05:6402:2072:b0:487:6d4a:444c with SMTP id bd18-20020a056402207200b004876d4a444cmr26202520edb.28.1672938667401;
        Thu, 05 Jan 2023 09:11:07 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id cn9-20020a0564020ca900b0048fdf37c441sm1714829edb.3.2023.01.05.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:11:06 -0800 (PST)
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
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] nvmem: u-boot-env: post process "ethaddr" env variable
Date:   Thu,  5 Jan 2023 18:10:38 +0100
Message-Id: <20230105171038.13649-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105171038.13649-1-zajec5@gmail.com>
References: <20230105171038.13649-1-zajec5@gmail.com>
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
 drivers/nvmem/u-boot-env.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 2a87dda45188..54283f8061b0 100644
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
@@ -70,6 +72,26 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void *data, size_t *bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (*bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(data, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(data, mac);
+	*bytes = ETH_ALEN;
+
+	return 0;
+}
+
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
@@ -101,6 +123,8 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		if (!strcmp(var, "ethaddr"))
+			priv->cells[idx].read_post_process = u_boot_env_read_post_process_ethaddr;
 	}
 
 	if (WARN_ON(idx != priv->ncells))
-- 
2.34.1

