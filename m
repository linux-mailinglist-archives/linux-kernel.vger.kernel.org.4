Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC6726A93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFGURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFGUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:16:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE61BD3;
        Wed,  7 Jun 2023 13:16:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6A6CD5FD05;
        Wed,  7 Jun 2023 23:16:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686169010;
        bh=M/we8RgDjwgR++pTBbcueO2YO/PO3K31bJrDaIQUUdE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=C+kUCvyF7gc57sZzG2y48Vr72/2ceS66RatT0BvhZU4hmzAD35j+MeraX6XBUD0Gf
         FNhuU2RDsciP98n0kMvXG8BNzq+ZcrlZnGvWtvoK1xf2nYdGWGTcQQJJNNgu98NDOU
         9k5yP3AEg0+vB0BSMk6gkKZb7peorcZ/g+yFfljCcSve5s1wmLlK0RIEBKueW9JAPj
         7udk1RP0ceU0FUZGWouH2I4TGbss8cqFQSA3nOnqCW4vhBJZ1L0ZCqBE2IfocvBjeZ
         wly0shj1NQH1yjQXO/OxZ4yX6G8XYEwCjh8YEojqac1/aE923pUePjq15iopLt0NEK
         i4XPXXtViiiHQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 23:16:50 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 0/6] arm64: dts: meson: a1: introduce several peripheral IPs
Date:   Wed, 7 Jun 2023 23:16:35 +0300
Message-ID: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 16:55:00 #21454472
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces device tree declarations for various
peripheral IPs of the A1 SoC family, including clock controllers, EFUSE,
USB, SPI Flash Controller, SDIO, and UART_AO:
    - CLK: A1 SoC has four types on the board, namely PLL, Peripherals,
      CPU, and Audio, but only Amlogic A1 PLL and Peripherals clock
      controllers are currently supported.
    - EFUSE: consists of a 4k bit One Time Programmable (OTP) memory
      divided into 32 128-bit blocks, and data is accessed using the APB
      bus through software or the Key-ladder integrated with the EFUSE
      block.
    - USB: only one USB 2.0 high-speed port is available in the A1 SoC,
      supporting both HOST and DEVICE modes for OTG.
    - SPI Flash Controller: 4-bit QPI/SPI NOR Flash or NAND FLASH
      controller.
    - SDIO: for WiFi/IEEE802.11 connection.
    - UART_AO: for Bluetooth connection.

Alexey Romanov (1):
  arm64: dts: meson: a1: enable efuse controller and setup its clk

Dmitry Rokosov (2):
  arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers
  arm64: dts: meson: a1: support USB controller in OTG mode

Jan Dakinevich (1):
  arm64: dts: meson: a1: add eMMC controller and its pins

Martin Kurbanov (1):
  arm64: dts: meson: a1: introduce SPI Flash Controller

Oleg Lyovin (1):
  arm64: dts: meson: a1: introduce UART_AO mux definitions

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 164 ++++++++++++++++++++++
 1 file changed, 164 insertions(+)

-- 
2.36.0

