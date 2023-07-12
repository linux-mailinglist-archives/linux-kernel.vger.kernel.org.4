Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2707506FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjGLLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B62125
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so76681075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162500; x=1691754500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m4IVPTYTxIJ2eR766+zgp957YtC6bDJl8bkI+uTVV8=;
        b=Is2g4i5skUG49kdkkHXwd2e3VLaICw1hIfJk77v2uT4eDvV8Z1jzS0rUqhLDkssTa+
         hFz7Rn7KxTqUK9jyoQ5+z5MHuwHSEg5r+mvU1HNJt0OeOELGOA9Drk56NudU2IdutguM
         cD1hLP26YQhP333BvEznA7LZTHxzFTo8x+E3yMLe402lziFRFN07aYkmff0v3hVHirO9
         FLd1eanecuiR2f/If27oHbj8xSnr6F6TeLqW+KsRMw1oIJ0xRyl3xI5ASGArdPNArfyY
         XL/Rd1j4dS1dPz+BXT1NKaL/g5Arn3ONoR+43IjUA03ZMYoX10EbUzjvQshAYqFuqUmb
         xcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162500; x=1691754500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m4IVPTYTxIJ2eR766+zgp957YtC6bDJl8bkI+uTVV8=;
        b=it5sS2kMVPtcSoI3ICs6gtugJj21M2ZXv/MCDRPWUDSUaYb5N1A3j66mFId3V9H2Jd
         LdLlQKukPMBvm+Znz9sOvDedTvGlKnaGUV4NPJ17OW40r1QUdUijss6o5l/I51UGrRzM
         t7iF8Caj1Minkr41k+OHtnMXtyRG2ntaI4ts9caZhNJWlIrxVV+i5vt3YJT8Sopo7vOf
         asCD5BkBbhBdQgcWdutB/opVVY45/i9T33PU3Vr+UP6AOpDazjG4hxTMQ6z6QhR8kQaf
         ePBmwoPXL9drxPwc7/yZYEepjTDD4xjtWrcj9TnUubzQ4AGEkjHrIH6P4B5iFIslklKj
         7hOg==
X-Gm-Message-State: ABy/qLbe9/rNVzWOr9hgdNC5Rd5fEJw5hjFWtfhCjtpuuJrQQ9adjFJd
        zaQPXOMi0INo4+jnXCPDdTUHiw==
X-Google-Smtp-Source: APBJJlHnmFB8y5Lxpvwd8d28alwPAoMU94csjmAv3XTBS8rXkIk9rjB04Tq5weqEO/jsOxzGKBBXcg==
X-Received: by 2002:a5d:53d0:0:b0:311:110d:5573 with SMTP id a16-20020a5d53d0000000b00311110d5573mr19718372wrw.64.1689162500429;
        Wed, 12 Jul 2023 04:48:20 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:20 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 6/8] hwmon: (pmbus/mp2975) Add support for MP2971 and MP2973
Date:   Wed, 12 Jul 2023 13:47:47 +0200
Message-ID: <20230712114754.500477-6-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support for MP2971 and MP2973, the successor of MP2975.

The major differences are:
 - On MP2973 and MP2971 the Vref cannot be read and thus most of
   the OVP/current calculations won't work.
 - MP2973 and MP2971 also support LINEAR format for VOUT
 - MP2973 and MP2971 do not support OVP2
 - On MP2973 and MP2971 most registers are in LINEAR format
 - The IMVP9_EN bit has a different position
 - Per phase current sense haven't been implemented.

As on MP2975 most of the FAULT_LIMIT and WARN_LIMIT registers
have been redefined and doesn't provide the functionality as
defined in PMBUS spec.

Tested on MP2973 and MP2971.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 262 +++++++++++++++++++++++++++++------
 1 file changed, 221 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 13d8b95eb992..83242595ccbe 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -35,6 +35,8 @@
 #define MP2975_MFR_OVP_TH_SET		0xe5
 #define MP2975_MFR_UVP_SET		0xe6
 
+#define MP2973_MFR_RESO_SET		0xc7
+
 #define MP2975_VOUT_FORMAT		BIT(15)
 #define MP2975_VID_STEP_SEL_R1		BIT(4)
 #define MP2975_IMVP9_EN_R1		BIT(13)
@@ -49,8 +51,32 @@
 #define MP2975_SENSE_AMPL_HALF		2
 #define MP2975_VIN_UV_LIMIT_UNIT	8
 
+#define MP2973_VOUT_FORMAT_R1		GENMASK(7, 6)
+#define MP2973_VOUT_FORMAT_R2		GENMASK(4, 3)
+#define MP2973_VOUT_FORMAT_DIRECT_R1	BIT(7)
+#define MP2973_VOUT_FORMAT_LINEAR_R1	BIT(6)
+#define MP2973_VOUT_FORMAT_DIRECT_R2	BIT(4)
+#define MP2973_VOUT_FORMAT_LINEAR_R2	BIT(3)
+
+#define MP2973_MFR_VR_MULTI_CONFIG_R1	0x0d
+#define MP2973_MFR_VR_MULTI_CONFIG_R2	0x1d
+#define MP2973_VID_STEP_SEL_R1		BIT(4)
+#define MP2973_IMVP9_EN_R1		BIT(14)
+#define MP2973_VID_STEP_SEL_R2		BIT(3)
+#define MP2973_IMVP9_EN_R2		BIT(13)
+
+#define MP2973_MFR_READ_IOUT_PK		0x90
+#define MP2973_MFR_READ_POUT_PK		0x91
+
 #define MP2975_MAX_PHASE_RAIL1	8
 #define MP2975_MAX_PHASE_RAIL2	4
+
+#define MP2973_MAX_PHASE_RAIL1	14
+#define MP2973_MAX_PHASE_RAIL2	6
+
+#define MP2971_MAX_PHASE_RAIL1	8
+#define MP2971_MAX_PHASE_RAIL2	3
+
 #define MP2975_PAGE_NUM		2
 
 #define MP2975_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | \
@@ -58,11 +84,13 @@
 				 PMBUS_HAVE_POUT | PMBUS_PHASE_VIRTUAL)
 
 enum chips {
-	mp2975
+	mp2971, mp2973, mp2975
 };
 
 static const int mp2975_max_phases[][MP2975_PAGE_NUM] = {
 	[mp2975] = { MP2975_MAX_PHASE_RAIL1, MP2975_MAX_PHASE_RAIL2 },
+	[mp2973] = { MP2973_MAX_PHASE_RAIL1, MP2973_MAX_PHASE_RAIL2 },
+	[mp2971] = { MP2971_MAX_PHASE_RAIL1, MP2971_MAX_PHASE_RAIL2 },
 };
 
 struct mp2975_data {
@@ -79,6 +107,8 @@ struct mp2975_data {
 };
 
 static const struct i2c_device_id mp2975_id[] = {
+	{"mp2971", mp2971},
+	{"mp2973", mp2973},
 	{"mp2975", mp2975},
 	{}
 };
@@ -215,6 +245,76 @@ mp2975_read_phases(struct i2c_client *client, struct mp2975_data *data,
 	return ret;
 }
 
+static int mp2973_read_word_data(struct i2c_client *client, int page,
+				 int phase, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2975_data *data = to_mp2975_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_OT_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase, reg,
+					      GENMASK(7, 0));
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase, reg,
+					      GENMASK(7, 0));
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST(ret, MP2975_VIN_UV_LIMIT_UNIT);
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		/*
+		 * MP2971 and mp2973 only supports tracking (ovp1) mode.
+		 */
+		ret = mp2975_read_word_helper(client, page, phase,
+					      MP2975_MFR_OVP_TH_SET,
+					      GENMASK(2, 0));
+		if (ret < 0)
+			return ret;
+
+		ret = data->vout_max[page] + 50 * (ret + 1);
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase, reg,
+					      GENMASK(8, 0));
+		if (ret < 0)
+			return ret;
+		ret = mp2975_vid2direct(info->vrm_version[page], ret);
+		break;
+	case PMBUS_VIRT_READ_POUT_MAX:
+		ret = pmbus_read_word_data(client, page, phase,
+					   MP2973_MFR_READ_POUT_PK);
+		break;
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, page, phase,
+					   MP2973_MFR_READ_IOUT_PK);
+		break;
+	case PMBUS_UT_WARN_LIMIT:
+	case PMBUS_UT_FAULT_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+	case PMBUS_VOUT_OV_WARN_LIMIT:
+	case PMBUS_VIN_OV_WARN_LIMIT:
+	case PMBUS_IIN_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_LV_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_UC_FAULT_LIMIT:
+	case PMBUS_POUT_OP_FAULT_LIMIT:
+	case PMBUS_POUT_OP_WARN_LIMIT:
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		return -ENXIO;
+	default:
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
 static int mp2975_read_word_data(struct i2c_client *client, int page,
 				 int phase, int reg)
 {
@@ -386,7 +486,7 @@ mp2975_identify_multiphase(struct i2c_client *client, struct mp2975_data *data,
 }
 
 static int
-mp2975_identify_vid(struct i2c_client *client, struct mp2975_data *data,
+mp297x_identify_vid(struct i2c_client *client, struct mp2975_data *data,
 		    struct pmbus_driver_info *info, u32 reg, int page,
 		    u32 imvp_bit, u32 vr_bit)
 {
@@ -422,7 +522,7 @@ mp2975_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
 		return ret;
 
 	/* Identify VID mode for rail 1. */
-	ret = mp2975_identify_vid(client, data, info,
+	ret = mp297x_identify_vid(client, data, info,
 				  MP2975_MFR_VR_MULTI_CONFIG_R1, 0,
 				  MP2975_IMVP9_EN_R1, MP2975_VID_STEP_SEL_R1);
 	if (ret < 0)
@@ -430,10 +530,39 @@ mp2975_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
 
 	/* Identify VID mode for rail 2, if connected. */
 	if (info->phases[1])
-		ret = mp2975_identify_vid(client, data, info,
+		ret = mp297x_identify_vid(client, data, info,
 					  MP2975_MFR_VR_MULTI_CONFIG_R2, 1,
 					  MP2975_IMVP9_EN_R2,
 					  MP2975_VID_STEP_SEL_R2);
+
+	return ret;
+}
+
+static int
+mp2973_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
+			  struct pmbus_driver_info *info)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
+	if (ret < 0)
+		return ret;
+
+	/* Identify VID mode for rail 1. */
+	ret = mp297x_identify_vid(client, data, info,
+				  MP2973_MFR_VR_MULTI_CONFIG_R1, 0,
+				  MP2973_IMVP9_EN_R1, MP2973_VID_STEP_SEL_R1);
+
+	if (ret < 0)
+		return ret;
+
+	/* Identify VID mode for rail 2, if connected. */
+	if (info->phases[1])
+		ret = mp297x_identify_vid(client, data, info,
+					  MP2973_MFR_VR_MULTI_CONFIG_R2, 1,
+					  MP2973_IMVP9_EN_R2,
+					  MP2973_VID_STEP_SEL_R2);
+
 	return ret;
 }
 
@@ -532,7 +661,7 @@ mp2975_vref_offset_get(struct i2c_client *client, struct mp2975_data *data,
 }
 
 static int
-mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
+mp297x_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
 		    struct pmbus_driver_info *info, int page)
 {
 	int ret;
@@ -548,17 +677,33 @@ mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
 }
 
 static int
-mp2975_set_vout_format(struct i2c_client *client,
+mp297x_set_vout_format(struct i2c_client *client,
 		       struct mp2975_data *data, int page)
 {
 	int ret;
 
-	ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
-	if (ret < 0)
-		return ret;
 	/* Enable DIRECT VOUT format 1mV/LSB */
-	ret &= ~MP2975_VOUT_FORMAT;
-	ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
+	if (data->chip_id == mp2975) {
+		ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
+		if (ret < 0)
+			return ret;
+		ret &= ~MP2975_VOUT_FORMAT;
+		ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
+	} else {
+		ret = i2c_smbus_read_word_data(client, MP2973_MFR_RESO_SET);
+		if (ret < 0)
+			return ret;
+
+		if (page == 0) {
+			ret &= ~MP2973_VOUT_FORMAT_R1;
+			ret |= MP2973_VOUT_FORMAT_DIRECT_R1;
+		} else {
+			ret &= ~MP2973_VOUT_FORMAT_R2;
+			ret |= MP2973_VOUT_FORMAT_DIRECT_R2;
+		}
+
+		ret = i2c_smbus_write_word_data(client, MP2973_MFR_RESO_SET, ret);
+	}
 	return ret;
 }
 
@@ -605,24 +750,28 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 	for (i = 0; i < data->info.pages; i++) {
 		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
 		if (ret < 0)
-			return ret;
+			continue;
 
-		/* Obtain voltage reference offsets. */
-		ret = mp2975_vref_offset_get(client, data, i);
+		/*
+		 * Set VOUT format for READ_VOUT command : direct.
+		 * Pages on same device can be configured with different
+		 * formats.
+		 */
+		ret = mp297x_set_vout_format(client, data, i);
 		if (ret < 0)
 			return ret;
 
 		/* Obtain maximum voltage values. */
-		ret = mp2975_vout_max_get(client, data, info, i);
+		ret = mp297x_vout_max_get(client, data, info, i);
 		if (ret < 0)
 			return ret;
 
-		/*
-		 * Set VOUT format for READ_VOUT command : direct.
-		 * Pages on same device can be configured with different
-		 * formats.
-		 */
-		ret = mp2975_set_vout_format(client, data, i);
+		/* Skip if reading Vref is unsupported */
+		if (data->chip_id != mp2975)
+			continue;
+
+		/* Obtain voltage reference offsets. */
+		ret = mp2975_vref_offset_get(client, data, i);
 		if (ret < 0)
 			return ret;
 
@@ -660,6 +809,23 @@ static struct pmbus_driver_info mp2975_info = {
 	.read_word_data = mp2975_read_word_data,
 };
 
+static struct pmbus_driver_info mp2973_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
+		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
+	.read_word_data = mp2973_read_word_data,
+};
+
 static int mp2975_probe(struct i2c_client *client)
 {
 	struct pmbus_driver_info *info;
@@ -679,6 +845,11 @@ static int mp2975_probe(struct i2c_client *client)
 	memcpy(data->max_phases, mp2975_max_phases[data->chip_id],
 	       sizeof(data->max_phases));
 
+	if (data->chip_id == mp2975)
+		memcpy(&data->info, &mp2975_info, sizeof(*info));
+	else
+		memcpy(&data->info, &mp2973_info, sizeof(*info));
+
 	info = &data->info;
 
 	/* Identify multiphase configuration for rail 2. */
@@ -693,30 +864,37 @@ static int mp2975_probe(struct i2c_client *client)
 		data->info.func[1] = MP2975_RAIL2_FUNC;
 	}
 
-	/* Identify multiphase configuration. */
-	ret = mp2975_identify_multiphase(client, data, info);
-	if (ret)
-		return ret;
+	if (data->chip_id == mp2975) {
+		/* Identify multiphase configuration. */
+		ret = mp2975_identify_multiphase(client, data, info);
+		if (ret)
+			return ret;
 
-	/* Identify VID setting per rail. */
-	ret = mp2975_identify_rails_vid(client, data, info);
-	if (ret < 0)
-		return ret;
+		/* Identify VID setting per rail. */
+		ret = mp2975_identify_rails_vid(client, data, info);
+		if (ret < 0)
+			return ret;
 
-	/* Obtain current sense gain of power stage. */
-	ret = mp2975_current_sense_gain_get(client, data);
-	if (ret)
-		return ret;
+		/* Obtain current sense gain of power stage. */
+		ret = mp2975_current_sense_gain_get(client, data);
+		if (ret)
+			return ret;
 
-	/* Obtain voltage reference values. */
-	ret = mp2975_vref_get(client, data, info);
-	if (ret)
-		return ret;
+		/* Obtain voltage reference values. */
+		ret = mp2975_vref_get(client, data, info);
+		if (ret)
+			return ret;
 
-	/* Obtain vout over-voltage scales. */
-	ret = mp2975_vout_ov_scale_get(client, data, info);
-	if (ret < 0)
-		return ret;
+		/* Obtain vout over-voltage scales. */
+		ret = mp2975_vout_ov_scale_get(client, data, info);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Identify VID setting per rail. */
+		ret = mp2973_identify_rails_vid(client, data, info);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Obtain offsets, maximum and format for vout. */
 	ret = mp2975_vout_per_rail_config_get(client, data, info);
@@ -727,6 +905,8 @@ static int mp2975_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id __maybe_unused mp2975_of_match[] = {
+	{.compatible = "mps,mp2971", .data = (void *)mp2971},
+	{.compatible = "mps,mp2973", .data = (void *)mp2973},
 	{.compatible = "mps,mp2975", .data = (void *)mp2975},
 	{}
 };
-- 
2.41.0

