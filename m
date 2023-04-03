Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8536D5083
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjDCScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjDCScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:32:36 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD2F2D4C;
        Mon,  3 Apr 2023 11:32:33 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 9EFA35FD33;
        Mon,  3 Apr 2023 21:32:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680546751;
        bh=skrvDahl5pDvwUwgatlspWiBA9wa5+vS0uE3UumKX9A=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=cqI6aPrNn5mtnhaVCbAtirVNzjeBzR1SEKqrbWHxEFvqNdiy5uS2bl+mGyCMo1kpC
         qbic7dxZuXwZvNtjHjr7xmZAUB1qWUesntKZoLItRDdwnsx8qyGc6JQnEzxrRXX8ye
         VJsYZWa6yQSM/eg+SuIgdfOESl0RFqLAJhcVVlfS3czuZp/rK51VZOwy9oi8fMOuvW
         AnjaCxGZECwoCgwAkevP0F+K6F+Cc+ZoEOi5pdxOpMyUwF1ckHsop5lafBMhOPPCkQ
         kng+5hNd3d/IJ7GR/VDPXokSM4AlD75/wqXsaZJb9QGfDMYOfKiPLBkHsxLXaUpNej
         OUCtHv7kdPsag==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  3 Apr 2023 21:32:30 +0300 (MSK)
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
Subject: [PATCH v3 0/2] add support for Amlogic A1 SPI Flash Controller
Date:   Mon, 3 Apr 2023 21:32:15 +0300
Message-ID: <20230403183217.13280-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/03 14:17:00 #21028104
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces DT bindings and driver for the Amlogic A1 SPI
flash controller (A113L SoC).

The existing spi-meson-spifc driver is incompatible with the A1 SPIFC
at all.

The implementation has been tested on the Amlogic A113L SoC based device
connected with ESMT F50L1G41LB spinand flash.

This patchset has dependencies on the A1 clock series which is still
under review [1].

Changelog:
  v3 since v2 at [2]:
    - Drop the 'meson' name as Neil suggested
    - Make cosmetic changes

  v2 since v1 at [3]:
    - Make cosmetic changes

Links:
  [1] https://lore.kernel.org/all/20230321193014.26349-1-ddrokosov@sberdevices.ru/
  [2] https://lore.kernel.org/all/20230327211351.686831-1-mmkurbanov@sberdevices.ru/
  [2] https://lore.kernel.org/all/20230322150458.783901-1-mmkurbanov@sberdevices.ru/

Martin Kurbanov (2):
  dt-bindings: spi: add Amlogic A1 SPI controller
  spi: add support for Amlogic A1 SPI Flash Controller

 .../bindings/spi/amlogic,a1-spifc.yaml        |  41 ++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-amlogic-spifc-a1.c            | 456 ++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
 create mode 100644 drivers/spi/spi-amlogic-spifc-a1.c

--
2.37.2

