Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E66FF73E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjEKQaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbjEKQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9BA1B1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso16037471a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822599; x=1686414599;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOXlr6SRXoJsbJvp/TMrj0DD75/K1iQobJvY87EAMHs=;
        b=Xz/RQq5wclbup0G36yLQE1t+FWgGMwi+IVZV0t1Zs5ts4xbiRGyHcFuX+XfRbn22tr
         ZmZ/lQt2Z0gm9d3V0DRHip86YCZkpwg9Y6kh5UC+nlfIfIj/XfP4IVHw71tqZSCDP2jz
         oAHkEsnKNVuzo8WidaW8/NG0kFo5FS/WSYaYxlUEo1Gl8pNPrEAsQu+pL6/h2Y2E5Ws7
         6zNEDraErYdVpyUb/03ljHWhXL4GN2v+iaL0i6JdnT4u+ZoI2L9lX5Q+k4+wllHRYzD+
         pGxDKYxidmWM+vTEDvoIhmFuBH4ATFEbq2EPPbv9kQikb5B6mw5v571lXYM22fwhpVS/
         FORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822599; x=1686414599;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOXlr6SRXoJsbJvp/TMrj0DD75/K1iQobJvY87EAMHs=;
        b=PBVmVGl8tTyIHTn7wNfkT77R6Tvcf2z32V5vezTWdT7wncCsQP5siGW43fvklOrS2x
         CQfG6whdCK6q6cvHpWqllIG9B2x+KAsI20DdNNnhEQJw0QoEGHvuT9wxH/SREik8pUUr
         sFN2aX3e7GNtfBeZqusMEZNTxwBCM34T4eDM6ml5/qjZOkt1jYZDAckRVxaQL2SvHaov
         gbl7Rkoer+8UsZAnZvLtE7VJD8OhHC5HucC2lZUvEb0qwPeGJ6Wf/RmZAHwpm+S+ocpU
         4QjfxY9O02bbcbfw//FYjaYPrt9EUo9aUxuFxlbKAjHxduSHnxoKedBYCa7uwygGtDk+
         s6nQ==
X-Gm-Message-State: AC+VfDwuPiiSYwCvL5Ny58daH1ZJPO0P9IxwFSvGUWFQu75VYemFjyGh
        n3KJCv/kPzp2nw/xKFsuhjqPvWwVJslKObZIh2c=
X-Google-Smtp-Source: ACHHUZ6WIzYhFgAFcsIsAcPM0vdI5AbfvQ1LOlAMpgYv5xZxQi7Bl3oSz3I3YSBq65xkCaJ7+GK74Q==
X-Received: by 2002:a17:907:d16:b0:966:391b:5b3e with SMTP id gn22-20020a1709070d1600b00966391b5b3emr17294069ejc.55.1683822598626;
        Thu, 11 May 2023 09:29:58 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:29:58 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 00/11] Improve the MT8365 SoC and EVK board support
Date:   Thu, 11 May 2023 18:29:20 +0200
Message-Id: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAXXWQC/4XOz2rDMAwG8FcpPs9DtuM/2WnvMXawZWUxy5Jit
 4FS8u5VdxxhOYlP8P2ku2hUCzXxdrqLSmtpZZk5+JeTwDHOXyRL5iw0aAMajKT1W6Yl1izb9Xx
 e6kVmm3wMpqfsk+Beio1kqnHGkZvzdZp4OZZ2Wert986qeHz8R65KggQHRnuwncr2PcXbVFKlV
 1x+xCeDqz5ENCOO0GNOChCHHcQcIub5CYChAATQ733SHSIdIxaHgZyLJiDsIPYQsYyoEAyq1IG
 NeQdxh4hjJGSXFA7kB93/QbZtewBb2rYjEwIAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=imRxbapmEJ9qqaKKfWX9LcSFQADLjeGPq13gZioNQ48=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgEmkZ1Wmx5aUfovH7JTgKGB3ghz97Nbp55wI3y
 6SqT4tKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBAAKCRArRkmdfjHURRDAD/
 4sIVRNJSV4mAKj9UxAok2bIneeEGeKLSxt8crFpOBUlc0Dbt3R8w52Ipgeeu3Xq1/VqHNb/P5zbcB6
 o6AJf/sLjY/lnJxt0izgc4nf/kQDPf2mhxgrKdQf+mlTylU8WEsRHSyWJJNf9xOs56MFdSk5n4sGdA
 Jvrj5X4UPFKVRZejL/zO2OuoH1aTaxz+AbnccTPLVVFNmMosBzUgEQ+iT0oo/XX0hWoBpl/AOBsNY1
 2GhbURO2unJivEGpG0kFbigpQsxDw/nxJCs9NRkkUkzJMNrrPm6DT/C7ckGEK+RrEcMSLe6FdHCaKs
 x63F8XH1xsVyKq1hMsvQLO6dClL2jdBTErLE9Kmb13IJUhhazE5eTmgk+FCDw73ILM3+vSmOo7o6uX
 P5YGgPnZVCUF76T1z6JkWkpzOtxEmpDJ5pWe3TfYRbLoL179cGFYr/IxFShJW6gBlfYohrZPejk0PA
 64UHyRwHB+EgWuXlrjWGkdKiZtsLkBShppniZdKsbYvw1ZPkZHnoOLKe6DZqmsqctIfrwxue6u6F7z
 kORg3oa2UTu13Ozdk1XRxCujUxpK4ntnb3z4fZRWlMUmBJ6/W1EyDNg6v9ATZbJC3JbJlc4xhav6JT
 SAjTPAdS0W3u2xxVPkWcC1t9xEYnLwhu3Cv+QjQIdp2aBUyzvX8wmTu/Gn2g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

All previous dependancies are merged and released into the v6.4-rc1.

=== Build:

To test this serie, cherry-pick this serie, and build it using the arm64
defconfig.

Regards,
Alex

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v7:
- Rebase to the kernel v6.4-rc1.
- Remove "dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365" because
  it was applied.
- Link to v6: https://lore.kernel.org/r/20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com

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
Alexandre Mergnat (9):
      arm64: defconfig: enable MT6357 regulator
      arm64: defconfig: enable Mediatek PMIC key
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

 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 249 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 142 ++++++++++++++++
 arch/arm64/configs/defconfig                |   2 +
 3 files changed, 393 insertions(+)
---
base-commit: d2b7e0f7ff8e0b21e4c8d0ae6dfa38786fe44b35
change-id: 20230203-evk-board-support-d5b7a839ed7b

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

