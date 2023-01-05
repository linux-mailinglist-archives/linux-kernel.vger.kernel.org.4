Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB70C65ED0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjAEN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjAEN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:26:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E0DC0B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:25:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n4so39347983plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4TnZDkiAdm2M990ZX4snq2VicduUxXaOkuOV0xOjD0=;
        b=cm5iZeDvUah9kYQf7pPxwGx17VNk4BV+D/QZoATTIFhFXbkPYbeuvDNkSST19dMFkz
         wZqnehd7ofEZUuxaKuR7uD3J+DuhF0Gq7B3mtS0Q+hu5c80JGIdbgBFW45GQdSUOGU2Q
         R63EzR/nwmWIxlO+5V02qTGAczcAfoSN0fwwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4TnZDkiAdm2M990ZX4snq2VicduUxXaOkuOV0xOjD0=;
        b=Da8mDISyg4YvzSzTFlEyqcZjmIaQqVTR1FdFSuiJIdhKWm3Uq43tsnKJ9MHdGkKNrY
         b9UDooGlutEIb6BuSi54qxuB+MzxiUPnR9hfE4E3COvkBz+WNMwLzcqoqCOnM1hP9WoA
         eCm0xejA41HN+EzutfBSd2bzSOhZbtEpizRzjZGNli88V2fIG/G/74qZKRkVw4qkGKii
         /Bcf7x92ydwZL/2mBFO6B0xdVi7YC+dPqgb3ul8KT5sl/FSa0Ap+OFwEb8HUZMYVFRfN
         HY/tsF6bgtw6xPJDVWEjcXBxjDny3joPt1xiYLcdnBGwedElHAhhv4oHA/hvgnv9uqhr
         38sA==
X-Gm-Message-State: AFqh2kpSNhpC1UKDp4m24Q7nRbnTyjRwBTpNSV5/Vh1HI3WrSJzaNqO7
        Usb8mB95UidP3T3+d6VGdccsSg==
X-Google-Smtp-Source: AMrXdXsncnR9wXOQ8G7aUTfbeoK21mOVWpCrGmhXxMOuFxRcBpn7LGrmpgN7UgsTPYWdU0u3CIvnPw==
X-Received: by 2002:a17:90a:3042:b0:226:c364:2d1d with SMTP id q2-20020a17090a304200b00226c3642d1dmr4079122pjl.41.1672925157074;
        Thu, 05 Jan 2023 05:25:57 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7a61:eb85:2e3:2bd0])
        by smtp.gmail.com with ESMTPSA id gk22-20020a17090b119600b00225e670e4c7sm1372682pjb.35.2023.01.05.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:25:56 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, chrome-platform@lists.linux.dev,
        Pin-yen Lin <treapking@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v7 8/9] drm/bridge: it6505: Fix Kconfig indentation
Date:   Thu,  5 Jan 2023 21:24:56 +0800
Message-Id: <20230105132457.4125372-9-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105132457.4125372-1-treapking@chromium.org>
References: <20230105132457.4125372-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the spaces with tab characters in the Kconfig file.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v7:
- New in v7

 drivers/gpu/drm/bridge/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 57946d80b02d..737578dd57ed 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -85,19 +85,19 @@ config DRM_FSL_LDB
 	  Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
 
 config DRM_ITE_IT6505
-        tristate "ITE IT6505 DisplayPort bridge"
-        depends on OF
+	tristate "ITE IT6505 DisplayPort bridge"
+	depends on OF
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
-        select DRM_DP_AUX_BUS
-        select DRM_KMS_HELPER
-        select DRM_DP_HELPER
-        select EXTCON
-        select CRYPTO
-        select CRYPTO_HASH
-        help
-          ITE IT6505 DisplayPort bridge chip driver.
+	select DRM_DP_AUX_BUS
+	select DRM_KMS_HELPER
+	select DRM_DP_HELPER
+	select EXTCON
+	select CRYPTO
+	select CRYPTO_HASH
+	help
+	  ITE IT6505 DisplayPort bridge chip driver.
 
 config DRM_LONTIUM_LT8912B
 	tristate "Lontium LT8912B DSI/HDMI bridge"
-- 
2.39.0.314.g84b9a713c41-goog

