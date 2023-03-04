Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623FC6AAC30
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCDTqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCDTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:46:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F26E1C318;
        Sat,  4 Mar 2023 11:46:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h11so5259361wrm.5;
        Sat, 04 Mar 2023 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677959195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35FOCHiR9xZSsWxch4KScyExSwzamtOfhF9aFMlWRRY=;
        b=Bu8EVVmNHp7/Vm3AlqR84z5HrM/ad5aZ0ZhBq5HE8U+KqeV+FuEVE/B5M2381ESnit
         5dMzDcZrXIdWbidkGdT9uYFM1yXMitNoEIpp9zykFOluiS/e3a+uOXyUHR6d6+ee5F8S
         0Ha9L8JiSqqUYp7FWGe/6VWsfcyAr1teYNe/uyH7029TxOUQYppPvkTnqHO4DczUIhiT
         8F+0uEeK3dwm5sV3iom073hqQ+uzJ+E8zbec40rs0Sd7XOAwzlS0ZDLTebACl9znRHSj
         ZJ75xv/d6epH3Ebn/+oyKwjf1QQ4+PIBU0ImaYXi6lnDlnS5E8uHdsgm4rrHfG6f2yDO
         WFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677959195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35FOCHiR9xZSsWxch4KScyExSwzamtOfhF9aFMlWRRY=;
        b=qa2icfqVnVXni5JTNbkmSCMTwdrJIFpPozgIERvYtsU2RqFHBvrP42GUToUr3Mv5zv
         QCVG5MvQeJ1k4IWMM1myTuxfLpGqbhbjhOdESQzEiDKjb6IFG10lATilUuAoT3UpBBGS
         DJ9XyU8kgx+vIrJIe2S66VWnXvPEpIyJoVdBzXHEcBoJ9fv/xK5WiwjxfmOiViKEOp22
         FcOWbNC1VLIjExQylvO+N151tBJ+7ZQXprSaK4Sl3Q2DM+NSSvJNHwLOwMCLAuy61La7
         C4IdXbM3Fxu1GCOIjeYBGhS0XiY3zQJMEWTk4op0aF6Uag0BTNMLkt44buHJekqXxUVf
         jbiQ==
X-Gm-Message-State: AO0yUKXu1JSRZ49GviPjCf0Niehb7DrGAm9lotEHIw5QkdxSKDeTeP7t
        +/Rvl7bduEdLZk3OFX336JU=
X-Google-Smtp-Source: AK7set9rIGp30rL8p8yVk773/FCJIi4M5wOFpv4E1njfy6qd6vV1pE4FIxCxeTsXLXL4ArN3y32WNg==
X-Received: by 2002:adf:f9d1:0:b0:2c7:f2f:e47 with SMTP id w17-20020adff9d1000000b002c70f2f0e47mr4093486wrr.22.1677959195408;
        Sat, 04 Mar 2023 11:46:35 -0800 (PST)
Received: from xws.localdomain ([217.138.207.232])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003e2052bad94sm10696067wms.33.2023.03.04.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:46:34 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/3] platform/surface: aggregator_tabletsw: Properly handle different posture source IDs
Date:   Sat,  4 Mar 2023 20:46:09 +0100
Message-Id: <20230304194611.87770-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304194611.87770-1-luzmaximilian@gmail.com>
References: <20230304194611.87770-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device posture subsystem (POS) can provide different posture
sources. Different sources can provide different posture states and
sources can be identified by their ID.

For example, screen posture of the Surface Laptop Studio (SLS), which is
currently the only supported source, uses a source ID of 0x03. The
Surface Pro 9 uses the same subsystem for its Type-Cover, however,
provides different states for that under the ID 0x00.

To eventually support the Surface Pro 9 and potential future devices, we
need to properly disambiguate between source IDs. Therefore, add the
source ID to the state we carry and determine the tablet-mode state (as
well as state names) based on that.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_tabletsw.c     | 123 ++++++++++++------
 1 file changed, 84 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 9fed800c7cc0..e8682f52558f 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -20,16 +20,23 @@
 
 struct ssam_tablet_sw;
 
+struct ssam_tablet_sw_state {
+	u32 source;
+	u32 state;
+};
+
 struct ssam_tablet_sw_ops {
-	int (*get_state)(struct ssam_tablet_sw *sw, u32 *state);
-	const char *(*state_name)(struct ssam_tablet_sw *sw, u32 state);
-	bool (*state_is_tablet_mode)(struct ssam_tablet_sw *sw, u32 state);
+	int (*get_state)(struct ssam_tablet_sw *sw, struct ssam_tablet_sw_state *state);
+	const char *(*state_name)(struct ssam_tablet_sw *sw,
+				  const struct ssam_tablet_sw_state *state);
+	bool (*state_is_tablet_mode)(struct ssam_tablet_sw *sw,
+				     const struct ssam_tablet_sw_state *state);
 };
 
 struct ssam_tablet_sw {
 	struct ssam_device *sdev;
 
-	u32 state;
+	struct ssam_tablet_sw_state state;
 	struct work_struct update_work;
 	struct input_dev *mode_switch;
 
@@ -45,9 +52,11 @@ struct ssam_tablet_sw_desc {
 
 	struct {
 		u32 (*notify)(struct ssam_event_notifier *nf, const struct ssam_event *event);
-		int (*get_state)(struct ssam_tablet_sw *sw, u32 *state);
-		const char *(*state_name)(struct ssam_tablet_sw *sw, u32 state);
-		bool (*state_is_tablet_mode)(struct ssam_tablet_sw *sw, u32 state);
+		int (*get_state)(struct ssam_tablet_sw *sw, struct ssam_tablet_sw_state *state);
+		const char *(*state_name)(struct ssam_tablet_sw *sw,
+					  const struct ssam_tablet_sw_state *state);
+		bool (*state_is_tablet_mode)(struct ssam_tablet_sw *sw,
+					     const struct ssam_tablet_sw_state *state);
 	} ops;
 
 	struct {
@@ -61,7 +70,7 @@ struct ssam_tablet_sw_desc {
 static ssize_t state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ssam_tablet_sw *sw = dev_get_drvdata(dev);
-	const char *state = sw->ops.state_name(sw, sw->state);
+	const char *state = sw->ops.state_name(sw, &sw->state);
 
 	return sysfs_emit(buf, "%s\n", state);
 }
@@ -79,19 +88,19 @@ static const struct attribute_group ssam_tablet_sw_group = {
 static void ssam_tablet_sw_update_workfn(struct work_struct *work)
 {
 	struct ssam_tablet_sw *sw = container_of(work, struct ssam_tablet_sw, update_work);
+	struct ssam_tablet_sw_state state;
 	int tablet, status;
-	u32 state;
 
 	status = sw->ops.get_state(sw, &state);
 	if (status)
 		return;
 
-	if (sw->state == state)
+	if (sw->state.source == state.source && sw->state.state == state.state)
 		return;
 	sw->state = state;
 
 	/* Send SW_TABLET_MODE event. */
-	tablet = sw->ops.state_is_tablet_mode(sw, state);
+	tablet = sw->ops.state_is_tablet_mode(sw, &state);
 	input_report_switch(sw->mode_switch, SW_TABLET_MODE, tablet);
 	input_sync(sw->mode_switch);
 }
@@ -146,7 +155,7 @@ static int ssam_tablet_sw_probe(struct ssam_device *sdev)
 	sw->mode_switch->id.bustype = BUS_HOST;
 	sw->mode_switch->dev.parent = &sdev->dev;
 
-	tablet = sw->ops.state_is_tablet_mode(sw, sw->state);
+	tablet = sw->ops.state_is_tablet_mode(sw, &sw->state);
 	input_set_capability(sw->mode_switch, EV_SW, SW_TABLET_MODE);
 	input_report_switch(sw->mode_switch, SW_TABLET_MODE, tablet);
 
@@ -203,9 +212,10 @@ enum ssam_kip_cover_state {
 	SSAM_KIP_COVER_STATE_FOLDED_BACK   = 0x05,
 };
 
-static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 state)
+static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw,
+					     const struct ssam_tablet_sw_state *state)
 {
-	switch (state) {
+	switch (state->state) {
 	case SSAM_KIP_COVER_STATE_DISCONNECTED:
 		return "disconnected";
 
@@ -222,14 +232,15 @@ static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 stat
 		return "folded-back";
 
 	default:
-		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %u\n", state);
+		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %u\n", state->state);
 		return "<unknown>";
 	}
 }
 
-static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 state)
+static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw,
+						const struct ssam_tablet_sw_state *state)
 {
-	switch (state) {
+	switch (state->state) {
 	case SSAM_KIP_COVER_STATE_DISCONNECTED:
 	case SSAM_KIP_COVER_STATE_FOLDED_CANVAS:
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
@@ -240,7 +251,7 @@ static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 s
 		return false;
 
 	default:
-		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %d\n", sw->state);
+		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %d\n", state->state);
 		return true;
 	}
 }
@@ -252,7 +263,7 @@ SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_get_cover_state, u8, {
 	.instance_id     = 0x00,
 });
 
-static int ssam_kip_get_cover_state(struct ssam_tablet_sw *sw, u32 *state)
+static int ssam_kip_get_cover_state(struct ssam_tablet_sw *sw, struct ssam_tablet_sw_state *state)
 {
 	int status;
 	u8 raw;
@@ -263,7 +274,8 @@ static int ssam_kip_get_cover_state(struct ssam_tablet_sw *sw, u32 *state)
 		return status;
 	}
 
-	*state = raw;
+	state->source = 0;	/* Unused for KIP switch. */
+	state->state = raw;
 	return 0;
 }
 
@@ -312,11 +324,15 @@ MODULE_PARM_DESC(tablet_mode_in_slate_state, "Enable tablet mode in slate device
 #define SSAM_EVENT_POS_CID_POSTURE_CHANGED	0x03
 #define SSAM_POS_MAX_SOURCES			4
 
-enum ssam_pos_state {
-	SSAM_POS_POSTURE_LID_CLOSED = 0x00,
-	SSAM_POS_POSTURE_LAPTOP     = 0x01,
-	SSAM_POS_POSTURE_SLATE      = 0x02,
-	SSAM_POS_POSTURE_TABLET     = 0x03,
+enum ssam_pos_source_id {
+	SSAM_POS_SOURCE_SLS   = 0x03,
+};
+
+enum ssam_pos_state_sls {
+	SSAM_POS_SLS_LID_CLOSED = 0x00,
+	SSAM_POS_SLS_LAPTOP     = 0x01,
+	SSAM_POS_SLS_SLATE      = 0x02,
+	SSAM_POS_SLS_TABLET     = 0x03,
 };
 
 struct ssam_sources_list {
@@ -324,42 +340,68 @@ struct ssam_sources_list {
 	__le32 id[SSAM_POS_MAX_SOURCES];
 } __packed;
 
-static const char *ssam_pos_state_name(struct ssam_tablet_sw *sw, u32 state)
+static const char *ssam_pos_state_name_sls(struct ssam_tablet_sw *sw, u32 state)
 {
 	switch (state) {
-	case SSAM_POS_POSTURE_LID_CLOSED:
+	case SSAM_POS_SLS_LID_CLOSED:
 		return "closed";
 
-	case SSAM_POS_POSTURE_LAPTOP:
+	case SSAM_POS_SLS_LAPTOP:
 		return "laptop";
 
-	case SSAM_POS_POSTURE_SLATE:
+	case SSAM_POS_SLS_SLATE:
 		return "slate";
 
-	case SSAM_POS_POSTURE_TABLET:
+	case SSAM_POS_SLS_TABLET:
 		return "tablet";
 
 	default:
-		dev_warn(&sw->sdev->dev, "unknown device posture: %u\n", state);
+		dev_warn(&sw->sdev->dev, "unknown device posture for SLS: %u\n", state);
 		return "<unknown>";
 	}
 }
 
-static bool ssam_pos_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 state)
+static const char *ssam_pos_state_name(struct ssam_tablet_sw *sw,
+				       const struct ssam_tablet_sw_state *state)
+{
+	switch (state->source) {
+	case SSAM_POS_SOURCE_SLS:
+		return ssam_pos_state_name_sls(sw, state->state);
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown device posture source: %u\n", state->source);
+		return "<unknown>";
+	}
+}
+
+static bool ssam_pos_state_is_tablet_mode_sls(struct ssam_tablet_sw *sw, u32 state)
 {
 	switch (state) {
-	case SSAM_POS_POSTURE_LAPTOP:
-	case SSAM_POS_POSTURE_LID_CLOSED:
+	case SSAM_POS_SLS_LAPTOP:
+	case SSAM_POS_SLS_LID_CLOSED:
 		return false;
 
-	case SSAM_POS_POSTURE_SLATE:
+	case SSAM_POS_SLS_SLATE:
 		return tablet_mode_in_slate_state;
 
-	case SSAM_POS_POSTURE_TABLET:
+	case SSAM_POS_SLS_TABLET:
 		return true;
 
 	default:
-		dev_warn(&sw->sdev->dev, "unknown device posture: %u\n", state);
+		dev_warn(&sw->sdev->dev, "unknown device posture for SLS: %u\n", state);
+		return true;
+	}
+}
+
+static bool ssam_pos_state_is_tablet_mode(struct ssam_tablet_sw *sw,
+					  const struct ssam_tablet_sw_state *state)
+{
+	switch (state->source) {
+	case SSAM_POS_SOURCE_SLS:
+		return ssam_pos_state_is_tablet_mode_sls(sw, state->state);
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown device posture source: %u\n", state->source);
 		return true;
 	}
 }
@@ -450,9 +492,10 @@ static int ssam_pos_get_posture_for_source(struct ssam_tablet_sw *sw, u32 source
 	return 0;
 }
 
-static int ssam_pos_get_posture(struct ssam_tablet_sw *sw, u32 *state)
+static int ssam_pos_get_posture(struct ssam_tablet_sw *sw, struct ssam_tablet_sw_state *state)
 {
 	u32 source_id;
+	u32 source_state;
 	int status;
 
 	status = ssam_pos_get_source(sw, &source_id);
@@ -461,13 +504,15 @@ static int ssam_pos_get_posture(struct ssam_tablet_sw *sw, u32 *state)
 		return status;
 	}
 
-	status = ssam_pos_get_posture_for_source(sw, source_id, state);
+	status = ssam_pos_get_posture_for_source(sw, source_id, &source_state);
 	if (status) {
 		dev_err(&sw->sdev->dev, "failed to get posture value for source %u: %d\n",
 			source_id, status);
 		return status;
 	}
 
+	state->source = source_id;
+	state->state = source_state;
 	return 0;
 }
 
-- 
2.39.2

