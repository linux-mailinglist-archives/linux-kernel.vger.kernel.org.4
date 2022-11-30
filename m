Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED463CFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiK3Ht7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiK3Ht5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:49:57 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEB3137C;
        Tue, 29 Nov 2022 23:49:56 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMWZW2np9z8RTZJ;
        Wed, 30 Nov 2022 15:49:55 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AU7nkM6099628;
        Wed, 30 Nov 2022 15:49:46 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 15:49:47 +0800 (CST)
Date:   Wed, 30 Nov 2022 15:49:47 +0800 (CST)
X-Zmail-TransId: 2af963870b1bffffffffc9b60380
X-Mailer: Zmail v1.0
Message-ID: <202211301549476468260@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <john@phrozen.org>
Cc:     <tsbogend@alpha.franken.de>, <zhang.songyi@zte.com.cn>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1pcHMvcGNpOiB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU7nkM6099628
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63870B23.000 by FangMail milter!
X-FangMail-Envelope: 1669794595/4NMWZW2np9z8RTZJ/63870B23.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870B23.000/4NMWZW2np9z8RTZJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
-       struct resource *res;
        struct device_node *child;
        u32 val;
        int err;
@@ -414,8 +413,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
        if (!rpc)
                return -ENOMEM;

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       rpc->base = devm_ioremap_resource(dev, res);
+       rpc->base = devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(rpc->base))
                return PTR_ERR(rpc->base);

--
2.15.2
