Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA626FFB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjEKVFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEKVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:05:12 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07246A76;
        Thu, 11 May 2023 14:05:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 240265FD0C;
        Fri, 12 May 2023 00:05:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683839108;
        bh=09RPiS2Ui8qACl/yeM9LjmonOUAmQqp0kC6laBOrPqM=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=sS0kJ+9englasC3dP9KjcEOfksuOL+iLoEmOpdiHHpwxC8CMaOqB4k13oNGHR+foT
         PMU7n9+4Ged/DFPfD4oKDP4Zj+2wJyvLr8a0eAHCXp/7+TTGymfFPSfKQwbvMny4IG
         WWKdmIEnwVlJ6KuCwfP1oKADmC6elStUhZe9/JKEvzSL7m0xTXih0pATo+4G3xT5/X
         p0eaZufQXxRGVAjAkk8F06hT3SoSpNxDf3SQgtt1yAG7dxLs2lro4pkCr2AWjCa0mC
         hIic69ivq+Vx3s3v6VmHtuSfl7LhGvHk6DnWyVXJ8aStOwY5a2g1AEJwZWx5ELzYH7
         YZHCLZOOcJeXA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 May 2023 00:05:06 +0300 (MSK)
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
Subject: [PATCH v4 0/3] arm64: meson: support Amlogic A1 USB OTG controller
Date:   Fri, 12 May 2023 00:04:52 +0300
Message-ID: <20230511210455.6634-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 10:21:00 #21259776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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

Changes v4 since v3 at [5]:
    - remove the dtsi patchset from series because it is dependent on the
      A1 clock bindings, which are not resolved yet; this is due to the
      fact that the A1 clock drivers are currently under review
    - remove the patchset for phy as it has already been applied by Vinod
      to phy/next at [6]

Changes v3 since v2 at [4]:
    - if reset_control_reset() fails during phy_exit() callback
      execution, do not disable clkin, instead, return an error
      immediately
    - provide proper 'phy-names' for the dwc2 device tree node as
      'usb2-phy' instead of 'usb2_phy' (replace underscore with dash)

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
    [4] https://lore.kernel.org/all/20230418111612.19479-1-ddrokosov@sberdevices.ru/
    [5] https://lore.kernel.org/all/20230426102922.19705-1-ddrokosov@sberdevices.ru/
    [6] https://lore.kernel.org/all/ZFjAmCcc%2F35MhcuI@matsya/

Dmitry Rokosov (3):
  usb: dwc2: support dwc2 IP for Amlogic A1 SoC family
  dt-bindings: usb: dwc2: add support for Amlogic A1 SoC USB peripheral
  usb: dwc3-meson-g12a: support OTG switch for all IP versions

 .../devicetree/bindings/usb/dwc2.yaml         |  1 +
 drivers/usb/dwc2/params.c                     | 21 +++++++++++++++++++
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 16 +++-----------
 3 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.36.0

