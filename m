Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2A63DBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiK3RNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiK3RMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:12:31 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13181837E9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:08:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 140so17411356pfz.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtB22ckpAeQTvW+2h2vhfpvkHho96FIUyOTjkXi8z4s=;
        b=mNLuBvJPsaKHf2okXvPTyzE7P7jC2dz2zM38h0ssXWF93vRO18bNkEgbK4pb6Q/aRY
         0Cf/H2DxiDMJOrq55Ea28d+DlkItHPqnRNPZdyVpcUgghgc7omeVnNNiQfj3HIkv5CeH
         ZZUZl9K0SrMLiAxNYuLTKm8KFjJOI/ZWfW25Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtB22ckpAeQTvW+2h2vhfpvkHho96FIUyOTjkXi8z4s=;
        b=ZxbA2j1BFpRLY6Ag3se2CApsmUM9u3DtdW1TY+HgqtfuHN3VlNZ43OZWFlRskDuL9z
         EVb/h/3N/3ocMoHkb4rVzaj0dN8rikgo3RHbCp6ACOr63zkqA4brUI6dVMz6OyJcGFFX
         QdaSaxZmsnl0H4E5GsKVvCJP04glhlT38pmQumxFIMdUOivDRKUTsW0dq4XcPGPRHGD4
         WG3Px6UO54ZkZAhVSbaOVXSDg186pUD5ILfbpKBqgLSyjXPaniM087uFM8z7RilfSloG
         Y/3Np8uI74VgxgxRTUerzfrBhi/MjPpUbZrlmXEP4qwcUoGYVYH7CVtetqc8cjiBCcJI
         6v9g==
X-Gm-Message-State: ANoB5pnJ5yjEVkvozvjEsAD88daTUzVDaC9ySNIAiCJy18v/dnItk5RT
        7ErxtUE2tQMkB/AcI/fevICCIBfCmRHB5g==
X-Google-Smtp-Source: AA0mqf49/qbqY4E3emNHvIlO5NfDZ4wHtB9xsvfwRSDeKFr5GX5Fz6byZzDmZIolP1Xj+B0TybrVsg==
X-Received: by 2002:a63:1464:0:b0:46a:f665:ed96 with SMTP id 36-20020a631464000000b0046af665ed96mr37677681pgu.486.1669828123067;
        Wed, 30 Nov 2022 09:08:43 -0800 (PST)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id x28-20020aa79a5c000000b0056b8181861esm1707154pfj.19.2022.11.30.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:08:42 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Ballway <ballway@chromium.org>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH] drm: Add orientation quirk for DynaBook K50
Date:   Wed, 30 Nov 2022 17:08:22 +0000
Message-Id: <20221130170811.1.Iee9a494547541dade9eeee9521cc8b811e76a8a0@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

Like the ASUS T100HAN for which there is already a quirk,
the DynaBook K50 has a 800x1280 portrait screen mounted
in the tablet part of a landscape oriented 2-in-1.
Update the quirk to be more generic and apply to this device.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---

 .../gpu/drm/drm_panel_orientation_quirks.c    | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 52d8800a8ab86..14f870fb2db04 100644
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
@@ -121,6 +115,12 @@ static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
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
@@ -151,7 +151,7 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
 		},
-		.driver_data = (void *)&asus_t100ha,
+		.driver_data = (void *)&lcd800x1280_leftside_up,
 	}, {	/* Asus T101HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
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
2.38.1.584.g0f3c55d4c2-goog

