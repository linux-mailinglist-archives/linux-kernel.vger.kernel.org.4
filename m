Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02E66D1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjAPWuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjAPWtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:49:50 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27725296
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:49 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h26so14608137ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MGJUK5g8dDeQ+HJR3sGsE5BNHrCIL6SPSjE4dQtW9Y=;
        b=gc6M8ZC6ahhun4+JlZQIhukal+fUx7cqOHh0olLM5NsLfRnjG3OEieJb9B1lyjJgWK
         GVq4npMAs1Q8wo0t4E5HepqEAkpUC3Oe733fdoLudI11lOmkqduiiS0yE/HQFbJVKR+x
         uRATcfQUHSOmRxl8xd03nTLS+R8zp94Jdm360KGjn7c6nf6AUHWk4u/hdsJrnyJv4AFz
         gWsnuzWbIQh6+UwZi6fYtP+QgCftmsM+vIUEUsnzXnJ6+skuPsL0FVnxteXN8xu5JXQk
         t6ilXM4JSOOUZXqRDrs5lzrhNkOIlEoVuOI3Oo9ZX0pId8uYYrX3xcCuVTRMk656cIXw
         XXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MGJUK5g8dDeQ+HJR3sGsE5BNHrCIL6SPSjE4dQtW9Y=;
        b=FGcmWq6AJbzLXQzEk56XQkTu0jLHbR+VceERmDOSiwjKitlegd2j5sGBOKF/MJeOYE
         J5M2bCf1jtzihZp6dpWe2GsKzBa//sOVNo2XFgiIVrsSH2YfcD8oPUCUrEM8LYKYo9Cn
         vuneXTjkSx3rGG3n0h3uAbUsnOWqLfWHco1541PaYzruFNrlnplMHeWUyo8eq/h7WcJz
         plaJuTnYBTGFDrmwlWyYEwNWeaB9QP2QoFtfIeqjLe8IvYcH2EIhf0CXhmjnRu+VVFhh
         F3n/rntU0n/L5GwPrOwGfUUt2bAqCdOX6CYSxE8/ztg6QcntEw8ZVdJLa1SBCvrEBPtH
         KzYw==
X-Gm-Message-State: AFqh2kpHMvBuI1rqQbKgAihfBoyyCXjl4Lf2O37vwgMyLRAJGyGoP6gb
        nqQ3psct6+DHndqUhyxmm5M=
X-Google-Smtp-Source: AMrXdXs8oxmkQDWUm07RaWOjawBeUQxY6M5hpGYnuVElzAKBh0KZcn3FylL48c1AaIFjECdf9VkbJg==
X-Received: by 2002:a05:6e02:be5:b0:30f:1cc:d14b with SMTP id d5-20020a056e020be500b0030f01ccd14bmr1031528ilu.0.1673909388527;
        Mon, 16 Jan 2023 14:49:48 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6be])
        by smtp.gmail.com with ESMTPSA id r6-20020a92c506000000b00300d3c0e33dsm8860747ilg.4.2023.01.16.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:49:48 -0800 (PST)
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
Subject: [RFC PATCH v3 3/3] drm/panel: vtdr6130: Use 16-bit brightness function
Date:   Mon, 16 Jan 2023 17:49:09 -0500
Message-Id: <20230116224909.23884-4-mailingradian@gmail.com>
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

This panel communicates brightness in big endian. This is not a quirk of
the panels themselves, but rather, a part of the MIPI standard. Use the
new mipi_dsi_dcs_set_display_brightness_large() function that properly
handles 16-bit brightness instead of bypassing the brightness functions
entirely.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index f9a6abc1e121..1092075b31a5 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -243,12 +243,9 @@ static int visionox_vtdr6130_bl_update_status(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
-	/* Panel needs big-endian order of brightness value */
-	u8 payload[2] = { brightness >> 8, brightness & 0xff };
 	int ret;
 
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
-				 payload, sizeof(payload));
+	mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.0

