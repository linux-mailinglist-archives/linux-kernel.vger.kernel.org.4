Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109A75FEABB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJNIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:45:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461533C8F7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:45:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a10so6458047wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=qU3b+QKkmvNWqoyQI19aCkTzRWNRWtrZ1TP3yM6JHaQ=;
        b=LxOLiS+9XkXnvyiz3FPAV9/DUW1oiPeZWzV2ys6vXleGK/CTdiIv6OBTVbdw+SPufZ
         IDURv6tFMsQ3X8Uh7Ee31whNzJrCbVoFHAjnPNZB2ETyHGNUMVL29x7dpQS3PK685WXs
         i6sVjtzBPi8gCdcxImWIwDvq1psvp731ZVeq25+gPXCkBMssv4nkjpATIt//pkOnWPR8
         MpUjhrxUDRU9xCa90/SEg/dZ58CkFmpMJMKDCX/PE9eX7iOlAGkW+IRi4p/dKHpYlleN
         hnxnY2pktAOcDpt1dC/ZIb2AML7AMEEiaSOAdB3BT0eZICWJi6eSUVqdqEd1Z64fbPe3
         KlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qU3b+QKkmvNWqoyQI19aCkTzRWNRWtrZ1TP3yM6JHaQ=;
        b=RxBK/975RTh6q5ia1vojjNoZv66r5oew7tfLbk9p36g0Nti0uL+gfDtNk2qRsb04rQ
         Yku2NSE8k04olR9aMrXMc3eqxUkLkfSWNJ4eXqpJWVAjjK2EhQcxLPCQkGfxAOaVpPA1
         X6MkTyhjE/FogtNrdXpius0ReXLWp3pYoeKIrslCoWXgFxFQGFUQQ0hYCh6O6h78VLIW
         XbLMvY+VlAOBqoj5kC/eXBw/OXGQoa4pwyMxZWrozVPLtATeraYiPIjTDTo1S9dOGsb9
         7VM2ia+VtJDJa50XOWWAEgGxqvxXrRLSelZ4lwSJ6ywp2D/Qn7sue/mVJiLvnL7giFc3
         qVGw==
X-Gm-Message-State: ACrzQf2iOjZ1tptuU1myUKaiVyWntvBpbaTmPVgieaVHaL5cwoRanUlW
        orl90iU/nmg59+ZaA0tz6Yu10Q==
X-Google-Smtp-Source: AMsMyM75SKwHKMzfLNtH31ZbKh9ImYHULUMQJz9S5W+AWudLj646M9oBHODI6iDOvgHfBXv67ejXUw==
X-Received: by 2002:a05:6000:1d94:b0:22c:c4d1:3622 with SMTP id bk20-20020a0560001d9400b0022cc4d13622mr2494179wrb.63.1665737132719;
        Fri, 14 Oct 2022 01:45:32 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a1c2606000000b003c452678025sm6684633wmm.4.2022.10.14.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:45:32 -0700 (PDT)
Subject: [PATCH v4 0/3] iommu/mediatek: Add mt8365 iommu support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKghSWMC/42OwWrDMAxAf6X4XA9FcZy6p/3H2CGylcWQxMVuAqXk36f1ttGGnYQE7z3dVeEcua
 jz4a4yr7HENMtijgflh27+Yh2D7AoBsQKodEzTtOiyXC4pX3VvwPmWwRm2ShjqCmvK3ewHoeZlHOU4
 xHJN+fZorCjj45VuRQ3aOqI22ACAzTt1tzFS5jefpp/AHhio5x6Zmbz7DX4Kuda75VoE/lQT9+wROf
 y7/ABbqqFxBKGyT8pmt2xEwN7K841hauiPYNu2b8Sb7KSmAQAA
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 14 Oct 2022 10:45:28 +0200
Message-Id: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=awStn1Bgi9IVLZZwAhDl6q1K64EBotws/kG7Aa33kjg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjSSGrfHPrOmp5a9BnpRr7fsC63XP6OroMz8PGyKw0
 lNvZgLSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY0khqwAKCRArRkmdfjHURe+oD/
 9A0itZcbHB5SXR7mNfM9dA3I6xlZzVIwR1SXL4FHIQiXIEDPCkvVN8ZtY05jb0RffkPt7sRn8VewKx
 eJytkKLfeoEQql93FNrk3H4IiyHlvjtk+7xGnOp/PeyfdTgB6q0TSljtAo8B5Qp0HHcjhXBPQ/IUHI
 g/x2nS1yZACBZUoPaSUc3jM6gXJkAa59St03ydauyZtAjGpjV218xhabSyzmMAO+CQ13GaVCNwVKaC
 gTQbVmwZMhn+MFxgrsnvu+u1xF071ibjssV84sF6ggioFIEd9KDLQ5UTN6yF0hKJTDXqzFkqKnnYCA
 OaTg/Ktm0HeWkGRIn4L+98dmKn3LDxd+czQJC9GqGkOqhanXSu0+m3tmQUX2hBElL1qbslXXOIwK8x
 vleS16lvW1qBeBppFUAOaZuxRWbIzmRntbhascwZA3MPKW14rRoC+UDXHf8wLRLixELArMhK7S+Tfk
 F4IBDiWTXZB4o3uL8lWsVCRNBl5DgI0nnd6Z4uhEEb0WtcgLVCvXhg+fGNv7qOVQFHgd4IfSizxt0y
 1KWnLlkKx5c9vBw+dyGkzIpuT9pO6kP0yyAJWhN0lK4qUjO36z1ekBgbPe4jtUTcb8oDdr5jiQB9dc
 FlNGmisi9xrFAJoNO6Cf+wP2JMwwZiOgVvKW9w+KR7q89izHWSVj5w7husHw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains patches related to the support of mt8365 iommu.
Thanks for your feedback so far.

Regards,
Alex

Changes in v4:
- Typo
- Rebase
- Link to v3: https://lore.kernel.org/r/20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com

Changes in v3:
- Rename "mt8365-larb-port.h" to "mediatek,mt8365-larb-port.h"
- Rework the macros which retrieve larb/port ID to improve human readability
- Link to v2: https://lore.kernel.org/r/20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com

Changes in v2:
- Rebase.
- Change M4U_PORT_APU_READ & M4U_PORT_APU_WRITE port to avoid display
  conflict in larb0. These definitions are used for vpu0 device node.
- Add dual license.
- Retitle commit.
- Rename to int_id_port_width for more detail.
- Fix typo.
- Set banks_enable and banks_num in mt8365_data to fix kernel panic at boot.
- Link to v1 - https://lore.kernel.org/lkml/20220530180328.845692-1-fparent@baylibre.com/

To: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Fabien Parent (3):
      dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
      iommu/mediatek: add support for 6-bit encoded port IDs
      iommu/mediatek: add support for MT8365 SoC

 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 drivers/iommu/mtk_iommu.c                          | 30 +++++++-
 .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90 ++++++++++++++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)
---
base-commit: 11082343e3bf2953a937509f0316cabf69dbf908
change-id: 20221001-iommu-support-f409c7e094e6

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
