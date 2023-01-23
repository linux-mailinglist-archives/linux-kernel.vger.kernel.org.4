Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559667752D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAWGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAWGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:40:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403571A94C
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:40:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso9834829wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+JF7XPB91qXux0PSB/u2LOK9F1btKF5KMGFh4JlLz4=;
        b=dYc41iPRe9mkv72Tn+NSiJD45gWuyAZwg8HfTDI4PDsqvCUMNTbGShut3I9O74si+A
         AFxDygpnmG4p9ExU+AJoM9T9SFnQlKsKFnol/JCZg0p1aVQvE5K3+YQfBflr7OpCzjaB
         FC0+sQ1ZQ/dfzk7OPCc9e5jdSg7Rn+4D7c0qh7D+d4SMg1ep+WC9IYYeb7LfpVlDHVpW
         ru4Rx9em/OXqAAaIQviIUg9xbX8pbIiUXczuHZeSlDQV5Li1hTQHQWsKcc8iyjTRTsLs
         1joZnpFitWK0kNfI1GyohlGsFJdXO4J2UbUzQLG5NfJcSl22rwOlbIIQjpX1TCJ7v3Pk
         RMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+JF7XPB91qXux0PSB/u2LOK9F1btKF5KMGFh4JlLz4=;
        b=zBZV7BgGb3g3u1s5IPjjAGPRx6T0x6BOEjDBM9kD+ia/+ZMm5FgXNFTBA56xapvPv2
         3q8KBtl3c/npFN4EbvEyKKRnSIxqVTNjdNmYkMIv+ZLHlqWNUm3RmzJxPRyQu8gLi3Mx
         0iwcTZhQgu+yttoUI0Rpi35vjLIOLJVh/wjkay5wISCEOXsbq/9M9xG++f2x8+Fe4yIK
         x10ACnQFkD+wr3JOkh+TQoA6MrtjDV8CUGfs0QHNj2igAVvu7RF+pbG1fbBAZgAGnOMm
         ueQETNIjBqxq4mpWgnPOjPC4sBaIRK8wuSI32+5aRXvYuKpxA5Fnrzp35x10w99xv+Rd
         4+4g==
X-Gm-Message-State: AFqh2koIVdBYwsckvwzjr6YKIIMeTRhDL1RiRfK5svIABatnndTIiTkG
        LGNq7i+90d+BT83Z5YNQ9IOyFA==
X-Google-Smtp-Source: AMrXdXu0fUtce20OFIj3HMtvfjV5CYnrL2JWHE0FAgqFynclPuOpHmHfA0Hk/kTeUJ5zHDfcC/wNAg==
X-Received: by 2002:a05:600c:1d0b:b0:3db:88f:996d with SMTP id l11-20020a05600c1d0b00b003db088f996dmr21949295wms.36.1674456039531;
        Sun, 22 Jan 2023 22:40:39 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a1c7504000000b003da28dfdedcsm11439373wmc.5.2023.01.22.22.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:40:39 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwmon: (pmbus/core): Notify hwmon events
Date:   Mon, 23 Jan 2023 07:40:21 +0100
Message-Id: <20230123064021.2657670-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123064021.2657670-1-Naresh.Solanki@9elements.com>
References: <20230123064021.2657670-1-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 45 ++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 3c1c68e93943..cbea92d3a1e6 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2735,8 +2735,35 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
 	},
 };
 
+#define to_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct device_attribute, attr)
 
-static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error)
+static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
+{
+	int i;
+
+	for (i = 0; i < data->num_attributes; i++) {
+		struct device_attribute *da = to_dev_attr(data->group.attrs[i]);
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+		int index = attr->index;
+		u16 smask = pb_index_to_mask(index);
+		u8 spage = pb_index_to_page(index);
+		u16 sreg = pb_index_to_reg(index);
+
+		if (reg == sreg && page == spage && (smask & flags)) {
+			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
+			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
+			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
+			flags &= ~smask;
+		}
+
+		if (!flags)
+			break;
+	}
+}
+
+static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error,
+			   bool notify)
 {
 	const struct pmbus_status_category *cat;
 	const struct pmbus_status_assoc *bit;
@@ -2764,6 +2791,8 @@ static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error
 				*error |= bit->rflag;
 		}
 
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
 	}
 
 	/*
@@ -2868,7 +2897,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
-	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3110,10 +3139,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+	int i, status, ret;
 
-	mutex_lock(&data->update_lock);
 	for (i = 0; i < data->info->pages; i++) {
+		ret = pmbus_get_flags(data, i, &status, true);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->update_lock);
 		status = pmbus_read_status_word(client, i);
 		if (status < 0) {
 			mutex_unlock(&data->update_lock);
@@ -3122,8 +3155,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 
 		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
 			pmbus_clear_fault_page(client, i);
+
+		mutex_unlock(&data->update_lock);
 	}
-	mutex_unlock(&data->update_lock);
+
 
 	return IRQ_HANDLED;
 }
-- 
2.38.1

