Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F136560A268
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiJXLm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiJXLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:42:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A710FEA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:39:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so8421191pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3OBF2k1WWtiu/9/W0b3fBEExfrwFAb3nrGZKspwFWo=;
        b=ytZxwj2KO7mqmejMHz4K1suZIYKgKIzkLd7EE+hEIaFueculEZeXax0rPFi0rtL4lr
         7+UX9MXWjbBbOQgBjauyeX2QMEOfr0yZCF6Yw3NwAEtLYr/AzMr4Ggz7FIpB/9yGq8Ci
         CeNajiFIEw4FF3iTA4CXFtGn9bA7DoprnQKeIA0r/AGyzUh0lUH+M9A0yNAdx4uOwaCJ
         5pnLw55cfyxjSf2H2FfT7iT6gF3REqCaachB0bZ+Y5p8FvjdHYs2Vj4mZ7V1Pkvhp4jO
         2xvAEzb4JSHAaQiHka7I4JxM52qtVtkqOhQWV7jRFiYQ4mE4otcRDd17QUh9/ZoY/MYV
         r1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3OBF2k1WWtiu/9/W0b3fBEExfrwFAb3nrGZKspwFWo=;
        b=6xhGrP4E9tAuH+p6Va8zQ3kZ5lyIPf+B+j1ovXi4ftxYM8xw37Md/nLfGSwAhRnM73
         Z5mEqqeel/FtxV+lTfRcMrtIWCG9g5Jvv4qJtZod04mI/PDaUYcebAU575CJCJReHoQ0
         rXNiI0ajCA7syaYuDhnP24sKPS3iftt92biyVhPbZ3vb1c9ozFD5C8tDaURBAGjLHqTT
         YzAnarJG9BKEklAHFvydjrHtrtl/w8CyZlyqI5GIxNhHx4wV8o2gUoIhC4kU3PDZmEd7
         qQ8e36Fz+kS596TI1pfa78t8XnHI4NAYiJHm6Bm0m3KrVi9Zv2MK39fDcwZvRlEstyxf
         Q6Jg==
X-Gm-Message-State: ACrzQf2tGrxylr2yipIEapfzKRNqdkUaQDRAM+sunhp7FVbCBkf6zQQo
        gDB2e0H/YZpwdkdcRqFl/4MO3Q==
X-Google-Smtp-Source: AMsMyM7gLd2Xh0sfa+tFaHscQUkpHnvkLJ1d0xqmrVl3HqwBIbYxynI67Kp0nGZCTrOWZta1N0QtUA==
X-Received: by 2002:a05:6a00:2288:b0:56b:fe9d:b4b7 with SMTP id f8-20020a056a00228800b0056bfe9db4b7mr1191782pfe.79.1666611475639;
        Mon, 24 Oct 2022 04:37:55 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:55 -0700 (PDT)
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
Subject: [PATCH 16/22] platform/x86: sony-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:07 +0900
Message-Id: <20221024113513.5205-17-akihiko.odaki@daynix.com>
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

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/sony-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 765fcaba4d12..987942719ba6 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3201,7 +3201,7 @@ static int sony_nc_add(struct acpi_device *device)
 			sony_nc_function_setup(device, sony_pf_device);
 	}
 
-	if (acpi_video_get_backlight_type() == acpi_backlight_vendor)
+	if ((acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
 		sony_nc_backlight_setup();
 
 	/* create sony_pf sysfs attributes related to the SNC device */
-- 
2.37.3

