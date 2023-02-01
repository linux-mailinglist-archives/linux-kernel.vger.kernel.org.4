Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A266870C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBAWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjBAWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:00:23 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147D7266F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:00:19 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id bx13so11149212oib.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XkbBn50HbU84B9DuICUZoT4NR3IzYgz7CKBq7MuAxw=;
        b=4n8H8qmqtFsHfszHzHtrf1VTHNp342jQiJP9qitPmeiYxBH6RlyLQIO2Leqx7yfYRx
         uU6D5C5V+Ar8OMWpM0QQJV6YP7AE1vg4eiiwlO+Uv4CrLz9W9fT+Py7bYgnVqCYwWmcE
         XhFdp4kxtAio9Rs6uluQORJMlHeCwcP+iRcnvOlrGodzUSBRCt8Nm7A3tv0h5f5yuCPd
         UOraqeQXEd+LCBrFbhO6tHP4pXOMxQTe7gghl8JCnYmvvL43HJpZDE2pIC/qhNhRwP61
         nfEuvIsknMDCDUTcA5E2azzkZzDhgUmcM/MWRYAxwoK/yKrzZjQXJPuDsCX2mPxCSYWd
         bqkA==
X-Gm-Message-State: AO0yUKWF93goHTjYd0chMM6KCZP2xRO2wgVFjXIGEhOORZWZycw0bNew
        MUC2lEnL14trEWpg9fcolOx/G5yVOg==
X-Google-Smtp-Source: AK7set+jOLkoidQpkXezdpSyqHhfDQEIuM5uDLkeDa17UAn3sp+hbfiK31GUqWVbrvLf1BpYzxvwBg==
X-Received: by 2002:a05:6808:ab7:b0:367:18a6:eb26 with SMTP id r23-20020a0568080ab700b0036718a6eb26mr1802405oij.42.1675288818506;
        Wed, 01 Feb 2023 14:00:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a186-20020acab1c3000000b00363760f96dcsm7308714oif.42.2023.02.01.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:00:17 -0800 (PST)
Received: (nullmailer pid 247224 invoked by uid 1000);
        Wed, 01 Feb 2023 22:00:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: unifier-system-bus: Remove open coded "ranges" parsing
Date:   Wed,  1 Feb 2023 16:00:11 -0600
Message-Id: <20230201220011.247100-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property and we have common helper functions for
parsing it, so let's use them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only!
---
 drivers/bus/uniphier-system-bus.c | 54 +++++++------------------------
 1 file changed, 11 insertions(+), 43 deletions(-)

diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index f70dedace20b..cb5c89ce7b86 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -176,10 +176,9 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_system_bus_priv *priv;
-	const __be32 *ranges;
-	u32 cells, addr, size;
-	u64 paddr;
-	int pna, bank, rlen, rone, ret;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -191,48 +190,17 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 
-	pna = of_n_addr_cells(dev->of_node);
-
-	ret = of_property_read_u32(dev->of_node, "#address-cells", &cells);
-	if (ret) {
-		dev_err(dev, "failed to get #address-cells\n");
-		return ret;
-	}
-	if (cells != 2) {
-		dev_err(dev, "#address-cells must be 2\n");
-		return -EINVAL;
-	}
-
-	ret = of_property_read_u32(dev->of_node, "#size-cells", &cells);
-	if (ret) {
-		dev_err(dev, "failed to get #size-cells\n");
+	ret = of_range_parser_init(&parser, dev->of_node);
+	if (ret)
 		return ret;
-	}
-	if (cells != 1) {
-		dev_err(dev, "#size-cells must be 1\n");
-		return -EINVAL;
-	}
 
-	ranges = of_get_property(dev->of_node, "ranges", &rlen);
-	if (!ranges) {
-		dev_err(dev, "failed to get ranges property\n");
-		return -ENOENT;
-	}
-
-	rlen /= sizeof(*ranges);
-	rone = pna + 2;
-
-	for (; rlen >= rone; rlen -= rone) {
-		bank = be32_to_cpup(ranges++);
-		addr = be32_to_cpup(ranges++);
-		paddr = of_translate_address(dev->of_node, ranges);
-		if (paddr == OF_BAD_ADDR)
+	for_each_of_range(&parser, &range) {
+		if (range.cpu_addr == OF_BAD_ADDR)
 			return -EINVAL;
-		ranges += pna;
-		size = be32_to_cpup(ranges++);
-
-		ret = uniphier_system_bus_add_bank(priv, bank, addr,
-						   paddr, size);
+		ret = uniphier_system_bus_add_bank(priv,
+						   upper_32_bits(range.bus_addr),
+						   lower_32_bits(range.bus_addr),
+						   range.cpu_addr, range.size);
 		if (ret)
 			return ret;
 	}
-- 
2.39.0

