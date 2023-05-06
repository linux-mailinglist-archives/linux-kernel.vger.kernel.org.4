Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9066F8D5A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEFBJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFBJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:09:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058019A5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:09:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-769a530a892so63002639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683335381; x=1685927381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Scj1Rm9/rC4jTYvI6m9Jl98HOksvm+XVG/RUqqIHZFo=;
        b=GFPrHBpS03ONy8mYrTlEeOHQcxOD/+xrCDQhAkIw8jhRBu4fD3S7EjtAVPqzSNLeEw
         u73UJQ1it5MligQY05B1dHVH/bETuspVhaVv2Bc6FOsidQNOrxhiQAkxwz14U7Gl96V8
         P/y1c+QEk+mgbZP5hAU4Iq8HLyEHJgP4DydI6A1X1lges94+qQ15L9rFEwHXKRbbItp6
         wXxhQ3xASZcbFOM0viQLyAyS5sAqYNUmtqft0ZRk7yshnHKi3YMSdi11KhGO9D+TLWtM
         qA8+9Z48bP4Dw7fD4NAlp2Q7kZKmrkembSxU+/EELHFPmbycdtg1M5MqNH9BLhxEyhjQ
         MWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683335381; x=1685927381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Scj1Rm9/rC4jTYvI6m9Jl98HOksvm+XVG/RUqqIHZFo=;
        b=icaJN2Tfd9nnzA86A6DoDaHkooi05zjMlbg1+w6fphhsh9zMAm8febRAfAylNTbR+u
         fN3v88UbkEKoJq6G29QYioTPt2yJ4j59MZ0cquel4ABNCSQlT4tsilSGZxrSWqKxMpG5
         vV2sa2uCzewHOKjxPYDdsiU2uIfZ+Mb7/C7SZuDUdk7NRLf7IC+/Qpvju0nIcWo4vt1B
         4dK5u4CSFWW+yz/Nmqt3qt6oP26PLQTBPfOy5ivx3HcId0g/LSud+N9y2Q5GlQ2sBhvK
         +wgn4oA+tI6ZVTXJ8K6IkF3uKfRi3i95MbWVkciA9sTK0vSVZ+AY6OLDlNjRh+3DNdzF
         R8iw==
X-Gm-Message-State: AC+VfDzA1vClk8X2LJ5s+78fmlmtdqsUb02qkS0zmoP7kqY5L39/MRWe
        qEAIHF7fIWTQ9B4iHILVYh9PQbvUri4=
X-Google-Smtp-Source: ACHHUZ6z1K4B8IjyH9SnCzJlCtBx6S2CxenHzNLsntovL8PjvA5kf/6saB//gSPCmuGUirY6clWZTA==
X-Received: by 2002:a05:6602:58:b0:768:dd79:c013 with SMTP id z24-20020a056602005800b00768dd79c013mr2164192ioz.17.1683335381065;
        Fri, 05 May 2023 18:09:41 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:34a2:3894:45cc:c002])
        by smtp.gmail.com with ESMTPSA id r11-20020a5e950b000000b00760ed929d0bsm335735ioj.2.2023.05.05.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 18:09:40 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/6] drm: bridge: samsung-dsim: Support variable clocking
Date:   Fri,  5 May 2023 20:09:27 -0500
Message-Id: <20230506010933.170939-1-aford173@gmail.com>
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
devices like an HDMI brige.  In that event, the HS clock is set to the value
requested by the bridge chip.

This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should work
on i.MX8M Mini as well.


Adam Ford (5):
  drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
  drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
  drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
  drm: bridge: samsung-dsim: Dynamically configure DPHY timing
  drm: bridge: samsung-dsim: Support non-burst mode

Lucas Stach (1):
  drm: bridge: samsung-dsim: fix blanking packet size calculation

 drivers/gpu/drm/bridge/Kconfig        |   1 +
 drivers/gpu/drm/bridge/samsung-dsim.c | 145 +++++++++++++++++++++++---
 include/drm/bridge/samsung-dsim.h     |   5 +
 3 files changed, 134 insertions(+), 17 deletions(-)

---
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
     This also maintains backwords compatibility with older device
     trees.

     This also changes the DPHY calcuation from a Look-up table,
     a reverse engineered algorithm which uses
     phy_mipi_dphy_get_default_config to determine the standard
     nominal values and calculates the cycles necessary to update
     the DPHY timings accordingly.
     
-- 
2.39.2

