Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430E728266
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjFHOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbjFHOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:11:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A051272A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:11:36 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q7GME-00084b-Ja; Thu, 08 Jun 2023 16:11:22 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu, 08 Jun 2023 16:11:14 +0200
Subject: [PATCH] backlight: pwm_bl: Avoid backlight flicker applying initial PWM state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-backlight-pwm-avoid-flicker-v1-1-afd380d50174@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAILhgWQC/x2NQQrDIBAAvxL23AWzhSD9SulB3TUusSZomxZC/
 l7pceYwc0CTqtLgNhxQZdema+kwXgYIyZVZULkzkKGrmYxF78KSdU4v3D5PdPuqjDFrWKQiE7Pl
 kaKlCXrBuyboqysh9UZ559zlViXq97+8P87zBwr6KW2CAAAA
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.12-dev-aab37
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial PWM state returned by pwm_init_state() has a duty cycle
of 0 ns. To avoid backlight flicker when taking over an enabled
display from the bootloader, skip the initial pwm_apply_state()
and leave the PWM be until backlight_update_state() will apply the
state with the desired brightness.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
With a PWM driver that allows to inherit PWM state from the bootloader,
postponing the initial pwm_apply_state() with 0 ns duty cycle allows to
set the desired duty cycle before the PWM is set, avoiding a short flicker
if the backlight was previously enabled and will be enabled again.
---
 drivers/video/backlight/pwm_bl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fce412234d10..47a917038f58 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -531,12 +531,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (!state.period && (data->pwm_period_ns > 0))
 		state.period = data->pwm_period_ns;
 
-	ret = pwm_apply_state(pb->pwm, &state);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
-			ret);
-		goto err_alloc;
-	}
+	/*
+	 * No need to apply initial state, except in the error path.
+	 * State will be applied by backlight_update_status() on success.
+	 */
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 
@@ -573,7 +571,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev,
 				"failed to setup default brightness table\n");
-			goto err_alloc;
+			goto err_apply;
 		}
 
 		for (i = 0; i <= data->max_brightness; i++) {
@@ -602,7 +600,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (IS_ERR(bl)) {
 		dev_err(&pdev->dev, "failed to register backlight\n");
 		ret = PTR_ERR(bl);
-		goto err_alloc;
+		goto err_apply;
 	}
 
 	if (data->dft_brightness > data->max_brightness) {
@@ -619,6 +617,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, bl);
 	return 0;
 
+err_apply:
+	pwm_apply_state(pb->pwm, &state);
 err_alloc:
 	if (data->exit)
 		data->exit(&pdev->dev);

---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230608-backlight-pwm-avoid-flicker-d2dd8d12f826

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>
