Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1962FD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbiKRSxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbiKRSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:51:55 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB4C8FE7B;
        Fri, 18 Nov 2022 10:51:53 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 655B325E7;
        Fri, 18 Nov 2022 19:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668797489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4G2KZPKkswRghYeLAYy/JqZHXcVyIyOuR6tOMMn75tE=;
        b=Cx1Un/GaB24T26eU3iF8gBu6H8vxoFLdftbUfiZzb8cI000UP9E74HGbcFXVLvonHBTtzU
        j1fZ+aM6XYth9nIX/gZhS5nIW0wLfFBdL1T1OSeKCJFiVdFNnHQe8woAAJ2X9RvMqjHvc7
        KD0qqJ2BLiDwGj4ogDbqsJIS3yNuNLUtZ1rqDO3GbLpkYriATVeDl5M/kJ5UiMGQvJbyaE
        aAqOFVXso9scDvq6IRRa/3QahnasIGzSYjCpsLEHzSj9+kbuAgEnRrDYwoppKZvCW4axf+
        WQrl5jdeujLSNSM4uAaGhyoriIKPczuXYZfZWBH5ipaacfpM9GL+4a6DCK7fZQ==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 09/18] nvmem: core: introduce NVMEM layouts
Date:   Fri, 18 Nov 2022 19:51:09 +0100
Message-Id: <20221118185118.1190044-10-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221118185118.1190044-1-michael@walle.cc>
References: <20221118185118.1190044-1-michael@walle.cc>
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

NVMEM layouts are used to generate NVMEM cells during runtime. Think of
an EEPROM with a well-defined conent. For now, the content can be
described by a device tree or a board file. But this only works if the
offsets and lengths are static and don't change. One could also argue
that putting the layout of the EEPROM in the device tree is the wrong
place. Instead, the device tree should just have a specific compatible
string.

Right now there are two use cases:
 (1) The NVMEM cell needs special processing. E.g. if it only specifies
     a base MAC address offset and you need to add an offset, or it
     needs to parse a MAC from ASCII format or some proprietary format.
     (Post processing of cells is added in a later commit).
 (2) u-boot environment parsing. The cells don't have a particular
     offset but it needs parsing the content to determine the offsets
     and length.

Co-developed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - look for "nvmem-layout" node and its compatible
 - add of_nvmem_layout_get_container()
 - special handling in of_nvmem_cell_get()

changes since v1:
 - add documentation in nvmem.rst
 - add nvmem_layout_unregister() + necessary module tracking
 - make it possible to supply a layout via nvmem_register()
 - check add_cells, before calling

 Documentation/driver-api/nvmem.rst |  15 ++++
 drivers/nvmem/Kconfig              |   4 +
 drivers/nvmem/Makefile             |   1 +
 drivers/nvmem/core.c               | 114 +++++++++++++++++++++++++++++
 drivers/nvmem/layouts/Kconfig      |   5 ++
 drivers/nvmem/layouts/Makefile     |   4 +
 include/linux/nvmem-consumer.h     |   7 ++
 include/linux/nvmem-provider.h     |  51 +++++++++++++
 8 files changed, 201 insertions(+)
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index e3366322d46c..de221e91c8e3 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -185,3 +185,18 @@ ex::
 =====================
 
 See Documentation/devicetree/bindings/nvmem/nvmem.txt
+
+8. NVMEM layouts
+================
+
+NVMEM layouts are yet another mechanism to create cells. With the device
+tree binding it is possible to specify simple cells by using an offset
+and a length. Sometimes, the cells doesn't have a static offset, but
+the content is still well defined, e.g. tag-length-values. In this case,
+the NVMEM device content has to be first parsed and the cells need to
+be added accordingly. Layouts let you read the content of the NVMEM device
+and let you add cells dynamically.
+
+Another use case for layouts is the post processing of cells. With layouts,
+it is possible to associate a custom post processing hook to a cell. It
+even possible to add this hook to cells not created by the layout itself.
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 755f551426b5..0e10b5b094b9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -21,6 +21,10 @@ config NVMEM_SYSFS
 	 This interface is mostly used by userspace applications to
 	 read/write directly into nvmem.
 
+# Layouts
+
+source "drivers/nvmem/layouts/Kconfig"
+
 # Devices
 
 config NVMEM_APPLE_EFUSES
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index fa80fe17e567..4cf87ef6c24d 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
+obj-y				+= layouts/
 
 # Devices
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 26459d582e99..4ad1a02faf30 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -40,6 +40,7 @@ struct nvmem_device {
 	nvmem_reg_write_t	reg_write;
 	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
+	struct nvmem_layout	*layout;
 	void *priv;
 };
 
@@ -74,6 +75,9 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+static DEFINE_SPINLOCK(nvmem_layout_lock);
+static LIST_HEAD(nvmem_layouts);
+
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			    void *val, size_t bytes)
 {
@@ -735,6 +739,95 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	return 0;
 }
 
+int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
+{
+	layout->owner = owner;
+
+	spin_lock(&nvmem_layout_lock);
+	list_add(&layout->node, &nvmem_layouts);
+	spin_unlock(&nvmem_layout_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__nvmem_layout_register);
+
+void nvmem_layout_unregister(struct nvmem_layout *layout)
+{
+	spin_lock(&nvmem_layout_lock);
+	list_del(&layout->node);
+	spin_unlock(&nvmem_layout_lock);
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
+
+static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
+{
+	struct device_node *layout_np, *np = nvmem->dev.of_node;
+	struct nvmem_layout *l, *layout = NULL;
+
+	layout_np = of_get_child_by_name(np, "nvmem-layout");
+	if (!layout_np)
+		return NULL;
+
+	spin_lock(&nvmem_layout_lock);
+
+	list_for_each_entry(l, &nvmem_layouts, node) {
+		if (of_match_node(l->of_match_table, layout_np)) {
+			if (try_module_get(l->owner))
+				layout = l;
+
+			break;
+		}
+	}
+
+	spin_unlock(&nvmem_layout_lock);
+	of_node_put(layout_np);
+
+	return layout;
+}
+
+static void nvmem_layout_put(struct nvmem_layout *layout)
+{
+	if (layout)
+		module_put(layout->owner);
+}
+
+static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
+{
+	struct nvmem_layout *layout = nvmem->layout;
+
+	if (layout && layout->add_cells)
+		layout->add_cells(&nvmem->dev, nvmem, layout);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF)
+/**
+ * of_nvmem_layout_get_container() - Get OF node to layout container.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: a node pointer with refcount incremented or NULL if no
+ * container exists. Use of_node_put() on it when done.
+ */
+struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
+{
+	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+}
+EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
+#endif
+
+const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
+					struct nvmem_layout *layout)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(layout->of_match_table, nvmem->dev.of_node);
+
+	return match ? match->data : NULL;
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -849,6 +942,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
+	/*
+	 * If the driver supplied a layout by config->layout, the module
+	 * pointer will be NULL and nvmem_layout_put() will be a noop.
+	 */
+	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
+
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
 		if (rval)
@@ -863,6 +962,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_add_cells_from_layout(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
@@ -872,6 +975,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
+	nvmem_layout_put(nvmem->layout);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
@@ -893,6 +997,7 @@ static void nvmem_device_release(struct kref *kref)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
 	nvmem_device_remove_all_cells(nvmem);
+	nvmem_layout_put(nvmem->layout);
 	device_unregister(&nvmem->dev);
 }
 
@@ -1258,6 +1363,15 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* nvmem layouts produce cells within the nvmem-layout container */
+	if (of_node_name_eq(nvmem_np, "nvmem-layout")) {
+		nvmem_np = of_get_next_parent(nvmem_np);
+		if (!nvmem_np) {
+			of_node_put(cell_np);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
 	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem)) {
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
new file mode 100644
index 000000000000..9ad3911d1605
--- /dev/null
+++ b/drivers/nvmem/layouts/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Layout Types"
+
+endmenu
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
new file mode 100644
index 000000000000..6fdb3c60a4fa
--- /dev/null
+++ b/drivers/nvmem/layouts/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for nvmem layouts.
+#
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 1f62f7ba71ca..fa030d93b768 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -239,6 +239,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *id);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
+struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 						   const char *id)
@@ -251,6 +252,12 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct device_node *
+of_nvmem_layout_get_container(struct nvmem_device *nvmem)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
 #endif  /* ifndef _LINUX_NVMEM_CONSUMER_H */
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 385d29168008..4185767c114f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -89,6 +89,7 @@ struct nvmem_cell_info {
  * @priv:	User context passed to read/write callbacks.
  * @wp-gpio:	Write protect pin
  * @ignore_wp:  Write Protect pin is managed by the provider.
+ * @layout:	Fixed layout associated with this nvmem device.
  *
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
@@ -111,6 +112,7 @@ struct nvmem_config {
 	bool			read_only;
 	bool			root_only;
 	bool			ignore_wp;
+	struct nvmem_layout	*layout;
 	struct device_node	*of_node;
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
@@ -144,6 +146,33 @@ struct nvmem_cell_table {
 	struct list_head	node;
 };
 
+/**
+ * struct nvmem_layout - NVMEM layout definitions
+ *
+ * @name:		Layout name.
+ * @of_match_table:	Open firmware match table.
+ * @add_cells:		Will be called if a nvmem device is found which
+ *			has this layout. The function will add layout
+ *			specific cells with nvmem_add_one_cell().
+ * @owner:		Pointer to struct module.
+ * @node:		List node.
+ *
+ * A nvmem device can hold a well defined structure which can just be
+ * evaluated during runtime. For example a TLV list, or a list of "name=val"
+ * pairs. A nvmem layout can parse the nvmem device and add appropriate
+ * cells.
+ */
+struct nvmem_layout {
+	const char *name;
+	const struct of_device_id *of_match_table;
+	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
+			 struct nvmem_layout *layout);
+
+	/* private */
+	struct module *owner;
+	struct list_head node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -158,6 +187,14 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 int nvmem_add_one_cell(struct nvmem_device *nvmem,
 		       const struct nvmem_cell_info *info);
 
+int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner);
+#define nvmem_layout_register(layout) \
+	__nvmem_layout_register(layout, THIS_MODULE)
+void nvmem_layout_unregister(struct nvmem_layout *layout);
+
+const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
+					struct nvmem_layout *layout);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -181,5 +218,19 @@ static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_layout_register(struct nvmem_layout *layout)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
+
+static inline const void *
+nvmem_layout_get_match_data(struct nvmem_device *nvmem,
+			    struct nvmem_layout *layout)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.30.2

