Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0386869B9A3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBRLRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBRLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:17:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4801C5AD
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id cp14so214945pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEF8FEuNLVayQdE5QI9MaMd8Q/7gQJSqUO9M+81Oa5M=;
        b=IaruHdGy8cyFLDUGIOX5pZOCfDLvKQZpLOUwXva2yFbitViwuTKQidiLFpOtPWhzcu
         suiJ6uJgAz2TngEijk5zQdejLa23H2xeo9jIswDVjTdRDMV/LGUV9eYlX3+ou4kJqg+8
         Pi9/8dmPnYdds+GD+VqOdlM6LCxjqZ45E1Hbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEF8FEuNLVayQdE5QI9MaMd8Q/7gQJSqUO9M+81Oa5M=;
        b=usmQ4tgWXKA+bdTY/07xzNgq+ZIlkNQwYeCqGQCPjW77yQVUCOGweRR2eSaJi2k8rM
         7LVM0auZZUt3fjS+VwTZSwdobcW+ACHMcjuZSvROGYpk3lh49I/jVkgZvUEP7xwBL4eb
         CiT1O9RBcNLrybCfkKr1FetbBRF/HmH8pvlb7ixsVvlKhIpFTVxA7kkVfMSXdvDHlykD
         8+pHAXVRdAO8UCq4Bm8fU2eCypQNjXBDaVqmWOZE3ys8+XDYxY615QvA0kmGmWUWFNle
         vxwAWit5BsrP3o0x6J+1WNgI4asjP0QJZ+q/i81odHZYXmN1wwv82lCDe6a7zhqIFIA4
         x6nw==
X-Gm-Message-State: AO0yUKWSDM7AyCt29FzC+cHOV8pQDCpdp5z5HXvm3nTx+V40OlUSsHm8
        phQUW5tVvS42lUiGifYgy5OH1A==
X-Google-Smtp-Source: AK7set+WyXQ3bNUcWSBc3Z7xIjr8Et8u/2+vAwZMWp1xbM5SWXK9wjjgnemRxkn9IVSvnVIBAgswew==
X-Received: by 2002:a62:1b48:0:b0:5ab:bf5d:a0d1 with SMTP id b69-20020a621b48000000b005abbf5da0d1mr2435384pfb.7.1676719041279;
        Sat, 18 Feb 2023 03:17:21 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:88dd:be84:8f65:fec2])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b005a8686b72fcsm4457829pfi.75.2023.02.18.03.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 03:17:20 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 0/5] Add generic-display-mux driver and bindings
Date:   Sat, 18 Feb 2023 19:17:07 +0800
Message-Id: <20230218111712.2380225-1-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is developed for and tested on MT8173 board, and the layout is:

                                  /-- anx7688
-- MT8173 HDMI bridge -- GPIO mux
                                  \-- native HDMI

v2: https://lore.kernel.org/all/20230116110820.2615650-1-treapking@chromium.org/
v1: https://patchwork.kernel.org/project/dri-devel/cover/20191211061911.238393-1-hsinyi@chromium.org/

Changes in v3:
- Removed ddc-i2c-bus in the gpio-mux bridge bindings
- Added .get_edid callback in generic-gpio-mux driver
- Removed .get_edid callback in mtk_hdmi.c
- Modified anx7688 driver and binding to add a .get_edid callback

Changes in v2:
- Referenced existing dt-binding schemas from graph.yaml
- Added ddc-i2c-bus into the bindings
- Dropped attach/mode_set/enable/disable callbacks
- Fixed style issues
- Removed the special case for the HDMI connector
- Made the driver only read the GPIO status in IRQ handler
- Rebased to drm-misc-next
- Update the license: "GPL v2" --> "GPL"

Nicolas Boichat (2):
  dt-bindings: display: bridge: Add GPIO display mux binding
  drm: bridge: Generic GPIO mux driver

Pin-yen Lin (3):
  dt-bindings: display: bridge: Add ddc-i2c-bus for anx7688
  drm/bridge: Add .get_edid callback for anx7688 driver
  drm/mediatek: Remove .get_edid callback

 .../bridge/google,cros-ec-anx7688.yaml        |   5 +
 .../bindings/display/bridge/gpio-mux.yaml     |  90 +++++++
 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/cros-ec-anx7688.c      |  24 ++
 drivers/gpu/drm/bridge/generic-gpio-mux.c     | 222 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  53 +----
 7 files changed, 365 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
 create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c

-- 
2.39.2.637.g21b0678d19-goog

