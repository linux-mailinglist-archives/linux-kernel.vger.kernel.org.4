Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588E169FA12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjBVRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBVRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:23:24 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6982DBE4;
        Wed, 22 Feb 2023 09:23:22 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a10so8674568ljq.1;
        Wed, 22 Feb 2023 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSnsOpv8KS0rCS6ksY5VSkRcczl5vnYaXjWVVff7kGI=;
        b=DEqh460Bb4lDxi7itAAchy/jrIh1Oa/jWaYu4Nx7cgDY96x8jDagi1unEus9USivCe
         hnkt0DAxuUro+wf1TVDiaPwef0RpD0ZP0ZUI8XqdpEPHbmWx56WXNhJwjrTSTcFh9L81
         l9UdDjbAjJrPEQiIYw4C5tm5ibZkYM/+w/O51saS4ht8gDwJkU4o9D3Z6RpPtAhUnaWp
         XsuVGK3z0vNMtxihXuJ7DqtCo0g3x7kxtzvmUU74ztWEhfW5e7JLrAaE4tOs8EIf9lqf
         gOyOJeMDeRctrIJkNNsQLdgto+hJ4uQKSybCQG8NcK8wJBT3zd7HMfpr/tJ62VAC4HpK
         zZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSnsOpv8KS0rCS6ksY5VSkRcczl5vnYaXjWVVff7kGI=;
        b=dBOt0yK5WPfqIv02p8jVK7Qu42kaSEoeb5RcYf2nC+6MTd3RHypxnKkiAo+sxSnY8Q
         rOywXb494Plba72Ig2B9t4oKv28zNkGBsMzbz/sGAeTn4+UOg3K/bR+KpFrEwwZX95wM
         K3M0oQauhPMyrCxEEUSJsZT1tpZ6FA3mQc6mOMOl95qp2ZtFR19cUw8eW3YMDwzuU90+
         I9v8fLxr3tqyovh7cHQCBruFSYRGVEM1Yx7W7Ngzie8z2eXuDYkjsAdF2OhbzH4Vt9TJ
         J3aVezXPdS8sPblhBgo8h3AeQ5m2vfGr7ZS2TMssDUawG4n/RJqgNcGDGqLhCo8eXfpA
         pIEQ==
X-Gm-Message-State: AO0yUKXcd0N9PETdXBpHwO+uHUvi5+j4qcEOTwUXitzQH0ZyCW8yYTz7
        xejy2ODH1Tqz2rjRf1AqJCqeidfGQ5ZZSw==
X-Google-Smtp-Source: AK7set8ci3FrIvgl9vUPXevbFYj2J3UGpD1jWl8kUSJoUcZ0ZOiGOLUbvHQ4ZGdGUqeYXnal0wky2g==
X-Received: by 2002:a05:651c:50f:b0:293:4fff:422e with SMTP id o15-20020a05651c050f00b002934fff422emr4780096ljp.16.1677086602368;
        Wed, 22 Feb 2023 09:23:22 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e93c2000000b0029477417d80sm721513ljh.85.2023.02.22.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:23:21 -0800 (PST)
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
Subject: [PATCH 4/4] nvmem: u-boot-env: post-process "ethaddr" env variable
Date:   Wed, 22 Feb 2023 18:22:45 +0100
Message-Id: <20230222172245.6313-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222172245.6313-1-zajec5@gmail.com>
References: <20230222172245.6313-1-zajec5@gmail.com>
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
 drivers/nvmem/u-boot-env.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 189ea85bd67d..71322ea7cf53 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -346,6 +346,7 @@ config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
 	select CRC32
+	select GENERIC_NET_UTILS
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 29b1d87a3c51..1f5d8aba98bf 100644
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
@@ -70,6 +72,27 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void **data, size_t *bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (*bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(*data, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	/* We need *smaller* buffer so don't bother to krealloc() */
+	ether_addr_copy(*data, mac);
+	*bytes = ETH_ALEN;
+
+	return 0;
+}
+
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
@@ -101,6 +124,8 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		if (!strcmp(var, "ethaddr"))
+			priv->cells[idx].read_post_process = u_boot_env_read_post_process_ethaddr;
 	}
 
 	if (WARN_ON(idx != priv->ncells))
-- 
2.34.1

