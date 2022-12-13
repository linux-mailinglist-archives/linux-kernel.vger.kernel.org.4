Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9664B63E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiLMNdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLMNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:33:11 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5F19025;
        Tue, 13 Dec 2022 05:33:08 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 190B240005;
        Tue, 13 Dec 2022 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670938387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FaZcbvxhHbNhfKGb06AAUPmEIZmHhk0GuKAwAJvTwYU=;
        b=QdtfiuX75JtMbXMDdbWIR7fTXtO3mtWjHMhv/05JoSUEaUYE4qA73zGG5X1FH08N7uJycy
        LxF6StlEnYvi8JMNv5o2tnFDt3WKhwyDxCkpHoN3LWMzo6tupeNOu1/a0iPU/zkecSVdnL
        ABKtFVrj/TV9002tyc47QqsIE1Cehr1jYy0FCy8nuqS6HTMNA3Gkb9fFu4yqk2TzSNUVQo
        hN9pgo/OEc0Tmx26j8DwlVJVhKXgmNGnSp2bOQ+eZ8ouf+DhsrwX+EcGo9jxH89Cpzpi6D
        TbKqD0VWvmRrUQ4Y/tvIsUzDLbp24VRBDnjA7oQGOsF5tqJDMgtVAEfOoCzMDg==
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
Subject: [PATCH v4 0/5] Add the Renesas USBF controller support
Date:   Tue, 13 Dec 2022 14:32:57 +0100
Message-Id: <20221213133302.218955-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add support for the Renesas USBF controller (USB Device
Controller) available in the Renesas RZ/N1 SoC.

Based on previous iteration:
  https://lore.kernel.org/all/20221207162435.1001782-1-herve.codina@bootlin.com/
The 'depends-on' property was removed.

Patches 1, 3, 4 and 5 are related to the USBF controller with a new
binding definition, the driver itself and myself as a maintainer
of this controller.

Patch 2 handles h2mode in sysctrl.

Hope that this v4 can lead to some feedbacks on the USB device
controller itself (patch 3).

Best regards,
Herve Codina

Changes v3 -> v4:
  - v3 patches 1, 2, 3 and 4 removed

  - Patch 1 (v3 patch 5)
    Remove 'depends-on' property

  - Patch 2 (v3 patch 6)
    Add 'Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>'

  - Patch 3 (v3 patch 7)
    Fix warning raised by the kernel test robot

  - Patch 4 (v3 patch 8)
    Remove 'depends-on' property
    add 'Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>'

  - Patch 5 (v3 patch 9)
    No changes

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


Herve Codina (5):
  dt-bindings: usb: add the Renesas RZ/N1 USBF controller
  soc: renesas: r9a06g032-sysctrl: Handle h2mode setting based on USBF
    presence
  usb: gadget: udc: add Renesas RZ/N1 USBF controller support
  ARM: dts: r9a06g032: Add the USBF controller node
  MAINTAINERS: add the Renesas RZ/N1 USBF controller entry

 .../bindings/usb/renesas,rzn1-usbf.yaml       |   68 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/r9a06g032.dtsi              |   12 +
 drivers/clk/renesas/r9a06g032-clocks.c        |   28 +
 drivers/usb/gadget/udc/Kconfig                |   11 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/renesas_usbf.c         | 3420 +++++++++++++++++
 7 files changed, 3548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
 create mode 100644 drivers/usb/gadget/udc/renesas_usbf.c

-- 
2.38.1

