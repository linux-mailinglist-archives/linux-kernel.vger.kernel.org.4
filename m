Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7345A66E426
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAQQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjAQQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:55:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3445876AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:55:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E75E4B81912
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C21C433EF;
        Tue, 17 Jan 2023 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974527;
        bh=6AZjoVdg/RLS8USVfO6rTfrFMGXn8onUGZ+IA9c39cg=;
        h=From:To:Cc:Subject:Date:From;
        b=NePJga1609jzDZ+MX9wc3d/G0f1ZOfXmM5j9r2mDOhwYelJtAIveIM03M+JxzZrlA
         RD4ZI0xi6zNFxNrQkIUY5/VqzRVRMfgXlbXSe6R/R2Gtk01sGDCgaeDYTgpfGfneJN
         n8k5T4aDQ5OSqlE4gJWVVs4lHc0ZQBAWY/bmu/S+84dlBXge5VVXJ6mUImEv5KLS3g
         sHlludGAQNL4Ssxu3yy2evw17OAqyuznNlqpA8HgsERSkI+YT1ODBS9JOuCJcw6mwy
         8pWDo1QXZ5YTV8tyQOOVs99Pu/cI4pvmTu0cA7lxvkMJyPj9w0QscVClrzEScxM3V0
         YuyNBRVfxcykw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel: visionox: add backlight dependency
Date:   Tue, 17 Jan 2023 17:54:50 +0100
Message-Id: <20230117165522.2104380-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

The newly added driver uses the backlight subsystem but is missing the
corresponding Kconfig dependency:

arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-visionox-vtdr6130.o: in function `visionox_vtdr6130_probe':
panel-visionox-vtdr6130.c:(.text+0xdee): undefined reference to `devm_backlight_device_register'

Fixes: 65dc9360f741 ("drm: panel: Add Himax HX8394 panel controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index dd79928f5482..8f2046caaa6b 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -742,6 +742,7 @@ config DRM_PANEL_VISIONOX_VTDR6130
 	tristate "Visionox VTDR6130"
 	depends on OF
 	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for Visionox
 	  VTDR6130 1080x2400 AMOLED DSI panel.
-- 
2.39.0

