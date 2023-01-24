Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621C767A610
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjAXWmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjAXWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:42:08 -0500
Received: from out-243.mta0.migadu.com (out-243.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C113585
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:42:06 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674600124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvJHwd3ZtTUQMGaubg6Qm+PNWUp6rIHTegEYq4CZ9Fo=;
        b=L6NmD0bbN/VtkjhGm01kiMkr5YLrKWJcjNKZXRKkn6BCj+HmG3cGPnzOeAqzgFLcIfIO0N
        4ZaOQrrN7NHEtjmV3N14/GcpGS08eELuvgXcFm2T+EUfYKhGIwGWd2cNdKJrXl3ke9UxEN
        7sYQz4/aOTCGOkW3c+eMMhwIz+3FB2s=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Rayyan Ansari <rayyan@ansari.sh>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 1/2] drm/simpledrm: Allow physical width and height configuration via DT
Date:   Tue, 24 Jan 2023 22:41:41 +0000
Message-Id: <20230124224142.7133-2-rayyan@ansari.sh>
In-Reply-To: <20230124224142.7133-1-rayyan@ansari.sh>
References: <20230124224142.7133-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional width-mm and height-mm devicetree properties and use this
to set the DRM Display Mode instead of calculating it based on an
average DPI.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 drivers/gpu/drm/tiny/simpledrm.c | 60 +++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 162eb44dcba8..7aab7fa572f0 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -128,6 +128,23 @@ simplefb_read_u32_of(struct drm_device *dev, struct device_node *of_node,
 	return ret;
 }
 
+static int
+simplefb_read_u32_of_opt(struct drm_device *dev, struct device_node *of_node,
+			 const char *name, u32 *value)
+{
+	int ret = of_property_read_u32(of_node, name, value);
+
+	if (ret == -EINVAL) {
+		*value = 0;
+		ret = 0;
+	} else if (ret) {
+		drm_err(dev, "simplefb: cannot parse framebuffer %s: error %d\n",
+			name, ret);
+	}
+
+	return ret;
+}
+
 static int
 simplefb_read_string_of(struct drm_device *dev, struct device_node *of_node,
 			const char *name, const char **value)
@@ -184,6 +201,19 @@ simplefb_get_format_of(struct drm_device *dev, struct device_node *of_node)
 	return simplefb_get_validated_format(dev, format);
 }
 
+static int
+simplefb_get_mm_of(struct drm_device *dev, struct device_node *of_node,
+		   const char *name)
+{
+	int mm;
+	int ret = simplefb_read_u32_of_opt(dev, of_node, name, &mm);
+
+	if (ret)
+		return ret;
+	return simplefb_get_validated_int(dev, name, mm);
+}
+
+
 /*
  * Simple Framebuffer device
  */
@@ -599,16 +629,12 @@ static const struct drm_mode_config_funcs simpledrm_mode_config_funcs = {
  */
 
 static struct drm_display_mode simpledrm_mode(unsigned int width,
-					      unsigned int height)
+					      unsigned int height,
+					      unsigned int width_mm,
+					      unsigned int height_mm)
 {
-	/*
-	 * Assume a monitor resolution of 96 dpi to
-	 * get a somewhat reasonable screen size.
-	 */
 	const struct drm_display_mode mode = {
-		DRM_MODE_INIT(60, width, height,
-			      DRM_MODE_RES_MM(width, 96ul),
-			      DRM_MODE_RES_MM(height, 96ul))
+		DRM_MODE_INIT(60, width, height, width_mm, height_mm)
 	};
 
 	return mode;
@@ -622,6 +648,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	struct simpledrm_device *sdev;
 	struct drm_device *dev;
 	int width, height, stride;
+	int width_mm = 0, height_mm = 0;
 	const struct drm_format_info *format;
 	struct resource *res, *mem;
 	void __iomem *screen_base;
@@ -676,6 +703,12 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		format = simplefb_get_format_of(dev, of_node);
 		if (IS_ERR(format))
 			return ERR_CAST(format);
+		width_mm = simplefb_get_mm_of(dev, of_node, "width-mm");
+		if (width_mm < 0)
+			return ERR_PTR(width_mm);
+		height_mm = simplefb_get_mm_of(dev, of_node, "height-mm");
+		if (height_mm < 0)
+			return ERR_PTR(height_mm);
 	} else {
 		drm_err(dev, "no simplefb configuration found\n");
 		return ERR_PTR(-ENODEV);
@@ -686,7 +719,16 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			return ERR_PTR(-EINVAL);
 	}
 
-	sdev->mode = simpledrm_mode(width, height);
+	/*
+	 * Assume a monitor resolution of 96 dpi if physical dimensions
+	 * are not specified to get a somewhat reasonable screen size.
+	 */
+	if (!width_mm)
+		width_mm = DRM_MODE_RES_MM(width, 96ul);
+	if (!height_mm)
+		height_mm = DRM_MODE_RES_MM(height, 96ul);
+
+	sdev->mode = simpledrm_mode(width, height, width_mm, height_mm);
 	sdev->format = format;
 	sdev->pitch = stride;
 
-- 
2.39.1

