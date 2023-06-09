Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8274A729D16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbjFIOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjFIOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:39:18 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EACA136;
        Fri,  9 Jun 2023 07:39:17 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686321556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFPA+iF1oDnlDYWPONEIrlc2JlsGAiwXm8sKilpLnOk=;
        b=pZ1jNqjSB01eYJK+iVJNl1WJucinc7z4V/+U4lwOOQ7cEr1056xU3pB8wk1R2R4FcYPGr9
        baOzltFc4Al22YTf8cmCrOzjkCILsbE4hxLM3+bzv4qWznAs4sH8IzkKxFKjEwdJcmhUbt
        TerWuex0XSyP+IP5PxjwAhK60e9FWkXz4WR8RiHQzCWnZ/GM/vhq1wtcHegOB5gB7IPa+8
        ZDpanMlbzoe3U59GSJfCNxzi9+gcp3a4lljxbn1QwMUl4+kL3dzu0AfsOH95uSBl3jJYUY
        HYl9d7+L5mvNd5vwhMe7N/9Dc9gcGpBANr9/9RfWu9bXOm5VhXtg+2P+rCaBYg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D9B56000A;
        Fri,  9 Jun 2023 14:39:15 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/2] power: reset: at91-reset: use driver structure as status parameter
Date:   Fri,  9 Jun 2023 16:39:11 +0200
Message-Id: <20230609143912.849995-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609143912.849995-1-miquel.raynal@bootlin.com>
References: <20230609143912.849995-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is quite uncommon to use a driver helper with parameters like *pdev
and __iomem *base. It is much cleaner and close to today's standards to
provide the per-device driver structure and then access its
internals. Let's do this with at91_resete_status() before making more
modifications to this helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/reset/at91-reset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 741e44a017c3..a8a6f3997768 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -149,11 +149,10 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static void __init at91_reset_status(struct platform_device *pdev,
-				     void __iomem *base)
+static void __init at91_reset_status(struct at91_reset *reset)
 {
+	u32 reg = readl(reset->rstc_base + AT91_RSTC_SR);
 	const char *reason;
-	u32 reg = readl(base + AT91_RSTC_SR);
 
 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
-- 
2.34.1

