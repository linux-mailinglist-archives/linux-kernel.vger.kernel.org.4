Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69162D42B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiKQHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiKQHf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:35:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88A66C8A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:35:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovZRA-0008RP-CB; Thu, 17 Nov 2022 08:35:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovZR8-004o4G-EG; Thu, 17 Nov 2022 08:35:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovZR8-00HDoK-Km; Thu, 17 Nov 2022 08:35:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] Input: max8997 - Convert to modern way to get a reference to a PWM
Date:   Thu, 17 Nov 2022 08:35:43 +0100
Message-Id: <20221117073543.3790449-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RHUmdzfS5kgAw35yKuhCfScFTp9Q8XCBrifuzdw6358=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdeRLyfYtfTatFvl7PMR56JYJU0K6IP3AgD3Gy09t YyL2qMuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3XkSwAKCRDB/BR4rcrsCYQdB/ 0ehWkn9MuqC7K+sPOxCxJ8i1ags3ILTQSanRJXX4cVaAq2D0Eb35ylKQ7VaPMmJy8BXtNTNMA3gk1u OjKPNNiCaHm6opTw0r/FL+nGBZK2kJ3TfSsfn4cKdFZeCKBWTu+xPoW36amKwUd+dSSd1oU+5soiPO RlmdNteN8DlHEMn997BMgEdYXPqPNfBDwxO/CRCCGLUMaOsMj7/hH47WDw6r+8/9eaTRHKwoCxXo8A XKSKy+ybWZTyja586mAL3m5/FQUBZcI374ut9d5YCm8+Cdk9r/YxloAAuvFRuQpmxUCTPp8Hx8CHJE mnl4p8M8irEa05QNJQtfSB4ivFPteg
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

pwm_request() isn't recommended to be used any more because it relies on
global IDs for the PWM which comes with different difficulties.

The new way to do things is to find the right PWM using a reference from
the platform device. (This can be created either using a device-tree
or a platform lookup table, see e.g. commit 5a4412d4a82f ("ARM: pxa:
tavorevb: Use PWM lookup table") how to do this.)

There are no in-tree users, so there are no other code locations that need
adaption.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/input/misc/max8997_haptic.c | 7 +++----
 include/linux/mfd/max8997.h         | 3 ---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index cd5e99ec1d3c..99cbc5ee89d1 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -278,8 +278,7 @@ static int max8997_haptic_probe(struct platform_device *pdev)
 		break;
 
 	case MAX8997_EXTERNAL_MODE:
-		chip->pwm = pwm_request(haptic_pdata->pwm_channel_id,
-					"max8997-haptic");
+		chip->pwm = pwm_get(&pdev->dev, NULL);
 		if (IS_ERR(chip->pwm)) {
 			error = PTR_ERR(chip->pwm);
 			dev_err(&pdev->dev,
@@ -344,7 +343,7 @@ static int max8997_haptic_probe(struct platform_device *pdev)
 	regulator_put(chip->regulator);
 err_free_pwm:
 	if (chip->mode == MAX8997_EXTERNAL_MODE)
-		pwm_free(chip->pwm);
+		pwm_put(chip->pwm);
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(chip);
@@ -360,7 +359,7 @@ static int max8997_haptic_remove(struct platform_device *pdev)
 	regulator_put(chip->regulator);
 
 	if (chip->mode == MAX8997_EXTERNAL_MODE)
-		pwm_free(chip->pwm);
+		pwm_put(chip->pwm);
 
 	kfree(chip);
 
diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997.h
index 6c98edcf4b0b..6193905abbb5 100644
--- a/include/linux/mfd/max8997.h
+++ b/include/linux/mfd/max8997.h
@@ -110,8 +110,6 @@ enum max8997_haptic_pwm_divisor {
 
 /**
  * max8997_haptic_platform_data
- * @pwm_channel_id: channel number of PWM device
- *		    valid for MAX8997_EXTERNAL_MODE
  * @pwm_period: period in nano second for PWM device
  *		valid for MAX8997_EXTERNAL_MODE
  * @type: motor type
@@ -128,7 +126,6 @@ enum max8997_haptic_pwm_divisor {
  *     [0 - 255]: available period
  */
 struct max8997_haptic_platform_data {
-	unsigned int pwm_channel_id;
 	unsigned int pwm_period;
 
 	enum max8997_haptic_motor_type type;

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.1

