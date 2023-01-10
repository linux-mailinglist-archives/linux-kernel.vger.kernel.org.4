Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D51663EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbjAJKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjAJKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1B1409F;
        Tue, 10 Jan 2023 02:54:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fc4so27488415ejc.12;
        Tue, 10 Jan 2023 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAqYvgRzLQ4rzA87QLNuurx0Mvg1Ygp2KEVQbcFxer4=;
        b=SJ7SFb8lSmxhm2NTUJn6edKXr2E6ocnaCm828IPBngsZmWq1fx4++PuFndDgKs7qoL
         Cyp2n6vHrRXFGBeDGFTSzfitsjvkIihjc0zpjySshruHuZQGaE4aktnpf/fPhTopvdjx
         qoJLiT5pX5fxUblFYSWoItSQwavPoqv+8cNMN4/Z7hrRk+D8Uk+rTTfYgKqjTGFzrrJd
         04KdQuFJqsa+VHF9irSvMGFn01TYJf06NLJZbGHj5wRcOQcvZ61+Fvk0gG02XTsjvuLx
         upYWU7na/qKc2fHeox3X0iUXzhxEjK1xfCpQZ9pnw1Y+ZXeD8fre8eiRWY4QJIAjyZ+O
         N+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAqYvgRzLQ4rzA87QLNuurx0Mvg1Ygp2KEVQbcFxer4=;
        b=joMd54O3jtxH5ZYAGkG9m7o5deJdPb/MH97YGeP+HZB18ivXN3vjCuSzNx0+bNNvND
         028Lmpxw0YAIIYfJuuzqGYVE8rSotDy3SS5WRWVL8LAKYqKDUAt5U6GjO3V4hM/16PMP
         6gULftBwcXdQ9+50K2ArJtZL1c6bbWqgxMdkOKQk93GX7JHKkugZ4a/bW9/xeW6vQ6Yb
         aB4xnbaJIaaJvuXif7SFpjo1DpiAoXbEzF5D6HP5M6QEO5dvcQOVT8RwsvIslc+gvcHu
         647s+YcSUAq5A1sp8Aj1qOqpsCeL/ye6XpLKgG80zUOPLJ9FlJIUJIWwe+jiqapik0rD
         Zr0Q==
X-Gm-Message-State: AFqh2ko/hRiqPzeVpEHvE82OcD5d3X2Ttcyj9ZHhrqVm6iUGWpB+LTJJ
        ElI8Fph8M0FKR+HSbKfjfwQ=
X-Google-Smtp-Source: AMrXdXur9POe208kdUVnqB2kY9qDlv0+hMyxhP8CXXFsMHUuSjJmZ80rZEFvMyJE2kSVSIcX8Ezf1g==
X-Received: by 2002:a17:906:5202:b0:7c1:4a3:10b6 with SMTP id g2-20020a170906520200b007c104a310b6mr56805461ejm.53.1673348083920;
        Tue, 10 Jan 2023 02:54:43 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm4818199edr.32.2023.01.10.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:54:43 -0800 (PST)
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
Subject: [PATCH 6/6] nvmem: u-boot-env: post process "ethaddr" env variable
Date:   Tue, 10 Jan 2023 11:54:25 +0100
Message-Id: <20230110105425.13188-6-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
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
 drivers/nvmem/layouts/u-boot-env.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

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
index 95c314553952..63baeb18bd56 100644
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
@@ -36,6 +38,26 @@ struct u_boot_env_image_broadcom {
 	uint8_t data[];
 } __packed;
 
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
 static int u_boot_env_parse_data(struct device *dev, struct nvmem_device *nvmem, uint8_t *buf,
 				 size_t data_offset, size_t data_len)
 {
@@ -67,6 +89,8 @@ static int u_boot_env_parse_data(struct device *dev, struct nvmem_device *nvmem,
 		info.offset = data_offset + value - data;
 		info.bytes = strlen(value);
 		info.np = of_get_child_by_name(np, info.name);
+		if (!strcmp(var, "ethaddr"))
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
 
 		err = nvmem_add_one_cell(nvmem, &info);
 		if (err) {
-- 
2.34.1

