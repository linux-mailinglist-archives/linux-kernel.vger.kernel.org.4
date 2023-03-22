Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB186C4EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCVPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCVPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:06:06 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3037725;
        Wed, 22 Mar 2023 08:06:04 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E565F5FD41;
        Wed, 22 Mar 2023 18:06:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679497562;
        bh=eTQd2Y4ovzRd2JsVVJJ6xL7i63yb2NKMkofOC1iY5UQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kjuu67TLLhokyUl0zqlRRkAEQm8sl9wwsLAdlKeQfw2SUtfkK5YalzTxGlkP1Vrqd
         tbKANfCR4jqjPhDMBSU5WQr2hmB+GpS1eNEbxPiBMERXY8rIyuDeh3K7EGjY9yhDDj
         X9+YgeH3XRmdMEGIn+KN0I3X3rk5fN+8iq90A8w9/KFoosiXcBATOqv3mjBXCQr3ZO
         /fj10e1wszNPQunskDzM8efw61e5A+PBuYqHKay78c03MnF4+BMN7o0ePYE4oyujmT
         Z++NYCFZb7qmZeolobG42evY1MEMS5aMlayUoI4aaPnK8DLBESHmoc7NO8yqFBoxn6
         vmlOKhOYz0e6A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Mar 2023 18:06:02 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1 0/2] add support for Meson A1 SPI Flash Controller
Date:   Wed, 22 Mar 2023 18:04:56 +0300
Message-ID: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/22 10:34:00 #20990985
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces DT bindings and driver for the Amlogic Meson A1
SPI flash controller (A113L family).

The existing spi-meson-spifc driver is incompatible with the A1 SPIFC
at all.

The implementation has been tested on the Amlogic A113L SoC based device
connected with ESMT F50L1G41LB spinand flash.

This patchset has dependencies on the A1 clock series which is still
under review [1].

Links:
  [1] https://lore.kernel.org/all/20230321193014.26349-1-ddrokosov@sberdevices.ru/

Martin Kurbanov (2):
  dt-bindings: spi: add binding for meson-spifc-a1
  spi: add support for Meson A1 SPI Flash Controller

 .../bindings/spi/amlogic,meson-a1-spifc.yaml  |  42 ++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-meson-spifc-a1.c              | 444 ++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
 create mode 100644 drivers/spi/spi-meson-spifc-a1.c

--
2.40.0

