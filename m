Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B45B68BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIMHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIMHeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:34:12 -0400
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EA4958DFA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:34:11 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13])
        by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee563203271572-36df0;
        Tue, 13 Sep 2022 15:34:10 +0800 (CST)
X-RM-TRANSID: 2ee563203271572-36df0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.98])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee763203270ff5-51eb6;
        Tue, 13 Sep 2022 15:34:10 +0800 (CST)
X-RM-TRANSID: 2ee763203270ff5-51eb6
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] soc: imx: fix error check in imx8mp_blk_ctrl_probe()
Date:   Tue, 13 Sep 2022 15:34:34 +0800
Message-Id: <20220913073434.7252-1-tangbin@cmss.chinamobile.com>
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

In the function imx8mp_blk_ctrl_probe(),
dev_pm_domain_attach_by_name() may return NULL in some cases,
so IS_ERR() doesn't meet the requirements. Thus fix it.

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index ccb30c6cd..ed8557eaf 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -597,11 +597,11 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 
 		domain->power_dev =
 			dev_pm_domain_attach_by_name(dev, data->gpc_name);
-		if (IS_ERR(domain->power_dev)) {
+		if (IS_ERR_OR_NULL(domain->power_dev)) {
 			dev_err_probe(dev, PTR_ERR(domain->power_dev),
 				      "failed to attach power domain %s\n",
 				      data->gpc_name);
-			ret = PTR_ERR(domain->power_dev);
+			ret = PTR_ERR(domain->power_dev) ? : -ENODATA;
 			goto cleanup_pds;
 		}
 		dev_set_name(domain->power_dev, "%s", data->name);
-- 
2.33.0



