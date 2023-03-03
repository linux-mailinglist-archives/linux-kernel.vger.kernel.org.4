Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827EA6A9C28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCCQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCCQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:48:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0D18B28;
        Fri,  3 Mar 2023 08:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82328B81991;
        Fri,  3 Mar 2023 16:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFE8C4339B;
        Fri,  3 Mar 2023 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677862103;
        bh=ghKAflDi6cHXV/m9c7aUUTchyJQbN3Zs5gEFagIodNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjNFRHUrfVzfTQN1hPMNIZMRPuA5MZpFQoOZTBb7kUjzBtw9js5rHCjRDugStH763
         F3mFBOBxY28EDv5le2uu9eb5Hidfcm/Fo8VxaHVJwXPckoLbHaBsok93vN7hD8Xx5H
         +bweBD6ed8q38NO/5VXPYTyIGF3s52CLEuX+2pZ3c1gF8pHz19VR116xsUlS9aYvdT
         MimxJEfUdJP/WsXE49pULvCVr7c0YSE1CW7Wu6bcsSC7X5pVOsdHYYsow6Rf5MpK+D
         phApojlZDsoRBV/6dQLYRjWFW+1i/ccGz7Syyxa0iUaTZw1sSlTXMuVadlefjLBsIk
         8laaT/inWojBA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pY8aV-0003Qg-Jx; Fri, 03 Mar 2023 17:48:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 3/4] drm/msm/adreno: drop bogus pm_runtime_set_active()
Date:   Fri,  3 Mar 2023 17:48:06 +0100
Message-Id: <20230303164807.13124-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303164807.13124-1-johan+linaro@kernel.org>
References: <20230303164807.13124-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime PM status can only be updated while runtime PM is disabled.

Drop the bogus pm_runtime_set_active() call that was made after enabling
runtime PM and which (incidentally but correctly) left the runtime PM
status set to 'suspended'.

Fixes: 2c087a336676 ("drm/msm/adreno: Load the firmware before bringing up the hardware")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f9a0b11c2e43..d9100e3870bc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -438,9 +438,6 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	 */
 	pm_runtime_enable(&pdev->dev);
 
-	/* Make sure pm runtime is active and reset any previous errors */
-	pm_runtime_set_active(&pdev->dev);
-
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(&pdev->dev);
-- 
2.39.2

