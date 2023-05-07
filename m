Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B86F9946
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjEGPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjEGPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:22:37 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98A1887A
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:22:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683472951; x=1683480151; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=JtCD7a2ohwxE6zrU/2xEaJh6Zoqff/FhUPQTLdec9mI=;
 b=AounJ9vHQ8JNltbfdKcnz/lrjbL0JOo1LKwrezskn+5wYsIac5sOLgr95V2DQLVMs4ZyhQGVl74yiMkgrKBK+5UFLLFKKnVfqpW7b3cpU1NLYey3PKLI9cl3H8x1zTB3AoXQG784ELUTsLg/2iDeeBNW8ZPxidjjmSFHv5eP9W0TDkdPo/mgY1bnlzvKmBAssvZWWWbuIW8Ia3zgsvKXYWRdAzgPTQ95IRKCetc0OCWN+L3cAErtjdUyHwERmC6IjvvELMfhy1zmRNhwKMbazY7kN8ZKH4OXJL0jlaLl+KFcI768/ABWiQgYYtLt3UUy/rtpQUX9Cau+2npc1Lm9fg==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 70825b0c4f46 with SMTP id
 6457c2375e23e5f95b11d541 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 07 May 2023 15:22:31 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (core) Add missing beep-related standard attributes
Date:   Sun,  7 May 2023 08:22:17 -0700
Message-Id: <20230507152216.1862653-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

beep_enable, inX_beep, currX_beep, fanX_beep, and tempX_beep
are standard attributes mentioned in the sysfs interface
specification but not implemented in the hwmon core. Since
these are not deprecated, implement them.

Adding beep_mask is not necessary, as it is deprecated and
the drivers already using it are manually defining it.

Signed-off-by: James Seo <james@equiv.tech>
---

Changes from RFC:
* Revised commit message
* Fixed misdefinition of fanX_beep attribute template

History:
RFC: https://lore.kernel.org/linux-hwmon/20230504075752.1320967-11-james@equiv.tech/

---
 drivers/hwmon/hwmon.c |  5 +++++
 include/linux/hwmon.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 5f205686065e..c7dd3f5b2bd5 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -456,6 +456,7 @@ static const char * const hwmon_chip_attrs[] = {
 	[hwmon_chip_in_samples] = "in_samples",
 	[hwmon_chip_power_samples] = "power_samples",
 	[hwmon_chip_temp_samples] = "temp_samples",
+	[hwmon_chip_beep_enable] = "beep_enable",
 };
 
 static const char * const hwmon_temp_attr_templates[] = {
@@ -486,6 +487,7 @@ static const char * const hwmon_temp_attr_templates[] = {
 	[hwmon_temp_reset_history] = "temp%d_reset_history",
 	[hwmon_temp_rated_min] = "temp%d_rated_min",
 	[hwmon_temp_rated_max] = "temp%d_rated_max",
+	[hwmon_temp_beep] = "temp%d_beep",
 };
 
 static const char * const hwmon_in_attr_templates[] = {
@@ -507,6 +509,7 @@ static const char * const hwmon_in_attr_templates[] = {
 	[hwmon_in_crit_alarm] = "in%d_crit_alarm",
 	[hwmon_in_rated_min] = "in%d_rated_min",
 	[hwmon_in_rated_max] = "in%d_rated_max",
+	[hwmon_in_beep] = "in%d_beep",
 };
 
 static const char * const hwmon_curr_attr_templates[] = {
@@ -528,6 +531,7 @@ static const char * const hwmon_curr_attr_templates[] = {
 	[hwmon_curr_crit_alarm] = "curr%d_crit_alarm",
 	[hwmon_curr_rated_min] = "curr%d_rated_min",
 	[hwmon_curr_rated_max] = "curr%d_rated_max",
+	[hwmon_curr_beep] = "curr%d_beep",
 };
 
 static const char * const hwmon_power_attr_templates[] = {
@@ -597,6 +601,7 @@ static const char * const hwmon_fan_attr_templates[] = {
 	[hwmon_fan_min_alarm] = "fan%d_min_alarm",
 	[hwmon_fan_max_alarm] = "fan%d_max_alarm",
 	[hwmon_fan_fault] = "fan%d_fault",
+	[hwmon_fan_beep] = "fan%d_beep",
 };
 
 static const char * const hwmon_pwm_attr_templates[] = {
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 492dd27a5dd8..8cd6a6b33593 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -44,6 +44,7 @@ enum hwmon_chip_attributes {
 	hwmon_chip_in_samples,
 	hwmon_chip_power_samples,
 	hwmon_chip_temp_samples,
+	hwmon_chip_beep_enable,
 };
 
 #define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
@@ -58,6 +59,7 @@ enum hwmon_chip_attributes {
 #define HWMON_C_IN_SAMPLES		BIT(hwmon_chip_in_samples)
 #define HWMON_C_POWER_SAMPLES		BIT(hwmon_chip_power_samples)
 #define HWMON_C_TEMP_SAMPLES		BIT(hwmon_chip_temp_samples)
+#define HWMON_C_BEEP_ENABLE		BIT(hwmon_chip_beep_enable)
 
 enum hwmon_temp_attributes {
 	hwmon_temp_enable,
@@ -87,6 +89,7 @@ enum hwmon_temp_attributes {
 	hwmon_temp_reset_history,
 	hwmon_temp_rated_min,
 	hwmon_temp_rated_max,
+	hwmon_temp_beep,
 };
 
 #define HWMON_T_ENABLE		BIT(hwmon_temp_enable)
@@ -116,6 +119,7 @@ enum hwmon_temp_attributes {
 #define HWMON_T_RESET_HISTORY	BIT(hwmon_temp_reset_history)
 #define HWMON_T_RATED_MIN	BIT(hwmon_temp_rated_min)
 #define HWMON_T_RATED_MAX	BIT(hwmon_temp_rated_max)
+#define HWMON_T_BEEP		BIT(hwmon_temp_beep)
 
 enum hwmon_in_attributes {
 	hwmon_in_enable,
@@ -136,6 +140,7 @@ enum hwmon_in_attributes {
 	hwmon_in_crit_alarm,
 	hwmon_in_rated_min,
 	hwmon_in_rated_max,
+	hwmon_in_beep,
 };
 
 #define HWMON_I_ENABLE		BIT(hwmon_in_enable)
@@ -156,6 +161,7 @@ enum hwmon_in_attributes {
 #define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
 #define HWMON_I_RATED_MIN	BIT(hwmon_in_rated_min)
 #define HWMON_I_RATED_MAX	BIT(hwmon_in_rated_max)
+#define HWMON_I_BEEP		BIT(hwmon_in_beep)
 
 enum hwmon_curr_attributes {
 	hwmon_curr_enable,
@@ -176,6 +182,7 @@ enum hwmon_curr_attributes {
 	hwmon_curr_crit_alarm,
 	hwmon_curr_rated_min,
 	hwmon_curr_rated_max,
+	hwmon_curr_beep,
 };
 
 #define HWMON_C_ENABLE		BIT(hwmon_curr_enable)
@@ -196,6 +203,7 @@ enum hwmon_curr_attributes {
 #define HWMON_C_CRIT_ALARM	BIT(hwmon_curr_crit_alarm)
 #define HWMON_C_RATED_MIN	BIT(hwmon_curr_rated_min)
 #define HWMON_C_RATED_MAX	BIT(hwmon_curr_rated_max)
+#define HWMON_C_BEEP		BIT(hwmon_curr_beep)
 
 enum hwmon_power_attributes {
 	hwmon_power_enable,
@@ -312,6 +320,7 @@ enum hwmon_fan_attributes {
 	hwmon_fan_min_alarm,
 	hwmon_fan_max_alarm,
 	hwmon_fan_fault,
+	hwmon_fan_beep,
 };
 
 #define HWMON_F_ENABLE			BIT(hwmon_fan_enable)
@@ -326,6 +335,7 @@ enum hwmon_fan_attributes {
 #define HWMON_F_MIN_ALARM		BIT(hwmon_fan_min_alarm)
 #define HWMON_F_MAX_ALARM		BIT(hwmon_fan_max_alarm)
 #define HWMON_F_FAULT			BIT(hwmon_fan_fault)
+#define HWMON_F_BEEP			BIT(hwmon_fan_beep)
 
 enum hwmon_pwm_attributes {
 	hwmon_pwm_input,
-- 
2.34.1

