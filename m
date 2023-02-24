Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F146A1BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBXMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBXMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:06:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3728658D1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:06:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq3-0000cN-Qq; Fri, 24 Feb 2023 13:06:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq1-007AzY-87; Fri, 24 Feb 2023 13:06:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pVWq1-006EYn-N4; Fri, 24 Feb 2023 13:06:09 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     kernel@pengutronix.de, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ajay Gupta <ajayg@nvidia.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mtd: maps: pismo: Convert to i2c's .probe_new()
Date:   Fri, 24 Feb 2023 13:05:53 +0100
Message-Id: <20230224120600.1681685-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
References: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/0eiJPqFeurijjpkwmurJqwpYiXoK4/V9TBQsEVUx4E=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj+KgKBq230DjtR0OENDTBnqh3jGbv7HQJOiXLd 6y9xrOx10OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/ioCgAKCRDB/BR4rcrs CY4XCACH57ZCK1Vw03Zvu0LsFkiwrHRc8kuPqK/hmjDx7CRhsyr4gxJ0xxXg7CJId36dbm1JTUt 6QWR789F/GDm8Ke3B/p+rJW56+JBqHvlevMucJ/8ufUbR9Q67xjEuH87WwsveZ7iG8/ovUdGcrr sgy3Q1yYjtkhxt39BvnHNHF91FhJdTT5fI91UIW4xHZKwKkjJdj0I9DpliGYGSELePaBm3h8kLo 7YlxhXiPBIvkJAvqRiG5/esKuqv0DXyqRt2UF42xR7hlbu5oHKZFRJ/XpRfCmkNS6m15CboT/Dg 7uxvImtjHzjPAXvCaAFFo6j3oGNqZE+TlK3mXL2fZA9KXnu9
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

Acked-by: Richard Weinberger <richard@nod.at>
Link: https://lore.kernel.org/lkml/20221118224540.619276-497-uwe@kleine-koenig.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/maps/pismo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
index 5fcefcd0baca..3e0fff3f129e 100644
--- a/drivers/mtd/maps/pismo.c
+++ b/drivers/mtd/maps/pismo.c
@@ -206,8 +206,7 @@ static void pismo_remove(struct i2c_client *client)
 	kfree(pismo);
 }
 
-static int pismo_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id)
+static int pismo_probe(struct i2c_client *client)
 {
 	struct pismo_pdata *pdata = client->dev.platform_data;
 	struct pismo_eeprom eeprom;
@@ -260,7 +259,7 @@ static struct i2c_driver pismo_driver = {
 	.driver	= {
 		.name	= "pismo",
 	},
-	.probe		= pismo_probe,
+	.probe_new	= pismo_probe,
 	.remove		= pismo_remove,
 	.id_table	= pismo_id,
 };
-- 
2.39.1

