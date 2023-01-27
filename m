Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32B67EA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjA0QAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjA0QAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:00:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BC8661E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:00:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b7so5393355wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=6AO8Wz0u03xQDCdINgTFwoolBurWKDLddXY3VYk4B+s=;
        b=cfGKXGy6jB1Gr9nmWaUv+Q92QA2JF0D1vQTXYRo/qtQPv/n8CxDqky+m4f/LapHdaC
         V1H6DhAQlIXeBzAm3PE2aw//nLeTCUJLwvd9Zb/nqxpqUB2VLaDc4gWFSZGN1CaX9vXn
         Kjst7ZgC+IkK5tNM0K65qh9PPz0D//eYBHe1P7cJ9mAornRjtTprXTsVkKljVFY98SBy
         rXTbgO+7qMA6ll8zBqboocigNzUuLU2y9FyA57Kd5/mnCKwsktyt/xCsIFnEdVg/DEvI
         qzV2VhX9403CCxSVF7uSjnKS8Z6tyoB6B6vzJSjW67tlH/CBiRUgJstJRlu7rEY+N0+J
         SD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AO8Wz0u03xQDCdINgTFwoolBurWKDLddXY3VYk4B+s=;
        b=iteFuClIUmWeivXF/ac12lI2q4IBprCb2h/qpFYToGhVL02qGEOUAx1OrQUx4ew2aE
         EPiUIDvtYN+vkeoCeminsSuB1K33DzkIuuXUvSo8v2Vm4Mx9dC68dgsrS6xAWYi+l/8Y
         hc5WVGmBuoRAzFN491y1gGc1SUGs2AW+LeaSNyYoE9TILHrcWyKKHP/x/Vaog3pB/dRD
         FW6iCenGPLeBwHejPQHEEazx7HpwFdNnWxacHY3PXywUTm+C1D7l6J5JEoivU5qEJ24F
         ZcCKRYU4nSw1sDJGx1rvVOiB24m7NutEpvsZQ+3WH3DtRghvHIrWh8TSqgZtlPI2OTnZ
         DZWg==
X-Gm-Message-State: AO0yUKWKXzgroWAq9U+xf6lCBZ6JLF+q/25TDAvMVqj4bj/QaKKccn7L
        dB6DUq1YBTe07EVJ1biFMvnM4Q==
X-Google-Smtp-Source: AK7set85MlINC1wX4kubGlvrGJsyxc6hLXlmKS/ArhQuSin31sebkVDcYK0X3xLR5HCG9POJz7mtaw==
X-Received: by 2002:a5d:6dd2:0:b0:2bf:b0e6:f463 with SMTP id d18-20020a5d6dd2000000b002bfb0e6f463mr11858738wrz.13.1674835199706;
        Fri, 27 Jan 2023 07:59:59 -0800 (PST)
Received: from [127.0.0.1] ([2a01:cb19:85c2:1100:7fe1:513:212f:568e])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b002bfcc940014sm3171942wrj.82.2023.01.27.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:59:59 -0800 (PST)
Subject: [PATCH v5 0/3] Add MT8195 HDMI phy support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANvz02MC/23MTQrDIBAF4KsE17WosYl21XuUUvxLlSYGNBVCyN07dFOQrIb3eN9sKLsUXEbXZk
 PJlZDDHCFcTg0yXsWXw8FCRowwRiSV2NspPKfljWChVXZYJxWNh038jCOUPuRlTuvvY6Fw7n9cKCaY
 C84F7YwURNy0WsegkzubeUIP4IVVhAERnEprBj4QaQ9IW5EWiBKkHVjXEcr6A8IrwoFoaxh1tCW9kx XZ9/0LLLTAOysBAAA=
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 27 Jan 2023 16:55:07 +0100
Message-Id: <20220919-v5-0-cfb0e5ad29b2@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>, Jitao shi <jitao.shi@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, CK Hu <ck.hu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mac.shen@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, stuart.lee@mediatek.com
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

This is split from the previous v3 to contain only the phy related
changes to the HDMI support for mt8195 as suggested by Vinod.

This is based on top of next-20221121

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
Changes in v5:
- Adapt clock bit ratio when TMDS is over 340M
- Used sized integers for register read/writes
- Removed useless comments
- Shortened function names
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
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         | 523 +++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         | 111 +++++
 drivers/phy/mediatek/phy-mtk-hdmi.c                |  15 +
 drivers/phy/mediatek/phy-mtk-hdmi.h                |   3 +
 6 files changed, 654 insertions(+)
---
base-commit: e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49
change-id: 20220919-hdmi_mtk

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>
