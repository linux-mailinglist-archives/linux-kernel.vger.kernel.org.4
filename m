Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBA5B5D84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiILPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiILPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C1F2BB0A;
        Mon, 12 Sep 2022 08:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41DBE61259;
        Mon, 12 Sep 2022 15:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E629C43144;
        Mon, 12 Sep 2022 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662997286;
        bh=NvUPn637z6uLalY0boDdcXrcj/rg6GMPWSoihJhuhnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuhz9DELmb+VMsNghrKvvabDT47SnHzyP7fPgGTEhXDCzH5DLcOFeJhEH8HL7aCPD
         MoqfnPuxjhHHpNtIXi4RQSa59WG3G+ffR3BQomxaGU6d4mKJPe4LJU5k8XWFypnvWD
         GpZppgjBhdNtvaHDLN3+PnIpI9KC6JY5h2OxAvEqtKB9phidytPw46H+/umJ7qHhyH
         wu+V0Hm4uSLaybeSB5njmUozFZ6ZcFaMG7vS6O6unarZzzHALWBCLQPWHWpN4Iy3rF
         HfZyfk6SxatSKX3N28/SQP4gQAwD9DEW0McrXXJ5WkBzZaXr16R2glvWG4nJj8iiLH
         uc2nEPXAGhWyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oXlYp-0003N0-Ni; Mon, 12 Sep 2022 17:41:23 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 7/7] drm/msm: drop modeset sanity checks
Date:   Mon, 12 Sep 2022 17:40:46 +0200
Message-Id: <20220912154046.12900-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220912154046.12900-1-johan+linaro@kernel.org>
References: <20220912154046.12900-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the overly defensive modeset sanity checks of function parameters
which have already been checked or used by the callers.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +------
 drivers/gpu/drm/msm/dsi/dsi.c       | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 393af1ea9ed8..8ad28bf81abe 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1597,15 +1597,10 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 			struct drm_encoder *encoder)
 {
-	struct msm_drm_private *priv;
+	struct msm_drm_private *priv = dev->dev_private;
 	struct dp_display_private *dp_priv;
 	int ret;
 
-	if (WARN_ON(!encoder) || WARN_ON(!dp_display) || WARN_ON(!dev))
-		return -EINVAL;
-
-	priv = dev->dev_private;
-
 	if (priv->num_bridges == ARRAY_SIZE(priv->bridges)) {
 		DRM_DEV_ERROR(dev->dev, "too many bridges\n");
 		return -ENOSPC;
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 8a95c744972a..31fdee2052be 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -211,14 +211,9 @@ void __exit msm_dsi_unregister(void)
 int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 			 struct drm_encoder *encoder)
 {
-	struct msm_drm_private *priv;
+	struct msm_drm_private *priv = dev->dev_private;
 	int ret;
 
-	if (WARN_ON(!encoder) || WARN_ON(!msm_dsi) || WARN_ON(!dev))
-		return -EINVAL;
-
-	priv = dev->dev_private;
-
 	if (priv->num_bridges == ARRAY_SIZE(priv->bridges)) {
 		DRM_DEV_ERROR(dev->dev, "too many bridges\n");
 		return -ENOSPC;
-- 
2.35.1

