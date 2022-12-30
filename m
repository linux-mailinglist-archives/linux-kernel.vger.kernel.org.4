Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE779659A18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiL3Plt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiL3PlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:41:10 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7559F1B1EE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:41:09 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BHVLpyfPcexdxBHVLp8KyJ; Fri, 30 Dec 2022 16:41:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Dec 2022 16:41:07 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] bus: bt1-axi: Use devm_clk_get_enabled() helper
Date:   Fri, 30 Dec 2022 16:41:05 +0100
Message-Id: <bb6731e2f2cdae66f3ce94cbb7760a671e034ee1.1672414841.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bus/bt1-axi.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index 70e49a6e5374..e02485270777 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -146,33 +146,14 @@ static int bt1_axi_request_rst(struct bt1_axi *axi)
 	return ret;
 }
 
-static void bt1_axi_disable_clk(void *data)
-{
-	struct bt1_axi *axi = data;
-
-	clk_disable_unprepare(axi->aclk);
-}
-
 static int bt1_axi_request_clk(struct bt1_axi *axi)
 {
-	int ret;
-
-	axi->aclk = devm_clk_get(axi->dev, "aclk");
+	axi->aclk = devm_clk_get_enabled(axi->dev, "aclk");
 	if (IS_ERR(axi->aclk))
 		return dev_err_probe(axi->dev, PTR_ERR(axi->aclk),
 				     "Couldn't get AXI Interconnect clock\n");
 
-	ret = clk_prepare_enable(axi->aclk);
-	if (ret) {
-		dev_err(axi->dev, "Couldn't enable the AXI clock\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(axi->dev, bt1_axi_disable_clk, axi);
-	if (ret)
-		dev_err(axi->dev, "Can't add AXI clock disable action\n");
-
-	return ret;
+	return 0;
 }
 
 static int bt1_axi_request_irq(struct bt1_axi *axi)
-- 
2.34.1

