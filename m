Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFC6B0CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjCHPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjCHPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:54 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68360DB6E8;
        Wed,  8 Mar 2023 07:32:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C833FF812;
        Wed,  8 Mar 2023 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPt8JXf9NOQ0MTpLZEyB4ihbzR5v6xSqNymS3y+vPl0=;
        b=CfKOeyVv7kx4wu/bRzKxXPq0xmAQGDmLNLLkbr5p0GGKW3ZIoIY/hljgB8sRYaLoR/fbnZ
        8my+azHW9vZ6PVvrt8OAHO0+ds9JHludsMDnExbbP9QHk+LsR148/Jv9GB05vJziBJ68ek
        8Yt+iuCEX+X/21JTp06E6xDf4dNfgTl+WDq0ZDqE3B0P3dJqfjvhcDw2eGuWJNreWiSWZ+
        OVIOiWys3DdLz9yyV88dfD10lsyiMfUO7TpnLnJ3aBlyFk4ooUO8CyOiCdJWcJ1GcQkbBL
        jgW1Y9Lmlqbjj27jfNwUKuZKRYnMxXe65VdI94UyenqQZCG5lEeGeVgFhHeFZw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 12/20] nvmem: core: add per-cell post processing
Date:   Wed,  8 Mar 2023 16:31:52 +0100
Message-Id: <20230308153200.682248-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Instead of relying on the name the consumer is using for the cell, like
it is done for the nvmem .cell_post_process configuration parameter,
provide a per-cell post processing hook. This can then be populated by
the NVMEM provider (or the NVMEM layout) when adding the cell.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 17 +++++++++++++++++
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 49b4bbaf59e8..0708f9f27898 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -54,6 +54,7 @@ struct nvmem_cell_entry {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
+	nvmem_cell_post_process_t read_post_process;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -470,6 +471,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
 	cell->name = info->name;
+	cell->read_post_process = info->read_post_process;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1563,6 +1565,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
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
@@ -1671,6 +1680,14 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
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
index 535c5f9f3309..3bfc23553a9e 100644
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
2.34.1

