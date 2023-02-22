Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3649069F3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjBVLun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBVLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:50:35 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F453311F8;
        Wed, 22 Feb 2023 03:50:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2F5CC5FD60;
        Wed, 22 Feb 2023 14:50:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677066630;
        bh=NI3Qga+qg/qUI1RfYvTnROlNrbv1pdLqP/Xu41xF+44=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=npI7zR4bm4ibCYlSQNIbxEbgoEmFp/7H5S5/LoP2eiyKY7aVjNvszlyGQrzj8kijz
         nWs4vNNoy8jwKaZexfNevtGtzzGMtx2S7Rp4F3fnyCgkLn9vCL9xglH4eL69QgOV3E
         SVq2BwM1UnTGPMYfB8xJsrj4erQTyqQxw1b08nxcGtna4tcQ3V0/jQFxAU8vjDjiNZ
         wxinpAoUhImYlyOPEIIGqidITMeu87ELV4q+W3O8oNwse3K1UYQfiycDXAxX1ZqL6p
         JWiWkme9ynGmYgytgKQK1Z2OHNlPyWMzDU9Xf8d9llhCUlePBp3Xrl9t3cd7BeeqkG
         TqBtarvpr9Esg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Feb 2023 14:50:29 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 0/3] Meson A1 32-bit support
Date:   Wed, 22 Feb 2023 14:50:17 +0300
Message-ID: <20230222115020.55867-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/22 06:32:00 #20888384
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patchset adds support for 32-bit Meson A1 board. 
We describe device tree with following components:
CPU, GIC, IRQ, Timer, UART, PIN controller. 
It's capable of booting up into the serial console.

We have tested this DTS and used drivers at our 
32-bit Meson A1 board and it works correctly.

Alexey Romanov (3):
  meson: pinctrl: use CONFIG_PINCTRL_A1 with CONFIG_ARM
  firmware: meson: use CONFIG_MESON_SM with CONFIG_ARM
  arch/arm: dts: introduce meson-a1 device tree

 arch/arm/boot/dts/meson-a1.dtsi | 151 ++++++++++++++++++++++++++++++++
 drivers/firmware/meson/Kconfig  |   2 +-
 drivers/pinctrl/meson/Kconfig   |   2 +-
 3 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/meson-a1.dtsi

-- 
2.38.1

