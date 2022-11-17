Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84162D5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiKQJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiKQJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:10:36 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F15ADC4;
        Thu, 17 Nov 2022 01:10:34 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCYzY192gz4xVnZ;
        Thu, 17 Nov 2022 17:10:33 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCYzW127rz4y0vK;
        Thu, 17 Nov 2022 17:10:31 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH9AC7j037132;
        Thu, 17 Nov 2022 17:10:13 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 17:10:15 +0800 (CST)
Date:   Thu, 17 Nov 2022 17:10:15 +0800 (CST)
X-Zmail-TransId: 2af96375fa77ffffffffcae92ea1
X-Mailer: Zmail v1.0
Message-ID: <202211171710153200734@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <herbert@gondor.apana.org.au>
Cc:     <olivia@selenic.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGh3cm5nOiBuMi1kcnYgLSBVc2UgZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgdG8gc2ltcGxpZnkgdGhlCgogY29kZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH9AC7j037132
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6375FA89.001 by FangMail milter!
X-FangMail-Envelope: 1668676233/4NCYzY192gz4xVnZ/6375FA89.001/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375FA89.001/4NCYzY192gz4xVnZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Directly get the match data with device_get_match_data().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/char/hw_random/n2-drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 73e408146420..2f784addb717 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -695,20 +695,15 @@ static void n2rng_driver_version(void)
 static const struct of_device_id n2rng_match[];
 static int n2rng_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
 	int err = -ENOMEM;
 	struct n2rng *np;

-	match = of_match_device(n2rng_match, &op->dev);
-	if (!match)
-		return -EINVAL;
-
 	n2rng_driver_version();
 	np = devm_kzalloc(&op->dev, sizeof(*np), GFP_KERNEL);
 	if (!np)
 		goto out;
 	np->op = op;
-	np->data = (struct n2rng_template *)match->data;
+	np->data = (struct n2rng_template *) device_get_match_data(&op->dev);

 	INIT_DELAYED_WORK(&np->work, n2rng_work);

-- 
2.25.1
