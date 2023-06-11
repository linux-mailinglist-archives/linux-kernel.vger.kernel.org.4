Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601972B3F2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFKUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:36:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139DE4E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:36:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8RnE-00012d-Lh; Sun, 11 Jun 2023 22:36:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8RnD-006jP7-M0; Sun, 11 Jun 2023 22:36:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8RnD-00DIHF-12; Sun, 11 Jun 2023 22:36:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: Switch two more i2c drivers back to use .probe()
Date:   Sun, 11 Jun 2023 22:35:59 +0200
Message-Id: <20230611203559.827168-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=alqYFWoRPEECnbW0ZYuuo1zmSk8OOA4KUAHqug0sTCQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkhjAur/qUi69hRcHnDvDwVeRuCysVH8uU5muCQ R4Z3+CQF4KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIYwLgAKCRCPgPtYfRL+ TiUAB/4vDGnj0xCY3vsw4OX848/mJr31/JpWXXezE1YAHZIE/0VTcznnS5BZdFgNjW/9mjHC+Vs OCFzN1m0cHDQu8XEWVHtnzGRI7yCtMfyKbgzQ+JKKYDM3GgyBfwu0tvNKEGzQTuRW1IxDRwEh4F Q44l+xyGLpR7s685h0szLk2Ol5lWP/dYcpTW7gboKJsEGv3y5MbU28uKJRAN5/tM8g/pDJ1WWwZ zJ97S3fkQ+p5rD/J52lGJNo4rETeUQOagOzByqb1nR5aL5ioB9ZFBwJ+2P3M0eqfIIbjlj9Hyne uPWpTCYkHI6orIsyeRG1Ita+1yTLALpM/Y0zIEU8oLPzEams
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous conversion back to .probe done in commit 964e186547b2
("regulator: Switch i2c drivers back to use .probe()") was done based on
v6.3. Since then two more drivers were added which need to be convert
back in the same way before eventually .probe_new() can be dropped from
struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/regulator/rt5739.c             | 2 +-
 drivers/regulator/tps6287x-regulator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt5739.c b/drivers/regulator/rt5739.c
index 74fc5bf6d87e..0ce6a1666752 100644
--- a/drivers/regulator/rt5739.c
+++ b/drivers/regulator/rt5739.c
@@ -282,7 +282,7 @@ static struct i2c_driver rt5739_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rt5739_device_table,
 	},
-	.probe_new = rt5739_probe,
+	.probe = rt5739_probe,
 };
 module_i2c_driver(rt5739_driver);
 
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index 870e63ce3ff2..b1c0963586ac 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -178,7 +178,7 @@ static struct i2c_driver tps6287x_regulator_driver = {
 		.name = "tps6287x",
 		.of_match_table = tps6287x_dt_ids,
 	},
-	.probe_new = tps6287x_i2c_probe,
+	.probe = tps6287x_i2c_probe,
 	.id_table = tps6287x_i2c_id,
 };
 

base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
-- 
2.39.2

