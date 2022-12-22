Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3B65458A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiLVRS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLVRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:18:52 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5C2B242
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671729516; bh=StquY4wdmhgaNyls5O+dcyLQ6Cptvx72ASz210O3A6U=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=fMq9hio7BzUAmW233U4M7DFDbeCZx+XHLaRz56Vdc308KjkAAe5rdsvFpQM9WvaGb
         F6UDZ79Jmad8XKKzRCg9olUv1XfcOifGYAjUTzL+RtnBTUUXFa1v7MnQN+DNZWOFsZ
         twVfe3HZqwBsbEq2ks1gQX8e3hzrkex9gziB5YIo=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 22 Dec 2022 18:18:35 +0100 (CET)
X-EA-Auth: +UzcuDTVw7b103pzKMi29hCxA7XsqGR1ZcuFunxSFb3oUi5dkg3viG5PJ2HAqjZI/GowK4tLl/IklOTFfTex1FdD5aloAddj
Date:   Thu, 22 Dec 2022 22:48:29 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] power: supply: da9150: Remove redundant error logging
Message-ID: <Y6SRZZUDoiIKJ0rJ@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to platform_get_irq_byname() already prints an error on failure
within its own implementation. So printing another error based on its
return value in the caller is redundant and should be removed. The
clean up also makes if condition block braces and the device pointer
variable dev unnecessary. Remove those as well.

Issue identified using platform_get_irq.cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: The change was build tested using ARM64 defconfig.

 drivers/power/supply/da9150-charger.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index f9314cc0cd75..14da5c595dd9 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -466,10 +466,8 @@ static int da9150_charger_register_irq(struct platform_device *pdev,
 	int irq, ret;

 	irq = platform_get_irq_byname(pdev, irq_name);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}

 	ret = request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, irq_name,
 				   charger);
@@ -482,15 +480,12 @@ static int da9150_charger_register_irq(struct platform_device *pdev,
 static void da9150_charger_unregister_irq(struct platform_device *pdev,
 					  const char *irq_name)
 {
-	struct device *dev = &pdev->dev;
 	struct da9150_charger *charger = platform_get_drvdata(pdev);
 	int irq;

 	irq = platform_get_irq_byname(pdev, irq_name);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
+	if (irq < 0)
 		return;
-	}

 	free_irq(irq, charger);
 }
--
2.34.1



