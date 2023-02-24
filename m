Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E646A1BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBXMHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjBXMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:06:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966D671DD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:06:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq5-0000cQ-Pz; Fri, 24 Feb 2023 13:06:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq1-007Azk-O1; Fri, 24 Feb 2023 13:06:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq2-006EYt-6D; Fri, 24 Feb 2023 13:06:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     kernel@pengutronix.de, Evgeniy Polyakov <zbr@ioremap.net>,
        Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean Delvare <jdelvare@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] w1: ds2482: Convert to i2c's .probe_new()
Date:   Fri, 24 Feb 2023 13:05:55 +0100
Message-Id: <20230224120600.1681685-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
References: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BzuVYSfwpD9FqWmWpmQJWk/Mwl/NXFiGZ/5Qwvgx0mU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj+KgRdtkNQDNgWuRKmbrh+DXfQMjcTk/EPMyGp jfiN54UhIuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/ioEQAKCRDB/BR4rcrs CdV+B/0aQU9cupvi0J/P9tYJ5xh//u+NoUyh700iUabvg00NxFprJPBgxFW/7Po26ZMc4WThhCv kyES+i34OGGzHEOKSJizsq+7ga1x0WRCbmAnMLLtroM8iojlWk7CR91ByP61Y+tCOXlXWK84o9Y DHxSTc+sGbJa2nHDlxl/3owHgwivqIZywAnHm2NzIjE3VgnQoBMsgfxVY44hvhemSqDl+RH0QTR apaT3dlDiEITXXcVaCi6tBaNWSp2lvXjlxQJaf9FJI7aCgEziK7k9rutBWWoOL3xkncU6xUl7gB 8zRyyMe3XZiqRJBGY0I4dlDzFxAHkT+7sGXK+FoN/w78Byz9
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

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Link: https://lore.kernel.org/lkml/20221118224540.619276-596-uwe@kleine-koenig.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/ds2482.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 62c44616d8a9..3d8b51316bef 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -442,8 +442,7 @@ static u8 ds2482_w1_set_pullup(void *data, int delay)
 }
 
 
-static int ds2482_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ds2482_probe(struct i2c_client *client)
 {
 	struct ds2482_data *data;
 	int err = -ENODEV;
@@ -553,7 +552,7 @@ static struct i2c_driver ds2482_driver = {
 	.driver = {
 		.name	= "ds2482",
 	},
-	.probe		= ds2482_probe,
+	.probe_new	= ds2482_probe,
 	.remove		= ds2482_remove,
 	.id_table	= ds2482_id,
 };
-- 
2.39.1

