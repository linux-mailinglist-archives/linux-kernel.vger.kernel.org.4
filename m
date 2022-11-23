Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7283635980
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiKWKSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiKWKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:17:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA312EBD7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:05:40 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v3so16360424pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UErsT04ZyvPQZD/GWA3SjRANjv/mY45ZrGViPWOUsZw=;
        b=YQq1OWP/rreUbf1JZWHTsvWDnRHZ6KDDSG+laL8s//K8YlvbE0jQAQGaPqUVd5uZ5X
         GxuAkR4sMWfwTX7XUtuQ92Pcgzw8Y568clN2ihAvwMYHUdzCDxRqQNHrF6EDm2pcadEa
         pbJhY8JmZrX52GI+i4lNgbrQ7ndJmKw0OQ4Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UErsT04ZyvPQZD/GWA3SjRANjv/mY45ZrGViPWOUsZw=;
        b=FEh5yO/7fPuFAmfsy8exbso+TvCjgNqMi7LFfyBAlUcZIwbv+6p2v08Tz2IYG/Q9mi
         IDGF/gXfQsuLRgHJTOLs75tKVLBzvYAWXe+8qMcKrpqTfGORYqeKGquylv/3J+Bz6Ugk
         kF2iPRlUiccHOxG5r5zpOTK/fKmGxgore344SPyZgJCrPPQ4M1C+5VGlpjo5vdg34TMZ
         SFFInMpV6TldnO1SXpNkxGgti7FdHVYUcvvEqpBy4YzHwNAj3gDwRA5wjt7R9qyOUKft
         b84sfyzgGawZddvZOzlsP7EMDvSaPXzn5/TcSbGTOtdhjGPqSoZOI2EnDDFPEJDQxxpf
         4eug==
X-Gm-Message-State: ANoB5plFejcdsgUoE9HMNNcz7cBb+JMb+LwAjHsvasdMOrKSWx996EHZ
        2CcdbQiIqYQJOMQX9bkhUcke2Q==
X-Google-Smtp-Source: AA0mqf4iGLyvjqwcvqsDaTaBWJ5NMnuRcCiESpIdGRGtMm/3xkawyZ5j9M5XKfTjRoZez7bimdIEsg==
X-Received: by 2002:a63:195:0:b0:442:c653:677d with SMTP id 143-20020a630195000000b00442c653677dmr25713206pgb.43.1669197939853;
        Wed, 23 Nov 2022 02:05:39 -0800 (PST)
Received: from hsinyi.c.googlers.com.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id y129-20020a626487000000b005745a586badsm1020138pfb.218.2022.11.23.02.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:05:39 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v7 2/3] drm/bridge: anx7625: register content protect property
Date:   Wed, 23 Nov 2022 10:05:28 +0000
Message-Id: <20221123100529.3943662-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123100529.3943662-1-hsinyi@chromium.org>
References: <20221123100529.3943662-1-hsinyi@chromium.org>
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

Set support_hdcp so the connector can register content protect proterty
when it's initializing.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v6->v7: no change
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0ff1ecb80a5..0636ac59c739 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2680,6 +2680,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->bridge.type = platform->pdata.panel_bridge ?
 				    DRM_MODE_CONNECTOR_eDP :
 				    DRM_MODE_CONNECTOR_DisplayPort;
+	platform->bridge.support_hdcp = true;
 
 	drm_bridge_add(&platform->bridge);
 
-- 
2.38.1.584.g0f3c55d4c2-goog

