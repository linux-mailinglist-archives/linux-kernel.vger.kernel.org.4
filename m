Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437CB5FE99E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJNHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJNHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:33:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032A1B76FB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:33:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a10so6209005wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKEmi6vccBwd4SuCcKc/2Tnsrh3azVvNbQckYv+e6ak=;
        b=gNx2C+pR029dJrAMYsM/ISYcaMzSXUq1lw4AX6GAvR0rl8PXVM3vUZ283CFCrrzcpo
         ncW5tMv7rYUFtP525ZQYUFEh/mtcdqZ/T0guZr8y2hnTgHfaJvuIi9G3kbdiBmtDeX2q
         Eb3snzOIVOuFoiLa0GB0N6eJj0hYjh/VnSQtp3nuH4xuHXfduU7mknGehTL9WNI2Wbrt
         c3gQyocfEbOVsgseyD1o1uXHN/HAWozN1uYfgau0sQLhvwpdJO+wdrnTIbYh7leWx8P3
         iG6IQRSx4queQONUNMipBhA7LjaKBTCe7wuJfosMY/+Yhkkq+xKmI7hMNG5hFmcvRUbP
         5d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKEmi6vccBwd4SuCcKc/2Tnsrh3azVvNbQckYv+e6ak=;
        b=fcXv2c/SH+Ojz5jIHsTzUDmJD09Dh+Pg85X5b+ziijpCvPmq5Fackjn7aXJOE0+J3a
         0wAIYSbwmoDe7dyBKgkDgCDKWq/nbqUE+1GhxRyyrFj4aIKma0ifDsUs7YXvhUQVNZfX
         E4m/icoAVBeW+tpp/N1ORxt6XPjEGmuuhBkv7zof34gwSpD/kJnp+y0JDHmnGfa1cN2M
         J56HcHDwQhX3BqVcoppxyX/Hl9vr+5i/IRAoXQtBL5OqaNFXGVVHaUQxQ5Q53oXS7wMH
         Gi+D6ekECGWD49d1Z1d9cJ98m2T5No17sW4xOIl6X21jZZ0pH+AwgJynPZ8KHjLOydlI
         D7Ig==
X-Gm-Message-State: ACrzQf0zw6PPZ/nJdY3IB9tDIg7V8RHkC5rvKTGnjDb9twS67qbT407g
        taMbPkK/6k9+yh0EgmpegUOXYg==
X-Google-Smtp-Source: AMsMyM7U73AFlAev/JPrLh9ASLCfIzg6SpI5mfM2QVAT97wVOID0wpuDdrcu0/aorO8JS6jw8R/vkg==
X-Received: by 2002:a5d:4887:0:b0:226:ed34:7bbd with SMTP id g7-20020a5d4887000000b00226ed347bbdmr2218132wrq.561.1665732790764;
        Fri, 14 Oct 2022 00:33:10 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:b460:17f0:186d:9d2e])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003a682354f63sm898148wmo.11.2022.10.14.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:33:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Nathan Errera <nathan.errera@intel.com>,
        linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK
        (iwlwifi)), netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
Subject: [PATCH 1/2] thermal/drivers/iwlwifi: Use generic thermal_zone_get_trip() function
Date:   Fri, 14 Oct 2022 09:32:50 +0200
Message-Id: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

The get_trip_temp, get_trip_hyst and get_trip_type are handled by the
get_trip_point().

The set_trip_temp() generic function does some checks which are no
longer needed in the set_trip_point() ops.

Convert ops content logic into generic trip points and register them
with the thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c  | 71 ++++----------------
 2 files changed, 13 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bf35e130c876..38e7426f98c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -501,7 +501,7 @@ struct iwl_mvm_tt_mgmt {
  * @tzone: thermal zone device data
 */
 struct iwl_mvm_thermal_device {
-	s16 temp_trips[IWL_MAX_DTS_TRIPS];
+	struct thermal_trip trips[IWL_MAX_DTS_TRIPS];
 	u8 fw_trips_index[IWL_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 69cf3a372759..3da4af7bc1ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -573,11 +573,11 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 	 * and uncompressed, the FW should get it compressed and sorted
 	 */
 
-	/* compress temp_trips to cmd array, remove uninitialized values*/
+	/* compress trips to cmd array, remove uninitialized values*/
 	for (i = 0; i < IWL_MAX_DTS_TRIPS; i++) {
-		if (mvm->tz_device.temp_trips[i] != S16_MIN) {
+		if (mvm->tz_device.trips[i].temperature != INT_MIN) {
 			cmd.thresholds[idx++] =
-				cpu_to_le16(mvm->tz_device.temp_trips[i]);
+				cpu_to_le16((s16)(mvm->tz_device.trips[i].temperature / 1000));
 		}
 	}
 	cmd.num_temps = cpu_to_le32(idx);
@@ -593,8 +593,8 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 	 */
 	for (i = 0; i < idx; i++) {
 		for (j = 0; j < IWL_MAX_DTS_TRIPS; j++) {
-			if (le16_to_cpu(cmd.thresholds[i]) ==
-				mvm->tz_device.temp_trips[j])
+			if ((int)(le16_to_cpu(cmd.thresholds[i]) * 1000) ==
+			    mvm->tz_device.trips[j].temperature)
 				mvm->tz_device.fw_trips_index[i] = j;
 		}
 	}
@@ -638,37 +638,12 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 	return ret;
 }
 
-static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone_device *device,
-				       int trip, int *temp)
-{
-	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
-
-	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS)
-		return -EINVAL;
-
-	*temp = mvm->tz_device.temp_trips[trip] * 1000;
-
-	return 0;
-}
-
-static int iwl_mvm_tzone_get_trip_type(struct thermal_zone_device *device,
-				       int trip, enum thermal_trip_type *type)
-{
-	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS)
-		return -EINVAL;
-
-	*type = THERMAL_TRIP_PASSIVE;
-
-	return 0;
-}
-
 static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 				       int trip, int temp)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
 	struct iwl_mvm_thermal_device *tzone;
-	int i, ret;
-	s16 temperature;
+	int ret;
 
 	mutex_lock(&mvm->mutex);
 
@@ -678,40 +653,17 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 		goto out;
 	}
 
-	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if ((temp / 1000) > S16_MAX) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	temperature = (s16)(temp / 1000);
 	tzone = &mvm->tz_device;
-
 	if (!tzone) {
 		ret = -EIO;
 		goto out;
 	}
 
-	/* no updates*/
-	if (tzone->temp_trips[trip] == temperature) {
-		ret = 0;
-		goto out;
-	}
-
-	/* already existing temperature */
-	for (i = 0; i < IWL_MAX_DTS_TRIPS; i++) {
-		if (tzone->temp_trips[i] == temperature) {
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-
-	tzone->temp_trips[trip] = temperature;
-
 	ret = iwl_mvm_send_temp_report_ths_cmd(mvm);
 out:
 	mutex_unlock(&mvm->mutex);
@@ -720,8 +672,6 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 
 static  struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = iwl_mvm_tzone_get_temp,
-	.get_trip_temp = iwl_mvm_tzone_get_trip_temp,
-	.get_trip_type = iwl_mvm_tzone_get_trip_type,
 	.set_trip_temp = iwl_mvm_tzone_set_trip_temp,
 };
 
@@ -743,7 +693,8 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
 
 	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
-	mvm->tz_device.tzone = thermal_zone_device_register(name,
+	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
+							mvm->tz_device.trips,    
 							IWL_MAX_DTS_TRIPS,
 							IWL_WRITABLE_TRIPS_MSK,
 							mvm, &tzone_ops,
@@ -766,8 +717,10 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 	/* 0 is a valid temperature,
 	 * so initialize the array with S16_MIN which invalid temperature
 	 */
-	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++)
-		mvm->tz_device.temp_trips[i] = S16_MIN;
+	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
+		mvm->tz_device.trips[i].temperature = INT_MIN;
+		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
+	}
 }
 
 static int iwl_mvm_tcool_get_max_state(struct thermal_cooling_device *cdev,
-- 
2.34.1

