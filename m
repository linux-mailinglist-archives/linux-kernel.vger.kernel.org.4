Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0646D6A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjDDRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjDDRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34E49D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eh3so133538997edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4Qz13+ZT5fbZmY5ugvf4iq0S8IgS9oqrtgiecX2uWE=;
        b=r1Yq5gtA9a8nCVL1ZyKKy/QUxEigL4eMKN0FTsvmmoXxGWb6vtES8vzYFOAVPG9iub
         JIEgI1AyZxjMlsIY5cBjxaXGHQKG8HVe6NitfbhYPpo7iTGtaqV0v57pXIUgufzl2l1i
         Mj5e/Rpfb6UTP334UDvc15rww4qUebqNg0PpkAIsYaxhMw/uLLCCGMJY4wkwZk2tlPhP
         JOKmGhOapiAI/uQiX090adtpR91sE56qGWtDS1wwuIyWsuYBYzhUiUanGivdtOTspgP9
         6Ar3JU1LGuqZgX+8mzurRqboWK2jPvuNchg2Ubfi1eaKdq6C9Wr3sxSrTneoQcwtA+Pg
         U4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4Qz13+ZT5fbZmY5ugvf4iq0S8IgS9oqrtgiecX2uWE=;
        b=RiV5zFsQw8IbPvCpTVE3zvpAB1GgJ0rwvzBv85hoAMsdCKfPM93iWAlKgGpRPo8/eP
         Oxwu9gB3Sfv5mATJ9HIT8j8w7Ox830VAUezWN27AQX58eT0rP9ntTuD3+ETPsOBR7wA5
         f28gym6CGLYDfq1pJfY3c6UzDNybayxZZwgMUfqKzGcJCcjP2tCk9ocNlQTizmLtBsT7
         qTVaN+fYW8JY9xyNu10QplX0IUKRZbs/gAAE9dis3qRobY/faprjXFNXFiW3TOD8DCuW
         3wZJiSINJUWpaCI+rnecEWVpPj/wG+ItrJmQiHPGka9BucutFCiviJsQXcWY70Ru3/a0
         j2MA==
X-Gm-Message-State: AAQBX9e7Ypz+VG33GtUUHaJNTtl5P02MriYQDk1rNAimAj0krqlkU4EK
        A7kpoNpL+DLmxNaTIvw9DP2RLw==
X-Google-Smtp-Source: AKy350bXAcNDA2Ep1cJudhdpm4hQemzV68CVq9tx06rnm2a9ij8kWVIDZTFbQrI/OCYIO4SA5+MeQA==
X-Received: by 2002:a17:906:37cd:b0:93e:82d1:9ae0 with SMTP id o13-20020a17090637cd00b0093e82d19ae0mr286805ejc.49.1680628974696;
        Tue, 04 Apr 2023 10:22:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 23/40] nvmem: layouts: onie-tlv: Add new layout driver
Date:   Tue,  4 Apr 2023 18:21:31 +0100
Message-Id: <20230404172148.82422-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/Kconfig    |   9 ++
 drivers/nvmem/layouts/Makefile   |   1 +
 drivers/nvmem/layouts/onie-tlv.c | 257 +++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index fd161347c129..7ff1ee1c1f05 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -11,4 +11,13 @@ config NVMEM_LAYOUT_SL28_VPD
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_ONIE_TLV
+	tristate "ONIE tlv support"
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
index 000000000000..d45b7301a69d
--- /dev/null
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -0,0 +1,257 @@
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
+		return "platform-name";
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
+MODULE_DEVICE_TABLE(of, onie_tlv_of_match_table);
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
+
+static void __exit onie_tlv_exit(void)
+{
+	nvmem_layout_unregister(&onie_tlv_layout);
+}
+
+module_init(onie_tlv_init);
+module_exit(onie_tlv_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
+MODULE_DESCRIPTION("NVMEM layout driver for Onie TLV table parsing");
+MODULE_ALIAS("NVMEM layout driver for Onie TLV table parsing");
-- 
2.25.1

