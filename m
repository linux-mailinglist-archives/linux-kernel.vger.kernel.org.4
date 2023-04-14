Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869B6E26D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDNPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjDNPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:24:37 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC7AD36;
        Fri, 14 Apr 2023 08:24:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E52E95FD0A;
        Fri, 14 Apr 2023 18:24:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681485872;
        bh=27rKXTxLIgcS+trNatx2a2CTSjoT7Q+aM89mbryOnzI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Uz8wBngDVIw48wLM/QWlmCJUlOirzMBsQEOG0xrZzrwXJanZJVT/GiLt80WLq3Q/2
         EyqqOMbA3EFLL/k68vaZ9evR2Ck+1wGmj1NBcB0vzgULQt83DBTlLNDMhppj16lRiS
         AgUSq4kYkuG+j9Mye2yaPZSQZuHJmcxqefSQ29d8bKGAANPo4TYT9pnOJNlkGUKfVI
         NR6uRr1ozPk+9UQQu2Z73RuN0HOpVZJ2HdaEK+Jnx9Mz8p4nSlnjT8eB98IST+K0HE
         n7qZ5kW2ExUxiV/saf4CctTFseoY2Remenf3CY5tFQqmoH2/upQbsr35n/AP8kx2gC
         JoNVuwI3dz2QA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 14 Apr 2023 18:24:30 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <mturquette@baylibre.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <hminas@synopsys.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 0/5] arm64: meson: support Amlogic A1 USB OTG controller
Date:   Fri, 14 Apr 2023 18:24:18 +0300
Message-ID: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/14 08:08:00 #21104846
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces full support for the Amlogic A1 USB controller
in OTG mode (peripheral and host modes switching).

Previously, Amlogic's patch series [1] was applied to the upstream tree,
but it only had USB host mode support.
Furthermore, the device tree patchset [2] wasn't merged due to a missing
clk driver.
Patchset [2] has been completely reworked:
    - changed register base offsets to proper values
    - introduced dwc2 in peripheral mode
    - OTG mode support
    - the SoB of Amlogic authors still remain

Testing:
    - USB OTG role switching between gadget and host - OK
    - Peripheral mode - OK (tested with adb shell/push/pop)
    - Host mode - OK (tested only USB enumeration and detection)

Links:
    [1] https://lore.kernel.org/all/1581990859-135234-1-git-send-email-hanjie.lin@amlogic.com/
    [2] https://lore.kernel.org/all/1581990859-135234-4-git-send-email-hanjie.lin@amlogic.com/

Dmitry Rokosov (5):
  phy: amlogic: during USB PHY clkin obtaining, enable it
  usb: dwc2: support dwc2 IP for Amlogic A1 SoC family
  dt-bindings: usb: dwc2: add support for Amlogic A1 SoC USB peripheral
  usb: dwc3-meson-g12a: support OTG switch
  arm64: dts: meson: a1: support USB controller in OTG mode

 .../devicetree/bindings/usb/dwc2.yaml         |  1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 59 +++++++++++++++++++
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     |  2 +-
 drivers/usb/dwc2/params.c                     | 21 +++++++
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  2 +-
 5 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.36.0

