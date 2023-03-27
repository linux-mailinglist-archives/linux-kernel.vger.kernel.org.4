Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA16CB072
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC0VOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjC0VOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:14:42 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A21703;
        Mon, 27 Mar 2023 14:14:39 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 010175FD07;
        Tue, 28 Mar 2023 00:14:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679951677;
        bh=9ycbOjNYWPGPuemVUaFLexVP6yqoiw6Ms1b3Do67mQ0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=XkFSNLxAWgQqGYBJ7Mu52Y2xhMANMpt/ZCoW6X3J2mfoB2wcx/Ij1ZSvdo/tXOKcA
         zZtEmisEr2qhIkNyTYLPtmuKuZ4Fxj3Q/YQoacdFu7Y1cj0EIv+GTef92M+0590/N6
         Wlyjj9VKd2L4144Qiwi8KoGw4KJaaGoUp2BI+2YqO1XEynS6goKuMhRec3bF/u3GRt
         EgiRywFDIHpLLbsaKtuhXrFvaBHH6NuLteYAKlhLOHHLKfylFBNb8IwXzt2GNkAcvA
         bCeGR683yVEEu5PDpW93b6aYB0iwMPY/CMAzqchLd9nuCEeOr18GNWkhFbtUXM5Mji
         9ROO5beEKSl2Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 28 Mar 2023 00:14:36 +0300 (MSK)
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
Subject: [PATCH v2 0/2] add support for Meson A1 SPI Flash Controller
Date:   Tue, 28 Mar 2023 00:13:49 +0300
Message-ID: <20230327211351.686831-1-mmkurbanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/27 19:06:00 #21018749
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces DT bindings and driver for the Amlogic Meson A1
SPI flash controller (A113L SoC).

The existing spi-meson-spifc driver is incompatible with the A1 SPIFC
at all.

The implementation has been tested on the Amlogic A113L SoC based device
connected with ESMT F50L1G41LB spinand flash.

This patchset has dependencies on the A1 clock series which is still
under review [1].

Changelog:
  v2 since v1 at [2]:
    - Make cosmetic changes

Links:
  [1] https://lore.kernel.org/all/20230321193014.26349-1-ddrokosov@sberdevices.ru/
  [2] https://lore.kernel.org/all/20230322150458.783901-1-mmkurbanov@sberdevices.ru/

Martin Kurbanov (2):
  dt-bindings: spi: add Amlogic Meson A1 SPI controller
  spi: add support for Meson A1 SPI Flash Controller

 .../bindings/spi/amlogic,meson-a1-spifc.yaml  |  42 ++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-meson-spifc-a1.c              | 453 ++++++++++++++++++
 4 files changed, 503 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
 create mode 100644 drivers/spi/spi-meson-spifc-a1.c

--
2.40.0

