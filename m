Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A149659A46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiL3QAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiL3QAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:00:16 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5D95A4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:00:15 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BHnmp7f8kLrOWBHnnp1MiM; Fri, 30 Dec 2022 17:00:13 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Dec 2022 17:00:13 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/bridge: tc358767: Use devm_clk_get_enabled() helper
Date:   Fri, 30 Dec 2022 17:00:09 +0100
Message-Id: <208546ce4e01973da1eb9ad7bc0f9241f650b3af.1672415956.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
Change in v2:
  - Convert to dev_err_probe()    [Andrzej Hajda]
  - Update the error message    [Andrzej Hajda]
  - Add R-b tag    [Andrzej Hajda]

v1:
https://lore.kernel.org/all/4f855984ea895e1488169e77935fa6e044912ac2.1672414073.git.christophe.jaillet@wanadoo.fr/
---
 drivers/gpu/drm/bridge/tc358767.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 2a58eb271f70..99f3d5ca7257 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2022,13 +2022,6 @@ static int tc_probe_bridge_endpoint(struct tc_data *tc)
 	return -EINVAL;
 }
 
-static void tc_clk_disable(void *data)
-{
-	struct clk *refclk = data;
-
-	clk_disable_unprepare(refclk);
-}
-
 static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
@@ -2045,20 +2038,10 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (ret)
 		return ret;
 
-	tc->refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(tc->refclk)) {
-		ret = PTR_ERR(tc->refclk);
-		dev_err(dev, "Failed to get refclk: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(tc->refclk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, tc_clk_disable, tc->refclk);
-	if (ret)
-		return ret;
+	tc->refclk = devm_clk_get_enabled(dev, "ref");
+	if (IS_ERR(tc->refclk))
+		return dev_err_probe(dev, PTR_ERR(tc->refclk),
+				     "Failed to get and enable the ref clk\n");
 
 	/* tRSTW = 100 cycles , at 13 MHz that is ~7.69 us */
 	usleep_range(10, 15);
-- 
2.34.1

