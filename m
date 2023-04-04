Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17386D6A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjDDRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjDDRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCA5B8C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so133634548edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55/HsPbECFGP1PL1OpKRnZp06obnPN7JssLV3bTa6kY=;
        b=M2E8W7Y02eGJTtZLnCueU6ATNrT5ScFOYtIpHpI6zkuUbqW2HMGzI7zjFrQXEgifx0
         WdvzH8z0pO03ulESrFKOYHRhB5xn2Kml/odEK44rAKPzuQi2MpUE7+0Q5U51BDDln614
         kcWtiz+9ub8PdUv8K0CcMk12oBFE7iR+yxZoQYj9z5y8vODJFhA+vgAzv+XOAygudgL7
         2pn0ap+NCrgquBazcSU/LuZx1GKXcaDIU3V+jBtT1ygWufmIiUH3AXZp6BzV9EXLvwnC
         pNlG98EGcAS/gIfzcdN4RlOUKrrB1f+FD6tvbaa69BgoIzOCzTvVvsAUgRDMCd1wEo3J
         N85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55/HsPbECFGP1PL1OpKRnZp06obnPN7JssLV3bTa6kY=;
        b=6FITfr6jTeNYgzXOkfMSrD+l/lGKMSRnGuqfn4rP5+rXIgRgvHoW3Q3EVAX9212QB9
         vhyFliGZt9xIXyrcWonOmxbezarm/k1mzcvf2gMNzL7ghnpTOHnYE6AK/eNVByST70IO
         xbhZranjdiN5JpEOF0AI7kL2nZ412ibTDx3dL821xqyFunG47pUr8K2nN7bVA5Jo0frL
         xkFYNDLcjusqu8PLYPRdByEM+uqUoV14azDf6+/rEM0cqSIkQm7GyGR6AMfrzGVSzVCj
         9AVQKNiGLmRLi8BP19OIRbICkRsr6c6uBtr+gRmsb7wFyBG82dLq9CGc5KFDudc/2qdm
         lkyA==
X-Gm-Message-State: AAQBX9eom7vGgbQv5d3fI8Q8zmNx7dJ597hc5X/W4BJglxSZfsgWpN3j
        /M5y6YxKzC5ZsKdJwXH7TVLfhQyJwNKKJolMzNA=
X-Google-Smtp-Source: AKy350ZtaeK3xkljnG68nVeuKnVaADFrYvNxg6n4gVOp2b/NZ9URm2GVykRELvPzJ2q8+ff7GuPHVQ==
X-Received: by 2002:a17:906:e0c7:b0:895:58be:957 with SMTP id gl7-20020a170906e0c700b0089558be0957mr290833ejb.2.1680628964717;
        Tue, 04 Apr 2023 10:22:44 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 16/40] nvmem: core: add per-cell post processing
Date:   Tue,  4 Apr 2023 18:21:24 +0100
Message-Id: <20230404172148.82422-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

