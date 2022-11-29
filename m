Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1B63C84C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiK2TZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiK2TYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:24:51 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B136E56D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749651; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTAcbDsSnpHtQLYEYbOOugt9xH+f+oTO9ezz+BdhRZw=;
        b=eSSEN8JvJtkcQpLhZiF7dYIrv23KzHI1PDfUftUkizJw6CJpc2fz6gg2JpHVYM25b1bdp1
        6gEv/7b4uA9vcjfqGCpzFU53cZr8tNN0DDt2Thm7n/45lYH/vjl0kMe6GbUHzjuFsbbSFU
        afDtSsIWNkd3bhotmWt5AsyjSsC4JHI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 24/26] drm: gm12u320: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:40 +0000
Message-Id: <20221129191942.138244-11-paul@crapouillou.net>
In-Reply-To: <20221129191942.138244-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191942.138244-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pm_ptr() macro to handle the .suspend / .resume / .reset_resume
callbacks.

This macro allows the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_PM is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch. It also allows to drop the
__maybe_unused tags.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 130fd07a967d..c5bb683e440c 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/usb.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -718,15 +719,15 @@ static void gm12u320_usb_disconnect(struct usb_interface *interface)
 	drm_atomic_helper_shutdown(dev);
 }
 
-static __maybe_unused int gm12u320_suspend(struct usb_interface *interface,
-					   pm_message_t message)
+static int gm12u320_suspend(struct usb_interface *interface,
+			    pm_message_t message)
 {
 	struct drm_device *dev = usb_get_intfdata(interface);
 
 	return drm_mode_config_helper_suspend(dev);
 }
 
-static __maybe_unused int gm12u320_resume(struct usb_interface *interface)
+static int gm12u320_resume(struct usb_interface *interface)
 {
 	struct drm_device *dev = usb_get_intfdata(interface);
 	struct gm12u320_device *gm12u320 = to_gm12u320(dev);
@@ -747,11 +748,9 @@ static struct usb_driver gm12u320_usb_driver = {
 	.probe = gm12u320_usb_probe,
 	.disconnect = gm12u320_usb_disconnect,
 	.id_table = id_table,
-#ifdef CONFIG_PM
-	.suspend = gm12u320_suspend,
-	.resume = gm12u320_resume,
-	.reset_resume = gm12u320_resume,
-#endif
+	.suspend = pm_ptr(gm12u320_suspend),
+	.resume = pm_ptr(gm12u320_resume),
+	.reset_resume = pm_ptr(gm12u320_resume),
 };
 
 module_usb_driver(gm12u320_usb_driver);
-- 
2.35.1

