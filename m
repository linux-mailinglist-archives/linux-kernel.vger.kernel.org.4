Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21876644D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLFUI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLFUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:58 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C192FC26;
        Tue,  6 Dec 2022 12:07:56 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C8F6E3BC9;
        Tue,  6 Dec 2022 21:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PB/NBD6nl2FVxdhufUcH2eKTgfvjlle8iT4ntIbVN0Y=;
        b=RwBxKOeiHvTIYT4ZCIORPh1Gs+CYgNtYxhVfJSZTKRIVb66P6CsWw6ph1HkrFLKtqp/SYc
        YV9OBFVZM4Ex/t9Fv11+FBeJjGKXTAepws0aQgMYwjTKrxFV1anwV6W6KpIRMF+YPQMvTW
        oV7Gt03AJFMLFmuzl94GyLLhnYxm97LkPQOwE4pa0J4KgQZco1mTubCdazI6FRaZR7xHJU
        CqMFmVHZSqqFCrq2kMmsBgc6aysQGpxLBuIieC3ChlqYDf9N5XszW9Gsf7YWP3GJkziVfv
        aR9deq8Pc2fNyLjS3mLBK2PT/BrLBxAUAaAkkrEuwPhyxOa7jRSb2ZWCRq6yDg==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v5 18/21] nvmem: layouts: add sl28vpd layout
Date:   Tue,  6 Dec 2022 21:07:37 +0100
Message-Id: <20221206200740.3567551-19-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206200740.3567551-1-michael@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This layout applies to the VPD of the Kontron sl28 boards. The VPD only
contains a base MAC address. Therefore, we have to add an individual
offset to it. This is done by taking the second argument of the nvmem
phandle into account. Also this let us checking the VPD version and the
checksum.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v4:
 - none

changes since v3:
 - none

changes since v2:
 - use of_nvmem_layout_get_container()

changes since v1:
 - none

 drivers/nvmem/layouts/Kconfig   |   9 ++
 drivers/nvmem/layouts/Makefile  |   2 +
 drivers/nvmem/layouts/sl28vpd.c | 153 ++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9ad3911d1605..75082f6b471d 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -2,4 +2,13 @@
 
 menu "Layout Types"
 
+config NVMEM_LAYOUT_SL28_VPD
+	bool "Kontron sl28 VPD layout support"
+	select CRC8
+	help
+	  Say Y here if you want to support the VPD layout of the Kontron
+	  SMARC-sAL28 boards.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 6fdb3c60a4fa..fc617b9e87d0 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -2,3 +2,5 @@
 #
 # Makefile for nvmem layouts.
 #
+
+obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
new file mode 100644
index 000000000000..a36800f201a3
--- /dev/null
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/crc8.h>
+#include <linux/etherdevice.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <uapi/linux/if_ether.h>
+
+#define SL28VPD_MAGIC 'V'
+
+struct sl28vpd_header {
+	u8 magic;
+	u8 version;
+} __packed;
+
+struct sl28vpd_v1 {
+	struct sl28vpd_header header;
+	char serial_number[15];
+	u8 base_mac_address[ETH_ALEN];
+	u8 crc8;
+} __packed;
+
+static int sl28vpd_mac_address_pp(void *priv, const char *id, int index,
+				  unsigned int offset, void *buf,
+				  size_t bytes)
+{
+	if (bytes != ETH_ALEN)
+		return -EINVAL;
+
+	if (index < 0)
+		return -EINVAL;
+
+	if (!is_valid_ether_addr(buf))
+		return -EINVAL;
+
+	eth_addr_add(buf, index);
+
+	return 0;
+}
+
+static const struct nvmem_cell_info sl28vpd_v1_entries[] = {
+	{
+		.name = "serial-number",
+		.offset = offsetof(struct sl28vpd_v1, serial_number),
+		.bytes = sizeof_field(struct sl28vpd_v1, serial_number),
+	},
+	{
+		.name = "base-mac-address",
+		.offset = offsetof(struct sl28vpd_v1, base_mac_address),
+		.bytes = sizeof_field(struct sl28vpd_v1, base_mac_address),
+		.read_post_process = sl28vpd_mac_address_pp,
+	},
+};
+
+static int sl28vpd_v1_check_crc(struct device *dev, struct nvmem_device *nvmem)
+{
+	struct sl28vpd_v1 data_v1;
+	u8 table[CRC8_TABLE_SIZE];
+	int ret;
+	u8 crc;
+
+	crc8_populate_msb(table, 0x07);
+
+	ret = nvmem_device_read(nvmem, 0, sizeof(data_v1), &data_v1);
+	if (ret < 0)
+		return ret;
+	else if (ret != sizeof(data_v1))
+		return -EIO;
+
+	crc = crc8(table, (void *)&data_v1, sizeof(data_v1) - 1, 0);
+
+	if (crc != data_v1.crc8) {
+		dev_err(dev,
+			"Checksum is invalid (got %02x, expected %02x).\n",
+			crc, data_v1.crc8);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem,
+			     struct nvmem_layout *layout)
+{
+	const struct nvmem_cell_info *pinfo;
+	struct nvmem_cell_info info = {0};
+	struct device_node *layout_np;
+	struct sl28vpd_header hdr;
+	int ret, i;
+
+	/* check header */
+	ret = nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
+	if (ret < 0)
+		return ret;
+	else if (ret != sizeof(hdr))
+		return -EIO;
+
+	if (hdr.magic != SL28VPD_MAGIC) {
+		dev_err(dev, "Invalid magic value (%02x)\n", hdr.magic);
+		return -EINVAL;
+	}
+
+	if (hdr.version != 1) {
+		dev_err(dev, "Version %d is unsupported.\n", hdr.version);
+		return -EINVAL;
+	}
+
+	ret = sl28vpd_v1_check_crc(dev, nvmem);
+	if (ret)
+		return ret;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(sl28vpd_v1_entries); i++) {
+		pinfo = &sl28vpd_v1_entries[i];
+
+		info.name = pinfo->name;
+		info.offset = pinfo->offset;
+		info.bytes = pinfo->bytes;
+		info.read_post_process = pinfo->read_post_process;
+		info.np = of_get_child_by_name(layout_np, pinfo->name);
+
+		ret = nvmem_add_one_cell(nvmem, &info);
+		if (ret) {
+			of_node_put(layout_np);
+			return ret;
+		}
+	}
+
+	of_node_put(layout_np);
+
+	return 0;
+}
+
+static const struct of_device_id sl28vpd_of_match_table[] = {
+	{ .compatible = "kontron,sl28-vpd" },
+	{},
+};
+
+struct nvmem_layout sl28vpd_layout = {
+	.name = "sl28-vpd",
+	.of_match_table = sl28vpd_of_match_table,
+	.add_cells = sl28vpd_add_cells,
+};
+
+static int __init sl28vpd_init(void)
+{
+	return nvmem_layout_register(&sl28vpd_layout);
+}
+subsys_initcall(sl28vpd_init);
-- 
2.30.2

