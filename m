Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7216F67D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjEDIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjEDIzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:55:33 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27140E3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:55:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683190530; x=1683197730; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=ASc5HhJn/HU0yPFLW+gOwv9LjjchW0gxLnNsBeAyJh8=;
 b=OIS3Z6NcJe5zIYg4wzx7sCfPDttwy8Gu4MxE7VukHDj+zVYKztU0YqpUIZenyuhoKCKSmcJirey/Qyne8ZKBn053DUKVcyrmHNDj2qq6iOIXwkdH2aFW8RG2pTEPnJe/EwUQliRPMO00JGnD8gv3+FJDzDxU1ciRH2BdYwEbDgt7vyxwqR2EZcRyMuVWa9PoInzVAY54fTr+VRq/U7gL77mBLUIAtShRz4+X9vLMgIHefsn/PyOUtBJdNXqRJbmSZEpKL3kHwzAfdtIQAIi6j3N1reT6HS+oFxo2tv25WaajAK1jfz9pBtHA9amy3j0EKGjGE/SZVQPLSAg05W98aA==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by ffb17371f780 with SMTP id
 64536600621871856c3f65e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 08:00:00 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 11/11] ABI: sysfs-class-hwmon: Add missing hwmon standard attributes
Date:   Thu,  4 May 2023 00:57:52 -0700
Message-Id: <20230504075752.1320967-12-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definitions for the following non-deprecated standard
attributes implemented in the API and mentioned in the sysfs
interface spec but not found in the ABI documentation.

Alarm attributes:
* inY_alarm, inY_min_alarm, inY_max_alarm,
  inY_lcrit_alarm, inY_crit_alarm
* currY_alarm, currY_min_alarm, currY_max_alarm,
  currY_lcrit_alarm, currY_crit_alarm
* powerY_alarm, powerY_cap_alarm,
  powerY_max_alarm, powerY_crit_alarm
* fanY_alarm, fanY_min_alarm, fanY_max_alarm
* tempY_alarm, tempY_min_alarm, tempY_max_alarm,
  tempY_lcrit_alarm, tempY_emergency_alarm
  (tempY_crit_alarm already existed)

Beep attributes:
beep_enable, inY_beep, currY_beep, fanY_beep, tempY_beep

Sample average attributes:
samples, in_samples, power_samples, temp_samples, curr_samples

Fault attributes:
tempY_fault (fanY_fault already existed)

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 358 +++++++++++++++++++-
 1 file changed, 344 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 7fc914bc70e2..2f6884874812 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -33,6 +33,23 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/beep_enable
+Description:
+		Enable or disable beeps.
+
+		- 0: No beeps
+		- 1: Beeps
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/samples
+Description:
+		Samples in calculated average.
+
+		Applies to all types of channels.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/inY_min
 Description:
 		Voltage min value.
@@ -194,6 +211,76 @@ Description:
 
 		RO
 
+What:		/sys/class/hwmon/hwmonX/inY_alarm
+Description:
+		Voltage channel alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_min_alarm
+Description:
+		Voltage min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_max_alarm
+Description:
+		Voltage max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_lcrit_alarm
+Description:
+		Voltage critical min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_crit_alarm
+Description:
+		Voltage critical max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/inY_beep
+Description:
+		Voltage channel beep.
+
+		- 0: Disable
+		- 1: Enable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/in_samples
+Description:
+		Voltage samples in calculated average.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/fanY_min
 Description:
 		Fan minimum value.
@@ -283,6 +370,48 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/fanY_alarm
+Description:
+		Fan channel alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/fanY_min_alarm
+Description:
+		Fan min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/fanY_max_alarm
+Description:
+		Fan max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/fanY_beep
+Description:
+		Fan channel beep.
+
+		- 0: Disable
+		- 1: Enable
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/fanY_fault
 Description:
 		Fan channel fault indicator.
@@ -468,20 +597,6 @@ Description:
 
 		RW
 
-What:		/sys/class/hwmon/hwmonX/tempY_crit_alarm
-Description:
-		Temperature critical max alarm indicator.
-
-		Contrary to regular alarm flags which clear themselves
-		automatically when read, this one sticks until cleared by
-		the user. This is done by writing 0 to the file. Writing
-		other values is unsupported.
-
-		- 0: No alarm
-		- 1: Alarm
-
-		RW
-
 What:		/sys/class/hwmon/hwmonX/tempY_crit_hyst
 Description:
 		Temperature hysteresis value for critical limit.
@@ -645,6 +760,101 @@ Description:
 
 		RO
 
+What:		/sys/class/hwmon/hwmonX/tempY_alarm
+Description:
+		Temperature channel alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_min_alarm
+Description:
+		Temperature min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_max_alarm
+Description:
+		Temperature max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_lcrit_alarm
+Description:
+		Temperature critical min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_crit_alarm
+Description:
+		Temperature critical max alarm indicator.
+
+		Contrary to regular alarm flags which clear themselves
+		automatically when read, this one sticks until cleared by
+		the user. This is done by writing 0 to the file. Writing
+		other values is unsupported.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_emergency_alarm
+Description:
+		Temperature emergency max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/tempY_beep
+Description:
+		Temperature channel beep.
+
+		- 0: Disable
+		- 1: Enable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/tempY_fault
+Description:
+		Temperature channel fault indicator.
+
+		Indicates whether a temperature sensor has reported failure.
+
+		- 0: OK
+		- 1: Failed
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/temp_samples
+Description:
+		Temperature samples in calculated average.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/currY_max
 Description:
 		Current max value.
@@ -748,6 +958,76 @@ Description:
 
 		RO
 
+What:		/sys/class/hwmon/hwmonX/currY_alarm
+Description:
+		Current channel alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_min_alarm
+Description:
+		Current min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_max_alarm
+Description:
+		Current max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_lcrit_alarm
+Description:
+		Current critical min alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_crit_alarm
+Description:
+		Current critical max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/currY_beep
+Description:
+		Current channel beep.
+
+		- 0: Disable
+		- 1: Enable
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/curr_samples
+Description:
+		Current samples in calculated average.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/powerY_average
 Description:
 		Average power use.
@@ -950,6 +1230,56 @@ Description:
 
 		RO
 
+What:		/sys/class/hwmon/hwmonX/powerY_alarm
+Description:
+		Power channel alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_cap_alarm
+Description:
+		Power reduction alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_max_alarm
+Description:
+		Power max alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/powerY_crit_alarm
+Description:
+		Power critical reduction alarm indicator.
+
+		Clears itself when read.
+
+		- 0: No alarm
+		- 1: Alarm
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/power_samples
+Description:
+		Power samples in calculated average.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/energyY_input
 Description:
 		Cumulative energy use.
-- 
2.34.1

