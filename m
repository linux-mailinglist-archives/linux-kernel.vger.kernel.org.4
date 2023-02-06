Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC868C6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBFTqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:46:07 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB281164F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:46:06 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-163bd802238so16510787fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4DTh2z1rpPRJ/teaflCZt687gPrck3bGUNfCgC0QoI=;
        b=Gehv3KAmCPDlOO+E738oe3GNLu6K3kWVTJC9nvcYAA+z2qZsA1hDcQ6M+XBl1xHmPd
         n56P4jIHRk1K54JUj9BmWZdrrqq/K7ml01yUbLjDAaTIKBD/VTRx0Ulvp7jV7c0FdNtl
         kGh+GKJid1arzEqckFE44Wr+C8IuXR+kkzSwcWHbzbAK/hHAf48p0TDy5/ehb7lI6/K+
         KcVSZYr820r/YR+mbyyZHcZBRRcH8b3Q5UCf12IO9ij39uL4hw9FndweQ2Omwh8yR0ys
         SjWd4GhXchqfbgXsaJ8DVg0oatkixLt5Da3qt6kF5oeXTpXL/my4PfzHW7IavmQib9+R
         WL7g==
X-Gm-Message-State: AO0yUKVacNdN++U2+SSqEqCUqW3uB/bL7ShTd8lZzSgH47oOt/Hlj1Ry
        sVYtnm0U9PsCUfsR3Lmx1g==
X-Google-Smtp-Source: AK7set8lDNcFV4HeZmp8nc61LAgkpAfWj4rmjX01wERSBhT4ExCxllVrC3mU0gL3aLnTDVBizvfcNA==
X-Received: by 2002:a05:6871:6a9:b0:15e:cfce:fcb9 with SMTP id l41-20020a05687106a900b0015ecfcefcb9mr11802215oao.34.1675712765745;
        Mon, 06 Feb 2023 11:46:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h5-20020a056870538500b0015f9cc16ef7sm4487247oan.46.2023.02.06.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:46:05 -0800 (PST)
Received: (nullmailer pid 1173026 invoked by uid 1000);
        Mon, 06 Feb 2023 19:46:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bus: uniphier-system-bus: Remove open coded "ranges" parsing
Date:   Mon,  6 Feb 2023 13:45:04 -0600
Message-Id: <20230206194503.1162108-1-robh@kernel.org>
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

"ranges" is a standard property and we have common helper functions for
parsing it, so let's use them.

Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only!

v2:
 - Fix subject: s/unifier/uniphier/
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
2.39.1

