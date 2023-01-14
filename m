Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347266A7D9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjANBAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjANBA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:00:29 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DD26084B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:00:28 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id u8so11601705ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y810J3KzQfR2aqbuK0dns8pKusrycDvek8iL+9qUASA=;
        b=XdgXKSRUDI7mA+iyCDrtRy1/vl9XhHBZcOwScEEwXnohGQWTnqsKP6oHamJuH3R9k7
         YfcQnT/MK1pQZNuBXhtsFmtQU/HclLUclxD0AwjyYgjIUza0MRF2bpeLf3kQKz9nF5Fd
         X7huRhWt09LLYqY7auT1qkZL8ZQGB6OUU9fzzVYjVASnqJ9DAZL848Q+5m4GT7xjVMdk
         WYe5pmBGjiWyIT22nkorbSQSfXI8BwHB1rsmEmE9/e0NYhO65tB+FQukZgMQcVUMhdD8
         UdU+KUhOkbVXZigpLMqFHVI0TV7sDiFYpjRDEpU1mKa/HWE7u6B/U2u/bbG9QdqYq8Os
         C8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y810J3KzQfR2aqbuK0dns8pKusrycDvek8iL+9qUASA=;
        b=N1DO40i88DlaMqzjW54AtPY9PwmlEuJUTBCr4Ga7uWPiO6ekNgWaFALrbxzf1RgL1Y
         gcZIf4QY6OZIuUJgY/7mAMkuV+gAYfW9ZRQhxsRmMUrJ5y5o6AC7yY+/jAuPrjWIJ7NE
         fwcioiZEBJm2krWASnbxlDUUTsHUljtKkaULN4HvyVrpGiApdS3V6ZE1uyNNdGYwDfQT
         xPgWKStLjyQGXt3EcX5vYjTaO6KLBRC4153s0MncmIw4ZTou2EQ7y6n0hYaltRRJK3Lb
         r5j06TYcjzqaCDmfyDgHeAbU/2AVz7W7E/BxBitcunW8UuKx7PI2OTVMRkRrYueSPdR+
         JCpg==
X-Gm-Message-State: AFqh2kqye4YAr3WrXp2jmmbZFv7rG6LxnT4B6gMlgClUPhmGwG+IZv1Z
        RZ79HSssAdJn3W5n/4615i1FhMv3QyA=
X-Google-Smtp-Source: AMrXdXvdzvyNPEcBo2dTCNko0YyA2FCz6UAntyW9K4phHNIHYi4IcFDz5u10dwOD953XHU5GsW4sZQ==
X-Received: by 2002:a92:cc08:0:b0:30d:92c4:8d6 with SMTP id s8-20020a92cc08000000b0030d92c408d6mr7895533ilp.10.1673658028036;
        Fri, 13 Jan 2023 17:00:28 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6463])
        by smtp.gmail.com with ESMTPSA id x13-20020a92d30d000000b0030c63d62106sm6436094ila.61.2023.01.13.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:00:27 -0800 (PST)
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
        Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH v2 2/2] drm/panel: sofef00: Use 16-bit panel brightness
Date:   Fri, 13 Jan 2023 20:00:06 -0500
Message-Id: <20230114010006.50471-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230114010006.50471-1-mailingradian@gmail.com>
References: <20230114010006.50471-1-mailingradian@gmail.com>
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
the new mipi_dsi_dcs_set_display_brightness_wide() function that
properly handles 16-bit brightness instead of doing special processing
of the brightness values.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/gpu/drm/panel/panel-samsung-sofef00.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index 1a0d24595faa..014fe350bc59 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/swab.h>
 #include <linux/backlight.h>
 
 #include <video/mipi_display.h>
@@ -221,13 +220,9 @@ static int sofef00_panel_bl_update_status(struct backlight_device *bl)
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

