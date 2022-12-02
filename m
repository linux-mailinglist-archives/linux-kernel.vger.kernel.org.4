Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A148663FE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiLBC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLBC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:28:28 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D7C86A7;
        Thu,  1 Dec 2022 18:28:27 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NNcLf3VLQz501SV;
        Fri,  2 Dec 2022 10:28:26 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B22SEG4067270;
        Fri, 2 Dec 2022 10:28:14 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 10:28:15 +0800 (CST)
Date:   Fri, 2 Dec 2022 10:28:15 +0800 (CST)
X-Zmail-TransId: 2af9638962bf1f3cbd76
X-Mailer: Zmail v1.0
Message-ID: <202212021028158035876@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <tsbogend@alpha.franken.de>
Cc:     <zhang.songyi@zte.com.cn>, <cgel.zte@gmail.com>,
        <chi.minghao@zte.com.cn>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIG1pcHMvcGNpOiB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B22SEG4067270
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638962CA.000 by FangMail milter!
X-FangMail-Envelope: 1669948106/4NNcLf3VLQz501SV/638962CA.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638962CA.000/4NNcLf3VLQz501SV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 arch/mips/pci/pci-rt3883.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index e07ae098bdd8..d59888aaed81 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -404,7 +404,6 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	struct rt3883_pci_controller *rpc;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct resource *res;
 	struct device_node *child;
 	u32 val;
 	int err;
@@ -414,8 +413,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	if (!rpc)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rpc->base = devm_ioremap_resource(dev, res);
+	rpc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);

-- 
2.15.2
