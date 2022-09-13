Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91245B6A19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiIMI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIMI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5585B074;
        Tue, 13 Sep 2022 01:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D53C761363;
        Tue, 13 Sep 2022 08:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB048C4315A;
        Tue, 13 Sep 2022 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663059500;
        bh=hrVvbXZI3Rtg13D3GQsc7u6t7rwPKk9Y9RWbu9u6KlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unmVFMd/dGOGh2PApm3PDyWQrBxL1xdvk35PijR18DwwcNW4H727qG6HywOtia2G2
         an8mZSsqIbYsjx7668w2wSRihZ+TOZk0wbnLpgVhA84QJsUt7Mf9OazIDIHQbvx8RA
         VGO+U0ddf3DHcr4r+i3jQv7zqXaXJOO5Huf2SFMYYixc586UzpcYleH6GsMFkAz32Z
         HDaH19Ek5MYXTqDLSUnLW4drfC15K1hC/dInzytrumqJumgk4zEXx/Dgn7N3eHacrJ
         Z8phApq3E6e67RMzA9Z9XfUf+fLj6acdta1bs96nRDXe2EgtZF3uX517FevoEzerlI
         fNnsMqDjz2NSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oY1kJ-0002HO-5t; Tue, 13 Sep 2022 10:58:19 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 10/10] drm/msm/dsi: drop modeset sanity checks
Date:   Tue, 13 Sep 2022 10:53:20 +0200
Message-Id: <20220913085320.8577-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913085320.8577-1-johan+linaro@kernel.org>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

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

