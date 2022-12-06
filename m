Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E3644D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLFUJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLFUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:59 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC932FFC2;
        Tue,  6 Dec 2022 12:07:56 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id F34243BD5;
        Tue,  6 Dec 2022 21:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WExFGJcqmgTXaKZQqcybDlur7a8O8FUqyOI1ePLZ42s=;
        b=g962j5kNwDUcBv6nuH/d7+257E/HPiojCgHFt4f0eyT9Jw6jjXuWfqJYQfKvw+odJhELVq
        mOQggCSs8eEnpRL5nLrimM2BQUBS+EaOtsaGqieQj5MJxmYBhfmNB7KjTRLz6pnL2titD9
        hLs+z3aZumhrunR1ESRBeyGy+MtECjxERubktG4hBJY0IGC8gyvUovbodMKZz4CeMKXSHf
        RC1pJ+kIl3TAFtEsIMJgOcc8ZhfeXMyixhKUFT8jAEMzTH0xISnSuWPSLGl8dwAno80YSE
        5yBDZFss1cCeYFIwsQya0/73xbH4yH3C6QVev8LkaEzb1NGZX/Fzt0AwS4lGLQ==
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
Subject: [PATCH v5 20/21] nvmem: layouts: Add ONIE tlv layout driver
Date:   Tue,  6 Dec 2022 21:07:39 +0100
Message-Id: <20221206200740.3567551-21-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206200740.3567551-1-michael@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

This layout applies on top of any non volatile storage device containing
an ONIE table factory flashed. This table follows the tlv
(type-length-value) organization described in the link below. We cannot
afford using regular parsers because the content of these tables is
manufacturer specific and must be dynamically discovered.

Link: https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
changes since v4:
 - none

changes since v3:
 - don't use kfree()
 - fix typo, s/no/on/

changes since v2:
 - new patch

 drivers/nvmem/layouts/Kconfig    |   9 ++
 drivers/nvmem/layouts/Makefile   |   1 +
 drivers/nvmem/layouts/onie-tlv.c | 244 +++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 75082f6b471d..9ad50474cb77 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -11,4 +11,13 @@ config NVMEM_LAYOUT_SL28_VPD
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_ONIE_TLV
+	bool "ONIE tlv support"
+	select CRC32
+	help
+	  Say Y here if you want to support the Open Compute Project ONIE
+	  Type-Length-Value standard table.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index fc617b9e87d0..2974bd7d33ed 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
+obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
new file mode 100644
index 000000000000..074c7c700845
--- /dev/null
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ONIE tlv NVMEM cells provider
+ *
+ * Copyright (C) 2022 Open Compute Group ONIE
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com>
+ * Based on the nvmem driver written by: Vadym Kochan <vadym.kochan@plvision.eu>
+ * Inspired by the first layout written by: Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+
+#define ONIE_TLV_MAX_LEN 2048
+#define ONIE_TLV_CRC_FIELD_SZ 6
+#define ONIE_TLV_CRC_SZ 4
+#define ONIE_TLV_HDR_ID	"TlvInfo"
+
+struct onie_tlv_hdr {
+	u8 id[8];
+	u8 version;
+	__be16 data_len;
+} __packed;
+
+struct onie_tlv {
+	u8 type;
+	u8 len;
+} __packed;
+
+static const char *onie_tlv_cell_name(u8 type)
+{
+	switch (type) {
+	case 0x21:
+		return "product-name";
+	case 0x22:
+		return "part-number";
+	case 0x23:
+		return "serial-number";
+	case 0x24:
+		return "mac-address";
+	case 0x25:
+		return "manufacture-date";
+	case 0x26:
+		return "device-version";
+	case 0x27:
+		return "label-revision";
+	case 0x28:
+		return "platforn-name";
+	case 0x29:
+		return "onie-version";
+	case 0x2A:
+		return "num-macs";
+	case 0x2B:
+		return "manufacturer";
+	case 0x2C:
+		return "country-code";
+	case 0x2D:
+		return "vendor";
+	case 0x2E:
+		return "diag-version";
+	case 0x2F:
+		return "service-tag";
+	case 0xFD:
+		return "vendor-extension";
+	case 0xFE:
+		return "crc32";
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+static int onie_tlv_mac_read_cb(void *priv, const char *id, int index,
+				unsigned int offset, void *buf,
+				size_t bytes)
+{
+	eth_addr_add(buf, index);
+
+	return 0;
+}
+
+static nvmem_cell_post_process_t onie_tlv_read_cb(u8 type, u8 *buf)
+{
+	switch (type) {
+	case 0x24:
+		return &onie_tlv_mac_read_cb;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
+			      size_t data_len, u8 *data)
+{
+	struct nvmem_cell_info cell = {};
+	struct device_node *layout;
+	struct onie_tlv tlv;
+	unsigned int hdr_len = sizeof(struct onie_tlv_hdr);
+	unsigned int offset = 0;
+	int ret;
+
+	layout = of_nvmem_layout_get_container(nvmem);
+	if (!layout)
+		return -ENOENT;
+
+	while (offset < data_len) {
+		memcpy(&tlv, data + offset, sizeof(tlv));
+		if (offset + tlv.len >= data_len) {
+			dev_err(dev, "Out of bounds field (0x%x bytes at 0x%x)\n",
+				tlv.len, hdr_len + offset);
+			break;
+		}
+
+		cell.name = onie_tlv_cell_name(tlv.type);
+		if (!cell.name)
+			continue;
+
+		cell.offset = hdr_len + offset + sizeof(tlv.type) + sizeof(tlv.len);
+		cell.bytes = tlv.len;
+		cell.np = of_get_child_by_name(layout, cell.name);
+		cell.read_post_process = onie_tlv_read_cb(tlv.type, data + offset + sizeof(tlv));
+
+		ret = nvmem_add_one_cell(nvmem, &cell);
+		if (ret) {
+			of_node_put(layout);
+			return ret;
+		}
+
+		offset += sizeof(tlv) + tlv.len;
+	}
+
+	of_node_put(layout);
+
+	return 0;
+}
+
+static bool onie_tlv_hdr_is_valid(struct device *dev, struct onie_tlv_hdr *hdr)
+{
+	if (memcmp(hdr->id, ONIE_TLV_HDR_ID, sizeof(hdr->id))) {
+		dev_err(dev, "Invalid header\n");
+		return false;
+	}
+
+	if (hdr->version != 0x1) {
+		dev_err(dev, "Invalid version number\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool onie_tlv_crc_is_valid(struct device *dev, size_t table_len, u8 *table)
+{
+	struct onie_tlv crc_hdr;
+	u32 read_crc, calc_crc;
+	__be32 crc_be;
+
+	memcpy(&crc_hdr, table + table_len - ONIE_TLV_CRC_FIELD_SZ, sizeof(crc_hdr));
+	if (crc_hdr.type != 0xfe || crc_hdr.len != ONIE_TLV_CRC_SZ) {
+		dev_err(dev, "Invalid CRC field\n");
+		return false;
+	}
+
+	/* The table contains a JAMCRC, which is XOR'ed compared to the original
+	 * CRC32 implementation as known in the Ethernet world.
+	 */
+	memcpy(&crc_be, table + table_len - ONIE_TLV_CRC_SZ, ONIE_TLV_CRC_SZ);
+	read_crc = be32_to_cpu(crc_be);
+	calc_crc = crc32(~0, table, table_len - ONIE_TLV_CRC_SZ) ^ 0xFFFFFFFF;
+	if (read_crc != calc_crc) {
+		dev_err(dev, "Invalid CRC read: 0x%08x, expected: 0x%08x\n",
+			read_crc, calc_crc);
+		return false;
+	}
+
+	return true;
+}
+
+static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem,
+				struct nvmem_layout *layout)
+{
+	struct onie_tlv_hdr hdr;
+	size_t table_len, data_len, hdr_len;
+	u8 *table, *data;
+	int ret;
+
+	ret = nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
+	if (ret < 0)
+		return ret;
+
+	if (!onie_tlv_hdr_is_valid(dev, &hdr)) {
+		dev_err(dev, "Invalid ONIE TLV header\n");
+		return -EINVAL;
+	}
+
+	hdr_len = sizeof(hdr.id) + sizeof(hdr.version) + sizeof(hdr.data_len);
+	data_len = be16_to_cpu(hdr.data_len);
+	table_len = hdr_len + data_len;
+	if (table_len > ONIE_TLV_MAX_LEN) {
+		dev_err(dev, "Invalid ONIE TLV data length\n");
+		return -EINVAL;
+	}
+
+	table = devm_kmalloc(dev, table_len, GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	ret = nvmem_device_read(nvmem, 0, table_len, table);
+	if (ret != table_len)
+		return ret;
+
+	if (!onie_tlv_crc_is_valid(dev, table_len, table))
+		return -EINVAL;
+
+	data = table + hdr_len;
+	ret = onie_tlv_add_cells(dev, nvmem, data_len, data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id onie_tlv_of_match_table[] = {
+	{ .compatible = "onie,tlv-layout", },
+	{},
+};
+
+static struct nvmem_layout onie_tlv_layout = {
+	.name = "ONIE tlv layout",
+	.of_match_table = onie_tlv_of_match_table,
+	.add_cells = onie_tlv_parse_table,
+};
+
+static int __init onie_tlv_init(void)
+{
+	return nvmem_layout_register(&onie_tlv_layout);
+}
+subsys_initcall(onie_tlv_init);
-- 
2.30.2

