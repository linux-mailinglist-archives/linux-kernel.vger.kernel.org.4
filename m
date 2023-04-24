Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F456ECA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjDXKfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjDXKer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:34:47 -0400
X-Greylist: delayed 2343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 03:34:24 PDT
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53956E42;
        Mon, 24 Apr 2023 03:34:24 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 2EA505ED20;
        Mon, 24 Apr 2023 12:36:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-IjRSbbKj;
        Mon, 24 Apr 2023 12:36:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328969;
        bh=Mx2hqLt4/z50beOgPB+ygINDekWFXL6ATj4afqN4iBs=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=qBdLkkz3cuV/oTDYOawaHRLB0ZiqRfECIW5t2bkr7rltqMAdcfnDqMedsRgH01cBB
         grZQh/5MRVdXOGnrq8Totopop9u6WEUocg3WxOElfBPrVV3LqYvTRQmjAhn+Dl21Xy
         piXcb4uyJTL+VRriFrbA6R7YuB8uu1ZsVTwc4INk=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 36/43] pwm: ep93xx: drop legacy pinctrl
Date:   Mon, 24 Apr 2023 15:34:52 +0300
Message-Id: <20230424123522.18302-37-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop legacy gpio request/free since we are using
pinctrl for this now.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/pwm/pwm-ep93xx.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 8bfe6cfbb3db..657adb011aeb 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -45,20 +45,6 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
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
@@ -157,8 +143,6 @@ static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops ep93xx_pwm_ops = {
-	.request = ep93xx_pwm_request,
-	.free = ep93xx_pwm_free,
 	.apply = ep93xx_pwm_apply,
 	.owner = THIS_MODULE,
 };
-- 
2.39.2

