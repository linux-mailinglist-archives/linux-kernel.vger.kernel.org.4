Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6036261FD54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKGSVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:21:19 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F9B61
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:21:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y13so11399111pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEQi0/+u8veZ/2x0qc40UHF2USFTrhR6G0DysBhXZXI=;
        b=LP8/2nP0rU35VDrVzIm8r3aawUgEGEjeds1NWZ3MKIAXwKbnfYaL61xaLw5DJUjSbP
         t35cImTYyrnWr+QQZzrsULG/iLZqJge9e6vvvQ2RWuTpoXfHUltTAwtQvUALvGiB6sK7
         B6PJ1tc9KlAxIzjLum0d1WdI9VRanVblWEsW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEQi0/+u8veZ/2x0qc40UHF2USFTrhR6G0DysBhXZXI=;
        b=S9FWYUzyPttaGx3A9RzV+puYg04hQ+dPD6VIb+bYQTu9gdeBdWSl/LwosQorIBSrDs
         pU/HgUVt8TX1qk+JApmydNs3gdSP4dfrER3W9uMJt/2H4jyN7K4sct9cqxyKfPLwnc+u
         CPhjurhZKiSHfOdf9R/DH3HLslSqpKk4LUVy/IAi2Bd0ql9rVJgveKYQHWD7/qKC6Hk1
         7TzsQiyy37KUhatAlAWwA1HGF+hQZ+9kz6WQBourEb26AM6xeyiKj4IbxkRIxUX5XDCH
         4IU7oEk3yXV9GqNhMUJhKC4rZhiqDYLSbRV1jpqbh76k1013JnswpfVm2o13RdJztYbZ
         HDWQ==
X-Gm-Message-State: ACrzQf0Pczcn8jKXabYeASW4wkEc5U5GW6b4KJrWh5XW+KzWZZr/no2S
        +sl8+OmMjTGvt8gcIk1WqImKv9Nit9SR/g==
X-Google-Smtp-Source: AMsMyM4Kx2Eg71jXuGHQSET20bNsEeHDP4AS5JSlnikAhQBj+uUCLRYCfKMosTwy3XPlQDDxtdB4ZA==
X-Received: by 2002:a05:6a00:234d:b0:561:f0c3:cde1 with SMTP id j13-20020a056a00234d00b00561f0c3cde1mr51847397pfj.34.1667845277663;
        Mon, 07 Nov 2022 10:21:17 -0800 (PST)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78f21000000b005613220346asm4749132pfr.205.2022.11.07.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:21:17 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allen Ballway <ballway@chromium.org>
Subject: [PATCH] drm: Add orientation quirk for DynaBook K50
Date:   Mon,  7 Nov 2022 18:21:06 +0000
Message-Id: <20221107182101.1.I8819de823145ea8234d19c526f933a7d16471835@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panel is 800x1280 but mounted on a detachable form factor sidways.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---

 .../gpu/drm/drm_panel_orientation_quirks.c    | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index fc1728d46ac2a..8c4b007081730 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -30,12 +30,6 @@ struct drm_dmi_panel_orientation_data {
 	int orientation;
 };

-static const struct drm_dmi_panel_orientation_data asus_t100ha = {
-	.width = 800,
-	.height = 1280,
-	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
-};
-
 static const struct drm_dmi_panel_orientation_data gpd_micropc = {
 	.width = 720,
 	.height = 1280,
@@ -115,6 +109,12 @@ static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };

+static const struct drm_dmi_panel_orientation_data lcd800x1280_leftside_up = {
+	.width = 800,
+	.height = 1280,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1600x2560_leftside_up = {
 	.width = 1600,
 	.height = 2560,
@@ -133,7 +133,7 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
 		},
-		.driver_data = (void *)&asus_t100ha,
+		.driver_data = (void *)&lcd800x1280_leftside_up,
 	}, {	/* Asus T101HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
@@ -172,6 +172,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 pro tablet"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Dynabook K50 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "dynabook K50/FR"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
 	}, {	/* GPD MicroPC (generic strings, also match on bios date) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
--
2.38.1.431.g37b22c650d-goog

