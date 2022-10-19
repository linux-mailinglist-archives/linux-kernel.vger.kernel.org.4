Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611D60481C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiJSNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiJSNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:48:57 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32711BBEE2;
        Wed, 19 Oct 2022 06:32:53 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 86302E0018;
        Wed, 19 Oct 2022 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666186345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4WZT0ijc4vr+yQWHuy8C2QHY5BLhRbeTNROpcFndPc=;
        b=o3EnyrFn/BZ9wLYgskdr/Yz5E2HEnUC5VDVvCSe8kK/Cb+eCeTeiAOXfBVDsZsyN2MVyQP
        aqWJDiXVy3b5y0ur4ojErVDDM0D3m8bfwbjaCEHHBJ8VV9y/DX627pFzvk9FWqgcKtkQWT
        OcfkX6R5VEinSeWGSkfxXjIOUq7MKK9saWMOiVwa5i7TPWWfLWn90phJNE8Q89LlqYW9Yi
        MgzEjUAObg+mIs6a31IHZljlVNygBUTGZXfjUwiDCjG1prvKn+jBd6ePiwCgyDTmPZNlWj
        q0/18vCqFMUhdMyinLWf0/IoM3/pVCqOAKiulwoxmp264zzK09+50pSJoQOpkg==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com,
        Kory Maincent <kory.maincent@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6/6] clk: spear: Fix SSP clock definition on SPEAr600
Date:   Wed, 19 Oct 2022 15:32:08 +0200
Message-Id: <20221019133208.319626-7-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019133208.319626-1-kory.maincent@bootlin.com>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

There is no SPEAr600 device named "ssp-pl022.x". Instead, the description
of the SSP (Synchronous Serial Port) was recently added to the Device Tree,
and the device name is "xxx.spi", so we should associate the SSP gateable
clock to these device names.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/clk/spear/spear6xx_clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index ee0ed89f2954..adfa118520c3 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -326,13 +326,13 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_gate(NULL, "ssp0_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			SSP0_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "ssp-pl022.0");
+	clk_register_clkdev(clk, NULL, "d0100000.spi");
 
 	clk = clk_register_gate(NULL, "ssp1_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			SSP1_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "ssp-pl022.1");
+	clk_register_clkdev(clk, NULL, "d0180000.spi");
 
 	clk = clk_register_gate(NULL, "ssp2_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			SSP2_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "ssp-pl022.2");
+	clk_register_clkdev(clk, NULL, "d8180000.spi");
 }
-- 
2.25.1

