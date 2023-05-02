Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453296F3BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEBBI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEBBIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:08:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B4811A
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:08:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7666121cf5dso55451839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989694; x=1685581694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0duPWgTIsXWR+LqC+JicpRWC9rG9dOi1hmp+K9AKt4=;
        b=oAJ1HEpecrB2Q6BRpL9rdawMEoPUyuLAfbZul0lkxVERtwEr0Pyslu/QBfGALP1vGf
         FW2D2BmSQbZc4Ge43oVD+clOIBN30ayCgAjWrlixkuij6syeE8/Ty47txlKBOGvyat1I
         6GJ2puGIwLAGWAMu5/YvxvMUePnjUmEdMyCHEEbcCjkMH3NrABW+z74FRbIMaB8dFuvf
         yqgHr9sHVZZEgBFCV1xTUPWFCWfDykx24oAQP8mQBk3chFdbSvdsuhA3LwZzM1Wit/y2
         awR7O7dw95WIJjIi96DY6NfO3SlaTrHb/Hi4BfNbml+KRTD/IZyjB68rGkzZzovbKjv0
         7wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989694; x=1685581694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0duPWgTIsXWR+LqC+JicpRWC9rG9dOi1hmp+K9AKt4=;
        b=jsbY/Mks5zWgsMYy1jWftqbFTGknm2NH6ZWZKWHKO46Ul1r6xSH5D3wzW25HluJeoY
         iE7mWFSIIwujG0jWD/nmZ6hPV0mBnosakMsJoTHITfS32nMmrMYknMaI07emEPeFX/PM
         9V7yE1stR+8Yhk2InCQTVHM5QD4IZBzhhHtGU/0PxFJFvGKXMBxynYZ4vWirHI8vXmp0
         +dWFA/C0Baleqfq+eHuOzRotQBs8G2V7ROLg8Jiomi8JJ3Zai1j5mbJORa8ssLk9fu1K
         4C0g6m02qFN80RvrOf8uSII7ltUplaXyBq4nu5dN5HXMyD9aordnDPWYvanfaCq8Tlec
         dB4w==
X-Gm-Message-State: AC+VfDxnIbKQlItor0+mhiRN5hp0gko/9Rg9zn3VsOHs9aRVMyBA80Py
        4dIzffsEYaU8+khxKA67f5o=
X-Google-Smtp-Source: ACHHUZ7dizlXI6hVaZ+RaY3BNeTDSUd8Ko7VO83X/pt9wJ4lPY8NsLPsumX4egRDWFTB6cv/DCWPzw==
X-Received: by 2002:a5d:9c94:0:b0:758:1fa5:f086 with SMTP id p20-20020a5d9c94000000b007581fa5f086mr9384657iop.17.1682989694343;
        Mon, 01 May 2023 18:08:14 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:8257:a536:d7fc:1919])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638329000b0040fb5d5429fsm4836329jav.131.2023.05.01.18.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:08:13 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
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
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/7] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
Date:   Mon,  1 May 2023 20:07:56 -0500
Message-Id: <20230502010759.17282-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230502010759.17282-1-aford173@gmail.com>
References: <20230502010759.17282-1-aford173@gmail.com>
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

