Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DE068E63B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBHCph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBHCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:45:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37742DF0;
        Tue,  7 Feb 2023 18:45:22 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBPVl5QFsz8R044;
        Wed,  8 Feb 2023 10:45:19 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 3182jFli062054;
        Wed, 8 Feb 2023 10:45:15 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 10:45:16 +0800 (CST)
Date:   Wed, 8 Feb 2023 10:45:16 +0800 (CST)
X-Zmail-TransId: 2af963e30cbc11603596
X-Mailer: Zmail v1.0
Message-ID: <202302081045168463601@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <tsbogend@alpha.franken.de>
Cc:     <john@phrozen.org>, <xkernel.wang@foxmail.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBNSVBTOiBsYW50aXE6IHh3YXk6IFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3182jFli062054
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63E30CBF.000 by FangMail milter!
X-FangMail-Envelope: 1675824319/4PBPVl5QFsz8R044/63E30CBF.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E30CBF.000/4PBPVl5QFsz8R044
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 arch/mips/lantiq/xway/dcdc.c | 5 +----
 arch/mips/lantiq/xway/dma.c  | 4 +---
 arch/mips/lantiq/xway/gptu.c | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
index 4960bee0a99d..96199966a350 100644
--- a/arch/mips/lantiq/xway/dcdc.c
+++ b/arch/mips/lantiq/xway/dcdc.c
@@ -22,10 +22,7 @@ static void __iomem *dcdc_membase;

 static int dcdc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dcdc_membase = devm_ioremap_resource(&pdev->dev, res);
+	dcdc_membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(dcdc_membase))
 		return PTR_ERR(dcdc_membase);

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index f8eedeb15f18..934ac72937e5 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -239,12 +239,10 @@ static int
 ltq_dma_init(struct platform_device *pdev)
 {
 	struct clk *clk;
-	struct resource *res;
 	unsigned int id, nchannels;
 	int i;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ltq_dma_membase = devm_ioremap_resource(&pdev->dev, res);
+	ltq_dma_membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(ltq_dma_membase))
 		panic("Failed to remap dma resource");

diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 200fe9ff641d..a492b1eb1925 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -136,17 +136,14 @@ static inline void clkdev_add_gptu(struct device *dev, const char *con,
 static int gptu_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
-	struct resource *res;

 	if (of_irq_to_resource_table(pdev->dev.of_node, irqres, 6) != 6) {
 		dev_err(&pdev->dev, "Failed to get IRQ list\n");
 		return -EINVAL;
 	}

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
 	/* remap gptu register range */
-	gptu_membase = devm_ioremap_resource(&pdev->dev, res);
+	gptu_membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(gptu_membase))
 		return PTR_ERR(gptu_membase);

-- 
2.25.1
