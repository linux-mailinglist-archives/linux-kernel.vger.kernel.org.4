Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055E7154D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjE3FR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjE3FRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:17:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BC110
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 22:17:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3rje-0000ah-P2; Tue, 30 May 2023 07:17:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3rjd-003ndd-0Y; Tue, 30 May 2023 07:17:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3rjb-009LP8-W2; Tue, 30 May 2023 07:17:28 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2] extcon: Switch i2c drivers back to use .probe()
Date:   Tue, 30 May 2023 07:17:26 +0200
Message-Id: <20230530051726.2155461-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=y9UynDkZdn1datHPb6IO1wuFDuj50DClJ4to/HUEJ3s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdYblixVvDBEHcs9jhSYfQBnF2ZcAO/tO92Hjs fdtgJvGVSOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWG5QAKCRCPgPtYfRL+ TkW9B/4hipiAo8OW0f6eIapdjAZRV1iGR6M/jpuaAENgt5pAcmsxW/yknuIw9F7J2zLkQ+0MENC 5wYkKewtzrcdUizW+tIClYAUEEckBfyr3OPHtsBTgFYS9CJA25QCOsM2Cy5tFF8RaaxoVkjyVuz ZMAOOGn3ws3ajpjx2y6qGjSfTfKixnNq+dx2qI5Dt/MvvI0hqmOhq/TswVVvq19HNSSD0OlI3Ib pET9WbklddYIQMNkOvAt8U5l0YzNBhfSmf7MA30jxYlcbPu0LcEmRkRnT99Ki+wiK7y+uYMYHEo eXUXnknIQiD/tGvM77Pq84rd+IlzE4zL+ZlgTusriFdXRfbS
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
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

On Mon, May 29, 2023 at 11:48:43PM +0900, Chanwoo Choi wrote:
> When I tried to apply it, there is conflict for extcon-usbc-tusb320.c
> extcon-usbc-tusb320.c was already changed to probe_new. 
> I'd like you to resend it on latest extcon-next branch. Thanks.

I rebased onto
git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next.
(It would have helped a bit if you mentioned the URL, I assume you would
have found it out more quickly than I did.) The relevant difference is a
conflict with commit 3adbaa30d973 ("extcon: usbc-tusb320: Unregister
typec port on driver removal") which added a .remove callback in the
context.

Best regards
Uwe

 drivers/extcon/extcon-fsa9480.c      | 2 +-
 drivers/extcon/extcon-ptn5150.c      | 2 +-
 drivers/extcon/extcon-rt8973a.c      | 2 +-
 drivers/extcon/extcon-sm5502.c       | 2 +-
 drivers/extcon/extcon-usbc-tusb320.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index e8b2671eb29b..e458ce0c45ab 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -369,7 +369,7 @@ static struct i2c_driver fsa9480_i2c_driver = {
 		.pm		= &fsa9480_pm_ops,
 		.of_match_table = fsa9480_of_match,
 	},
-	.probe_new		= fsa9480_probe,
+	.probe			= fsa9480_probe,
 	.id_table		= fsa9480_id,
 };
 
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 017a07197f38..4616da7e5430 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -348,7 +348,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
 		.name	= "ptn5150",
 		.of_match_table = ptn5150_dt_match,
 	},
-	.probe_new	= ptn5150_i2c_probe,
+	.probe		= ptn5150_i2c_probe,
 	.id_table = ptn5150_i2c_id,
 };
 module_i2c_driver(ptn5150_i2c_driver);
diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
index afc9b405d103..19bb49f13fb0 100644
--- a/drivers/extcon/extcon-rt8973a.c
+++ b/drivers/extcon/extcon-rt8973a.c
@@ -695,7 +695,7 @@ static struct i2c_driver rt8973a_muic_i2c_driver = {
 		.pm	= &rt8973a_muic_pm_ops,
 		.of_match_table = rt8973a_dt_match,
 	},
-	.probe_new = rt8973a_muic_i2c_probe,
+	.probe = rt8973a_muic_i2c_probe,
 	.remove	= rt8973a_muic_i2c_remove,
 	.id_table = rt8973a_i2c_id,
 };
diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 8401e8b27788..c8c4b9ef72aa 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -840,7 +840,7 @@ static struct i2c_driver sm5502_muic_i2c_driver = {
 		.pm	= &sm5502_muic_pm_ops,
 		.of_match_table = sm5502_dt_match,
 	},
-	.probe_new = sm5022_muic_i2c_probe,
+	.probe = sm5022_muic_i2c_probe,
 	.id_table = sm5502_i2c_id,
 };
 
diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index cc2d0ac7c5f6..4d08c2123e59 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -593,7 +593,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
 MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
 
 static struct i2c_driver tusb320_extcon_driver = {
-	.probe_new	= tusb320_probe,
+	.probe		= tusb320_probe,
 	.remove		= tusb320_remove,
 	.driver		= {
 		.name	= "extcon-tusb320",

base-commit: 93e60cd5e00e63f29e896453e10c7ede4cd8e882
-- 
2.39.2

