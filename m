Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA370418B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjEOX5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245701AbjEOX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:57:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389D7EC8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c5749b10fso208992239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684195052; x=1686787052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o9sUAx3iK/A4vzjmFl/tQ6LFFXKGPJqcsBJSVqCXEY=;
        b=Qhc++AOKc6iuU6NDoWnS1HCbpn4iPCDGURXGkt7PM71KSwmvciygh1yDBOBiJ0LDA3
         hnw414SE6bnXHXCB9GAtOf2eJuw0Q/A0SBcz5OK7aNOznlX3XGYXDogEEExxdxcKKsT/
         x84+Z3C35XY6dYRzaaDOpDU/QsOVNe8g0R5HqmhfU7vbsr7MF4bp33QrK/dvejoXRn5L
         Nh/9ZyFBZDHPaSN1ZcjZIlZRMx9SnTQWKVczFyUvwNQxS9ppKYnRF1aMmq9c7TRg9ghT
         QbUTy3XvhLiZUJRtukxhVX9MqOE9DyG+9kPoBxyzOSz+mg5ElZoy3b+rOmixEZJaiipT
         bK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195052; x=1686787052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o9sUAx3iK/A4vzjmFl/tQ6LFFXKGPJqcsBJSVqCXEY=;
        b=dlwm2r3fesRFDUjg8jaFnn/ab/IgG23+SiDFKcIS11dlZ+kSElR5mhGxUHCtJZh2Td
         Q1b817uaxlZUvPToJEDlCgxeNFD4A6cLwsylZb/ypvdVJYG9hnfK5r+0Ru2jb0ReRdh8
         gE/IGRxlmIPVWnMtFHq3kHZJVy1O/dctT69EXMlFbflzUtsUC/Wdh/Z+2iWeQW353mLT
         CuBtIiuPupwC0mK4eAXabDvDBf7qD8BMXcGWTuG1axkdWVfb5oUV+jzljRsVY2MGAIhr
         n+4sCAryRfb2w80NLozDIXHnA2gHu1gODbfAJrOLvoX0CB45vyULezimW/Ar9MfkT4f8
         BeAw==
X-Gm-Message-State: AC+VfDyK6y/ozzb3Zuu78N3hkQMx5rE3hcYc2r0jr8zcZPg5EP4is/A5
        iFFRGN0PEg9rhcff94Zr6H8=
X-Google-Smtp-Source: ACHHUZ4XF7Hna2wtvI3r7ukfUzFNTLOqmB3ynidPlmpgPu1EcvqiwgTXbGgh1UZtGhdREDtHKDAwkw==
X-Received: by 2002:a5d:814d:0:b0:758:917b:c313 with SMTP id f13-20020a5d814d000000b00758917bc313mr750544ioo.13.1684195052132;
        Mon, 15 May 2023 16:57:32 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:61e0:9fee:1bca:ea3c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm7427851jar.108.2023.05.15.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:57:31 -0700 (PDT)
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
Subject: [PATCH V6 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
Date:   Mon, 15 May 2023 18:57:11 -0500
Message-Id: <20230515235713.232939-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515235713.232939-1-aford173@gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
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

