Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0638D6E538A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDQVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDQVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE6A7AA4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDAF62A85
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4189DC4339B;
        Mon, 17 Apr 2023 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681765339;
        bh=M+0Wkonx6xgqnpncRO7OGIWleTNT95JSdoH0jUPeOZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=MpAkNO0krwEsoJPAt7dNl0COD7+wh03WF2d3c1EKXmjLKM6OZnBMcSPbqYKub1jR7
         hLsZp9CBdvceZrM2gfDGyMn9PkVoXBAL79G6J7/YShxy9ffLlPz804Z+P1rbTnR6ON
         lVAuh9boHMbLX0yd7BASNMdQ/UoeAigySsBqyZpCcHYQXBP4ght0vdteUdZk65f2Yn
         nAzuq70pEK34nvCo/eIP5nTE2nuy0HdxCLQfbNdZ2JZBgLX6A9YuSWdR3RhBEHQPhF
         7wSvaXvV+60Ho5gRttq68P2dag6QhODix4Fwf3XeCFMSCO2y5qiXGWRa8RGDfaO7fU
         Bees4prCuY2WQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] backlight: corgi_lcd: fix missing prototype
Date:   Mon, 17 Apr 2023 23:02:13 +0200
Message-Id: <20230417210213.2385912-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The corgi_lcd_limit_intensity() function is called from platform
and defined in a driver, but the driver does not see the declaration:

drivers/video/backlight/corgi_lcd.c:434:6: error: no previous prototype for 'corgi_lcd_limit_intensity' [-Werror=missing-prototypes]
  434 | void corgi_lcd_limit_intensity(int limit)

Move the prototype into a header that can be included from both
sides to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/sharpsl_pm.h | 1 -
 arch/arm/mach-pxa/spitz_pm.c   | 1 +
 include/linux/spi/corgi_lcd.h  | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.h b/arch/arm/mach-pxa/sharpsl_pm.h
index 9429900db0bb..eff9a74e787f 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.h
+++ b/arch/arm/mach-pxa/sharpsl_pm.h
@@ -105,5 +105,4 @@ void sharpsl_pm_led(int val);
 #define MAX1111_ACIN_VOLT   6u
 int sharpsl_pm_pxa_read_max1111(int channel);
 
-void corgi_lcd_limit_intensity(int limit);
 #endif
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index c783696e13b9..9571f2b5b118 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
+#include <linux/spi/corgi_lcd.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
diff --git a/include/linux/spi/corgi_lcd.h b/include/linux/spi/corgi_lcd.h
index 0b857616919c..fc6c1515dc54 100644
--- a/include/linux/spi/corgi_lcd.h
+++ b/include/linux/spi/corgi_lcd.h
@@ -15,4 +15,6 @@ struct corgi_lcd_platform_data {
 	void (*kick_battery)(void);
 };
 
+void corgi_lcd_limit_intensity(int limit);
+
 #endif /* __LINUX_SPI_CORGI_LCD_H */
-- 
2.39.2

