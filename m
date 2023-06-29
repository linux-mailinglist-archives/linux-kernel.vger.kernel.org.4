Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170E9741E22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF2CTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjF2CS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:18:59 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E2211D;
        Wed, 28 Jun 2023 19:18:57 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 222B4200D56;
        Thu, 29 Jun 2023 04:10:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF4AA200D42;
        Thu, 29 Jun 2023 04:10:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2919D181D0E5;
        Thu, 29 Jun 2023 10:10:38 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] ASoC: fsl_easrc: enable memory to memory function
Date:   Thu, 29 Jun 2023 09:37:53 +0800
Message-Id: <1688002673-28493-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intergrate memory to memory feature to EASRC driver.
call m2m probe(), remove(), suspend() and resume()
in different callback.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 41 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index b735b24badc2..bc5404627032 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -29,6 +29,7 @@
 #include <sound/core.h>
 
 #include "fsl_easrc.h"
+#include "fsl_asrc_m2m.h"
 #include "imx-pcm.h"
 
 #define FSL_EASRC_FORMATS       (SNDRV_PCM_FMTBIT_S16_LE | \
@@ -2190,11 +2191,21 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* probe the m2m feature */
+	ret = fsl_asrc_m2m_probe(easrc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void fsl_easrc_remove(struct platform_device *pdev)
 {
+	/* remove the m2m feature */
+	fsl_asrc_m2m_remove(pdev);
+
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -2295,12 +2306,38 @@ static __maybe_unused int fsl_easrc_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int __maybe_unused fsl_easrc_suspend(struct device *dev)
+{
+	struct fsl_asrc *easrc = dev_get_drvdata(dev);
+	int ret;
+
+	/* suspend m2m function first */
+	fsl_asrc_m2m_suspend(easrc);
+
+	ret = pm_runtime_force_suspend(dev);
+
+	return ret;
+}
+
+static int __maybe_unused fsl_easrc_resume(struct device *dev)
+{
+	struct fsl_asrc *easrc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+
+	/* resume m2m function */
+	fsl_asrc_m2m_resume(easrc);
+
+	return ret;
+}
+
 static const struct dev_pm_ops fsl_easrc_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_easrc_runtime_suspend,
 			   fsl_easrc_runtime_resume,
 			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_easrc_suspend,
+				fsl_easrc_resume)
 };
 
 static struct platform_driver fsl_easrc_driver = {
-- 
2.34.1

