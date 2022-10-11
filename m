Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805AE5FB593
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJKOze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJKOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:54:34 -0400
X-Greylist: delayed 1077 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 07:51:39 PDT
Received: from 5.mo575.mail-out.ovh.net (5.mo575.mail-out.ovh.net [46.105.62.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE899B86F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:51:39 -0700 (PDT)
Received: from player755.ha.ovh.net (unknown [10.108.1.153])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id D498B23D6C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:33:40 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 0488D2FA536CD;
        Tue, 11 Oct 2022 14:33:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S004cf6abaae-65cc-4a2d-b9a2-0791702198c8,
                    1484D649C3824875A5D1A4DE507C75CAB639AB48) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Kitt <steve@sk2.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hwmon: use simple i2c probe
Date:   Tue, 11 Oct 2022 16:33:08 +0200
Message-Id: <20221011143309.3141267-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9134425945843074779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppeduvdejrddtrddtrddupdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/hwmon/aht10.c      | 5 ++---
 drivers/hwmon/emc2305.c    | 4 ++--
 drivers/hwmon/ltc2992.c    | 4 ++--
 drivers/hwmon/max127.c     | 5 ++---
 drivers/hwmon/sbrmi.c      | 5 ++---
 drivers/hwmon/sbtsi_temp.c | 5 ++---
 drivers/hwmon/sht4x.c      | 5 ++---
 7 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/aht10.c b/drivers/hwmon/aht10.c
index 2d9770cb4401..d76f3441ecf1 100644
--- a/drivers/hwmon/aht10.c
+++ b/drivers/hwmon/aht10.c
@@ -289,8 +289,7 @@ static const struct hwmon_chip_info aht10_chip_info = {
 	.info = aht10_info,
 };
 
-static int aht10_probe(struct i2c_client *client,
-		       const struct i2c_device_id *aht10_id)
+static int aht10_probe(struct i2c_client *client)
 {
 	struct device *device = &client->dev;
 	struct device *hwmon_dev;
@@ -336,7 +335,7 @@ static struct i2c_driver aht10_driver = {
 	.driver = {
 		.name = "aht10",
 	},
-	.probe      = aht10_probe,
+	.probe_new  = aht10_probe,
 	.id_table   = aht10_id,
 };
 
diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index aa1f25add0b6..f222fcf3b6aa 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -518,7 +518,7 @@ static int emc2305_identify(struct device *dev)
 	return 0;
 }
 
-static int emc2305_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int emc2305_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
@@ -607,7 +607,7 @@ static struct i2c_driver emc2305_driver = {
 	.driver = {
 		.name = "emc2305",
 	},
-	.probe    = emc2305_probe,
+	.probe_new = emc2305_probe,
 	.remove	  = emc2305_remove,
 	.id_table = emc2305_ids,
 	.address_list = emc2305_normal_i2c,
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 72489d5d7eaf..88514152d930 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -881,7 +881,7 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
 	return 0;
 }
 
-static int ltc2992_i2c_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int ltc2992_i2c_probe(struct i2c_client *client)
 {
 	struct device *hwmon_dev;
 	struct ltc2992_state *st;
@@ -927,7 +927,7 @@ static struct i2c_driver ltc2992_i2c_driver = {
 		.name = "ltc2992",
 		.of_match_table = ltc2992_of_match,
 	},
-	.probe    = ltc2992_i2c_probe,
+	.probe_new = ltc2992_i2c_probe,
 	.id_table = ltc2992_i2c_id,
 };
 
diff --git a/drivers/hwmon/max127.c b/drivers/hwmon/max127.c
index 402ffdc2f425..0e21e7e6bbd2 100644
--- a/drivers/hwmon/max127.c
+++ b/drivers/hwmon/max127.c
@@ -303,8 +303,7 @@ static const struct hwmon_chip_info max127_chip_info = {
 	.info = max127_info,
 };
 
-static int max127_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int max127_probe(struct i2c_client *client)
 {
 	int i;
 	struct device *hwmon_dev;
@@ -340,7 +339,7 @@ static struct i2c_driver max127_driver = {
 	.driver = {
 		.name	= "max127",
 	},
-	.probe		= max127_probe,
+	.probe_new	= max127_probe,
 	.id_table	= max127_id,
 };
 
diff --git a/drivers/hwmon/sbrmi.c b/drivers/hwmon/sbrmi.c
index 7bf0c3fba75f..8ea5a4d3219f 100644
--- a/drivers/hwmon/sbrmi.c
+++ b/drivers/hwmon/sbrmi.c
@@ -297,8 +297,7 @@ static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 	return ret;
 }
 
-static int sbrmi_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id)
+static int sbrmi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
@@ -348,7 +347,7 @@ static struct i2c_driver sbrmi_driver = {
 		.name = "sbrmi",
 		.of_match_table = of_match_ptr(sbrmi_of_match),
 	},
-	.probe = sbrmi_probe,
+	.probe_new = sbrmi_probe,
 	.id_table = sbrmi_id,
 };
 
diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index e35357c48b8e..4c37de846f93 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -199,8 +199,7 @@ static const struct hwmon_chip_info sbtsi_chip_info = {
 	.info = sbtsi_info,
 };
 
-static int sbtsi_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id)
+static int sbtsi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
@@ -239,7 +238,7 @@ static struct i2c_driver sbtsi_driver = {
 		.name = "sbtsi",
 		.of_match_table = of_match_ptr(sbtsi_of_match),
 	},
-	.probe = sbtsi_probe,
+	.probe_new = sbtsi_probe,
 	.id_table = sbtsi_id,
 };
 
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index 13ac2d8f22c7..13e042927bf8 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -232,8 +232,7 @@ static const struct hwmon_chip_info sht4x_chip_info = {
 	.info = sht4x_info,
 };
 
-static int sht4x_probe(struct i2c_client *client,
-		       const struct i2c_device_id *sht4x_id)
+static int sht4x_probe(struct i2c_client *client)
 {
 	struct device *device = &client->dev;
 	struct device *hwmon_dev;
@@ -292,7 +291,7 @@ static struct i2c_driver sht4x_driver = {
 		.name = "sht4x",
 		.of_match_table = sht4x_of_match,
 	},
-	.probe		= sht4x_probe,
+	.probe_new	= sht4x_probe,
 	.id_table	= sht4x_id,
 };
 

base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.30.2

