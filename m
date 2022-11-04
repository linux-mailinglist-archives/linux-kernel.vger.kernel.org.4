Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069236198F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKDOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKDOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:14:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCF9FFC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:14:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a14so7240949wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=dkhsx/f1qVfNpQ2gRDXYIwTY68Bz97MiITex7YRzTDc=;
        b=2wxt6g/M78F4d/hPa2+Kfql5eYMCMpkhtLTQgIowWZbk6VugLMYhUoHkZ/LSQhl7/t
         9DR0AKN6J9FIhzbCFUBijhPrf7EmAr8tcWklcQ9BJ+FHxkUiNO2uZXGE4K+7q100IlT/
         Bqj50J4yZyUz9ElyWH8tfh8+shAKb1xzCnj448DMiTL7CCODiIsu5obU0zTIhNxU13qb
         S2/+/XgFgd07DE16E9iClL2HeuJaSbLa5Kq/a1GGYSC50gVdEM7gS2aJbddW+X5SmUo7
         Hoj6a2H1LH588/jWdGPHVubluWKMq56gg7o9u3Ee8v/ub3u0brWcIHiHtKw67eTzWzWI
         KBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkhsx/f1qVfNpQ2gRDXYIwTY68Bz97MiITex7YRzTDc=;
        b=pbwqIM3gSoB4O4+4LsGV2UnPnfxLr9qJhFDKpKuLS6TDaDVuDzASl0Yipk8HMpJ3JJ
         87OnGj3zne2nldc562V6PVoNgpG9NcAtu7jtI+PvRkOC/S/zjnwOMd323PYRrq7wM/kg
         PnYu29d7p7szQzYJAtRN77m1u2GGVWBjBzIxSzi4hhwXGESI1v+syisKIEudrG0pekEh
         fWi4B+GZlII9UWhNN3kIwUYg/LcMr8bpDYKNxceajOVKUSMKUHBy0Hx5oqjyNiG68+yl
         UOfZeOSRF/Hm69pgda/7NtwqErRAq70BrMr5BRAj6GG5YVazE0QG47S5rhSZxdgDdLjt
         qskw==
X-Gm-Message-State: ACrzQf2pqZs3VKNhWOuxiHa5dYU5et68L8HyyFIdn16GqsQA4GhicOZ9
        LuEy2uQyJTESrhD/Q82jOYVJow==
X-Google-Smtp-Source: AMsMyM48zF9LQVcGi2NS+xsg9MQEat8n9V4ePGrQVLsNqsfhWhu/0S0WAkVM6laGPMKiYfM4ViunHg==
X-Received: by 2002:a05:6000:381:b0:236:f075:d2a9 with SMTP id u1-20020a056000038100b00236f075d2a9mr9822118wrf.65.1667571246699;
        Fri, 04 Nov 2022 07:14:06 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6440-7fff-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6440:7fff:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id bj9-20020a0560001e0900b002365cd93d05sm3594512wrb.102.2022.11.04.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:14:06 -0700 (PDT)
Subject: [PATCH v3 00/12] Add MT8195 HDMI support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIACodZWMC/13MTQrCMBAF4KuUWRtJYpDElfcoIvmrGWxTSGqglN7dwY3Q1fAe75sNaiwYK9y6DU
 psWHHOFC6nDnyy+RUZBsoguZTcCMNSmPA5LW+ghbM1Mlds9ok2+TOOVCasy1zW38cm6PR/3ATjTGml
 tLh6o7m+O7uO6Eo8+3mCB/EmD0QS0UqY4Ac1cBMOZN/3L59Xi/bFAAAA
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 04 Nov 2022 15:09:46 +0100
Message-Id: <20220919-v3-0-a803f2660127@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDMI Tx on MT8195.

This includes a split of the current "legacy" hdmi driver into a common
library of functions and a two dedicated compilation units with specific
code for mt8167 and another for the "new" mt8195 SoC.

Support for the new mt8195 hdmi phy and the dpi/drm_drv adjustments to
support hdmi.

Based on next-20221104

test branch with dts and various "in flight" patches available here:
https://gitlab.com/granquet/linux/-/tree/granquet/linux-next_HDMI

I haven't updated the vdosys/mmsys/ethdr and mutex patches in a while
in that test branch, they might be outdated..

To: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
To: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: CK Hu <ck.hu@mediatek.com>
To: Jitao shi <jitao.shi@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mac.shen@mediatek.com
CC: stuart.lee@mediatek.com
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes in v3:
- phy: Grouped register and bit definition together to add clarity
- dt-bindings: Addressed comments
- Link to v2: https://lore.kernel.org/r/20220919-v2-0-8419dcf4f09d@baylibre.com

Changes in v2:
- Removed syscon requirement from the hdmi node
- Use as much as possible bit FIELD_PREP/FIELD_GET macros across all the
  patches
- Make cec optional dynamically instead of hardcoded with a flag
- Renamed hdmi variants to v1 (legacy) and v2 (mt8195) while waiting for
  a better name
- Rework hdmi v2 code to use a connector (same as v1)
- Remove "magic" 0x43 addr special handling in hdmi ddc code
- Link to v1: https://lore.kernel.org/r/20220919-v1-0-4844816c9808@baylibre.com

---
Guillaume Ranquet (12):
      dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
      dt-bindings: display: mediatek: add MT8195 hdmi bindings
      drm/mediatek: hdmi: use a regmap instead of iomem
      drm/mediatek: extract common functions from the mtk hdmi driver
      drm/mediatek: hdmi: make the cec dev optional
      drm/mediatek: hdmi: add frame_colorimetry flag
      drm/mediatek: hdmi: add v2 support
      drm/mediatek: hdmi: v2: add audio support
      phy: phy-mtk-hdmi: Add generic phy configure callback
      phy: mediatek: add support for phy-mtk-hdmi-mt8195
      dt-bindings: display: mediatek: dpi: Add compatible for MediaTek MT8195
      drm/mediatek: dpi: Add mt8195 hdmi to DPI driver

 .../bindings/display/mediatek/mediatek,dpi.yaml    |    1 +
 .../bindings/display/mediatek/mediatek,hdmi.yaml   |   61 +-
 .../display/mediatek/mediatek,mt8195-hdmi-ddc.yaml |   51 +
 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |    1 +
 drivers/gpu/drm/mediatek/Makefile                  |    5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  143 +-
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h            |    5 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  655 +-------
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |   16 +
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c         |  477 ++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_common.h         |  224 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c         |  367 +++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h        |  309 ++++
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             | 1592 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.h             |   31 +
 drivers/phy/mediatek/Makefile                      |    1 +
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         |  543 +++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         |  109 ++
 drivers/phy/mediatek/phy-mtk-hdmi.c                |   15 +
 drivers/phy/mediatek/phy-mtk-hdmi.h                |    2 +
 20 files changed, 3976 insertions(+), 632 deletions(-)
---
base-commit: 8d9826217c539e9dbc3472823dc536cff1d517a2
change-id: 20220919-hdmi_mtk

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>
