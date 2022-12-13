Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0C64BAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiLMRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiLMRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:11:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7311AD90
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:11:37 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so5290372ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzPRmPJd5jX18eH45PIAN8StaeBDhiKrmupibyDWdg8=;
        b=FcHqQZiQueKJ651RYxOjnxiNoPcwp76wuWOgFrCSmWSBDLfAvtqqjxjqU1EEPe9eEc
         XlrVgbFDhlVhxOxc6xya0KapeOs5Jk6fRw7iNKkD+8uoop7CqZ0AU++wuC8fE5ap/pwk
         LRMrEcspEEvcopA+/mDOujTzVtkEXotR4+SsRdUcJ08HTbaS2pjkjaHyNbY+VS1pRQgJ
         b5IXRVZIkYuNmWXb/FvLyICQ3SJmtnTYkYIsTnjY2t4wyENdzHzkljl6dE5iG1lt6Hl7
         eDlFhgsfWfCgST9oAJ8/Rqd7VOPIhaS7cgn5BUKejl6kEB6wZYXYpSVVNcOfFJjSoeyO
         FB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzPRmPJd5jX18eH45PIAN8StaeBDhiKrmupibyDWdg8=;
        b=2h/6q25XDCECeAi5OFWtdk63Cyb6D0y/R0TTTChHU1dEjzWRSKVj93r00qdVJ2w+8U
         dDavD34bvDN1OG2Clf4Aw/fDE8akjn5GS1rHip3lJmiVbY7j0/Tv52BVHNhwamupFbKS
         Tnltq2zUre/ts0K+0wBeib/u7jMgsEJzXOKrwz5iDM60AS6b+CxLRkgVZ9FvxpLPNM/q
         8Y8xGACj/jCC0/RYgRxWSuixKP9yLFJAc7OjVtvuKKUFHbMH8wazQGYF1zHJw/OSt3bF
         NXGQVVjtEesFFIDaCV/H6exRzq90rOnuIXbZfD3kA87mvsHRU0klxd5hErZBRESnpcSr
         wG2g==
X-Gm-Message-State: ANoB5pnYZnM6C1XbitVeQpBJFNsVZhsGsm/M+bexpEFDWOWAHCUTl5H5
        lODDzRFBGCGaYyy4Kwi8Rztr7phOwKY=
X-Google-Smtp-Source: AA0mqf6x6l3ZDqo2+/4Ek7BNKuSl0keRsInOG2BuToRH9bhyxM43ZOygbLSbX1xxvPZ2/Oa/APLyag==
X-Received: by 2002:a92:c5cf:0:b0:304:bf1f:d72f with SMTP id s15-20020a92c5cf000000b00304bf1fd72fmr3730788ilt.32.1670951497030;
        Tue, 13 Dec 2022 09:11:37 -0800 (PST)
Received: from pop-os.. ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e02078400b003029afc3672sm3915512ils.36.2022.12.13.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:11:36 -0800 (PST)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirks for One XPlayer handheld variants
Date:   Tue, 13 Dec 2022 11:10:44 -0600
Message-Id: <20221213171044.14869-1-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have more handhelds in the One XPLAYER lineup now that needs support added to the orientation-quirks.
By adding more native resolution checks and the one unique BIOS variant available we add support to most devices.

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 .../gpu/drm/drm_panel_orientation_quirks.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 52d8800a8ab8..335d636e6696 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -103,6 +103,12 @@ static const struct drm_dmi_panel_orientation_data lcd800x1280_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd800x1280_leftside_up = {
+	.width = 800,
+	.height = 1280,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
 	.width = 1080,
 	.height = 1920,
@@ -115,6 +121,12 @@ static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1200x1920_leftside_up = {
+	.width = 1200,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
 	.width = 1280,
 	.height = 1920,
@@ -344,6 +356,24 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer Mini 800p */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
+	}, {	/* OneXPlayer Mini 1200p */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* OneXPlayer Mini A07 Bios Variant */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini A07"),
+		},
+		.driver_data = (void *)&lcd800x1280_leftside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.34.1

