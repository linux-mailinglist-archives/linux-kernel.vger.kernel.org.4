Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4300868BE92
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBFNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjBFNox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBD265B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10817208wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuTt71lD8B/n2u59N4cGLt6TG19xWq8/kXTRq4dBA90=;
        b=lPZh/SlNhPkBN/EBEtMPXYtKfHR6e84GfMOfReruV5ruas0/VgSlpbhUpxWxCsPn5+
         +L/cTpLlzEieacLyNsVd31LJEe5g/9+XtqLY97GPF4KyLtTuN23NfciIQH6oo5zsuV1R
         iYCeJ1m2CgzhK/vPk1gGWn52MV4hb7lAI95ujLAoVxe/yA+IvSLfRv8xqP9gMMlB6kXT
         IG0AN/xP7nIPiWNaQ4fn3JYN4SlnMQwkXfS6lnDW90HSjJCMBnurI4M5hKJFqM47mgWJ
         tl8k+yYWEZ4Z+dzMBGYGvevQRcxRASj8DW8DuX99nIiIsfpLj7MijUit0ksixY0SAbja
         dhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuTt71lD8B/n2u59N4cGLt6TG19xWq8/kXTRq4dBA90=;
        b=4rzaer4P5r0L+QX9Ms0Mmltix5ATWtTlbFZ1Og6ugTEWkK15VYEUDzfCi0ZMOuU3cn
         G6kCoHTrI7ZHKvg4iaVcY1FupKJnp9GqxPzt5BTgeAr6r0owGsLoRTeLPzpDWyU6EPgg
         Foje6f9SrxAkKKEX/YRWZaueEmgL9ZWNrgkSQE50IT+FsMllmYTu2yPsp969FI8pkDcK
         9Fb4U343/BVrMKw31LBvJY3EIg2GMG9t2he78KpK525ZZrDPDsMzusCK4Q3FV6eSeNtZ
         SjEN+4fP7yHOKCtcEg8CnofVAv1jeXtfC9/T5u5xkI+3jStXUnhM5D+Ya3lDpmgxJMcc
         xsxg==
X-Gm-Message-State: AO0yUKUIev7NC5vAbaVCNQKMh+4jkmzwJwTdG6HsD4dzCnrkkkX8gJyH
        xPE3GXAhbY+U7Q86wgTgc/v69g==
X-Google-Smtp-Source: AK7set8EjhF6v8wrXbJxOIlrjTQPcQnG1R41c1zfXhaH13XFrAiQ7Qi6jsY+brkDJZTlWazstTXPHg==
X-Received: by 2002:a05:600c:35ca:b0:3df:f7cc:4da2 with SMTP id r10-20020a05600c35ca00b003dff7cc4da2mr6901629wmq.16.1675691066579;
        Mon, 06 Feb 2023 05:44:26 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:25 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 16/22] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
Date:   Mon,  6 Feb 2023 13:43:50 +0000
Message-Id: <20230206134356.839737-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

