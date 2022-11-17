Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7400062D9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiKQLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiKQLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:52:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE7059FCF;
        Thu, 17 Nov 2022 03:52:31 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCdZQ2XFYz8RTZF;
        Thu, 17 Nov 2022 19:52:30 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AHBqLfU094194;
        Thu, 17 Nov 2022 19:52:21 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 19:52:24 +0800 (CST)
Date:   Thu, 17 Nov 2022 19:52:24 +0800 (CST)
X-Zmail-TransId: 2af963762078ffffffffc1a5ec43
X-Mailer: Zmail v1.0
Message-ID: <202211171952240424511@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1mZDogcGFsbWFzOiBVc2UgZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgdG8gc2ltcGxpZnkgdGhlIGNvZGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AHBqLfU094194
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6376207E.000 by FangMail milter!
X-FangMail-Envelope: 1668685950/4NCdZQ2XFYz8RTZF/6376207E.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6376207E.000/4NCdZQ2XFYz8RTZF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Directly get the match data with device_get_match_data().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mfd/palmas.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 8b7429bd2e3e..5105c6488d3d 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -512,7 +512,6 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 	int ret = 0, i;
 	unsigned int reg, addr;
 	int slave;
-	const struct of_device_id *match;

 	pdata = dev_get_platdata(&i2c->dev);

@@ -536,12 +535,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 	palmas->dev = &i2c->dev;
 	palmas->irq = i2c->irq;

-	match = of_match_device(of_palmas_match_tbl, &i2c->dev);
-
-	if (!match)
-		return -ENODATA;
-
-	driver_data = (struct palmas_driver_data *)match->data;
+	driver_data = (struct palmas_driver_data *) device_get_match_data(&i2c->dev);
 	palmas->features = *driver_data->features;

 	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
-- 
2.25.1
