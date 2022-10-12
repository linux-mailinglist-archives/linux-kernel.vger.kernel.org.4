Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1625FC94F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJLQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJLQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:29:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D49FBCDF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:29:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so15974995pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn1tYSp6Fs26zz8mdx6XxYmQlY8g3zLtpMK7g8RZT1U=;
        b=Fs4gWIc/2+USWqzntDJRD8yynnsb+1iJJm80wz2TexKT+yj1/30tVTpzfqpdS8pCvH
         HS4tBX00esP9gFzO0IfU6EgXKKLTonR/DMOrz79rWkAnGGazztmHzy3D0Pp9NhYjlbjx
         8bPjoHnzoGMcOrDGW71iHil+DqNvPV6tnom7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn1tYSp6Fs26zz8mdx6XxYmQlY8g3zLtpMK7g8RZT1U=;
        b=pl67gVhL4yhBI2LXUJvC20SYIYjNJQwsXzn0Gul7srA/XIEopaqGHZLAFbQW64JfuI
         QNVclPPTcihtvSNz7pYLmZqHLCuojorTGGDqiHkKRkPIPAHGTQRE+oco5coh74E7ks3l
         e/nuPnfeIyg0W0ySl1Pl7OT5PGCX2iMv8CTMQR/Hiw6TLcXRFMeC2JmGHLfjgFs48UJR
         Q/CLnLA7vghXCr/yo2rZAbrbI0r6Uba51C5A+FFMKzl5g57Apo0XOu4LuEBda+SSF1Fh
         xiNkGPUb4xj9EObGHnmHQQ6R+eiQ5wB7qaClQZOa/YJ9ewEj0U09BomaMnzH4oSKnkt7
         34GQ==
X-Gm-Message-State: ACrzQf3cstGm5B+MPc6V6kLhbb0+FMOQ0MiFcY9chwQvKUlZUf3EINms
        Gy+M+4D+7fXNf7lEH/Is36izrg==
X-Google-Smtp-Source: AMsMyM6HxJ+lgT8f8WrnaKCblNjlb/TUbZ2wY3dcWmlOhT8Hmm5Z6eImkf02dCMv+Hli0GCNG87qgA==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr31258809pfu.28.1665592150442;
        Wed, 12 Oct 2022 09:29:10 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:2921:f6a9:5848:18e1])
        by smtp.gmail.com with ESMTPSA id l4-20020a635704000000b0045dc85c4a5fsm9722163pgb.44.2022.10.12.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:29:09 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe
Date:   Thu, 13 Oct 2022 00:28:57 +0800
Message-Id: <20221012162900.2876686-2-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221012162900.2876686-1-treapking@chromium.org>
References: <20221012162900.2876686-1-treapking@chromium.org>
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

During device boot, the HPD interrupt could be triggered before the DRM
subsystem registers it6505 as a DRM bridge. In such cases, the driver
tries to access AUX channel and causes NULL pointer dereference.
Initializing the AUX channel earlier to prevent such error.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/ite-it6505.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index a4302492cf8d..f7f6c3e20fae 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2871,10 +2871,7 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
 	}
 
 	/* Register aux channel */
-	it6505->aux.name = "DP-AUX";
-	it6505->aux.dev = dev;
 	it6505->aux.drm_dev = bridge->dev;
-	it6505->aux.transfer = it6505_aux_transfer;
 
 	ret = drm_dp_aux_register(&it6505->aux);
 
@@ -3354,6 +3351,11 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	debugfs_init(it6505);
 	pm_runtime_enable(dev);
 
+	it6505->aux.name = "DP-AUX";
+	it6505->aux.dev = dev;
+	it6505->aux.transfer = it6505_aux_transfer;
+	drm_dp_aux_init(&it6505->aux);
+
 	it6505->bridge.funcs = &it6505_bridge_funcs;
 	it6505->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 	it6505->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
-- 
2.38.0.rc1.362.ged0d419d3c-goog

