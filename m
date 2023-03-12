Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5086B6817
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCLQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCLQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE94536FE6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-0007nk-Ja; Sun, 12 Mar 2023 17:15:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-003f1W-CW; Sun, 12 Mar 2023 17:15:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLu-004K88-HS; Sun, 12 Mar 2023 17:15:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/30] clk: tegra: Don't warn three times about failure to unregister
Date:   Sun, 12 Mar 2023 17:14:44 +0100
Message-Id: <20230312161512.2715500-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+9AIxbdgygHscbuQBZ/9x7Mj2mdYT5CkFcqptrNLIzs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfoZt+vEgQUzkC6DfJiC5nFmGIwE1dZDTropc hsVPMpXKMiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36GQAKCRDB/BR4rcrs CdPQB/9x+RX5qdpP5p75qTQmrWsuZtOUtTbvdCLf6ap0jZk0ajXM6AZAQG6gldT5Dezfdk4nBEH nGaudn6KTmmM5kKwAVzSU9bMMGVViK7U/Ik1BX7d1S+UFXjYZ7DGhrbumaB53BLoNyvq0IrInHH mQFZaJ/aCe/2AelK7D18mVR0W3MtbZPtj6tAJ0GSvIWOtlxSyhx0E0UGpDL2EpAoCBYsGWw4rvT qGcQAaCpIB6ghHcsuSizmiCZXlJARky4QiZo+q9i0p8ujwSHwS2fb1qyBUIczJ04rQQJtq6pdRZ TzmvAMFpB+rrAhMgNatHs12yLJ3EaW/R1dDHKkX7RH5sUH6u
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra124_dfll_fcpu_remove() calls tegra_dfll_unregister() and the former
emits an error message if the latter fails. In that case
tegra_dfll_unregister() already printed an error message. Additionally
tegra124_dfll_fcpu_remove() returns an error code which results in yet
another warning emitted by platform_remove().

So drop the error message from tegra124_dfll_fcpu_remove() and let it
return 0. (Retuning 0 has no side effect but suppressing the error
message in platform_remove().)

Also add two comments about exiting early being wrong. This is something
that needs fixing separately.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/tegra/clk-dfll.c               |  5 ++++-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 11 ++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 41433927b55c..58fa5a59e0c7 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -2081,7 +2081,10 @@ struct tegra_dfll_soc_data *tegra_dfll_unregister(struct platform_device *pdev)
 {
 	struct tegra_dfll *td = platform_get_drvdata(pdev);
 
-	/* Try to prevent removal while the DFLL is active */
+	/*
+	 * Note that exiting early here doesn't prevent unbinding the driver.
+	 * Exiting early here only leaks some resources.
+	 */
 	if (td->mode != DFLL_DISABLED) {
 		dev_err(&pdev->dev,
 			"must disable DFLL before removing driver\n");
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 5e339ad0a97c..15c5e14dd82f 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -616,12 +616,13 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 {
 	struct tegra_dfll_soc_data *soc;
 
+	/*
+	 * Note that exiting early here is dangerous as after this function
+	 * returns *soc is freed.
+	 */
 	soc = tegra_dfll_unregister(pdev);
-	if (IS_ERR(soc)) {
-		dev_err(&pdev->dev, "failed to unregister DFLL: %ld\n",
-			PTR_ERR(soc));
-		return PTR_ERR(soc);
-	}
+	if (IS_ERR(soc))
+		return 0;
 
 	tegra_cvb_remove_opp_table(soc->dev, soc->cvb, soc->max_freq);
 
-- 
2.39.1

