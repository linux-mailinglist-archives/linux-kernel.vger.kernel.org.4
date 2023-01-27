Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2167EA99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjA0QQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjA0QQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:16:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31627AE6D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:16:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3847278wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=LD2mVmTYVkgVFaby6r4EipeMY5amZrRMiimJ3O/2RrU=;
        b=5seBXzzPgAeLvHuN9wPZVB6vmQFDHRfeQT+yEEifWtgG1OEyoAI8qCCWDB+eAYBjJt
         kw1UiK+Sko5zfe32q8ksuqAK3DJZg80mFqkRae2Y27vmECvHzrYBoS6wd/pXpT4PZGHj
         S7hTqxrketXSov7vmhY3DoTy6WRjkqO7XyxR/c4bApyUcyrN62VS4E89kY/Dfyczoqk0
         /Qml15BPIxlw70zpH802Gwn3j0DECyHP4sw80t/gxE+eq8uY9F9EswFBFPC/gnZAjSfD
         8rbXCSfltXoI25jlvp33H/24Dz+2OW2ryZtYk8iSEk8N96sXn4Se5JzSMYDf2o3UZxtV
         cDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LD2mVmTYVkgVFaby6r4EipeMY5amZrRMiimJ3O/2RrU=;
        b=uc5LnIV6FzwpYZwWW9r/NyrxdVs4urwZEEhQZ51LB228uZn5fKlhk3QG0tGonir1jd
         gZqzOoWu879DNsuc0IGc+AgUkOSbSzVYknpQndE4NDPSW8gyks22yWfowAcdGPMCPT42
         vlHnBdNgVZe3Er+FQfhDniH3QWTK3bPg8PV56tm8MyWqcH14roWnsUmH4pdrRG8VprX7
         Szd1XAgBPXB+jMyq1DB8586OMljmTn1osa8CwiTFe6ZqvOOwzLYJzynwDsS2M+1hYKP3
         8A0XZXw2Xib1OJh29uys9SZA9lQh9Gr+Wb5M/4RUg7C0scHjHVYgw522gWF80UBCk53X
         R4SQ==
X-Gm-Message-State: AFqh2kpe5WH6Xa8BMmvp0SgkDQW0P2RDhgdoixaYoId+HSeTou9OFImq
        Y0UrEpKxicQLHg06G1yZ1Z5zpQ==
X-Google-Smtp-Source: AMrXdXtOR4HuyLKvrKjT1o730urF+dKgb/mtCV6kH3TJ6KcijSkrbqDijR+KMDRiCxTlZwoNuU1aSQ==
X-Received: by 2002:a05:600c:d3:b0:3da:23a4:627e with SMTP id u19-20020a05600c00d300b003da23a4627emr38891278wmm.6.1674836176508;
        Fri, 27 Jan 2023 08:16:16 -0800 (PST)
Received: from [127.0.0.1] ([2a01:cb19:85c2:1100:7fe1:513:212f:568e])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c439300b003cfd4e6400csm4744566wmn.19.2023.01.27.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:16:16 -0800 (PST)
Subject: [PATCH v6 0/3] Add MT8195 HDMI phy support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIALX302MC/23MywrCMBAF0F+RrI3kMU0TV/6HiORVG+wDEi1I6b87uBFCV8O93DMrKTGnWMj5sJ
 Icl1TSPGFQxwPxvZ0ekaaAmQgmBDPc0D6M6T6+ngQXzpZIXbaT73EzvYcByz6V15w/v48Lx3P944VT
 RkEDaK680UxfnP0MyeV48vNIbsgXURGBRAM3wXfQMRN2iKyIRGI1k51QinHR7hCoCCBxwQseuWRtND ukqUiDpJOgAMB5aGqybdsXGnUs+14BAAA=
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 27 Jan 2023 17:11:33 +0100
Message-Id: <20220919-v6-0-2f641c422cb6@baylibre.com>
To:     David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stuart.lee@mediatek.com,
        Guillaume Ranquet <granquet@baylibre.com>,
        mac.shen@mediatek.com, kernel test robot <lkp@intel.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDMI phy on MT8195.

This is based on top of next-20221128

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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mac.shen@mediatek.com
CC: stuart.lee@mediatek.com
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
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
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         | 517 +++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         | 111 +++++
 drivers/phy/mediatek/phy-mtk-hdmi.c                |  15 +
 drivers/phy/mediatek/phy-mtk-hdmi.h                |   3 +
 6 files changed, 648 insertions(+)
---
base-commit: e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49
change-id: 20220919-hdmi_mtk

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>
