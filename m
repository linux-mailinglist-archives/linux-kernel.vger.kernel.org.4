Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5706D8ABE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDEWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDEWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:45:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9449D6;
        Wed,  5 Apr 2023 15:45:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i5so145095373eda.0;
        Wed, 05 Apr 2023 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680734749; x=1683326749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abs5vnuFg+JgN+Qc/VQYYpxmAo9K163MxBlLncrpmMw=;
        b=EB/arFQjqUhFEJ0eE7Rt8j8O1JnV4Tkcxm9EDnFbpumcMiGtipOVpXMdxJjAc3YZMg
         ncsXHdTFzh8rCW+MKCb3Xq5Dh/On2Cv/Q8XUrovdqt2f13oHTBsP1hLUbjV1n75c0d5t
         mCX4u5EZ6dHxvOHgzoexm8ypz/xfwnUD+vjzlk0q47ykCErANJQPVBWFL4mIqc1d4qNI
         V2ptoCepb5wsum56Gpj1lIFaGriIiLqucc32Ij38ZkqdPgtGMBsegYAeMzWdSWVm0yQL
         C310v4O0n4ujbrmzCxC2Af7crXWdvUBwlMt5ZOc99lDgDLYMX0YTY7U6wfAZsoT7pya5
         h6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680734749; x=1683326749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abs5vnuFg+JgN+Qc/VQYYpxmAo9K163MxBlLncrpmMw=;
        b=FjnJSSTuskdZTiBnPrRGWl0HS1QqSpcC7kLaqiAOgmD8QEaoAVBJ25JZlmK/yBYHVt
         j3e6twVKUxMFb9347BDLorLM0PCoai+Rf2keU6EtUCvXxFg6BUuHWx63tABSxAdodK0/
         gScyTRLcNnIaXhv4hlgb9oYD+gwb2gfcn20o5GeCC2oRUbNYdY5m6ll4FjdU9phuXu9T
         TLNA+cJOsqPtCr737BnkSrSC13CSPF/16gxFr3XTjDuWcDrQzyLZTImtfg0eYLl05yC3
         elhHFrZGRTyp863M6QfFTOHj6088HosCvjGReqoXKagrp6FL44Wg//3dfck98xajyxIi
         hRkA==
X-Gm-Message-State: AAQBX9ekpxVqL2QOerO+A0EbPEblYRXaf8b6CXp65t6GRnxPCvgwrJzw
        xjRF2/OgLc7gdbMEFiiE1VI=
X-Google-Smtp-Source: AKy350bJi5ORiHSzQJdMZwNjssIYN1vVckW55eJnhB3LijhUySdMYnVKYjGiDXE0y1Vn+UlydZiXAQ==
X-Received: by 2002:a17:906:3815:b0:8c3:3439:24d9 with SMTP id v21-20020a170906381500b008c3343924d9mr4417277ejc.24.1680734749229;
        Wed, 05 Apr 2023 15:45:49 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2cac00f0c38d0eb7c148d4.dip0.t-ipconnect.de. [2003:cf:9f2c:ac00:f0c3:8d0e:b7c1:48d4])
        by smtp.googlemail.com with ESMTPSA id h3-20020a1709067cc300b0094776b4ef04sm8091868ejp.10.2023.04.05.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:45:48 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (asus-ec-sensors) add ROG STRIX Z390-F GAMING
Date:   Thu,  6 Apr 2023 00:43:39 +0200
Message-Id: <20230405224339.358675-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405224339.358675-1-eugene.shalygin@gmail.com>
References: <20230405224339.358675-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition comes from a LHM PR [1], and the mutex path from
the ACPI dump, kindly provided by the PR author [2]

[1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/1031
[2] https://github.com/zeule/asus-ec-sensors/issues/36

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index f1c9b1e11268..c92c1d3839e4 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -22,6 +22,7 @@ Supported boards:
  * ROG STRIX X570-E GAMING WIFI II
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
+ * ROG STRIX Z390-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
  * ROG ZENITH II EXTREME
  * ROG ZENITH II EXTREME ALPHA
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 594fe7241111..e5be0cf472fc 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -408,6 +408,14 @@ static const struct ec_board_info board_info_strix_x570_i_gaming = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_strix_z390_f_gaming = {
+	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_intel_300_series,
+};
+
 static const struct ec_board_info board_info_strix_z690_a_gaming_wifi_d4 = {
 	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
@@ -473,6 +481,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x570_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-I GAMING",
 					&board_info_strix_x570_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-F GAMING",
+					&board_info_strix_z390_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-A GAMING WIFI D4",
 					&board_info_strix_z690_a_gaming_wifi_d4),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
-- 
2.40.0

