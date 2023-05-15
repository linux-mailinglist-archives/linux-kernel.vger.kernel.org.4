Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381EA704184
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbjEOX5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjEOX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:57:28 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336587294
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33550237f6fso70226575ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684195045; x=1686787045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+O4/ssLgmztN5BM7M82vr66O6jkTSH4ZHyxDa1+Ug8=;
        b=B0ntmpLUk6eNh3OLIUA7OPQpY3picoLY5XUIesF0KsBU3nYzm6J2yYRc3xOuejaDc/
         S+W8BWKRAZ/kCmqXfGPxIXokvDQ4TxfEy4jTjbNipS13wQQTbEoTwjVxh6m2wRxj+syH
         UkGbWSW1zFWIapxkCXXypvndH4UqsX66RqqcaO4xH0NZOL+KNJvniFgYkrAoMJ4Y0IC2
         1+3202JXtPzxgJZZEcaqDXjcLXQFVVBebj40S3IBPkGuyW6XMeuWtlo2cHJyn60ktKw1
         S7qT7gNEXtup6ADfN4bi3bvLXbg14+R8Noaqv8NaZ1FEMg36Xnk9yhq3ALCtcWTPzjSP
         Hmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195045; x=1686787045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+O4/ssLgmztN5BM7M82vr66O6jkTSH4ZHyxDa1+Ug8=;
        b=XSYfWntXQV+1jdMmSE+3jjtyaDq6amCKgL+XrK3+zlDNsfvGOcaIlxuO3DVPAL4q6r
         z7EpOoPfOx88eeh3XASj0qoAHv8PNgoCKlSfVSFVx+5pBnPivkeByrBqJ5WZvmykAJw4
         UK3zoD5BehT8xBg2cM8GOy/L98VzHqOHdrpTOR9xqbkGEeHInnCuoClcc1FHg08guUQu
         rxEAnA2obJqchs8RvBNTOGbeASZg5+Ah1WZD+h1VJGnC8qQDC2bNsAM4wMqsrx19m84L
         sG3boFPV29YmMEwV9rvmrYVCmolVWRjJ3Jsh209P+EjYnY84ZKBzlzVDSzlB8et+s37i
         ytpA==
X-Gm-Message-State: AC+VfDziDfSujubbSKDzWxam1dVVWMkKFiMXIUKqhYEQPn75MfmNzwPE
        OseaRjjh6+eQ2Fj4oSKeodg=
X-Google-Smtp-Source: ACHHUZ49in19sRs1FqtjrAtNiP3pmQ/Qi2JvTtYVIDz2gKPvpzvDQ8OkDxV0kKIvFptWtbQfPXE5zw==
X-Received: by 2002:a05:6e02:6c1:b0:335:87f9:50e4 with SMTP id p1-20020a056e0206c100b0033587f950e4mr20972368ils.29.1684195045365;
        Mon, 15 May 2023 16:57:25 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:61e0:9fee:1bca:ea3c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm7427851jar.108.2023.05.15.16.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:57:24 -0700 (PDT)
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
Subject: [PATCH V6 0/6] drm: bridge: samsung-dsim: Support variable clocking
Date:   Mon, 15 May 2023 18:57:07 -0500
Message-Id: <20230515235713.232939-1-aford173@gmail.com>
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
 drivers/gpu/drm/bridge/samsung-dsim.c | 143 +++++++++++++++++++++-----
 include/drm/bridge/samsung-dsim.h     |   4 +
 3 files changed, 125 insertions(+), 23 deletions(-)


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

