Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FD68BA27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjBFK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBFK2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAAD1EBC8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o36so8300750wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuTt71lD8B/n2u59N4cGLt6TG19xWq8/kXTRq4dBA90=;
        b=sDpY0J/nG6QSE6RneUOkJa6qmtNn/t9zh2ccWxS7SgFOyDBWgYwGiE/5WTvqcdl+PC
         uIBgRQK5DzTAEOZ/ZBEPP9YXaQPwI8UnbkP5h0r2vkavGtsotmqbpLCYpOR92riP259f
         E7+1/RLgybW72AHdYbSnBw5+d6znnPoXWvwW+/6lgwVv4xPdbene882EYldXWv6wK3u/
         TKwitfwWhoW6aNJddByx1cXWvxnpifbnlhqmVpU+77pXDCQdr2qn9BJXWlzbCkDYks9W
         B7g0yS17h/Hc1VN1KyDwVpSv8vKtj/XGfwhTXvpjdPXU3z2wYklAoLgu1JC5TsazqPpH
         8Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuTt71lD8B/n2u59N4cGLt6TG19xWq8/kXTRq4dBA90=;
        b=x9Mj6FkQujJjVPpGdlr3J7pYlpNr42Sy8QzS5O7BvLlpqzCkuVqgw4xhzRjwuC36Re
         LwwpeST1vpbu+UbB569100h5tG7S1bQ5vTpOM2mac9AcVFeDxK51eeIooO/K/6Pb21+c
         axtckOmw3wXycBCbALgel9n57WaeDCCAUYKLHsJnbv8nHi8+2q5FCELBENnmDsszgnKa
         c+c8/q7OK3TMYkpthicbh0+cFAD4XhK6Pzt/3/FaRqWHAop78VyK6q9rqRptmXs/t5P+
         8pNZrdWAgB5UoTvs0LHuTHCgw5Y2+6HrcEH1AWxBGKIcgYGM4fomZN7zfryrUXPXDkPQ
         cVsg==
X-Gm-Message-State: AO0yUKWFmGWReBb5G/2LaaBW15B5LG4HPBS+S0nifpdjcl3VO3SqSZTI
        DUwn+WsgbiAJE6GLMZVCERREKxrNXlioAznt
X-Google-Smtp-Source: AK7set+j3mzD54y3lcLXa4qNs5So7Zu9m87jIaahWbR0DPl9EMWmLf4KMDm5REgzGFvPA41uUHZKYQ==
X-Received: by 2002:a05:600c:4e54:b0:3df:f7ba:14e1 with SMTP id e20-20020a05600c4e5400b003dff7ba14e1mr7425635wmq.8.1675679313654;
        Mon, 06 Feb 2023 02:28:33 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 16/37] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
Date:   Mon,  6 Feb 2023 10:27:38 +0000
Message-Id: <20230206102759.669838-17-srinivas.kandagatla@linaro.org>
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

Convert nvmem_add_cells_from_of() to use the new nvmem_add_one_cell().
This will remove duplicate code and it will make it possible to add a
hook to a nvmem layout in between, which can change fields before the
cell is finally added.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 45 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 58f8e33e7a8c..174ef3574e07 100644
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
2.25.1

