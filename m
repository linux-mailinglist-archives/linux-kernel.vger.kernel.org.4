Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048FF699BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBPSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBPSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:12:35 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DD50ACA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:12:30 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id w11so2501115oiv.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AY71C+meiyBHhST24LKS8BIZ3aLMamU0OluZ9cJRz0Q=;
        b=xtl+RSevCG8xi9SVW8+vJ5lb5IbVNKt5qlLrcXM3XmaeK75UzGIsdY83tC1giS2OMG
         xG1n6D95s3ZRf6Ll2GXxe0GcsKW4/zz0pSBS+8gZuVkXasajLo35j0oZmbOm76nbIyYC
         fmJT0KqAdUPsxtlVlH2i5GddJGrUf7OmoPC/zKzzwwcwk56LjxS2sqcbTGH1lJNs7tIv
         AehR0wSFIM1SEBk+GqPrC4qytrQEvdI+eemKuSgmo6puOfJzFQxmN8oTAkQX+hAXplcN
         OO7eZ9vUPly09+slBjhsmfqWnyMPlaoDO8j9YMrlKAw2WYQQ7ikll1lAE3T9swePdZSd
         ju/w==
X-Gm-Message-State: AO0yUKX35Kr7VVMeHdWE2dW+NBAny1ypR0msrsHDLpdv35NxNdPFLSNs
        j4RB0UOpEjnZIpp2Q7b1A5E+HZ9mow==
X-Google-Smtp-Source: AK7set/pbk6oZ0/SkxgTX5KHhHgxu5iymQgCl4ocNvHwABpkAaCU0q6GU9DfXqbnQVqUYbgXmiFHrQ==
X-Received: by 2002:a05:6808:192:b0:378:6f44:2a2e with SMTP id w18-20020a056808019200b003786f442a2emr2751994oic.46.1676571149629;
        Thu, 16 Feb 2023 10:12:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r124-20020acaf382000000b0035c073aa0d8sm821386oih.18.2023.02.16.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:12:29 -0800 (PST)
Received: (nullmailer pid 2896124 invoked by uid 1000);
        Thu, 16 Feb 2023 18:12:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bus: mvebu-mbus: Remove open coded "ranges" parsing
Date:   Thu, 16 Feb 2023 12:12:04 -0600
Message-Id: <20230216181204.2895676-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
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

"ranges" is a standard property, and we have common helper functions for
parsing it, so let's use them.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only!
---
 drivers/bus/mvebu-mbus.c | 58 ++++++----------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index d51573ac525e..00cb792bda18 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -1179,74 +1179,32 @@ static int __init mbus_dt_setup_win(struct mvebu_mbus_state *mbus,
 	return 0;
 }
 
-static int __init
-mbus_parse_ranges(struct device_node *node,
-		  int *addr_cells, int *c_addr_cells, int *c_size_cells,
-		  int *cell_count, const __be32 **ranges_start,
-		  const __be32 **ranges_end)
-{
-	const __be32 *prop;
-	int ranges_len, tuple_len;
-
-	/* Allow a node with no 'ranges' property */
-	*ranges_start = of_get_property(node, "ranges", &ranges_len);
-	if (*ranges_start == NULL) {
-		*addr_cells = *c_addr_cells = *c_size_cells = *cell_count = 0;
-		*ranges_start = *ranges_end = NULL;
-		return 0;
-	}
-	*ranges_end = *ranges_start + ranges_len / sizeof(__be32);
-
-	*addr_cells = of_n_addr_cells(node);
-
-	prop = of_get_property(node, "#address-cells", NULL);
-	*c_addr_cells = be32_to_cpup(prop);
-
-	prop = of_get_property(node, "#size-cells", NULL);
-	*c_size_cells = be32_to_cpup(prop);
-
-	*cell_count = *addr_cells + *c_addr_cells + *c_size_cells;
-	tuple_len = (*cell_count) * sizeof(__be32);
-
-	if (ranges_len % tuple_len) {
-		pr_warn("malformed ranges entry '%pOFn'\n", node);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
 				struct device_node *np)
 {
-	int addr_cells, c_addr_cells, c_size_cells;
-	int i, ret, cell_count;
-	const __be32 *r, *ranges_start, *ranges_end;
+	int ret;
+	struct of_range_parser parser;
+	struct of_range range;
 
-	ret = mbus_parse_ranges(np, &addr_cells, &c_addr_cells,
-				&c_size_cells, &cell_count,
-				&ranges_start, &ranges_end);
+	ret = of_range_parser_init(&parser, np);
 	if (ret < 0)
-		return ret;
+		return 0;
 
-	for (i = 0, r = ranges_start; r < ranges_end; r += cell_count, i++) {
-		u32 windowid, base, size;
+	for_each_of_range(&parser, &range) {
+		u32 windowid = upper_32_bits(range.bus_addr);
 		u8 target, attr;
 
 		/*
 		 * An entry with a non-zero custom field do not
 		 * correspond to a static window, so skip it.
 		 */
-		windowid = of_read_number(r, 1);
 		if (CUSTOM(windowid))
 			continue;
 
 		target = TARGET(windowid);
 		attr = ATTR(windowid);
 
-		base = of_read_number(r + c_addr_cells, addr_cells);
-		size = of_read_number(r + c_addr_cells + addr_cells,
-				      c_size_cells);
-		ret = mbus_dt_setup_win(mbus, base, size, target, attr);
+		ret = mbus_dt_setup_win(mbus, range.cpu_addr, range.size, target, attr);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.39.1

