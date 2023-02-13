Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DC16944AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBMLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjBMLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:38:43 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8B7D9D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:41 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gr7so31076374ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/90RUFFsyhxTIlGFCCXSL5k3Rb6p3EDGwQoGJDsxy0=;
        b=AAsSe626xpvEag3aibZRY1D+gnpLWbu/ZJLqDdAtfuLJy09JbPa0xddFDrF/lPUYp4
         3Ad1KKUuqB907OPF0yodBzJWSGLJsfXuu5nuda6vLKFaqHIILotS0u0jZrhkB4m9qYWW
         g5CucycFXxWcZVEqxmj/0JdOFWmbxFlGavWcQ5rLpE7seNNT8V5DTP/g4cxiOwqS7vKn
         wv7ktizk2yPOYab5qrkhxgHXvx1momWjjOUrd2bnsH6sSE6Aci+PS+9eUHpHrnAES4pP
         s+jQLtdViE+8izHVfd231Bd1FhiPJ7edh65G+kEUYtdDpa1xMr5kx5516/4rWBOYn7e1
         sNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/90RUFFsyhxTIlGFCCXSL5k3Rb6p3EDGwQoGJDsxy0=;
        b=0eXhFdBGaSdj3KSxXZfz3AvVR2vzqbFvUbL78+cpjryp57cABiUO6LPFentrV+zOUP
         BBHxJ6APuIuLufyUOM+hf5ZMpWg6vzk4rrZHynxZ3I99f+RnwMSAaexK1jX2Eq0tdepI
         yY5qxND4t7j+dGgBXY5pxN6YPfXmA9RV0SsSg7Ay6gdlmz8NjwwZBW5c4y17MKoOyygw
         d9U9sb3eh4Rvaqe9GRBZXStKZto2impPvPg40I0WfTEo+QgREUoxYKYjUZIfL0PAdR4V
         IMt7FrIhFnpgrMXldsStDCooSZMB9RQpuHJv00zZpfUF3BX8FsJDG/ssXNw3eRqCn4q0
         +quA==
X-Gm-Message-State: AO0yUKXkH2QFDuI+LpR8tYX00PIbrZ6WxP3C1bc3mRi72BAOtEkMnOcu
        EETx+kTcaRRY7zTRh9yv/1or7g==
X-Google-Smtp-Source: AK7set+DHNqIFOpozfBDldGxHMxVi/rXTgwwL0gV7IG1EfsqnQE7FkA4BM7FFcwSalBd3dxTJFcGrw==
X-Received: by 2002:a17:906:4413:b0:878:673f:5492 with SMTP id x19-20020a170906441300b00878673f5492mr23699631ejo.40.1676288319630;
        Mon, 13 Feb 2023 03:38:39 -0800 (PST)
Received: from [127.0.0.1] (2a02-8440-d206-ae05-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:d206:ae05:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906061400b0088ba2de323csm6638792ejb.181.2023.02.13.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:38:39 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v7 0/3] Add MT8195 HDMI phy support
Date:   Mon, 13 Feb 2023 12:33:31 +0100
Message-Id: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsg6mMC/23My2rDMBAF0F8JWldFGo1lKav+RwlFz1rUD5ASQ
 wj+9w7dFIRXw73cMy/WUi2psevlxWraSyvbSmF8u7AwufU78RIpMxAAwkrLp7iUr+X+w2jhXUv
 cV7eGiTbrY56pnEq7b/X593GXdD7/8S654GgQjdTBGmE+vHvOxdf0HraF3Yjv0BEgYlDaGDJmY
 eMJUR1RRJwRKoPWQsJ4QrAjSMTHADJJJcZkT8jQkYFIVqgR0QcczojuiCYCWaMMCBC87shxHL9
 fFxI9kQEAAA==
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com, Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDMI phy on MT8195.

This is based on top of next-20230213

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes in v7:
- Removed lkp reported-by trailer
- Fixed checkpatch --strict warnings/checks (besides two lines at 102
  chars instead of 100)
- Used constants where applicable as suggested by Vinod in v6 review
- Link to v6: https://lore.kernel.org/r/20220919-v6-0-2f641c422cb6@baylibre.com

Changes in v6:
- Adapt clock bit ratio when TMDS is over 340M
- Used sized integers for register read/writes
- Removed useless comments
- Shortened function names
- Link to v5: https://lore.kernel.org/r/20220919-v5-0-f346444bc459@baylibre.com

Changes in v5:
- Fix compilation errors on 32 bits platform with no support for __udivdi3.
    Compile tested on mips with gcc-12
- Link to v4: https://lore.kernel.org/r/20220919-v4-0-bdc21e1307e9@baylibre.com

Changes in v4:
- Dedicated series for HDMI phy support (without the drm/ related
  changes)
- Removed useless variable initializations in phy driver
- Link to v3: https://lore.kernel.org/r/20220919-v3-0-a803f2660127@baylibre.com

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
Guillaume Ranquet (3):
      dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
      phy: phy-mtk-hdmi: Add generic phy configure callback
      phy: mediatek: add support for phy-mtk-hdmi-mt8195

 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |   1 +
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         | 509 +++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         | 113 +++++
 drivers/phy/mediatek/phy-mtk-hdmi.c                |  15 +
 drivers/phy/mediatek/phy-mtk-hdmi.h                |   3 +
 6 files changed, 642 insertions(+)
---
base-commit: 09e41676e35ab06e4bce8870ea3bf1f191c3cb90
change-id: 20220919-hdmi_mtk

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>

