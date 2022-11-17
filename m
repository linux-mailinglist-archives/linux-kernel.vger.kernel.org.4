Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418162D87F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiKQKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKQKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:53:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8C5ADF7;
        Thu, 17 Nov 2022 02:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668682379; x=1700218379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PgRUd/gJcLJbdlYAmpEJ7HzosgEa1Fgc6gekCvI/uMM=;
  b=wc+3Uc0gmuAMn5+RMaPo8J904atdsKv6pGcG5W7gHfmXXVBla4cLO7ww
   knd6AyHAk+1dUTfR5ZAjU9bv7EowKygpJCpAEld9w85l/OioasazE3N73
   tG3OoO15DZoh2qYfp+JzdBRRYLhDBu1p5avSDHEfKgV/mjyDlm3ecfOck
   7eerUdGWZ1VGtuqd4qXO5aTwhMpRy253nGkPy1MomAXdnLbcXBFcy2t7U
   hty7LtrohVgh2fv6+U4cCsXJMoMnzpqUxqT0cotV2u8SYDL7KOLXTKKmj
   PZcIVBNSPHEeHOjnmmpdigwc/QjLkVJZSUhJTWIRd7RF7CtTZt080ih+n
   A==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183965587"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 03:52:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 03:52:53 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 03:52:50 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/8] spi: Introduce spi-cs-setup-ns dt property
Date:   Thu, 17 Nov 2022 12:52:41 +0200
Message-ID: <20221117105249.115649-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI NOR flashes have specific cs-setup time requirements without which
they can't work at frequencies close to their maximum supported frequency,
as they miss the first bits of the instruction command. Unrecognized
commands are ignored, thus the flash will be unresponsive. Introduce the
spi-cs-setup-ns property to allow spi devices to specify their cs setup
time.

Tudor Ambarus (8):
  spi: dt-bindings: Introduce spi-cs-setup-ns property
  spi: Introduce spi-cs-setup-ns property
  spi: Reintroduce spi_set_cs_timing()
  spi: atmel-quadspi: Add support for configuring CS timing
  ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at its
    maximum frequency
  ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its
    maximum frequency
  ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI NOR flash at its
    maximum frequency
  ARM: dts: at91: sam9x60ek: Set sst26vf064b SPI NOR flash at its
    maximum frequency

 .../bindings/spi/spi-peripheral-props.yaml    |  5 +++
 arch/arm/boot/dts/at91-sam9x60ek.dts          |  3 +-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi     |  3 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   |  3 +-
 arch/arm/boot/dts/at91-sama5d2_icp.dts        |  3 +-
 drivers/spi/atmel-quadspi.c                   | 34 +++++++++++++++
 drivers/spi/spi.c                             | 43 +++++++++++++++++++
 7 files changed, 90 insertions(+), 4 deletions(-)

-- 
2.25.1

