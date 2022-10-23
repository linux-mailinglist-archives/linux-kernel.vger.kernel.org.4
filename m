Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C448609236
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJWJzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJWJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:55:08 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863931EFF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518559; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKwp4R0sM21Ivi8navoOTJy75R51wyGPAcCybh3hh04=;
        b=lqSw4wxfbDVH/WSNC7MHZ2lbxkvreN4X8JVR+2SW39jHRtx3syR+/ZfcjjgpzZViqWyNrV
        LYVRYIqXS3oRKf7OdAxD8dI3q7L1kXI1SDAtFzQB/y/Q5PdQ1mnMa1BSFfMwRo1QHPd8z7
        Et6ahhV6CTUWuhmbDXKLANHKt6DlQ/s=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 27/28] mfd: tc6393xb: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:51 +0100
Message-Id: <20221023094852.8035-28-paul@crapouillou.net>
In-Reply-To: <20221023094852.8035-1-paul@crapouillou.net>
References: <20221023094852.8035-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm_sleep_ptr() macro to handle the .suspend/.resume
callbacks.

This macro allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/tc6393xb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index aa903a31dd43..997bb8b5881d 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -813,7 +813,6 @@ static int tc6393xb_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int tc6393xb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct tc6393xb_platform_data *tcpd = dev_get_platdata(&dev->dev);
@@ -876,16 +875,12 @@ static int tc6393xb_resume(struct platform_device *dev)
 
 	return 0;
 }
-#else
-#define tc6393xb_suspend NULL
-#define tc6393xb_resume NULL
-#endif
 
 static struct platform_driver tc6393xb_driver = {
 	.probe = tc6393xb_probe,
 	.remove = tc6393xb_remove,
-	.suspend = tc6393xb_suspend,
-	.resume = tc6393xb_resume,
+	.suspend = pm_sleep_ptr(tc6393xb_suspend),
+	.resume = pm_sleep_ptr(tc6393xb_resume),
 
 	.driver = {
 		.name = "tc6393xb",
-- 
2.35.1

