Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E4644D05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLFUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLFUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:55 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041518356;
        Tue,  6 Dec 2022 12:07:52 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3F3E33B3D;
        Tue,  6 Dec 2022 21:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wuDmiAG2lNQr5F+Y/u377Zv6TIAoB3gQ2DuFpKEqzG0=;
        b=xXm6zyXMvjwyzHY3/mrx2gMzr/Yk8wiy7PgLg1+wyr6l+zy7dp1fGSdPPQUe1hR1Ca+w7F
        JyV9OCIHEx7j1thtXOM2aHbyHO5kkbl1doqkl29v95t7IAm06cpp2XFC/9qtFDeqnCy93o
        Maz4eSKDSKkGAfRbdzxxuZkhJVR4ij8NzhY6Ab3Q6ZS/0Uj4Z7172ZNTYGam+9WtDXvwjH
        DKEUSXCP/RqM9DGvWE9jt4ZNH+vnKPTDTz11ojXlAgmlpZBnqV0Rimstkx7b6w9LwMeDuW
        hYMSoaj4izyG5MElD1XZHzGJuyBwJnJ0Eo2jfJLKCwVZw1NPfzNkauYYCiiswA==
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
Subject: [PATCH v5 11/21] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
Date:   Tue,  6 Dec 2022 21:07:30 +0100
Message-Id: <20221206200740.3567551-12-michael@walle.cc>
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

Convert nvmem_add_cells_from_of() to use the new nvmem_add_one_cell().
This will remove duplicate code and it will make it possible to add a
hook to a nvmem layout in between, which can change fields before the
cell is finally added.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v4:
 - drop now unused allocation of nvmem_cell_entrys, thanks Dan

changes since v3:
 - none

changes since v2:
 - none

changes since v1:
 - new patch

 drivers/nvmem/core.c | 45 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 5db169aa7988..0993e1ebdeaf 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -688,15 +688,14 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
-	struct device_node *parent, *child;
 	struct device *dev = &nvmem->dev;
-	struct nvmem_cell_entry *cell;
+	struct device_node *child;
 	const __be32 *addr;
-	int len;
+	int len, ret;
 
-	parent = dev->of_node;
+	for_each_child_of_node(dev->of_node, child) {
+		struct nvmem_cell_info info = {0};
 
-	for_each_child_of_node(parent, child) {
 		addr = of_get_property(child, "reg", &len);
 		if (!addr)
 			continue;
@@ -706,40 +705,24 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			return -EINVAL;
 		}
 
-		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
-		if (!cell) {
-			of_node_put(child);
-			return -ENOMEM;
-		}
-
-		cell->nvmem = nvmem;
-		cell->offset = be32_to_cpup(addr++);
-		cell->bytes = be32_to_cpup(addr);
-		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
+		info.offset = be32_to_cpup(addr++);
+		info.bytes = be32_to_cpup(addr);
+		info.name = kasprintf(GFP_KERNEL, "%pOFn", child);
 
 		addr = of_get_property(child, "bits", &len);
 		if (addr && len == (2 * sizeof(u32))) {
-			cell->bit_offset = be32_to_cpup(addr++);
-			cell->nbits = be32_to_cpup(addr);
+			info.bit_offset = be32_to_cpup(addr++);
+			info.nbits = be32_to_cpup(addr);
 		}
 
-		if (cell->nbits)
-			cell->bytes = DIV_ROUND_UP(
-					cell->nbits + cell->bit_offset,
-					BITS_PER_BYTE);
+		info.np = of_node_get(child);
 
-		if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
-				cell->name, nvmem->stride);
-			/* Cells already added will be freed later. */
-			kfree_const(cell->name);
-			kfree(cell);
+		ret = nvmem_add_one_cell(nvmem, &info);
+		kfree(info.name);
+		if (ret) {
 			of_node_put(child);
-			return -EINVAL;
+			return ret;
 		}
-
-		cell->np = of_node_get(child);
-		nvmem_cell_entry_add(cell);
 	}
 
 	return 0;
-- 
2.30.2

