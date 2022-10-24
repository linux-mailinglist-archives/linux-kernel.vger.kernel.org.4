Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DAC60A276
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiJXLnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiJXLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:43:15 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F066C130
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:40:34 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id h185so8430034pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiSdINSVFRYviECfxwDXkA1dnuYyyTGGZx7DJKOoYJs=;
        b=iGtXR8pxJeARtYM65YtWK/rMT1cGkHNCbn5om85YN4tLiOmmeq2/FBvx3pSpv/m1Sr
         Va9GHFdP0chf3eQTUSVDangVFZ/dqZDSfu19hibg9oS2kk/KlgfVT6JFeQ68GHunlhzC
         se1sWoi2z1fTcKdw8FOIcyCxwwKqRbZobTBVM7iGls36LCpZ3DZIX0Tfn7Kb0gOkShSW
         pNe8W3N4rMeldUr8oUAlIfVjHR6cNauEMm0EGdVKOdZI/PPmhyAtOJqcxE6jGzxL2wA6
         7MgNHiUTVhnxOnZse4TBGZUhOboi/UB4XI8imIbLRZSiYGhvYc8SoFkFpIFpQvLUOsh+
         Hp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiSdINSVFRYviECfxwDXkA1dnuYyyTGGZx7DJKOoYJs=;
        b=30kk+1kruttFMUthmCI0hOb8WvzsKNMU4KGg6cuBCmRwGV9p5rzhxmXxWshxYnOTqd
         GUycm8C5F+NwISoDfHHnXshVTRU3Ue9O2DXjY7wyERyKqXqOzj4DXxiJkg6hK8lpGanZ
         f8W9zspFKPMcpPs4pdICzS4zlhc/1c9joUsqZXJQg8YBScn5EICnWo8RfFTiO/Xpu9Aw
         4pNnk/UGgIiRQ/Kwl4nLNQU4eSECNjCGtrbhXOsyzKq6v3uYrPzqhoHQl3c1QhWu6QhJ
         9UaIEHeo9of6a8NvVJmmUTM0Napu2dDt1OXPMvvrfLOeywsjcjwmH/F4NAXo2MRdQ2s6
         BRsA==
X-Gm-Message-State: ACrzQf2c3GRQmHkBTRWUwAxLZuzL/PBKCvvI1s96I2hIl6/0tpWYsviI
        K+GP6TwI3fyEsY4oDvlfs16vOuPoKqEY/UR9
X-Google-Smtp-Source: AMsMyM7XYF0/Ljt4MGKz/TruSqF/tNgb9whiXQXnKj0J8NH8HwiMDdKOolztUet8v/T3k84ugzg6BQ==
X-Received: by 2002:a17:902:7297:b0:17f:93b5:5ecc with SMTP id d23-20020a170902729700b0017f93b55eccmr32624764pll.93.1666611467259;
        Mon, 24 Oct 2022 04:37:47 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:46 -0700 (PDT)
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
Subject: [PATCH 15/22] platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:06 +0900
Message-Id: <20221024113513.5205-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/samsung-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index b4aa8ba35d2d..8ba377df73e8 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1574,7 +1574,7 @@ static int __init samsung_init(void)
 	samsung->handle_backlight = true;
 	samsung->quirks = quirks;
 
-	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
 		samsung->handle_backlight = false;
 
 	ret = samsung_platform_init(samsung);
-- 
2.37.3

