Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1826F5FCBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJLUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJLUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:10:51 -0400
X-Greylist: delayed 4198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 13:10:50 PDT
Received: from 15.mo561.mail-out.ovh.net (15.mo561.mail-out.ovh.net [87.98.150.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341EA8322A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:10:49 -0700 (PDT)
Received: from player696.ha.ovh.net (unknown [10.111.172.45])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 47F5F25243
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:33:19 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 68B922573F8DE;
        Wed, 12 Oct 2022 16:33:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004926c2626-9614-4700-a3bb-23ab756441d8,
                    75377E6B882747309559AE06BD3DFEEF97A89409) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Kitt <steve@sk2.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] drivers/hid: use simple i2c probe
Date:   Wed, 12 Oct 2022 18:33:00 +0200
Message-Id: <20221012163300.3928075-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17027828717298353769
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkphepuddvjedrtddrtddruddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
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
 drivers/hid/i2c-hid/i2c-hid-of-elan.c   | 5 ++---
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 5 ++---
 drivers/hid/i2c-hid/i2c-hid-of.c        | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 2d991325e734..76ddc8be1cbb 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -68,8 +68,7 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 	regulator_disable(ihid_elan->vcc33);
 }
 
-static int i2c_hid_of_elan_probe(struct i2c_client *client,
-				 const struct i2c_device_id *id)
+static int i2c_hid_of_elan_probe(struct i2c_client *client)
 {
 	struct i2c_hid_of_elan *ihid_elan;
 
@@ -119,7 +118,7 @@ static struct i2c_driver elan_i2c_hid_ts_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(elan_i2c_hid_of_match),
 	},
-	.probe		= i2c_hid_of_elan_probe,
+	.probe_new	= i2c_hid_of_elan_probe,
 	.remove		= i2c_hid_core_remove,
 	.shutdown	= i2c_hid_core_shutdown,
 };
diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index ec6c73f75ffe..29c6cb174032 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -87,8 +87,7 @@ static int ihid_goodix_vdd_notify(struct notifier_block *nb,
 	return ret;
 }
 
-static int i2c_hid_of_goodix_probe(struct i2c_client *client,
-				   const struct i2c_device_id *id)
+static int i2c_hid_of_goodix_probe(struct i2c_client *client)
 {
 	struct i2c_hid_of_goodix *ihid_goodix;
 	int ret;
@@ -167,7 +166,7 @@ static struct i2c_driver goodix_i2c_hid_ts_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(goodix_i2c_hid_of_match),
 	},
-	.probe		= i2c_hid_of_goodix_probe,
+	.probe_new	= i2c_hid_of_goodix_probe,
 	.remove		= i2c_hid_core_remove,
 	.shutdown	= i2c_hid_core_shutdown,
 };
diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 97a27a803f58..10176568133a 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -66,8 +66,7 @@ static void i2c_hid_of_power_down(struct i2chid_ops *ops)
 			       ihid_of->supplies);
 }
 
-static int i2c_hid_of_probe(struct i2c_client *client,
-			    const struct i2c_device_id *dev_id)
+static int i2c_hid_of_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct i2c_hid_of *ihid_of;
@@ -138,7 +137,7 @@ static struct i2c_driver i2c_hid_of_driver = {
 		.of_match_table = of_match_ptr(i2c_hid_of_match),
 	},
 
-	.probe		= i2c_hid_of_probe,
+	.probe_new	= i2c_hid_of_probe,
 	.remove		= i2c_hid_core_remove,
 	.shutdown	= i2c_hid_core_shutdown,
 	.id_table	= i2c_hid_of_id_table,

base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.30.2

