Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CC627C02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiKNLSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiKNLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:26 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766682253B;
        Mon, 14 Nov 2022 03:15:24 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id DB3976000F;
        Mon, 14 Nov 2022 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668424522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JCugCvGRdbEluzdDQKoO/nIaXFqTiQjnDG3+OCpPLoU=;
        b=kUPMpPqGSSnUB0ZJcDO/lAPSZhYByPeTCi73VRYXpTus04v3V/an/AqIOlXAdUmvaoIANT
        bjDA5YIR8KFlHCjcScOf9iWytIf7RiOHHdQRe25JFJ+VeYpkRSPHoqY8NOzXoynglMs+J3
        2axxBrd8kGlHTBxzpcCrMiid6ZnF+hpsQyJh9K5+/WSwdq+rZ4ktfhm51z6wghYlZHgTah
        rypVytdp3YFpESV9QGtBA+PqnMD201FnrM6a8/Pa2eGJ1xfv5H3q+qXHnlidU6CZJeDlG8
        rJRYvSTiCoqh8uVn33YNTGvZf3DW+fTs/pMNg+y1yuXRqPTBD/PcTKUS62dTdQ==
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
Subject: [PATCH v2 0/7] Add the Renesas USBF controller support
Date:   Mon, 14 Nov 2022 12:15:06 +0100
Message-Id: <20221114111513.1436165-1-herve.codina@bootlin.com>
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

The first three patches are related to the H2MODE bit from CFG_USB
register. This register is managed by the Renesas sysctrl driver.
The H2MODE bit allows to configure the internal USB Port interface
for two hosts or one host and one device.

The next patches are related to the USBF controller with a new
binding definition, the driver itself and myself as a maintainer
of this controller.

Best regards,
Herve Codina

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

Herve Codina (7):
  soc: renesas: r9a06g032-sysctrl: Export function to get the usb role
  dt-bindings: clock: renesas,r9a06g032-sysctrl: Add h2mode property
  soc: renesas: r9a06g032-sysctrl: Handle h2mode device-tree property
  dt-bindings: usb: add the Renesas RZ/N1 USBF controller binding
  usb: gadget: udc: add Renesas RZ/N1 USBF controller support
  ARM: dts: r9a06g032: Add the USBF controller node
  MAINTAINERS: add the Renesas RZ/N1 USBF controller entry

 .../clock/renesas,r9a06g032-sysctrl.yaml      |   10 +
 .../bindings/usb/renesas,rzn1-usbf.yaml       |   68 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/r9a06g032.dtsi              |   12 +
 drivers/clk/renesas/r9a06g032-clocks.c        |   39 +
 drivers/usb/gadget/udc/Kconfig                |   11 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/renesas_usbf.c         | 3430 +++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |    2 +
 9 files changed, 3581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
 create mode 100644 drivers/usb/gadget/udc/renesas_usbf.c

-- 
2.38.1

