Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39C653804
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLUVJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:09:35 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2567E20BEC;
        Wed, 21 Dec 2022 13:09:34 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,263,1665414000"; 
   d="scan'208";a="144108253"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2022 06:09:33 +0900
Received: from mulinux.example.org (unknown [10.226.92.211])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7051440DC566;
        Thu, 22 Dec 2022 06:09:28 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 0/4] Driver support for RZ/V2M PWC
Date:   Wed, 21 Dec 2022 21:09:13 +0000
Message-Id: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWC IP found in the RZ/V2M family of chips fits the Multi-Function
Device (MFD) model quite well, and comes with the below capabilities:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

With this new version I have changed model for the DT/dt-bindings.
I have dropped syscon, simple-mfd, regmap, offset, and the child nodes.

Thanks,
Fab

Fabrizio Castro (4):
  dt-bindings: mfd: Add RZ/V2M PWC
  mfd: Add RZ/V2M PWC core driver
  gpio: Add support for the Renesas RZ/V2M PWC GPIOs
  power: reset: Add new driver for RZ/V2M PWC poweroff

 .../bindings/mfd/renesas,rzv2m-pwc.yaml       |  56 ++++++++++
 drivers/gpio/Kconfig                          |  10 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rzv2m-pwc.c                 | 105 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  14 +++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rzv2m-pwc.c                       |  70 ++++++++++++
 drivers/mfd/rzv2m-pwc.h                       |  18 +++
 drivers/power/reset/Kconfig                   |   9 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/rzv2m-pwc-poweroff.c      |  67 +++++++++++
 11 files changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
 create mode 100644 drivers/gpio/gpio-rzv2m-pwc.c
 create mode 100644 drivers/mfd/rzv2m-pwc.c
 create mode 100644 drivers/mfd/rzv2m-pwc.h
 create mode 100644 drivers/power/reset/rzv2m-pwc-poweroff.c

-- 
2.34.1

