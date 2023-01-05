Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134EE65EDC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjAENsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjAENrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A13D9DF;
        Thu,  5 Jan 2023 05:47:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6474E61A8D;
        Thu,  5 Jan 2023 13:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30FCC433F0;
        Thu,  5 Jan 2023 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926433;
        bh=5PvMVJ+De8GLNJxPP8DhyDrpZdidR1+tQOfU9i8T7uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw2+yIKhRrAXQmrCfUNpEWl94azK5I8+iqKBydGYHk6o8kfI9128IY5wVCjdKXECL
         MIXqh5QuXse6XkGENWc+s0wE2bX2PGpJGRmUSQvFOssPorPiCVEYRvwiNckBiQOdMw
         izgrWrne5+bC2HqNibiwNwCRC2ure4/a3NKFRvo6zG2cVhwlNuAQK5nFtQ9Uz6W/F/
         wWSlXfjh/uhQkTS8z4yslaNUUy8k84l3w77B+aI1g66t1xG9qDIsmjabHcucEMYI6u
         zStpYC6bU6u67G/oYY2WWYuUrbCl+8CQNy8g0y860hizA669dc4dmyki4HVmI8h3sj
         9+iNFhARVcdCg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH 12/27] input: remove zylonite touchscreen driver
Date:   Thu,  5 Jan 2023 14:46:07 +0100
Message-Id: <20230105134622.254560-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The PXA zylonite platform was removed, so this driver has no
remaining users.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/Kconfig           |  14 --
 drivers/input/touchscreen/Makefile          |   1 -
 drivers/input/touchscreen/zylonite-wm97xx.c | 220 --------------------
 3 files changed, 235 deletions(-)
 delete mode 100644 drivers/input/touchscreen/zylonite-wm97xx.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 5abb45ea1b1b..ca00f55eaf45 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -928,20 +928,6 @@ config TOUCHSCREEN_WM97XX_MAINSTONE
 	  To compile this driver as a module, choose M here: the
 	  module will be called mainstone-wm97xx.
 
-config TOUCHSCREEN_WM97XX_ZYLONITE
-	tristate "Zylonite accelerated touch"
-	depends on TOUCHSCREEN_WM97XX && MACH_ZYLONITE
-	depends on SND_PXA2XX_LIB_AC97
-	select TOUCHSCREEN_WM9713
-	help
-	  Say Y here for support for streaming mode with the touchscreen
-	  on Zylonite systems.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called zylonite-wm97xx.
-
 config TOUCHSCREEN_USB_COMPOSITE
 	tristate "USB Touchscreen Driver"
 	depends on USB_ARCH_HAS_HCD
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 3bc2a47c489c..7053fede594e 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -107,7 +107,6 @@ wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+= wm9712.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713)	+= wm9713.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
-obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
deleted file mode 100644
index a70fe4abe520..000000000000
-- 
2.39.0

