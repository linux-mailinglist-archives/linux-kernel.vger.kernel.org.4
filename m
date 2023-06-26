Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4073DB44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFZJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFZJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:21:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469B2956
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:19:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDiNu-0001YG-1H; Mon, 26 Jun 2023 11:19:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDiNs-00AAaY-3x; Mon, 26 Jun 2023 11:19:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDiNr-00HVKs-GK; Mon, 26 Jun 2023 11:19:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Julien Panis <jpanis@baylibre.com>,
        Okan Sahin <okan.sahin@analog.com>, Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] mfd: Switch two more drivers back to use struct i2c_driver::probe
Date:   Mon, 26 Jun 2023 11:19:41 +0200
Message-Id: <20230626091941.557733-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bq7oPIquMq4Lboy2h00zRETaF+nqESmlcPfKxTMse70=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkmVgs7ZZKYBC/T9Z5Gt/kcaD7bltl67MMrPiG9 v566HgDzJOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJlYLAAKCRCPgPtYfRL+ TuoVCACR+cY7VZXNGkgIQC0iK0jg86u0OKqVz+jv09Tj9EVRrq4wPrmczswLEkt9H6/ZBv9UVjl mmSj+UFqu9Q3ZfFe9NhCOzOsq/9tJHTT86mMwDluCLdT1+OJ/vZgC+Ji0zIBjEohALADnljkNJ3 FUF0AzSny13vK8goH70S5VQtj1AXzKkFtb7Bn/4Y8hqn4k4ro+dpsJ2x/CaleEtw7bt4+J3cx2y 9BEYDjOat7lwDXAqmu/MpKvdS9MmF22c/9F9g/BZHOP5WbvhYVzx32caOzfqNXxvkIBinELP2gm 34NUKA39PV/DVdvsuBxA6ekE2WlVTvRhCE5zqKfmxvu/1Fdp
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

struct i2c_driver::probe_new is about to go away. Switch the driver to
use the probe callback with the same prototype.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/max77541.c    | 2 +-
 drivers/mfd/tps6594-i2c.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
index 4a3bad3493b3..e147e949c2b3 100644
--- a/drivers/mfd/max77541.c
+++ b/drivers/mfd/max77541.c
@@ -214,7 +214,7 @@ static struct i2c_driver max77541_driver = {
 		.name = "max77541",
 		.of_match_table = max77541_of_id,
 	},
-	.probe_new = max77541_probe,
+	.probe = max77541_probe,
 	.id_table = max77541_id,
 };
 module_i2c_driver(max77541_driver);
diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index 50a3cd03b3b0..899c88c0fe77 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -235,7 +235,7 @@ static struct i2c_driver tps6594_i2c_driver = {
 		.name = "tps6594",
 		.of_match_table = tps6594_i2c_of_match_table,
 	},
-	.probe_new = tps6594_i2c_probe,
+	.probe = tps6594_i2c_probe,
 };
 module_i2c_driver(tps6594_i2c_driver);
 

base-commit: e0cbc202388af454eb771043b20db6dfe68199ec
-- 
2.39.2

