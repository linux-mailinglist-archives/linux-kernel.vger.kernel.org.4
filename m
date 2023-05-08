Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1E6FA914
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjEHKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjEHKqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:46:52 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889112A9EE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:46:43 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7886200C78;
        Mon,  8 May 2023 12:46:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF78520096F;
        Mon,  8 May 2023 12:46:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2789518002DC;
        Mon,  8 May 2023 18:46:40 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_micfil: Fix error handler with pm_runtime_enable
Date:   Mon,  8 May 2023 18:16:36 +0800
Message-Id: <1683540996-6136-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is error message when defer probe happens:

fsl-micfil-dai 30ca0000.micfil: Unbalanced pm_runtime_enable!

Fix the error handler with pm_runtime_enable and add
fsl_micfil_remove() for pm_runtime_disable.

Fixes: 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 94341e4352b3..3f08082a55be 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -1159,7 +1159,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to pcm register\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	fsl_micfil_dai.capture.formats = micfil->soc->formats;
@@ -1169,9 +1169,20 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register component %s\n",
 			fsl_micfil_component.name);
+		goto err_pm_disable;
 	}
 
 	return ret;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static void fsl_micfil_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused fsl_micfil_runtime_suspend(struct device *dev)
@@ -1232,6 +1243,7 @@ static const struct dev_pm_ops fsl_micfil_pm_ops = {
 
 static struct platform_driver fsl_micfil_driver = {
 	.probe = fsl_micfil_probe,
+	.remove_new = fsl_micfil_remove,
 	.driver = {
 		.name = "fsl-micfil-dai",
 		.pm = &fsl_micfil_pm_ops,
-- 
2.34.1

