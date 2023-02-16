Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA43E69998D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBPQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBPQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:12:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42A4E5D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:12:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m14so2320757wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lFXqhOt2OsAjZlN9q24biXqlMln9UilMimz3k+ZbCE=;
        b=L0sVkWCeH5g7Y1SN9yP507VBDypXN55J/yXZKy5ne+L5Zy1kHCp1Kj+tL+6mSj5H2d
         Qvyl5gTe2zGLS3cXoRhnibKk3SzJSDifV12O+6PXYb9KiC5olmaeDwQd/YlojJ+leF2i
         VwfdJn9HiWl+waQTF2siGDa0oII4sQp7flT/SOb8dU13EHDt5XNM5FiUPi9oc3Wr1PcJ
         2OFoLOety3Fetv4cSosf1x9KLuCz8UpDV72gD6M+jnFkOymTW6HCEC0hbtYdgRDFcAgu
         /5XEUKrKLEsINNiqkO/JxDcLVRmmoUI6W+JEAnKYgHc2xDCEe3gjeotvDWDPkWkec3dc
         LzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lFXqhOt2OsAjZlN9q24biXqlMln9UilMimz3k+ZbCE=;
        b=e4dNdgpolJogNqKRapp9ueXZMFzz42alEtKhgaCzeyRU3o38LjLGJoMpV4E8lbLg3j
         fzGAIf8ojzVMlgX6rM/WeZwAO7kxe1RUY1/W+LwwHJwzhh56DBCrxmoSP/tXv5Hzutu2
         cDZ/PuP6n2o6WDUoAVkY2h8lKz7+pmArBZvLe1kdAqRw2tnDYjPGS7c1254wwmKjt0Aw
         hMhN+eHSnfGnU9iVms1u4feCZb0IUoQe3VbCC9xzjCYYBAIf2akxRcyQ1gXGv2+xoWgp
         gBw9rhvgH+7ZRwHweavm614kLvLibIk4gsa1zRnT+hCtD49AMv1Pcw4qjqXGK5nk/BnF
         9Jxw==
X-Gm-Message-State: AO0yUKUuloViipt5OEIyrvzpzxPUOpe6dEqxw3eqQjGYdwiFukLDZE3w
        SgTMd0kJ2IWVrdHkoGw1ykQcgQ==
X-Google-Smtp-Source: AK7set9HfpJ/WtYQfwUA/WaYWlKP16uqXWuqMuHS3egf3HT7MZs2MM9vbGhFeIU7EHTCRrVrA+8KpA==
X-Received: by 2002:a5d:55cb:0:b0:2c5:4154:9f32 with SMTP id i11-20020a5d55cb000000b002c541549f32mr5049388wrw.65.1676563935831;
        Thu, 16 Feb 2023 08:12:15 -0800 (PST)
Received: from [127.0.0.1] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id m16-20020adff390000000b002c56a1a5a95sm1845586wro.30.2023.02.16.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:12:15 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v8 0/3] Add MT8195 HDMI phy support
Date:   Thu, 16 Feb 2023 17:02:24 +0100
Message-Id: <20220919-v8-0-a84c80468fe9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBT7mMC/23PS2rEMAwG4KsMXjfFlmXH7qr3KMMQy3Zjmgc40
 8Aw5O5VuymYrMQv9AnpKbZUS9rE2+UpatrLVtaFg3u5CBqH5TN1JXIWIAGkV74b41xu8/1L8EQ
 YttSFOiw08szyPU3cHMt2X+vjb+OuuHz84111skOH6JQl76R7D8NjKqGmV1pncWW+Q0OAiUPlI
 2XM0scTohuimQxO6gzWSgX9CcGGIJMQCVRSWvbJnxDTEMMka7SIGAjNGbENsUwgW1SEABTsCek
 b0v8eZoJxZIhItr8cx/EDtv41ScQBAAA=
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

I'm sending v8 despite a pending question from Vinod [1] regarding some
odd register writes for impendance.
I'm trying to get some feedback from MediaTeK regarding the content of
thse registers, but It may take some time...

[1] : https://lore.kernel.org/all/Y+upK4nCCYlg+4dU@matsya/

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes in v8:
- Used GIGA / MEGA macros where applicable
- Link to v7: https://lore.kernel.org/r/20220919-v7-0-b5b58c5ccc07@baylibre.com

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
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         | 495 +++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         | 113 +++++
 drivers/phy/mediatek/phy-mtk-hdmi.c                |  15 +
 drivers/phy/mediatek/phy-mtk-hdmi.h                |   3 +
 6 files changed, 628 insertions(+)
---
base-commit: 09e41676e35ab06e4bce8870ea3bf1f191c3cb90
change-id: 20220919-hdmi_mtk

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>

