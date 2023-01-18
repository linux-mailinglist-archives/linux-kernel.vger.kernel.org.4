Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6A667225C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjARQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjARQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:00:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63A4DE1A;
        Wed, 18 Jan 2023 07:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C8A617BC;
        Wed, 18 Jan 2023 15:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB98CC433EF;
        Wed, 18 Jan 2023 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674057510;
        bh=pEEVf/Jora3k9fJs7MkNDz8h6qM3plpE8adDbzqBFOc=;
        h=From:To:Cc:Subject:Date:From;
        b=oarDxp9l6MGmeqdtPPlPcdcbct7dpxUxhM4ZbO0nB/h5L1I/bWMWT+F4COW6gdFuG
         ka9uVRj0MBzO/PovATGhagFvnLVoGhVt9G3I1LO1xyY9kfG5IqOrjAJZP7Zl/qgYlv
         6L0hvziRSN4jmqOJDOFRRFpiKNndCh0ggr0dntwoM1JG7GRQUGNE5FJo0JLoRvjF0y
         NKPqAvqHFVaXZHU1ccf/FYF52DgvTbWPikkg3D8T0KkzILemeh+co8C+tjw+5RkntU
         0Qz8dKIMvdmpTHejRPydgnFn/g8+EZJ+cBDARMBwAPLowgmKyFS4N4ocHLdjGyh8sz
         qMSJkca+YFgqg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/gpu: Add proper DEVFREQ_GOV_SIMPLE_ONDEMAND dependency
Date:   Wed, 18 Jan 2023 16:58:05 +0100
Message-Id: <20230118155825.4071424-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

DRM_MSM can no longer be built when devfreq is disabled:

WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDEMAND
  Depends on [n]: PM_DEVFREQ [=n]
  Selected by [y]:
  - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM [=n] || SOC_IMX5 [=n] || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=n] || QCOM_LLCC [=n]=n) && (QCOM_COMMAND_DB [=y] || QCOM_COMMAND_DB [=y]=n)

In file included from drivers/gpu/drm/msm/msm_gpu.h:18,
                 from drivers/gpu/drm/msm/adreno/adreno_gpu.h:15,
                 from drivers/gpu/drm/msm/adreno/adreno_device.c:9:
drivers/gpu/drm/msm/msm_drv.h:238:45: error: field 'gpu_devfreq_config' has incomplete type
  238 |         struct devfreq_simple_ondemand_data gpu_devfreq_config;
      |                                             ^~~~~~~~~~~~~~~~~~

Device drivers should never select user-visible options, especially
in other subsystems. This one can simply be expressed as a Kconfig
'depends on' statement, though a better approach would be to
let the driver keep working even without devfreq.

Note that the same symbol selects a bunch of other drivers that
should probably be turned into 'depends on' as well, but doing so
has the potential to introduce regressions, so I'm not touching
that here.

Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 871870ddf7ec..7f6f5202648a 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -9,6 +9,7 @@ config DRM_MSM
 	depends on QCOM_OCMEM || QCOM_OCMEM=n
 	depends on QCOM_LLCC || QCOM_LLCC=n
 	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
+	depends on DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select IOMMU_IO_PGTABLE
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
@@ -23,7 +24,6 @@ config DRM_MSM
 	select SHMEM
 	select TMPFS
 	select QCOM_SCM
-	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select WANT_DEV_COREDUMP
 	select SND_SOC_HDMI_CODEC if SND_SOC
 	select SYNC_FILE
-- 
2.39.0

