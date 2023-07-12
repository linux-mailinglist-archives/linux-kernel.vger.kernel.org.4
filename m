Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BE74FFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjGLGvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGLGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:51:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0841BC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:50:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7656652da3cso572093685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689144658; x=1691736658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikjp8bXOr9w+1zAFDDrD/xtGyBZP1yYzO0vDJOIDmiY=;
        b=oRfKsJ28pU7X/VXGOIWXuIohz/jy3PtnVwxE1tJl+2WoTIRrsSiGyxhk0ztXNgkLS3
         LWmWQ3IuCt55Gf7Nrf3+rInkoIVVctwDPrApYDWUyUXr7AD/zXgZJgtzWZLUMhkMeSNZ
         MldWZiSScORaun1iv/LI/tKwl+0nO+tPtI/q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144658; x=1691736658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ikjp8bXOr9w+1zAFDDrD/xtGyBZP1yYzO0vDJOIDmiY=;
        b=CF+ZFoA9t//W3vdC75IkOQM8xbymxRIPDqWzD0yek2W34//wBtge7NN9DhseRK43EO
         vDqxtQUSD7lKPs+vh4i+KkefDhVP2O2HrGdVo1aEYZO513sQttklv2HrCYxf0ARGVNI5
         nU4pH5Smm1ZL1/7Y9oG8pI5EFQk06e+HpoG9mE64B9VJL4kZklekDbK/JiywHIOjbriN
         BJE69aOEeh91WrKc71xvW5ZNagUY++Ke0qXJ7Osw9cWeOY3GOgd8uQrtmEZ0zqE/ybao
         DZ56LwRJrYxpeZfiTGqR4eI83FFFbOrTH12BlkdTfgDqRgm1BfBGqFzwdgNz3XQAc17I
         jczw==
X-Gm-Message-State: ABy/qLaAhyji3gYZGAWkQsptDv4wL28evkjfBQOx9bX9IkUVeW7sIOjE
        YbuxMt/U6ERE3aBY2LDYaBLl+A==
X-Google-Smtp-Source: APBJJlFNN4hfmssZAwCqbgmaoduWlCOkP5fkqpM7evtL79kHVgTQd+I270rF3FRQnqsRRRkxA3Mg0A==
X-Received: by 2002:a05:620a:47b0:b0:765:a58f:d080 with SMTP id dt48-20020a05620a47b000b00765a58fd080mr16800084qkb.47.1689144658577;
        Tue, 11 Jul 2023 23:50:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:99a0:b85a:11e5:45aa])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004fab4455748sm2717499pgf.75.2023.07.11.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:50:58 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH RESEND v11] drm/bridge: it6505: Fix Kconfig indentation
Date:   Wed, 12 Jul 2023 14:50:53 +0800
Message-ID: <20230712065054.2377278-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pin-yen Lin <treapking@chromium.org>

Replace the spaces with tab characters in the Kconfig file.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Splitting this patch out of its original type-C mux patch series [1] to
get it merged. This is a cleanup that is not strictly related to the
rest of the series, and that series is still undergoing dicussions about
the design.

[1] https://lore.kernel.org/r/20230331091145.737305-10-treapking@chromium.org
 drivers/gpu/drm/bridge/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 82c68b042444..44a660a4bdbf 100644
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
2.41.0.390.g38632f3daf-goog

