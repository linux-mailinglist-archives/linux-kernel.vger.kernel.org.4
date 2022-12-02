Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864C6410B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiLBWeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiLBWeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:34:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C23F9330;
        Fri,  2 Dec 2022 14:33:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z92so8294275ede.1;
        Fri, 02 Dec 2022 14:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvtD66Z6AMevOIHQl87ix4bKuxbdxW7Yl3ZiVOzqn1s=;
        b=onbNhJnMyZ+8g+RqwYEtI5LUuGm5EaY3OYGEG/i3dyOUFzxfQVtt9wpjHide7Tiux6
         DXVh5Yg+UQ4zpo3SDj2CogD/JEA1s993jZ/F/u9HWhRsWBe7jMmeLKFLR9Q3V+ab2+i4
         R+tJ29xQEg0y4Vo8L0mLyLk0ZmGISLEIorXZ+61YpXq4ywavdOP9JZl5x9o59uUHYzYs
         NXGiQmdwIaO9gqLumQRbxEFv83QlO4srIxeqeZJmr4rpT1YBsMFbUwcK2QZF6q/tBPB4
         zSj2bqjp7Du+JgTVT7S7row768nyoupX2YE71UgWntsYhxdrTnGIn7ZJV5gbJqDzJ5Bd
         k52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvtD66Z6AMevOIHQl87ix4bKuxbdxW7Yl3ZiVOzqn1s=;
        b=ZPoQEtB+hnZofmPEloCpVoTC2OHhV1ygzbJTrGVR4iKEnCBb6Y5f/Ve0InK6aE2eCW
         9V/ri7Q1XGrHmyYucIhusg4qGfO6J/6+c6GORo+398FFXyM3wXwJ/Oix7MW3A2CvVeff
         YL27fYvN4RIu5QWc45OGWBe0g/siu5LGP01+Q9ofMzHcB+sRqr3CrSG38FVEDYw/y6vw
         ntR+RYuGD4asXu8SDNa3W9Vrn0P8MjoKew3QNw8XV5VW7s/CwAjQUkZeNuwODTgMNahq
         rFT264DR9/AQDswd5L95httkjZp8djd1rQdPJDe4ZMHsFLaXE3cRxNUrpyyKliYoWLfy
         v6KA==
X-Gm-Message-State: ANoB5plz5sWmDaM60AtMqMs4hgKnKX2x2UsQQYo7N/6saz+SI3L6mjxC
        Fo1yo7WAg4pWQ9yzbZoEmBc=
X-Google-Smtp-Source: AA0mqf6praQLGtWedB9YTM0UktoCAxb4kme9HYyFyXnMVe/564tNfF/OgvCoKQHUtqFasZdtYnkJZQ==
X-Received: by 2002:a05:6402:100b:b0:461:f1c6:1f22 with SMTP id c11-20020a056402100b00b00461f1c61f22mr52417880edu.95.1670020426873;
        Fri, 02 Dec 2022 14:33:46 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:46 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] platform/surface: aggregator: Enforce use of target-ID enum in device ID macros
Date:   Fri,  2 Dec 2022 23:33:26 +0100
Message-Id: <20221202223327.690880-9-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the target category (TC), the target ID (TID) can be one
value out of a small number of choices, given in enum ssam_ssh_tid.

In the device ID macros, SSAM_SDEV() and SSAM_VDEV() we already use text
expansion to, both, remove some textual clutter for the target category
values and enforce that the value belongs to the known set. Now that we
know the names for the target IDs, use the same trick for them as well.

Also rename the SSAM_ANY_x macros to SSAM_SSH_x_ANY to better fit in.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/hid/surface-hid/surface_hid.c         |  2 +-
 .../platform/surface/surface_aggregator_hub.c |  4 +-
 .../surface/surface_aggregator_tabletsw.c     |  4 +-
 drivers/platform/surface/surface_dtx.c        |  2 +-
 .../surface/surface_platform_profile.c        |  2 +-
 drivers/power/supply/surface_battery.c        |  4 +-
 drivers/power/supply/surface_charger.c        |  2 +-
 include/linux/surface_aggregator/device.h     | 50 +++++++++----------
 8 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/surface-hid/surface_hid.c b/drivers/hid/surface-hid/surface_hid.c
index d4aa8c81903a..aa80d83a83d1 100644
--- a/drivers/hid/surface-hid/surface_hid.c
+++ b/drivers/hid/surface-hid/surface_hid.c
@@ -230,7 +230,7 @@ static void surface_hid_remove(struct ssam_device *sdev)
 }
 
 static const struct ssam_device_id surface_hid_match[] = {
-	{ SSAM_SDEV(HID, SSAM_ANY_TID, SSAM_ANY_IID, 0x00) },
+	{ SSAM_SDEV(HID, ANY, SSAM_SSH_IID_ANY, 0x00) },
 	{ },
 };
 MODULE_DEVICE_TABLE(ssam, surface_hid_match);
diff --git a/drivers/platform/surface/surface_aggregator_hub.c b/drivers/platform/surface/surface_aggregator_hub.c
index 62f27cdb6ca8..6abd1efe2088 100644
--- a/drivers/platform/surface/surface_aggregator_hub.c
+++ b/drivers/platform/surface/surface_aggregator_hub.c
@@ -348,8 +348,8 @@ static const struct ssam_hub_desc kip_hub = {
 /* -- Driver registration. -------------------------------------------------- */
 
 static const struct ssam_device_id ssam_hub_match[] = {
-	{ SSAM_VDEV(HUB, 0x01, SSAM_SSH_TC_KIP, 0x00), (unsigned long)&kip_hub  },
-	{ SSAM_VDEV(HUB, 0x02, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub },
+	{ SSAM_VDEV(HUB, SAM, SSAM_SSH_TC_KIP, 0x00), (unsigned long)&kip_hub  },
+	{ SSAM_VDEV(HUB, KIP, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub },
 	{ }
 };
 MODULE_DEVICE_TABLE(ssam, ssam_hub_match);
diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index bd8cd453c393..6147aa887939 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -510,8 +510,8 @@ static const struct ssam_tablet_sw_desc ssam_pos_sw_desc = {
 /* -- Driver registration. -------------------------------------------------- */
 
 static const struct ssam_device_id ssam_tablet_sw_match[] = {
-	{ SSAM_SDEV(KIP, 0x01, 0x00, 0x01), (unsigned long)&ssam_kip_sw_desc },
-	{ SSAM_SDEV(POS, 0x01, 0x00, 0x01), (unsigned long)&ssam_pos_sw_desc },
+	{ SSAM_SDEV(KIP, SAM, 0x00, 0x01), (unsigned long)&ssam_kip_sw_desc },
+	{ SSAM_SDEV(POS, SAM, 0x00, 0x01), (unsigned long)&ssam_pos_sw_desc },
 	{ },
 };
 MODULE_DEVICE_TABLE(ssam, ssam_tablet_sw_match);
diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 0de76a784a35..30cbde278c59 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -1214,7 +1214,7 @@ static void surface_dtx_ssam_remove(struct ssam_device *sdev)
 }
 
 static const struct ssam_device_id surface_dtx_ssam_match[] = {
-	{ SSAM_SDEV(BAS, 0x01, 0x00, 0x00) },
+	{ SSAM_SDEV(BAS, SAM, 0x00, 0x00) },
 	{ },
 };
 MODULE_DEVICE_TABLE(ssam, surface_dtx_ssam_match);
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index fbf2e11fd6ce..f433a13c3689 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -169,7 +169,7 @@ static void surface_platform_profile_remove(struct ssam_device *sdev)
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
-	{ SSAM_SDEV(TMP, 0x01, 0x00, 0x01) },
+	{ SSAM_SDEV(TMP, SAM, 0x00, 0x01) },
 	{ },
 };
 MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 540707882bb0..19d2f8834e56 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -852,8 +852,8 @@ static const struct spwr_psy_properties spwr_psy_props_bat2_sb3 = {
 };
 
 static const struct ssam_device_id surface_battery_match[] = {
-	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat1     },
-	{ SSAM_SDEV(BAT, 0x02, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat2_sb3 },
+	{ SSAM_SDEV(BAT, SAM, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat1     },
+	{ SSAM_SDEV(BAT, KIP, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat2_sb3 },
 	{ },
 };
 MODULE_DEVICE_TABLE(ssam, surface_battery_match);
diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index 59182d55742d..cabdd8da12d0 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -260,7 +260,7 @@ static const struct spwr_psy_properties spwr_psy_props_adp1 = {
 };
 
 static const struct ssam_device_id surface_ac_match[] = {
-	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 },
+	{ SSAM_SDEV(BAT, SAM, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 },
 	{ },
 };
 MODULE_DEVICE_TABLE(ssam, surface_ac_match);
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 46c45d1b6368..4da20b7a0ee5 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -68,9 +68,9 @@ struct ssam_device_uid {
  * match_flags member of the device ID structure. Do not use them directly
  * with struct ssam_device_id or struct ssam_device_uid.
  */
-#define SSAM_ANY_TID		0xffff
-#define SSAM_ANY_IID		0xffff
-#define SSAM_ANY_FUN		0xffff
+#define SSAM_SSH_TID_ANY	0xffff
+#define SSAM_SSH_IID_ANY	0xffff
+#define SSAM_SSH_FUN_ANY	0xffff
 
 /**
  * SSAM_DEVICE() - Initialize a &struct ssam_device_id with the given
@@ -83,25 +83,25 @@ struct ssam_device_uid {
  *
  * Initializes a &struct ssam_device_id with the given parameters. See &struct
  * ssam_device_uid for details regarding the parameters. The special values
- * %SSAM_ANY_TID, %SSAM_ANY_IID, and %SSAM_ANY_FUN can be used to specify that
+ * %SSAM_SSH_TID_ANY, %SSAM_SSH_IID_ANY, and %SSAM_SSH_FUN_ANY can be used to specify that
  * matching should ignore target ID, instance ID, and/or sub-function,
  * respectively. This macro initializes the ``match_flags`` field based on the
  * given parameters.
  *
  * Note: The parameters @d and @cat must be valid &u8 values, the parameters
- * @tid, @iid, and @fun must be either valid &u8 values or %SSAM_ANY_TID,
- * %SSAM_ANY_IID, or %SSAM_ANY_FUN, respectively. Other non-&u8 values are not
+ * @tid, @iid, and @fun must be either valid &u8 values or %SSAM_SSH_TID_ANY,
+ * %SSAM_SSH_IID_ANY, or %SSAM_SSH_FUN_ANY, respectively. Other non-&u8 values are not
  * allowed.
  */
 #define SSAM_DEVICE(d, cat, tid, iid, fun)					\
-	.match_flags = (((tid) != SSAM_ANY_TID) ? SSAM_MATCH_TARGET : 0)	\
-		     | (((iid) != SSAM_ANY_IID) ? SSAM_MATCH_INSTANCE : 0)	\
-		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
+	.match_flags = (((tid) != SSAM_SSH_TID_ANY) ? SSAM_MATCH_TARGET : 0)	\
+		     | (((iid) != SSAM_SSH_IID_ANY) ? SSAM_MATCH_INSTANCE : 0)	\
+		     | (((fun) != SSAM_SSH_FUN_ANY) ? SSAM_MATCH_FUNCTION : 0),	\
 	.domain   = d,								\
 	.category = cat,							\
-	.target   = __builtin_choose_expr((tid) != SSAM_ANY_TID, (tid), 0),	\
-	.instance = __builtin_choose_expr((iid) != SSAM_ANY_IID, (iid), 0),	\
-	.function = __builtin_choose_expr((fun) != SSAM_ANY_FUN, (fun), 0)
+	.target   = __builtin_choose_expr((tid) != SSAM_SSH_TID_ANY, (tid), 0),	\
+	.instance = __builtin_choose_expr((iid) != SSAM_SSH_IID_ANY, (iid), 0),	\
+	.function = __builtin_choose_expr((fun) != SSAM_SSH_FUN_ANY, (fun), 0)
 
 /**
  * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
@@ -113,18 +113,18 @@ struct ssam_device_uid {
  *
  * Initializes a &struct ssam_device_id with the given parameters in the
  * virtual domain. See &struct ssam_device_uid for details regarding the
- * parameters. The special values %SSAM_ANY_TID, %SSAM_ANY_IID, and
- * %SSAM_ANY_FUN can be used to specify that matching should ignore target ID,
+ * parameters. The special values %SSAM_SSH_TID_ANY, %SSAM_SSH_IID_ANY, and
+ * %SSAM_SSH_FUN_ANY can be used to specify that matching should ignore target ID,
  * instance ID, and/or sub-function, respectively. This macro initializes the
  * ``match_flags`` field based on the given parameters.
  *
  * Note: The parameter @cat must be a valid &u8 value, the parameters @tid,
- * @iid, and @fun must be either valid &u8 values or %SSAM_ANY_TID,
- * %SSAM_ANY_IID, or %SSAM_ANY_FUN, respectively. Other non-&u8 values are not
+ * @iid, and @fun must be either valid &u8 values or %SSAM_SSH_TID_ANY,
+ * %SSAM_SSH_IID_ANY, or %SSAM_SSH_FUN_ANY, respectively. Other non-&u8 values are not
  * allowed.
  */
 #define SSAM_VDEV(cat, tid, iid, fun) \
-	SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
+	SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, SSAM_SSH_TID_##tid, iid, fun)
 
 /**
  * SSAM_SDEV() - Initialize a &struct ssam_device_id as physical SSH device
@@ -136,18 +136,18 @@ struct ssam_device_uid {
  *
  * Initializes a &struct ssam_device_id with the given parameters in the SSH
  * domain. See &struct ssam_device_uid for details regarding the parameters.
- * The special values %SSAM_ANY_TID, %SSAM_ANY_IID, and %SSAM_ANY_FUN can be
- * used to specify that matching should ignore target ID, instance ID, and/or
- * sub-function, respectively. This macro initializes the ``match_flags``
- * field based on the given parameters.
+ * The special values %SSAM_SSH_TID_ANY, %SSAM_SSH_IID_ANY, and
+ * %SSAM_SSH_FUN_ANY can be used to specify that matching should ignore target
+ * ID, instance ID, and/or sub-function, respectively. This macro initializes
+ * the ``match_flags`` field based on the given parameters.
  *
  * Note: The parameter @cat must be a valid &u8 value, the parameters @tid,
- * @iid, and @fun must be either valid &u8 values or %SSAM_ANY_TID,
- * %SSAM_ANY_IID, or %SSAM_ANY_FUN, respectively. Other non-&u8 values are not
- * allowed.
+ * @iid, and @fun must be either valid &u8 values or %SSAM_SSH_TID_ANY,
+ * %SSAM_SSH_IID_ANY, or %SSAM_SSH_FUN_ANY, respectively. Other non-&u8 values
+ * are not allowed.
  */
 #define SSAM_SDEV(cat, tid, iid, fun) \
-	SSAM_DEVICE(SSAM_DOMAIN_SERIALHUB, SSAM_SSH_TC_##cat, tid, iid, fun)
+	SSAM_DEVICE(SSAM_DOMAIN_SERIALHUB, SSAM_SSH_TC_##cat, SSAM_SSH_TID_##tid, iid, fun)
 
 /*
  * enum ssam_device_flags - Flags for SSAM client devices.
-- 
2.38.1

