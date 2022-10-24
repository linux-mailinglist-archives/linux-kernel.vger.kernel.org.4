Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291360A216
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJXLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJXLhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:37:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F094C41524
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:37:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so1135577pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqmnVvhO9UyNXVHf0JsSwhtfQtP7FaZ6t+IS8pLhYe4=;
        b=s196kKLMLpzulXUS4BLxdjP3PZud7xTpKqpKruF8CPkUOnlKaR/90Xeg2YiBo1lxHt
         0phPGBaGv8xL/2sJqtVjolNPplrc2gMArMrd38Fp4QY7w8IhO1gtyxxMyGg93VGpm0MM
         j/H+7JqUU0uyU9EbCNWGW0hSXVYMoeFxaVahwQmC5a0ogDrEldzdfFhw1y5wfPbeoDyv
         hhwAFpQRAr0P5gUGNLn3NAYvFzK96KUpTxDG6A6mcGTvTgwIFrZjd1qq4rg87X1gcrgv
         qVb+qSNOeTlneVvekKPumnA2sWUZNn6pea2DrTamA/nt4dzQ8wvTNCAad1chJdFMPTZm
         71eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqmnVvhO9UyNXVHf0JsSwhtfQtP7FaZ6t+IS8pLhYe4=;
        b=ky1a7GzNlfsFOjs86w+sPzUpapT2QDfDdXkskBr6ZRDWuhUFf8QLNL2AdxfSTP4y/X
         d2Q4l5fny+BfioKGSdaYbAsfzvVLXj1ADwQCqbdVoHhvokjrI1xI6cMWCtOG1qYVbx/5
         ljDx5hLNoU4Qm/3ShTXZ4q2GXUbSqaFaLUk+iYK6nt7u1mvmd4elP32A5uTc45j9onBF
         5knZQIhbu5PwNL7kytmMFgl65ozBLThoU2e2qh5fWCEnlZfrLQrU2P0Q41ZNX3GNNQzb
         DpMrHP5YfZpazDzk6HIke8iKpSK+juEFO+p6/o+x0H7vG5RvdgfNpJtFUnLDR9EY8Y7k
         PHlw==
X-Gm-Message-State: ACrzQf0YbNlyyMsna4XSrzRqnN4idUtQ/NtLNiabW0cQyBU8hQHJeFex
        HLA0aMgyu30KFNwsRwxf39GBMA==
X-Google-Smtp-Source: AMsMyM4bQCnNONbcQRCLJnNp3+V9paAm7JCDcLdkyq7fRJSwz3Z4S1McoGfU9dqTYLitGtEw6cnCGg==
X-Received: by 2002:a17:903:2014:b0:186:8937:28a6 with SMTP id s20-20020a170903201400b00186893728a6mr11907681pla.39.1666611357909;
        Mon, 24 Oct 2022 04:35:57 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:35:57 -0700 (PDT)
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
Subject: [PATCH 02/22] ACPI: video: Introduce acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:34:53 +0900
Message-Id: <20221024113513.5205-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This deprecates acpi_video_get_backlight_type().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/acpi/acpi_video.c   |  2 +-
 drivers/acpi/video_detect.c |  6 +++---
 include/acpi/video.h        | 12 ++++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 32953646caeb..63e41aac71bd 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1823,7 +1823,7 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 	if (video->backlight_registered)
 		return 0;
 
-	if (acpi_video_get_backlight_type() != acpi_backlight_video)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VIDEO))
 		return 0;
 
 	mutex_lock(&video->device_list_lock);
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0d9064a9804c..9cb12e4f06f7 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -17,13 +17,13 @@
  * Otherwise vendor specific drivers like thinkpad_acpi, asus-laptop,
  * sony_acpi,... can take care about backlight brightness.
  *
- * Backlight drivers can use acpi_video_get_backlight_type() to determine which
+ * Backlight drivers can use acpi_video_get_backlight_types() to determine which
  * driver should handle the backlight. RAW/GPU-driver backlight drivers must
  * use the acpi_video_backlight_use_native() helper for this.
  *
  * If CONFIG_ACPI_VIDEO is neither set as "compiled in" (y) nor as a module (m)
- * this file will not be compiled and acpi_video_get_backlight_type() will
- * always return acpi_backlight_vendor.
+ * this file will not be compiled and acpi_video_get_backlight_types() will
+ * always return ACPI_BACKLIGHT_VENDOR.
  */
 
 #include <linux/export.h>
diff --git a/include/acpi/video.h b/include/acpi/video.h
index a275c35e5249..a565ba27fae0 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -2,6 +2,7 @@
 #ifndef __ACPI_VIDEO_H
 #define __ACPI_VIDEO_H
 
+#include <linux/bits.h> /* for BIT */
 #include <linux/errno.h> /* for ENODEV */
 #include <linux/types.h> /* for bool */
 
@@ -52,6 +53,12 @@ enum acpi_backlight_type {
 	acpi_backlight_apple_gmux,
 };
 
+#define ACPI_BACKLIGHT_VIDEO BIT(acpi_backlight_video)
+#define ACPI_BACKLIGHT_VENDOR BIT(acpi_backlight_vendor)
+#define ACPI_BACKLIGHT_NATIVE BIT(acpi_backlight_native)
+#define ACPI_BACKLIGHT_NVIDIA_WMI_EC BIT(acpi_backlight_nvidia_wmi_ec)
+#define ACPI_BACKLIGHT_APPLE_GMUX BIT(acpi_backlight_apple_gmux)
+
 #if IS_ENABLED(CONFIG_ACPI_VIDEO)
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
@@ -97,4 +104,9 @@ static inline int acpi_video_get_levels(struct acpi_device *device,
 }
 #endif
 
+static inline int acpi_video_get_backlight_types(void)
+{
+	return BIT(acpi_video_get_backlight_type());
+}
+
 #endif
-- 
2.37.3

