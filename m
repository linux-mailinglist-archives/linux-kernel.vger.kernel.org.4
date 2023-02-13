Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15D694BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBMP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjBMP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:59:46 -0500
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE53170B;
        Mon, 13 Feb 2023 07:59:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A84AEBFC15;
        Mon, 13 Feb 2023 16:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676303980; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=H8jzCZUhCtm5be52x1tFFTW+Htqs/PGXpKjaIEzFfgs=;
        b=hHnUSNftOPAG/xJMZJXg607t9+vY0bi8+IioY24lRX0czh3zByE24OfsszZGThhCcGJb04
        tLziZKD8AdAz3v2JXXgrNU/O6uiXh2RCw56xo36GF3Cj+WqseO1ond4bKQ66NTLgvi3G0P
        1XLDTWymhZ8t1Df/N4EZiBvkaFuNUygVvNaIV1XFzL+zI6xWZW8e7t5z3Oi5arRMQ08eBe
        0CtaIA+1/H+NE/wY8eheQ45CungBXcLj7IRVybg4eEDcceydEN48km05zV5b8seLd+jszg
        hrnYP+ZAuRwbAxq3+SztfiQ2pSl7EjsirhbA8MvqAU50XL92uAoERPBThXMpcg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
Date:   Mon, 13 Feb 2023 16:58:18 +0100
Message-Id: <20230213155833.1644366-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This patchset fixes the control of the LDO5 regulator by providing an
option for letting the driver know which of the two possible control
registers is currently in use by the hardware.

It also fixes the enable register for LDO5 to use PCA9450_REG_LDO5CTRL_L
as specified by the datasheet.

The last patch makes use of the fix by adjusting the devicetree for
the Kontron i.MX8MM boards.

In Linux this currently doesn't fix any functional issues, but in
U-Boot similar changes are needed in order to fix SD card access.
See the following thread for more information:

https://lists.denx.de/pipermail/u-boot/2023-January/506103.html

Frieder Schrempf (6):
  dt-bindings: regulator: pca9450: Document new usage of sd-vsel-gpios
  regulator: pca9450: Fix enable register for LDO5
  Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"
  regulator: Add operation to let drivers select vsel register
  regulator: pca9450: Fix control register for LDO5
  arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal

 .../regulator/nxp,pca9450-regulator.yaml      | 23 ++++++---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts |  6 +--
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |  6 +--
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |  1 +
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |  1 +
 drivers/regulator/helpers.c                   | 16 ++++++-
 drivers/regulator/pca9450-regulator.c         | 47 ++++++++++++++-----
 include/linux/regulator/driver.h              |  5 ++
 8 files changed, 79 insertions(+), 26 deletions(-)

-- 
2.39.1

