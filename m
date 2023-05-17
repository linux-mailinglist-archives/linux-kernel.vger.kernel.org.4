Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76598706DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEQQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjEQQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:14:58 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6647ABB;
        Wed, 17 May 2023 09:14:56 -0700 (PDT)
Received: from ipservice-092-217-095-237.092.217.pools.vodafone-ip.de ([92.217.95.237] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pzJGj-0004yN-6f; Wed, 17 May 2023 17:40:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v5 2/2] clk: imx25: make __mx25_clocks_init return void
Date:   Wed, 17 May 2023 17:39:32 +0200
Message-Id: <20230517153932.172081-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230517153932.172081-1-martin@kaiser.cx>
References: <20220815190748.102664-1-martin@kaiser.cx>
 <20230517153932.172081-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __mx25_clocks_init function always returns 0 and its only
caller does not check the return value. Let's remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
changes in v5:
- rebase against today's linux-next

changes in v4:
- rebase against today's linux-next
- add Fabio's Reviewed-by tag

changes in v3:
- rebase against today's linux-next

changes in v2:
- send the patch to the clk maintainers

 drivers/clk/imx/clk-imx25.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index bee3da2e21e1..c566be848c2d 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -74,7 +74,7 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
-static int __init __mx25_clocks_init(void __iomem *ccm_base)
+static void __init __mx25_clocks_init(void __iomem *ccm_base)
 {
 	BUG_ON(!ccm_base);
 
@@ -222,8 +222,6 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 	imx_register_uart_clocks();
 
 	imx_print_silicon_rev("i.MX25", mx25_revision());
-
-	return 0;
 }
 
 static void __init mx25_clocks_init_dt(struct device_node *np)
-- 
2.30.2

