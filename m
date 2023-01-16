Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE57A66D1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjAPWuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjAPWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:49:47 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A025E2C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:47 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r71so5204147iod.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omKF2YX7pGIZQKEcRL/MvPMHB5a+dIUWO4cJUKQU+u0=;
        b=CZ/0UTase2xAs8lxHI9UeqC/wdKvzNYmpbiDBVrjqyYZGIKUGnIUNlcy3Cwp+wmDeR
         d3c6Pb98pr5Y/PoyKbSFMnaVb1YvbkpejVW6ZEyWUR648sqhTe5Y9lca6Qy8qA1wFTUO
         0d2hmxgAwMij76ziFQpzZomOFM0vUZtIBM6fuaKo1TEuXX7r5yd/8Tr5IrpR6xpJxYF9
         GegZ+ZW1ybWZP2QuyhV7THjLgR8U3isBjeWRdx8ArOk6hPq7TLgc4YNxrttoTeRYqlQ0
         KxYahUCJMpiI69XCFQwKHfjWo8DkCy+Zhf2TOr/W4are0BoAi4XuyBfpAfyk0pI6Tsl/
         SFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omKF2YX7pGIZQKEcRL/MvPMHB5a+dIUWO4cJUKQU+u0=;
        b=G8tg2jNNKknHRUrU/ZeNZ5JN+3GvuY4eKQod4LwtCL5SbJEr8qtAnQiwkcnJOViT22
         KZjz/46+JBK670my1M3G+YMUuk1vudCb9W1GpiJSXVcTB7qdt/dOLUGstsL54iX0VM02
         n8GT6XH4ZhsxEzf+nTQwpJP7ajN+BUShQ95vqcICXvglvdTdZhezBiOLDQlHNWbF7M4j
         urPjsFDrrjkZhpxvHrbSaEKskFsYDRJZAr7cSvTe+IzHq9r1Fcr61c+dA9mTHH3OFjMs
         3A1r1fpKKIPFvJH8GNm21uFJKfj+i3snuhbC3cNvUMTnnLVUQTKXQK0JcdqKor1ssbpf
         4UcA==
X-Gm-Message-State: AFqh2krjyeb+AINZrY0H8l6LJxrP8GsXiQoQ6BjVha4189oftgxpLQtI
        5XDrGEfzlJEJbkR14lKYiCE=
X-Google-Smtp-Source: AMrXdXtPw+6hWBhNdeiLKTPCVjXcBFoNQ6gjAqaly6x0ETeYM27eNPMHuRAACMVCQo+sFcLbWTGtRg==
X-Received: by 2002:a05:6602:378a:b0:6e0:10d3:9631 with SMTP id be10-20020a056602378a00b006e010d39631mr695736iob.16.1673909386891;
        Mon, 16 Jan 2023 14:49:46 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6be])
        by smtp.gmail.com with ESMTPSA id z25-20020a056638215900b003a3dd1c7be7sm1791841jaj.128.2023.01.16.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:49:46 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH v3 2/3] drm/panel: sofef00: Use 16-bit brightness function
Date:   Mon, 16 Jan 2023 17:49:08 -0500
Message-Id: <20230116224909.23884-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116224909.23884-1-mailingradian@gmail.com>
References: <20230116224909.23884-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These panels communicate brightness in big endian. This is not a quirk
of the panels themselves, but rather, a part of the MIPI standard. Use
the new mipi_dsi_dcs_set_display_brightness_large() function that
properly handles 16-bit brightness instead of doing special processing
of the brightness values.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Tested-by: Caleb Connolly <caleb@connolly.tech>
---
 drivers/gpu/drm/panel/panel-samsung-sofef00.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index 9db49a028930..1ebb79e3103c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/swab.h>
 #include <linux/backlight.h>
 
 #include <video/mipi_display.h>
@@ -213,13 +212,9 @@ static int sofef00_panel_bl_update_status(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
 	int err;
-	u16 brightness;
+	u16 brightness = (u16)backlight_get_brightness(bl);
 
-	brightness = (u16)backlight_get_brightness(bl);
-	// This panel needs the high and low bytes swapped for the brightness value
-	brightness = __swab16(brightness);
-
-	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	err = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 	if (err < 0)
 		return err;
 
-- 
2.39.0

