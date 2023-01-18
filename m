Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215E767268E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjARSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjARSQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:16:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D1D5976C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:16:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so1994903wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8sOpg2jsh5IIv/+9bpFBSXh64MYJcWPCrHkWXWRQik=;
        b=PpiYy4Jds4QmdJM3SrsLCRcOX+kvsRI1DgfONWLx+2mM83I77cZz+yTUP2iTO8eJmf
         QkQB3ka3NtkIvhtk//godVvnxyRrIvvLKceVonLL0RWXwYHPgnqJadrcAAmsYtIFU2pY
         bl6JngCRBjpRzY3gG9WwuE3EDbUD7EHtEP7a0Mz5xQxt0ir7E1VcuZ0hecj40Oc6eFAG
         oFZsLlaTAcJk0tA2TYTfl+6YtxE70FDurc3OUOJYxVUJZ39Lz0PJryj7zeGFjfa0OvMu
         EUCzqPGB8aiC3iKtBPQDbzvJv4kGMORKebKNF3kmJOcP3Phduwf7y77n4QuTf7P+H8Ki
         9m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8sOpg2jsh5IIv/+9bpFBSXh64MYJcWPCrHkWXWRQik=;
        b=wR+tHRHc6dw3QNm8EAwQIFUkPwv34XaxKJ2Zbmeo+KktNOMCXRYzVtquQpeXXlJP+V
         DbA/eFQ9crD6UqTuf8iugQXElfZ4kSMBU994D+XIpqQlbe6oNsjBIHLAUdC+jDFkZtxz
         LvBOcdmoGPu2ElB4lQLL/reH9z6a249QGxRyHE6eCat+6EfHeNL+XukNVy9DkUVTOK3/
         18vCZwcs81L19mE2K24vosjIvJhkt5Km6FL0KQiUnB+uimIjMupzUxyinzTUsonja7nF
         MQ137RXsnsSVcJmcKl7J+21304g+kh50+WpJr4vJXGQoYRu/8oHcEUCztpl4GYtfVN01
         ZVXA==
X-Gm-Message-State: AFqh2krUU2srF/dJSQNBeQ/TDTFoNacDQpRK0rSblqFWCB+xZK4qAQv7
        aE43xd6O5OpFZIR58mUBQN273w==
X-Google-Smtp-Source: AMrXdXuuf1lOfpMYOUUKzaqlKVpAozs14Lg/Iu4jQYC6Pz/MaetiHMvYXZxQqm/YUfkoF6BJekpgIA==
X-Received: by 2002:a05:600c:3555:b0:3da:f4d4:4c2 with SMTP id i21-20020a05600c355500b003daf4d404c2mr7426443wmq.37.1674065797376;
        Wed, 18 Jan 2023 10:16:37 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003db12112fcfsm2817414wmq.4.2023.01.18.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:16:36 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for intel_soc_dts_iosf
Date:   Wed, 18 Jan 2023 19:16:21 +0100
Message-Id: <20230118181622.33335-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118181622.33335-1-daniel.lezcano@linaro.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@kernel.org>

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 58 ++++++++--------------
 drivers/thermal/intel/intel_soc_dts_iosf.h |  2 +-
 2 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 342b0bb5a56d..130c416ec601 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -71,20 +71,13 @@ static int get_tj_max(u32 *tj_max)
 	return err;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip,
-			     int *temp)
+static int get_trip_temp(struct intel_soc_dts_sensors *sensors, int trip, int *temp)
 {
 	int status;
 	u32 out;
-	struct intel_soc_dts_sensor_entry *dts;
-	struct intel_soc_dts_sensors *sensors;
 
-	dts = tzd->devdata;
-	sensors = dts->sensors;
-	mutex_lock(&sensors->dts_update_lock);
 	status = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
 			       SOC_DTS_OFFSET_PTPS, &out);
-	mutex_unlock(&sensors->dts_update_lock);
 	if (status)
 		return status;
 
@@ -173,8 +166,13 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 	if (status)
 		goto err_restore_te_out;
 
-	dts->trip_types[thres_index] = trip_type;
-
+	status = get_trip_temp(sensors, thres_index, &temp);
+	if (status)
+		goto err_restore_te_out;		
+	
+	dts->trips[thres_index].type = trip_type;
+	dts->trips[thres_index].temperature = temp;
+	
 	return 0;
 err_restore_te_out:
 	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
@@ -202,24 +200,12 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 
 	mutex_lock(&sensors->dts_update_lock);
 	status = update_trip_temp(tzd->devdata, trip, temp,
-				  dts->trip_types[trip]);
+				  dts->trips[trip].type);
 	mutex_unlock(&sensors->dts_update_lock);
 
 	return status;
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *tzd,
-			     int trip, enum thermal_trip_type *type)
-{
-	struct intel_soc_dts_sensor_entry *dts;
-
-	dts = tzd->devdata;
-
-	*type = dts->trip_types[trip];
-
-	return 0;
-}
-
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 			     int *temp)
 {
@@ -245,8 +231,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
 };
 
@@ -320,7 +304,8 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 	dts->trip_mask = trip_mask;
 	dts->trip_count = trip_count;
 	snprintf(name, sizeof(name), "soc_dts%d", id);
-	dts->tzone = thermal_zone_device_register(name,
+	dts->tzone = thermal_zone_device_register_with_trips(name,
+						  dts->trips,
 						  trip_count,
 						  trip_mask,
 						  dts, &tzone_ops,
@@ -430,27 +415,28 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
 		notification = false;
 	else
 		notification = true;
-	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		sensors->soc_dts[i].sensors = sensors;
-		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
-					   notification, trip_count,
-					   read_only_trip_count);
-		if (ret)
-			goto err_free;
-	}
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		ret = update_trip_temp(&sensors->soc_dts[i], 0, 0,
 				       THERMAL_TRIP_PASSIVE);
 		if (ret)
-			goto err_remove_zone;
+			goto err_free;
 
 		ret = update_trip_temp(&sensors->soc_dts[i], 1, 0,
 				       THERMAL_TRIP_PASSIVE);
 		if (ret)
-			goto err_remove_zone;
+			goto err_free;
 	}
 
+	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
+		sensors->soc_dts[i].sensors = sensors;
+		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
+					   notification, trip_count,
+					   read_only_trip_count);
+		if (ret)
+			goto err_remove_zone;
+	}
+	
 	return sensors;
 err_remove_zone:
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i)
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
index c54945748200..ee0a39e3edd3 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -27,7 +27,7 @@ struct intel_soc_dts_sensor_entry {
 	u32 store_status;
 	u32 trip_mask;
 	u32 trip_count;
-	enum thermal_trip_type trip_types[2];
+	struct thermal_trip trips[2];
 	struct thermal_zone_device *tzone;
 	struct intel_soc_dts_sensors *sensors;
 };
-- 
2.34.1

