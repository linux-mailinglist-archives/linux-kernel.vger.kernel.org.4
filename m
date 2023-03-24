Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FB6C7669
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCXD7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXD7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:59:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AA166CB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:59:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o2so751885plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679630356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/x6xUHvTwRFsgTrEXeg3pX13bSDLxkZywP1Xe73le4=;
        b=iyt5GhYfKzDwjTCCM2vwOrvEZrKVVwF1OOD9H302ql6dH6poTrgoPMp8ygoN2Bhicn
         r1l6jrTA8nJIqDGo0frRFR7LsNrYuw8H+U68OZEl2Fd7mwqeklVWVjZh+pQY366GsAgh
         Re3VHLJcpN/dxNA3DXLuyp1ZlMw2JevPwpEE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679630356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/x6xUHvTwRFsgTrEXeg3pX13bSDLxkZywP1Xe73le4=;
        b=LlVaV7QrT7TL0ir2tc4pLF7R4n5GGileo86HsRD0qjhLiZ5+bBpmHs5n4xET2yhnVD
         yz4r738jXO1CbpRRBhFza+GoXWNuF8YpuDL4csh2HPGk6uIvVihI6+2biJFv8kWlKiK7
         enETQfo6Tply9N7w1ca2gofHr3Ul3PrEpSHAGZ2BzAqTaRYOFOsF71FMZbz2dqqgD2kC
         j+amhwCFajrgLQtdTAVlG6J/PBD4oDMTSUKTY1i7GoTp88v4q+v6dbrXyoDNqrFIFT7F
         jTd24ecz1TY+Pkul4JgTNoTjOe9xN6gOyfMA9IjRWGVXy7wbbNgAjfjKaNClUe7w07JX
         GjKw==
X-Gm-Message-State: AAQBX9cJr/yKcZO4+5Fq+ypLF0/ZVR6oFkXS8L0BKMbxtp561lb8ZUsO
        nhL20iQuhMwyxt0xMh+Su6VHPw==
X-Google-Smtp-Source: AKy350YXePktJl6QG8JfXu8oz4ywLlmXo0h3VIMfdQ/+aoFk6hcK0sXWE6MT5Q7/X8C92Frhv1CMBg==
X-Received: by 2002:a17:90a:1a05:b0:23d:5485:b80e with SMTP id 5-20020a17090a1a0500b0023d5485b80emr1489596pjk.6.1679630356510;
        Thu, 23 Mar 2023 20:59:16 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:e6f6:fe75:aa75:56cc])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c21300b001a04ff0e2eesm13069249pll.58.2023.03.23.20.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 20:59:16 -0700 (PDT)
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
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/bridge: ps8640: Return NULL immediately when EDID read fail
Date:   Fri, 24 Mar 2023 11:59:09 +0800
Message-Id: <20230324035909.1727356-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_edid_read returns NULL on error, so feeding it directly into
drm_edid_duplicate may lead to NULL pointer dereference. Add a check to
guard this.

Fixes: 6a17b4d1b52f ("drm/bridge: ps8640: Add a cache for EDID")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index cddbfe91f75e..b823e55650b1 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -543,6 +543,7 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
 					   struct drm_connector *connector)
 {
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
 	bool poweroff = !ps_bridge->pre_enabled;
 
 	if (!ps_bridge->edid) {
@@ -574,6 +575,11 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
 							     connector->state->state);
 	}
 
+	if (!ps_bridge->edid) {
+		dev_err(dev, "Failed to get EDID\n");
+		return NULL;
+	}
+
 	return drm_edid_duplicate(ps_bridge->edid);
 }
 
-- 
2.40.0.348.gf938b09366-goog

