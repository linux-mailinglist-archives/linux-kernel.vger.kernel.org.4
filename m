Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC42C6FECF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEKHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbjEKHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:35:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533F9EE5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:34:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1px0os-0007Zn-TE; Thu, 11 May 2023 09:34:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1px0os-002fr1-2v; Thu, 11 May 2023 09:34:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1px0or-003LJM-58; Thu, 11 May 2023 09:34:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] driver core: Call pm_runtime_put_sync() only after device_remove()
Date:   Thu, 11 May 2023 09:34:28 +0200
Message-Id: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=inxu00lxAvQhhTdGwdmmOXbixsATQzMqe2CB3zBDu5I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXJqDyBlNnJ+V0dwc6hrHJ43dopD/xjtOQqTyu VX7vDqJ/uKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZFyagwAKCRCPgPtYfRL+ TmGdB/9Mu2bv39+Vfrpo+4ssj59lgz65Oc97qu74DfG3s7/lLI0AsUWxoEOuE++iqeatemZlwvH 4QURYl7UbHzj+pUAfDx6gxTzCmUqPd/40uC35U61Ah+h1YN3hMLRKmmtDw67FjeqsX1i7G+rqI9 8jTXKOk427HvZPHsX3nuyWBkUqhIRwdEEh3DPBbngoRQYkQkJZV2dxBQ9warhDnRbYqV7Nv19o+ Ielf3E3CW/ZhfnJIeTHGcviYojHygYaa88y0NgKThdu9e1h0meTIiCQR7oEr8OBhifGj6HIDB/M R+QHgkZwc8FwpmGXfN80j4gqIkQZVq59jdg6TpWwqhSMwncO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers that use runtime PM call pm_runtime_get_sync() or one of
its variants in their remove callback. So calling pm_runtime_put_sync()
directly before calling the remove callback results (under some
conditions) in the driver's suspend routine being called just to resume
it again afterwards.

So delay the pm_runtime_put_sync() call until after device_remove().

Confirmed on a stm32mp157a that doing

	echo 4400e000.can > /sys/bus/platform/drivers/m_can_platform/unbind

(starting with a runtime-pm suspended 4400e000.can) results in one call
less of m_can_runtime_resume() and m_can_runtime_suspend() each after
this change was applied.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

side note: To test I added a dev_info() to m_can_runtime_resume() and
m_can_runtime_suspend(). I was surprised that directly after boot I had:

	# dmesg | grep -E '4400e000.can: m_can_runtime_(resume|suspend)' | wc -l
	15

I didn't go down that rabbit hole to debug this.

Best regards
Uwe

 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9c09ca5c4ab6..d97f6b1486d1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1267,10 +1267,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
 
-		pm_runtime_put_sync(dev);
-
 		device_remove(dev);
 
+		pm_runtime_put_sync(dev);
+
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
 
-- 
2.39.2

