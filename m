Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF560A22C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJXLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJXLig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:38:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D31059EA9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:37:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3135962pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3/qt1OzaBc9a5GsaEcxXWSHAm3X31gczykCRrhGnKw=;
        b=lOEcU4RGCEfGg+wnfVs0l7n30cTg9FbZcgkthaptWevuzG9Ssi+9oWFgfDpyitG3Tk
         OuLI1JcLxzeALUawRzgQ4OCHUQAGKneDBweTsEC2z2rv/dy7b2CVz85QxzVHNDeK3Mlb
         xsxvq1aCJ5rCSCJDSgTd1x0eL49i7F01FPf3bevhsJTjMKGOtn1fRwPcWjyhr7lR2spk
         XeIQqVeTz/3QdhnRwjU1wp6PSyaOIKZ5MzRhwmkzlX7C/eeOdJtAKw9fT8Pc1B5311gv
         y6ZojtRQW/tr/7t2nMkDZNTzuYYeLPsaTucm9GFd6bYXgmrWG6KMd06zb2097bHNbdj6
         vLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3/qt1OzaBc9a5GsaEcxXWSHAm3X31gczykCRrhGnKw=;
        b=28M1jeBRo6jIbYLQJdqIMB/AyKiPxsA8Mbvw2BtUIeaFARpYvdFic7bdrC+1lmQY9O
         bN1JrH55KIMmKctcRRIYb5RzMTfUntba4G/0HcwTBb8PmagKbn5yLTp1XtdUjR7rD/Vn
         8/ZlKdzKwNd4d9XJ3ezaUsSVvAKIkmR/VRneYUfBBNk6tcFz5CDMJC3duESj/4zpSLun
         E/7xDwv31G9gkrcK894m9B9vOGzzj5XCO6CF1324DjbIlsM9AYfEUXpqpYLCzpAlR3wf
         7jeU75S1xMWdE+njz3gYcvkkATlb6wm+aID9whTQ1K9XkvmSnehO+s1i0PRLxRx+WkMJ
         oCGA==
X-Gm-Message-State: ACrzQf076C+39Z+bFqXer3FMY/Q1rkv/Ntaovdm/Dl30BMUXOC4L+eKA
        hCGuoTA4a8iD7dTUpibm5Vpbcw==
X-Google-Smtp-Source: AMsMyM4VgcDLQ4Mdfbv6hIeokV3STzkHDHm8r2Jacxl6wRFbQoIXcyKQ22yPaEG8fZMahC4Fy+BnrA==
X-Received: by 2002:a17:902:7281:b0:178:388d:6f50 with SMTP id d1-20020a170902728100b00178388d6f50mr33837351pll.127.1666611416833;
        Mon, 24 Oct 2022 04:36:56 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:36:56 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 09/22] platform/x86: fujitsu-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:00 +0900
Message-Id: <20221024113513.5205-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/fujitsu-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index b543d117b12c..e820de39cb68 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -387,7 +387,7 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	struct fujitsu_bl *priv;
 	int ret;
 
-	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
 		return -ENODEV;
 
 	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
@@ -819,7 +819,7 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 
 	/* Sync backlight power status */
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
-	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
+	    (acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR)) {
 		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2,
 				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
-- 
2.37.3

