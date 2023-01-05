Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706C065EFF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjAEPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjAEPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:23:09 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7D288;
        Thu,  5 Jan 2023 07:23:07 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 89348E0015;
        Thu,  5 Jan 2023 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672932186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y7hEx4jCdi5gZ1clrt4nc1ulwGgfHk1FihM6F9ggSy4=;
        b=G/qSdJ0ydV8Xr7/XCkRJgxtAvxWYqZr8MKEt1Hi93EBzvUUdqVbu28IIZlQDeEJ1MBQ2u5
        Dzd0gKB9pavVblmFt7cuEyE3SDi4JsSKTddd5RwcP03y0W2HkgpFO1PwJiOi7WoEHDw6WS
        /7tspGqfhXQq9BevoClufVtGuXi+119mZg9IoMjI+KYIlF8kWC0Hq/tO4Ei4cBon4Axq7+
        kPB+QGdviuDD3z0sQsmjdJQRg/IpwvzwZA1pQZayhOuz6WcZ4ELSeFDiclrXBkhdg9KnPW
        nbygepLIVF5ENUoKQRbVR+mnJrjtD76zwYOu5eiyNfD4ytNH75OEFimyL+qveQ==
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
Subject: [PATCH v5 0/5] Add the Renesas USBF controller support
Date:   Thu,  5 Jan 2023 16:22:52 +0100
Message-Id: <20230105152257.310642-1-herve.codina@bootlin.com>
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
  https://lore.kernel.org/lkml/20221213133302.218955-1-herve.codina@bootlin.com/
Custom debug macros present in the controller driver source code
have been replaced by dev_dbg() calls.

Best regards,
Herve Codina

Changes v4 -> v5:
  - patch 1
    Add 'Reviewed-by: Rob Herring <robh@kernel.org>'
    Add 'Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>'

  - patch 3
    Remove custom TRACE() and TRACEEP() debug macros and
    use directly dev_dbg() instead.

  - patch 2, 4 and 5
    No changes

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
 drivers/usb/gadget/udc/renesas_usbf.c         | 3406 +++++++++++++++++
 7 files changed, 3534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
 create mode 100644 drivers/usb/gadget/udc/renesas_usbf.c

-- 
2.38.1

