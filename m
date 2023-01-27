Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D822567E2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjA0LTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjA0LSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B312047
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so4640929wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuTt71lD8B/n2u59N4cGLt6TG19xWq8/kXTRq4dBA90=;
        b=TggSNnmO+S1xOyxL1gxoWnyoTzZApGY8ER4pOfOMvOADbyJrozqByVmDDVsOGFLDOM
         faQ5f9MiZJf9uayk8NZUWxELptgHvTKGLgsjEJsXBO9L6I/0QDU1kv7HGOnDQyRDxKXB
         /kXu45KekG3U8s5tEQRB8l/6UslB+HBgeYDmQlEkahsje4cszCxWku6bojwSMg63GLyi
         JiZkVav4vecsnURvB8hb6mUZTls48xorQTzPaHvRJRojzBjLVhtDRxMKT3i0e3UjCkuP
         fik+39hxUpANsiBkqB/Aj0Isq+oUMV0Kr4octLnyvj+NEie/JIM5/Wcr5OfCQuSRaBYV
         L7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuTt71lD8B/n2u59N4cGLt6TG19xWq8/kXTRq4dBA90=;
        b=4e7kMaTAnxjrVujVsTj8sgAwIJvV/PG7H+vKnhzXAb8pHPDwfLlY41e4kXkyQRk8TK
         KtsuSlEJHmBDnl8GE/7iG8CFQWtlWtgJIMssPIweQDmXxdCTKxWFXaYIpY8KLVib+5iS
         W9z07Wd/EKCQAEoyfAe3YqiCkHvC5ke54cY5TMQLt6j8hvUoBeq7jfZtIXfsHWInxFe3
         72Pq6D2lA7cpHZLMtG7+8cN9BQpewSpOqqm1mzLRFXdLu0TGh0zU0pD3xWxB5I732eUN
         ObndbaRosSn7u5Nu+Up8gC1idr7JA6ZZ6WdM2QjUj/YJo9gJ1Csh0lslIlHnPyrrP8ld
         +pMA==
X-Gm-Message-State: AO0yUKV1Le+DVsy98GP+5e/bBNSY1/0InNt1XG+Ko74ARIhwUdqNfjV+
        LzETMSzOd0jZnWxI9nLmIISHEKsrC/I5dwSD
X-Google-Smtp-Source: AK7set9KGYBy6ambnD6CqvEJ61EmvdrnBnDIlUBz6uIe23P0EkiF51O40m0Wyr/W2dj+tPmzZe85Pw==
X-Received: by 2002:adf:f841:0:b0:2bf:d686:c873 with SMTP id d1-20020adff841000000b002bfd686c873mr833937wrq.28.1674818281756;
        Fri, 27 Jan 2023 03:18:01 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 16/37] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
Date:   Fri, 27 Jan 2023 11:15:44 +0000
Message-Id: <20230127111605.25958-17-srinivas.kandagatla@linaro.org>
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

