Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7971EFA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjFAQuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFAQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:49:29 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBF1A2;
        Thu,  1 Jun 2023 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1vqldTdNzpvO/yWdW/72YvIUl497xOnquYw80TxcOt4=; b=v/KW0AI9kPY9m5StkAIXu5ZgCG
        xJa+5o81vji3IsR2li2hotp9FGiMFbCO1/GEkVWPwDvcGYjjdFWob4WvP6b/GXUKDD5LjLZU+Nqa5
        grWrjuTArzMsr8h2biZLLNA/1VCSdSSgmbZIlNCfhevJs0DXnCJ1xoiWz13WPJFoFMtA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53588 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q4lCq-0003BU-Uj; Thu, 01 Jun 2023 12:31:21 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Date:   Thu,  1 Jun 2023 12:31:07 -0400
Message-Id: <20230601163113.2785657-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230601163113.2785657-1-hugo@hugovil.com>
References: <20230601163113.2785657-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v5 3/9] serial: sc16is7xx: refactor GPIO controller registration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

In preparation for upcoming patch "fix regression with GPIO
configuration". To facilitate review and make code more modular.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 39 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 0c903d44429c..279d7dcb1447 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1349,6 +1349,26 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 
 	return 0;
 }
+
+static int sc16is7xx_setup_gpio_chip(struct device *dev)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(dev);
+
+	if (!s->devtype->nr_gpio)
+		return 0;
+
+	s->gpio.owner		 = THIS_MODULE;
+	s->gpio.parent		 = dev;
+	s->gpio.label		 = dev_name(dev);
+	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+	s->gpio.get		 = sc16is7xx_gpio_get;
+	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+	s->gpio.set		 = sc16is7xx_gpio_set;
+	s->gpio.base		 = -1;
+	s->gpio.ngpio		 = s->devtype->nr_gpio;
+	s->gpio.can_sleep	 = 1;
+	return gpiochip_add_data(&s->gpio, s);
+}
 #endif
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
@@ -1502,22 +1522,9 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_thread;
-	}
+	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);
+	if (ret)
+		goto out_thread;
 #endif
 
 	/*
-- 
2.30.2

