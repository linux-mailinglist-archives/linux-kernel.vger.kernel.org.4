Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4145E616A34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiKBRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKBRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:05 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4056E17E38;
        Wed,  2 Nov 2022 10:11:04 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 957D3100009;
        Wed,  2 Nov 2022 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667409063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2xVfnlmooK7Qg1BmLHoWVwjVfzC1dVIJEO1AD5E1VU=;
        b=FwF9YkUVYzUrCoshasYZIRNKboNo6j1i0R4ypo9aBEDT5lyrnQWloO6wdIb3IXD9Hc0KGA
        bLyFCSbR9kqnEUDp2so6a7Pxk/ablv5ycwC91CsTv+Vh5mpBxPfC/hx4QRMi6sy5ZtR9hB
        AZMqkdZAdt/N6zVYqACerzJvn8yxIke3Ou+HN9V38aAv6MDbkfJtqulndK4Ib1xwE2Z6x6
        R7lYDSFPvQU/SPcZQAb7hv1fP1qvDWzYZDT2W2G32zNyUyZm8WoaiaVQx5Heas1TB5NXr4
        358zV1riX4xRPxQr82Jag2b6IEUy8q6hB6/vPA8gd93Db4f1mQKmHiAXe/0+/w==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     viresh.kumar@linaro.org, Bhavna Yadav <bhavna.yadav@st.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Vipul Kumar Samar <vipulkumar.samar@st.com>,
        Vipin Kumar <vipin.kumar@st.com>
Subject: [PATCH v2 6/6] clk: spear: Fix SSP clock definition on SPEAr600
Date:   Wed,  2 Nov 2022 18:10:10 +0100
Message-Id: <20221102171012.49150-7-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102171012.49150-1-kory.maincent@bootlin.com>
References: <20221102171012.49150-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

