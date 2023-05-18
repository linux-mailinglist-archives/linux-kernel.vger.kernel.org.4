Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA0708C06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjERXGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjERXGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:06:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F85E66
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3383025b9c6so6708605ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684451198; x=1687043198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDVLVchNwHu4gCB84Byfao8xXuzpMRrJqDwTNid2o6c=;
        b=k4Sctar4BOS9H7HreNrDWu+pg8VpPwD0C0ts51kplfqR5pLMjZyJU3c1cQydJQF2g4
         qXwAoEJPivjgQ+/TMwCEu2UJ9iu63UqOI/nTufUvgSjLdHd61ZadnOvnmzGbtFtMCy+g
         0A0WaQpeywz27Qfdic9dO7mMYWNdU6p6pLhOt2z3rFNo0VAKtkiDCJBQf/NEB1Yfls2D
         /SzEKoPcp229Czu9pvxTsCEDxCmoqlCldmyGf/4XQtGPuVjGCt4jE8PpzI9uWGUvnVYB
         v8LQ2x1pib/J5H1HW8ASNOjPgj8IrTfZSSfe+VfkX+EK0HTDDCYs5xOtHGV/7cOaFGxk
         OHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451198; x=1687043198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDVLVchNwHu4gCB84Byfao8xXuzpMRrJqDwTNid2o6c=;
        b=A3NIeAe4pa8MLFfdkp1+0Lm5JpWWwDSH0LlIQuaIoHLgBCH95vFcPfVK5PuXQQbwTD
         +UW1iQmB+4sDpD0optlhMEUyICUQnzhQjhKOD24QaDLbtgykhwoRWhWDXqlutjwUL72j
         6FzhAtsXJV0HRGfo/NynHaIUF74KqJXEqKBn7H3NnrcaqC+C6HVIwdNCQeFLEn8DphQ3
         eolLdN85EjbV/pIQ/WvPXdxwPNEEhQj55gSoCT2VXlUEDtedRkUNdg2c2nEC6HG5O8nG
         lz3hAuTSg54YBmfUHBlQX8wORTHh7Gr2058JBPuA8o5x0va79Igaj/mUxjwAr1XApty6
         R2LA==
X-Gm-Message-State: AC+VfDzi8R2EYfXAHxhv4HXzx8WgwPdS2NdnjasmhWImhFaHlcwWS4YC
        LbibFkAqWGKG2bdTwaOQ7zE=
X-Google-Smtp-Source: ACHHUZ4C1Nsf5w9tu6OrNRHCjmsqgbH4LOCTH9HuScT5RTOWd1FIrZzfFOKX6FDd6x8IdN+KZST0EA==
X-Received: by 2002:a92:c64e:0:b0:335:38b:e734 with SMTP id 14-20020a92c64e000000b00335038be734mr4991370ill.28.1684451198014;
        Thu, 18 May 2023 16:06:38 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:56b8:635c:4c7a:15b1])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cd0c000000b003317ebbc426sm635897iln.47.2023.05.18.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:06:37 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
Date:   Thu, 18 May 2023 18:06:20 -0500
Message-Id: <20230518230626.404068-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series fixes the blanking pack size and the PMS calculation.  It then
adds support to allows the DSIM to dynamically DPHY clocks, and support
non-burst mode while allowing the removal of the hard-coded clock values
for the PLL for imx8m mini/nano/plus, and it allows the removal of the
burst-clock device tree entry when burst-mode isn't supported by connected
devices like an HDMI brige.  In that event, the HS clock is set to the
value requested by the bridge chip.

This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should
work on i.MX8M Mini as well. Marek Szyprowski has tested it on various
Exynos boards.

Adam Ford (5):
  drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
  drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
  drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
  drm: bridge: samsung-dsim: Dynamically configure DPHY timing
  drm: bridge: samsung-dsim: Support non-burst mode

Lucas Stach (1):
  drm: bridge: samsung-dsim: fix blanking packet size calculation

 drivers/gpu/drm/bridge/Kconfig        |   1 +
 drivers/gpu/drm/bridge/samsung-dsim.c | 142 +++++++++++++++++++++-----
 include/drm/bridge/samsung-dsim.h     |   4 +
 3 files changed, 124 insertions(+), 23 deletions(-)

V7:  Move messages indicating the optional device tree items are going
     to be automatically read elsewhere was move to dev_dbg instead of
     dev_info.  Cleaned up some of the comments to be a bit more clear.
     Eliminated a double variable assignement accidentally introduced
     in V6 when some of the items were moved from patch 6 to patch 5.

V6:  Squash-in an additional error fix from Lucas Stach regarding the
     DPHY calcuations.  Remove the dynamic_dphy variable and let
     everyone use the new calculations.  Move the hs_clock caching
     from patch 6 to patch 5 to go along with the DPHY calcuations
     since they are now based on the recorded hs_clock rate.
     
V5:  Update error message to dev_info and change them to indicate
     what is happening without sounding like an error when optional
     device tree entries are missing.

V4:  Undo some accidental whitespace changes, rename PS_TO_CYCLE
     variables to ps and hz from PS and MHz. Remove if check
     before the samsung_dsim_set_phy_ctrl call since it's
     unnecessary.
     Added additional tested-by and reviewed-by comments.
     Squash patches 6 and 7 together since the supporting
     non-burst (patch 6) mode doesn't really work until
     patch 7 was applied.

V3:  When checking if the bust-clock is present, only check for it
     in the device tree, and don't check the presence of the
     MIPI_DSI_MODE_VIDEO_BURST flag as it breaks an existing Exynos
     board.

     Add a new patch to the series to select GENERIC_PHY_MIPI_DPHY in
     Kconfig otherwise the build breaks on the 32-bit Exynos.

     Change vco_min variable name to min_freq

     Added tested-by from Chen-Yu Tsai

V2:  Instead of using my packet blanking calculation, this integrates
     on from Lucas Stach which gets modified later in the series to
     cache the value of the HS-clock instead of having to do the
     calucations again.

     Instead of completely eliminating the PLL clock frequency from
     the device tree, this makes it optional to avoid breaking some
     Samsung devices.  When the samsung,pll-clock-frequency is not
     found, it reads the value of the clock named "sclk_mipi"
     This also maintains backwards compatibility with older device
     trees.

     This also changes the DPHY calcuation from a Look-up table,
     a reverse engineered algorithm which uses
     phy_mipi_dphy_get_default_config to determine the standard
     nominal values and calculates the cycles necessary to update
     the DPHY timings accordingly.
-- 
2.39.2

