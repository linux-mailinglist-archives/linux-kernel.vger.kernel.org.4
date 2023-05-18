Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0564708C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjERXHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjERXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:06:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40521B5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3381e9ec12bso20452505ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684451204; x=1687043204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o9sUAx3iK/A4vzjmFl/tQ6LFFXKGPJqcsBJSVqCXEY=;
        b=neaX1AsZMi4JgHzRyfIozgwJkv0FHSm6o2KaeG8oqw6uC6x7lCfn4Ki/4zzqGlEnya
         M0BuBiOj1lP7uaTnPY5que/47wI7qw7Ve/rH9kZMXmnc5cbq951KZ2i47NpVR3KPfO+P
         WnpunmjsKVfR+txcol9AxWoV1vEFS8n1T1X03Dyyjb7iLjzik9w5eeV1/prjhqy2nDpk
         EcgmWnwfGhByiNjV6yjOcR0CIkEfMYCzFAiKcxfQmGMUdKb3vyHwvpiw4RULlmGbIoIE
         uOQBFKvyXm//KalxwaUBmOoYpXwWj8NEVaiuEkp/S1BVHSXwQ2W2NQZkAtcsllmVRfTV
         rMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451204; x=1687043204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o9sUAx3iK/A4vzjmFl/tQ6LFFXKGPJqcsBJSVqCXEY=;
        b=jT0nlbwUYEPmwbqMRwYZQK8cHy1Gp8wecrYg/o5Y2s0x9eb02pgTEw7GRju7bdnfmZ
         C8wJmccAFoJm7xbHS2zs6CGmrlwExTi6fTSWeg2gPeDCO8vx0U/GhveCA11g3w7XNfOq
         IndQzTzwrSMzyaGEyNZ9xYgNUBfAx5u80z8Fu+JDC7hj8FkoppAcT2y+FbtSFMiM2CwB
         h3IEZfvAvLGqJIvRsnWBfsXw7QY+WDGfHjrs4QNgnayYP1e5uXAH3lFvXryGNJ5YG1jp
         ZnyiXWW58TP0n/l8OnmX9lGGIVRLaD0cIqemG0zrzQAdFRW58BfD7m4sDmsRMdPB/i//
         bV+Q==
X-Gm-Message-State: AC+VfDy723oK6NP3d6N0WKXfkWsbGBYpWdQjt+cysSub1nBsBmM/zEL+
        7+I7F8lz9ixjHOwJCjNAukA=
X-Google-Smtp-Source: ACHHUZ49jytJKEuT745t6jx63iNJD9VDzHUyMD5fg/bxd46QCh04b8HvC+o6yRsw5Kn3S5qQd5r04Q==
X-Received: by 2002:a92:c952:0:b0:337:83fc:43c8 with SMTP id i18-20020a92c952000000b0033783fc43c8mr5814594ilq.10.1684451204474;
        Thu, 18 May 2023 16:06:44 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:56b8:635c:4c7a:15b1])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cd0c000000b003317ebbc426sm635897iln.47.2023.05.18.16.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:06:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH V7 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
Date:   Thu, 18 May 2023 18:06:24 -0500
Message-Id: <20230518230626.404068-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518230626.404068-1-aford173@gmail.com>
References: <20230518230626.404068-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support variable DPHY timings, it's necessary
to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
can be used to determine the nominal values for a given resolution
and refresh rate.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f076a09afac0..82c68b042444 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -227,6 +227,7 @@ config DRM_SAMSUNG_DSIM
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY_MIPI_DPHY
 	help
 	  The Samsung MIPI DSIM bridge controller driver.
 	  This MIPI DSIM bridge can be found it on Exynos SoCs and
-- 
2.39.2

