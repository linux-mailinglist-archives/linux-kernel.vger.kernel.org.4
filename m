Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192566A1BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBXMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBXMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:06:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498EC65336
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:06:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq3-0000cO-GQ; Fri, 24 Feb 2023 13:06:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq1-007Aze-Ft; Fri, 24 Feb 2023 13:06:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq1-006EYk-GX; Fri, 24 Feb 2023 13:06:09 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] misc: ad525x_dpot-i2c: Convert to i2c's .probe_new()
Date:   Fri, 24 Feb 2023 13:05:52 +0100
Message-Id: <20230224120600.1681685-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
References: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mZMy4fIoX9VoX671/ujh3l6dvR2sZ0vFBfJ5QYZaI/k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj+KgGWYZ8keqte4NLP53S5uCaMlHf1ql5crSHa pOrSxDbA+KJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/ioBgAKCRDB/BR4rcrs CX6MCACDJMLcVlwPFqphiqcsaBpcTjlkPiqn53IelowpPzNxMasMAbZ9xaSQGdfNW7wajIfoThu ijkwGZi3dY26Szqrsf878I+U27c/lYrgrQV0PFRo1saSk1v2fHWczfjc/zQh2KPaokJ4Oiqe+I5 gVo+X+ZCH7sgGmxOrMLIUJJ+jcez/aLDQn0DT270iinI6loLbU2jdUA3OHHkcLGkjCZ6UDiWy8X C4XIatL9rz+rFHtfxc3chUe8W8DPUFWDCNuPbLp4KxsiQ7Osv2KSUJQjVlAQvyiT9E1AErFgM/5 1PzLHBN8mMKCbyud7y6k1KI0W+qjv1est8jwO8EGmqG805aZ
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

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in the probe function.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/20221118224540.619276-483-uwe@kleine-koenig.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/ad525x_dpot-i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-i2c.c
index 28ffb4377d98..3856d5c04c5f 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -50,9 +50,9 @@ static const struct ad_dpot_bus_ops bops = {
 	.write_r8d16	= write_r8d16,
 };
 
-static int ad_dpot_i2c_probe(struct i2c_client *client,
-				      const struct i2c_device_id *id)
+static int ad_dpot_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct ad_dpot_bus_data bdata = {
 		.client = client,
 		.bops = &bops,
@@ -106,7 +106,7 @@ static struct i2c_driver ad_dpot_i2c_driver = {
 	.driver = {
 		.name	= "ad_dpot",
 	},
-	.probe		= ad_dpot_i2c_probe,
+	.probe_new	= ad_dpot_i2c_probe,
 	.remove		= ad_dpot_i2c_remove,
 	.id_table	= ad_dpot_id,
 };
-- 
2.39.1

