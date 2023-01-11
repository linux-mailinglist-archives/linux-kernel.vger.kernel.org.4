Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA9665532
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAKHbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbjAKHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:31:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F7C76A;
        Tue, 10 Jan 2023 23:31:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j16so21067663edw.11;
        Tue, 10 Jan 2023 23:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZG5/dJfEvlfksUEy4dZqlxkQUvfDpGnkVNpt/A8DFM=;
        b=L7tzBu0DFenwt3+uzh4aGNJXZrLz9+JI73DKhb1jKJJPerJQP4FXl+Nka8fNjQzWPy
         3aywNKLauxX1cB4gN8yKBq69FHT8fNTE+J2/++uYpGvCf3dSzEetjSXixny8rXJgE5Xq
         oo9PI6kahvQTLhucbBFTGwTqwTFnuxVyS6OFcIumGzsj1Ybv4jRx08kxWWOzygLKpiAk
         7nlKGTNB+GRBqzg6r+K6bltbOAQ0tHJnctOvJmjpu/+pEdPtwtkAqxpG072S4zoPP66v
         nx+c/09bgi9sLhCWoZof+AAQtzbyT3CJiZhye8S6jtuvlE07aG2P3e9FxFUFiSW8ukS6
         PWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZG5/dJfEvlfksUEy4dZqlxkQUvfDpGnkVNpt/A8DFM=;
        b=8ILzlPluDnq+4TKJ7QPAtdLNLtphxVY6qX9DH8E9iM4fn08ho0jzVZDlo7xOgL51dr
         nfqNay7PpiOp58Lg3vr+RewaA7gAMfjpVN78WbzbGWvA91j8tCmKkWPLrGUwnYp/XNFG
         YwvOpSWj6cLMsYS3F/TEDhtV+g2WU+BnLxmT3h3Yg3n27A+mOvMhlQ9DJB2MjOtbpfR+
         mz27I2InWTNlDtqTS2Z+IYuG8/EWKJFj+O087CeY3Kfoy6r6DmDHSya0xocu5fU/p3uV
         aHz8oazM3FvtukKVIXDMkM4e9NH3filVUiJi1siw1Ib84ftSMzmTnXQpM07iV4u+cjuP
         l9Tw==
X-Gm-Message-State: AFqh2krQsdRjS2NCqHEpV8NTLgSKuvVZhE84mXRx7u4AGS9QvpOtV651
        QL5uCSY6u74FleIV6r5Q6CE=
X-Google-Smtp-Source: AMrXdXviRWemoxJeyz2j5A2MJA1bIBH5p+F2cAyWLSNk5iJigeCylpmCPfufczACWXrlMLnmM2wjbA==
X-Received: by 2002:a50:eac6:0:b0:461:d042:80db with SMTP id u6-20020a50eac6000000b00461d04280dbmr61859126edp.0.1673422284520;
        Tue, 10 Jan 2023 23:31:24 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id ed6-20020a056402294600b00499e5659988sm593193edb.68.2023.01.10.23.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 23:31:24 -0800 (PST)
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
Subject: [PATCH V2 6/6] nvmem: u-boot-env: post process "ethaddr" env variable
Date:   Wed, 11 Jan 2023 08:31:02 +0100
Message-Id: <20230111073102.8147-6-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111073102.8147-1-zajec5@gmail.com>
References: <20230111073102.8147-1-zajec5@gmail.com>
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
 drivers/nvmem/layouts/Kconfig      |  1 +
 drivers/nvmem/layouts/u-boot-env.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 8a38c514943a..566b4f25630d 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -23,6 +23,7 @@ config NVMEM_LAYOUT_ONIE_TLV
 config NVMEM_LAYOUT_U_BOOT_ENV
 	bool "U-Boot environment variables support"
 	select CRC32
+	select GENERIC_NET_UTILS
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 95c314553952..e99b853a44c4 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -36,6 +38,27 @@ struct u_boot_env_image_broadcom {
 	uint8_t data[];
 } __packed;
 
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
 static int u_boot_env_parse_data(struct device *dev, struct nvmem_device *nvmem, uint8_t *buf,
 				 size_t data_offset, size_t data_len)
 {
@@ -67,6 +90,8 @@ static int u_boot_env_parse_data(struct device *dev, struct nvmem_device *nvmem,
 		info.offset = data_offset + value - data;
 		info.bytes = strlen(value);
 		info.np = of_get_child_by_name(np, info.name);
+		if (!strcmp(var, "ethaddr"))
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
 
 		err = nvmem_add_one_cell(nvmem, &info);
 		if (err) {
-- 
2.34.1

