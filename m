Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9C72A24E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFIScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjFIScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:32:47 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017314206
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:32:31 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33e4e59da95so9046905ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335551; x=1688927551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1tsdW879hEz8ZM1hUfjQy+GQmzb7YudBjWdJTwNOWo=;
        b=eyiJ3Pb3dhZfVgHzheVpzDYpFsrnIDbwPu3D7eWJjJglCtgPJvORm2Ju2Ojb4nEjnY
         Jj/XaBPGk24GLmv2dY9gIQSDETWn6HuGx3Jwu2z50rtLjTFZ0RgxfQvw80rHpXpHX/PR
         aOLuepU1cougRTaAWIyO0acuaLVtUUg1hm3m0hTNTMtByyjmLNuSpCgmrdMn2tDKhAB6
         Z9hBPMP88dEZPfuxr1YG7qKPlsgnl104Z0BEiRVLd70HGhundyH4wruA+UC1ciYnygVl
         h2w97t2JSjCthjeaacAH9L9RLozRf1qaz5Sdx7wWGUE4n7PQvQi9LzMu9xj2v2hJ/uLz
         /C5Q==
X-Gm-Message-State: AC+VfDwq9bridtMupSzqdagelUEpxlVAwokpbxG41x6OLGPbOvdLjWFd
        xfXALiXAlwq31AJmYmvqWg==
X-Google-Smtp-Source: ACHHUZ7W/BNJTBWEuzlVSH6IdqkzDcm9veSVqRhEBiDBRS7zfxQmyz1wWm6tcwQq8rqCfLhFbBrE5Q==
X-Received: by 2002:a92:d483:0:b0:338:d170:6e32 with SMTP id p3-20020a92d483000000b00338d1706e32mr2259045ilg.7.1686335550873;
        Fri, 09 Jun 2023 11:32:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p5-20020a92d285000000b00333b5ae4ab7sm1193799ilp.87.2023.06.09.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:32:30 -0700 (PDT)
Received: (nullmailer pid 1766999 invoked by uid 1000);
        Fri, 09 Jun 2023 18:32:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: Use common ranges functions
Date:   Fri,  9 Jun 2023 12:32:15 -0600
Message-Id: <20230609183215.1766735-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3d5089c4263d ("of/address: Add support for 3 address cell
bus"), the DT address functions can handle translating buses with 3
address cells. Replace the custom code with the for_each_of_range()
iterator.

The original code had fallbacks to get "#address-cells"/"#size-cells"
from the bus parent node if they are missing. This is non-standard
behavior, and AFAICT the upstream .dts files never relied on that.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 90 +++++----------------------------
 1 file changed, 13 insertions(+), 77 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 653e2d4c116f..5062d73b13e2 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -999,75 +999,18 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 }
 EXPORT_SYMBOL_GPL(fsl_mc_get_endpoint);
 
-static int parse_mc_ranges(struct device *dev,
-			   int *paddr_cells,
-			   int *mc_addr_cells,
-			   int *mc_size_cells,
-			   const __be32 **ranges_start)
-{
-	const __be32 *prop;
-	int range_tuple_cell_count;
-	int ranges_len;
-	int tuple_len;
-	struct device_node *mc_node = dev->of_node;
-
-	*ranges_start = of_get_property(mc_node, "ranges", &ranges_len);
-	if (!(*ranges_start) || !ranges_len) {
-		dev_warn(dev,
-			 "missing or empty ranges property for device tree node '%pOFn'\n",
-			 mc_node);
-		return 0;
-	}
-
-	*paddr_cells = of_n_addr_cells(mc_node);
-
-	prop = of_get_property(mc_node, "#address-cells", NULL);
-	if (prop)
-		*mc_addr_cells = be32_to_cpup(prop);
-	else
-		*mc_addr_cells = *paddr_cells;
-
-	prop = of_get_property(mc_node, "#size-cells", NULL);
-	if (prop)
-		*mc_size_cells = be32_to_cpup(prop);
-	else
-		*mc_size_cells = of_n_size_cells(mc_node);
-
-	range_tuple_cell_count = *paddr_cells + *mc_addr_cells +
-				 *mc_size_cells;
-
-	tuple_len = range_tuple_cell_count * sizeof(__be32);
-	if (ranges_len % tuple_len != 0) {
-		dev_err(dev, "malformed ranges property '%pOFn'\n", mc_node);
-		return -EINVAL;
-	}
-
-	return ranges_len / tuple_len;
-}
-
 static int get_mc_addr_translation_ranges(struct device *dev,
 					  struct fsl_mc_addr_translation_range
 						**ranges,
 					  u8 *num_ranges)
 {
-	int ret;
-	int paddr_cells;
-	int mc_addr_cells;
-	int mc_size_cells;
-	int i;
-	const __be32 *ranges_start;
-	const __be32 *cell;
-
-	ret = parse_mc_ranges(dev,
-			      &paddr_cells,
-			      &mc_addr_cells,
-			      &mc_size_cells,
-			      &ranges_start);
-	if (ret < 0)
-		return ret;
+	struct fsl_mc_addr_translation_range *r;
+	struct of_range_parser parser;
+	struct of_range range;
 
-	*num_ranges = ret;
-	if (!ret) {
+	of_range_parser_init(&parser, dev->of_node);
+	*num_ranges = of_range_count(&parser);
+	if (!*num_ranges) {
 		/*
 		 * Missing or empty ranges property ("ranges;") for the
 		 * 'fsl,qoriq-mc' node. In this case, identity mapping
@@ -1083,20 +1026,13 @@ static int get_mc_addr_translation_ranges(struct device *dev,
 	if (!(*ranges))
 		return -ENOMEM;
 
-	cell = ranges_start;
-	for (i = 0; i < *num_ranges; ++i) {
-		struct fsl_mc_addr_translation_range *range = &(*ranges)[i];
-
-		range->mc_region_type = of_read_number(cell, 1);
-		range->start_mc_offset = of_read_number(cell + 1,
-							mc_addr_cells - 1);
-		cell += mc_addr_cells;
-		range->start_phys_addr = of_read_number(cell, paddr_cells);
-		cell += paddr_cells;
-		range->end_mc_offset = range->start_mc_offset +
-				     of_read_number(cell, mc_size_cells);
-
-		cell += mc_size_cells;
+	r = *ranges;
+	for_each_of_range(&parser, &range) {
+		r->mc_region_type = range.flags;
+		r->start_mc_offset = range.bus_addr;
+		r->end_mc_offset = range.bus_addr + range.size;
+		r->start_phys_addr = range.cpu_addr;
+		r++;
 	}
 
 	return 0;
-- 
2.39.2

