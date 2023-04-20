Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AC6E9DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjDTVgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDTVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883F30D2;
        Thu, 20 Apr 2023 14:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4CA464C19;
        Thu, 20 Apr 2023 21:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B2BC433D2;
        Thu, 20 Apr 2023 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682026577;
        bh=N4kO0Ct/LnSLCi9T11XBZTUArgxHgmHTQU2AiDujI3o=;
        h=From:To:Cc:Subject:Date:From;
        b=OWspLkkmDbLi4PsR/Dq2qnHLUx/tAWfx2lQH1hjad2NuBrOmm4jEe42bR3Wkn4yAH
         BygNnJjNdNPaHCAI0k94PE7RTWBk51F4r6/w9dHyL8xSlisABkbBqRjHx15Zz06Rxk
         VA87KAdEenumsUT3r2NhZQ74OgcWzT2kUzapy0XB3WLCHMENFIdga15OCS1nSA0gIJ
         uJAhWD8R/e9L2XJzZMz0uf0hpN0ymnMPQ2Di3/Yn8Wln8zUpbcixQPsuxCHDm7XYh/
         par1g0B7aoCZrH/KxWy93rgcnxN29UWfyvEZdBqjs9hiDzqx5AcnBgau3rBfZ1vlZl
         h0Yxemfd2B0DQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: imx_dsp_rproc: use modern pm_ops
Date:   Thu, 20 Apr 2023 23:36:04 +0200
Message-Id: <20230420213610.2219080-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_PM, the driver warns about unused functions:

drivers/remoteproc/imx_dsp_rproc.c:1210:12: error: 'imx_dsp_runtime_suspend' defined but not used [-Werror=unused-function]
 1210 | static int imx_dsp_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
drivers/remoteproc/imx_dsp_rproc.c:1178:12: error: 'imx_dsp_runtime_resume' defined but not used [-Werror=unused-function]
 1178 | static int imx_dsp_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~

Change the old SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS()
helpers to their modern replacements that avoid the warning,
and remove the now unnecessary __maybe_unused annotations
on the other PM helper functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/imx_dsp_rproc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index cab06dbf37fb..2d75dea43f20 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -1243,7 +1243,7 @@ static void imx_dsp_load_firmware(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
-static __maybe_unused int imx_dsp_suspend(struct device *dev)
+static int imx_dsp_suspend(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct imx_dsp_rproc *priv = rproc->priv;
@@ -1278,7 +1278,7 @@ static __maybe_unused int imx_dsp_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static __maybe_unused int imx_dsp_resume(struct device *dev)
+static int imx_dsp_resume(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1312,9 +1312,8 @@ static __maybe_unused int imx_dsp_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops imx_dsp_rproc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(imx_dsp_suspend, imx_dsp_resume)
-	SET_RUNTIME_PM_OPS(imx_dsp_runtime_suspend,
-			   imx_dsp_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(imx_dsp_suspend, imx_dsp_resume)
+	RUNTIME_PM_OPS(imx_dsp_runtime_suspend, imx_dsp_runtime_resume, NULL)
 };
 
 static const struct of_device_id imx_dsp_rproc_of_match[] = {
@@ -1332,7 +1331,7 @@ static struct platform_driver imx_dsp_rproc_driver = {
 	.driver = {
 		.name = "imx-dsp-rproc",
 		.of_match_table = imx_dsp_rproc_of_match,
-		.pm = &imx_dsp_rproc_pm_ops,
+		.pm = pm_ptr(&imx_dsp_rproc_pm_ops),
 	},
 };
 module_platform_driver(imx_dsp_rproc_driver);
-- 
2.39.2

