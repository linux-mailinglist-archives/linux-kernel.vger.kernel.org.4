Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B86BA5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCODzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCODzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:55:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5723A4B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:55:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so517256pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678852515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGPhTm2xXTX9SZzSC6N4Q9IoG+nmSEEb9/PORbnLy0A=;
        b=ZDG8fL713b301hTiq1x9F5hFdpR3HMZYFNXk4tKHoW2LPgzAMZ6QnQ8RtJiUaVPybh
         lbFg02/OpMcs7UKmQ56kWTTU7kdQkE7xEfnhkG8UhwsAhvuCpcPmKzsfWwbi4VvDp4s1
         Wvku0K8jYswJC3YUnrb74MhfG1/l8TdBIbrRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678852515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGPhTm2xXTX9SZzSC6N4Q9IoG+nmSEEb9/PORbnLy0A=;
        b=y7g5RKHx52xUuqxR/EDe4xIScd19LIhzFdTPpwLgTJLAE57fGxZXpcXYXWSb64lkhl
         U8DyZ57Dpe0qHIbe/FMet40Jkrv2fiHunYCnILmDOGioewcm7Bp7Z9pDdp5lxjlnNMCO
         lDCFo+AbRSAYhDly5FQmEOe0ufnJZOL3/ltd9reGHXmYdLHdUUpwJMo838Iwygx/1ceC
         /Q/0sDg7GvGbesMvv1AO5tMC9Q1NKWo9EoJP9zm2KBgcwre85kGCPn0dhDq/eOJUHt70
         vBGTZ3KxffoJnn7mkfon7Bbib/cDT5za97Q4S6gneqG8zIAa0u/MHN1Ak7ND/QWKcAkg
         w3WA==
X-Gm-Message-State: AO0yUKV6tPUDhlQ7/ub6kjKlwHULOtedCkUYbmlCid10WafesQqDX29j
        EAOw4XBOdl4LgWdhv0+XCmxpJw==
X-Google-Smtp-Source: AK7set/5N7Cl/sUaBcNmnMU62DRuK94lIT7muZs9u0wEBnJT5Q9iDNVCoIqXOPoEDS87tQvZGYECyg==
X-Received: by 2002:a17:90a:2c2:b0:23a:340d:fa53 with SMTP id d2-20020a17090a02c200b0023a340dfa53mr41651640pjd.44.1678852515602;
        Tue, 14 Mar 2023 20:55:15 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3a77:bf68:24f0:1c75])
        by smtp.gmail.com with ESMTPSA id z31-20020a17090a6d2200b001fde655225fsm3208372pjj.2.2023.03.14.20.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:55:15 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 1/2] drm/bridge: ps8640: Skip redundant bridge enable
Date:   Wed, 15 Mar 2023 11:55:07 +0800
Message-Id: <20230315035508.2874915-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the drm_bridge_chain_pre_enable call when the bridge is already
pre_enabled. This make pre_enable and post_disable (thus
pm_runtime_get/put) symmetric.

Fixes: 46f206304db0 ("drm/bridge: ps8640: Rework power state handling")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 4b361d7d5e44..08de501c436e 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -557,7 +557,8 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
 	 * EDID, for this chip, we need to do a full poweron, otherwise it will
 	 * fail.
 	 */
-	drm_atomic_bridge_chain_pre_enable(bridge, connector->state->state);
+	if (poweroff)
+		drm_atomic_bridge_chain_pre_enable(bridge, connector->state->state);
 
 	edid = drm_get_edid(connector,
 			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
-- 
2.40.0.rc1.284.g88254d51c5-goog

