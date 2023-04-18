Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E26E5FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjDRLS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDRLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:18:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07969020;
        Tue, 18 Apr 2023 04:17:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C9C5E5FD76;
        Tue, 18 Apr 2023 14:16:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681816580;
        bh=rV+/2Zo+MYA4X9kDnUDGtNKqBpG9r9Rn4Sf3ySX9kzE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=F0653ogbGcbwdRloENjlGCckoaKBL+kNs03aZ1bCYLxyxxRYxSx6sLtZ3MJnjlAyo
         OXg9yMVSSyzK5NbKaTiYACuCBX2U04u7iukNEHSvKw+LhT635rkAvyg6tBEhXHKmmA
         PHaCnPB/NnvBpafk2Yo5Xj2lclnbLp+/RKtJIc6kCmQtOjISGp9A0MTngxEyCx0RY/
         qmXSdNJTWhoGP046V1q6ahddQ8ux1e2XOjxBdSCc3K6JdPhrf++FGXz0+1IZj8mpTl
         4m9dJPgYLNLpDrt2oQjcjEXm//X8hds6NCi0bZF11OwMeVqS8+wpIeDfCgLkk+PN4p
         8UniCupfsTXHg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 14:16:19 +0300 (MSK)
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
Subject: [PATCH v2 0/5] arm64: meson: support Amlogic A1 USB OTG controller
Date:   Tue, 18 Apr 2023 14:16:07 +0300
Message-ID: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 05:44:00 #21123121
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes v2 since v1 at [3]:
    - as Martin suggested in v1, this commit completely removes
      the 'otg_switch_supported' parameter from dwc3_meson_g12a_drvdata;
      this parameter is no longer necessary as all IP versions now
      support OTG switching
    - this commit moves the USB PHY clkin enable/disable calls to
      the PHY init/exit routines

Links:
    [1] https://lore.kernel.org/all/1581990859-135234-1-git-send-email-hanjie.lin@amlogic.com/
    [2] https://lore.kernel.org/all/1581990859-135234-4-git-send-email-hanjie.lin@amlogic.com/
    [3] https://lore.kernel.org/all/20230414152423.19842-1-ddrokosov@sberdevices.ru/

Dmitry Rokosov (5):
  phy: amlogic: enable/disable clkin during Amlogic USB PHY init/exit
  usb: dwc2: support dwc2 IP for Amlogic A1 SoC family
  dt-bindings: usb: dwc2: add support for Amlogic A1 SoC USB peripheral
  usb: dwc3-meson-g12a: support OTG switch for all IP versions
  arm64: dts: meson: a1: support USB controller in OTG mode

 .../devicetree/bindings/usb/dwc2.yaml         |  1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 59 +++++++++++++++++++
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     | 13 +++-
 drivers/usb/dwc2/params.c                     | 21 +++++++
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 16 +----
 5 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.36.0

