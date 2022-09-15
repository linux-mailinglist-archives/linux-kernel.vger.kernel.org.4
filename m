Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB65B98C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIOK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIOK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:29:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DDDD49
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:29:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso4227694wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=t1tgoHzcuNz6608F9ral59980nRZm0iCe/jA9+SaWcw=;
        b=xfY46AXwiEIXzTNjMYfvBmoBvK4Okl/KzOSF3uSeGFm9POQCmX8JyovEnujiJcNHwM
         Q3BVJh22F5JuOT6W6BYomK3QVYIlZkz0XNt+sRs7eohfl2mDzwt9HSwzSjqL1+PF1j5C
         I99VRPz5qfWn/dIucemh/z/u9xxMc9BOy2JhbFIgxaaqqq3q9hJ6G5dA/ZIfbEJy5t0z
         zrTUFWM6+xc6gsr7KV0J85QlrOcwQ4zjeDX9eNA9jOm6bMTFUHS7HeImyzOvC1Kl9jea
         +QRxQhQeaOoNkcXJWMYW5xrvveb4Xy7B53oSinOGsWTXdBO0E9KnJAdbVNffCEsei0Jv
         kVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t1tgoHzcuNz6608F9ral59980nRZm0iCe/jA9+SaWcw=;
        b=HI29yQekojOIdlZfo5h+hXuUHK4JpfOiThIdO1C3hJtxFz2hU5db+4kGby5u6Wuxf0
         X95o+c3dYkNbBJKzcXSDzmyqugyzF7K4Nwwz4t0veC1MuxbkFDNbzyLej6VxYHRzBptB
         y3gqeARpOXilt7WUcfOSaEEnovng4OR+y0dRu379Ujmlry1BvI+s5W+4cmimC4Ms4RMw
         oGDXuxafUBKMRQUFotOtRwm+hfKlhO6ZehrdKjZMJ4C3qWq1oWVYCenSiwXW/SnSYsGk
         jUyk9KwdGko0IRCTihhDu2aZLDzO1tRvHc0/FAZRFPT4ItXHYn+FbPqMVp92Jv3tLvX2
         H0jg==
X-Gm-Message-State: ACrzQf2ydQzmLcd1gsFvi5FqCEhs+pboYnw8O8eE73dkvsWuHtXb/lUb
        4LDFivUFUdUQ45eupW/ILZZLHA==
X-Google-Smtp-Source: AMsMyM6l0IFcUEUYMdFQtm6+1h40cpF70ZwsOEncfkwpO534Z60smPFIjDXh6oCkTPCcHe7qz5kDEg==
X-Received: by 2002:a05:600c:5110:b0:3b4:b3d7:c30f with SMTP id o16-20020a05600c511000b003b4b3d7c30fmr333227wms.93.1663237770497;
        Thu, 15 Sep 2022 03:29:30 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b00228dff8d975sm2098257wrr.109.2022.09.15.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 03:29:29 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] Revert "drm/bridge: chrontel-ch7033: Add byteswap order setting"
Date:   Thu, 15 Sep 2022 12:29:24 +0200
Message-Id: <20220915102924.370090-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220915102924.370090-1-robert.foss@linaro.org>
References: <20220915102924.370090-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert this patch since it depends on devicetree functionality that
previously has been reverted in the below commit.

commit e798ba3374a1 ("Revert "dt-bindings: Add byteswap order to chrontel ch7033"")

This reverts commit ce9564cfc9aea65e68eb343c599317633bc2321a.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index c5719908ce2d..ba060277c3fd 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -68,7 +68,6 @@ enum {
 	BYTE_SWAP_GBR	= 3,
 	BYTE_SWAP_BRG	= 4,
 	BYTE_SWAP_BGR	= 5,
-	BYTE_SWAP_MAX	= 6,
 };
 
 /* Page 0, Register 0x19 */
@@ -356,8 +355,6 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
 	int hsynclen = mode->hsync_end - mode->hsync_start;
 	int vbporch = mode->vsync_start - mode->vdisplay;
 	int vsynclen = mode->vsync_end - mode->vsync_start;
-	u8 byte_swap;
-	int ret;
 
 	/*
 	 * Page 4
@@ -401,16 +398,8 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
 	regmap_write(priv->regmap, 0x15, vbporch);
 	regmap_write(priv->regmap, 0x16, vsynclen);
 
-	/* Input color swap. Byte order is optional and will default to
-	 * BYTE_SWAP_BGR to preserve backwards compatibility with existing
-	 * driver.
-	 */
-	ret = of_property_read_u8(priv->bridge.of_node, "chrontel,byteswap",
-				  &byte_swap);
-	if (!ret && byte_swap < BYTE_SWAP_MAX)
-		regmap_update_bits(priv->regmap, 0x18, SWAP, byte_swap);
-	else
-		regmap_update_bits(priv->regmap, 0x18, SWAP, BYTE_SWAP_BGR);
+	/* Input color swap. */
+	regmap_update_bits(priv->regmap, 0x18, SWAP, BYTE_SWAP_BGR);
 
 	/* Input clock and sync polarity. */
 	regmap_update_bits(priv->regmap, 0x19, 0x1, mode->clock >> 16);
-- 
2.34.1

