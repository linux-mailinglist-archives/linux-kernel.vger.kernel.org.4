Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6037506FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjGLLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjGLLtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D842105
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31441dfbf97so7685288f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162498; x=1691754498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Saa7jbAnKv6/aFJ04VhkVrkgcqBc2X3n9e+eP71Ul0=;
        b=W+m1h90UlA3oYUb3/8IOQdifd8XsTo1zwO6iXBzuAoaxwGzw5vcpBqrzf70aBY14Z3
         duJX33JDVt/bOavIUTs14hm0hL8HTBzCAivTDyTYGV5f8qIQzdOFawuJzDpwVxsl2R18
         w1AOZy+OuASSwvB9M22iJnCs51ElmT65kQkvVOFK780opEQP7wDNYP9OWDDoit+CPM6f
         n2q5XJLkhuQYUgYYhvK8Mx45nZJ5BOOX5cKfUBfTXaqZYJUs4AXm97zbCoiCsgv9qUs9
         cBQSGEmYugaT7ki5ceYheZ4ZPeeBHRKJL/hsi6/dOmHDMQko3TK5L5ZpGScm/9S3np3D
         Ae0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162498; x=1691754498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Saa7jbAnKv6/aFJ04VhkVrkgcqBc2X3n9e+eP71Ul0=;
        b=FxkvfxqSubGOBEnPCf93/w9HNoexTS/HLP8iR/HDOIuinzUmhLYLKd3M4Btql07ITj
         7iF2OyJxYLYnO2DoPJbsd3lVG87MJgbzWGzc5MI+6F+LHrZcC8sUtDNdjZCOejyVLaSV
         qmIBuGRfKdu8/7oZyCzIwmzMENxVhOd2312yZzfZNhQjjDJprBGUOVaNR36AP2vTvzCW
         JujVQU+Bn2KzFYyVkK9DRCu3zBYoS6+pamWQQ4sWe+ny5A3IgtmfRfYOqX0ty3Kbd2l5
         KOYH315J5bpnx6L2YLclf/Bbb33WZF19YTojLXpEusTxhwrgxWR2ClvIXfmJrmMLoJBb
         4O3g==
X-Gm-Message-State: ABy/qLb67BYlN7RFTpTs8hv7WIfh/p0a/3FBeOF1Ao7bCQvgornEDcET
        GXdj2NIHT9qrWjEGJqNgRSjiog==
X-Google-Smtp-Source: APBJJlGTxLkm+W+9MJG5o9kxu8f/PALLlF4e4GVIaXopTy0Q6wputWK3KlVi68XyQAGwHQC9oZgiqQ==
X-Received: by 2002:a5d:5912:0:b0:314:c2a:31c5 with SMTP id v18-20020a5d5912000000b003140c2a31c5mr19304030wrd.19.1689162498000;
        Wed, 12 Jul 2023 04:48:18 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:17 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 4/8] hwmon: (pmbus/mp2975) Simplify VOUT code
Date:   Wed, 12 Jul 2023 13:47:45 +0200
Message-ID: <20230712114754.500477-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

In order to upstream MP2973/MP2971 simplify the code by removing support
for various VOUT formats. The MP2973 and MP2971 supports all PMBUS
supported formats for VOUT, while the MP2975 only support DIRECT and
VID for VOUT.

In DIRECT mode all chips report the voltage in 1mV/LSB.

Configure the chip to use DIRECT format for VOUT and drop the code
conversion code for other formats. The to be added chips MP2973/MP2971
will be configured to also report VOUT in DIRECT format.

The maximum voltage that can be reported in DIRECT format is 32768mV.
This is sufficient as the maximum output voltage for VR12/VR13 is
3040 mV.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 54 ++++++------------------------------
 1 file changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 04778f2dcbdb..ebc9a84b8ad3 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -70,7 +70,6 @@ struct mp2975_data {
 	int vref_off[MP2975_PAGE_NUM];
 	int vout_max[MP2975_PAGE_NUM];
 	int vout_ov_fixed[MP2975_PAGE_NUM];
-	int vout_format[MP2975_PAGE_NUM];
 	int curr_sense_gain[MP2975_PAGE_NUM];
 };
 
@@ -83,22 +82,6 @@ MODULE_DEVICE_TABLE(i2c, mp2975_id);
 
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
-static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	switch (reg) {
-	case PMBUS_VOUT_MODE:
-		/*
-		 * Enforce VOUT direct format, since device allows to set the
-		 * different formats for the different rails. Conversion from
-		 * VID to direct provided by driver internally, in case it is
-		 * necessary.
-		 */
-		return PB_VOUT_MODE_DIRECT;
-	default:
-		return -ENODATA;
-	}
-}
-
 static int
 mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
 			u16 mask)
@@ -273,24 +256,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
 		ret = DIV_ROUND_CLOSEST(data->vref[page] * 10 - 50 *
 					(ret + 1) * data->vout_scale, 10);
 		break;
-	case PMBUS_READ_VOUT:
-		ret = mp2975_read_word_helper(client, page, phase, reg,
-					      GENMASK(11, 0));
-		if (ret < 0)
-			return ret;
-
-		/*
-		 * READ_VOUT can be provided in VID or direct format. The
-		 * format type is specified by bit 15 of the register
-		 * MP2975_MFR_DC_LOOP_CTRL. The driver enforces VOUT direct
-		 * format, since device allows to set the different formats for
-		 * the different rails and also all VOUT limits registers are
-		 * provided in a direct format. In case format is VID - convert
-		 * to direct.
-		 */
-		if (data->vout_format[page] == vid)
-			ret = mp2975_vid2direct(info->vrm_version[page], ret);
-		break;
 	case PMBUS_VIRT_READ_POUT_MAX:
 		ret = mp2975_read_word_helper(client, page, phase,
 					      MP2975_MFR_READ_POUT_PK,
@@ -578,20 +543,18 @@ mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
 }
 
 static int
-mp2975_identify_vout_format(struct i2c_client *client,
-			    struct mp2975_data *data, int page)
+mp2975_set_vout_format(struct i2c_client *client,
+		       struct mp2975_data *data, int page)
 {
 	int ret;
 
 	ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
 	if (ret < 0)
 		return ret;
-
-	if (ret & MP2975_VOUT_FORMAT)
-		data->vout_format[page] = vid;
-	else
-		data->vout_format[page] = direct;
-	return 0;
+	/* Enable DIRECT VOUT format 1mV/LSB */
+	ret &= ~MP2975_VOUT_FORMAT;
+	ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
+	return ret;
 }
 
 static int
@@ -650,11 +613,11 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 			return ret;
 
 		/*
-		 * Get VOUT format for READ_VOUT command : VID or direct.
+		 * Set VOUT format for READ_VOUT command : direct.
 		 * Pages on same device can be configured with different
 		 * formats.
 		 */
-		ret = mp2975_identify_vout_format(client, data, i);
+		ret = mp2975_set_vout_format(client, data, i);
 		if (ret < 0)
 			return ret;
 
@@ -689,7 +652,6 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
-	.read_byte_data = mp2975_read_byte_data,
 	.read_word_data = mp2975_read_word_data,
 };
 
-- 
2.41.0

