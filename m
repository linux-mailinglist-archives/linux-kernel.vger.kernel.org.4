Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7211274BD58
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGHL1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 07:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:27:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B11991
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 04:27:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1qI65i-0002IC-OZ; Sat, 08 Jul 2023 13:27:06 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1qI65e-00CwkC-0l; Sat, 08 Jul 2023 13:27:02 +0200
Received: from afa by dude05.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <afa@pengutronix.de>)
        id 1qI65d-00C9j5-1g;
        Sat, 08 Jul 2023 13:27:01 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: imx8mm: suppress log message on probe deferral
Date:   Sat,  8 Jul 2023 13:26:46 +0200
Message-Id: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem_cell_read_u32() may return -EPROBE_DEFER if NVMEM supplier has not
yet been probed. Future reprobe may succeed, so printing:

  i.mx8mm_thermal 30260000.tmu: Failed to read OCOTP nvmem cell (-517).

to the log is confusing. Fix this by using dev_err_probe. This also
elevates the message from warning to error, which is more correct: The
log message is only ever printed in probe error path and probe aborts
afterwards, so it really warrants an error-level message.

Fixes: 403291648823 ("thermal/drivers/imx: Add support for loading calibration data from OCOTP")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/thermal/imx8mm_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index d8005e9ec992..1f780c4a1c89 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -179,10 +179,8 @@ static int imx8mm_tmu_probe_set_calib_v1(struct platform_device *pdev,
 	int ret;
 
 	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &ana0);
-	if (ret) {
-		dev_warn(dev, "Failed to read OCOTP nvmem cell (%d).\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read OCOTP nvmem cell\n");
 
 	writel(FIELD_PREP(TASR_BUF_VREF_MASK,
 			  FIELD_GET(ANA0_BUF_VREF_MASK, ana0)) |
-- 
2.39.2

