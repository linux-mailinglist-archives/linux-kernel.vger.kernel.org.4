Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4D644CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLFUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLFUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:53 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE015832;
        Tue,  6 Dec 2022 12:07:51 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 060923B2A;
        Tue,  6 Dec 2022 21:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oi6mw7eMT741U/IKaok3g4GdHwU7S21KLKm3d4kbCc4=;
        b=XdNFdLF/W9gu0574b6cxs7QHAlkxybckaWRgx5Q+F+cIAHqT1bmVapWEG/Te10qSUYPo9E
        DBCsLZetGlQPbKAMmB/z+71xVyvN3FK78WKoRMU6JlcbRXvUsQ4mUz4GanWDLmcDeC4o0+
        7/x3DS1I18OJNZGi9KEUWYZcDvuu7/Vh2MLU8QJueLgVVn2itpj2jO4AU/CjrRVax7chlR
        LJ0SFeCoMoq7yuKAHXhJzKVcRtv7NNAgZXDJ0jD8fWjr0fnl29QmsALGBYf49dCqUqAZEX
        wRZ0KTGmlV50Ba07wyiR+jxLoliDdW3xCtiVGJUMWe+QGQVqZzzw/WPR/diftQ==
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
Subject: [PATCH v5 06/21] nvmem: core: add an index parameter to the cell
Date:   Tue,  6 Dec 2022 21:07:25 +0100
Message-Id: <20221206200740.3567551-7-michael@walle.cc>
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

Sometimes a cell can represend multiple values. For example, a base
ethernet address stored in the NVMEM can be expanded into multiple
discreet ones by adding an offset.

For this use case, introduce an index parameter which is then used to
distiguish between values. This parameter will then be passed to the
post process hook which can then use it to create different values
during reading.

At the moment, there is only support for the device tree path. You can
add the index to the phandle, e.g.

  &net {
          nvmem-cells = <&base_mac_address 2>;
          nvmem-cell-names = "mac-address";
  };

  &nvmem_provider {
          base_mac_address: base-mac-address@0 {
                  #nvmem-cell-cells = <1>;
                  reg = <0 6>;
          };
  };

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v4:
 - none

changes since v3:
 - none

changes since v2:
 - none

changes since v1:
 - none

 drivers/nvmem/core.c           | 37 ++++++++++++++++++++++++----------
 drivers/nvmem/imx-ocotp.c      |  4 ++--
 include/linux/nvmem-provider.h |  4 ++--
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 205a427f564d..24573e63e5a9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -60,6 +60,7 @@ struct nvmem_cell_entry {
 struct nvmem_cell {
 	struct nvmem_cell_entry *entry;
 	const char		*id;
+	int			index;
 };
 
 static DEFINE_MUTEX(nvmem_mutex);
@@ -1127,7 +1128,8 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
-static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry, const char *id)
+static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
+					    const char *id, int index)
 {
 	struct nvmem_cell *cell;
 	const char *name = NULL;
@@ -1146,6 +1148,7 @@ static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry, cons
 
 	cell->id = name;
 	cell->entry = entry;
+	cell->index = index;
 
 	return cell;
 }
@@ -1184,7 +1187,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 				__nvmem_device_put(nvmem);
 				cell = ERR_PTR(-ENOENT);
 			} else {
-				cell = nvmem_create_cell(cell_entry, con_id);
+				cell = nvmem_create_cell(cell_entry, con_id, 0);
 				if (IS_ERR(cell))
 					__nvmem_device_put(nvmem);
 			}
@@ -1232,15 +1235,27 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	struct nvmem_device *nvmem;
 	struct nvmem_cell_entry *cell_entry;
 	struct nvmem_cell *cell;
+	struct of_phandle_args cell_spec;
 	int index = 0;
+	int cell_index = 0;
+	int ret;
 
 	/* if cell name exists, find index to the name */
 	if (id)
 		index = of_property_match_string(np, "nvmem-cell-names", id);
 
-	cell_np = of_parse_phandle(np, "nvmem-cells", index);
-	if (!cell_np)
-		return ERR_PTR(-ENOENT);
+	ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
+						  "#nvmem-cell-cells",
+						  index, &cell_spec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cell_spec.args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	cell_np = cell_spec.np;
+	if (cell_spec.args_count)
+		cell_index = cell_spec.args[0];
 
 	nvmem_np = of_get_parent(cell_np);
 	if (!nvmem_np) {
@@ -1262,7 +1277,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 		return ERR_PTR(-ENOENT);
 	}
 
-	cell = nvmem_create_cell(cell_entry, id);
+	cell = nvmem_create_cell(cell_entry, id, cell_index);
 	if (IS_ERR(cell))
 		__nvmem_device_put(nvmem);
 
@@ -1415,8 +1430,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
-		      struct nvmem_cell_entry *cell,
-		      void *buf, size_t *len, const char *id)
+			     struct nvmem_cell_entry *cell,
+			     void *buf, size_t *len, const char *id, int index)
 {
 	int rc;
 
@@ -1430,7 +1445,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (nvmem->cell_post_process) {
-		rc = nvmem->cell_post_process(nvmem->priv, id,
+		rc = nvmem->cell_post_process(nvmem->priv, id, index,
 					      cell->offset, buf, cell->bytes);
 		if (rc)
 			return rc;
@@ -1465,7 +1480,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id);
+	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id, cell->index);
 	if (rc) {
 		kfree(buf);
 		return ERR_PTR(rc);
@@ -1778,7 +1793,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	if (rc)
 		return rc;
 
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL);
+	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL, 0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 14284e866f26..e9b52ecb3f72 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	return ret;
 }
 
-static int imx_ocotp_cell_pp(void *context, const char *id, unsigned int offset,
-			     void *data, size_t bytes)
+static int imx_ocotp_cell_pp(void *context, const char *id, int index,
+			     unsigned int offset, void *data, size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 50caa117cb62..8f964b394292 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -20,8 +20,8 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
-typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, unsigned int offset,
-					  void *buf, size_t bytes);
+typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
+					 unsigned int offset, void *buf, size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
-- 
2.30.2

