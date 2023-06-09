Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6272A248
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjFIScD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjFIScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:32:00 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34FB3A8C;
        Fri,  9 Jun 2023 11:31:50 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77acb944bdfso92188939f.0;
        Fri, 09 Jun 2023 11:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335510; x=1688927510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSViwTkLOmC7b6AdgszW04O7q+R6AtCgFR4UO5Oh1QI=;
        b=kY2lkOm7JTfJcs1x3GFl+Kh+jySxb6gEx6qkopho5r3tgIhYhkQ/B5rOv+xTxUfzIm
         RHknOH/aL0/BeHi+70rIMxOdE2hl2Mba2eErGD9nUoV6obfLYLaq68lsQASnd3GLlcEP
         10WqEKWHHt8JJFt6exqQQ0HtgcyV985Ptr8QZiL0lnpQu/wDVWUzZpqIihrPX4L94an/
         MDV42Gvp6X1isJmwPBJYuiiEVYXsF785+f9JgrjHrl7ULvIUX0YqvXCSb+h01r75Ch/u
         5xG1Bd3yFnD2qA2WBrbCMCrTYhSJ7obiTS4Cbls5aHlkW/SToKPHPt1aPZ7TxfhLbp7Y
         7suw==
X-Gm-Message-State: AC+VfDzokMJkF5u2MUBfjuH4YBWqhHIrLEEtdkK13wsMLmlnrpHhWEPz
        mDRMtxxFQ4cHX5cHJ78jEvoEN/4N0Q==
X-Google-Smtp-Source: ACHHUZ5HhG9e71Rqo27WUlJEXN9BCT5Vc2riQV41Sic5YdY/vlQMW/Y7qnVOwayKSsL3BK4pk2cQqw==
X-Received: by 2002:a6b:e602:0:b0:777:a8f0:1fc5 with SMTP id g2-20020a6be602000000b00777a8f01fc5mr2100503ioh.5.1686335509950;
        Fri, 09 Jun 2023 11:31:49 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k7-20020a5e8907000000b0076c8d04a612sm1194337ioj.1.2023.06.09.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:31:49 -0700 (PDT)
Received: (nullmailer pid 1766200 invoked by uid 1000);
        Fri, 09 Jun 2023 18:31:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:31:25 -0600
Message-Id: <20230609183125.1765780-1-robh@kernel.org>
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

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ata/pata_octeon_cf.c | 26 +++++++++-----------------
 drivers/ata/sata_svw.c       |  7 ++++---
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index b1ce9f1761af..57b2166a6d5d 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -804,9 +804,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 	struct resource *res_cs0, *res_cs1;
 
 	bool is_16bit;
-	const __be32 *cs_num;
-	struct property *reg_prop;
-	int n_addr, n_size, reg_len;
+	u64 reg;
 	struct device_node *node;
 	void __iomem *cs0;
 	void __iomem *cs1 = NULL;
@@ -834,15 +832,10 @@ static int octeon_cf_probe(struct platform_device *pdev)
 	else
 		is_16bit = false;
 
-	n_addr = of_n_addr_cells(node);
-	n_size = of_n_size_cells(node);
-
-	reg_prop = of_find_property(node, "reg", &reg_len);
-	if (!reg_prop || reg_len < sizeof(__be32))
-		return -EINVAL;
-
-	cs_num = reg_prop->value;
-	cf_port->cs0 = be32_to_cpup(cs_num);
+	rv = of_property_read_reg(node, 0, &reg, NULL);
+	if (rv < 0)
+		return rv;
+	cf_port->cs0 = upper_32_bits(reg);
 
 	if (cf_port->is_true_ide) {
 		struct device_node *dma_node;
@@ -884,13 +877,12 @@ static int octeon_cf_probe(struct platform_device *pdev)
 		cs1 = devm_ioremap(&pdev->dev, res_cs1->start,
 					   resource_size(res_cs1));
 		if (!cs1)
-			return rv;
-
-		if (reg_len < (n_addr + n_size + 1) * sizeof(__be32))
 			return -EINVAL;
 
-		cs_num += n_addr + n_size;
-		cf_port->cs1 = be32_to_cpup(cs_num);
+		rv = of_property_read_reg(node, 1, &reg, NULL);
+		if (rv < 0)
+			return rv;
+		cf_port->cs1 = upper_32_bits(reg);
 	}
 
 	res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index c47c3fb434d5..b3cc23d891d5 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -32,6 +32,7 @@
 #include <scsi/scsi.h>
 #include <linux/libata.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #define DRV_NAME	"sata_svw"
 #define DRV_VERSION	"2.3"
@@ -319,10 +320,10 @@ static int k2_sata_show_info(struct seq_file *m, struct Scsi_Host *shost)
 	/* Match it to a port node */
 	index = (ap == ap->host->ports[0]) ? 0 : 1;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		const u32 *reg = of_get_property(np, "reg", NULL);
-		if (!reg)
+		u64 reg;
+		if (of_property_read_reg(np, 0, &reg, NULL))
 			continue;
-		if (index == *reg) {
+		if (index == reg) {
 			seq_printf(m, "devspec: %pOF\n", np);
 			break;
 		}
-- 
2.39.2

