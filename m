Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5746F70672A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjEQLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEQLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:54:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BB10FE;
        Wed, 17 May 2023 04:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684324444; x=1715860444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x/TZ2v45jbxmXqFd0/TXltD77HteerLNjobEtu6yQas=;
  b=05l2pQZjojV9PGLkF8ygoV0fRJzSkZbAAt+ZIbWaAuR83lDyq52onO2C
   QyII7ZD+WuuH4NNbHmc73wqJuDLWvqc+dRtBaKy4DR0f6LzaFHrwEUv3Y
   4BLEypdcKZnkorNGMZ9ZNWe7WRnGU72vkCnO2EfItXI4Z/t/Bm8571/wc
   vf+ba0JAYCO9qHE9nbEpoaVVTo+jDFqd6/PthmG0BZsoAhIPwqvHbRAfd
   33DdicPcDryEVhk8dGE/LZoAezgzx+vOZuP++c7ODFMVoR1hVZHmqrFJW
   ZJeN2O8HpxlrLY6WGuyJZo6fm0UG5nLSIgqwLU9XDkN5XMFnxc0VA1tor
   w==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="215867507"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 04:54:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 04:54:04 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 04:54:00 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/3] AT91 PIO4 push-pull enable
Date:   Wed, 17 May 2023 13:54:03 +0200
Message-ID: <cover.1684313910.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set enables push-pull pin configuation for PIO4 IP as well as
updating the DT binding.

Removing the integer argument for open-drain allows the driver to
process drive configuration from gpiolib as the integer argument is
discarded.

Ryan Wanner (3):
  pinctrl: at91-pio4: Enable Push-Pull configuration
  dt-bindings: pinctrl: at91-pio4: Add push-pull support
  ARM: dts: at91: Return to boolean properties

 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt  |  3 ++-
 arch/arm/boot/dts/at91-kizbox3-hs.dts             |  2 +-
 arch/arm/boot/dts/at91-kizbox3_common.dtsi        |  2 +-
 drivers/pinctrl/pinctrl-at91-pio4.c               | 15 +++++++++++----
 4 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.39.2

