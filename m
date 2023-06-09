Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBDF72A256
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjFISda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjFISdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:33:23 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E44205
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:32:51 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33b6c47898dso9120665ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335570; x=1688927570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDsI6y+39w6RrJxOoiKJblVUr+xr5BV/zYozHnP9juw=;
        b=c2rxuocowS25lq84k+rxbEkUt0K1+EUkMcEFlFKmB3PJmm1I13tLDVAdvD0YZDTueZ
         nUHF1aSVJ8sl3aCnES0hxmTafhlHN8wcfytiFSatn0o24yWSbnQs13+5OwIoeOeGWe2n
         1W3dyTPqyi9dchfUGR9kun2w93+SsunAS5es/gWX17ohgGYitCMTGlaLA40ZqF7fIcs8
         35iq2kBrp6Pw7D+qRvbL+9vsZdgkdXnB3lmNCk2d+ZiZNkK7NpuSPmIbIM1XgjsEpwuQ
         cHDRmfyeoUZ190dO23i/wDP2aU+LwJ2CV0wOh5JYI9SXaXqNulTiMlIWTP+Ym62z4yKd
         pmqg==
X-Gm-Message-State: AC+VfDytBsJ13JRwcN25Allh+CiylrTja6wYVotIxaOjZhVjqz6DeLJl
        UiJsPmgCLqpdFqQtxq0d/A==
X-Google-Smtp-Source: ACHHUZ6DEagZP+w3SELSpPxmJK661d/nGvdwb8QCFGy6mM1D9jVKQqt37IfcnNZh71b3U4xaaQlZTg==
X-Received: by 2002:a92:c743:0:b0:331:a2f5:b50d with SMTP id y3-20020a92c743000000b00331a2f5b50dmr2068590ilp.30.1686335570552;
        Fri, 09 Jun 2023 11:32:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p7-20020a056e0206c700b0033b2a123254sm1199546ils.61.2023.06.09.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:32:49 -0700 (PDT)
Received: (nullmailer pid 1767422 invoked by uid 1000);
        Fri, 09 Jun 2023 18:32:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fsl_rio: Use of_range_to_resource() for "ranges" parsing
Date:   Fri,  9 Jun 2023 12:32:44 -0600
Message-Id: <20230609183244.1767325-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property with common parsing functions. Users
shouldn't be implementing their own parsing of it. Refactor the FSL RapidIO
"ranges" parsing to use of_range_to_resource() instead.

One change is the original code would look for "#size-cells" and
"#address-cells" in the parent node if not found in the port child
nodes. That is non-standard behavior and not necessary AFAICT. In 2011
in commit 54986964c13c ("powerpc/85xx: Update SRIO device tree nodes")
there was an ABI break. The upstream .dts files have been correct since
at least that point.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/sysdev/fsl_rio.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index f8e492ee54cc..18176d0df612 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -453,8 +453,8 @@ int fsl_rio_setup(struct platform_device *dev)
 	struct device_node *np, *rmu_node;
 	int rlen;
 	u32 ccsr;
-	u64 range_start, range_size;
-	int paw, aw, sw;
+	u64 range_start;
+	int aw;
 	u32 i;
 	static int tmp;
 	struct device_node *rmu_np[MAX_MSG_UNIT_NUM] = {NULL};
@@ -569,6 +569,8 @@ int fsl_rio_setup(struct platform_device *dev)
 
 	/*set up ports node*/
 	for_each_child_of_node(dev->dev.of_node, np) {
+		struct resource res;
+
 		port_index = of_get_property(np, "cell-index", NULL);
 		if (!port_index) {
 			dev_err(&dev->dev, "Can't get %pOF property 'cell-index'\n",
@@ -576,32 +578,14 @@ int fsl_rio_setup(struct platform_device *dev)
 			continue;
 		}
 
-		dt_range = of_get_property(np, "ranges", &rlen);
-		if (!dt_range) {
+		if (of_range_to_resource(np, 0, &res)) {
 			dev_err(&dev->dev, "Can't get %pOF property 'ranges'\n",
 					np);
 			continue;
 		}
 
-		/* Get node address wide */
-		cell = of_get_property(np, "#address-cells", NULL);
-		if (cell)
-			aw = *cell;
-		else
-			aw = of_n_addr_cells(np);
-		/* Get node size wide */
-		cell = of_get_property(np, "#size-cells", NULL);
-		if (cell)
-			sw = *cell;
-		else
-			sw = of_n_size_cells(np);
-		/* Get parent address wide wide */
-		paw = of_n_addr_cells(np);
-		range_start = of_read_number(dt_range + aw, paw);
-		range_size = of_read_number(dt_range + aw + paw, sw);
-
-		dev_info(&dev->dev, "%pOF: LAW start 0x%016llx, size 0x%016llx.\n",
-				np, range_start, range_size);
+		dev_info(&dev->dev, "%pOF: LAW %pR\n",
+				np, &res);
 
 		port = kzalloc(sizeof(struct rio_mport), GFP_KERNEL);
 		if (!port)
@@ -624,9 +608,7 @@ int fsl_rio_setup(struct platform_device *dev)
 		}
 
 		INIT_LIST_HEAD(&port->dbells);
-		port->iores.start = range_start;
-		port->iores.end = port->iores.start + range_size - 1;
-		port->iores.flags = IORESOURCE_MEM;
+		port->iores = res;	/* struct copy */
 		port->iores.name = "rio_io_win";
 
 		if (request_resource(&iomem_resource, &port->iores) < 0) {
-- 
2.39.2

