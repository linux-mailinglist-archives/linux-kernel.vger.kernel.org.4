Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118962F003
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiKRIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiKRIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:47:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60106273E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:46:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j15so7522477wrq.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3amH7rJnvrs/QaT/Rqb0QDnOSfc+s7uS/cghl6emmVE=;
        b=CglC4XKerFt+XpCsRxGzQDfDhCRu9S4POpBLAHkc/i3X78+jF3ymvE/0LfYF1JbfxU
         0kPlFg1p+lTWUDyw0yjTzCuzhOlxbZ7dWcdyb3tlSnsiwX/vmtW14j+I8J3KRgDnQCdh
         8UL1gDwQeTCdTMLqj9a2NQA28esLTemjtbcTIEQW9jfTDQvVN8IyAgXDttDdJDIwkLub
         bBrAtmCCnwb7yfIs1/Np3dWzvi9VfMjh4qOFfdMVfmIrX8bf4HvSs1d7JHx9PsEf2I4E
         HutOd22xHFFcErVfveY5ZoW4fX03PxUNkigJ7ihmWzP7lNT9v/+1Y8BOVyjkc5K5bqpg
         c7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3amH7rJnvrs/QaT/Rqb0QDnOSfc+s7uS/cghl6emmVE=;
        b=jHXPZuNLgOOrA42dFFAwp/2wtqLzGWsXPdqv1E8Q+Ty7i2BfPkSXI1OkVqfYgW+HQg
         gah1A12S/9i9bg7Vjc+HZGW31kDDe+5hK7WPoh6T5Z32/k885vLAngOmSXtfMDtdfkwI
         VIBHCeW5zaO+156xakJDW/gp/GRUM7r07dP257y/ColAdPu2O9WSbYwqH8TXivX6Gklw
         vun15e0B5PhwicBOYHr0zam7pixsIg/nkVT6+4zlm+BQLfSinWFFkn3bcxoindCK8SqB
         RMTndIWF3t2wsTOXP13AX/00FyXLWmTvrqO1dbS5XXYNPWj8hsDNXcHizq9y7ZwDrIeU
         s59g==
X-Gm-Message-State: ANoB5pnFb9pxxMISXJMg/fypKAPrDGq0XZkoL1T2Bz5K23dK9Ru1E1fE
        e+Ygq0duc8DdGuUo2djPiId6wA==
X-Google-Smtp-Source: AA0mqf7MOSuxRsGCbZl2H4GweJ4czz/OQLFa9+8NQ39lcD9YLUNb/XB2tSqElyp6ka/wyl/g9IcEcw==
X-Received: by 2002:a5d:6d47:0:b0:230:3652:205 with SMTP id k7-20020a5d6d47000000b0023036520205mr3634228wri.322.1668761201902;
        Fri, 18 Nov 2022 00:46:41 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b003c7087f6c9asm8716126wmo.32.2022.11.18.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:46:41 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: pm_bus: core: Implement regulator get_status
Date:   Fri, 18 Nov 2022 09:46:36 +0100
Message-Id: <20221118084637.1973838-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add get_status for pmbus_regulator_ops.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 7ec04934747e..5dde345c7679 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2851,6 +2851,77 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	return 0;
 }
 
+static int pmbus_regulator_get_status(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u8 page = rdev_get_id(rdev);
+	int status, status2;
+
+	mutex_lock(&data->update_lock);
+	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
+	mutex_unlock(&data->update_lock);
+	if (status < 0)
+		return status;
+
+	if (status & (PB_STATUS_VIN_UV | PB_STATUS_IOUT_OC | PB_STATUS_VOUT_OV |
+	    PB_STATUS_UNKNOWN))
+		return REGULATOR_STATUS_ERROR;
+
+	if (status & (PB_STATUS_OFF | PB_STATUS_POWER_GOOD_N))
+		return REGULATOR_STATUS_OFF;
+
+	if (status & PB_STATUS_VOUT &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
+		mutex_lock(&data->update_lock);
+		status2 = _pmbus_read_byte_data(client, page,
+					 PMBUS_STATUS_VOUT);
+		mutex_unlock(&data->update_lock);
+		if (status2 < 0)
+			return status2;
+		if (status2 & (PB_VOLTAGE_OV_FAULT | PB_VOLTAGE_UV_FAULT))
+			return REGULATOR_STATUS_ERROR;
+	}
+	if (status & PB_STATUS_IOUT_POUT &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
+		mutex_lock(&data->update_lock);
+		status2 = _pmbus_read_byte_data(client, page,
+						 PMBUS_STATUS_IOUT);
+		mutex_unlock(&data->update_lock);
+		if (status2 < 0)
+			return status2;
+		if (status2 & (PB_POUT_OP_FAULT | PB_IOUT_UC_FAULT |
+		    PB_IOUT_OC_LV_FAULT | PB_IOUT_OC_FAULT))
+			return REGULATOR_STATUS_ERROR;
+	}
+	if (status & PB_STATUS_INPUT &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_INPUT) {
+		mutex_lock(&data->update_lock);
+		status2 = _pmbus_read_byte_data(client, page,
+						 PMBUS_STATUS_INPUT);
+		mutex_unlock(&data->update_lock);
+		if (status2 < 0)
+			return status2;
+		if (status2 & (PB_IIN_OC_FAULT | PB_VOLTAGE_OV_FAULT |
+		    PB_VOLTAGE_UV_FAULT))
+			return REGULATOR_STATUS_ERROR;
+	}
+	if (status & PB_STATUS_TEMPERATURE &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
+		mutex_lock(&data->update_lock);
+		status2 = _pmbus_read_byte_data(client, page,
+						 PMBUS_STATUS_TEMPERATURE);
+		mutex_unlock(&data->update_lock);
+		if (status2 < 0)
+			return status2;
+		if (status2 & (PB_TEMP_UT_FAULT | PB_TEMP_OT_FAULT))
+			return REGULATOR_STATUS_ERROR;
+	}
+
+	return REGULATOR_STATUS_ON;
+}
+
 static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2991,6 +3062,7 @@ const struct regulator_ops pmbus_regulator_ops = {
 	.disable = pmbus_regulator_disable,
 	.is_enabled = pmbus_regulator_is_enabled,
 	.get_error_flags = pmbus_regulator_get_error_flags,
+	.get_status = pmbus_regulator_get_status,
 	.get_voltage = pmbus_regulator_get_voltage,
 	.set_voltage = pmbus_regulator_set_voltage,
 	.list_voltage = pmbus_regulator_list_voltage,

base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
-- 
2.37.3

