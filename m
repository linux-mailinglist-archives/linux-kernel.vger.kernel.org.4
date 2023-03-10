Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB96B4D83
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCJQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjCJQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:47:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D42265AE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:45:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pafrz-00089n-44; Fri, 10 Mar 2023 17:45:27 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pafrx-003DTM-G3; Fri, 10 Mar 2023 17:45:25 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pafrw-002F50-NG; Fri, 10 Mar 2023 17:45:24 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] clk: imx6ul: fix "failed to get parent" error
Date:   Fri, 10 Mar 2023 17:45:23 +0100
Message-Id: <20230310164523.534571-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some configuration we may get following error:
[    0.000000] imx:clk-gpr-mux: failed to get parent (-EINVAL)

This happens if selector is configured to not supported value. To avoid
this warnings add dummy parents for not supported values.

Fixes: 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/clk/imx/clk-imx6ul.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 2836adb817b7..e3696a88b5a3 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -95,14 +95,16 @@ static const struct clk_div_table video_div_table[] = {
 	{ }
 };
 
-static const char * enet1_ref_sels[] = { "enet1_ref_125m", "enet1_ref_pad", };
+static const char * enet1_ref_sels[] = { "enet1_ref_125m", "enet1_ref_pad", "dummy", "dummy"};
 static const u32 enet1_ref_sels_table[] = { IMX6UL_GPR1_ENET1_TX_CLK_DIR,
-					    IMX6UL_GPR1_ENET1_CLK_SEL };
+					    IMX6UL_GPR1_ENET1_CLK_SEL, 0,
+					    IMX6UL_GPR1_ENET1_TX_CLK_DIR | IMX6UL_GPR1_ENET1_CLK_SEL };
 static const u32 enet1_ref_sels_table_mask = IMX6UL_GPR1_ENET1_TX_CLK_DIR |
 					     IMX6UL_GPR1_ENET1_CLK_SEL;
-static const char * enet2_ref_sels[] = { "enet2_ref_125m", "enet2_ref_pad", };
+static const char * enet2_ref_sels[] = { "enet2_ref_125m", "enet2_ref_pad", "dummy", "dummy"};
 static const u32 enet2_ref_sels_table[] = { IMX6UL_GPR1_ENET2_TX_CLK_DIR,
-					    IMX6UL_GPR1_ENET2_CLK_SEL };
+					    IMX6UL_GPR1_ENET2_CLK_SEL, 0,
+					    IMX6UL_GPR1_ENET2_TX_CLK_DIR | IMX6UL_GPR1_ENET2_CLK_SEL };
 static const u32 enet2_ref_sels_table_mask = IMX6UL_GPR1_ENET2_TX_CLK_DIR |
 					     IMX6UL_GPR1_ENET2_CLK_SEL;
 
-- 
2.30.2

