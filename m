Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992725FC77D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJLOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJLOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:37:20 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 07:37:18 PDT
Received: from 4.mo575.mail-out.ovh.net (4.mo575.mail-out.ovh.net [46.105.59.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B16402D7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:37:18 -0700 (PDT)
Received: from player746.ha.ovh.net (unknown [10.110.208.22])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 87AE724FA6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:18:54 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player746.ha.ovh.net (Postfix) with ESMTPSA id 098612240642C;
        Wed, 12 Oct 2022 14:18:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G001fb4e0ef8-106b-41a5-ada3-e1102ea64411,
                    75377E6B882747309559AE06BD3DFEEF97A89409) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/extcon: use simple i2c probe
Date:   Wed, 12 Oct 2022 16:18:46 +0200
Message-Id: <20221012141846.3916480-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14757733032743241435
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppeduvdejrddtrddtrddupdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/extcon/extcon-fsa9480.c      | 5 ++---
 drivers/extcon/extcon-rt8973a.c      | 5 ++---
 drivers/extcon/extcon-usbc-tusb320.c | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index 7cff66c29907..e8b2671eb29b 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -257,8 +257,7 @@ static irqreturn_t fsa9480_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int fsa9480_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int fsa9480_probe(struct i2c_client *client)
 {
 	struct fsa9480_usbsw *info;
 	int ret;
@@ -370,7 +369,7 @@ static struct i2c_driver fsa9480_i2c_driver = {
 		.pm		= &fsa9480_pm_ops,
 		.of_match_table = fsa9480_of_match,
 	},
-	.probe			= fsa9480_probe,
+	.probe_new		= fsa9480_probe,
 	.id_table		= fsa9480_id,
 };
 
diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
index e6e448f6ea2f..afc9b405d103 100644
--- a/drivers/extcon/extcon-rt8973a.c
+++ b/drivers/extcon/extcon-rt8973a.c
@@ -548,8 +548,7 @@ static void rt8973a_init_dev_type(struct rt8973a_muic_info *info)
 	}
 }
 
-static int rt8973a_muic_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *id)
+static int rt8973a_muic_i2c_probe(struct i2c_client *i2c)
 {
 	struct device_node *np = i2c->dev.of_node;
 	struct rt8973a_muic_info *info;
@@ -696,7 +695,7 @@ static struct i2c_driver rt8973a_muic_i2c_driver = {
 		.pm	= &rt8973a_muic_pm_ops,
 		.of_match_table = rt8973a_dt_match,
 	},
-	.probe	= rt8973a_muic_i2c_probe,
+	.probe_new = rt8973a_muic_i2c_probe,
 	.remove	= rt8973a_muic_i2c_remove,
 	.id_table = rt8973a_i2c_id,
 };
diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 6ba3d89b106d..ca752ddf7763 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -230,8 +230,7 @@ static const struct regmap_config tusb320_regmap_config = {
 	.val_bits = 8,
 };
 
-static int tusb320_extcon_probe(struct i2c_client *client,
-				const struct i2c_device_id *id)
+static int tusb320_extcon_probe(struct i2c_client *client)
 {
 	struct tusb320_priv *priv;
 	const void *match_data;
@@ -313,7 +312,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
 MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
 
 static struct i2c_driver tusb320_extcon_driver = {
-	.probe		= tusb320_extcon_probe,
+	.probe_new	= tusb320_extcon_probe,
 	.driver		= {
 		.name	= "extcon-tusb320",
 		.of_match_table = tusb320_extcon_dt_match,

base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.30.2

