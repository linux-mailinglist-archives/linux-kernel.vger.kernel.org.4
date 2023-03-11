Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D769E6B61F8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCKXKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:10:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37CB4DE3C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 15:10:26 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y12so894709ilq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678576226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cpvYmVBhD4fHRIrTGT44scJM9mOEe4nde0KEivzpRU=;
        b=b0DGG+OiczaXdjYEhNUmMwjVPqFwNqfWT2CWfDR8tRxIe5tHVvuLxy6/DeGkZTdWYa
         QYaA8RbvXZzZDSq2GKecdW9xBKTa+yDmzyK+zuVYYYfRYxsrKDfpUsUzg5t4Fl4qrkj8
         z9uPrtiurvxE60GSlV4qCRVxIodf/NpJ9bC+FOjNMxYKp7ablkd7CQKiAaQHn0tqJ0T6
         ySfpg7FxTx9UaXiUyQHt8OZNOvcyATtYH6R/fWwWt5k+kEBn5ot1z6SzosM6L9rJ4iPY
         pAQ1rPSOj84VcRzI8F1dCfv2yB0NDdfi2BaLEU1O7U6hDcx9ZOkaIqaO3lAunTcnl8qH
         y+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678576226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cpvYmVBhD4fHRIrTGT44scJM9mOEe4nde0KEivzpRU=;
        b=ysCzfwU4sSWTAIW1EgIWYcMjEMWqYRFmhsTGuFeTiWQ9IcLETTbyis+eHAw9McUwIe
         xhJs5GVydoYlQkf7hNVyuFMv+a85Mqr89i3IWBS0TYfJ47xE29ILecs9fp9GGj/vLkdM
         xd4f52VYHSVUaGY2iPRd2TM4NCjPcawttI3DQJLyS17RmwZYQHCYOZs4I1A01BZniB+S
         u6nDXKMTiA7hmjXsYEvcaY45qRFZe9a9uBIC2A623IWPUI/pQUaG7e4IDtTFePaPI8+N
         iS1ZpjsCTdHPAND8e5aEWpYqbYSAroQU7Hn16bd9pxuefzRazF9fTZOECFa7rfHF8zJR
         i9SA==
X-Gm-Message-State: AO0yUKVOd4taDH/hzaRePp3XsxhkQ6gSk8651mP5uOrqcfeGUaOeBE1H
        FLQX306eOZN/L9hcZ4OzwAY=
X-Google-Smtp-Source: AK7set8xLaf6sGCvFzp9Oq9/f/JMIaxPKVY87Tn55B/7J2yLpejE7qv7ohOneDZo8+6MZwjoiq29wQ==
X-Received: by 2002:a05:6e02:1522:b0:317:9945:6054 with SMTP id i2-20020a056e02152200b0031799456054mr23500135ilu.9.1678576226071;
        Sat, 11 Mar 2023 15:10:26 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:3d1b:3fae:4f25:ccd])
        by smtp.gmail.com with ESMTPSA id y11-20020a02bb0b000000b003fddcf34e0csm679190jan.117.2023.03.11.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 15:10:25 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, Adam Ford <aford173@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535
Date:   Sat, 11 Mar 2023 17:10:07 -0600
Message-Id: <20230311231007.46174-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dynamically switching lanes was removed, the intent of the code
was to check to make sure that higher speed items used 4 lanes, but
it had the unintended consequence of removing the slower speeds for
4-lane users.

This attempts to remedy this by doing a check to see that the
max frequency doesn't exceed the chip limit, and a second
check to make sure that the max bit-rate doesn't exceed the
number of lanes * max bit rate / lane.

Fixes: 9a0cdcd6649b ("drm/bridge: adv7533: remove dynamic lane switching from adv7533 bridge")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index fdfeadcefe80..10a112d36945 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -103,13 +103,9 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
 enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
 					const struct drm_display_mode *mode)
 {
-	int lanes;
+	unsigned long max_lane_freq;
 	struct mipi_dsi_device *dsi = adv->dsi;
-
-	if (mode->clock > 80000)
-		lanes = 4;
-	else
-		lanes = 3;
+	u8 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 
 	/*
 	 * TODO: add support for dynamic switching of lanes
@@ -117,8 +113,16 @@ enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
 	 * out the modes which shall need different number of lanes
 	 * than what was configured in the device tree.
 	 */
-	if (lanes != dsi->lanes)
-		return MODE_BAD;
+
+	/* Check max clock for either 7533 or 7535 */
+	if (mode->clock > (adv->type == ADV7533 ? 80000 : 148500))
+		return MODE_CLOCK_HIGH;
+
+	/* Check max clock for each lane */
+	max_lane_freq = (adv->type == ADV7533 ? 800000 : 891000);
+
+	if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
+		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
-- 
2.37.2

