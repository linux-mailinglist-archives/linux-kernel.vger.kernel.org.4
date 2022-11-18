Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90062FD2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbiKRSwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbiKRSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:51:42 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215F93CDE;
        Fri, 18 Nov 2022 10:51:28 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6A0D71D3E;
        Fri, 18 Nov 2022 19:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668797486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8O2KQMPE2O01M8v+SA8VCZdDXPSXBpYyoavVmhy8dQ=;
        b=Qee//rjRncNfbLFAxm3ewFj+I//0OcA9y80MhumWzUPQEQB9x1Acvl4IFFqChpXqAl3fmm
        Bv4ipBpOjzB9rfy58nQ8V2AoP5xFI6d1PbL8OUuomKjsEXRIPyBxWsMNmJklWg4F61AP+h
        JqDXbbJQt7oNiUc9TwuHGUdphPd+DIB8kB5Yt08tf4VDEXl+jNFxYwAXE78ZBVCrHq2Dg9
        4LVFYoh+DRfmjvIFWN4/yiGj+1b2tQeIDazBgg6Iu2de+dbencTUHPz81vfzvJC04RLpCQ
        g6fY/RFz8s4yDskD8NFLf18C0bfOGPb4jWVR0bEMiWQ+3DpfP5LVnexpLGIYPQ==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 03/18] nvmem: core: fix device node refcounting
Date:   Fri, 18 Nov 2022 19:51:03 +0100
Message-Id: <20221118185118.1190044-4-michael@walle.cc>
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

In of_nvmem_cell_get(), of_get_next_parent() is used on cell_np. This
will decrement the refcount on cell_np, but cell_np is still used later
in the code. Use of_get_parent() instead and of_node_put() in the
appropriate places.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - new patch

 drivers/nvmem/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..205a427f564d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1242,16 +1242,21 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	if (!cell_np)
 		return ERR_PTR(-ENOENT);
 
-	nvmem_np = of_get_next_parent(cell_np);
-	if (!nvmem_np)
+	nvmem_np = of_get_parent(cell_np);
+	if (!nvmem_np) {
+		of_node_put(cell_np);
 		return ERR_PTR(-EINVAL);
+	}
 
 	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
 	of_node_put(nvmem_np);
-	if (IS_ERR(nvmem))
+	if (IS_ERR(nvmem)) {
+		of_node_put(cell_np);
 		return ERR_CAST(nvmem);
+	}
 
 	cell_entry = nvmem_find_cell_entry_by_node(nvmem, cell_np);
+	of_node_put(cell_np);
 	if (!cell_entry) {
 		__nvmem_device_put(nvmem);
 		return ERR_PTR(-ENOENT);
-- 
2.30.2

