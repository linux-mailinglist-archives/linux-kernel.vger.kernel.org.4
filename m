Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0066EBF3A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDWMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDWMMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:12:54 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F3E7C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:12:53 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-329627dabfbso35778575ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682251972; x=1684843972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmlliGRkQt3zFcGLj9Go0Ae946lja32lat9O7DSGJ1s=;
        b=PiHgoOLlsJuL21nPDzQBkQ6wNUxHJHMrJke/SD3DX89cNmUnGulmMBm7Ck3QZEe1jJ
         M8vbckkkIgLAkDQWn0/WejBhDijURz64QDfTogbJuyXiD/9l529uws1blBSsUlGGNbJ4
         LBYVITbRU0ftIRRzDc+rt1GfQf4JOOMkNNZ/XutRjbEUnV9IQKRCcYDZBpMPIx18A2ac
         xjQlyaQCuSWDNRAkzMtFgKQ2iOx3TapVe7G+NySApBAPnrkpnaNfB3xBRDjIwcQoowmC
         F1YZmjVqbvvLjkHiiUbpISunwI2tkvVHKhhnK9g8iixJWGLTBAqpk3fjqd4H++ATMwPx
         twLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682251972; x=1684843972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmlliGRkQt3zFcGLj9Go0Ae946lja32lat9O7DSGJ1s=;
        b=UfQk+bhpsbCz5aoqtiq3b7ZhKMAs6SSsONxU5vIBUMSoXkCT8Dnu65oQhCXe8KRLEf
         lcU/VW+LB+1xlWbeltgmLQ0S57t2fizcfAMFWdH37JLEcRUFgDSouyb6N2nHTT91tpLI
         geWOaNkvmLEcfd19d+tG72jCxs3uOHRJrYFgvk2QlQ2arGhO1Mj3f+Mac+/5+WiXtkLL
         ULZ8hiGcBKluEH3uOpLBjtH5Xz9L7A4r0qTA0yHTtYhOXgQc2d90H03PVYniP2cby8s2
         DEPUJQg/zVwufX/0zASsagBUG7TJ9QjJPA9mPcQPMPGafXeUK6HQxVHDW/b1E8Sk3QTe
         27ww==
X-Gm-Message-State: AAQBX9c6WkcPu7BmE/Nr40cT0/p5cxus9V48YxzeuWaHesgIvk/SSM3G
        O4AIsGZd2TpwH8H/c1MUxK0IoVvR3vQ=
X-Google-Smtp-Source: AKy350Z+/FqvbghweTImeWKxFlGIN4GJb1ciPYdiWsEAx/ozS9tZ1ED/le+s9cSTvXEmhFZc8xmy9g==
X-Received: by 2002:a05:6602:368a:b0:763:5548:c53a with SMTP id bf10-20020a056602368a00b007635548c53amr3498141iob.8.1682251972271;
        Sun, 23 Apr 2023 05:12:52 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm1612155jau.155.2023.04.23.05.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:12:51 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com, l.stach@pengutronix.de,
        Adam Ford <aford173@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] drm: bridge: samsung-dsim: Support variable clocking
Date:   Sun, 23 Apr 2023 07:12:26 -0500
Message-Id: <20230423121232.1345909-1-aford173@gmail.com>
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
  drm: bridge: samsung-dsim: Dynamically configure DPHY timing
  drm: bridge: samsung-dsim: Support non-burst mode
  drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst
    mode

Lucas Stach (1):
  drm: bridge: samsung-dsim: fix blanking packet size calculation

 drivers/gpu/drm/bridge/samsung-dsim.c | 150 ++++++++++++++++++++++----
 include/drm/bridge/samsung-dsim.h     |   5 +
 2 files changed, 135 insertions(+), 20 deletions(-)

---
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

