Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286256A7D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCBJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:13:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82319AD07
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:13:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXezh-0007mj-I3; Thu, 02 Mar 2023 10:12:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXezg-001IPj-92; Thu, 02 Mar 2023 10:12:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXezf-001W1r-GU; Thu, 02 Mar 2023 10:12:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] misc: sram: Improve and simplify clk handling
Date:   Thu,  2 Mar 2023 10:12:51 +0100
Message-Id: <20230302091251.1852454-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2553; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=79f3oqYl4fstIXA+fENaf7H698JlJ9S6m/Euq4PXaW0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAGiQebfxS6jf01Xmu0QGxAx7wiQYNGvoh9gDC lhHjtygF+iJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZABokAAKCRDB/BR4rcrs CVhoB/9Irqlo/JauvUqH6xQQQmHcHaAlBNk5VYP28OkzNIrowe0PhSEcSlnGLoLetH/asgh0a+r tig35TUGtxnRpaBAu6TBaJvJwdbCfZ7oV3fdyA8nzq9lq0mmmyYWn/pjCChGeOA6EhHFAFo6ya2 osZzEfS3jJv4UiKYTSQK7QgWz5OSrTVJJdHmR5yy9R/VQLnBxUH5+7HNu8+dM/B1uVNePGHxyNm D3xF36nXvwRfq8Z/MYthjnGmOEjxB7zsRzhuzKu75Spb6YWAhjGAaIb7keVdU6EvI57Nlnx3gr6 +UpspujtyCjFz7dQjvdyAmgDCgE3ukM8C05oNddxT2taRGCO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code tries to get an associated clk, ignores any errors in the
process and if there is a clock enables it unconditionally for the whole
lifetime of the sram device.

Instead use an "optional" variant of devm_clk_get() which handles the case
where no clk is needed for the sram device and do proper error handling
for the remaining error cases. Also use an "enabled" variant of
devm_clk_get() to simplify. With that .probe() is the only function using
struct sram_dev::clk, so it can be replaced by a local variable.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/sram.c | 17 +++++------------
 drivers/misc/sram.h |  1 -
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f0e7f02605eb..dec92580a42c 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -381,6 +381,7 @@ static int sram_probe(struct platform_device *pdev)
 	struct sram_dev *sram;
 	int ret;
 	struct resource *res;
+	struct clk *clk;
 
 	config = of_device_get_match_data(&pdev->dev);
 
@@ -409,16 +410,14 @@ static int sram_probe(struct platform_device *pdev)
 			return PTR_ERR(sram->pool);
 	}
 
-	sram->clk = devm_clk_get(sram->dev, NULL);
-	if (IS_ERR(sram->clk))
-		sram->clk = NULL;
-	else
-		clk_prepare_enable(sram->clk);
+	clk = devm_clk_get_optional_enabled(sram->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	ret = sram_reserve_regions(sram,
 			platform_get_resource(pdev, IORESOURCE_MEM, 0));
 	if (ret)
-		goto err_disable_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, sram);
 
@@ -436,9 +435,6 @@ static int sram_probe(struct platform_device *pdev)
 
 err_free_partitions:
 	sram_free_partitions(sram);
-err_disable_clk:
-	if (sram->clk)
-		clk_disable_unprepare(sram->clk);
 
 	return ret;
 }
@@ -452,9 +448,6 @@ static int sram_remove(struct platform_device *pdev)
 	if (sram->pool && gen_pool_avail(sram->pool) < gen_pool_size(sram->pool))
 		dev_err(sram->dev, "removed while SRAM allocated\n");
 
-	if (sram->clk)
-		clk_disable_unprepare(sram->clk);
-
 	return 0;
 }
 
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index d2058d8c8f1d..397205b8bf6f 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -27,7 +27,6 @@ struct sram_dev {
 	bool no_memory_wc;
 
 	struct gen_pool *pool;
-	struct clk *clk;
 
 	struct sram_partition *partition;
 	u32 partitions;

base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
-- 
2.39.1

