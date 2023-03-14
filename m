Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3786B90D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCNLAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCNLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:00:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FA5DC80
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:00:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id fd25so9448868pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678791652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Js/tHDer/Yr5TRaIcV1cVBSaKjsn5E+7833Z9Y2Z5oc=;
        b=gInm2BDdjwVTeHhR+bNfsdsL2pH8+qdgFc7TzHVJ4615z6q0HAoAtyj5pze2EYkGTz
         1jpip1tf8MIJ7tJqh0VMGZ7Zr0N3ZwCVJ1+5nwgQapiJNp7s27Y/MRo2oYpVreB3IqiZ
         sIto1wJGlyvGFDTiMNxtX2WNThMiOKoVNitN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678791652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js/tHDer/Yr5TRaIcV1cVBSaKjsn5E+7833Z9Y2Z5oc=;
        b=2DGdVD7cN1L4nFl879ilLKfrkSQ/LesjOu7RecDnvwjCVgFJNF9En2lzcMmt7HxDHx
         8UitGkhBkN3aCnQQMQR4Vdzk/e4x1RdWTOk1gXYaZ9gutZhqcM5rYV77ygjYvbapWFC0
         1INaq/r62UCavTk7T0B/VolS7Tn3tay4u1GXLflFFnt4EAdSlTgcetGpHL5PpdxqMhAH
         ReLX9YIKT1ZCMAHuQajCJhaJVUFxeREnLvOxYI4dwtKgKXkAoSxYsao9ZKjal0my4jHw
         5Zs/xcNxWmHqiAFPbP71yLG60GseMcATOI4L3xd9pMod5QGj2X0eme9wsGTcDYTposBO
         IJTQ==
X-Gm-Message-State: AO0yUKWl5Pmd2YcqLu2LC5zFpyA12i7IdpV+uDJU+LfAf1Et1zpvRC6P
        OaXYwu/OAVcA/jfJzQW+6vbcdQ==
X-Google-Smtp-Source: AK7set+M0m+PUk7VtHcQ/wCnMA01qfJFPe6qJcSy/J388yRSRSnOkJJyxAJrjvIqfPdAK5e4t4zAEA==
X-Received: by 2002:aa7:9511:0:b0:625:4d29:7390 with SMTP id b17-20020aa79511000000b006254d297390mr3123574pfp.13.1678791652359;
        Tue, 14 Mar 2023 04:00:52 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3718:fdeb:7d7e:b6c0])
        by smtp.gmail.com with ESMTPSA id x2-20020a62fb02000000b005a909290425sm1362028pfm.172.2023.03.14.04.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:00:51 -0700 (PDT)
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
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 1/2] drm/bridge: ps8640: Skip redundant bridge enable
Date:   Tue, 14 Mar 2023 19:00:42 +0800
Message-Id: <20230314110043.2139111-1-treapking@chromium.org>
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
---

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

