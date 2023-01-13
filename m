Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906766A744
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjAMX4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjAMX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:56:35 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A417E2DE7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:56:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i65so13829679pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+evsYAc3b1lQ5lkyPBOLTAudAqBRHFoDkoyn9gzcWU=;
        b=bglNrXXzl+zfB88DcX28XESqwrqWNa2PfHlGEAegGmswKUvIEGuclPlzAGHJAX4jCa
         JS45SdnMg4dw/bRTbacQImuLolP2g4t6Xy/VSB3Vr6FXhf/nsHLl/zrsvI+YI1cS/bWg
         79LDXePloaL1xmygJa8gaMTVJUaxRy4BV/MC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+evsYAc3b1lQ5lkyPBOLTAudAqBRHFoDkoyn9gzcWU=;
        b=OIBBX/hc10qy+0iBRlB+lydTiB1ywtSGR/O255PykXEfm5vl2EvmdRj/hKCAhQEYgq
         TqcB8xtC7nmntBbRbzsQ5eJ+QUMimD0o9/Nrcj75NbUYLeNOJ+6+wbmQB67fXSE9nY+S
         kdSFGDhdYZW2Qh5DlrdGKnAek9CddgxoBbWgysM/roE2EVE6rTLzWgHuriidSpO+bq9X
         yLbblmXdnnsBPsppjZUybEhP/XHtYNoxOB6Nb801sCCvd2hNTI8NTOMh14FX+qEr4cLe
         MQ4lfspYI+iF0aDGE5MMdoUkpctp9apY541EAds8ri20tq9Q8Sceo3oRBDQqgKNW0MDf
         Ot8A==
X-Gm-Message-State: AFqh2kqRpJ+CYirP/SEW7W1QWL71ww/SAVKfHWpDZlCD5qq/bDS2Glxv
        Plax78+0UcUk9dB2t3VvgZ20oQ==
X-Google-Smtp-Source: AMrXdXsl5dwvIc5BLm75HVq3ofqQwGV0J7iamu0uFTfbZwquAyj1MTYTinzmzaIutoOWtOvYzd3dTg==
X-Received: by 2002:a62:2746:0:b0:58b:af27:dcda with SMTP id n67-20020a622746000000b0058baf27dcdamr5847832pfn.14.1673654194182;
        Fri, 13 Jan 2023 15:56:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b4ad:3c49:1195:a01e])
        by smtp.gmail.com with ESMTPSA id f10-20020aa79d8a000000b005823b7da05asm10002737pfq.122.2023.01.13.15.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:56:33 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH 1/2] drm/bridge: tc358762: Set pre_enable_prev_first
Date:   Fri, 13 Jan 2023 15:56:03 -0800
Message-Id: <20230113155547.RFT.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the "pre_enable_prev_first" as provided by commit 4fb912e5e190
("drm/bridge: Introduce pre_enable_prev_first to alter bridge init
order"). This should allow us to revert commit ec7981e6c614
("drm/msm/dsi: don't powerup at modeset time for parade-ps8640") and
commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
time").

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/tc358762.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 0b6a28436885..77f7f7f54757 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -229,6 +229,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->bridge.funcs = &tc358762_bridge_funcs;
 	ctx->bridge.type = DRM_MODE_CONNECTOR_DPI;
 	ctx->bridge.of_node = dev->of_node;
+	ctx->bridge.pre_enable_prev_first = true;
 
 	drm_bridge_add(&ctx->bridge);
 
-- 
2.39.0.314.g84b9a713c41-goog

