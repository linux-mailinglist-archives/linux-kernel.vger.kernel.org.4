Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7F62FD41
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiKRSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiKRSvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:51:54 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9E78FE79;
        Fri, 18 Nov 2022 10:51:53 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 02CB4266F;
        Fri, 18 Nov 2022 19:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668797490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGxXXy0kIf1UzrkGm+tZ3CrPqpHJ4nUU5CZdnlTTc7g=;
        b=f0mo8oXSNw4/RiNHSh8GAYR/ZkmbNaA7R5OGhlLEEt9iwuSlZv+fMcAvaz98TZ6Tg3Yd19
        j9Ms9zE/bEgbnBZMIeJxZbuT8rC7DP+ga1CVdjO2MS4DVL/ZaGrZi+z0v3iJPPlGYJ2ErF
        1p5EWzuyNl+k8zlquBLdFZjQGPBgpbhgO1LgVod2Z74rsDFw3968IInmOXtqdZPEdFBUls
        Gb+5JAWflplGyb+bGKMUZ1Umfs57HCltcYavBcs0Y4Elv1NeSNQvnQBGDz38liYhNmVIfV
        S4NBfBnjZdDPRxLFofNTS1P3QYUQuNGREpONg12VvdpF1X5lYnzt0Tw2omnN2Q==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 10/18] nvmem: core: add per-cell post processing
Date:   Fri, 18 Nov 2022 19:51:10 +0100
Message-Id: <20221118185118.1190044-11-michael@walle.cc>
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

Instead of relying on the name the consumer is using for the cell, like
it is done for the nvmem .cell_post_process configuration parameter,
provide a per-cell post processing hook. This can then be populated by
the NVMEM provider (or the NVMEM layout) when adding the cell.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - none

changes since v1:
 - rename hook to read_post_process

 drivers/nvmem/core.c           | 17 +++++++++++++++++
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4ad1a02faf30..f0c0bf3b8b25 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -53,6 +53,7 @@ struct nvmem_cell_entry {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
+	nvmem_cell_post_process_t read_post_process;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -469,6 +470,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
 	cell->name = info->name;
+	cell->read_post_process = info->read_post_process;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1553,6 +1555,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
+	if (cell->read_post_process) {
+		rc = cell->read_post_process(nvmem->priv, id, index,
+					     cell->offset, buf, cell->bytes);
+		if (rc)
+			return rc;
+	}
+
 	if (nvmem->cell_post_process) {
 		rc = nvmem->cell_post_process(nvmem->priv, id, index,
 					      cell->offset, buf, cell->bytes);
@@ -1661,6 +1670,14 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 	    (cell->bit_offset == 0 && len != cell->bytes))
 		return -EINVAL;
 
+	/*
+	 * Any cells which have a read_post_process hook are read-only because
+	 * we cannot reverse the operation and it might affect other cells,
+	 * too.
+	 */
+	if (cell->read_post_process)
+		return -EINVAL;
+
 	if (cell->bit_offset || cell->nbits) {
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 4185767c114f..1930496d8854 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -54,6 +54,8 @@ struct nvmem_keepout {
  * @bit_offset:	Bit offset if cell is smaller than a byte.
  * @nbits:	Number of bits.
  * @np:		Optional device_node pointer.
+ * @read_post_process:	Callback for optional post processing of cell data
+ *			on reads.
  */
 struct nvmem_cell_info {
 	const char		*name;
@@ -62,6 +64,7 @@ struct nvmem_cell_info {
 	unsigned int		bit_offset;
 	unsigned int		nbits;
 	struct device_node	*np;
+	nvmem_cell_post_process_t read_post_process;
 };
 
 /**
-- 
2.30.2

