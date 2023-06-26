Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1090573DB18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFZJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjFZJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:18:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08A26BC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:15:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDiK3-0001E3-Na; Mon, 26 Jun 2023 11:15:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDiK3-00AAa2-2a; Mon, 26 Jun 2023 11:15:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDiK2-00HVJn-5X; Mon, 26 Jun 2023 11:15:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: raa215300: Switch back to use struct i2c_driver::probe
Date:   Mon, 26 Jun 2023 11:15:44 +0200
Message-Id: <20230626091544.557403-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Eo7Y0QRpE6Ruz3WRmJ2RCvcmW4dC42D0VpSBv+tLGUQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkmVc/bbtoPr3OdNtXbEGdxCOk0spbrFb5QXdP5 iaiNzlC5c6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJlXPwAKCRCPgPtYfRL+ TsqfB/9H6FVoGVAkGyHQ0lKZSJaNhKqEahvZIOZ+ZIgO4rBcu6JG8NeJtNIoaqwNX7kFGTdeftd CBzzDtyQ+ARHdPFLOYMgv89xBIh3WqMc272MX9O5X+RKR/dzhZkLGPEuW1kQA0/SvQmYMMLDMGQ eaWfRMUw7gGsgleBPtUroZtMU2y1UOcJ3MljckI91zVGbZ5s8A8Fhj2FK9WNGAD0dH1ZtrqI1/e jU4V7vCfjBDhd/ohAcrtxKgzU3RYpQCQ5cgUmu+KVfQY8UCyyNE5E33R5pfvmWJW95LWFR/0YET hkVIV5o2HcVOLKWYw/N3Q165kQth5XoB7EbJ5ps0loOrg+5h
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
 drivers/regulator/raa215300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/raa215300.c b/drivers/regulator/raa215300.c
index 24a1c89f5dbc..ed93468d408f 100644
--- a/drivers/regulator/raa215300.c
+++ b/drivers/regulator/raa215300.c
@@ -180,7 +180,7 @@ static struct i2c_driver raa215300_i2c_driver = {
 		.name = "raa215300",
 		.of_match_table = raa215300_dt_match,
 	},
-	.probe_new = raa215300_i2c_probe,
+	.probe = raa215300_i2c_probe,
 };
 module_i2c_driver(raa215300_i2c_driver);
 

base-commit: 7bce16630837c705f72e8fd53a11ae8c236236f4
-- 
2.39.2

