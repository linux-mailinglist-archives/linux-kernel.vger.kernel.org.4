Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB93066A7D8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjANBAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjANBA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:00:27 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D357A397
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:00:26 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id u8so11601676ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hef3HKJw/rh8LMbhGDXUzdaIfcIHyO7m2r48LhMzONQ=;
        b=Zy//f3JiIpMV+8UMCiYoIm2Tha3BaDlu356RKRLoiWjKY0XOKk1MGobKMcAb3ixLRP
         NTWR3wf4LAaxp+sYohOs90AIqfu+IbIiwZENwL6qTuSkmvefdO5/wxO41TBK72NB+D98
         M+DP2helRU+IqSnOkn7f6AtZLOgt50oEQ6G5AGD+Hn8LwoXqLbCTb6oXLZmvJ7/cf9qL
         O64PgChaj6cl+I6HmfQUsM7eMJbM3bijQ1q48UKP8hql/nN+lQNIjR7EMMO2XbWkOh2A
         YoYWtMDDiaD5ek3wWbwMw4zh7x3h1dAQkDXvW6WzKotwUUR3S0KKZnawnoGK19YHesRw
         ct0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hef3HKJw/rh8LMbhGDXUzdaIfcIHyO7m2r48LhMzONQ=;
        b=wYZhqbpracEMk+dCbDGI6LfT9oLkkNFAX2dICu+F/HN0mojEIQehkgmhMveGUTt30Y
         1KWarpoicCuptPWBx2gukJ5rPJoCIVL694gY8/p+GD8tafsTGs/P6aeSPfZthkCLOIr0
         4SoQ8MQX7HFRlbpoRDPpsHOdm39cqQkTpCIDcqz/ZpCKhOex5Vlau62b3bn0T4GFEvaY
         yOzsz7TF2o8oxHGyBS6dmYG6n39/+jnh89HmInMMCdIKNDEotK4P1voBkD2KBVGpi1yg
         j0YLKIZoVoTRNWM1Qdp3wOQwCsh7lnGZYscrj2goVAQ1dStzZ+O1aeadBA2FJSro4X3L
         0msA==
X-Gm-Message-State: AFqh2ko5084toAbGx7GiKhS9+BsChr362vrCmExwGIdCGnCKhTS/AAEU
        r6mWAKGqZLRcNY7a/AjrLLE=
X-Google-Smtp-Source: AMrXdXsIIUYD+FJQRU22iUAfjjh4RjByOXA0IuTNMrw5Nv9J8+VQxZsV6IuZ/eXk5Q7x1+wwxbhfeA==
X-Received: by 2002:a92:d186:0:b0:30d:b66e:e4e3 with SMTP id z6-20020a92d186000000b0030db66ee4e3mr10760510ilz.1.1673658026262;
        Fri, 13 Jan 2023 17:00:26 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6463])
        by smtp.gmail.com with ESMTPSA id 191-20020a021dc8000000b0039e07ca9ae5sm6566086jaj.113.2023.01.13.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:00:25 -0800 (PST)
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
Subject: [RFC PATCH v2 1/2] drm/dsi-mipi: Fix byte order of DCS set/get brightness
Date:   Fri, 13 Jan 2023 20:00:05 -0500
Message-Id: <20230114010006.50471-2-mailingradian@gmail.com>
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

From: Daniel Mentz <danielmentz@google.com>

The MIPI DCS specification demands that brightness values are sent in
big endian byte order. It also states that one parameter (i.e. one byte)
shall be sent/received for 8 bit wide values, and two parameters shall
be used for values that are between 9 and 16 bits wide.

Fixes: 1a9d759331b8 ("drm/dsi: Implement DCS set/get display brightness")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
Change-Id: I24306e21ec6a5ff48ea121d977419a81d5b44152
Link: https://android.googlesource.com/kernel/msm/+/754affd62d0ee268c686c53169b1dbb7deac8550
[richard: fix 16-bit brightness_get]
[richard: use separate functions instead of switch/case]
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
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

