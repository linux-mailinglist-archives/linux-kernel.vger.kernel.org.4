Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966F63CFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiK3Hhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiK3Hhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:37:45 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F446417
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:37:43 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NMWJP48hKz4y0tv;
        Wed, 30 Nov 2022 15:37:41 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AU7bYFC084520;
        Wed, 30 Nov 2022 15:37:35 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 15:37:36 +0800 (CST)
Date:   Wed, 30 Nov 2022 15:37:36 +0800 (CST)
X-Zmail-TransId: 2af9638708407bc45ebb
X-Mailer: Zmail v1.0
Message-ID: <202211301537369277960@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <daniel@zonque.org>
Cc:     <haojian.zhuang@gmail.com>, <robert.jarzmik@free.fr>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEFSTTogUFhBOiB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU7bYFC084520
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63870845.000 by FangMail milter!
X-FangMail-Envelope: 1669793861/4NMWJP48hKz4y0tv/63870845.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870845.000/4NMWJP48hKz4y0tv
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
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index eda5a47d7fbb..e94b340589ed 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -104,7 +104,6 @@ static int cplds_resume(struct platform_device *pdev)

 static int cplds_probe(struct platform_device *pdev)
 {
-       struct resource *res;
        struct cplds *fpga;
        int ret;
        int base_irq;
@@ -127,8 +126,7 @@ static int cplds_probe(struct platform_device *pdev)
                        return ret;
        }

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       fpga->base = devm_ioremap_resource(&pdev->dev, res);
+       fpga->base = devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(fpga->base))
                return PTR_ERR(fpga->base);

--
2.15.2
