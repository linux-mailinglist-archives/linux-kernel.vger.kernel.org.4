Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D228E627707
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiKNIEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiKNIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:04:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7176D766F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:04:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b11so9654605pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJDRhD+by6ePLMyu0jFNF0DA5otbXQzM82G9QXM16+g=;
        b=iNyUdIcLjrR/mqWwLs/KmivHxLDyDcgVMh73gXOXYAq/IkDPCGsH/9skjnoPBo8gG6
         dVsG+Nyz//OyLV9sBaU+LDku2PU2tznUw3oQfZcEDdJTg3TXSasC9ANQUJ8O9rAfDnu3
         HYFZQvEswdMHQT0j1ewSY0yDMwKNsygZtxCdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJDRhD+by6ePLMyu0jFNF0DA5otbXQzM82G9QXM16+g=;
        b=MUa5SEa+5LKlRaOMwJ3dVfWuA0jh2yzQlcP+dO5rnJcJTIPcX7vPQcU715SDgj3/TE
         vdhQdM1nLXRKcsF1Z0Qz6SiL0yXZQfKgXqSPNkTPE+VP1ujqTeeVijwWbXZ2FUsoKkzq
         2wiTj/bsGnEQstbdyDljSI9ln3n1f+2YqYDXuAMDkYleLWPNooVPG/3jzaywOJOOtO2p
         uPpy1AHbJ26GYd/UIlMLzkMscv/eFPfpsNLfTO1oSCfYY71TUaQ2JX/y3K86tFKbc6uu
         KIU/MQkzk+d3eKpqAh0jidoyxgN/sQ+80GmZr193rNWDvFidMFai5CMMop/ZMkpZEkLd
         kikQ==
X-Gm-Message-State: ANoB5plJRnfCbpvJPXb/MmnopnFhZA47jx8DWtsEdeRpXVZQFyawNKUq
        RT6lS4g13FdyfRxq4a+yklzI9g==
X-Google-Smtp-Source: AA0mqf688Sv1eNxrH8zO0KEumgyIdk7+CrlCUx/YBZCPZDBo0HdDgxOmFWwMZNEwJYoy+Gal0QQx/Q==
X-Received: by 2002:a17:90a:f18f:b0:218:8f4:bad5 with SMTP id bv15-20020a17090af18f00b0021808f4bad5mr12851400pjb.55.1668413075989;
        Mon, 14 Nov 2022 00:04:35 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40f1:682:170b:f25a])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b00186fb8f931asm6696799plf.206.2022.11.14.00.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:04:35 -0800 (PST)
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
Subject: [PATCH v4 2/3] drm/bridge: anx7625: register content protect property
Date:   Mon, 14 Nov 2022 16:04:06 +0800
Message-Id: <20221114080405.2426999-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221114080405.2426999-1-hsinyi@chromium.org>
References: <20221114080405.2426999-1-hsinyi@chromium.org>
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
v3->v4: no change.
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
2.38.1.431.g37b22c650d-goog

