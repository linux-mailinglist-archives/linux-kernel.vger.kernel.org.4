Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1B6F6706
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjEDIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjEDIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:46 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58353C14
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:10:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187822; x=1683195022; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=+imrWICyrYRPw++/MiGoDEqyC3wHCsqDOe2h8EEWLUM=;
 b=Z11OReiG0ZsNkglgX/To5y1Py0wgENgnhKf1re3w9fPGkhrsQ2oH3eqvgej/3vZU8wk4J1bK73yyVffZq645eG3LGRoHWQsR8QOtogl8r4mD/GvmA2ithTsKSe0OPCxkgY61bUZ6gDM6C9Yq6nacDNn1kzSdjr7cmk2hkUCbNClWzE99CaNdhew523O0i71i4hPPP8Jgk2UhYqCN1Z/gaaZ724H+ftwZnS3v0+VaBwlUzsjaEcMCYawzoPVQxGKo5mLvNr8p2cXD2Ws0ntfPLQJIkHTJVHXVWLASQePm7dKNE+cABe7kbOgEv4wP6LWa6O0Gvt4Pa9mDRaY5La7BBA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 43f335790acc with SMTP id
 645365f8dd415858cb91a107 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:59:52 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 10/11] hwmon: (core) Add missing beep-related standard attributes
Date:   Thu,  4 May 2023 00:57:51 -0700
Message-Id: <20230504075752.1320967-11-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

beep_enable, inY_beep, currY_beep, fanY_beep, and tempY_beep
are standard attributes mentioned in the sysfs interface
specification but not implemented in the hwmon core. Since
these are not deprecated, implement them.

Adding beep_mask is not necessary, as it is deprecated and
the drivers already using it are manually defining it.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/hwmon.c |  5 +++++
 include/linux/hwmon.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index cc140cf99290..7b611a073be4 100644
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
@@ -562,6 +566,7 @@ static const char * const hwmon_power_attr_templates[] = {
 	[hwmon_power_crit_alarm] = "power%d_crit_alarm",
 	[hwmon_power_rated_min] = "power%d_rated_min",
 	[hwmon_power_rated_max] = "power%d_rated_max",
+	[hwmon_curr_beep] = "power%d_beep",
 };
 
 static const char * const hwmon_energy_attr_templates[] = {
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index fe80e8e24b5a..496448a5f331 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -60,6 +60,7 @@ enum hwmon_chip_attributes {
 	hwmon_chip_in_samples,
 	hwmon_chip_power_samples,
 	hwmon_chip_temp_samples,
+	hwmon_chip_beep_enable,
 };
 
 #define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
@@ -74,6 +75,7 @@ enum hwmon_chip_attributes {
 #define HWMON_C_IN_SAMPLES		BIT(hwmon_chip_in_samples)
 #define HWMON_C_POWER_SAMPLES		BIT(hwmon_chip_power_samples)
 #define HWMON_C_TEMP_SAMPLES		BIT(hwmon_chip_temp_samples)
+#define HWMON_C_BEEP_ENABLE		BIT(hwmon_chip_beep_enable)
 
 enum hwmon_temp_attributes {
 	hwmon_temp_enable,
@@ -103,6 +105,7 @@ enum hwmon_temp_attributes {
 	hwmon_temp_reset_history,
 	hwmon_temp_rated_min,
 	hwmon_temp_rated_max,
+	hwmon_temp_beep,
 };
 
 #define HWMON_T_ENABLE		BIT(hwmon_temp_enable)
@@ -132,6 +135,7 @@ enum hwmon_temp_attributes {
 #define HWMON_T_RESET_HISTORY	BIT(hwmon_temp_reset_history)
 #define HWMON_T_RATED_MIN	BIT(hwmon_temp_rated_min)
 #define HWMON_T_RATED_MAX	BIT(hwmon_temp_rated_max)
+#define HWMON_T_BEEP		BIT(hwmon_temp_beep)
 
 enum hwmon_in_attributes {
 	hwmon_in_enable,
@@ -152,6 +156,7 @@ enum hwmon_in_attributes {
 	hwmon_in_crit_alarm,
 	hwmon_in_rated_min,
 	hwmon_in_rated_max,
+	hwmon_in_beep,
 };
 
 #define HWMON_I_ENABLE		BIT(hwmon_in_enable)
@@ -172,6 +177,7 @@ enum hwmon_in_attributes {
 #define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
 #define HWMON_I_RATED_MIN	BIT(hwmon_in_rated_min)
 #define HWMON_I_RATED_MAX	BIT(hwmon_in_rated_max)
+#define HWMON_I_BEEP		BIT(hwmon_in_beep)
 
 enum hwmon_curr_attributes {
 	hwmon_curr_enable,
@@ -192,6 +198,7 @@ enum hwmon_curr_attributes {
 	hwmon_curr_crit_alarm,
 	hwmon_curr_rated_min,
 	hwmon_curr_rated_max,
+	hwmon_curr_beep,
 };
 
 #define HWMON_C_ENABLE		BIT(hwmon_curr_enable)
@@ -212,6 +219,7 @@ enum hwmon_curr_attributes {
 #define HWMON_C_CRIT_ALARM	BIT(hwmon_curr_crit_alarm)
 #define HWMON_C_RATED_MIN	BIT(hwmon_curr_rated_min)
 #define HWMON_C_RATED_MAX	BIT(hwmon_curr_rated_max)
+#define HWMON_C_BEEP		BIT(hwmon_curr_beep)
 
 enum hwmon_power_attributes {
 	hwmon_power_enable,
@@ -328,6 +336,7 @@ enum hwmon_fan_attributes {
 	hwmon_fan_min_alarm,
 	hwmon_fan_max_alarm,
 	hwmon_fan_fault,
+	hwmon_fan_beep,
 };
 
 #define HWMON_F_ENABLE			BIT(hwmon_fan_enable)
@@ -342,6 +351,7 @@ enum hwmon_fan_attributes {
 #define HWMON_F_MIN_ALARM		BIT(hwmon_fan_min_alarm)
 #define HWMON_F_MAX_ALARM		BIT(hwmon_fan_max_alarm)
 #define HWMON_F_FAULT			BIT(hwmon_fan_fault)
+#define HWMON_F_BEEP			BIT(hwmon_fan_beep)
 
 enum hwmon_pwm_attributes {
 	hwmon_pwm_input,
-- 
2.34.1

