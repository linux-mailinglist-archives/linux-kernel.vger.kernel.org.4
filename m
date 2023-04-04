Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1376D6A75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjDDRYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjDDRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2304E46
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eh3so133538491edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsL63XMcYPG0QJDkZzTuMtc8RkwMSJtKAF6NPnFMA58=;
        b=frRBwHt+RApdtoCGulgzPWlxd1OOnYcCOpCHchyrQTFLjfOKNZgiVx5MjfjWWCRXja
         dcpTdeMGhcazyEsMqIFSGCRjNC7Aye5a8MtGY/rBRdABqCA8y3Cwf6UBjmmA4vzrHyRS
         eWsEgmo0u3C8TU4aWDCdh1erX3L5mBqsin0o+n0F64VbnbYPPdKkjfH9BRdDYUFeOpvd
         jj9QHqZJbQ3Qp5Olwhh/Bxtvp9EkO0hPSNc+ACiFzJDHVmyi+ojCNB6M8hxdZw95za3W
         wsuJt1ag5M/IrgrNVIZ4Qm+4zZOhAT4aWVq5THZLvcyiAfKdP6w2Ifo4WHVQ4gd7KIUA
         LY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsL63XMcYPG0QJDkZzTuMtc8RkwMSJtKAF6NPnFMA58=;
        b=2SB+MfFNnhIEdi+6/YSGLp70aVLnwwTgTdHINLnqwBK95Tn6FwvpbaGVxT9kBT+X38
         8ChYmJ2gTzS6kWfexxUZcLFf3Wg4UOKsXhtZYlWUfQrpU73oZXUJ8PlaCBL1bqytGNqV
         /h8MIHRwmHa8aWAXoGT+gfq21KVXOOOdUrhG4+DahC/A5qti9SFyeH7S/P6cidcLdUx9
         GDxUub2avn2raViIaShoO6ITOq/gnwS8EMDrhrm7NCUHGcQIztPlCI8mE0l+8YPwSohg
         hqjE1Cux+d9ArmdovmePAZyXcTrScQxCos5t+R9/f4ehvkGM3RKl7LSnGmNywCVX77bf
         6EgQ==
X-Gm-Message-State: AAQBX9ejb4Q99EoF3BZWFcADX0KFKc00xr9+Aino+YlpogKKY5LUOfkg
        8AhlrFS+xv+RGA+2m5RiiYvagh65+/pvrto99F4=
X-Google-Smtp-Source: AKy350Ya0OLmUJcuCrz7z9NJli6CZbvBVuY654jWw83HZ8mvAWnRupVESbGa/p+OFnIaCHbj1LhnOA==
X-Received: by 2002:a17:906:c7d9:b0:93c:847d:a456 with SMTP id dc25-20020a170906c7d900b0093c847da456mr347753ejb.22.1680628972021;
        Tue, 04 Apr 2023 10:22:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 21/40] nvmem: layouts: sl28vpd: Add new layout driver
Date:   Tue,  4 Apr 2023 18:21:29 +0100
Message-Id: <20230404172148.82422-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

This layout applies to the VPD of the Kontron sl28 boards. The VPD only
contains a base MAC address. Therefore, we have to add an individual
offset to it. This is done by taking the second argument of the nvmem
phandle into account. Also this let us checking the VPD version and the
checksum.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/Kconfig   |   9 ++
 drivers/nvmem/layouts/Makefile  |   2 +
 drivers/nvmem/layouts/sl28vpd.c | 165 ++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9ad3911d1605..fd161347c129 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -2,4 +2,13 @@
 
 menu "Layout Types"
 
+config NVMEM_LAYOUT_SL28_VPD
+	tristate "Kontron sl28 VPD layout support"
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
index 000000000000..9370e41bad73
--- /dev/null
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -0,0 +1,165 @@
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
+MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
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
+
+static void __exit sl28vpd_exit(void)
+{
+	nvmem_layout_unregister(&sl28vpd_layout);
+}
+
+module_init(sl28vpd_init);
+module_exit(sl28vpd_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_DESCRIPTION("NVMEM layout driver for the VPD of Kontron sl28 boards");
-- 
2.25.1

