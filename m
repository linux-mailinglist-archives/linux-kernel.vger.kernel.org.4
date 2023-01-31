Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004468394D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjAaWW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjAaWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:22:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6DF5AB6A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:22:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be8so16568250plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nDJfgGY2Uq4pkbdaiIQ1ONvu1Aumpm8UVU5btqep3hU=;
        b=C//XxpbCdZukvZqKglW8c6wuEVing1SDTbUUogS/ymch/qoW0vbXqPjsij+7C39bKM
         cz2v/jqa/PU4i47Iz53rPk2Vw3mNsCvZevPClswFn03twuQH9OPEeoCTzI0WxPUHRVN+
         yilQTQAnqMoG4QmPIPzwSaV9MSqokzOW+hEIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDJfgGY2Uq4pkbdaiIQ1ONvu1Aumpm8UVU5btqep3hU=;
        b=YqHSGgKpIGYB1a1CqL0lqUNXu8Re/co6T0CkTHKPUthIqvualKlznCOsac1z6FHPPd
         Qx5GK4ZGohWDKoeSGuFwmWpXBJG1bxbaYkQVccDbWKr2hUpSoepS9CC0XrTYQEW5KN13
         sTPomlXNcvm2fOKcEKaHSmshAlWv+rpula/WDYeUegUaqBuya50SE66lyueqOo0Dvokw
         udR+koaUN/WJqSnCONz5B7sTnbcJXIR455X0SOA9LuN3SaJ+HTonmOlZpOQl/FxlpWCw
         50i2PW7uEKYeSOQW+bjtULgVobYcFjXXpAWOclJhNMrB/sAfda1Wk+T2lPEauClJtvap
         Oqxw==
X-Gm-Message-State: AO0yUKXoDMGDKJ5n4lbnKEwno7Tsu3efHw7ptjthK0Xr7iciBhbJkp+a
        QSr01wMP2ZcW3WJjN4qTCbpl9A==
X-Google-Smtp-Source: AK7set9E0fDgYOMAjwM1gzKlM6zWrGLc2FbOBfwbJBwFkBrg9zJem7/LBAqKEjhYlOZ3sKIlqEM0TA==
X-Received: by 2002:a17:903:138c:b0:192:d625:ecc4 with SMTP id jx12-20020a170903138c00b00192d625ecc4mr495493plb.18.1675203738010;
        Tue, 31 Jan 2023 14:22:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:138e:73d3:502:64f])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b0019339f3368asm10377471plh.3.2023.01.31.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:22:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        Vinod Koul <vkoul@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 1/3] drm/bridge: tc358762: Set pre_enable_prev_first
Date:   Tue, 31 Jan 2023 14:18:24 -0800
Message-Id: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

(no changes since v1)

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
2.39.1.456.gfc5497dd1b-goog

