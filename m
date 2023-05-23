Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D3B70D9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjEWKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjEWKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:02:51 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EC126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:02:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D6351BF205;
        Tue, 23 May 2023 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684836162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5M/vHgzuPPKaMo5s10MhzrRN3WWq1fY96XvfFQ3nlE=;
        b=YeqwowiJ0aVl/brGpwQk1/8hi9PNM7WuD/z6nzr759He76pNZrB9RQtpWdq/Js4SGfWkKA
        Z8BPIjub1xWK39MaRo3NtcjizsE3BJhSYVEiHjzFmiDtn0skvlt09APzxAuxSa12mKa7nS
        HzyaMirNlPtZ63WIVyM+BIhagBgXcF71GusghkOYf9a0q55/OpsEh/zU4w6YWluoIw2j9x
        r1mBF/gCcThjgFOc5OLKxIFsHiTqHRjKx4jAuPRHPLsetDvVnGzRdHCAK5OGIni1VEiH1f
        43F24UOjTUCtyRb4dzJKkMFSP4hi6ahuQLfbhsYpQ9a5ozmOBrkWAde4KzQeGA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Date:   Tue, 23 May 2023 12:02:39 +0200
Message-Id: <20230523100239.307574-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523100239.307574-1-miquel.raynal@bootlin.com>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binary content of nvmem devices is available to the user so in the
easiest cases, finding the content of a cell is rather easy as it is
just a matter of looking at a known and fixed offset. However, nvmem
layouts have been recently introduced to cope with more advanced
situations, where the offset and size of the cells is not known in
advance or is dynamic. When using layouts, more advanced parsers are
used by the kernel in order to give direct access to the content of each
cell regardless of their position/size in the underlying device, but
these information were not accessible to the user without re-writing the
parser logic in userland.

The current implementation only adds the 'cells' attributes if cells are
found within the device, otherwise the folder does not appear.

Exposed cells are read-only. There is in practice everything in the core
to support a write path, but as I don't see any need for that, I prefer
to keep the interface simple (and probably safer). The interface is
documented as being in the "testing" state which means we can later add
a write attribute if though relevant.

Of course the relevant NVMEM sysfs Kconfig option must be enabled for
this support to be compiled-in.

There is one limitation though: if a layout is built as a module but is
not properly installed in the system and loaded manually with insmod
while the nvmem device driver was built-in, the cells won't appear in
sysfs. But if done like that, the cells won't be usable by the built-in
kernel drivers anyway.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 135 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 342cd380b420..234b2f232854 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -325,6 +325,61 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
+static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
+					    const char *id, int index);
+
+static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct nvmem_cell_entry *entry;
+	struct nvmem_cell *cell = NULL;
+	struct nvmem_device *nvmem;
+	size_t cell_sz, read_len;
+	struct device *dev;
+	void *content;
+
+	if (attr->private)
+		dev = attr->private;
+	else
+		dev = kobj_to_dev(kobj);
+	nvmem = to_nvmem_device(dev);
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(entry, &nvmem->cells, node) {
+		if (strncmp(entry->name, attr->attr.name, XATTR_NAME_MAX))
+			continue;
+
+		cell = nvmem_create_cell(entry, entry->name, 0);
+		if (IS_ERR(cell)) {
+			mutex_unlock(&nvmem_mutex);
+			return PTR_ERR(cell);
+		}
+
+		break;
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	if (!cell)
+		return -EINVAL;
+
+	content = nvmem_cell_read(cell, &cell_sz);
+	if (IS_ERR(content)) {
+		count = PTR_ERR(content);
+		goto destroy_cell;
+	}
+
+	read_len = min_t(unsigned int, cell_sz - pos, count);
+	memcpy(buf, content + pos, read_len);
+	kfree(content);
+
+destroy_cell:
+	kfree_const(cell->id);
+	kfree(cell);
+
+	return read_len;
+}
+
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
@@ -346,8 +401,14 @@ static const struct attribute_group nvmem_bin_group = {
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
+/* Cell attributes will be dynamically allocated */
+static struct attribute_group nvmem_cells_group = {
+	.name		= "cells",
+};
+
 static const struct attribute_group *nvmem_dev_groups[] = {
 	&nvmem_bin_group,
+	NULL, /* Reserved for exposing cells, if any */
 	NULL,
 };
 
@@ -406,6 +467,66 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 }
 
+static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
+{
+	struct bin_attribute **cells_attrs, *attrs;
+	struct nvmem_cell_entry *entry;
+	unsigned int ncells = 0, i = 0;
+	int ret = 0;
+
+	mutex_lock(&nvmem_mutex);
+
+	/* Allocate an array of attributes */
+	list_for_each_entry(entry, &nvmem->cells, node)
+		ncells++;
+
+	if (!ncells)
+		goto unlock_mutex;
+
+	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1, sizeof(struct bin_attribute *),
+				   GFP_KERNEL);
+	if (!cells_attrs) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
+	attrs = devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribute),
+			     GFP_KERNEL);
+	if (!attrs) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
+	/* Initialize each attribute to have the name of a cell */
+	list_for_each_entry(entry, &nvmem->cells, node) {
+		sysfs_bin_attr_init(&attrs[i]);
+		attrs[i].attr.name = kstrdup(entry->name, GFP_KERNEL);
+		attrs[i].attr.mode = 0444;
+		attrs[i].size = entry->bytes;
+		attrs[i].read = &nvmem_cell_attr_read;
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto unlock_mutex;
+		}
+
+		cells_attrs[i] = &attrs[i];
+		i++;
+	}
+
+	nvmem_cells_group.bin_attrs = cells_attrs;
+
+	/* Fill the attribute group structure with the cells member */
+	for (i = 0;; i++)
+		if (!nvmem_dev_groups[i])
+			break;
+	nvmem_dev_groups[i] = &nvmem_cells_group;
+
+unlock_mutex:
+	mutex_unlock(&nvmem_mutex);
+
+	return ret;
+}
+
 #else /* CONFIG_NVMEM_SYSFS */
 
 static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
@@ -976,16 +1097,22 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_add_cells_from_layout(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
+#ifdef CONFIG_NVMEM_SYSFS
+	rval = nvmem_populate_sysfs_cells(nvmem);
+	if (rval)
+		goto err_remove_cells;
+#endif
+
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
-- 
2.34.1

