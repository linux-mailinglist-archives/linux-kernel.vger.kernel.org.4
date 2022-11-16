Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202862C102
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKPOfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:35:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6315A25
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:35:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs21so30234415wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8czfhSUs3mWHeIfFdLH5/G0a3Uk3RSmYGgvVFUZjxw=;
        b=WGzXTljvZSs2p0IjXnKub2fXvs+by26DaMNPHNseJK45SXzjN2mpHV2nhd5fKcEzUd
         FxuC7mCyzPTDLpcs9+NvZw/9f3yKf5aMMPfu8xZ0EooP3sadwjoKmJQIu4kflQL6CSHm
         3mmk+vdddaNM8D7JGuOalFOsbuiiNyj8JYnY6upvijkpjzOqH6D3L5M+I87kCYmwj6Qr
         PDHcRDHRBVD9EhBevRNBQXWcMgSIyBCz23/yjiEgPggheZs0hqVzZAVRSOxz++e8HEEe
         su8WM+SnpCoQWwhJnDVoUmTLsNLqMz2pBd+0Ixw/wVgwV1Dj+Mcpr39k4ZwAjv2ULZR0
         fVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8czfhSUs3mWHeIfFdLH5/G0a3Uk3RSmYGgvVFUZjxw=;
        b=erlXfSRMxM0DPlkaDFTEN2ns+OP+65A/zzXt0Oxy5MYACLnTpKxDEJ1epAw7IzdUK8
         6gtaN+FOffC/T7edfqWFXiJSJOzut+GaoXteM7YYQukRL3OWl1a0fufK3PbHsEa9VP42
         PoUyGtHjO1DYXKXSzd2g1EpBLghvVZENAgOLXz6nzHmjXtvfedxHWZs1nYYaZeG5ds7C
         mRkpa8VevzVn7bPot3MJtnfGutywxzvJ/qLdiv5USP+y/DgYJLc6ESJUiirh5V1Kls0+
         BcuiQ6H3JkvZzaa9vjxe7ATrl8RngSzWrQjJmHV/9ujNjYGYbTm1MG3oDlws+FPWZZoQ
         mX+Q==
X-Gm-Message-State: ANoB5pl13M2Ma0v+qk91PBZyUPP6sNcGIRJv73lZEvm7siZ4/xsZaY6M
        gNapYoup3Cak6WdVxsZuv+s=
X-Google-Smtp-Source: AA0mqf5598TxLDqy4tIWUpYjpY0aL3kt7HPLQgal2MvvcizUGXiBe1ztwx8Cofhygfbkrm1iEOsnCQ==
X-Received: by 2002:a5d:658b:0:b0:22e:3397:2e96 with SMTP id q11-20020a5d658b000000b0022e33972e96mr13714180wru.535.1668609345451;
        Wed, 16 Nov 2022 06:35:45 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:5da:d460:bf85:51f8:ca78:20c2])
        by smtp.googlemail.com with ESMTPSA id x11-20020a5d54cb000000b002415dd45320sm15152354wrv.112.2022.11.16.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:35:44 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 15:35:23 +0100
Message-Id: <20221116143523.2126-1-the.cheaterman@gmail.com>
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

