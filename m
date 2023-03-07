Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADB6ADE58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCGMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCGMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:13 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E2B574F8;
        Tue,  7 Mar 2023 04:10:11 -0800 (PST)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id B816326F885;
        Tue,  7 Mar 2023 13:10:09 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Subject: [PATCH v3 00/15] Device trees for Apple M2 (t8112) based devices
Date:   Tue, 07 Mar 2023 13:10:06 +0100
Message-Id: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4pB2QC/32OQQ7CIBBFr2JYOwaGWqkr72FcUJhaXFADSDRN7
 y50YeJCN5O8ybz/Z2aRgqPIjpuZBcouuskXkNsNM6P2VwJnCzPkKHkZoKMeHSQlBIJN0A5GKW6
 UsQfJitTrSNAH7c1YNc452BJrKAWij1Yv74EG91yrz5fCo4tpCq/1kyzq9mdpFsDB9PumQSsMY
 ne6ae/1Y+cpsZqV8b+PxS8athqVtB1++cuyvAHlR8OCFwEAAA==
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4768; i=j@jannau.net;
 h=from:subject:message-id; bh=zZjy+LGQTCEgF66RbhVdSwq/T6rF7frY2iZarHHX2zo=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhR2zfkHhW5vWKNbnP+Soa7uv+PRuJuVWpfbg7Vkv11QM
 Tnw/dScjlIWBjEOBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABM5mczwz9jC9K288Kba5Wf2
 CZqel3IW1H+msOe8jnCd8JPONcss7Rn+B7v/66rWC3w6d6XWnwdCur/KtYKy3ltlGMmoRxqIr8p
 kAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains dt-bindings updates and device trees for Apple
silicon devices based on the M2 SoC (t8112).

Device tree validation depends on the dart-t8110 bindings queued in
the iommu tree for 6.3 [1], PMU updates [2] and support for
"local-mac-address" for brcm,bcm4329-fmac based devices [3]. The latter
fixes validation errors for the existing M1 and M1 Pro/Max/Ultra device
trees.

The device trees are tested with the downstream Asahi Linux kernel and
on top of v6.2-rc5. The hardware is of limited use with the upstream
kernel. The notebooks miss keyboard/trackpad drivers and usb support.
The Mac mini does not yet have a boot framebuffer and lacks usb support
as well.

1: https://lore.kernel.org/linux-iommu/20230113105029.26654-1-marcan@marcan.st/
2: https://lore.kernel.org/linux-devicetree/20230214-apple_m2_pmu-v1-1-9c9213ab9b63@jannau.net/
3: https://lore.kernel.org/linux-devicetree/20230203-dt-bindings-network-class-v2-2-499686795073@jannau.net/

The dt-binding changes in this series are documentation only. All
drivers are compatible with the HW on the M2 SoC and are probed based
on generic compatibles. The t8112 specific compatibles are added to
address t8112 specific quirks in the case they become required.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v3:
- drops already picked up "dt-bindings: sound: apple,mca: Add
  t8112-mca compatible"
- updates commit message of "arm64: dts: apple: t8112: Initial t8112
  (M2) device trees" to reflect the supported hardware of M2 devices
- fixes placement of 'if' block in apple,aic2.yaml
- collects 'Acked-by:'/'Reviewed-by:' tags 
- Link to v2: https://lore.kernel.org/r/20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net

Changes in v2:
- collect acked/reviewed-by: tags
- disable unused PCIe ports instead of deleting them
- fixes based on review feedback for "apple,aic2" and "apple,sart" 
- dropped "arm-pmu: Add PMU compatible strings for Apple M2 cores"
  (submitted separately)
- Link to v1: https://lore.kernel.org/r/20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net

---
Hector Martin (2):
      dt-bindings: power: apple,pmgr-pwrstate: Add t8112 compatible
      arm64: dts: apple: t8112: Initial t8112 (M2) device trees

Janne Grunau (13):
      dt-bindings: arm: apple: apple,pmgr: Add t8112-pmgr compatible
      dt-bindings: watchdog: apple,wdt: Add t8112-wdt compatible
      dt-bindings: arm: cpus: Add apple,avalanche & blizzard compatibles
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t8112-aic compatible
      dt-bindings: iommu: apple,sart: Add apple,t8112-sart compatible string
      dt-bindings: mailbox: apple,mailbox: Add t8112 compatibles
      dt-bindings: nvme: apple: Add apple,t8112-nvme-ans2 compatible string
      dt-bindings: pci: apple,pcie: Add t8112 support
      dt-bindings: pinctrl: apple,pinctrl: Add apple,t8112-pinctrl compatible
      dt-bindings: i2c: apple,i2c: Add apple,t8112-i2c compatible
      dt-bindings: clock: apple,nco: Add t8112-nco compatible
      dt-bindings: dma: apple,admac: Add t8112-admac compatible
      dt-bindings: arm: apple: Add t8112 j413/j473/j493 compatibles

 Documentation/devicetree/bindings/arm/apple.yaml   |   15 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/clock/apple,nco.yaml       |    1 +
 .../devicetree/bindings/dma/apple,admac.yaml       |    1 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   22 +-
 .../devicetree/bindings/iommu/apple,sart.yaml      |   10 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    2 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |    5 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    3 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   63 ++
 arch/arm64/boot/dts/apple/t8112-j473.dts           |   54 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   52 +
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi          |   81 ++
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi          | 1141 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  912 ++++++++++++++++
 21 files changed, 2363 insertions(+), 7 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230202-asahi-t8112-dt-6fc880c8cd73

Best regards,
-- 
Janne Grunau <j@jannau.net>

