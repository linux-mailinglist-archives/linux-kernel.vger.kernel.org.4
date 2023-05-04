Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82DA6F6D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjEDNrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEDNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:47:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912287D9C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:47:39 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1puZIT-0004SX-Dt; Thu, 04 May 2023 15:47:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 0/4] Add i.MX8MP-EVK USB Gadget Support
Date:   Thu, 04 May 2023 15:46:49 +0200
Message-Id: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEm3U2QC/x2OTQqDMBQGryJZ9wOJqbW9SukiP8/6aEwkaYIg3
 r2hy5nFMIfIlJiyeHSHSFQ5cwwN5KUTdtHhTWDXWMheDv21VzAKdcSAb9zYwkSdXAav+7RuoPq
 BK9ojRU8o2WBydh7lTbm7m0VrGp0JJulgl1YNxfsmt0Qz7/+J5+s8f36w3qSUAAAA
To:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.12.1
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this adds the usb gadget support to the i.MX8MP-EVK. This Series is
based on [1] and therefore it is already a v2. Thanks to Li and Andreas
for the very useful feedback.

Patch1-3: Add the mssing support for USB-SS GPIO muxes. This is required
          to have proper USB-SS support on the EVK.

Patch4: Adds the devicetree integration.

[1] https://lore.kernel.org/all/20230323105826.2058003-1-m.felsch@pengutronix.de/

Regards,
  Marco

---
Marco Felsch (4):
      dt-bindings: usb: gpio-sbu-mux: add support for ss-data lanes mux
      usb: typec: mux: gpio-sbu-mux: add support for ss data lane muxing
      usb: typec: tcpci: clear the fault status bit
      arm64: dts: imx8mp-evk: add dual-role usb port1 support

 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      | 82 +++++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       | 88 ++++++++++++++++++++++
 drivers/usb/typec/mux/Kconfig                      |  5 +-
 drivers/usb/typec/mux/gpio-sbu-mux.c               | 18 ++++-
 drivers/usb/typec/tcpm/tcpci.c                     |  5 ++
 include/linux/usb/tcpci.h                          |  1 +
 6 files changed, 185 insertions(+), 14 deletions(-)
---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-8dcf6274d9df

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>

