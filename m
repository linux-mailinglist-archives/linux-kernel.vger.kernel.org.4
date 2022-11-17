Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5362E561
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiKQToJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbiKQToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:44:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCF786E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:44:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l14so5637025wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KypUmzDrLXtL4OjD6DSrcNKq8t+D4EOgwsfEXkwQU0=;
        b=V1jXmA6YET/Riwy5Az9K0/WdgDv5mgz3KeiZl+O8+3lk/eNHXBfRBHXQdY9wrMFcLB
         EKemOItrqdWH+zvLW7qiw7upC82yiyin0PTMqwegB6fajKU2wB07IoCDufTrPcpWvPOw
         1zx4sdzzEpb9SQts0jZ5mnaUN/7+xc91/nMlF2ijoPkXaZSkM+t27w/+sA0CRy1f1HhS
         /CTxyCvSrH+YBHdy1VTDUA+gNe0tf+MHhHWnuBdgbbBdgMe2DcwD/odCAv9Q3H2PaZEO
         dcltEuqWIu1wE1+IcVzxHO7SJYF9g9gX0sHzqAT6icy/5xZ2aJ4CbuoYwIDpt0yAwFYX
         x3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KypUmzDrLXtL4OjD6DSrcNKq8t+D4EOgwsfEXkwQU0=;
        b=fkZi+0XAdh9RXcZABg4RiL473qb/KMqS8GlBBLid6zUjvMxBq1ae6q5kuRcRcTWRg9
         LjKJtYv8GadeToi1NNZzk6b1uP9OQq69L9/SpLWEgUkdgxIShnDMGnlf8bOYwP9e8Hrq
         pr4a0km52QLTD0UOl9k0BoIXyk9g9C6miwAClk4Hrd3xANQyPZ+JIXEHadmBw4OpuaA7
         t2F6jX5qwK0WjngJZW5av5l2WnfyjHzNpAddyCM7IEJqGDFF9Y06HWSvyxYjfiset5bK
         Bp9n9SxsXXOhzeXKeZbJRO5jp4Z5gwt/iOfyszMq0FgscIxSJEtpTrkGVcwyUJXQXyyE
         r6ww==
X-Gm-Message-State: ANoB5pnNFhAk3J5PcdqDbXqMip+F9kuOgyzM20iqHDNVktu1gRENJXbI
        fuk6NbClGsaRp/4mdfaSYbSgRtb2Vq+9+gos
X-Google-Smtp-Source: AA0mqf4V++i4LNKsL4Fa85a8xDNFHKj4vwCrQ3EC45itZ35zFFJIAhQswriVJKbbYBeXtUAOiYmw+Q==
X-Received: by 2002:adf:f949:0:b0:236:704f:29f4 with SMTP id q9-20020adff949000000b00236704f29f4mr2480605wrr.11.1668714244805;
        Thu, 17 Nov 2022 11:44:04 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r24-20020adfa158000000b00236b2804d79sm1912823wrr.2.2022.11.17.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 11:44:04 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: pm_bus: core: Implement regulator get_status
Date:   Thu, 17 Nov 2022 20:43:51 +0100
Message-Id: <20221117194352.1904264-1-Naresh.Solanki@9elements.com>
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
 drivers/hwmon/pmbus/pmbus_core.c | 78 ++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 7ec04934747e..d5e2b0662da5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2851,6 +2851,83 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
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
+		 return status;
+
+	if (status & PB_STATUS_VIN_UV ||
+	    status & PB_STATUS_IOUT_OC ||
+	    status & PB_STATUS_VOUT_OV ||
+	    status & PB_STATUS_UNKNOWN)
+		 return REGULATOR_STATUS_ERROR;
+
+	if (status & PB_STATUS_VOUT_OV &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
+		 mutex_lock(&data->update_lock);
+		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_VOUT);
+		 mutex_unlock(&data->update_lock);
+		 if (status2 < 0)
+			  return status2;
+		 if (status2 & PB_VOLTAGE_OV_FAULT ||
+		     status2 & PB_VOLTAGE_UV_FAULT)
+			  return REGULATOR_STATUS_ERROR;
+	}
+	if (status & PB_STATUS_IOUT_OC &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
+		 mutex_lock(&data->update_lock);
+		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_IOUT);
+		 mutex_unlock(&data->update_lock);
+		 if (status2 < 0)
+			  return status2;
+		 if (status2 & PB_POUT_OP_FAULT ||
+		     status2 & PB_IOUT_UC_FAULT ||
+		     status2 & PB_IOUT_OC_LV_FAULT ||
+		     status2 & PB_IOUT_OC_FAULT)
+			  return REGULATOR_STATUS_ERROR;
+	}
+	if (status & PB_STATUS_VIN_UV &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_INPUT) {
+		 mutex_lock(&data->update_lock);
+		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_INPUT);
+		 mutex_unlock(&data->update_lock);
+		 if (status2 < 0)
+			  return status2;
+		 if (status2 & PB_IIN_OC_FAULT ||
+		     status2 & PB_VOLTAGE_OV_FAULT ||
+		     status2 & PB_VOLTAGE_UV_FAULT)
+			  return REGULATOR_STATUS_ERROR;
+	}
+	if (status & PB_STATUS_TEMPERATURE &&
+	    data->info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
+		 mutex_lock(&data->update_lock);
+		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_TEMPERATURE);
+		 mutex_unlock(&data->update_lock);
+		 if (status2 < 0)
+			  return status2;
+		 if (status2 & PB_TEMP_UT_FAULT ||
+		     status2 & PB_TEMP_OT_FAULT)
+			  return REGULATOR_STATUS_ERROR;
+	}
+
+	if (status & PB_STATUS_OFF)
+		 return REGULATOR_STATUS_OFF;
+
+	if (status & PB_STATUS_POWER_GOOD_N)
+		 return REGULATOR_STATUS_OFF;
+
+	return REGULATOR_STATUS_ON;
+}
+
 static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2991,6 +3068,7 @@ const struct regulator_ops pmbus_regulator_ops = {
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

