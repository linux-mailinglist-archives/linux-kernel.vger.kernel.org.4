Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773DA71181E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjEYU2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjEYU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:28:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F6BB
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:28:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2HZ8-0004tX-Um; Thu, 25 May 2023 22:28:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2HZ7-002nk3-Ge; Thu, 25 May 2023 22:28:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2HZ6-007xUt-Lp; Thu, 25 May 2023 22:28:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] extcon: Switch i2c drivers back to use .probe()
Date:   Thu, 25 May 2023 22:28:02 +0200
Message-Id: <20230525202802.630753-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+ay54A6Jp9L7mhXpSpBiKHMUk5jWMRZUZMJ6TtTpC7Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkb8TQqKgrAwqjRuT2PjMx2yq9qmZnkHKmcuQJd 3vuJlBTh2GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG/E0AAKCRCPgPtYfRL+ Ttk3B/46y8MPrpxgrKk8fTGMKHRDP7JJRwL0NEbwnfVQs9S3hoCuHpdYXUOAafjWhnf3/aNycu1 zqcce58y9jSjuf5JhwKGzM5RUgSyEP19W8gh50u9O4YqV2sw8d84jPPLtYXlnybOTvvgco5pIkt tgOhqIAOf1Ta8w7RFQQ+frt/ciSB3iSixLZiXlgbFOMYaCkAucC6TsOlVu6QnTCim8iLT6hf68r t7bynLL8eevmMIj3sJezYYm2OH9++umEJtcpiH7pV5YiaIX+VHbz912RwyB8pC6ip96aiIBQ9DH 7TeBT8r28Mgzanhmgv4JoFLtsmeywaa7iTFvM/ayDmtkyBYx
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

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/extcon/extcon-fsa9480.c      | 2 +-
 drivers/extcon/extcon-ptn5150.c      | 2 +-
 drivers/extcon/extcon-rt8973a.c      | 2 +-
 drivers/extcon/extcon-sm5502.c       | 2 +-
 drivers/extcon/extcon-usbc-tusb320.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index e8b2671eb29b..e458ce0c45ab 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -369,7 +369,7 @@ static struct i2c_driver fsa9480_i2c_driver = {
 		.pm		= &fsa9480_pm_ops,
 		.of_match_table = fsa9480_of_match,
 	},
-	.probe_new		= fsa9480_probe,
+	.probe			= fsa9480_probe,
 	.id_table		= fsa9480_id,
 };
 
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 017a07197f38..4616da7e5430 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -348,7 +348,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
 		.name	= "ptn5150",
 		.of_match_table = ptn5150_dt_match,
 	},
-	.probe_new	= ptn5150_i2c_probe,
+	.probe		= ptn5150_i2c_probe,
 	.id_table = ptn5150_i2c_id,
 };
 module_i2c_driver(ptn5150_i2c_driver);
diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
index afc9b405d103..19bb49f13fb0 100644
--- a/drivers/extcon/extcon-rt8973a.c
+++ b/drivers/extcon/extcon-rt8973a.c
@@ -695,7 +695,7 @@ static struct i2c_driver rt8973a_muic_i2c_driver = {
 		.pm	= &rt8973a_muic_pm_ops,
 		.of_match_table = rt8973a_dt_match,
 	},
-	.probe_new = rt8973a_muic_i2c_probe,
+	.probe = rt8973a_muic_i2c_probe,
 	.remove	= rt8973a_muic_i2c_remove,
 	.id_table = rt8973a_i2c_id,
 };
diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 8401e8b27788..c8c4b9ef72aa 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -840,7 +840,7 @@ static struct i2c_driver sm5502_muic_i2c_driver = {
 		.pm	= &sm5502_muic_pm_ops,
 		.of_match_table = sm5502_dt_match,
 	},
-	.probe_new = sm5022_muic_i2c_probe,
+	.probe = sm5022_muic_i2c_probe,
 	.id_table = sm5502_i2c_id,
 };
 
diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index b408ce989c22..1251301d2005 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -501,7 +501,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
 MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
 
 static struct i2c_driver tusb320_extcon_driver = {
-	.probe_new	= tusb320_probe,
+	.probe		= tusb320_probe,
 	.driver		= {
 		.name	= "extcon-tusb320",
 		.of_match_table = tusb320_extcon_dt_match,

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

