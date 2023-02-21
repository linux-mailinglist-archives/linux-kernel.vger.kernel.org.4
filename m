Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE569DD64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjBUJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjBUJwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:52:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3225E33
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:52:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g14so4178534pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+ZwZOlvy1Ieyd+NawnN26j/EK/CvIkDa4Muyk3m0b0=;
        b=daZg1Pec7EJrMORTMITKYWij1J4BgliqjsZvb3TbYCCLcJJYZeZTMDf99ihvRH/kTf
         qxVIbEHtaec6WttYcZTg4c0AYs6bRMwz5JsRVbGRpthUOwl5yb6srFbp+pgjSrWwn4nv
         0rSdKxM9oSYymDaRhj4yMXFEWlGma1u8CDn2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+ZwZOlvy1Ieyd+NawnN26j/EK/CvIkDa4Muyk3m0b0=;
        b=2dsLQfreVNOBnfROiudx+0E1YILRR92oDne/odva0tLC1gIsufetDzAxK8tNKd4VV/
         y1P1TabsiPwY19ADgf8J+1XriRMo9ZrWYjaQOFSYZnMFbiwneTuEvR/jSSXAhcvtFu/H
         9vtKSGDAMZWn9vN0d05+4r8sJnKtuWcjh5grFVcX1A1Hchd49p15EhWLBiVFDjpQ901s
         5ODO410zi6LXeEDV2nkV5U4sydd9bH+PnVeiRm6zyKc5UOkk2lJQIC/goJETxvuirnOe
         IxDDdpBHsDmEF3HPNzu/JNdvPckUoYORWv//Z6rJlvUAiLihLYWYeKWLJjO4fXLy4RgG
         EJ7g==
X-Gm-Message-State: AO0yUKXioej+pxUpPPIEHMeoq12tlrokY9fIxpdkTuT3oh3esjHP9anr
        PcRFw6mxF+gZ/8jO/QbhITCeCA==
X-Google-Smtp-Source: AK7set8HfGPAaKpQmAs84raUeV4ejCG0h7+PitATt7AQBNDfQ8PcDz5YsTFC935Sjmq3p9k0M4//0g==
X-Received: by 2002:a05:6a20:429a:b0:c0:c9b8:64 with SMTP id o26-20020a056a20429a00b000c0c9b80064mr5162345pzj.17.1676973131621;
        Tue, 21 Feb 2023 01:52:11 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a1f5:f58d:584e:5906])
        by smtp.gmail.com with ESMTPSA id t25-20020a656099000000b004eca54eab50sm3524918pgu.28.2023.02.21.01.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:52:11 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
Cc:     Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v12 09/10] drm/bridge: it6505: Fix Kconfig indentation
Date:   Tue, 21 Feb 2023 17:50:53 +0800
Message-Id: <20230221095054.1868277-10-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230221095054.1868277-1-treapking@chromium.org>
References: <20230221095054.1868277-1-treapking@chromium.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

(no changes since v10)

Changes in v10:
- Collected Reviewed-by tag

Changes in v7:
- New in v7

 drivers/gpu/drm/bridge/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 12e8f30c65f7..28dc7711bf5f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -74,19 +74,19 @@ config DRM_FSL_LDB
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
2.39.2.637.g21b0678d19-goog

