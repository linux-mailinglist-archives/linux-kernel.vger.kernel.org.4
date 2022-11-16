Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6862BFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKPNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:44:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED11B1D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:44:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g12so29761830wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8czfhSUs3mWHeIfFdLH5/G0a3Uk3RSmYGgvVFUZjxw=;
        b=NT+BUGGtGZAE2pjUnqSGkFkx3B1JCAolXNU5i9AiCCH7MdU4HJuegoVnVsC45K8Iow
         jzJ7a8el4ZGSDJ6zEC9Z/GE3NEKoZvkhcIXqAon3nxxO47/i0Y/ELCUOUX7GkxB94T2I
         SZcO9pXD6CAGQKO7LeaJ21mYHK6PnybDztnrrEAYG/4oEPk268L6V2HJ40V9/2cupmT/
         DDknWLgdezM7NSFros3VfLOKEKYVXpzEfx+V34ZRARZs7EBxkVCwAWORLorCfNzaYRwl
         f6b7K1Kzm+WZNZoM96e7VIMNs6xtYjc9YbRKrRU8A/Y8I7s1NmOPmfXAzC03wBPejwdH
         2euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8czfhSUs3mWHeIfFdLH5/G0a3Uk3RSmYGgvVFUZjxw=;
        b=GibHJ8rYLJpSPzwopaZkJGpxOcu4umnzC80x1LypIX/satFI0ziZARq6eFfs3t7yDr
         wDy+C8bYz0A7aBXNYC2WLjgcEX1a2LWQnImuwtws4ane6qlkWFOdjN4j3qwQjRtb4nN4
         WZvTS0Alj9mNtaR8d1oqdRTUDtxr5LjVhRzP8IO9tWSWSP26GcmP+ileVqqItzwKbYRp
         GGYuEcr/S2YhZjqo7/CZut/w+/pR683tBrfv05Mv8zPuQWaxEI4RgECubSbTvA919xVw
         qNYpXpAFynqZF2LZHSQgYaqXdiBbIcdnCd5NSNJ8s+YPYYER0Albrb4uvdhxfrD0N7q9
         Ggdw==
X-Gm-Message-State: ANoB5pnKmj1k08yNCyjLlOaFcccKMymM16LJ3Rhg3cboh1YPquqSyWP8
        41HzDMJrOMgMEo0J0fjz9Sk=
X-Google-Smtp-Source: AA0mqf67ZMlz+LUVMxCXN1/IrpPbOUHhtbCF/kaOO3d28Z3gsn7J2mkZlI9xuSJe+siQptMk1PxrHA==
X-Received: by 2002:a5d:6f06:0:b0:236:5726:f1b with SMTP id ay6-20020a5d6f06000000b0023657260f1bmr13685093wrb.231.1668606274179;
        Wed, 16 Nov 2022 05:44:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:5da:d460:bf85:51f8:ca78:20c2])
        by smtp.googlemail.com with ESMTPSA id g18-20020a05600c4ed200b003cf6e1df4a8sm2594584wmq.15.2022.11.16.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:44:33 -0800 (PST)
From:   Guillaume BRUN <the.cheaterman@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     Guillaume BRUN <the.cheaterman@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420
Date:   Wed, 16 Nov 2022 14:44:19 +0100
Message-Id: <20221116134419.16581-1-the.cheaterman@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Cheap monitors sometimes advertise YUV modes they don't really have
(HDMI specification mandates YUV support so even monitors without actual
support will often wrongfully advertise it) which results in YUV matches
and user forum complaints of a red tint to light colour display areas in
common desktop environments.

Moving the default RGB fall-back before YUV selection results in RGB
mode matching in most cases, reducing complaints.

Fixes: 6c3c719936da ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")
Signed-off-by: Guillaume BRUN <the.cheaterman@gmail.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 40d8ca37f5bc..aa51c61a78c7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2720,6 +2720,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	 * if supported. In any case the default RGB888 format is added
 	 */
 
+	/* Default 8bit RGB fallback */
+	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+
 	if (max_bpc >= 16 && info->bpc == 16) {
 		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
@@ -2753,9 +2756,6 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
 		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
 
-	/* Default 8bit RGB fallback */
-	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
-
 	*num_output_fmts = i;
 
 	return output_fmts;
-- 
2.37.3

