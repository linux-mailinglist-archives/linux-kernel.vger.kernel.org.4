Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BD1637A36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKXNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKXNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:47:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00BA106136
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:47:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DE481F74A;
        Thu, 24 Nov 2022 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669297630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u8LB/DQnqDL27uZg7uaQmSyTXaWbhXNtNg3l7WnNVrs=;
        b=N+O/NpmW4K8Q18nfdtAUH67dYPU+KXd5yAgCzkaZ3NDihPZWKDdjRBUWpz/9Ys1DshvFfr
        gM+qFkzvyFCu4UbH9S7IAw46R0e371yqRs9CHAkoTkknB6eJM+IGzyGj43iyFRZtXyqVPJ
        8qPYfyTk0aPCf/Qw6OOpzV2jK0HFqrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669297630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u8LB/DQnqDL27uZg7uaQmSyTXaWbhXNtNg3l7WnNVrs=;
        b=ng4mIXcT3yjNj1SSV2i+ckEGsloyS55mjXB4fP7Gerrquh56Ifr/7N3Wq+v0Sa+A1tfI6Z
        U8VW3eGYtgpumuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F31513B4F;
        Thu, 24 Nov 2022 13:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UW4HAt51f2OrMQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 24 Nov 2022 13:47:10 +0000
Date:   Thu, 24 Nov 2022 14:47:08 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] regulator: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221124144708.64371b98@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

As a minor optimization, this also lets us drop several occurrences of
of_match_ptr(), __maybe_unused and some ifdef guarding, as we now know
what all of this will resolve to, we might as well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/regulator/Kconfig             |   10 +++++-----
 drivers/regulator/fan53880.c          |   16 +++++++---------
 drivers/regulator/mp886x.c            |    2 +-
 drivers/regulator/sy8106a-regulator.c |    4 ++--
 drivers/regulator/sy8824x.c           |    2 +-
 drivers/regulator/sy8827n.c           |    4 +---
 6 files changed, 17 insertions(+), 21 deletions(-)

--- linux-6.0.orig/drivers/regulator/Kconfig
+++ linux-6.0/drivers/regulator/Kconfig
@@ -377,7 +377,7 @@ config REGULATOR_FAN53555
 
 config REGULATOR_FAN53880
 	tristate "Fairchild FAN53880 Regulator"
-	depends on I2C && (OF || COMPILE_TEST)
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  This driver supports Fairchild (ON Semiconductor) FAN53880
@@ -743,7 +743,7 @@ config REGULATOR_MP8859
 
 config REGULATOR_MP886X
 	tristate "MPS MP8869 regulator driver"
-	depends on I2C && (OF || COMPILE_TEST)
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  This driver supports the MP8869 voltage regulator.
@@ -1269,21 +1269,21 @@ config REGULATOR_SY7636A
 
 config REGULATOR_SY8106A
 	tristate "Silergy SY8106A regulator"
-	depends on I2C && (OF || COMPILE_TEST)
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  This driver supports SY8106A single output regulator.
 
 config REGULATOR_SY8824X
 	tristate "Silergy SY8824C/SY8824E regulator"
-	depends on I2C && (OF || COMPILE_TEST)
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  This driver supports SY8824C single output regulator.
 
 config REGULATOR_SY8827N
 	tristate "Silergy SY8827N regulator"
-	depends on I2C && (OF || COMPILE_TEST)
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  This driver supports SY8827N single output regulator.
--- linux-6.0.orig/drivers/regulator/fan53880.c
+++ linux-6.0/drivers/regulator/fan53880.c
@@ -42,8 +42,8 @@ static const struct regulator_ops fan538
 #define FAN53880_LDO(_num, _supply, _default)				\
 	[FAN53880_LDO ## _num] = {					\
 		.name =		   "LDO"#_num,				\
-		.of_match =	   of_match_ptr("LDO"#_num),		\
-		.regulators_node = of_match_ptr("regulators"),		\
+		.of_match =	   "LDO"#_num,		\
+		.regulators_node = "regulators",		\
 		.type =		   REGULATOR_VOLTAGE,			\
 		.owner =	   THIS_MODULE,				\
 		.linear_ranges =   (struct linear_range[]) {		\
@@ -68,8 +68,8 @@ static const struct regulator_desc fan53
 	FAN53880_LDO(4, "VIN4", 1800000),
 	[FAN53880_BUCK] = {
 		.name =		   "BUCK",
-		.of_match =	   of_match_ptr("BUCK"),
-		.regulators_node = of_match_ptr("regulators"),
+		.of_match =	   "BUCK",
+		.regulators_node = "regulators",
 		.type =		   REGULATOR_VOLTAGE,
 		.owner =	   THIS_MODULE,
 		.linear_ranges =   (struct linear_range[]) {
@@ -88,8 +88,8 @@ static const struct regulator_desc fan53
 	},
 	[FAN53880_BOOST] = {
 		.name =		   "BOOST",
-		.of_match =	   of_match_ptr("BOOST"),
-		.regulators_node = of_match_ptr("regulators"),
+		.of_match =	   "BOOST",
+		.regulators_node = "regulators",
 		.type =		   REGULATOR_VOLTAGE,
 		.owner =	   THIS_MODULE,
 		.linear_ranges =   (struct linear_range[]) {
@@ -157,13 +157,11 @@ static int fan53880_i2c_probe(struct i2c
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id fan53880_dt_ids[] = {
 	{ .compatible = "onnn,fan53880", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fan53880_dt_ids);
-#endif
 
 static const struct i2c_device_id fan53880_i2c_id[] = {
 	{ "fan53880", },
@@ -174,7 +172,7 @@ MODULE_DEVICE_TABLE(i2c, fan53880_i2c_id
 static struct i2c_driver fan53880_regulator_driver = {
 	.driver = {
 		.name = "fan53880",
-		.of_match_table	= of_match_ptr(fan53880_dt_ids),
+		.of_match_table	= fan53880_dt_ids,
 	},
 	.probe_new = fan53880_i2c_probe,
 	.id_table = fan53880_i2c_id,
--- linux-6.0.orig/drivers/regulator/mp886x.c
+++ linux-6.0/drivers/regulator/mp886x.c
@@ -362,7 +362,7 @@ MODULE_DEVICE_TABLE(i2c, mp886x_id);
 static struct i2c_driver mp886x_regulator_driver = {
 	.driver = {
 		.name = "mp886x-regulator",
-		.of_match_table = of_match_ptr(mp886x_dt_ids),
+		.of_match_table = mp886x_dt_ids,
 	},
 	.probe_new = mp886x_i2c_probe,
 	.id_table = mp886x_id,
--- linux-6.0.orig/drivers/regulator/sy8106a-regulator.c
+++ linux-6.0/drivers/regulator/sy8106a-regulator.c
@@ -123,7 +123,7 @@ static int sy8106a_i2c_probe(struct i2c_
 	return 0;
 }
 
-static const struct of_device_id __maybe_unused sy8106a_i2c_of_match[] = {
+static const struct of_device_id sy8106a_i2c_of_match[] = {
 	{ .compatible = "silergy,sy8106a" },
 	{ },
 };
@@ -138,7 +138,7 @@ MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id)
 static struct i2c_driver sy8106a_regulator_driver = {
 	.driver = {
 		.name = "sy8106a",
-		.of_match_table	= of_match_ptr(sy8106a_i2c_of_match),
+		.of_match_table	= sy8106a_i2c_of_match,
 	},
 	.probe_new = sy8106a_i2c_probe,
 	.id_table = sy8106a_i2c_id,
--- linux-6.0.orig/drivers/regulator/sy8824x.c
+++ linux-6.0/drivers/regulator/sy8824x.c
@@ -233,7 +233,7 @@ MODULE_DEVICE_TABLE(i2c, sy8824_id);
 static struct i2c_driver sy8824_regulator_driver = {
 	.driver = {
 		.name = "sy8824-regulator",
-		.of_match_table = of_match_ptr(sy8824_dt_ids),
+		.of_match_table = sy8824_dt_ids,
 	},
 	.probe_new = sy8824_i2c_probe,
 	.id_table = sy8824_id,
--- linux-6.0.orig/drivers/regulator/sy8827n.c
+++ linux-6.0/drivers/regulator/sy8827n.c
@@ -170,7 +170,6 @@ static int sy8827n_i2c_probe(struct i2c_
 	return ret;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id sy8827n_dt_ids[] = {
 	{
 		.compatible = "silergy,sy8827n",
@@ -178,7 +177,6 @@ static const struct of_device_id sy8827n
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8827n_dt_ids);
-#endif
 
 static const struct i2c_device_id sy8827n_id[] = {
 	{ "sy8827n", },
@@ -189,7 +187,7 @@ MODULE_DEVICE_TABLE(i2c, sy8827n_id);
 static struct i2c_driver sy8827n_regulator_driver = {
 	.driver = {
 		.name = "sy8827n-regulator",
-		.of_match_table = of_match_ptr(sy8827n_dt_ids),
+		.of_match_table = sy8827n_dt_ids,
 	},
 	.probe_new = sy8827n_i2c_probe,
 	.id_table = sy8827n_id,


-- 
Jean Delvare
SUSE L3 Support
