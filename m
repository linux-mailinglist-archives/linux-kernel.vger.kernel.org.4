Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7767E15B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjA0KRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjA0KRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:17:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20762DBC9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:17:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pLLnb-0000It-0H; Fri, 27 Jan 2023 11:17:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pLLnb-000lL8-7F; Fri, 27 Jan 2023 11:17:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pLLnZ-00GGtV-5Y; Fri, 27 Jan 2023 11:17:33 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: max20411: Convert to i2c's .probe_new()
Date:   Fri, 27 Jan 2023 11:17:26 +0100
Message-Id: <20230127101726.1313927-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K8fuR6YVVy7Mx50qAVTWWO9NTfOzag1c/ArLj19HLJo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj06SxrxsgOLxNcybYyLgjPyJkoaFPB+EHJCvqKpny 7bwP14eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY9OksQAKCRDB/BR4rcrsCUSkCA Cafz5WWJZJ9KkTDMUpcxDdmWrK0L+kTUTDd9xRatOHSYfAWbe1lRp7hTeFz1MoyBVaT2ED4e5JEjmn 8rFt79hFTuAKMqFgIliqXmZrf82CKQUVk3ZvGs/i266q7VXvx3JLcl9kfWcJOskpKwTNJW0kAqEDds ZMpbJyfYZHVVXo2gbxMyvY0rsfH/yIRVvfdefL2eVtOnURajkyt6TU/q7purPQOu1lyoIx+RpAGMBt RzoI4Cem9bKBrQ3cKqMDEzmDDqV9Hhw/RsgoUGQUn/yNANDAFm6yixcuL0G4JR4LSIqepv7X56D/Yr OG5koMTKFK262DKBvKXyKlrkbnU1mo
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

The probe function doesn't make use of the i2c_device_id * parameter so
it can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
There is an ongoing effort to convert all drivers to .probe_new to
eventually drop .probe with the i2c_device_id parameter. This driver
currently sits in next so wasn't on my radar before.

My plan is to tackle that after the next merge window. So I ask you to
either apply this patch during the next merge window or accept that it
will go in via the i2c tree together with the patch that drops .probe().
---
 drivers/regulator/max20411-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index b4faad54c458..e75d16048e2f 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -96,8 +96,7 @@ static const struct regulator_desc max20411_desc = {
 	.n_ramp_values = ARRAY_SIZE(max20411_slew_rates),
 };
 
-static int max20411_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int max20411_probe(struct i2c_client *client)
 {
 	struct regulator_init_data *init_data;
 	struct device *dev = &client->dev;
@@ -156,7 +155,7 @@ static struct i2c_driver max20411_i2c_driver = {
 		.name = "max20411",
 		.of_match_table	= of_max20411_match_tbl,
 	},
-	.probe = max20411_probe,
+	.probe_new = max20411_probe,
 	.id_table = max20411_id,
 };
 module_i2c_driver(max20411_i2c_driver);
-- 
2.39.0

