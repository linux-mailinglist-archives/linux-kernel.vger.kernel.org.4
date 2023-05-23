Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E970E03D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjEWPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbjEWPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522A189;
        Tue, 23 May 2023 08:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07406623F1;
        Tue, 23 May 2023 15:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6381BC433D2;
        Tue, 23 May 2023 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684855061;
        bh=D2TI28zRqMeP33qD4AGJWV2hUnE/pn90ek046LImn8g=;
        h=From:To:Cc:Subject:Date:From;
        b=aCoBt0h0f7NnX7GHkpKHx5gX/kOf9gAf60zsdhyzmiEFf+xCbWPbmRlqVY2L+G3uB
         qHsIFCdiq1Vo2YL79EGMRddXfA7JRKvA2aXHN0efIAUqdMgUpU70iS9t8yoNaPh4KZ
         DyrY+bUPUsYjBE6py0YTCxEurL/YMVOizJBEywAwYU5NHi4oUJaHRd+XeYfAgLuyZM
         0z0XPl9Zw2kcaFZWuqLwG09mIZVspbZef7/Yz3A5M7mw6llm7VBYZ3skX6OCps4Jpx
         zj9Lh+ZaiZVKPIBANRvV69ER6euCgEo++kYy6qqBNCFycbhItcIyZKJY30Y9NKIhgv
         Dsmk9u8YB0CZw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q1Tlg-0007O5-3D; Tue, 23 May 2023 17:17:44 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Subject: [PATCH] Revert "drm/msm/dp: set self refresh aware based on PSR support"
Date:   Tue, 23 May 2023 17:16:46 +0200
Message-Id: <20230523151646.28366-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1844e680d56bb0c4e0489138f2b7ba2dc1c988e3.

PSR support clearly is not ready for mainline and specifically breaks
virtual terminals which are no longer updated when PSR is enabled (e.g.
no keyboard input is echoed, no cursor blink).

Disable PSR support for now by reverting commit 1844e680d56b
("drm/msm/dp: set self refresh aware based on PSR support").

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Bjorn reported that PSR support broke virtual terminals two months ago, 
but this is still broken in 6.4-rc3:

	https://lore.kernel.org/lkml/20230326162723.3lo6pnsfdwzsvbhj@ripper/

despite the following series that claimed to address this:

	https://lore.kernel.org/lkml/1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com

Let's revert until this has been fixed properly.

Johan


 drivers/gpu/drm/msm/dp/dp_drm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 785d76639497..029e08c5bb06 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -117,8 +117,6 @@ static int edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 	if (WARN_ON(!conn_state))
 		return -ENODEV;
 
-	conn_state->self_refresh_aware = dp->psr_supported;
-
 	if (!conn_state->crtc || !crtc_state)
 		return 0;
 
-- 
2.39.3

