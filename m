Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4323F6B54B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjCJWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjCJWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:42:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE314D083
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:41:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQg-0002dA-Ci; Fri, 10 Mar 2023 23:41:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003GqK-PW; Fri, 10 Mar 2023 23:41:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQd-003uEV-Tw; Fri, 10 Mar 2023 23:41:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] bus: fsl-mc: Only warn once about errors on device unbind
Date:   Fri, 10 Mar 2023 23:41:23 +0100
Message-Id: <20230310224128.2638078-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=soyW7qTmvLYZjqko2bU9Wwukx4vz+pHXyLiUEo5BE/k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC7ICu4CcOxQg/SDY7ITR2qMbSiRlYm+mW1eYT 2LMemXdmyCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAuyAgAKCRDB/BR4rcrs CTO4CACB4/9hoCCFS63udqPEt25X5YNtEcx6g17uulRdRr3YvP0UrswrzXQcFDuua+LWWn3jbt0 95PWumPSIH+HoznhsoXg4e5CWtEPRR9oM00ZSR5M5R6+HONbarn/jiE1eGrGK06hrOiKrXp2HQG DdWhR/qEGVjxNZmAw+cm3eS+4tiex/oIN+TgD3BZMS+iZMJI9wp4UN/Nx+IYFWLUp9Yfpl4IbxL PpFV3rzLosWHSubLoWl7WZWwhMku4s8cxeRduT00Dp3X5lEmPYkYW3ryh/aMlQeNsV/9hhQ7vAo tzihQ5oJECMj5dnRkfvBR37bT0n/BGO3saVBnptKAKFDqXot
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a platform driver's remove function returns an error code, this
results in a (generic and little helpful) error message. Otherwise the
value is ignored.

As fsl_mc_driver_remove() already emit an error message, return 0 also
in the error case. The only effect is to suppress the device core's
error message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 36cb091a33b4..1531e6101fb1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -457,10 +457,8 @@ static int fsl_mc_driver_remove(struct device *dev)
 	int error;
 
 	error = mc_drv->remove(mc_dev);
-	if (error < 0) {
+	if (error < 0)
 		dev_err(dev, "%s failed: %d\n", __func__, error);
-		return error;
-	}
 
 	return 0;
 }
-- 
2.39.1

