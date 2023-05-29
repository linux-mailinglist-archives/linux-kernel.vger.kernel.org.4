Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60DB71422E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjE2Cze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2Czd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:55:33 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BABDAC;
        Sun, 28 May 2023 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IPBfR
        OQGAHvO+OIRDKPXfjIBmCUrDAFYHoBeZw4uo3E=; b=EHWRJekNq3yl8z0N2pDf+
        QItTcwvaGPhhfdEZbmAfh+E5HxQt+hhmG65nAsaDmfGYwGJzr4Xeam6yTZ4Sm5in
        z5WVnPfnHO+NDsvar5ITpcJNRkfQ+AnYHAhC1/nLEK/UgObXhG+//6Nfq4QJio5G
        G/V+y0TjDWXup90MEG569E=
Received: from localhost.localdomain (unknown [39.144.137.9])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wA36+zmEnRk5hF9Aw--.29114S3;
        Mon, 29 May 2023 10:54:36 +0800 (CST)
From:   xingtong_wu@163.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     henning.schild@siemens.com, xingtong.wu@siemens.com
Subject: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other gpio pins
Date:   Mon, 29 May 2023 10:50:12 +0800
Message-Id: <20230529025011.2806-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529025011.2806-1-xingtong_wu@163.com>
References: <20230529025011.2806-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA36+zmEnRk5hF9Aw--.29114S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWDJr45Jw17Ww4fJr45Awb_yoW3KFW8pF
        95Jw4ru3srKr4fArWUKa1kuw1DWFyDJrWft3s5K3yjvF40yr1ftrs8Kr1rZr1Fvr9xJrZa
        qr90vF1UGr13G37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b-EfrUUUUU=
X-Originating-IP: [39.144.137.9]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiMw9+0FXmE5NcvQAAsA
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

switch pin base from static to automatic allocation to
avoid conflicts and align with other gpio chip drivers

Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index f54ca5a1775e..3875fd940ccb 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -163,7 +163,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value);
 static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 				  unsigned long config);
 
-#define F7188X_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
+#define F7188X_GPIO_BANK(_ngpio, _regbase, _label)			\
 	{								\
 		.chip = {						\
 			.label            = _label,			\
@@ -174,7 +174,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 			.direction_output = f7188x_gpio_direction_out,	\
 			.set              = f7188x_gpio_set,		\
 			.set_config	  = f7188x_gpio_set_config,	\
-			.base             = _base,			\
+			.base             = -1,				\
 			.ngpio            = _ngpio,			\
 			.can_sleep        = true,			\
 		},							\
@@ -191,98 +191,98 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 #define f7188x_gpio_data_single(type)	((type) == nct6126d)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 6, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(6, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(6, 0x90, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank f71869a_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
+	F7188X_GPIO_BANK(6, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f71882_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 4, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 4, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(4, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(4, 0xB0, DRVNAME "-4"),
 };
 
 static struct f7188x_gpio_bank f71889a_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
+	F7188X_GPIO_BANK(7, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(7, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f71889_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
+	F7188X_GPIO_BANK(7, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(7, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f81866_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
-	F7188X_GPIO_BANK(80, 8, 0x88, DRVNAME "-8"),
+	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(8, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
+	F7188X_GPIO_BANK(8, 0x88, DRVNAME "-8"),
 };
 
 
 static struct f7188x_gpio_bank f81804_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-4"),
-	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-5"),
-	F7188X_GPIO_BANK(90, 8, 0x98, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xA0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-4"),
+	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-5"),
+	F7188X_GPIO_BANK(8, 0x98, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank f81865_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(8, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(5, 0x90, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank nct6126d_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
-	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
-	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
-	F7188X_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
-	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
-	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
-	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
+	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(8, 0xE4, DRVNAME "-1"),
+	F7188X_GPIO_BANK(8, 0xE8, DRVNAME "-2"),
+	F7188X_GPIO_BANK(8, 0xEC, DRVNAME "-3"),
+	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(8, 0xF4, DRVNAME "-5"),
+	F7188X_GPIO_BANK(8, 0xF8, DRVNAME "-6"),
+	F7188X_GPIO_BANK(8, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
-- 
2.25.1

