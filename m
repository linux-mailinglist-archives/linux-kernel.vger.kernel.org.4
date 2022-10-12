Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138AB5FC79D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJLOm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJLOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:42:52 -0400
Received: from 15.mo583.mail-out.ovh.net (15.mo583.mail-out.ovh.net [178.33.107.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB4FC8205
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:42:48 -0700 (PDT)
Received: from player788.ha.ovh.net (unknown [10.110.171.148])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id DA70F253CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:25:43 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 5AC742F9B390F;
        Wed, 12 Oct 2022 14:25:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R0049184b12f-2b4e-4dcb-9236-01c8d45e0aad,
                    75377E6B882747309559AE06BD3DFEEF97A89409) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Stephen Kitt <steve@sk2.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/gpio: use simple i2c probe
Date:   Wed, 12 Oct 2022 16:25:23 +0200
Message-Id: <20221012142524.3920266-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14872856296705656539
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppeduvdejrddtrddtrddupdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these drivers have an i2c probe function which doesn't use the
"struct i2c_device_id *id" parameter, so they can trivially be
converted to the "probe_new" style of probe with a single argument.

This is part of an ongoing transition to single-argument i2c probe
functions. Old-style probe functions involve a call to i2c_match_id:
in drivers/i2c/i2c-core-base.c,

         /*
          * When there are no more users of probe(),
          * rename probe_new to probe.
          */
         if (driver->probe_new)
                 status = driver->probe_new(client);
         else if (driver->probe)
                 status = driver->probe(client,
                                        i2c_match_id(driver->id_table, client));
         else
                 status = -EINVAL;

Drivers which don't need the second parameter can be declared using
probe_new instead, avoiding the call to i2c_match_id. Drivers which do
can still be converted to probe_new-style, calling i2c_match_id
themselves (as is done currently for of_match_id).

This change was done using the following Coccinelle script, and fixed
up for whitespace changes:

@ rule1 @
identifier fn;
identifier client, id;
@@

- static int fn(struct i2c_client *client, const struct i2c_device_id *id)
+ static int fn(struct i2c_client *client)
{
...when != id
}

@ rule2 depends on rule1 @
identifier rule1.fn;
identifier driver;
@@

struct i2c_driver driver = {
-       .probe
+       .probe_new
                =
(
                   fn
|
-                  &fn
+                  fn
)
                ,
};

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/gpio/gpio-gw-pld.c   | 5 ++---
 drivers/gpio/gpio-max7300.c  | 5 ++---
 drivers/gpio/gpio-tpic2810.c | 5 ++---
 drivers/gpio/gpio-ts4900.c   | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-gw-pld.c b/drivers/gpio/gpio-gw-pld.c
index 2109803ffb38..5057fa9ad610 100644
--- a/drivers/gpio/gpio-gw-pld.c
+++ b/drivers/gpio/gpio-gw-pld.c
@@ -67,8 +67,7 @@ static void gw_pld_set8(struct gpio_chip *gc, unsigned offset, int value)
 	gw_pld_output8(gc, offset, value);
 }
 
-static int gw_pld_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int gw_pld_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct gw_pld *gw;
@@ -126,7 +125,7 @@ static struct i2c_driver gw_pld_driver = {
 		.name = "gw_pld",
 		.of_match_table = gw_pld_dt_ids,
 	},
-	.probe = gw_pld_probe,
+	.probe_new = gw_pld_probe,
 	.id_table = gw_pld_id,
 };
 module_i2c_driver(gw_pld_driver);
diff --git a/drivers/gpio/gpio-max7300.c b/drivers/gpio/gpio-max7300.c
index 43da381a4d7e..cf482f4f0098 100644
--- a/drivers/gpio/gpio-max7300.c
+++ b/drivers/gpio/gpio-max7300.c
@@ -28,8 +28,7 @@ static int max7300_i2c_read(struct device *dev, unsigned int reg)
 	return i2c_smbus_read_byte_data(client, reg);
 }
 
-static int max7300_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int max7300_probe(struct i2c_client *client)
 {
 	struct max7301 *ts;
 
@@ -63,7 +62,7 @@ static struct i2c_driver max7300_driver = {
 	.driver = {
 		.name = "max7300",
 	},
-	.probe = max7300_probe,
+	.probe_new = max7300_probe,
 	.remove = max7300_remove,
 	.id_table = max7300_id,
 };
diff --git a/drivers/gpio/gpio-tpic2810.c b/drivers/gpio/gpio-tpic2810.c
index d642c35cb97c..349c5fbd9b02 100644
--- a/drivers/gpio/gpio-tpic2810.c
+++ b/drivers/gpio/gpio-tpic2810.c
@@ -98,8 +98,7 @@ static const struct of_device_id tpic2810_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, tpic2810_of_match_table);
 
-static int tpic2810_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int tpic2810_probe(struct i2c_client *client)
 {
 	struct tpic2810 *gpio;
 	int ret;
@@ -144,7 +143,7 @@ static struct i2c_driver tpic2810_driver = {
 		.name = "tpic2810",
 		.of_match_table = tpic2810_of_match_table,
 	},
-	.probe = tpic2810_probe,
+	.probe_new = tpic2810_probe,
 	.remove = tpic2810_remove,
 	.id_table = tpic2810_id_table,
 };
diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index 416725c26e94..43e8b66e04f7 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -136,8 +136,7 @@ static const struct of_device_id ts4900_gpio_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ts4900_gpio_of_match_table);
 
-static int ts4900_gpio_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ts4900_gpio_probe(struct i2c_client *client)
 {
 	struct ts4900_gpio_priv *priv;
 	u32 ngpio;
@@ -186,7 +185,7 @@ static struct i2c_driver ts4900_gpio_driver = {
 		.name = "ts4900-gpio",
 		.of_match_table = ts4900_gpio_of_match_table,
 	},
-	.probe = ts4900_gpio_probe,
+	.probe_new = ts4900_gpio_probe,
 	.id_table = ts4900_gpio_id_table,
 };
 module_i2c_driver(ts4900_gpio_driver);

base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.30.2

