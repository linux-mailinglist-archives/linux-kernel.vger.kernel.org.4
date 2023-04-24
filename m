Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4EF6EC8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDXJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjDXJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:25:08 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812C1FE2;
        Mon, 24 Apr 2023 02:25:06 -0700 (PDT)
Received: from liuyuxing.. ([10.12.190.56])
        (user=lyx2022@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33O9OD7v016919-33O9OD7w016919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Apr 2023 17:24:20 +0800
From:   Yuxing Liu <lyx2022@hust.edu.cn>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Yuxing Liu <lyx2022@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: imx: clk-imx8mp: add error handling of of_clk_add_hw_provider
Date:   Mon, 24 Apr 2023 09:24:10 +0000
Message-Id: <20230424092411.124706-1-lyx2022@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lyx2022@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referring to clk-imx8mq.c, check the return code of of_clk_add_hw_provider,
if it returns negtive, print error info and unregister hws,
which makes the program more robust.

Signed-off-by: Yuxing Liu <lyx2022@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
This patch is untested on real device.
---
 drivers/clk/imx/clk-imx8mp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 353d58b665f9..de7d2d2176be 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -414,6 +414,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	void __iomem *anatop_base, *ccm_base;
+	int err;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
 	anatop_base = devm_of_iomap(dev, np, 0, NULL);
@@ -717,7 +718,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (err < 0) {
+		dev_err(dev, "failed to register hws for i.MX8MP\n");
+		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
+		return err;
+	}
 
 	imx_register_uart_clocks();
 
-- 
2.34.1

