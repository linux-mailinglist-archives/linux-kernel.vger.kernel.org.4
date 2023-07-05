Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4D748BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjGESdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjGEScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:32:41 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C52A133;
        Wed,  5 Jul 2023 11:32:40 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C0EBC12006D;
        Wed,  5 Jul 2023 21:18:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C0EBC12006D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688581121;
        bh=3czK2XZcVhnxWQ4LxP6D2tqOHdgOkwBZ2FrUJZvSVhU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=aCBQsMuE53VtU6GUf47xiQKpt/QInrkHBmzHeXyxvDHIG7l7o9RAAHLsimb4G4X2F
         yJaRMB/uYZfb16RhFVAdKMLVTTJz90Gl/qUk2FC0W/FiCF8EfiXkKvUGy6hB/3g4J8
         eedHep8Td6AythOkK5oP8ryJQqM8DkyAX/TSuWgny5lSl4Ujsiy8/arxYJ9PnWUaep
         sgiDK2co6JrMxTplEJkBQNeHtOMYcaSsmJrRJ97jZgsTWu2AmzPJ8B9SVcLCduVLTg
         md7smJVLIeDshrChS7XQjwEnKwahCi7efN29ry/Hu1dn/inRxtSVzzqqbKqj3CORuo
         vikqkpMDUVWIA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 21:18:41 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 21:18:39 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <jirislaby@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>, <xianwei.zhao@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2 0/7] tty: serial: meson: support ttyS devname
Date:   Wed, 5 Jul 2023 21:18:26 +0300
Message-ID: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178461 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, libera.irclog.whitequark.org:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/05 16:50:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/05 16:49:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 14:57:00 #21566867
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

During a IRC discussion with Neil, as reported in reference [1], an idea
emerged to provide support for a standard devname 'ttyS' in new SoCs
such as A1, S4, T7, C3 and others. The current devname 'ttyAML' is not
widely known and has caused several issues with both low and high-level
software, without any apparent justification for its implementation.
Consequently, it has been deemed necessary to introduce the 'ttyS'
devname for all new 'compatible' entries, while still retaining backward
compatibility with the old 'ttyAML' devname by supporting it in parallel
with the new approach. This patch series therefore aims to implement
these changes.

Changes v2 since v1 at [2]:
    - as suggested by Conor, relocate modifications with the new
      uart_data structures of S4 and A1 SoC from the main meson_uart
      patchset to a separate patchsets
    - ensure that the uart_driver is not unregistered if there is at
      least one active port
    - per Neil's suggestion declare separate uart_driver and console
      objects for both tty devnames (ttyAML and ttyS) to enable the use
      of multiple uart objects with different compatibility strings

Links:
    [1]: https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
    [2]: https://lore.kernel.org/linux-amlogic/20230704135936.14697-1-ddrokosov@sberdevices.ru/

Dmitry Rokosov (7):
  tty: serial: meson: use dev_err_probe
  tty: serial: meson: redesign the module to platform_driver
  tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs
  tty: serial: meson: introduce separate uart_data for S4 SoC family
  tty: serial: meson: add independent uart_data for A1 SoC family
  dt-bindings: serial: amlogic,meson-uart: support Amlogic A1
  arm64: dts: meson: a1: change uart compatible string

 .../bindings/serial/amlogic,meson-uart.yaml   |   2 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   4 +-
 drivers/tty/serial/meson_uart.c               | 145 ++++++++++--------
 3 files changed, 88 insertions(+), 63 deletions(-)

-- 
2.36.0

