Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3565772E14E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbjFMLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjFMLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:09:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57AF10DE;
        Tue, 13 Jun 2023 04:09:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2A2E223E7;
        Tue, 13 Jun 2023 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686654597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=759wPSS2YZhgjZvqqs3DuVdRpXqcbQxPoHRkgNwrzjQ=;
        b=hB2LOkFdJ+zgRNkt1Xil1QsWxaSSGjhWIEkLnnB+ViefVknwgzP+1uVoJXm5oVEYtOKwaK
        iYZSd1mpgCuQz+47nSm+EndIsjAN/yhXD8m4zlUlNJ7H5V7IDE+3/2gq0puNLgJNUc0cjd
        cNZltbFm3n6FwjCID/HOxOq/GANXEjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686654597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=759wPSS2YZhgjZvqqs3DuVdRpXqcbQxPoHRkgNwrzjQ=;
        b=IEJlUU0QgQc1tc+jsRfLDZZsU94E6dRYpY9GsfopDnR7T62da6D3m9rgkIJCnVqZsF/Poi
        VUtvvBgd/IgiQsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 490D313483;
        Tue, 13 Jun 2023 11:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QJ7tEIVOiGR8CQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 13 Jun 2023 11:09:57 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v3 04/38] backlight/gpio_backlight: Rename field 'fbdev' to 'dev'
Date:   Tue, 13 Jun 2023 13:06:39 +0200
Message-ID: <20230613110953.24176-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230613110953.24176-1-tzimmermann@suse.de>
References: <20230613110953.24176-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the field 'fbdev' in struct gpio_backlight_platform_data and
struct gpio_backlight to 'dev', as they store pointers to the Linux
platform device; not the fbdev device. Makes the code easier to
understand.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-sh@vger.kernel.org
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/sh/boards/mach-ecovec24/setup.c         | 2 +-
 drivers/video/backlight/gpio_backlight.c     | 6 +++---
 include/linux/platform_data/gpio_backlight.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 674da7ebd8b7f..310513646c9b3 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -386,7 +386,7 @@ static struct property_entry gpio_backlight_props[] = {
 };
 
 static struct gpio_backlight_platform_data gpio_backlight_data = {
-	.fbdev = &lcdc_device.dev,
+	.dev = &lcdc_device.dev,
 };
 
 static const struct platform_device_info gpio_backlight_device_info = {
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 5c5c99f7979e3..d3bea42407f15 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 
 struct gpio_backlight {
-	struct device *fbdev;
+	struct device *dev;
 	struct gpio_desc *gpiod;
 };
 
@@ -35,7 +35,7 @@ static int gpio_backlight_check_fb(struct backlight_device *bl,
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
 
-	return gbl->fbdev == NULL || gbl->fbdev == info->device;
+	return !gbl->dev || gbl->dev == info->device;
 }
 
 static const struct backlight_ops gpio_backlight_ops = {
@@ -59,7 +59,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (pdata)
-		gbl->fbdev = pdata->fbdev;
+		gbl->dev = pdata->dev;
 
 	def_value = device_property_read_bool(dev, "default-on");
 
diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
index 1a8b5b1946fe4..323fbf5f76139 100644
--- a/include/linux/platform_data/gpio_backlight.h
+++ b/include/linux/platform_data/gpio_backlight.h
@@ -8,7 +8,7 @@
 struct device;
 
 struct gpio_backlight_platform_data {
-	struct device *fbdev;
+	struct device *dev;
 };
 
 #endif
-- 
2.41.0

