Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D16DC9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDJRCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDJRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:02:22 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8591BF2;
        Mon, 10 Apr 2023 10:02:22 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pluuI-0005B6-06;
        Mon, 10 Apr 2023 19:02:18 +0200
Date:   Mon, 10 Apr 2023 18:02:11 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Maxime Ripard <mripard@kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH] input: touchscreen: edt-ft5x06: select REGMAP_I2C
Message-ID: <ZDRBExF1xmxalMZc@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After starting to use regmap API to access registers the edt-ft5x06
driver depends on symbols provided by REGMAP_I2C:

edt-ft5x06.o: in function `edt_ft5x06_ts_probe':
edt-ft5x06.c:1154: undefined reference to `__regmap_init_i2c'
edt-ft5x06.o: in function `edt_ft5x06_ts_identify':
edt-ft5x06.c:897: undefined reference to `__regmap_init_i2c'

Make sure support for I2C regmap is actually selected by adding this
dependency to Kconfig.

Fixes: 9dfd9708ffba ("Input: edt-ft5x06 - convert to use regmap API")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 1feecd7ed3cb5..143ff43c67ae3 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -768,6 +768,7 @@ config TOUCHSCREEN_PENMOUNT
 config TOUCHSCREEN_EDT_FT5X06
 	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y here if you have an EDT "Polytouch" touchscreen based
 	  on the FocalTech FT5x06 family of controllers connected to
-- 
2.40.0

