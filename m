Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39A61F4C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKGN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKGN7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:59:43 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31533D8;
        Mon,  7 Nov 2022 05:59:41 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 752854000A;
        Mon,  7 Nov 2022 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667829580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J18pKrIjW6VEPXi9FUYA5NYj/Ak1VdU4SYHkeyksqwM=;
        b=OChktmqRY6fpdgcTyG1ttuM1cSZn2f97WaPikChL78nIxHtRCZ5N+evzRsQ0pa0yp/8J6A
        1o9O/LSQK14SrafStp51j8nPuEpgCiT3Or7K+ad7mhUNL9WiNdJ1NbGSwAPf5F2SloQnrB
        Hf8gIZ4ZXByakcBXMvFTrT0traZbNdpwL8cyzvD2NK5OOTGmjuX4YcP0fvEHX6t5OZgJaC
        PSSy1PXrKeloApL1NSbI8gj9oYgza1udb892/dCfiNUWYWOyHcjqGOilP0CThOygRxygCV
        GvlJDhPxeAKTSbj3DEsOvvEZqJkqoFs8xfgBOG8VWkg50yl0XpKI907Yb9imWA==
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
Subject: [PATCH 0/7] Add the Renesas USBF controller support
Date:   Mon,  7 Nov 2022 14:58:18 +0100
Message-Id: <20221107135825.583877-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.37.3
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

The first three patches are related to the H2MODE bit from CFG_USB
register. This register is managed by the Renesas sysctrl driver.
The H2MODE bit allows to configure the internal USB Port interface
for two hosts or one host and one device.

The next patches are related to the USBF controller with a new
binding definition, the driver itself and myself as a maintainer
of this controller.

Best regards,
Herve Codina

Herve Codina (7):
  soc: renesas: r9a06g032-sysctrl: Export function to get H2MODE from
    CFG_USB register
  dt-bindings: clock: renesas,r9a06g032-sysctrl: Add h2mode property
  soc: renesas: r9a06g032-sysctrl: Handle h2mode device-tree property
  dt-bindings: usb: add the Renesas USBF controller binding
  usb: gadget: udc: add Renesas RZ/N1 USBF controller support
  ARM: dts: r9a06g032: Add the USBF controller node
  MAINTAINERS: add the Renesas RZ/N1 USBF controller entry

 .../clock/renesas,r9a06g032-sysctrl.yaml      |   10 +
 .../devicetree/bindings/usb/renesas,usbf.yaml |   64 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/r9a06g032.dtsi              |   11 +
 drivers/clk/renesas/r9a06g032-clocks.c        |   39 +
 drivers/usb/gadget/udc/Kconfig                |   11 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/renesas_usbf.c         | 3455 +++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |    2 +
 9 files changed, 3601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usbf.yaml
 create mode 100644 drivers/usb/gadget/udc/renesas_usbf.c

-- 
2.37.3

