Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737162558E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiKKIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKKIoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:44:05 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32D7723E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:44:03 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N7sgk4p7tz5PkGk
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:44:02 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AB8hkD6046394
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:43:46 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 11 Nov 2022 16:43:48 +0800 (CST)
Date:   Fri, 11 Nov 2022 16:43:48 +0800 (CST)
X-Zmail-TransId: 2afa636e0b44ffffffff99ced111
X-Mailer: Zmail v1.0
Message-ID: <202211111643486186597@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <linux-kernel@vger.kernel.org>
Cc:     <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBidXM6IGRhdmluY2k6IHVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AB8hkD6046394
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 636E0B52.001 by FangMail milter!
X-FangMail-Envelope: 1668156242/4N7sgk4p7tz5PkGk/636E0B52.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636E0B52.001/4N7sgk4p7tz5PkGk
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
 drivers/bus/da8xx-mstpri.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index ee4c02335130..864b61adf005 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -213,8 +213,7 @@ static int da8xx_mstpri_probe(struct platform_device *pdev)
 	u32 reg;
 	int i;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mstpri = devm_ioremap_resource(dev, res);
+	mstpri = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mstpri)) {
 		dev_err(dev, "unable to map MSTPRI registers\n");
 		return PTR_ERR(mstpri);
-- 
2.25.1
