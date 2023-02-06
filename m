Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B568BA26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBFK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBFK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F631EBEC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10413337wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiSe+GBuFOro9IU25G1dPaAB4qi2H5ERUtgYWOzK1rc=;
        b=trqOQmZboMzCVT6US8AA0xejQw3vI04MF20TX6/Kun5Wpt+WrwvHc/tKYY5mkmf2TR
         prhxOdHZmeKeGWcGz4SLbzXTM1EYK2U8GRm7fIqbNjebZ8OO+l25hNfhBYissXwMRkfh
         qEIiXzvX75dIZV35Ne+6XMZN0tPE5IlPyjzl6z9knrzhQpQxxn1uyRGX5xC1jrxzo0z6
         lEA49lISeqpZ26DyqAm0hVE2vhQPYgMp5Ugv3Jki7s9Atq190I7ybef5EcdYae2e36PE
         vb4f+wlYGaRyPbwsdb2rkDjoy6/dkmayGkmZU0u7oylFmjWaOC8d/jt29IooFtVOoTy8
         ta1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiSe+GBuFOro9IU25G1dPaAB4qi2H5ERUtgYWOzK1rc=;
        b=sosjMxOfkTeiDrk4cDc4uC0CMBw9racL3fvT8Rojs6k0QDU7sH2tNn37PN7RiEXQJy
         rPuZSDbteWo2u0/g6+OyvfmdjKT9hprPiz0yWaVn0+XKoBHWe+QdFQGwYfQFsLZmRu/g
         TM+qVDEU3dauCJZlSG2PeNMzmnN7DT1flGWrCGCxqOt+EQLwAglecbQgtTGHQ0niVBmD
         Lzuy2EfJAThT8Bjb17MsA1Uad2nx+Mjg0jWTOjrD7DDmqzjcTWpCyVFMlALPrtEqrin7
         sIGXMeoqHXXeLUc8zuNyUHjR1OKry09Fi6c+TEPZHWrXVlTFBagnho/xnFzrYOAyB4mN
         rmXg==
X-Gm-Message-State: AO0yUKV2OOXxSDZJL+R7PAHcEZmylrge5JfSBQ6sq/YkY/Il4N6dDVRH
        hoo+md6hs9smK07RAGUJ68xeumcDXshgvNvq
X-Google-Smtp-Source: AK7set+Snda63TAYsi68rur+gRuGXqvl/APszlqiglr3NbHqBVt8bApdPxkL+bg7HCFyrYGY4jaJlQ==
X-Received: by 2002:a05:600c:314a:b0:3df:eeaa:816d with SMTP id h10-20020a05600c314a00b003dfeeaa816dmr6273008wmo.28.1675679316081;
        Mon, 06 Feb 2023 02:28:36 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 18/37] nvmem: core: add per-cell post processing
Date:   Mon,  6 Feb 2023 10:27:40 +0000
Message-Id: <20230206102759.669838-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

