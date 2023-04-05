Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330EC6D8ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDEWpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjDEWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:45:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364654EE2;
        Wed,  5 Apr 2023 15:45:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so144861595edb.11;
        Wed, 05 Apr 2023 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680734742; x=1683326742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rZfW/ZUQcsYXVhPws5kpGW4HZLanDFgEGRr3N5pjXQ=;
        b=OfwQq+Tn/E0syeBI0QtxwuwtEcdVJS6I3ZWj8s63hwN0aJdRKvF6IC38j+QZJ7dFhv
         neG/Isn5u4MeAK2Z6bxqotBTSFlgcH7jR/sfMG1Fc5tNq06n9PZ05I48AE+h47ZHSlZb
         0cg35DdDDGZviZIBb3/lupA0yDgQ6CihriJksbbaIx5C6ZLfDMr4nuigtDx2rqsJ/IJU
         7fOQ/Lwgp3QiTgv+swdXFptCVMyOXC6Z+00OaC4IbWFWahWN4plg7iRHLXlYDN65bnQa
         wC4vmNieqpm6QGnWeh0syo0dHGVkCNa0T3/dmYdDsp8GEgrqLEWKq2pys6Nbl4amB/Ea
         2VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680734742; x=1683326742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rZfW/ZUQcsYXVhPws5kpGW4HZLanDFgEGRr3N5pjXQ=;
        b=qpG8Wv6xsFIEQWSSlqrgU88PtGymzcCPtT21A+ZRdHe25cYwf5RfNU6NYleHo4zaTi
         inyvxicwA/wGmsAQ2MJduO4ZlEw5wPR8gnxlkWScM0iR1rv1Pq3dMsj96Oy79zAvElIi
         ii8/TrXlf9LdC1n4ff9Rgs1HKe/x9EHPKiO+ufWwZ8NSQUJ82JlmnNoYnAvDp8Ah3ax3
         yQ5a5ydIlsrnro/B5SJAr1dQvOQjONX3LfwBVu1wUG7q4Hg4msS0MvB2SAkHi3GSc3Oy
         7+mK5ou5csvK1KOWygtImyqRGRMCVhV11DupEBu6vrlDMBKOP4lvaPmbtwa+pQeMDKed
         lanA==
X-Gm-Message-State: AAQBX9f9ROqmM/+XN1VwplTy2NKifB/W0jB7QZiF4IAWEUCPA7q+A9lE
        FG2ezs5nu5qyEfvzXA91ZGU=
X-Google-Smtp-Source: AKy350Ye51akLmxE4wTR/m3W3FL9Vg3yREipFySxGN0AIOkDvkknoh22U3dZrmFJLm+thmqkq+PHFg==
X-Received: by 2002:a17:906:1482:b0:948:b300:6e9a with SMTP id x2-20020a170906148200b00948b3006e9amr4633666ejc.32.1680734742436;
        Wed, 05 Apr 2023 15:45:42 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2cac00f0c38d0eb7c148d4.dip0.t-ipconnect.de. [2003:cf:9f2c:ac00:f0c3:8d0e:b7c1:48d4])
        by smtp.googlemail.com with ESMTPSA id h3-20020a1709067cc300b0094776b4ef04sm8091868ejp.10.2023.04.05.15.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:45:41 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     fireflame90051 <cacoukoulis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (asus-ec-sensors) add ProArt B550-Creator
Date:   Thu,  6 Apr 2023 00:43:38 +0200
Message-Id: <20230405224339.358675-2-eugene.shalygin@gmail.com>
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

From: fireflame90051 <cacoukoulis@gmail.com>

Add support for the ASUS ProArt B550-Creator board, was tested
with the hardware [1].

[1] https://github.com/zeule/asus-ec-sensors/issues/35

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: fireflame90051 <cacoukoulis@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index a4039f2f9ca4..f1c9b1e11268 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -8,6 +8,7 @@ Supported boards:
  * PRIME X570-PRO
  * Pro WS X570-ACE
  * ProArt X570-CREATOR WIFI
+ * ProArt B550-CREATOR
  * ROG CROSSHAIR VIII DARK HERO
  * ROG CROSSHAIR VIII HERO (WI-FI)
  * ROG CROSSHAIR VIII FORMULA
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 2768b7511684..594fe7241111 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -303,6 +303,14 @@ static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_pro_art_b550_creator = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
 static const struct ec_board_info board_info_pro_ws_x570_ace = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
@@ -435,6 +443,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_prime_x570_pro),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
 					&board_info_pro_art_x570_creator_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
+					&board_info_pro_art_b550_creator),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
 					&board_info_pro_ws_x570_ace),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO",
-- 
2.40.0

