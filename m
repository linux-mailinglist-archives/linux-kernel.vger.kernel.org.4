Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD726B6811
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCLQQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCLQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649C34F6E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-0007rH-Eb; Sun, 12 Mar 2023 17:15:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-003f36-Pq; Sun, 12 Mar 2023 17:15:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLy-004K9J-MT; Sun, 12 Mar 2023 17:15:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/30] clk: mvebu: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:03 +0100
Message-Id: <20230312161512.2715500-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4390; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WMTwTZXP8LdhrTppykw/Ey9Tf4bxrgjWhSEjSmPYxu0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfprZ5YALT/w10X6upwax85uZRgogh4gB5pws JwhwUrbucCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36awAKCRDB/BR4rcrs CWGRB/9X/lsRLoDOmA5j0fmrys8M6tXFOu0ftVULR4UklyTtE5PMdX/75F3LsWHgYppPgTAO+x7 vyPoy2/6ILVI0lb9u8MijUQa2Ozu+CJy9LzCdd/Gg81WRr2xrSoTL9LFS3TgTesuYz/Hi+1FwPD pkZs/88UVShdVeubuI+RM/vXzDM1DK8Ondr6ixD60x1ek+3izG/nP6oNHe4sV8O1MlI0zbp/rhF Z9EsSnw0/1aD74FSeB5TV1VtFF3+uRu7O4N3OJ2q63VEA9sXRKYlEKFzQjITIBirGiDfmH/X5IO lsklLlU+ei0APGgYylYNbWUdZjTzNU27OUlpG8ul/pc5hjrh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 6 ++----
 drivers/clk/mvebu/armada-37xx-tbg.c    | 6 ++----
 drivers/clk/mvebu/armada-37xx-xtal.c   | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index e3777ca65912..3ae6078f6ff7 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -781,7 +781,7 @@ static int armada_3700_periph_clock_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int armada_3700_periph_clock_remove(struct platform_device *pdev)
+static void armada_3700_periph_clock_remove(struct platform_device *pdev)
 {
 	struct clk_periph_driver_data *data = platform_get_drvdata(pdev);
 	struct clk_hw_onecell_data *hw_data = data->hw_data;
@@ -791,13 +791,11 @@ static int armada_3700_periph_clock_remove(struct platform_device *pdev)
 
 	for (i = 0; i < hw_data->num; i++)
 		clk_hw_unregister(hw_data->hws[i]);
-
-	return 0;
 }
 
 static struct platform_driver armada_3700_periph_clock_driver = {
 	.probe = armada_3700_periph_clock_probe,
-	.remove = armada_3700_periph_clock_remove,
+	.remove_new = armada_3700_periph_clock_remove,
 	.driver		= {
 		.name	= "marvell-armada-3700-periph-clock",
 		.of_match_table = armada_3700_periph_clock_of_match,
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index fc403ad735ad..eccc1aeefbaf 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -126,7 +126,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_tbg_data);
 }
 
-static int armada_3700_tbg_clock_remove(struct platform_device *pdev)
+static void armada_3700_tbg_clock_remove(struct platform_device *pdev)
 {
 	int i;
 	struct clk_hw_onecell_data *hw_tbg_data = platform_get_drvdata(pdev);
@@ -134,8 +134,6 @@ static int armada_3700_tbg_clock_remove(struct platform_device *pdev)
 	of_clk_del_provider(pdev->dev.of_node);
 	for (i = 0; i < hw_tbg_data->num; i++)
 		clk_hw_unregister_fixed_factor(hw_tbg_data->hws[i]);
-
-	return 0;
 }
 
 static const struct of_device_id armada_3700_tbg_clock_of_match[] = {
@@ -145,7 +143,7 @@ static const struct of_device_id armada_3700_tbg_clock_of_match[] = {
 
 static struct platform_driver armada_3700_tbg_clock_driver = {
 	.probe = armada_3700_tbg_clock_probe,
-	.remove = armada_3700_tbg_clock_remove,
+	.remove_new = armada_3700_tbg_clock_remove,
 	.driver		= {
 		.name	= "marvell-armada-3700-tbg-clock",
 		.of_match_table = armada_3700_tbg_clock_of_match,
diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
index 41271351cf1f..0e2e7d00ae11 100644
--- a/drivers/clk/mvebu/armada-37xx-xtal.c
+++ b/drivers/clk/mvebu/armada-37xx-xtal.c
@@ -65,11 +65,9 @@ static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int armada_3700_xtal_clock_remove(struct platform_device *pdev)
+static void armada_3700_xtal_clock_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-
-	return 0;
 }
 
 static const struct of_device_id armada_3700_xtal_clock_of_match[] = {
@@ -79,7 +77,7 @@ static const struct of_device_id armada_3700_xtal_clock_of_match[] = {
 
 static struct platform_driver armada_3700_xtal_clock_driver = {
 	.probe = armada_3700_xtal_clock_probe,
-	.remove = armada_3700_xtal_clock_remove,
+	.remove_new = armada_3700_xtal_clock_remove,
 	.driver		= {
 		.name	= "marvell-armada-3700-xtal-clock",
 		.of_match_table = armada_3700_xtal_clock_of_match,
-- 
2.39.1

