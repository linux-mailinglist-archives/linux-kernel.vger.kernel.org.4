Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC99693808
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBLPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:41:31 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494CCC09;
        Sun, 12 Feb 2023 07:41:29 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id B337B26F774;
        Sun, 12 Feb 2023 16:41:27 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] Device trees for Apple M2 (t8112) based devices
Date:   Sun, 12 Feb 2023 16:41:10 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4069; i=j@jannau.net; h=from:subject:message-id; bh=T1gW01uvhz7dwsM+fyAZoh/ebAn42ouyiqF3bLCCef8=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7MfbCn4wiptbu+TrSxxu2cIeFnyk3rezQ7iobIO+S 8v1jDUdpSwMYhwMsmKKLEnaLzsYVtcoxtQ+CIOZw8oEMoSBi1MAJtJbyPDfW4/3zfn/P+TLk57w /VRm7pAXYnt5uP+Z7KKbl9dwfk5mYGRoNbNZqlD0lj3lxb7QMOulC9rXlMakpIQdjPG1Fv4re4s ZAA==
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains dt-bindings updates and device trees for Apple
silicon devices based on the M2 SoC (t8112).

Device tree validation depends ont the dart-t8110 bindings queued in
the iommu tree for 6.3 [1] and support for "local-mac-address" for
brcm,bcm4329-fmac based devices [2]. The latter fixes validation errors
for the existing M1 and M1 Pro/Max/Ultra device trees.

The device trees are tested with the downstream Asahi Linux kernel and
on top of v6.2-rc5. The hardware is of limited use with the upstream
kernel. The notebooks miss keyboard/trackpad drivers and usb support.
The Mac mini does not yet have a boot framebuffer and lacks usb support
as well.

The PMU (performance monitor) driver needs a small update which I'll
send out separately. All other driver changes are already queued. The
dt-bindings changes should be merged through asahi-soc to ensure
devicetree validation.

1: https://lore.kernel.org/linux-iommu/20230113105029.26654-1-marcan@marcan.st/
2: https://lore.kernel.org/linux-devicetree/20230203-dt-bindings-network-class-v2-2-499686795073@jannau.net/

Signed-off-by: Janne Grunau <j@jannau.net>
---
Hector Martin (2):
      dt-bindings: power: apple,pmgr-pwrstate: Add t8112 compatible
      arm64: dts: apple: t8112: Initial t8112 (M2) device trees

Janne Grunau (15):
      dt-bindings: arm: apple: apple,pmgr: Add t8112-pmgr compatible
      dt-bindings: watchdog: apple,wdt: Add t8112-wdt compatible
      dt-bindings: arm: cpus: Add apple,avalanche & blizzard compatibles
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t8112-aic compatible
      dt-bindings: arm-pmu: Add PMU compatible strings for Apple M2 cores
      dt-bindings: iommu: apple,sart: Add apple,t8112-sart compatible string
      dt-bindings: mailbox: apple,mailbox: Add t8112 compatibles
      dt-bindings: nvme: apple: Add apple,t8112-nvme-ans2 compatible string
      dt-bindings: pci: apple,pcie: Add t8112 support
      dt-bindings: pinctrl: apple,pinctrl: Add apple,t8112-pinctrl compatible
      dt-bindings: i2c: apple,i2c: Add apple,t8112-i2c compatible
      dt-bindings: clock: apple,nco: Add t8112-nco compatible
      dt-bindings: sound: apple,mca: Add t8112-mca compatible
      dt-bindings: dma: apple,admac: Add t8112-admac compatible
      dt-bindings: arm: apple: Add t8112 j413/j473/j493 compatibles

 Documentation/devicetree/bindings/arm/apple.yaml   |   15 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |    2 +
 .../devicetree/bindings/clock/apple,nco.yaml       |    1 +
 .../devicetree/bindings/dma/apple,admac.yaml       |    1 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   23 +-
 .../devicetree/bindings/iommu/apple,sart.yaml      |   11 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    2 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |    5 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/sound/apple,mca.yaml       |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    3 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   71 ++
 arch/arm64/boot/dts/apple/t8112-j473.dts           |   60 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   60 +
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi          |   81 ++
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi          | 1141 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  904 ++++++++++++++++
 23 files changed, 2382 insertions(+), 7 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230202-asahi-t8112-dt-6fc880c8cd73

Best regards,
-- 
Janne Grunau <j@jannau.net>

