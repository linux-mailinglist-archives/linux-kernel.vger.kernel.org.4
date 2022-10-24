Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C760A793
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiJXMwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiJXMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:48:07 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC29D15719
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:12:32 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id 192so1626253pfx.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghtJtVJhPw81MXq6/J6quq2LuUHiKWw8lzS+pFTBsP0=;
        b=cZrJzXH//QTytM0WW2x60eVTJWmr4XlL39TbHpKK3q3WQCrSwZnjVPRWyiABmgouTe
         tcWaVYaRKc8hu79d1xDnlFcNITHqD8aagxIfdW/j33EuRzv9/LyBezR8gcIDeuDjMBdi
         Ipdx3WUUwYagpuujWId9VshSvfmg5KdxiBBTFEGB4woUWAXr+bNyz5W7lNqKncoZTj5V
         OtqnOJcGCmy/ESZHdgjapJ1vmW0D4ruK7a2seAn0eeRS8/38sQjcPxnlad2eAV61+hmK
         GkeCBWxM+dUrzuzssuopdvmaQwwmpmxNgwGhyMJjD/yNfawG/7R+9RDafwqQFOoJ0z9Q
         ANrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghtJtVJhPw81MXq6/J6quq2LuUHiKWw8lzS+pFTBsP0=;
        b=W0oUd7aXp344ctaQbs8b2LR8RwQ9WIMsSo+lUKbWdxZKUAlWmDs5/4k+tWTDj+pxXn
         f16vVvAIC3i3FUfbwyJBZ+gH3EUyqhwq+oqvXGr9Z+mrDvmiVK0gBNWnAmcqPJJcgtmz
         SxlIOL/sY8haFZwGUL68zabaKar6HO325Tt/Ubsk5WCX8hEJDluAnSDb+Y5VZ0/0t3jK
         c0MNK4wKuohUalgPsKWeTVDEXmM6w8Ol8IVAtZcg8j7Bq1+wAYdFH5iaXLLI0ezFubaj
         WKpLdN5hVIdCb4UWYIuDWrOn+ptgHScBlE4AfbEmwX4opoOyu4CZTDcc+YkmNl8tQJG7
         n2Og==
X-Gm-Message-State: ACrzQf3fVmue9i4OKeTrmnKBDGkLtwsBGDZG4athu5BDxYCoJ/GZuXj1
        0rjL11JuhM2M5RtT+Mszu0ICk9+9d/hqDWmN
X-Google-Smtp-Source: AMsMyM7jVfOb4cdFC5JDiHJLWBD4KDzAtatMaD5/Pd8TR8fUHas2SHGFltiDcGGdPiW3YBak6k10IA==
X-Received: by 2002:a63:dc54:0:b0:44c:ce26:fa35 with SMTP id f20-20020a63dc54000000b0044cce26fa35mr28698734pgj.374.1666611492363;
        Mon, 24 Oct 2022 04:38:12 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:38:11 -0700 (PDT)
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
Subject: [PATCH 18/22] platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:09 +0900
Message-Id: <20221024113513.5205-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/toshiba_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 160abd3b3af8..3d747a901ad8 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2978,7 +2978,7 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
 		return 0;
 	}
 
-	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
 		return 0;
 
 	memset(&props, 0, sizeof(props));
-- 
2.37.3

