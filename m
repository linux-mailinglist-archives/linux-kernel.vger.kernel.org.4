Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85062BE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiKPMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKPMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F524E1C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1356478wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=R0mtcbapNc12SG7qveDyhHcRn237sKO8IzVL/uWZIsQ=;
        b=v5UzEkcqZrK1gREL0R7n3vJHHAKiPtDlOhGN4U6SBY4aJMbxeWegynJS1VWBR0z3yn
         8lGwmhPeJ7fNydUP9xWQUogS8iToX2ihEVd+9yF6fa56JNewQOFwlVwY4FGHWEQ2QiP4
         DP3JD9psfPG9M3kjGtjLeqlD6EH4YoX0YQAiECnVWHL/x4WxxwaXJHPw9WnBaL0f+ks6
         RXRpaBJgI2pmKV4Kh5MaUMV4PXoQdLN6rHpIDBOZpIzOS4gX/LJIltwoSWyLjMHkuQzk
         jBQ+mnTMeBHkW04FITUsM09dD55Fka4uUKqewnvA4hWOn+ss0tXYObudLu70worG6MjS
         VWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0mtcbapNc12SG7qveDyhHcRn237sKO8IzVL/uWZIsQ=;
        b=y2uAevFwZ0QXjUb+xT/2mX1nv5IEc+Zm65QQtgcY9nGinN4OZ//nA6LPrzTNXwo0oD
         1olCS3Zmm7dgetaB/CL1FBAARdPYE4Ud2xcT2GExy2DJDMyKObf5ca6lMOlqfYtTmK++
         ToA1qDWpv3ji3sdxxiivLFoM3sod+nPy4RU2OgAACCfB0upKKjYJMBQiWNOUKo0pBsB+
         PoZ1JHOGPIFosRxdyL4bfxhKL1gN+GoMDpyNQvMetlgjJDv5qp0f6Ys2h0oofAoOkLBe
         c/MRjq592B78OcY09A2x37hdMBKnplnEABCXmbxyMxzCVzll/Vz+k6/FG8CrWTDvO151
         epog==
X-Gm-Message-State: ANoB5pk31Oh71ONP2nm8VAS4Xsm8/9fkK4roO2u2sQGRbd+HbzUq2jaf
        Oadgcgpn+qUKxp/7BCqPicA9DA==
X-Google-Smtp-Source: AA0mqf6bkONAJxgcou0DSMhPWfx1UdDKPf6SpVqbRBgR3aToSPxhVHiVXmce2GONDgjiznl0+Ydj7g==
X-Received: by 2002:a1c:7715:0:b0:3cf:d18d:3bfe with SMTP id t21-20020a1c7715000000b003cfd18d3bfemr1911593wmi.203.1668602015855;
        Wed, 16 Nov 2022 04:33:35 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:35 -0800 (PST)
Subject: [PATCH v5 00/10] Add MediaTek MT6357 PMIC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAHbYdGMC/33NTQqDMBAF4KuUrJsSJ8bYrnqP0kXGjDXgH4kKIt69Q5eldTW8B++bTSSKgZK4nT
 YRaQkpDD0Hcz6JqnH9i2TwnAUogEwpI7up0MbKNI/jECdpjFYllkBa14JH6BJJjK6vGp71c9ty2YQ0
 DXH9PFmAz+Ovt4BUss4sOvDglbve0a1twEiXaujEk7VFHwuaBUsKva10ZhB+CPmxkLNgPCCakgpV2i 9h3/c3/ajz7DgBAAA=
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:32:54 +0100
Message-Id: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6543; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=NshVBYuu9TdFHoEf91yvknNPpw+L+ZYKe9wp64lvKjA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNie1B6xTOBloeueoPhUeiyM2FvEnzXWytPapQme
 PGuEqP+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURSX1D/
 0fhbES4V/OF3JKAj0wIXtjekYXEENu8Ek/sh0BTttoOWTT/l+wSs3JuPLNRQSzYd6ZAYSnD3oXqmpW
 fZUBJpAwl3u62M5f2TRAclh5DFhhST0H0WxP2NMH2zY8hjEBfx+DGjSf7shTr+2Mxd+7ir10KZ8UqS
 ILGXk4OgR9QdVRUInFinKR94s4X0756dL3Ubz/9pCgRap7DGUKLKHnMYClWsu1Wp56uhelinkO7/9s
 UxA/VQb9dTz3Yss0eQ6UIFQKNkcrH4P3xLCtTMvEhBfV1V+kZl48k0LLYitK48GVhKR6RIRFhmasKm
 AdRlxx2DWiBSfkBYz3lNT1NEXamtskZq9BrLz8PjJiAWzH0AWPuo8o3jVPVI4nWqX9XDMEAhvrzI9A
 2bMYnKuN2fOgKHeyhVx7jEqeHB4iL4u/Me+DHf8yikRD+tizkfg5KBgH9uvS+S48aMi69EoRvNulNX
 cU1CgWiu3JE6WT0aecpyWwGQ3gftWGbLRKcI5s8FksefCCv1xHrVhnjTqBe3GdIH38Y4zvaS30CGXH
 I+pVlNpyn3Cs6MD449VPZaUgRyBO/gE1cu326LLNJo12+wBD0TyGVtbXBIy6pz9JNOmCO5aPofdWLq
 ihF2gc+fFwJci1VnHrXUG6a1BQZ8UYH2mRszp0+RqcApuhopFKGyzgkl/EzQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
- Change node names for mt8173 and mt6358 SoC to be consistent with
  pwrap documentation.
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
      dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
      dt-bindings: soc: mediatek: convert pwrap documentation
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
 .../regulator/mediatek,mt6357-regulator.yaml       | 293 +++++++++++++
 .../bindings/rtc/mediatek,mt6397-rtc.yaml          |  44 ++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  31 --
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 145 +++++++
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 ----
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |   6 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   2 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |  17 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6357-regulator.c               | 454 +++++++++++++++++++++
 include/linux/regulator/mt6357-regulator.h         |  51 +++
 17 files changed, 1128 insertions(+), 114 deletions(-)
---
base-commit: e7f535c0775b896befb4f6765c02bc065fd26156
change-id: 20221005-mt6357-support-55308b82e33f

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
