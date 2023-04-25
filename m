Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8396EE34C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjDYNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDYNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:41:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583631A5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:41:30 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rIv9pfJUpNW2mrIv9pVpBo; Tue, 25 Apr 2023 15:41:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682430088;
        bh=rXrzLrO3vGjGiwYLBA1OdhCadEqnB23+J7DLeIwxJkU=;
        h=From:To:Cc:Subject:Date;
        b=rPqKGAgtC97DC+4ysW4ox64hT/KD/gHMevtma70trjnkFd1NqMVAogdG1plzShqgQ
         pSYo24zJia4wYKcxJa9ZCBA8SYnbuYKiy5bptaRtpOSxK1ZP9zKPL7FWToeSsIWR/9
         vlnV41mZ4tT9AhtPvUrHUkEUodsqqQ7tsraISuACtctXk8Fa2d3fNe4Muj3HIc3Kq7
         1Ujzxaq9ARCLrKsqNVIeom7pXugqo9pVvCKyWsgvPqo669tqd4aiwUVZem3myMnTr4
         DGV3ccRiGUPsy+7hkw2CkgbjjYK0C0fl78AMX2nvJNfujPCK7veZ2XV/2Nu8TkbsYe
         dis3Zm/LCSWkw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 15:41:28 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Brad Larson <blarson@amd.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: Fix an error handling path in sdhci_cdns_probe()
Date:   Tue, 25 Apr 2023 15:41:26 +0200
Message-Id: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_reset_control_get_optional_exclusive() fails, some resources still
need to be released. So branch to the error handling path instead of
returning directly.

Fixes: aad53d4ee756 ("mmc: sdhci-cadence: Support mmc hardware reset")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/sdhci-cadence.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index b24aa27da50c..d2f625054689 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -540,9 +540,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	if (host->mmc->caps & MMC_CAP_HW_RESET) {
 		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
-		if (IS_ERR(priv->rst_hw))
-			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
-					     "reset controller error\n");
+		if (IS_ERR(priv->rst_hw)) {
+			ret = dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
+					    "reset controller error\n");
+			goto free;
+		}
 		if (priv->rst_hw)
 			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
 	}
-- 
2.34.1

