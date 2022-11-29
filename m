Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69A63C46E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiK2P5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiK2P5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DAD3FBAD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so11186946wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=9cT9eY9V1xGeVmdlYi9xsAkTdg7w7/HSLsB4PWNKGgw=;
        b=GSFjwxVYrOvZnxXeKOG1mXSHFUUjH+6TfW+LuGB/qqkRkRn+pi2370UkFfKGWthhiW
         NO4yC2Xm5lZpt/NMfXHlSP7gpPhoWCtCmdxRlaX3BA9j0TCxgIZgtCmJK03ixcS8gu0p
         wA+Kjt0RYZOl6IBxSvXZ/3shPnk7qUD1Mv1ePqi1TE3KSkwvtYQOezuT2eP9VMq+xJXf
         bmqFKefY6PggAN7pTXAotNmeeuLivo4QcEJkwIyThCipoQISjo/o8tdeiUOmBSaiwxWU
         VM4Fnbl8UK6ttX91DiC11G/ldK/8cPsFBnZW2DnjQ1+mPfQ0+M/57KYULDMIlhuAhBxR
         XNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cT9eY9V1xGeVmdlYi9xsAkTdg7w7/HSLsB4PWNKGgw=;
        b=2t6M2QqhqeB1kAuNyOODHtMEAbnTxYgjBwawRkgMnJAlGL45RZUhR9HBKZmTQYRcED
         S7/x5EwWzmWZFtw9h+D0mlVj+vbBFmyCWvu/lxwPWnFVZ31d5KyLnkhBNHOd+7mzFpQD
         JjAVF3y3pShHlILmWNhaHtBVOOZKrEMuF5ZmABgWQEV9by8D04swMfdLeZoU6wJIeGkl
         G0lvNG/N5Q+BwMPdAP0fY6LTluJEJY64gTgQMyWhMeO6gQPGbAIVHxN/C2vQ8/Yp4nUN
         iX0e/+bot1EJXtvXXkMufilmfnD2t7a2xdLDNvwXrJlpSOy5PibVYl3S/wYoc6iO2mlR
         Nmsg==
X-Gm-Message-State: ANoB5pnDCV7XmsB6SJOxmtET+DbYJn0cneJRchZtYhbGvTQFFoe0lKj3
        4/34FhODYXnMA6wMesLglBWp3w==
X-Google-Smtp-Source: AA0mqf7a/uNfdsh/7H4r89x7hh5q1/8Z5l3vM7esHKeAiqIvXE2W93f4XnSlqHDEyHPZ0T6Rrps9Ow==
X-Received: by 2002:a05:600c:42d2:b0:3cf:c907:a05a with SMTP id j18-20020a05600c42d200b003cfc907a05amr44540859wme.177.1669737425037;
        Tue, 29 Nov 2022 07:57:05 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b003cfb7c02542sm2601550wml.11.2022.11.29.07.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:04 -0800 (PST)
Subject: [PATCH v7 0/8] Add MediaTek MT6357 PMIC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAMsrhmMC/33NwWrDMAwG4FcpPs/DkSPb6WnvMXawYmUxpEmx00ApefeJHUeWk/gl/k8vVblkru
 p6eanCW655mSX4t4vqxzh/s85JsgID0BiD+rY6i17Xx/2+lFUjWhMoAFs7KClRrKypxLkfpTY/pkmW
 Y67rUp6/TzaQ8fmvt4E2emg8RUiQTOw+KD6nTIXf++WmvkTb7LlgRfBsKPneNkhwILTnQisCJiDCwM
 4EfyDguYAiBDmlDjElmw4Edy44EdoBQ+fREQ/xj7Dv+w9+AoIavAEAAA==
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 29 Nov 2022 16:56:59 +0100
Message-Id: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6769; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=XJ7rH7BqCc/2CFaN/h/E5eGeg1OjcZ68setrFIOtCaQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjhivPr8A8ybgzH1k0EI44AOfZwyjUPlUsinHiY5RQ
 J7VLBiCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4YrzwAKCRArRkmdfjHURZqID/
 93t438MbTmhu8y9LJNiU81vhIiJFQGZJonp+/qR0dJgLwAxIS8NVsf6tv6dCBrb47WilqISTf0accb
 9tyS9yHOj9rhqkvz27Md1QtOzNbsObad2ljHDcjX2iDTLj8tcr8UpBRsMlEZZT9D0JP5AiEJ5JrnIK
 fDI6TFyOsh8VpC8VcC4wSpDwkh0kE9p4tsWC1P98KosVHeLJIO17B25KpGT9/AGxflNqUN6x0C2/St
 SbO+G6jDQAfcxPDetkPX+2745iqSdJI9HdNI7Cah8H2eMJhF/dW52kERjMfeC+BWglj5I8iEaD58/C
 bnL2DD98GOvY9Dw22BAzv/TkAP4ipzh97lkoky/3T47AC/UlAJxPUdUtXh3jQYnsBv888Rif3hLChp
 VrTTOJ68Z++IeH1e1VO6TbtZIht46JpmsXziMkoQv/FwgPGYmbbYQdoVDVu+1xpjYjZ/Pkwm6uLAme
 k6cXRf93bBYsiH8aMSIGlojWCYmd9qjzwqRbB34jXY+mgZJBAY4XBz5U3nuQSUaKMam9dPcfDgm0iB
 Yh53umXFWr+QXNzfdcfo+GO0GqeIM/gYThOyloiCHHcSwBVBLHNAle80vhUZN4KrqjEST3B/PvPW8W
 qSTVZOZU0TSiuSaOV/zIRdqS3OjiIoRZiJvtRcdf8z+wF1E+lo5CsA29M8Nw==
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
This patch series adds MFD, PMIC keys, and regulator support for MT6357.
MT6357 is a MediaTek PMIC very similar to MT6358.

Currently, MTK bindings related to the PMICs are not converted yet (still .txt):

soc/mediatek/pwrap.txt (all PMIC parent)
      |
      V
mfd/mt6397.txt (support lot of mt63XX PMIC)
      +---------------+----------------+---...
      V               V                V
regulator/...      rtc/...          codec/...

1) Convert pwrap to yaml is ok.

2) For the PMIC bindings, there are two option:
- Convert mt6397.txt to mediatek,mt6397.yaml and continue to support multiple
  PMIC with only one file. IMO, the file will be hard to read because
  the supported features aren't the same for each PMIC.

- Make a binding file for each PMIC ref:
    - mfd/mediatek,mt6357.yaml
    - mfd/mediatek,mt6358.yaml
    - ...

3) All PMIC daughter bindings (regulator, rtc, codec, led, ...) aren't fully
converted yet. Refering to the two PMIC convertion options above:
- To be clean, all daughter bindings should be converted. This is hard because
  a good understanding of each device is requiered to write efficient bindings.
- Only daughter bindings supported by the added PMIC should be converted, that
  allows to do the task conversion step by step.

In the V4 of this serie, I chose the second option.

Regards,
Alex

Changes in v7:
- Drop mt6397 RTC schema conversion.
- Integrate mt6357 RTC schema directly in mediatek,mt6357.yaml.
- Fix unit address in mediatek,pwrap.yaml.
- Link to v6: https://lore.kernel.org/r/20221005-mt6357-support-v6-0-4f589756befa@baylibre.com

Changes in v6:
- Fix typo in documentations.
- Remove mediatek,mt6397-rtc.yaml example.
- Align pwrap convertion with the original .txt file.
- Remove unecessary include in the mt6357-regulator driver.
- Link to v5: https://lore.kernel.org/r/20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com

Changes in v5:
- Add missing maintainers
- Improve RTC binding by adding rtc.yaml ref and start-year property
- Split the txt->yaml conversion in one commit and the addition of the
  new mt6357-rtc compatible in another commit.
- Improve PWRAP binding:
  - clocks and clock-name have been refactored.
  - reset-names is now properly dependent to resets.
  - additionalProperties change from true to false.
  - change example for a most recent and popular SoC.
  - "allOf" part has been simplified.
- Pass binding tests with the updated tools. Here the command:
  "make DT_CHECKER_FLAGS=-m dt_binding_check"
- Link to v4: https://lore.kernel.org/r/20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com

Changes in v4:
- "dt-bindings: mfd: mt6397: add binding for MT6357" has been applied
  by Lee Jones
- All fixed regulator are now refering to fixed-regulator.yaml
- vfe28 and vcamio18 regulators have been added
- pwrap binding has been converted and mt8365 support has been added
- mt6357 PMIC binding has been created
- mt6397 RTC binding has been converted and mt6357 support has been added
- Link to v3: https://lore.kernel.org/r/20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com

Changes in v3:
- To be consistent with regulator/driver.h and helper.c, shift
  variables have been removed and the mask values have been directly shifted.
- Remove index tables and rework volt tables to use set/get helper functions.
- Add comment to structure and function.
- Fix Fabien Parent mail address.
- Link to v2: https://lore.kernel.org/r/20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com

Changes in v2:
- Rebase
- Fix typo
- Remove dependencies with https://lore.kernel.org/all/20220415153629.1817202-1-fparent@baylibre.com/
  which is no longer relevant.

Previous versions:
v1 - https://lore.kernel.org/all/20220531124959.202787-1-fparent@baylibre.com/

To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen Zhong <chen.zhong@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Fabien Parent <fabien.parent@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sean Wang <sean.wang@mediatek.com>
To: Pavel Machek <pavel@ucw.cz>
To: Tianping Fang <tianping.fang@mediatek.com>
To: Flora Fu <flora.fu@mediatek.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-rtc@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Alexandre Mergnat (4):
      dt-bindings: soc: mediatek: convert pwrap documentation
      dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
      arm64: dts: mt6358: change node names
      arm64: dts: mt8173: change node name

Fabien Parent (4):
      dt-bindings: input: mtk-pmic-keys: add binding for MT6357 PMIC
      regulator: dt-bindings: Add binding schema for mt6357 regulators
      regulator: add mt6357 regulator
      Input: mtk-pmic-keys: add MT6357 support

 .../bindings/input/mediatek,pmic-keys.yaml         |   1 +
 .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 111 +++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
 .../regulator/mediatek,mt6357-regulator.yaml       | 294 +++++++++++++
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 147 +++++++
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 ----
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |   6 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   2 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |  17 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6357-regulator.c               | 453 +++++++++++++++++++++
 include/linux/regulator/mt6357-regulator.h         |  51 +++
 15 files changed, 1091 insertions(+), 82 deletions(-)
---
base-commit: f6e37bb630736d880a319b7845e8837c8536dd59
change-id: 20221005-mt6357-support-55308b82e33f

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
