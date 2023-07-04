Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20874728D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjGDNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjGDNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218510F5;
        Tue,  4 Jul 2023 06:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEB861259;
        Tue,  4 Jul 2023 13:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A639AC433C7;
        Tue,  4 Jul 2023 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688476662;
        bh=9vUu33erJrLKcQGqMGFnvE8WQvh13xozOrZ4w+HY/xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMkozYtK84+lmlgpbelApGQ2e9158q3VW5g6YbjU2H9bkeVi2unsT+vKksWV6gGRs
         qwY+HAnOz8ysLFA2ykcZl4sUO41XWUKujKVZBaQ6Kkj8DjnTaBmw3zgi/w6nNxiVZM
         YhSms/ySgKUNcglef9czFRC0Y2oAz7Q8zdhmb14Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-hwmon@vger.kernel.org
Cc:     linux@roeck-us.net, samsagax@gmail.com,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
Date:   Tue,  4 Jul 2023 14:17:17 +0100
Message-ID: <20230704131715.44454-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704131715.44454-5-gregkh@linuxfoundation.org>
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033; i=gregkh@linuxfoundation.org; h=from:subject; bh=9vUu33erJrLKcQGqMGFnvE8WQvh13xozOrZ4w+HY/xI=; b=owGbwMvMwCRo6H6F97bub03G02pJDClLpO9JLeFbElY84UbQEw37ayfvfYs/X1Htn/5WVXMNa 3MBz/1LHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRv+kM80xt5s5yC9svxt5S /tzk1cX04sLPDxnmqT1Re+wmMlfw54nCxVMOK0jsWJCoBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should not have a single static variable for the type of device
they are bound to.  While this driver is really going to only have one
device at a time in the system, remove the static variable and instead,
look up the device type when needed.

Cc: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/oxp-sensors.c | 47 ++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index e1a907cae820..3bcba0c476c4 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -48,10 +48,9 @@ enum oxp_board {
 	oxp_mini_amd,
 	oxp_mini_amd_a07,
 	oxp_mini_amd_pro,
+	UNKNOWN,
 };
 
-static enum oxp_board board;
-
 /* Fan reading and PWM */
 #define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
 #define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
@@ -136,6 +135,24 @@ static const struct dmi_system_id dmi_table[] = {
 	{},
 };
 
+static enum oxp_board get_board_type(void)
+{
+	const struct dmi_system_id *dmi_entry;
+
+	/*
+	 * Have to check for AMD processor here because DMI strings are the
+	 * same between Intel and AMD boards, the only way to tell them apart
+	 * is the CPU.
+	 * Intel boards seem to have different EC registers and values to
+	 * read/write.
+	 */
+	dmi_entry = dmi_first_match(dmi_table);
+	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return UNKNOWN;
+
+	return (enum oxp_board)(unsigned long)dmi_entry->driver_data;
+}
+
 /* Helper functions to handle EC read/write */
 static int read_from_ec(u8 reg, int size, long *val)
 {
@@ -182,7 +199,7 @@ static int tt_toggle_enable(void)
 	u8 reg;
 	u8 val;
 
-	switch (board) {
+	switch (get_board_type()) {
 	case oxp_mini_amd_a07:
 		reg = OXP_OLD_TURBO_SWITCH_REG;
 		val = OXP_OLD_TURBO_TAKE_VAL;
@@ -203,7 +220,7 @@ static int tt_toggle_disable(void)
 	u8 reg;
 	u8 val;
 
-	switch (board) {
+	switch (get_board_type()) {
 	case oxp_mini_amd_a07:
 		reg = OXP_OLD_TURBO_SWITCH_REG;
 		val = OXP_OLD_TURBO_RETURN_VAL;
@@ -249,7 +266,7 @@ static ssize_t tt_toggle_show(struct device *dev,
 	u8 reg;
 	long val;
 
-	switch (board) {
+	switch (get_board_type()) {
 	case oxp_mini_amd_a07:
 		reg = OXP_OLD_TURBO_SWITCH_REG;
 		break;
@@ -315,7 +332,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
 			if (ret)
 				return ret;
-			switch (board) {
+			switch (get_board_type()) {
 			case aya_neo_2:
 			case aya_neo_air:
 			case aya_neo_air_pro:
@@ -357,7 +374,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			if (val < 0 || val > 255)
 				return -EINVAL;
-			switch (board) {
+			switch (get_board_type()) {
 			case aya_neo_2:
 			case aya_neo_air:
 			case aya_neo_air_pro:
@@ -412,25 +429,11 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
 /* Initialization logic */
 static int oxp_platform_probe(struct platform_device *pdev)
 {
-	const struct dmi_system_id *dmi_entry;
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
 	int ret;
 
-	/*
-	 * Have to check for AMD processor here because DMI strings are the
-	 * same between Intel and AMD boards, the only way to tell them apart
-	 * is the CPU.
-	 * Intel boards seem to have different EC registers and values to
-	 * read/write.
-	 */
-	dmi_entry = dmi_first_match(dmi_table);
-	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
-		return -ENODEV;
-
-	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
-
-	switch (board) {
+	switch (get_board_type()) {
 	case aok_zoe_a1:
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
-- 
2.41.0

