Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98016710789
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjEYIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjEYIed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5441BD
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:33:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so1763275f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003633; x=1687595633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzLBA0ulSqogErFIVu+8bfox6+q1wNs8YMgbb2gj9O8=;
        b=euIoeFVX5DZLsdnUDVfa0q+ZMfRpA1gsEdhmNyg2lE1Vbl6gvtHaP2d3siI2idJYqt
         OQ7gehXukara5AqefXCbhvvEYpTo7QjwT+Yx2XoRwE7ZvfexW4SBalgLdTMc/KlpBWda
         7qM/7rVcRKh1S8yNKxy9ggaLPUw0ok3k1NJPCEp3OeAWDs/Z2+nqeVslwZFX7Vd6VFWI
         OkeSi3/kiyp0DYUw/84t+4pKEIhb5m4IYFJ0dS5Yv5zP0EEPnBX9iVnQcPM1BU9+8smB
         fXW3+HU9VWS2nFDG6CROMOnUSRS14iGQ/5PmItbTvnaphmO2ivg2rqRmAIHs6xKsTGqR
         IBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003633; x=1687595633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzLBA0ulSqogErFIVu+8bfox6+q1wNs8YMgbb2gj9O8=;
        b=OKL9dJvFibd32HWHbGG5UPos1OlkSRzGfWPwrSSNc/0755ws7WUH/WkNJrRMZadfQ0
         BtWXCrIJg0f/IKWFP1+izcJ0yXX8/bA8kx6npMP7gS4qsMBg7xQpcb89XIFsYnVohcaA
         /1D7fT4CPPhjOMoXTQEyNNSybgnEdRKF/KCDY/KBc97gXE1QxyFn/kDXgU6O5SxjceCu
         4u4RBiVDh+X1xmajkVgHA/gwgExfxTqFd7O4qYNjVDYofAiOTlpJ0vwScjQyvh6jb+/z
         /y8R82v6CRGIVhnUlZ7ftUT7I+8w2ouRmlHMApIRvCYHdPnX0NQ9PPRXzwok0qR2mC6A
         JDSw==
X-Gm-Message-State: AC+VfDyymB7jh/++w8auGnA+0Ni+EQUAEz91MunOWz2/paVHaJL3gy9D
        4aL/gLumwmxTcNTvLPuqCwhYiyQmz1EE8Z1MHws=
X-Google-Smtp-Source: ACHHUZ6Xhx++SlPUZnWwmSO9AC8dvDTg1MvWXGRjxNLtDYYDcMIJA28lqZFQ8FJa7issgyM1OFA/lA==
X-Received: by 2002:adf:e511:0:b0:306:3899:ccbf with SMTP id j17-20020adfe511000000b003063899ccbfmr1962415wrm.14.1685003632957;
        Thu, 25 May 2023 01:33:52 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:33:52 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v8 00/10] Improve the MT8365 SoC and EVK board support
Date:   Thu, 25 May 2023 10:33:09 +0200
Message-Id: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUdb2QC/4XOTWrEMAwF4KsMXtdFtuOfdNV7lC5sWW5Mp8lgz
 wSGIXev2mUJzUo8wfukh+jUKnXxcnqIRmvtdZk5hKeTwCnOHyRr5iw0aAMajKT1U6Yltiz77XJ
 Z2lVmm3wMZqTsk+Beip1kanHGiZvz7Xzm5VT7dWn33zur4vH2H7kqCRIcGO3BDirb1xTv55oaP
 ePyJd4ZXPUhohlxhB5zUoBYdhBziJifTwAMBSCAce+T4RAZGLFYCjkXTUDYQewhYhlRIRhUaQA
 b8w7iDhHHSMguKSzkix53EH+IeEbGgCmXiM46+oNs2/YNGR4juVgCAAA=
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
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3600; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=oXFkwv30PQiHsvUw3Gm2oqLRkH85H2byPieMXIgeFvk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1vv7eqXrKOVpAFj/UFbNNFu/nubQWEv7U+NGns
 uwmwNvWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURTsKEA
 CbqPknaqksOYG6ClJshktGlpf9J1qcgkGD5llfrDqziweMOEnFodz+wXwa4QUuJiASHuiqs2zEFNmd
 la62LhBvIeZNMhV+ukmcHdA123FoYitY8PvC3rddBNsXYJIusDYSpazahXWWDslFQoaDzmuBjOpAKZ
 M/uPpkY4qrY9oLC4/Ob195jkwuIKrUUFIO2TndPMzZnROgDu+ryV7S3TN+nNo/viW5twNJTurDsleQ
 jGeUL3PotyEKIvj0Wm++e1/QSezCR8VQSDq+4trvIzW0c7MQV4HfsFAnziCJYA6N05x5YENWtCZHdG
 4pGSBz7cyZkhVJzUeUn9IwBOPVfk1A2SA55JgzQpQlenqKEg0GkMW1O32lVouevHjsF6q3ZfqL4dDW
 mdDTTTtcNlne3xzcJx7DpZTmoPc6UHUXXb8Df80cytbmpiFjOdIWHfctrr5vYG3eCSJXlWr0q4rA8y
 VL4VeVrC4JYyCe6kww8sy0F09tcdC5zTHtPO8QxgbyZNoQt7eAFhN9yjLNqrmbTCk8bNjfv9UQBtAE
 2QrB6xnDj1NSPLLcysgq9Smf99qgMxNHU9e08ahs2W6IyKWV/wD1hP5BEHGiFhRarpW77ATHV1n+Hk
 6inCWaIQ0OuuuACrUlhj4DnqQFUNn/bIGz5GhTyVEQX4ElgDUy/0NOJcdUiw==
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
Changes in v8:
- Change vqmmc-supply of mmc1 node.
- Remove all always-on regulators from the board devicetree.
- Link to v7: https://lore.kernel.org/r/20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com

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

 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 235 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 142 +++++++++++++++++
 arch/arm64/configs/defconfig                |   2 +
 3 files changed, 379 insertions(+)
---
base-commit: d2b7e0f7ff8e0b21e4c8d0ae6dfa38786fe44b35
change-id: 20230203-evk-board-support-d5b7a839ed7b

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

