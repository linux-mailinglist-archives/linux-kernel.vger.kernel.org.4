Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D956A1BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBXMGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBXMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:06:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78B658CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:06:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq5-0000cR-1X; Fri, 24 Feb 2023 13:06:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq2-007Azo-1R; Fri, 24 Feb 2023 13:06:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq2-006EZ1-KU; Fri, 24 Feb 2023 13:06:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     kernel@pengutronix.de, Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 6/9] media: i2c: ov2685: convert to i2c's .probe_new()
Date:   Fri, 24 Feb 2023 13:05:57 +0100
Message-Id: <20230224120600.1681685-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
References: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7yv9mXh7sjTNuiY/jTjA3naqJ/nYBGzIZt6uw2F2D8c=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj+KgXRLWoSMNc/bOdJhtHrW/tFpDl/midGdlNh EXU3p1BKUOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/ioFwAKCRDB/BR4rcrs CZbjB/0UsaLUVBgtMCn930I2FROj9MNO1M3bCOISey8f0uxBInDAVmq6o3D6bJ73bPnFyeXEwuf sEv4WmCNjBqeOhLDJiO/gz4SAjK1hXawlmaTiZaRX24hFRTBfrgHa9qj2dlhNJEnUc2otfoljnK WrScX67pVMIVASZXj+49u1rEXFoYQui4RwHsR/TafjSoLBQGSKftFHFr/+fVNlggOW4BjSTwVyS u8REwitycX4UuuKxVQb8iSaKM0I1Ax/RmX26uPeAQZ+EJf9C1+BDi5OUAr3lRgymabA0oOrJe0Q 42IQ2Rx/4+6a5yU5FEGe1cQYCZX9ylgsZ29kaqTRlvTb/RYA
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

The probe function doesn't make use of the i2c_device_id * parameter so
it can be trivially converted.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Link: https://lore.kernel.org/lkml/20221121102838.16448-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/i2c/ov2685.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index a3b524f15d89..1c80b121e7d6 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -707,8 +707,7 @@ static int ov2685_configure_regulators(struct ov2685 *ov2685)
 				       ov2685->supplies);
 }
 
-static int ov2685_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ov2685_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct ov2685 *ov2685;
@@ -830,7 +829,7 @@ static struct i2c_driver ov2685_i2c_driver = {
 		.pm = &ov2685_pm_ops,
 		.of_match_table = of_match_ptr(ov2685_of_match),
 	},
-	.probe		= &ov2685_probe,
+	.probe_new	= &ov2685_probe,
 	.remove		= &ov2685_remove,
 };
 
-- 
2.39.1

