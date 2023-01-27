Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39867E5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjA0M5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjA0M5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:57:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34EB7D28E;
        Fri, 27 Jan 2023 04:57:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m12so4658716edq.5;
        Fri, 27 Jan 2023 04:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZG5/dJfEvlfksUEy4dZqlxkQUvfDpGnkVNpt/A8DFM=;
        b=EX3d7D9gnItYT1rU6c/kJyqXPYfLJK0VS58ySEa8KxtMm+SfJqn3lQxVk09N6+0cCT
         kl8DduwQd8D+ta6lsxIUn3FaKKsR28tvCVCEu4JyFLzf8ukjn5p7JwgZLFzTLpIkcomx
         3hfIzFHnvUquZFohcnL7uBSbixlVbDLaTK0t2Q71quau437fCyVkKwgx0o8TtvwfgG1J
         rfxZsv5iSj9m9br8IPfIi4MVeiwAwFTg6CIYcp/sksPUHqu49wiFIWu9urk0YoHrriqm
         sXnvzEKRBBSRtlp3I6E2j4S8O2l91TxyyS7G+rPgV84RWPNAnwFNimu4IOaXMgPS+0jt
         Wecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZG5/dJfEvlfksUEy4dZqlxkQUvfDpGnkVNpt/A8DFM=;
        b=6uK4ehbU2/VMrQMQRFoqsigZMq0MXghwLi1+uLOKjKh2JzqvCQT4FvT3M7NLoJJdT8
         +4N/N5AUq6S8DGo3cZ+X3fac4ygPVlBX+hl8+pNGRd4LrHx4/vK4O32vw/wr/5R+m5CD
         6c+5ILeeJ3/D6oFZS4HqIXdWWj0I13W2C7yl8SJdwI4b0KEaM4f3jxv8oOTSMaLCz9gb
         oDQCVxf57Spmh3ZVK7NzCK7vfpZ32e8lb5EAf7NPT5Ps0nAkp2x13pQ5viBqHH18ZtsK
         LRm/Q4HuER8MbUuf4uVO9V9SKC3XVVCnuERHTXOOEfPkf7lmXrk9YsZ7BvWii1cPaoaR
         Adng==
X-Gm-Message-State: AFqh2kqU/T5Quh3cTk02ENLIw1fhS7BQAPUwBOox5c3w8j7XYB2yGASB
        AaB5iLriftZ/w11mxAkcM4U=
X-Google-Smtp-Source: AMrXdXs9hkTQoMtsQj/q7bK+0hqEGX45N2hOmMzacl7O03MEP6FYZIiUlc8wIjtyjmskicMgm3eMPg==
X-Received: by 2002:a50:ff12:0:b0:492:8c77:7da9 with SMTP id a18-20020a50ff12000000b004928c777da9mr37459278edu.9.1674824250105;
        Fri, 27 Jan 2023 04:57:30 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402358500b00482e0c55e2bsm2248136edc.93.2023.01.27.04.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:57:29 -0800 (PST)
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
Subject: [PATCH V3 6/6] nvmem: u-boot-env: post process "ethaddr" env variable
Date:   Fri, 27 Jan 2023 13:57:09 +0100
Message-Id: <20230127125709.32191-6-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127125709.32191-1-zajec5@gmail.com>
References: <20230127125709.32191-1-zajec5@gmail.com>
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

