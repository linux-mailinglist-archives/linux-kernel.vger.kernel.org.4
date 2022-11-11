Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32C66255A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiKKIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiKKIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:45:39 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B083BA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:45:21 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N7sjD4PSxz5PkGn
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:45:20 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AB8jC2k048931
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:45:12 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 11 Nov 2022 16:45:14 +0800 (CST)
Date:   Fri, 11 Nov 2022 16:45:14 +0800 (CST)
X-Zmail-TransId: 2afa636e0b9affffffffcb2f1423
X-Mailer: Zmail v1.0
Message-ID: <202211111645144926643@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <linux-kernel@vger.kernel.org>
Cc:     <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBidXM6IG9tYXAtb2NwMnNjcDogdXNlCgogZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AB8jC2k048931
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 636E0BA0.000 by FangMail milter!
X-FangMail-Envelope: 1668156320/4N7sjD4PSxz5PkGn/636E0BA0.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636E0BA0.000/4N7sjD4PSxz5PkGn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/bus/omap-ocp2scp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e02d0656242b..c8707c491c37 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -31,7 +31,6 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	int ret;
 	u32 reg;
 	void __iomem *regs;
-	struct resource *res;
 	struct device_node *np = pdev->dev.of_node;

 	if (np) {
@@ -58,8 +57,7 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	 * of SYNC2 parameter in OCP2SCP. Suggested reset value is 0x6 or more.
 	 */
 	if (!of_device_is_compatible(np, "ti,am437x-ocp2scp")) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		regs = devm_ioremap_resource(&pdev->dev, res);
+		regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 		if (IS_ERR(regs)) {
 			ret = PTR_ERR(regs);
 			goto err1;
-- 
2.25.1
