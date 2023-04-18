Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08B6E5A38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDRHQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDRHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309D1BF6;
        Tue, 18 Apr 2023 00:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D23622ED;
        Tue, 18 Apr 2023 07:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09166C4339C;
        Tue, 18 Apr 2023 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681802172;
        bh=07NV2Gmox+YRD93ereeLrOro5v93hkdsxev1VKaen7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=mm7+Es+NlCcXGiXXyoWT9RuaKMVF9rjk5PcIzc6t8qVNwF4ujzaYdkZwHaFYcIEnG
         CeVZRwb/It9DxKRSj2mCKlxrB2CrqEiZkUJm6Jowri2QjedPrLhVasLINm4rPvEL2E
         9vO9yc5SsgHBN5+GYjr7l/+6c0R5/KQ8H7/rDAShmpnu4IQZS8GBX1FsLLUstWGVV0
         xRBW0DhDEurQc9f7qk/hXVK4zJnByE4LS4LoAvU+wEfY+w7CxZ3ZWsqKdT4MPfeyed
         ogGHuzI5n4IBYpPGcxxSoNChyFlxkdrOtk7uTS4S5XliIKOWStVLgC6+hWwRj14slS
         vvYC6xO30yZSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Guoniu Zhou <guoniu.zhou@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: nxp: ignore unused suspend operations
Date:   Tue, 18 Apr 2023 09:15:51 +0200
Message-Id: <20230418071605.2971866-1-arnd@kernel.org>
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

gcc warns about some functions being unused when CONFIG_PM is
disabled:

drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:328:12: error: 'mxc_isi_pm_resume' defined but not used [-Werror=unused-function]
  328 | static int mxc_isi_pm_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~
drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:314:12: error: 'mxc_isi_pm_suspend' defined but not used [-Werror=unused-function]
  314 | static int mxc_isi_pm_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~

Use the modern SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers in place
of the old SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS() ones, and add
a pm_ptr() check to ensure they get dropped by the compiler.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 238521622b75..253e77189b69 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -378,8 +378,8 @@ static int mxc_isi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mxc_isi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mxc_isi_pm_suspend, mxc_isi_pm_resume)
-	SET_RUNTIME_PM_OPS(mxc_isi_runtime_suspend, mxc_isi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mxc_isi_pm_suspend, mxc_isi_pm_resume)
+	RUNTIME_PM_OPS(mxc_isi_runtime_suspend, mxc_isi_runtime_resume, NULL)
 };
 
 /* -----------------------------------------------------------------------------
@@ -528,7 +528,7 @@ static struct platform_driver mxc_isi_driver = {
 	.driver = {
 		.of_match_table = mxc_isi_of_match,
 		.name		= MXC_ISI_DRIVER_NAME,
-		.pm		= &mxc_isi_pm_ops,
+		.pm		= pm_ptr(&mxc_isi_pm_ops),
 	}
 };
 module_platform_driver(mxc_isi_driver);
-- 
2.39.2

