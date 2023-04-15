Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B956E326C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDOQ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:27:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9092689
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:27:15 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nik4pY6QZ7Jnhnik5pkskN; Sat, 15 Apr 2023 18:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681576034;
        bh=+n1C546ZL1I+N6GOU5CwCojcyLanrdxNntqvU5Ovh+w=;
        h=From:To:Cc:Subject:Date;
        b=DatsQjS0WO4wXEuyF1xcv86k8biX9DF3YSgHQKyK4UTZId+aYhwjlFTAYHgfYnVry
         OccGmeR7LgMputnJ427Wkh+193HDfPlui8DCprBU6ZrNNZC2AOuQD8Oquqmal4hZfl
         53MTEmEKRNzVGvatqbxL6Y2maUruuZwB6k/RJ1+o62X/+cnmAKqOAz5e/WRyn1ffLg
         i6uG+Ara6FW6pyWAcI2hFdYYajrUyIfmObDAEmwz6DKcCYXiHDottyYiAKS/nX6Wy1
         3wWeKhVKN+nQINRXBBebhTx0hyFuePAYmUuprPjKXMpNmfuSwIRObR4ch9yg4QtwrZ
         s5M9LVjSt6Efw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 18:27:14 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org
Subject: [PATCH] leds: pwm-multicolor: Simplify an error message
Date:   Sat, 15 Apr 2023 18:27:11 +0200
Message-Id: <07d35e221faaa380fd11cd4597e42354c8eb350c.1681576017.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already display the error code. There is no need to
duplicate it explicitly in the error message.

While at it, add a missing \n at the end of the message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/leds/rgb/leds-pwm-multicolor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-pwm-multicolor.c b/drivers/leds/rgb/leds-pwm-multicolor.c
index da9d2218ae18..46cd062b8b24 100644
--- a/drivers/leds/rgb/leds-pwm-multicolor.c
+++ b/drivers/leds/rgb/leds-pwm-multicolor.c
@@ -158,8 +158,8 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 	ret = led_pwm_mc_set(cdev, cdev->brightness);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-				     "failed to set led PWM value for %s: %d",
-				     cdev->name, ret);
+				     "failed to set led PWM value for %s\n",
+				     cdev->name);
 
 	platform_set_drvdata(pdev, priv);
 	return 0;
-- 
2.34.1

