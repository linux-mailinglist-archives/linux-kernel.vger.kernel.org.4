Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60E6D2737
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjCaRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCaRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:55:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504C10265
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so14412280wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsdpYjF3syBHZgFNYzSRIs96odbvYEi5NYnPkaWji2s=;
        b=D7fMYdzDV7g7vU0VtE5FK+/I/b67QflgYkVGo3+z6uejVQqKRbhrzkGl6wBwAIaCFe
         mjoOxShki3XXGhnp1HrwTqOqZ4VqJ693r7oBiAmdCyICnSE010hxHLZEQi/32FLdrre+
         ZfFroHJa2PJ8/91y4Z96ESDqaDucBjOGLDhT7lhr9CNlbr5to9fOfanR/NOnSSXtr2AN
         XZN9REigG7TAw+usWXRan3gMo5Nv4+qeqc7zz7FLe7/UPKXQ1OsSZHdWmi+fLiBoKktp
         c201ih/2dP1lRwQC3ePlipZN52062wclF32GY1UOJzDGLU/VjNVqfC5ywUrdJzhfFg+E
         BWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsdpYjF3syBHZgFNYzSRIs96odbvYEi5NYnPkaWji2s=;
        b=yL3PpJtAXfJMMcC7JhhO6/rY/uSHpWUrL+xVNgPAQWjH9p5o0F2P11gydY9yrPq6M9
         3nj/b0+V4M7EDjQViI1Xj/1sKuv7RUoJwYj2yzVV1ikEkFIYf/e5HkbgcGdPq1HPo9nY
         FnM1WfjtDDS7dcy3lF8nyEhoGbRgz5K8vEVv+tqs9viSZpDC7tRZSiyg+OR3w9zDIzjK
         ick90kOJJ82dBclV1AYEoyAfD8lZOX1l+H1qSry0Y5P13SH00PhHwL8xrYMA1kB3HuTC
         BvV7nGh+fF+7Bx/EOEhA1G7ribisNY0j+kMGbjgcI+0CecvPz4g+QQS0SbPKzT7GP1EH
         acTg==
X-Gm-Message-State: AAQBX9f736qnmEtW0pmPdOvkSNlZsmIXW70Hq+9xnLgvuTBqWPjkCyOH
        Rb6QkR3DAmjkkuFa87z9/GlUEg==
X-Google-Smtp-Source: AKy350addcoFAOVXSbc4akoysm1SuwS/0dymFAe3JQRHQ2q6/IjRuVXoPj9fXXz5CNR8FEJY3RL4Dg==
X-Received: by 2002:a1c:4b04:0:b0:3ed:c84c:7efe with SMTP id y4-20020a1c4b04000000b003edc84c7efemr7957386wma.7.1680285333533;
        Fri, 31 Mar 2023 10:55:33 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:32 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
Date:   Fri, 31 Mar 2023 19:54:44 +0200
Message-Id: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQeJ2QC/4XOTQ6CMBAF4KuQrq0ZWqDgynsYF/0ZpRFb0kITQ
 ri71aUxspq8Sd43s5KIwWIkp2IlAZON1rscqkNBdC/dHak1ORMGjAMDTjE9qPIyGBrncfRhoqZ
 WQra8QyMUyT0lI1IVpNN9brp5GPKyt3HyYfncSWUel39kKilQaIAzAXVVmvqs5DJYFfCo/ZNcM
 5jYLsIy0qAW2qgStL79QPguwt+fAHBsAQG670+2bXsBCfE25UQBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=g6QcyfmR6WQISod8SsOAV0fvqJ4GAS81PN4pXjBo1YI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6TMUNWgOq1M9kKUf8Hyk+HBOdRhDM9kCQ8bvha
 bettplqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcekwAKCRArRkmdfjHURVMjD/
 sEAJOXUkkF49/VjifC4cfaa2kBphhLpZPFyZy+n/avDNRgE0iHhywdwOmcPqZoob/ZC+ULKnr1iYUB
 jpeARQaaZzTHRbDD51JpBrsxftK5O/c8O227dK9uOysUNhW5W1ngRT/WYjPHcrsiAq0vBKnzKiz1R0
 KEynockGlTutS1AuGmD9ITjENf10wKwmw1jjX64D6wtrjqpYcDjvNlcXnTe9q46n6Uu0tr5m2MZnI8
 PpDHL6HvtelgbCbq0aFu51UtSUjS3Z+ULBlcVUgZGUk/G3l8JYd281XbtWtmOjd1jSwo+KcW9QbtAz
 AU0Ac7bJeZl2pk/rhm4HOEd+kZwtwxwKjdG6d2OIGi73PWTaX6q/QbZiTyIOSNjx0JDsY0GvQhgGwO
 NL0DJ1/RZAo2eJ/KCQ/JJssDycLH419+aY9YV+jI7mr3MUX8wnx3gOWzyfEYnKuilohS8BVB/WlUyE
 aLQ9QEz5YrMhCgCOJNmkFYI3qMO1phScvcQxFquHtQp01bP/Jhy69kKp1PyzO3+2qJ1Gd/MNhOCOey
 6Xbat62XXilnLPLqOpHdWFcs/Gi9a132g0wSLG3ylrVEQLUIst/WeJG6fr8X6zgusgsd9aA/kX/w8/
 ZiHx2EevzYolV+Hp0a2u1fyFnf0ZqIXSQAOOWwci5AB6/4szhTi3CECHgI6g==
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
[1] and the MT8365 I2C support [2]. Both are currently applied.

The DTB check may failed/warn about pinctrl binding, but it should be
fixed thanks to this serie [3]

Regards,
Alex

[1]: https://lore.kernel.org/all/20230309213501.794764-1-bero@baylibre.com/
[2]: https://lore.kernel.org/all/20221122-mt8365-i2c-support-v6-0-e1009c8afd53@baylibre.com/
[3]: https://lore.kernel.org/all/20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
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
Alexandre Mergnat (9):
      dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365
      dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength property
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

 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  |   3 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        | 249 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 142 ++++++++++++
 4 files changed, 395 insertions(+)
---
base-commit: 4f2a499a344b36ebb325e610265452ea88541116
change-id: 20230203-evk-board-support-d5b7a839ed7b

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

