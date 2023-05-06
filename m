Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA36F93C4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEFTZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFTZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:25:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AB64234
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 12:25:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76937f5f9c5so82694639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683401118; x=1685993118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtqE7gru9L7aUI9DrBovms89ZLUDI+niZ6Hbhs/0ig8=;
        b=meePf845x5onCP3jHrfUx2bLn3pgUagH/loKAiW3P+8FoLTOI1EHMYA+i6SwKOYS5X
         DmxUZWBUkop6/nXsPk9RVReL4pHGw5V+aJP1eaioYu+htGeNYQTrbGJb68x06brnIfVo
         pA06BnbCQwe67H09Oaj3I+VHnLG2MBu+b7nCyBaOo4JKo8oGiwoc/T82MmfwWE7VmxLN
         dEJQS5rVgEU/sjGCCwblneX+oDVd3yaaumbJp2Gw1eyzb2zbSRrTT2F0Ko6VeqooxRLt
         vj4RseBmCqhnKo4nNXfsct3IwRGCyaqDqyezR6jgP+lqbPx0Cs2G6IMCT8PY3wx16PSo
         zPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683401118; x=1685993118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtqE7gru9L7aUI9DrBovms89ZLUDI+niZ6Hbhs/0ig8=;
        b=jq5vIBKzicwUVhM/fGrIKz0bDoRsEu/lT2AbGZV3HlkXpDa6oISczjKM6MIbObYHl9
         +CoN3abuT0UsnvHh3JKjBTP56Z8TIlqwSWWuBGlt9qEVDB6nueVY/Y2KM04xHFyHKBAw
         OyHJwiqy+KhV9kfxDHs29dkan57rDy/+21Ag5syAlwKdWkTs6/zpTu1wmRP9mwzE+wOl
         hrwkCOk9YaoPM6J/uL+CAf5UktQp9wqsL8yN7MVaojJxbgeNpHKjCFZHRTmpK3bhH099
         1yf4r7B+S/ymcvUna1i9KInbOL+Sb6KwdSMVVhH4x2nVil2cb3G3cTbSMwtAyjkAygrx
         4YTg==
X-Gm-Message-State: AC+VfDwYAn3eat7VX3362JOpVYeIOvFZYth5Ou/RMSaawtJn9lzLm2yo
        hPSpfrBEHAcNCXlK3KhQTzs=
X-Google-Smtp-Source: ACHHUZ4dcKKPwYUA5qy9tz+3ej5+IshZTlk/SCv0lDxO8AxW+LCiJQ0VbHVnEzi3plh/aoKvj4xKig==
X-Received: by 2002:a05:6e02:68d:b0:331:4865:c891 with SMTP id o13-20020a056e02068d00b003314865c891mr3291971ils.24.1683401118042;
        Sat, 06 May 2023 12:25:18 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:5e49:1bed:79d0:5c25])
        by smtp.gmail.com with ESMTPSA id z18-20020a05663822b200b0041631393ac9sm847824jas.18.2023.05.06.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 12:25:17 -0700 (PDT)
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
Subject: [PATCH V5 0/6] drm: bridge: samsung-dsim: Support variable clocking
Date:   Sat,  6 May 2023 14:24:47 -0500
Message-Id: <20230506192453.725621-1-aford173@gmail.com>
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

This series fixes the blanking packet size and the PMS calculation.
According to Lucas, "The blanking packets are MIPI long packets,
so 4 byte header, payload, 2 bytes footer."
It also dds support to allows the DSIM to dynamically DPHY clocks, and
support non-burst mode while allowing the removal of the hard-coded
clock values for the PLL for imx8m mini/nano/plus, and it allows the
removal of the burst-clock device tree entry when burst-mode isn't
supported by connected devices like a brige.  In that event, the HS
clock is set to the value requested by the bridge chip.

This has been tested on both an i.MX8M Nano and i.MX8M Plus, and
should work on i.MX8M Mini as well based on feedback from other
users.

Adam Ford (5):
  drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
  drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
  drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
  drm: bridge: samsung-dsim: Dynamically configure DPHY timing
  drm: bridge: samsung-dsim: Support non-burst mode

Lucas Stach (1):
  drm: bridge: samsung-dsim: fix blanking packet size calculation

 drivers/gpu/drm/bridge/Kconfig        |   1 +
 drivers/gpu/drm/bridge/samsung-dsim.c | 160 ++++++++++++++++++++++----
 include/drm/bridge/samsung-dsim.h     |   5 +
 3 files changed, 143 insertions(+), 23 deletions(-)

---
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
     This also maintains backwords compatibility with older device
     trees.

     This also changes the DPHY calcuation from a Look-up table,
     a reverse engineered algorithm which uses
     phy_mipi_dphy_get_default_config to determine the standard
     nominal values and calculates the cycles necessary to update
     the DPHY timings accordingly.
-- 
2.39.2

