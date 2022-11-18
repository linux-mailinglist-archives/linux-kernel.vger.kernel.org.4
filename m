Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8653F62FD44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbiKRSww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242878AbiKRSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:51:56 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E78FE74;
        Fri, 18 Nov 2022 10:51:54 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8EB332457;
        Fri, 18 Nov 2022 19:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668797488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KglAEmBx7k7GHRnoGp1f+VG/5KRaSEwVNOp3438K3mE=;
        b=THuuo4/SGaLbc7NIU2TDCHSmaFRPbNaqgvgMB542zdtHzUuS3xgfe4L+trFrIp1Xfo0uLz
        jpXa5LeejmVIx7aGUfCQemQtWGV6apKutprUncJrJrR36nrO08+IbdplWRhhK+oBWOuZjo
        4+beqh+N99Hupoy/jhcwB2Ti1DrrZSpwLk+CRR4kJY0zP0eQn5hO6Q1+Z8tK4lGjOKGGY9
        +/oB7Vgv706lksscvNpvWQa+uPcHk5+MYFef93yXS2KdpdoadVrkIPEIuaQoBAIoE/0Kql
        g1OFjUDQzX1PBWLRrFAfnn34EXVYmsKFCMa7D3AeZPODtrYL6HLXVggkMXUBBQ==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 07/18] nvmem: core: add nvmem_add_one_cell()
Date:   Fri, 18 Nov 2022 19:51:07 +0100
Message-Id: <20221118185118.1190044-8-michael@walle.cc>
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

Add a new function to add exactly one cell. This will be used by the
nvmem layout drivers to add custom cells. In contrast to the
nvmem_add_cells(), this has the advantage that we don't have to assemble
a list of cells on runtime.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - add EXPORT_SYMBOL_GPL()

changes since v1:
 - none

 drivers/nvmem/core.c           | 59 ++++++++++++++++++++--------------
 include/linux/nvmem-provider.h |  8 +++++
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7c76e0e0072e..cb25bf29dea7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -501,6 +501,36 @@ static int nvmem_cell_info_to_nvmem_cell_entry(struct nvmem_device *nvmem,
 	return 0;
 }
 
+/**
+ * nvmem_add_one_cell() - Add one cell information to an nvmem device
+ *
+ * @nvmem: nvmem device to add cells to.
+ * @info: nvmem cell info to add to the device
+ *
+ * Return: 0 or negative error code on failure.
+ */
+int nvmem_add_one_cell(struct nvmem_device *nvmem,
+		       const struct nvmem_cell_info *info)
+{
+	struct nvmem_cell_entry *cell;
+	int rval;
+
+	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return -ENOMEM;
+
+	rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, info, cell);
+	if (rval) {
+		kfree(cell);
+		return rval;
+	}
+
+	nvmem_cell_entry_add(cell);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_add_one_cell);
+
 /**
  * nvmem_add_cells() - Add cell information to an nvmem device
  *
@@ -514,34 +544,15 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		    const struct nvmem_cell_info *info,
 		    int ncells)
 {
-	struct nvmem_cell_entry **cells;
-	int i, rval = 0;
-
-	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
-	if (!cells)
-		return -ENOMEM;
+	int i, rval;
 
 	for (i = 0; i < ncells; i++) {
-		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
-		if (!cells[i]) {
-			rval = -ENOMEM;
-			goto out;
-		}
-
-		rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, &info[i], cells[i]);
-		if (rval) {
-			kfree(cells[i]);
-			goto out;
-		}
-
-		nvmem_cell_entry_add(cells[i]);
+		rval = nvmem_add_one_cell(nvmem, &info[i]);
+		if (rval)
+			return rval;
 	}
 
-out:
-	/* remove tmp array */
-	kfree(cells);
-
-	return rval;
+	return 0;
 }
 
 /**
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 14a32a1bc249..385d29168008 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -155,6 +155,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
+int nvmem_add_one_cell(struct nvmem_device *nvmem,
+		       const struct nvmem_cell_info *info);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -172,6 +175,11 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
+static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
+				     const struct nvmem_cell_info *info)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.30.2

