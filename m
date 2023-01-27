Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FF67E2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjA0LTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjA0LSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE23B3E1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so4627876wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiSe+GBuFOro9IU25G1dPaAB4qi2H5ERUtgYWOzK1rc=;
        b=iXpf0mP2V2KhdwfBZ5oGYuv6EupKViiWXlhrW6PxPzfRnexaLYVBci+tAllOCPXli4
         TSfAS2N+wzepALfliE4PZfyzCalmSjfhC6cFiuj21G0UhNTF30F31AkkLtZ7yRJ/zFSU
         9v7k19kb0X/74MbPhu94zk+b+bU4+scR9YciPH8rDTdduJ5AXzEMiYxbmQLhW7E5bA1C
         N6fgpvyxhM0jv/tIhbezhMIgWcq07zjN8eYy0WXk2Onrs7zwbm8xSbCJalB/vFQkNJ/3
         f2v/sxt4G6vJwHkAc8FGisUPW/DdB5ns23ETICK3AbDXjhE8oaW/ymYCgSZyD8gfUayn
         T0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiSe+GBuFOro9IU25G1dPaAB4qi2H5ERUtgYWOzK1rc=;
        b=IotjLEc6Jxl6lSbANbq+Q2eK9xHRwyPDdPbQnTMl7YG5s11OfW9iK5dF/uSJ1AMu7c
         qbXu6xILDe1OR+lRsP+/fpJ68vrKK0KnLcHbus7M6LWuEIYNyfMAxmke9cl2NLooKJoF
         suxHCzus2/0dXuN0abpF2mq8A+enW3jLehURK7z9V8MYpqbRNRsTFda1qrubqc/bID2o
         QltjpH8HzL2fk/Y4BKi0NZm+v9rtpS8YQKyTloDp9Z7PdSLUtQEkjtwm+1ncqseOhn5z
         VC2JehTrcOCTtv+zdkXj/mu88aGKDhvoO/JeD2nx8AZyaXV5wqF7IUu/TjakkX+r8Kwb
         aEkg==
X-Gm-Message-State: AFqh2koo/2EUvDvqwAoB5SeQlX3QShuaqU5nUZ1ixzW5zRDbEochpUOj
        r8wtMd0x+hDxJTGhD4KIgJBAuQ==
X-Google-Smtp-Source: AMrXdXvinoQvkYcpJYi6y4TpFjpJE/9bsGIVPdtBh5mlowPaMI9/VixxyhkEwMiEFLyS9Z9v+GEvRg==
X-Received: by 2002:adf:f90e:0:b0:2bc:aa67:28fb with SMTP id b14-20020adff90e000000b002bcaa6728fbmr31093908wrr.49.1674818284789;
        Fri, 27 Jan 2023 03:18:04 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:04 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 18/37] nvmem: core: add per-cell post processing
Date:   Fri, 27 Jan 2023 11:15:46 +0000
Message-Id: <20230127111605.25958-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 17 +++++++++++++++++
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d2c427c5ebc6..80051726b064 100644
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
@@ -1545,6 +1547,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
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
@@ -1653,6 +1662,14 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
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
2.25.1

