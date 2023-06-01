Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4F7192AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjFAFsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjFAFrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:47:04 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0540D10EC;
        Wed, 31 May 2023 22:46:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 37FD046CD1;
        Thu,  1 Jun 2023 08:46:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-g8stdGLu;
        Thu, 01 Jun 2023 08:46:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598388;
        bh=EOmo+RE2lmZbsgHFDMmAtXJCZ5Gk2K8xR39C2HP8i6U=;
        h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
        b=VdnyYB/VNrOd+qfrFT1H4Id+8uaguK42lktXQ2n82X1822UuFEV66jyQl/8cAvFvT
         zc6ol3NJhdpumMgNgS+vGH9LgISgn+Eu/XLS1aqDEGovd92q2Drdo4PREXBCyf8pEB
         CTcBI91a+WZbwYnhK5lLp18OLCcBpZ8pHgmPNdmw=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 37/43] pwm: ep93xx: drop legacy pinctrl
Date:   Thu,  1 Jun 2023 08:45:42 +0300
Message-Id: <20230601054549.10843-19-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop legacy gpio request/free since we are using
pinctrl for this now.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

Notes:
    v0 -> v1:
    
    - dropped leagcy soc header

 drivers/pwm/pwm-ep93xx.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 361984ef4c0b..ac08bd0e7572 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -27,8 +27,6 @@
 
 #include <asm/div64.h>
 
-#include <linux/soc/cirrus/ep93xx.h>	/* for ep93xx_pwm_{acquire,release}_gpio() */
-
 #define EP93XX_PWMx_TERM_COUNT	0x00
 #define EP93XX_PWMx_DUTY_CYCLE	0x04
 #define EP93XX_PWMx_ENABLE	0x08
@@ -45,20 +43,6 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct ep93xx_pwm, chip);
 }
 
-static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct platform_device *pdev = to_platform_device(chip->dev);
-
-	return ep93xx_pwm_acquire_gpio(pdev);
-}
-
-static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct platform_device *pdev = to_platform_device(chip->dev);
-
-	ep93xx_pwm_release_gpio(pdev);
-}
-
 static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -157,8 +141,6 @@ static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops ep93xx_pwm_ops = {
-	.request = ep93xx_pwm_request,
-	.free = ep93xx_pwm_free,
 	.apply = ep93xx_pwm_apply,
 	.owner = THIS_MODULE,
 };
-- 
2.37.4

