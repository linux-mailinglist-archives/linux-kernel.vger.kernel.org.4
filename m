Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250AF6FC9DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEIPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjEIPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:07:55 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628B140C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:07:54 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:5484:c4b7:4aff:589c])
        by xavier.telenet-ops.be with bizsmtp
        id uf7p2900Y2rLuoZ01f7pbN; Tue, 09 May 2023 17:07:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwOwI-001h8b-LY;
        Tue, 09 May 2023 17:07:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwOwP-00EpLt-Cq;
        Tue, 09 May 2023 17:07:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] leds: Make LEDS_TI_LMU_COMMON invisible
Date:   Tue,  9 May 2023 17:07:47 +0200
Message-Id: <91f6efaa48c36320e58b6a312025ae9b39ee206b.1683644796.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, LEDS_LM3697 and LEDS_LM36274 depend on LEDS_TI_LMU_COMMON,
which contains the common code to support TI LMU devices.  This means
the user is asked about the common code first, followed by the
individual drivers, if their dependencies are met.

Simplify this, and reduce the number of questions by making
LEDS_TI_LMU_COMMON invisible, and letting it be selected when needed.

Fixes: 3fce8e1eb9945c27 ("leds: TI LMU: Add common code for TI LMU devices")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Exposed by commit a61079efc8788858 ("leds: TI_LMU_COMMON: select REGMAP
instead of depending on it").
---
 drivers/leds/Kconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 717c3bd804058813..55733fd4b1fb3860 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -814,8 +814,7 @@ config LEDS_SPI_BYTE
 	  supported: Ubiquiti airCube ISP microcontroller based LED controller.
 
 config LEDS_TI_LMU_COMMON
-	tristate "LED driver for TI LMU"
-	depends on LEDS_CLASS
+	tristate "LED driver for TI LMU" if COMPILE_TEST
 	select REGMAP
 	help
 	  Say Y to enable the LED driver for TI LMU devices.
@@ -824,16 +823,16 @@ config LEDS_TI_LMU_COMMON
 
 config LEDS_LM3697
 	tristate "LED driver for LM3697"
-	depends on LEDS_TI_LMU_COMMON
-	depends on I2C && OF
+	depends on LEDS_CLASS && I2C && OF
+	select LEDS_TI_LMU_COMMON
 	help
 	  Say Y to enable the LM3697 LED driver for TI LMU devices.
 	  This supports the LED device LM3697.
 
 config LEDS_LM36274
 	tristate "LED driver for LM36274"
-	depends on LEDS_TI_LMU_COMMON
-	depends on MFD_TI_LMU
+	depends on LEDS_CLASS && MFD_TI_LMU
+	select LEDS_TI_LMU_COMMON
 	help
 	  Say Y to enable the LM36274 LED driver for TI LMU devices.
 	  This supports the LED device LM36274.
-- 
2.34.1

