Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C51A638D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKYPL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiKYPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D8E10FCB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t4so3671126wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=XJxTDeXeIWQYLD7JipzsnC61wDCNzbvkJYjH3GkbQc4=;
        b=f70FiwS+6LTA1RanYy/8t0VxONnDQjyBwpY+GUS7suJdPMiRPy+tIiuH6gcAubmKjK
         wVAn5Uv/I9Ae+oPCKzv4wXUFHoCVwfp5oxXLAyQgcBlpO8qRz9DdlsRXW3VYw3Hx6Yi9
         yMmxKc/PiivGCg6nso8aseq44GazboeAkgdz5jupauOrzdPoURcLAxV17pekN7Z8mG9o
         6lfmsaKrcvwqq73WMi0X4RtyLleaic9DDMK02erYz1Rffml/DmxwJUuwvJdtqk69S1iI
         nq7/oeO7F+/WQYZF1uInLl1VBzom0q7bT2WZxUhb+Q+NE+jFTvGiP0JmAUJpbCjmx5Kf
         OuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJxTDeXeIWQYLD7JipzsnC61wDCNzbvkJYjH3GkbQc4=;
        b=jmbP8jHoZG5mkWzW9c7ZgGZ3NuI6ijNgUMyG9s8AZoTAjIlIl42prI/cx2bR1WM7v7
         g8OkZ/ArPsu6l/MafJmqY8AEtCiKJ8jNqHFiHsNKaxHhv7T8UyyHzvv3IY/2ZN93wI8v
         JhZhEzuDyG0ll9d4kusLwPNpUkKLEM8GPdRTG7fNOKRXqiKDYWWn59HF1R6tcRyPTQvm
         /ybqdMr6hmGVxxdnACfee257rL6/Z/6gwJeMc0k9/UGr3vCsj77ldD38NlWtoWCrEP0X
         byGixsl96bTg9Ell4qFtq6x02e5aKMWq78BCI/nWuNmQGk2nCivAdYE/wUQz9+caA5XR
         yoQg==
X-Gm-Message-State: ANoB5pmOM4JP6gbKF9grxlwViiS/Vftc8mlqQv6ztcMoV971LcQiUWyN
        1a/AUc2Usd98Kr+kfGjW/YslgQ==
X-Google-Smtp-Source: AA0mqf7+7d/sQ3IiRQAa80tIBPWkqZ/V9yHRIDk37st4q9LcHQhMW6ZVgj75Mvyx5S/MhNjNVwccOQ==
X-Received: by 2002:a1c:6a02:0:b0:3cf:71e4:75b with SMTP id f2-20020a1c6a02000000b003cf71e4075bmr16311984wmc.114.1669389080513;
        Fri, 25 Nov 2022 07:11:20 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:19 -0800 (PST)
Subject: [PATCH v6 00/10] Add MediaTek MT6357 PMIC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANPagGMC/33NQY7CMAwF0KugrCcodXATWHEPNIu4NtNIpUVJqYRQ7z7WLEfQlfVt/eeXqVKyVH
 PavUyRJdc8jRrar53p+jT+iM2s2YADaJxDe5tbj8HWx/0+ldkiehcpgnh/NVqiVMVSSWPXa218DIMu
 +1znqTz/niyg4/LRW8A6e20CJWBgl45nSs8hU5F9N93Mt2qL3xa8CkEcceh8gwRvhMO2cFABGYgwSu tieCPgtoAqRD3xEZHZ8z9hXddf4yU9+3oBAAA=
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:11 +0100
Message-Id: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6755; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=FgsXPgRXvQqbCe+YwUjx2VoAtXg81wnZiWFINiOzpLo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsWBkcBpKvN/k3q2Z5kAYRf6DZ8FyMGz504eSgP
 ZbiGMF6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFgAKCRArRkmdfjHURcKNEA
 C/Bkuh8P4rVzqqS7DJjIa2PgrRXckXRF5DQnKYYkQyVhtKQOXgXT0JCQ4C4kGiiriO9IYn9Turk0Ik
 klJq+Sp2vaHbcEOocoTn7QeatBx4d9/HokgQJB5/VNvC6yKdW6/UrjKcO7YQP7KEYh/xenSR2fvgQ1
 Hx5yhtChx8HYFe7p7daQ/mEu9X1h20bxv7FMrf8XUT/8UrbJkCE3KrqdZnFW2nE0lrGqSSl+x+o8tV
 APYSRuLVOtBhKVoxH8a69G8YinOOZlyQEDgn0aBCZbC8q0sfVdEqR/38FwDMEfmrGhwICibGVDXMKC
 D6W5JBXRGU+4usgZOIu1nBCNMh5x+GIVl2yn4OBaR0tgpviLnUuQz6UEaOVh2Ry6Q8xcnU/FxGeXZG
 cCTuHIuEOlBrZsiDdEeLkAHm9EBzQxvgITNM7cHJYzDWHZZCAXR8JEyMVv7QcvgJ056CbXh8yVDzYl
 3QRZB5+92OZM4JWz/7TnnapfUO8FLQ1OhvwF7l2UnxgjsUbvCHFaNJ0JURh+sMX1y9iXt7MrhI9m0O
 Kl54hqMlLNm2RU0+O0SHDeX7ggNAxXLfH1xqZPpSqXo0OGDpqymABsgdwBxZTpxCETXlFwwrzvqe7u
 j8uLc1ahikc1eeXujWbhXdy2i+9G0k6M1xv/B6Z8v6/I7oyGHsSSBFK4ohjw==
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
Alexandre Mergnat (6):
      dt-bindings: rtc: mediatek: convert MT6397 rtc documentation
      dt-bindings: rtc: mediatek: add MT6357 support
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
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 105 +++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +-
 .../regulator/mediatek,mt6357-regulator.yaml       | 294 +++++++++++++
 .../bindings/rtc/mediatek,mt6397-rtc.yaml          |  36 ++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  31 --
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
 17 files changed, 1122 insertions(+), 114 deletions(-)
---
base-commit: f6e37bb630736d880a319b7845e8837c8536dd59
change-id: 20221005-mt6357-support-55308b82e33f

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
