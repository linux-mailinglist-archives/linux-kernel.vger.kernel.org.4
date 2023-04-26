Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789E46EF2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbjDZKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbjDZKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0919F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so146848405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506176; x=1685098176;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXqpOIhkzwPRXmqDg52P5Pe8HaS6m4zR8JovEcwwVoo=;
        b=ZDpQ1hhLsbi7CS535pqYF3gnHiml9s00kPPxdCtw+mPgIgeqReJQSGyKQ6lNzHebJ1
         WuWIymVAaKiRUlhMzYIxLZcOh0FqvOEvPUs2zCSUJMTEkyYtjfq3mN5DWvjS0JpLV/FI
         IPzruLvzHylyUBUnIhB5l+7gxBT2QDnJgHCoJfUPfcI86Yw+fuFnJ51aS/VCl9fwk1NH
         OyGVjrEoZ80VLJByUaU3+1HDdgnXT3tBQhoiMiYj00sK5TObslC+cj7zbPapE4lOCJgN
         LDFIiyvYeWG3bD5N01l+mn7VRc3Vk3BrJYh/lP+VVbCdftZCCSzRI973roq7c8/SaQ+Q
         LdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506176; x=1685098176;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXqpOIhkzwPRXmqDg52P5Pe8HaS6m4zR8JovEcwwVoo=;
        b=Cs4QunmD7MGcfAWj1a+VADvzM1tv6ue36i/cTXc1Ictv1Mtal8wj8BGyaLf0sQgtBe
         CEgsArsJUJIAqwDsvICojHr9FNTO4UNfHDOu3uhS5zMsvAzUIU6vNPnwtaHxBi0UeDCd
         NxpikNsXMimONsPLbwCxFdmyfIWgTCrfr26YKgNssJoyTfAQxibmzy+vTQ2nUkoiB31p
         dzlBcm2eM+FMzvdpxdCP6kr/No8mJmIRlxD9gN/C/EyG3oKr3ho3fscOsGUfNw/otnHA
         P7D2UYyQ8g0VqHEJMdKSSdlx6pOP3JK0dT6jWCCNnrcemFg8XCOOlohCaKsLLBC3p1Z5
         Zftg==
X-Gm-Message-State: AC+VfDyoyLIKw6sfPHVw2yolu0ppj+Zq1qBLLcfcUD5FeN8ARZyC1D+M
        K+r0oubPVi1cl2nYgPy/DeeoNw==
X-Google-Smtp-Source: ACHHUZ4enVDWy52+KhmMnqjQXLUOxop4/WasL/L+Qo7S3eViLzsO6QqIXDK2o9bhjpKEDPNf/LAbsw==
X-Received: by 2002:a05:600c:474e:b0:3f1:7510:62e8 with SMTP id w14-20020a05600c474e00b003f1751062e8mr1486385wmo.3.1682506176383;
        Wed, 26 Apr 2023 03:49:36 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:35 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v6 00/12] Improve the MT8365 SoC and EVK board support
Date:   Wed, 26 Apr 2023 12:49:00 +0200
Message-Id: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwBSWQC/4XOwW7DIAwG4FepOI/JQCB0p73HtAMYZ0HLQgUtU
 lXl3eftOEXLyfot/Z/9EI1qpiZeTg9RqeeWy8rBPZ0EzmH9IJkTZ6FBG9BgJPVPGUuoSbbb5VL
 qVSYbx+DNmdIYBfdiaCRjDSvO3Fxvy8LLObdrqfffO13xePuP7EqCBAdGj2AHlexrDPclx0rPW
 L7EO4NdHyKaEUc4YooKEKcdxBwi5ucTAEMeCOC898lwiAyMWJwmci4Yj7CD2EPEMqK8N6jiADa
 kP8i2bd91ymqSzgEAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3cpMqoAIbEB/10TKO6xL48InNMRQARuO5SZVvhSL3Js=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG+qCzT9ucovl/oxsyKVndun3w9oEpHSRG/jODy
 9ZtYqhSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvgAKCRArRkmdfjHURT+/EA
 DASggB/c5arZeYIIB3jJA4rPhLRODAMysf2Ftpmx9t9b1WYkM2prj3jAEzhuAUTuFEEqN5VdGO2L4c
 w5hwiH6skyFQEy5yBmX1GU3jwhCkCDuQ90r1p45Sn6hysKJqJcRWNNOyYiWCo6TiPK+LQeMmEKCRdo
 Y4QLoQgiMZASwjkmRH4pJphax5nyNAP7Re1Rq2sIWaTsCGNxkwBQtBUwMhENDaa4KnT77DiwVUtiVb
 x5zXBB848IUgavMF+vh20pA7pi6xtJW8XDK3BsYZNSGKB5FDi9vFD/ndoZNBPRZ4iCSbkuofRtAtie
 VBrVKNncGrpvgTPtHYekr/R5/QJAfVElZZ6Z4A3zCGTlCjGkCwGTUB4B4jjXSYhAOHmfR225ITo+aL
 BDi8ewAB2f3YPkr4e2QqUdoC5YZXNt3jtwenqaGmFSAMlOPTA82ZjZI+hX1cNm6LmFsCfP4TYFojBy
 mPj/Uf4E10FS9yp9lgN8OSTo15oZ5xB6Oq6E1dRJh9LKRuSSxTFNvokNFZl01H6KSWt3QuJcWB1QjT
 qaZNtCDEv2v97SWZTy37nJa5Q881qVRRkqIuah/ZWO2qPfcMoRvlWknn4Kl60XaUYUC4jlTbIWAMtt
 xvD1qiOdrSyajdqzbA/4e8iPOuOr8kJSTRgfBJJA56KrdPzgDfcaK9st8NBg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
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
Changes in v6:
- Add commit message for the arm64 defconfig changes
- Fix the mail list
- Link to v5: https://lore.kernel.org/r/20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com

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
      arm64: dts: mediatek: add mt6357 PMIC support for mt8365-evk
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
 arch/arm64/configs/defconfig                       |   2 +
 4 files changed, 394 insertions(+)
---
base-commit: 4f2a499a344b36ebb325e610265452ea88541116
change-id: 20230203-evk-board-support-d5b7a839ed7b

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

