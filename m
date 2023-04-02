Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA126D375A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDBKkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:40:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABC211EB4
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:40:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1piv7v-0006tR-Ry; Sun, 02 Apr 2023 12:39:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1piv7v-008QnH-1T; Sun, 02 Apr 2023 12:39:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1piv7u-009wdU-3H; Sun, 02 Apr 2023 12:39:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH RFC] PM: runtime: Drop device usage only after remove is done
Date:   Sun,  2 Apr 2023 12:39:51 +0200
Message-Id: <20230402103951.2510773-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OwxwmIKy2FteW/idb53cSJwTf/azfHPSb/pvNvtIfZk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkKVt24IsjqrU6OjFcCEbuoukKPpqOuraJJ4cT8 vbfjV7XCsmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZClbdgAKCRCPgPtYfRL+ TuAeB/0fFBunTODyu0Ux6drM0CqTKwcuxZqIwRBw9axgz5Pf8pM7kX6SE92K+kzNzGc34n3aDIK TQvludfF2wS2ZDX94uz5yfaPmSId1fkKxl7iqFp8OklGHKWUd/1QtpISzgZmIjB5w5Ya6TzwelT Ggudv/W8C2diVHqDWdKpiOfFV32AF0IocWHRRBWGZaEglY+IkBGS7tf8wRCJ2Ygl0J+OAmq7n5q K7NXzO1mZlZcrTSYPJHZ/jHr3QtZtvkjqbNwRyBsim5zhrV2+WrqbbQRjFVhtBaxGAdtQJPh+8R w+q1McUZ8srxFzfeYdd8xmqUKWFFKIha0XdCy/AuzIuJmiIs
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many device drivers call one of the variants of pm_runtime_resume() in
their remove callback. So calling pm_runtime_put_sync() just before that
is ineffective as the suspend callback might just be called just to
resume the device directly afterwards again.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is a theoretical issue that I noticed while doing some research how
pm-runtime works. Not sure it makes sense, so I marked it as RFC.

Best regards
Uwe

 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8def2ba08a82..6beac141d3d2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1235,10 +1235,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
 
-		pm_runtime_put_sync(dev);
-
 		device_remove(dev);
 
+		pm_runtime_put_sync(dev);
+
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
 

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

