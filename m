Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1395E6F3BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjEBBIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjEBBIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:08:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB013C30
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:08:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760f5070ccfso248396639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989687; x=1685581687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWHDFN7Ujs5msRXNgIZk9qHJ9Glg+BaYPkvMRLxbY7E=;
        b=lh0V+FG7uHRTs6DVgOJWfpgNz/OJGm/zRrYCEM8miEzWzfgNut+GnLjU/CESuAdZmv
         DU7zQO6fXNlyiiwRVkp7aq6cuKyUMx7m4VvwDkpiEs/wC7AhV6Bu7Isu1axKZSbeIPw3
         YEzZNuXxQyxj2Wkemem/+CB9Bxle3AGEBIFwwf+6X+0M3DiOxhp9Q2Ue+69dFgkB2rJC
         DhQ0hZAhxs12e6NoRCULOrrpAJfr0GSRzPcWWZBnSGNK7kePayZQ3vy9tHQ+FACj7Vzg
         tFHKTn5RKMHBvnSzleg7bWFO13DQ2sYTV9LPx8o4UpCCiUzJASoTOBCwxfSHKp69TD2b
         nJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989687; x=1685581687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWHDFN7Ujs5msRXNgIZk9qHJ9Glg+BaYPkvMRLxbY7E=;
        b=FkKmdaS8d2raZkTGJYpJEfFed4lAoR+4ygyOVoJbnPrOV9Kb8iTwbB2wUYtqYA6rrx
         hn/tEYKfLY9NJRfstAA4ED6LVZOHnSquLyyeGscrzGEJsR5y2ocMcU2IYixHnxwuW1ZW
         9IgszuudrOP0dFDA4kp89sv7KoZWC28uyZS0nNOZ/DhyDR9r481SLly8NEIahr2WX/2U
         hx/PIUofhIhCD32m+/BWBsUV5rY3egEIIipJI9E852hL/3dSMkLfzpvh3/6eHFe3DRwb
         LXvfOXyU+gFBGgQi8PBN8sMavjCPYlKQAcig80GfnPhAS1o9w6gf4MX+a9S/UZ6+Dajg
         ZxOw==
X-Gm-Message-State: AC+VfDwZzhesvGRVSGhzBlH1vBPEeLyF1V92nCoJ3rid943EQM4y0Trr
        R1wGS/7Jvry473/YAzfmvCK/k8O/4rU=
X-Google-Smtp-Source: ACHHUZ7H5cd1a+PaC7TYOYVXFLm8Ds8lDPcMFxpaqZUET7b/kIVqMWFgkNZ+SOIAZEZ17OCb/bsGQQ==
X-Received: by 2002:a6b:5c0a:0:b0:760:ec21:a8af with SMTP id z10-20020a6b5c0a000000b00760ec21a8afmr12811865ioh.0.1682989687374;
        Mon, 01 May 2023 18:08:07 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:8257:a536:d7fc:1919])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638329000b0040fb5d5429fsm4836329jav.131.2023.05.01.18.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:08:06 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/7] drm: bridge: samsung-dsim: Support variable clocking
Date:   Mon,  1 May 2023 20:07:52 -0500
Message-Id: <20230502010759.17282-1-aford173@gmail.com>
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

Adam Ford (6):
  drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
  drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
  drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
  drm: bridge: samsung-dsim: Dynamically configure DPHY timing
  drm: bridge: samsung-dsim: Support non-burst mode
  drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst
    mode

Lucas Stach (1):
  drm: bridge: samsung-dsim: fix blanking packet size calculation

 drivers/gpu/drm/bridge/Kconfig        |   1 +
 drivers/gpu/drm/bridge/samsung-dsim.c | 150 ++++++++++++++++++++++----
 include/drm/bridge/samsung-dsim.h     |   5 +
 3 files changed, 136 insertions(+), 20 deletions(-)

---
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

