Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA4711897
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjEYU6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEYU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:58:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D4194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:58:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2I2n-0008BB-W3; Thu, 25 May 2023 22:58:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2I2n-002npV-4y; Thu, 25 May 2023 22:58:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2I2l-007xf5-VD; Thu, 25 May 2023 22:58:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] auxdisplay: Switch i2c drivers back to use .probe()
Date:   Thu, 25 May 2023 22:58:40 +0200
Message-Id: <20230525205840.734432-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WDheXxcyv2C6WJm5pPhJajYgMN7v+nb7XRs/N10gpJM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkb8v+jh5Jj5XTs5Q6lI+/2GAdBLfmi28HhaXNS OQoxT6qH1WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG/L/gAKCRCPgPtYfRL+ TkxCB/9LCnlyQrxnWwWfD9PITjVN51iFgWuBioOTDpIZJVYh/774jvKt1pKEMlH0S2sY8IRHdBV etCE7YnCgLCKQys7B0YwuCJfi3mCXNO3AgP3Fuy121gy0dalMQ/hDTTxxHJ0UEM3GHnNW0LGMDW fuwvOELcm3mgm7V2WihJ8uHi3LRle3kpXTL88HpdfyfgW6g9H+750DjSZAjGq5g33NJA0bMPEJN l+r+JgMKXrEMQWUY4YsiXTC+xOx1hdpv0u2jXBfwR4+XIESCWEJAsES6vK+Pryh0HShvxxnr0eK YJlDuT+VecNqW7p2HXxe4wcsKr+3rT7dkYNFxR8aSDzmdQeW
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
 drivers/auxdisplay/ht16k33.c | 2 +-
 drivers/auxdisplay/lcd2s.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 02425991c159..d44814b9562a 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -820,7 +820,7 @@ static const struct of_device_id ht16k33_of_match[] = {
 MODULE_DEVICE_TABLE(of, ht16k33_of_match);
 
 static struct i2c_driver ht16k33_driver = {
-	.probe_new	= ht16k33_probe,
+	.probe		= ht16k33_probe,
 	.remove		= ht16k33_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 135831a16514..6422be0dfe20 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -365,7 +365,7 @@ static struct i2c_driver lcd2s_i2c_driver = {
 		.name = "lcd2s",
 		.of_match_table = lcd2s_of_table,
 	},
-	.probe_new = lcd2s_i2c_probe,
+	.probe = lcd2s_i2c_probe,
 	.remove = lcd2s_i2c_remove,
 	.id_table = lcd2s_i2c_id,
 };

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

