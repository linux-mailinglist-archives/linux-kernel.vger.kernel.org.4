Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C4636841
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiKWSEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiKWSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:38 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C35538B0;
        Wed, 23 Nov 2022 10:02:27 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7D1AC322F;
        Wed, 23 Nov 2022 19:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669226545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWIy14I/UvLVcaIWHNN4F1QfxaBMysU7plut6EIoZF4=;
        b=IE1H+doMlIY1EfJeSW2TWe9C7687yXBsjzdNWihFHWDcTM9TQifBJovYRcBzUtzhHfq9J9
        iwCba5GXwfX6HxxViisFb98uUN68gZom9Xf1LMh1H0rhmdYrj+wUpKMGIKNXSOc4bT3EB1
        TbCMQ+u6c9XSvWj3HulbEgK6ifW5oVHQmNzr3B56Wfz5BTM3BkANvMYzh4QtjPN7eLkpyz
        PQXuKyRi/oyxTNHfX83wSof+YCMTz34JItJs+EkPBtgpEVrfVB36NUjnpIqEKjWjvHneld
        oaPG1/KM06E02l4K8Eq0xH1Ts2NHLYO8Kga79PLmBFdHTcjpk0z8cHnZQ67A8g==
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
Subject: [PATCH v4 16/20] nvmem: core: provide own priv pointer in post process callback
Date:   Wed, 23 Nov 2022 19:01:47 +0100
Message-Id: <20221123180151.2160033-17-michael@walle.cc>
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

It doesn't make any more sense to have a opaque pointer set up by the
nvmem device. Usually, the layout isn't associated with a particular
nvmem device. Instead, let the caller who set the post process callback
provide the priv pointer.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v3:
 - none

changes since v2:
 - don't drop the pointer but let the user specify an opaque pointer

changes since v1:
 - new patch

 drivers/nvmem/core.c           | 4 +++-
 include/linux/nvmem-provider.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 5733bf79dda1..a52c810e9b02 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -53,6 +53,7 @@ struct nvmem_cell_entry {
 	int			bit_offset;
 	int			nbits;
 	nvmem_cell_post_process_t read_post_process;
+	void			*priv;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -470,6 +471,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->bytes = info->bytes;
 	cell->name = info->name;
 	cell->read_post_process = info->read_post_process;
+	cell->priv = info->priv;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1562,7 +1564,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (cell->read_post_process) {
-		rc = cell->read_post_process(nvmem->priv, id, index,
+		rc = cell->read_post_process(cell->priv, id, index,
 					     cell->offset, buf, cell->bytes);
 		if (rc)
 			return rc;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 12833fe4eb4d..cb0814f2ddae 100644
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
2.30.2

