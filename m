Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE069C3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 02:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBTBEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 20:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBTBEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 20:04:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A42D52C;
        Sun, 19 Feb 2023 17:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ovqZtYKPJQ6/2tewzPzR4aQLjzsj+HmREsk7V7Fv1eg=; b=AW2niDUyFd6c5SQTpM3F2Y5Dpg
        XyPzZ8fu5vCzkd6PVQKw3lKwEPKHk9wvNfvCmv3LUmu7dFMaS2PJkzQEAK9MNllHuYkAdEMjp5pGs
        PjX5cKk9gSIYEaRPJbjt8CiKlTCw3+hONrdrZ+txskDBa4luXWk8vBJxWLn8eXkUnYh0Df7fFPWqR
        ms93hxgrx/JYa2gd1Eu/522kgI6XqJC6zoYSyrt1FN/+KH5Wbt0NCLUUY+hw2V6bcnXV9Ro7/VaR7
        rmCKlWUss1NhzfJ6nEr/DFMY0LaVzDf6qWUFD/ok0NhDc1xyVSnFTYOCvk0FTzU/yDc/VmJvWZ6/f
        PFQa+eAQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTubX-002eJA-2B; Mon, 20 Feb 2023 01:04:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH v2] drm/msm: DEVFREQ_GOV_SIMPLE_ONDEMAND is no longer needed
Date:   Sun, 19 Feb 2023 17:04:28 -0800
Message-Id: <20230220010428.16910-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM_MSM no longer needs DEVFREQ_GOV_SIMPLE_ONDEMAND (since dbd7a2a941b8
in linux-next: PM / devfreq: Fix build issues with devfreq disabled),
so remove that select from the DRM_MSM Kconfig file.

Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
---
v2: since <linux/devfreq.h> has been patched, this select is no longer
    needed (Rob Clark)

 drivers/gpu/drm/msm/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -23,7 +23,6 @@ config DRM_MSM
 	select SHMEM
 	select TMPFS
 	select QCOM_SCM
-	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select WANT_DEV_COREDUMP
 	select SND_SOC_HDMI_CODEC if SND_SOC
 	select SYNC_FILE
