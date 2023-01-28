Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B567FA12
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjA1RsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjA1RsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:48:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81724119;
        Sat, 28 Jan 2023 09:48:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8491A60C33;
        Sat, 28 Jan 2023 17:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17C8C4339B;
        Sat, 28 Jan 2023 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674928083;
        bh=CGiNFqcT+gNp/yI+0vG+FDcZN+kG7gW2rijDRrtuYc4=;
        h=From:Date:Subject:To:Cc:From;
        b=hclYjqeN03YvCttJwy9WFtn/b6tVf93vanrhSra5SjFyEuPoFzhc0dOdHHDL1iaqV
         AUNOQ/lr31c6tYwDeHYi5OxX9xZ9BQxJBl8wt4wHV4qVeBYurZsAEhWgMMIzzkTcEU
         WQkl4dssbGrC5ELvWYJbIZwY884IvY7JAlJ4aeJU3HjFruZ3+FhsHhuizYRIMkL1XK
         Dmx7y8sJyiq0eLNN4rRgBCTcUWq4KzsLicM+kYF8IrkxomUGkFaBb5XQ69LrT/uc9W
         hdXswRg1h5BrwJa/tKSLX0pv7ed6b7HxDzslf7nGldCv35WxwJ8hJPo2RmstAkp63o
         Yme2Mw18R0O2A==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 28 Jan 2023 17:47:50 +0000
Subject: [PATCH v2] of/address: Return an error when no valid dma-ranges
 are found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-synquacer-boot-v2-1-cb80fd23c4e2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMVf1WMC/3WNyw6CMBAAf4Xs2TXdQvBx8j8MhxYWaNQWt0gkh
 H+3cPc4k0xmgcjiOMI1W0B4ctEFn0AfMqh74ztG1yQGrXSuSJcYZ//+mJoFbQgj6iK3DdnzqS0
 LSJE1kdGK8XW/ZeNr2Owg3LrvvrlXiXsXxyDzfp1os38HEyHhpeBGsSVF1N4eLJ6fxyAdVOu6/
 gDDXQiMwwAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Luca Di Stefano <luca.distefano@linaro.org>,
        993612@bugs.debian.org, stable@kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CGiNFqcT+gNp/yI+0vG+FDcZN+kG7gW2rijDRrtuYc4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj1V/PdwRKheajGm5zYB0t0GGNbHMK+t0YJGiAGyMv
 7nzZNfCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9VfzwAKCRAk1otyXVSH0Lp6B/
 9mQ2Tm0CX1Y/bGHUfz4EpEoh6P2BDc6brRD59DNc8SorKsqPzKlUdJo03OWe6n/yoCPG2QQLykTm7W
 +zEMXQLBXGCUkModIJ715Wk4F3eIAdMWnqbYch7T7kxVPdqtBTnZZeEfE3pys0DK9XPh4JBKwISZWe
 g+4RAGjJe9Lo1jE1otg8SzgQfbRqs/T08xNLlSPxKtfFqDY+V95CjZhgTGNT9XfJtUNlMuDT4FRFbo
 Z9IO7l5/WInIEzN11t6AtCoVMP/T48ybGF6MJ7zPaPGokrEUpTuEjqMlkV9aCmhK7ZoUT6oPscsCG6
 9EtpJ7Jw//tAZl+p6+YReoYICc1OXB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
converted the parsing of dma-range properties to use code shared with the
PCI range parser. The intent was to introduce no functional changes however
in the case where we fail to translate the first resource instead of
returning -EINVAL the new code we return 0. Restore the previous behaviour
by returning an error if we find no valid ranges, the original code only
handled the first range but subsequently support for parsing all supplied
ranges was added.

This avoids confusing code using the parsed ranges which doesn't expect to
successfully parse ranges but have only a list terminator returned, this
fixes breakage with so far as I can tell all DMA for on SoC devices on the
Socionext Synquacer platform which has a firmware supplied DT. A bisect
identified the original conversion as triggering the issues there.

Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Luca Di Stefano <luca.distefano@linaro.org>
Cc: 993612@bugs.debian.org
Cc: stable@kernel.org
---
Changes in v2:
- Don't leak parsed resources.
- Link to v1: https://lore.kernel.org/r/20230126-synquacer-boot-v1-1-94ed0eb1011f@kernel.org
---
 drivers/of/address.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index c34ac33b7338..67763e5b8c0e 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -965,8 +965,19 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	}
 
 	of_dma_range_parser_init(&parser, node);
-	for_each_of_range(&parser, &range)
+	for_each_of_range(&parser, &range) {
+		if (range.cpu_addr == OF_BAD_ADDR) {
+			pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
+			       range.bus_addr, node);
+			continue;
+		}
 		num_ranges++;
+	}
+
+	if (!num_ranges) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
 	if (!r) {
@@ -975,18 +986,16 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	}
 
 	/*
-	 * Record all info in the generic DMA ranges array for struct device.
+	 * Record all info in the generic DMA ranges array for struct device,
+	 * returning an error if we don't find any parsable ranges.
 	 */
 	*map = r;
 	of_dma_range_parser_init(&parser, node);
 	for_each_of_range(&parser, &range) {
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
-		if (range.cpu_addr == OF_BAD_ADDR) {
-			pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
-			       range.bus_addr, node);
+		if (range.cpu_addr == OF_BAD_ADDR)
 			continue;
-		}
 		r->cpu_start = range.cpu_addr;
 		r->dma_start = range.bus_addr;
 		r->size = range.size;

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-synquacer-boot-243bd1b87f64

Best regards,
-- 
Mark Brown <broonie@kernel.org>

