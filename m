Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97848631E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKUKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKUKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:25:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7F8CFCC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:25:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ox3z1-0008Pk-L2; Mon, 21 Nov 2022 11:24:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ox3z0-005dP2-3A; Mon, 21 Nov 2022 11:24:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ox3z0-000YG2-DD; Mon, 21 Nov 2022 11:24:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] mfd: rohm-bd9576: convert to i2c's .probe_new()
Date:   Mon, 21 Nov 2022 11:24:54 +0100
Message-Id: <20221121102454.15664-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=L4ZEXavhL0XEdzdCGTRYtbxFUCH0CVdrdVnnZLFA96E=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBje1HyxWXq6XIqyCXxzxwrSovrISgUb7LtXGKB74Qs LqGBUByJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3tR8gAKCRDB/BR4rcrsCcZKB/ 4tPJxyR8kaYYnnReCqP/Rax41+JVHpeYqQVqWWvp6aJQnf4Y1wy0B6Wsl/RFIhmwCsNDhSkO4IItwE kgY76m3aA37FsO5BNSULF4Ucrr2KLtP/ONEumYt6H+OYAm4SfDXkt3Ly7Pk3FGqs51D37Ifg4Dg3im 57Ute6MY8sYLoI0FS5I+uvE6/qWjFNMsbdz3nzP42A7CFvz+gCqFRiyE6Vj3znfLw7fr70wf1wNIGK n5WYHs+e9/EMC/p+dwIh9CL2ImNJnkzVyO7gJUb+qGDJfzp/UKwqWgaZuykeMglcBiTNjbWcOUVNQi nDZuBjX6VWeH2huD930Cy5u1BOG5UK
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

The probe function doesn't make use of the i2c_device_id * parameter so
it can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/rohm-bd9576.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index f37cd4f27aeb..c854ab5bcd80 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -88,8 +88,7 @@ static struct regmap_irq_chip bd9576_irq_chip = {
 	.irq_reg_stride = 1,
 };
 
-static int bd957x_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int bd957x_i2c_probe(struct i2c_client *i2c)
 {
 	int ret;
 	struct regmap *regmap;
@@ -180,7 +179,7 @@ static struct i2c_driver bd957x_drv = {
 		.name = "rohm-bd957x",
 		.of_match_table = bd957x_of_match,
 	},
-	.probe = &bd957x_i2c_probe,
+	.probe_new = &bd957x_i2c_probe,
 };
 module_i2c_driver(bd957x_drv);
 
-- 
2.38.1

