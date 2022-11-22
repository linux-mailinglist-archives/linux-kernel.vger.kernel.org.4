Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E699B6337D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiKVJDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiKVJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:03:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B049FD2D5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:03:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so23626479wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlO7g4Lsw0W29NZcE0ra/AJVqpRBqZGwpRSfI2r7w5Y=;
        b=XHn2YtjbLOJMoShQ8Uuzur7XQJyv9rqI/IfrS/8/o24iIBnkbh1vaoC1ZCUmfR+W5k
         pR9cuxus/C9I5QoH4SuyXLUTEw0vDOKujndGzluBpFR1wU5MWxB+PGFxfLbzOjWSNGLy
         LUtJHT02Z9pN5gCXFEBXY78s2tpJ9omwPiUbXfxCHmrcQW0742Hq0VvR8TYsLHg8YVkE
         K240BL4nTxQxAAg2snoDSeJPwPfvwYTRFZHxjkJnUTFO9ioR9I1zmQEdALS7e/2Y/SEH
         t8RNEoJvnXxpH56Fo7S3LJ6ip5AImo/i54tk1N9TIwsTVCgqx9JaT4HZNZTvXcJdcJm5
         U6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlO7g4Lsw0W29NZcE0ra/AJVqpRBqZGwpRSfI2r7w5Y=;
        b=kL36mMX3O8TFGZV+fo/NqJzS+JItgiXoN/kifrwkh2iBVOz44zCPOJkF4VoC1MFPXD
         Seq264z3ZvmpraM1THInrPCD5kDexZkKGhckYsgOuukrVIavZmwYaOm8btdpLQlioFjT
         0lxu74Ycuom8UtiSqatAvqRzL7nsxy4vF7AmCup+VH58HXDH3WW4ZPO3Qx3XwdNjPbpx
         JvY6kEhn56UZdCXsP911DuemIYEXt7s+aLlHkQzX8G8GSFdDKX5JxS6JdEJMRigb7+rN
         3l+cBGMFcYvo8u2qzn1Jxv43boDw9PR3jmhAp0L+RcnWOGiC01ISykBVBEAvn1vsyY0Z
         6NWQ==
X-Gm-Message-State: ANoB5plOdwst+osRrg6IHx4DzV7wnhsnozzn9sSpGqAZ6il9XrAF2he8
        RH8yBILZW2jz4pg/l20Vhf58+yzSNx5iJ9ZF
X-Google-Smtp-Source: AA0mqf68rXUfFCPbiYFPRAEVP2GsE6Sh7ZlYje0Rb53NCB/Hi0QUvgnkvfPQfNOqxHzkmQm0uYYymw==
X-Received: by 2002:a5d:5744:0:b0:236:b7c6:7ef9 with SMTP id q4-20020a5d5744000000b00236b7c67ef9mr1729027wrw.10.1669107785740;
        Tue, 22 Nov 2022 01:03:05 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c2ccc00b003cf54b77bfesm21296686wmc.28.2022.11.22.01.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:03:05 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (pmbus/core): Implement regulator get_status
Date:   Tue, 22 Nov 2022 10:03:02 +0100
Message-Id: <20221122090302.3053092-1-Naresh.Solanki@9elements.com>
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

---
Changes:
- use lock throughout the function
- Avoid line continuation upto 100 column
- Optimize use of & and | operator
- Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
  respective status register for fault.
- Report regulator current status.
- Utilize get_error_flag to check for regulator errors.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 7ec04934747e..5df2aee549e6 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2851,6 +2851,46 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	return 0;
 }
 
+static int pmbus_regulator_get_status(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u8 page = rdev_get_id(rdev);
+	int status, ret;
+
+	mutex_lock(&data->update_lock);
+	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
+	if (status < 0) {
+		ret = status;
+		goto unlock;
+	}
+
+	if (status & PB_STATUS_OFF) {
+		ret = REGULATOR_STATUS_OFF;
+		goto unlock;
+	}
+
+	/* If regulator is ON & reports power good then return ON */
+	if (!(status & PB_STATUS_POWER_GOOD_N)) {
+		ret = REGULATOR_STATUS_ON;
+		goto unlock;
+	}
+
+	if (rdev->desc->ops->get_error_flags)
+		ret = rdev->desc->ops->get_error_flags(rdev, &status);
+
+	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
+	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP))
+		ret = REGULATOR_STATUS_ERROR;
+	else
+		ret = REGULATOR_STATUS_UNDEFINED;
+
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
 static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2991,6 +3031,7 @@ const struct regulator_ops pmbus_regulator_ops = {
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

