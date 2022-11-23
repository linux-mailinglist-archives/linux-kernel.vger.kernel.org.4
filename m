Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8F636831
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiKWSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiKWSC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:26 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88397350;
        Wed, 23 Nov 2022 10:02:24 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E74BF3B2D;
        Wed, 23 Nov 2022 19:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669226543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXol5tT/oIFKZhTAd0NDm/tufouMejDDn5FNjp75nXI=;
        b=d42jT60xZRu6OI92S9R0pgqZ5Rr5mDmN1r2cDlA5DFBC/iHLLLHyRclbVm8cYR4xzuC5M/
        /RrCXHVcHLquLp3ENBOUklnFAAeKR/JHo/45/aqFdslL+tvMuIOERwy07yIt3QF2GWHZuL
        jNy9w9lDPAUg1OeLH+PWhXFYuMsw93b5DsfaxQjxt+++qedSmLFhpiOemn6yoK4xXGBc9e
        dc+ttW6spRW5F3gwoCffA9tDACTKV1WxXLBEPfmo0GNYi/GCCai6Xi/4N5Pjj+TBGlDOSM
        Xl84Rkcgn3zzUfN7UK648yWPEqJV73G37UaB7y76QugAB4rhL+7VyJBvk91Osw==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 10/20] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
Date:   Wed, 23 Nov 2022 19:01:41 +0100
Message-Id: <20221123180151.2160033-11-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123180151.2160033-1-michael@walle.cc>
References: <20221123180151.2160033-1-michael@walle.cc>
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
changes since v3:
 - none

changes since v2:
 - none

changes since v1:
 - new patch

 drivers/nvmem/core.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cb25bf29dea7..26459d582e99 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -688,15 +688,15 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
-	struct device_node *parent, *child;
 	struct device *dev = &nvmem->dev;
 	struct nvmem_cell_entry *cell;
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
@@ -712,34 +712,24 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			return -ENOMEM;
 		}
 
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

