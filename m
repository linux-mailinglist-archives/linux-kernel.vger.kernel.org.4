Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF186AE7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCGQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:13 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85EA943AD;
        Tue,  7 Mar 2023 08:55:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F317EC0004;
        Tue,  7 Mar 2023 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lm8Fo8GltNhElaI0RcGviH0CBmxuVxbmsI/nBgU01Rc=;
        b=FrPKkgO+1fcjp2bepCD+d6vTWTmXiUpGQ3IkRThmns1bDR1s2lSX6Pv9L2EXj2cUv4KdTd
        3hAXz+eUmhKVhDV5izAIjL6168bfQGgaORJNR+CiV+i43z+btSOAwGxZ57jgU5yxrC4c8i
        voEs/YVJ+UdSYWhsROfWRMKYItbtZU5Fod3j74edqjuFh2JorRaMss2xu13rvmH7khJxTz
        fUJQVyLpJTl0lEwvUaCiwBI5Nux7STF8yen3lRf2E9pav1QRsVUtAw6V1IBIjms7HOEyRy
        fEns7dpG/0DnJTGA2FmoZyZmwhAHQW/cwVpYIFT8nGl5yhXTRUgsqWwOIGixEA==
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
Subject: [PATCH v2 17/21] nvmem: core: provide own priv pointer in post process callback
Date:   Tue,  7 Mar 2023 17:53:55 +0100
Message-Id: <20230307165359.225361-18-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
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

It doesn't make any more sense to have a opaque pointer set up by the
nvmem device. Usually, the layout isn't associated with a particular
nvmem device. Instead, let the caller who set the post process callback
provide the priv pointer.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 4 +++-
 include/linux/nvmem-provider.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 31d1d10c0e1c..8e07b9df3221 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -54,6 +54,7 @@ struct nvmem_cell_entry {
 	int			bit_offset;
 	int			nbits;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -471,6 +472,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->bytes = info->bytes;
 	cell->name = info->name;
 	cell->read_post_process = info->read_post_process;
+	cell->priv = info->priv;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1568,7 +1570,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (cell->read_post_process) {
-		rc = cell->read_post_process(nvmem->priv, id, index,
+		rc = cell->read_post_process(cell->priv, id, index,
 					     cell->offset, buf, cell->bytes);
 		if (rc)
 			return rc;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index d3d7af86a283..0cf9f9490514 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -20,7 +20,8 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
 typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
-					 unsigned int offset, void *buf, size_t bytes);
+					 unsigned int offset, void *buf,
+					 size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -56,6 +57,7 @@ struct nvmem_keepout {
  * @np:		Optional device_node pointer.
  * @read_post_process:	Callback for optional post processing of cell data
  *			on reads.
+ * @priv:	Opaque data passed to the read_post_process hook.
  */
 struct nvmem_cell_info {
 	const char		*name;
@@ -65,6 +67,7 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 	struct device_node	*np;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 };
 
 /**
-- 
2.34.1

