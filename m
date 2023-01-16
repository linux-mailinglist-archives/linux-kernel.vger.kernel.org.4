Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8966D1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjAPWuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjAPWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:49:46 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73525E24
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:45 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p66so14186593iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlMIUi+YfP7k/BEEENzXAg+UYL09PWGfuqaTM6sQw0I=;
        b=o2yBg4ngM8TYFAdxDCcoNdj0A8A3NEvcsdFljaeoCH/3TCPHvUYh1gu/7rItW/mNi/
         nrJt9nQu+F4ylYtexOOy5kqJa+VTSfDL5I7aHHLE9aoo6LknK8CVP8hPtIZcWU02uWrO
         ANhW9KWBc7+t3XNble9Hr1pmThvtY78vyvDE5sm0XiGLtaOMn0xP0NPQDuwO+/M6kkgz
         OJRi+QE9jZ99DDMCjg0lS8v4dFuI1hWrAi+6JZ6hO0SmhfSKH34It7YmZ2HbTk5Ic6a+
         tQhJ3NM9UCbr6be3ndvoVTTKSeEjzJrvfpasn9E732OHIdUtPjW4MjYgSYdgsa/Thrgi
         VuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlMIUi+YfP7k/BEEENzXAg+UYL09PWGfuqaTM6sQw0I=;
        b=Z+bY926Dn8Rh2HiJMjQJnxDTPlDStY4sZU6gWZldIIKyiHsWnXNsq+imDamxrG0AgR
         lhu5g+kH9jODTHR8Z/a+KUePvBPH1jSpqT//d4FyfBIIv2dcce48aEJAQo2MygyHDDrV
         XmL/UEwUPTkXXHbLd8QgWdS4foMZkw1OHsvKd7G3aOu/SPmpvmrvRZ7jHL5s7RI2vEOo
         b3CIoLM6JOi6dVfBJ+ii9CYV1FF8QUAmN5ZgKe7OC4D1NCjCJ2cSg2NVXdgwWfSLiz0t
         oyFel2F88KJZXWk8GXUr7xKpHKpcMkJnI194MGn9RDj3+SnMCoLf2mTdHGO/Rowdnj6+
         iNfQ==
X-Gm-Message-State: AFqh2koe3Auc/kypYGf3YepZd1z4CnNGJOwPQYCpABjrBWLcQcc0A0GS
        3jH0AiS9pE8e5lQJGKfsogRPjFy35SM=
X-Google-Smtp-Source: AMrXdXtBDkHSt71z5BDQjMOXx68uplVPX5cYkR0TUt+L/JWg3uuApC+ErwdrSBGTh2X02NhTpZy4/w==
X-Received: by 2002:a5d:9905:0:b0:6e0:58c:fb32 with SMTP id x5-20020a5d9905000000b006e0058cfb32mr552719iol.2.1673909385080;
        Mon, 16 Jan 2023 14:49:45 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6be])
        by smtp.gmail.com with ESMTPSA id f14-20020a056638112e00b0038a346207cdsm9070777jar.84.2023.01.16.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:49:44 -0800 (PST)
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
Subject: [RFC PATCH v3 1/3] drm/mipi-dsi: Fix byte order of 16-bit DCS set/get brightness
Date:   Mon, 16 Jan 2023 17:49:07 -0500
Message-Id: <20230116224909.23884-2-mailingradian@gmail.com>
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

From: Daniel Mentz <danielmentz@google.com>

The MIPI DCS specification demands that brightness values are sent in
big endian byte order. It also states that one parameter (i.e. one byte)
shall be sent/received for 8 bit wide values, and two parameters shall
be used for values that are between 9 and 16 bits wide.

Add new functions to properly handle 16-bit brightness in big endian,
since the two 8- and 16-bit cases are distinct from each other.

Fixes: 1a9d759331b8 ("drm/dsi: Implement DCS set/get display brightness")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
Link: https://android.googlesource.com/kernel/msm/+/754affd62d0ee268c686c53169b1dbb7deac8550
[richard: fix 16-bit brightness_get]
[richard: use separate functions instead of switch/case]
[richard: split into 16-bit component]
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Tested-by: Caleb Connolly <caleb@connolly.tech>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 52 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  4 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 497ef4b6a90a..4bc15fbd009d 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1224,6 +1224,58 @@ int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness);
 
+/**
+ * mipi_dsi_dcs_set_display_brightness_large() - sets the 16-bit brightness value
+ *    of the display
+ * @dsi: DSI peripheral device
+ * @brightness: brightness value
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
+					     u16 brightness)
+{
+	u8 payload[2] = { brightness >> 8, brightness & 0xff };
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+				 payload, sizeof(payload));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness_large);
+
+/**
+ * mipi_dsi_dcs_get_display_brightness_large() - gets the current 16-bit
+ *    brightness value of the display
+ * @dsi: DSI peripheral device
+ * @brightness: brightness value
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
+					     u16 *brightness)
+{
+	u8 brightness_be[2];
+	ssize_t err;
+
+	err = mipi_dsi_dcs_read(dsi, MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
+				brightness_be, sizeof(brightness_be));
+	if (err <= 0) {
+		if (err == 0)
+			err = -ENODATA;
+
+		return err;
+	}
+
+	*brightness = (brightness_be[0] << 8) | brightness_be[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_large);
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 4f503d99f668..16f30975b22b 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -296,6 +296,10 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
 					u16 brightness);
 int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
 					u16 *brightness);
+int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
+					     u16 brightness);
+int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
+					     u16 *brightness);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.39.0

