Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E335B6895
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIMHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIMHVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:21:47 -0400
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39FE258DD6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:21:44 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee863202f85593-3745f;
        Tue, 13 Sep 2022 15:21:43 +0800 (CST)
X-RM-TRANSID: 2ee863202f85593-3745f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.98])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee163202f844cd-4e1df;
        Tue, 13 Sep 2022 15:21:43 +0800 (CST)
X-RM-TRANSID: 2ee163202f844cd-4e1df
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: Fix wrong check
Date:   Tue, 13 Sep 2022 15:21:55 +0800
Message-Id: <20220913072155.13392-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function imx8m_blk_ctrl_probe(),
dev_pm_domain_attach_by_name() may return NULL in some cases,
so IS_ERR() doesn't meet the requirements. Thus fix it.

Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index ccd0577a7..98a1f2151 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -235,10 +235,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 		domain->power_dev =
 			dev_pm_domain_attach_by_name(dev, data->gpc_name);
-		if (IS_ERR(domain->power_dev)) {
+		if (IS_ERR_OR_NULL(domain->power_dev)) {
 			dev_err_probe(dev, PTR_ERR(domain->power_dev),
 				      "failed to attach power domain\n");
-			ret = PTR_ERR(domain->power_dev);
+			ret = PTR_ERR(domain->power_dev) ? : -ENODATA;
 			goto cleanup_pds;
 		}
 
-- 
2.20.1.windows.1



