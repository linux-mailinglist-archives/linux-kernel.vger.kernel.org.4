Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023516B6806
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCLQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCLQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7171367DA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLy-0007pC-5v; Sun, 12 Mar 2023 17:15:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-003f2O-H9; Sun, 12 Mar 2023 17:15:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-004K8p-T4; Sun, 12 Mar 2023 17:15:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] clk: pwm: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:55 +0100
Message-Id: <20230312161512.2715500-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Q+rpWm1HaK4xx5/3Iyhh29mSbdCQ7CSBoKry7Jsdg+A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpGnV0BSNFK4Uz6sZ29SPWtGD/x44TndcG5w cCAsvh3fsSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36RgAKCRDB/BR4rcrs CXCTB/9RpM0vW3C+ksZO4wadXUqTA5CZwwP3+1e1bM4QumdyWcbH31e8qdKW0w2SdAxHWW98v/v SxqmVOYSnUuf3SJbtqdN2xp3Le9rRn1S5ojOIdKMcZyvFYNL/Tvg5v3Q/RCY4TrRU7vIc+tquSq I1rlxSBEnx7IlqV7cNFSeK8iqAqCL6QPbSlNv1rORND0kQw1yP3HlfUJUtmBgj1C88jVLu8mq6s N5JfHxEp/t2zlrwmRWrXJh3hdLPeE39/aJAXRHs+OCnjScEoWeTZYowqeeZ4cNKPodKgAY4kijj pFE/kaQjJpsQTEAK3TnLfPcDxDsvYKugYaN88TslTUMRuRb/
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
 drivers/clk/clk-pwm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index da2c8eddfd9f..3dd2b83d0404 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -129,11 +129,9 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	return of_clk_add_hw_provider(node, of_clk_hw_simple_get, &clk_pwm->hw);
 }
 
-static int clk_pwm_remove(struct platform_device *pdev)
+static void clk_pwm_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-
-	return 0;
 }
 
 static const struct of_device_id clk_pwm_dt_ids[] = {
@@ -144,7 +142,7 @@ MODULE_DEVICE_TABLE(of, clk_pwm_dt_ids);
 
 static struct platform_driver clk_pwm_driver = {
 	.probe = clk_pwm_probe,
-	.remove = clk_pwm_remove,
+	.remove_new = clk_pwm_remove,
 	.driver = {
 		.name = "pwm-clock",
 		.of_match_table = clk_pwm_dt_ids,
-- 
2.39.1

