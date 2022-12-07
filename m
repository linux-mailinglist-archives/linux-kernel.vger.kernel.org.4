Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06841645EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLGQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLGQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:24:44 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8A2BF1;
        Wed,  7 Dec 2022 08:24:42 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E8FDB40003;
        Wed,  7 Dec 2022 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670430280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uXJ9vQ0Ynsot47CGwLCWr7UusrmSQ01bL1ZRlYaTFVo=;
        b=jWDZwiQ8jwUnrFFI1b5mTkv69adeV5Eug7HW9Dba1jfz2rniPainJkBrJlVaZFSGfbYdD1
        2I1z0cr16Jm7Zpo0GBx8JPmmXTC9Lx1D33B23cmmyO0QOR9pffoiUQQiSHYkp75rF2dKQH
        XAUiWHY22RRehFAZp1L2y1U+p9yGZ0aHpPM+JmT1EHIRhxFB8f2MdiH2iglaArOZf9t2vy
        tZBm7m10XE09CArmpWBiubotGMHEXBuVIC/OnaU3Xsej2CUoN+ZEokGW7jcu5pOrIbbXUh
        88Fd9SSvFUlM6D+bzyxYoCTXcqeD/rUSK48RnO4em9+KcPGPa056jZZbS4arqg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/9] Add the Renesas USBF controller support
Date:   Wed,  7 Dec 2022 17:24:26 +0100
Message-Id: <20221207162435.1001782-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add support for the Renesas USBF controller (USB Device
Controller) available in the Renesas RZ/N1 SoC.

Based on previous review:
  https://lore.kernel.org/all/20221114111513.1436165-3-herve.codina@bootlin.com/
  
A new strategy is proposed to handle the H2MODE bit from CFG_USB
register compared to the previous versions on the series. As a
reminder, H2MODE bit allows to configure the internal USB Port
interface for two hosts or one host and one device.

This new strategy is:
  - Add the new generic 'depends-on' property in the device tree.

    This generic property expresses an simple functionnal dependency
    that does not rely on a specific topic. It is an 'order only'
    dependency that can be used for dependencies between consumers
    and producers that are not based on a specific infrastructure
    and not need other relationship than this simple 'order only'
    (ie no API is provided between the provider and the consumer)

    The 'depends-on' property is handled in a generic way using
    fw_devlink. The probe() function calls order is ensured by the
    core infrastructure.

    In the nodes impacted by H2MODE, 'depends-on' is used to
    express the dependency to sysctrl.

  - At sysctrl level, during the probe, switch to '1 host, 1 device'
    mode only if the USB device is available.

Patches 1, 2 and 3 are related to 'depends-on' in the PCI bridge
node. This PCI bridge connects the USB host controllers to the AHB bus

Patch 4 adds the 'depends-on' support in fw_devlink
Patch 6 handles h2mode in sysctrl

Patch 5, 7, 8 and 9 are related to the USBF controller with a new
binding definition, the driver itself and myself as a maintainer
of this controller.

Best regards,
Herve Codina

Changes v2 -> v3:
  - v2 Patches 1, 2 and 3 removed.

  - Patches 1, 2, 3 and 4 (new patches)

  - Patch 5 (v2 patch 4):
    Add 'depends-on' property
    Removed redundant 'binding' word

  - Patch 6 (new patch)

  - Patch 7 (v2 patch 5)
    Removed h2mode checking. This check is no more needed and the API no more
    available.

  - Patch 8 (v2 patch 6)
    Add 'depends-on' property

  - Patch 9 (v2 patch 7)
    Fix file name

Changes v1 -> v2:
  - Patch 1:
    Rename r9a06g032_sysctrl_get_usb_h2mode to r9a06g032_sysctrl_get_usb_role
    and return USB_ROLE_{HOST,DEVICE} or an error code.
    Reword commit log

  - Patches 2 and 3:
    No changes. Some previous feedbacks still need to be taken into account
      https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
      https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/

  - Patch 4:
    Rename file from renesas,usbf.yaml to renesas,rzn1-usbf.yaml.
    Remove 'oneOf'.
    Add blank line and line break.
    Add 'power-domains'.
    Reword commit log

  - Patch 5:
    Remove clocks handling (handled by runtime PM through the clock domain
    pointed by power-domains).
    Fix compilation warning raised by the 'kernel test robot'.

  - Patch 6:
    Add 'power-domains'

  - Patch 7:
    Add 'Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>'


Herve Codina (9):
  dt-bindings: PCI: renesas,pci-rcar-gen2: Add depends-on for RZ/N1 SoC
    family
  ARM: dts: r9a06g032: Add dependency to sysctrl in the PCI bridge
  dt-bindings: PCI: renesas,pci-rcar-gen2: 'depends-on' is no more
    optional
  of: property: fw_devlink: Add support for "depends-on"
  dt-bindings: usb: add the Renesas RZ/N1 USBF controller
  soc: renesas: r9a06g032-sysctrl: Handle h2mode setting based on USBF
    presence
  usb: gadget: udc: add Renesas RZ/N1 USBF controller support
  ARM: dts: r9a06g032: Add the USBF controller node
  MAINTAINERS: add the Renesas RZ/N1 USBF controller entry

 .../bindings/pci/renesas,pci-rcar-gen2.yaml   |    7 +
 .../bindings/usb/renesas,rzn1-usbf.yaml       |   77 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/r9a06g032.dtsi              |   14 +
 drivers/clk/renesas/r9a06g032-clocks.c        |   28 +
 drivers/of/property.c                         |    2 +
 drivers/usb/gadget/udc/Kconfig                |   11 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/renesas_usbf.c         | 3420 +++++++++++++++++
 9 files changed, 3568 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
 create mode 100644 drivers/usb/gadget/udc/renesas_usbf.c

-- 
2.38.1

