Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA37C72B3FF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjFKUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:47:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBCD8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:47:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8RyS-00027v-22; Sun, 11 Jun 2023 22:47:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8RyQ-006jQU-Df; Sun, 11 Jun 2023 22:47:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8RyP-00DIKg-Du; Sun, 11 Jun 2023 22:47:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] mux: adg792a: Switch back to use i2c_driver's .probe()
Date:   Sun, 11 Jun 2023 22:47:37 +0200
Message-Id: <20230611204737.828617-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=y4hva+PgitW/U7eAqgv9+HU/FxY3KXgCgs+LNOqhnLg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkhjLonctaeBic711T6V3z66PRv/YrtFUIjbzEE du7n2lj8zWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIYy6AAKCRCPgPtYfRL+ Tg/gCACr0OMSxV4lU9LXHcDoEgej/cchJQk+KCCx+i+Fv5idIvwvfRHgHFpu/ZYA81CdBDV6hL2 H1hT8y4fXbPqq3+QJQSz0u6soMKlvOLJ2ys97mvc2kSnwSNaltxfNV51A+thNtzguP9IP0N5bzT hh1bLUZyBGE6cnrnPxa6SCxiNHjTlEM0ICq5ri0pvjjjXo1PgVeDzsUY2syljVrspPK6YUemgbQ y/ALTIYpQMH781bVXJ0lmU7+lGtztlDXyHRBsZuhMuBdd5Nnu5rW2Nd71t+YTq628Doix5zok9Y TIZ1NILPQ6urWm4EsPJg/5rq06YImIGb1gEgTojEscwmND3F
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

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mux/adg792a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
index e8fc2fc1ab09..4da5aecb9fc6 100644
--- a/drivers/mux/adg792a.c
+++ b/drivers/mux/adg792a.c
@@ -143,7 +143,7 @@ static struct i2c_driver adg792a_driver = {
 		.name		= "adg792a",
 		.of_match_table = of_match_ptr(adg792a_of_match),
 	},
-	.probe_new	= adg792a_probe,
+	.probe		= adg792a_probe,
 	.id_table	= adg792a_id,
 };
 module_i2c_driver(adg792a_driver);

base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
-- 
2.39.2

