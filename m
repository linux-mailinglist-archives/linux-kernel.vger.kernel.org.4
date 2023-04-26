Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D466EFA34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjDZSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:44:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9BA44BA;
        Wed, 26 Apr 2023 11:44:51 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6a5f765d5b8so5763192a34.3;
        Wed, 26 Apr 2023 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682534691; x=1685126691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19DcYFOzr7bYWgxAGD4nb6l+fYJhmF+vtyo3LpAEbFI=;
        b=q8StYfd7PyIZ+wYaYPJzn38ROM6BjLJ+nJ+jB8GQLB+n9BKNJ9thubM43pxGxiail+
         rtiLYoQeUdu6M4Dc/p4B3los1qXqepTdTcnaQPO6vM2MoXzHm+YnGZNqVCq+PRkIgilv
         C0Au7sxr6uKC376PYjVoF4BJkNrHSlAS0FE6fHgLdyawDqaFEBuUm45JKn9Q1HfpiSNl
         v8MIBR67iDd0Yb6Dk6zj4rYXCBmrNnzKu0Tg7l0tl8c2e3FUkPOnv/2CIb1VkwbTUnqI
         +0oI8k1N74V2oxfEvtyclb8VLXoSxcDiN/5fu7mbL0Wm6BojjN69CgOTkIS83TsswbT9
         WdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534691; x=1685126691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19DcYFOzr7bYWgxAGD4nb6l+fYJhmF+vtyo3LpAEbFI=;
        b=XDEPsfanHZ48tv7IfaXfXGHuW/sqiQtHwigL6c39YtHZHmfec9vxKuPRY4u/8QXMqS
         NsMpaSGukcHYjVTLQ/QQCt153kbfTL8pU8Y0RbgznwpOBeXKMa4Wk0w7ntOkt49adRSj
         DczeKbx+IvtFte7nmFQAcsiYg8bycsSPhbSRJHuwiiXM0JbmVDvrPbLHfoDAbhJefNth
         Owsrfp58N18/XfwhGXOflhjXBHQXUXgCnRfVMJ8GyKufr4Kk46WqDQ5PSekDayI7pIAG
         kMg+DOq+dHM2PF+HsmabhlWBMP969qVjuxjZ2gAeqwcvNZcuQMeavnBaAdAMckr9j0l/
         96RA==
X-Gm-Message-State: AC+VfDwD/FMHRuAnbI2Qz3RPO09Q2rW3ze5Bjm8ZOz3GHiGMECQOXh57
        B1ML99XDYXdRlRNEAmCLNHU=
X-Google-Smtp-Source: AKy350Z3O+cgN8178KDyjnlW8gw1rrrtW92Jw4nHiK+SPthg9GNdfERoXYxU9SzATJ4rBwRIXsTzhg==
X-Received: by 2002:a9d:6251:0:b0:6a7:bced:4121 with SMTP id i17-20020a9d6251000000b006a7bced4121mr2483500otk.5.1682534690696;
        Wed, 26 Apr 2023 11:44:50 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id j14-20020a9d7f0e000000b0069f0a85fa36sm7097580otq.57.2023.04.26.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:44:50 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
Date:   Wed, 26 Apr 2023 15:44:20 -0300
Message-Id: <20230426184420.99945-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for handhelds with same EC registers
  - AYANEO 2
  - AYANEO GEEK

All functionality tests succeed on AYANEO 2 by "pastaq" user on Discord
and AYANEO GEEK tested by "oneoc" Discord user.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst |  2 ++
 drivers/hwmon/oxp-sensors.c         | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 566a8d5bde08..4ab442301415 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -25,8 +25,10 @@ Supported devices
 Currently the driver supports the following handhelds:
 
  - AOK ZOE A1
+ - Aya Neo 2
  - Aya Neo AIR
  - Aya Neo AIR Pro
+ - Aya Neo Geek
  - OneXPlayer AMD
  - OneXPlayer mini AMD
  - OneXPlayer mini AMD PRO
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index ae67207030e8..9093c608dee0 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -42,8 +42,10 @@ static bool unlock_global_acpi_lock(void)
 
 enum oxp_board {
 	aok_zoe_a1 = 1,
+	aya_neo_2,
 	aya_neo_air,
 	aya_neo_air_pro,
+	aya_neo_geek,
 	oxp_mini_amd,
 	oxp_mini_amd_pro,
 };
@@ -62,6 +64,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
+		},
+		.driver_data = (void *) &(enum oxp_board) {aya_neo_2},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
@@ -76,6 +85,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK"),
+		},
+		.driver_data = (void *) &(enum oxp_board) {aya_neo_geek},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
@@ -178,8 +194,10 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			if (ret)
 				return ret;
 			switch (board) {
+			case aya_neo_2:
 			case aya_neo_air:
 			case aya_neo_air_pro:
+			case aya_neo_geek:
 			case oxp_mini_amd:
 				*val = (*val * 255) / 100;
 				break;
@@ -217,8 +235,10 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			if (val < 0 || val > 255)
 				return -EINVAL;
 			switch (board) {
+			case aya_neo_2:
 			case aya_neo_air:
 			case aya_neo_air_pro:
+			case aya_neo_geek:
 			case oxp_mini_amd:
 				val = (val * 100) / 255;
 				break;
-- 
2.40.1

