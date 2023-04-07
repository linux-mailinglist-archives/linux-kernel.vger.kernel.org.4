Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939B6DACE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjDGM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjDGM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426C76BB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j11so2574878wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872380; x=1683464380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kq3srRZu0LgAYU4VKXs4/x4Tf8N0jKR40LSgweSSzt4=;
        b=J8F4OlPAWoGfnnTQnhWuwZuquQmDiCe49xZdCmHOE9h9usVYq1yauUBTCmjPfjYB3Z
         d1ldncRdPQsHKcPd3Ck9RWGT0GlBFFdSHOiou1N+N7qh/Q4JLZcd+NJs89fOTxmC+RDG
         dWlpah3w/1qSsT1vjfjzsg7h/9joVEIY5uUuTTvgKKRh3L3AKy+CTRT4Wwi+HJd5gtL8
         lyeNHXT+6g55BsO/f4Ml8TMByzqWkq+jG4Z8JlJ0ZjV4EiIO0p3O49KX+EDIUrtvsHqY
         SXtG8I1RRkLh6igGelUg/FvhN9t5iiJ5R/4ylFlO1IISQqoG4kP1xHOlT8U1e8eGF95X
         Lntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872380; x=1683464380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq3srRZu0LgAYU4VKXs4/x4Tf8N0jKR40LSgweSSzt4=;
        b=j8PpYkJnga5p03B8cEa+Nrby7bR4EJGQTbWtL8EwfA2xF30+fhc4/8gXfFgiwhlucT
         d2jADq1U+vQ47jugMYhCoyBQ4+dlYiatBaPW9DTSnS1imXic4lOQS09e0UnS2lWkCjOS
         w8XlFKCd13BYbwTukWsixNLaEKBW0K/hb+yiKhu+rxw+nolRgUEyPz+WlihvmFOphNb7
         C551k250azaLVWP3ZRR3wrJnSxVpssBU6rwysnzRAbJTuFcqVk/ls0/sGNDMYzadSgV9
         Lg6e9EkueGfdwyxbWjtxZiepzBhs3YjVJaRtq7+qx5ClQLqfxIAkd4sLdRc08XTCsYI3
         6vww==
X-Gm-Message-State: AAQBX9dJgN3iOZ6Ew40055wCy5Ira5FiyMtQxSQh7dUyEzorBmRlF/rN
        hXMNLHXzNOrIu2biEwac1tzjtg==
X-Google-Smtp-Source: AKy350aG6CSkeDb0CB1KwfgXuanzjSo9RbQa9ivfIsXGFklPxG3zSB10aYjFNeGA5ApfzmlpCuFLOA==
X-Received: by 2002:adf:fd46:0:b0:2ef:466b:8f27 with SMTP id h6-20020adffd46000000b002ef466b8f27mr1192967wrs.18.1680872380324;
        Fri, 07 Apr 2023 05:59:40 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:39 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v5 00/12] Improve the MT8365 SoC and EVK board support
Date:   Fri, 07 Apr 2023 14:59:19 +0200
Message-Id: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcTMGQC/4XOwQrCMAwG4FeRnq1k7bpNT76HeGjTzBXnKq0WR
 PbuRo8i7hT+wP8lT5EpBcpit3qKRCXkECcOZr0SONjpRDJ4zkKB0qBASypn6aJNXub79RrTTXr
 jWtvpLfnWCe45m0m6ZCccuDndx5GXQ8i3mB6fO6XicfhHlkqChAa0asHUlTd7Zx9jcIk2GC/iy
 GBRi4hipCFs0bsKEPsfiF5E9PsTAE0dEMD21yf1IlIzYrDvqWms7hC+kHmeX37qXbeJAQAA
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4029; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=EIPehOyKI/NzIl5wvVSNCdB4HdlMEQRiPIApPxEycOU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO54ToqEDvwXUh0RFYVMxOGueAOJNRyVbQ7vcCE
 qhK+wO2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATuQAKCRArRkmdfjHURSmNEA
 C3HhBnDWjrngdrYcbYlvOmYXCKSvy4CHP8QLWSRKvPof7NB9L0STInkkeKaHP10FN6j9ZgLhzHyy1F
 dBRxXLMuzG4TenqY1tCQpkAAil4QJ0OU1EGpt7ViKNW18bksXV4gaGh5DeTqRr/94H6eS9gZvgoYwi
 1QTp2TYann1sMzDiKx499sjbUp8nyXsjspPanivSsHqeMW20OOIbmXbSW9RifyCdV+5xIat9T9vaiJ
 i8Rssc4dITvMoEGXXlWDpBEwqU1VLK2S4xudk8m2+6SyIkmcJBLYBfu7qNi/j/vkKv9pnqtUmXBvZ/
 QaYEiULr52hCG5Yt89scfq65cWfLlZWFHFV4mUBI2vUDR+wIdLk22eb8KrICwCSQktY9ZTmLYkJUpk
 N0hWlbLuoousXycLbBpwfs7IwDt77a9LyarQk/cVy/83Ea0HaVf6Mybi6hzq9RVyVIjSDo+PX7L/L0
 mgyVNNJP97EPjXqdkdVb5GyQshZ34u0JrFXPZRibNAbuCHmA17kg0FNAG8g4LIAgpqBDWifa4zFaGj
 lw9XU8HF/4m5lclzPpjs++2moDjtl0vYQbOJuLJm+L00OvB/erfXKu5tBoM2W4/a6wgvzNEsirOwxG
 ejtsBivDTmxWCIzKnyV3b4sns+WpB2/EdykFRrp+Jq5lz+dQsrURQ8a0oM+g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits are based on the Fabien Parent <fparent@baylibre.com> work.

The purpose of this series is to add the following HWs / IPs support for
the mt8365-evk board:
- Watchdog
- Power Management Integrated Circuit "PMIC" wrapper
- MT6357 PMIC
- MultiMediaCard "MMC" & Secure Digital "SD" controller
- USB controller
- Ethernet MAC controller

Add CPU Freq & IDLE support for this board.

This series depends to anothers which add support for MT8365 EVK board
[1], add the MT8365 I2C support [2] (both are currently applied) and
finally the pinctrl binding cleanup [3].

=== Build:

To test this serie, cherry-pick patches from the dependent series ([1],[2],[3])
and the applied patches from this serie (documented in the "Changes" below).
Be carefull, the pinctrl serie [3] is rebased to linusw/linux-pinctrl,
cherry-pick will not be straightforward.
Finally, cherry-pick this serie.

You can also take my branch [4] which have all the needed patches
retrieved from the instructions above.

Use the arm64 defconfig to make the build.

Regards,
Alex

[1]: https://lore.kernel.org/all/20230309213501.794764-1-bero@baylibre.com/
[2]: https://lore.kernel.org/all/20221122-mt8365-i2c-support-v6-0-e1009c8afd53@baylibre.com/
[3]: https://lore.kernel.org/all/20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com/
[4]: https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/amergnat/i350-evk-board-support

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v5:
- Add patches to build the MT6357 regulator driver and MTK PMIC keys by default
- Remove "dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength property"
  patch from this serie and add it to the pinctrl serie [3]
- Link to v4: https://lore.kernel.org/r/20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com

Changes in v4:
- Remove v3 applied patch from the serie:
  - arm64: dts: mediatek: add ethernet support for mt8365 SoC
  - arm64: dts: mediatek: add mmc support for mt8365 SoC
  - arm64: dts: mediatek: add mt6357 device-tree
  - arm64: dts: mediatek: add pwrap support to mt8365 SoC
  - arm64: dts: mediatek: Increase the size BL31 reserved memory
- Drop "arm64: dts: mediatek: fix systimer properties" which is done [1]
- Fix style, typo and re-order properties.
- Use interrupts-extended for the PMIC node.
- Link to v3: https://lore.kernel.org/r/20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com

Changes in v3:
- Remove v2 applied patch from the serie:
  - dt-bindings: mmc: mediatek,mtk-sd: add mt8365
- Add trailers and simply resend.
- Link to v2: https://lore.kernel.org/r/20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com

---
Alexandre Mergnat (10):
      arm64: defconfig: enable MT6357 regulator
      arm64: defconfig: enable Mediatek PMIC key
      dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365
      arm64: dts: mediatek: add watchdog support for mt8365 SoC
      arm64: dts: mediatek: add mt6357 PMIC support for  mt8365-evk
      arm64: dts: mediatek: add mmc support for mt8365-evk
      arm64: dts: mediatek: add usb controller support for mt8365-evk
      arm64: dts: mediatek: add ethernet support for mt8365-evk
      arm64: dts: mediatek: add OPP support for mt8365 SoC
      arm64: dts: mediatek: add cpufreq support for mt8365-evk

Amjad Ouled-Ameur (1):
      arm64: dts: mediatek: Add CPU Idle support

Fabien Parent (1):
      arm64: dts: mediatek: set vmc regulator as always on

 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        | 249 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 142 ++++++++++++
 arch/arm64/configs/defconfig                       |   3 +
 4 files changed, 395 insertions(+)
---
base-commit: 4f2a499a344b36ebb325e610265452ea88541116
change-id: 20230203-evk-board-support-d5b7a839ed7b

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

