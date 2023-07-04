Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBA747374
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjGDN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGDN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:59:49 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD9E76;
        Tue,  4 Jul 2023 06:59:46 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 44F16120055;
        Tue,  4 Jul 2023 16:59:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 44F16120055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688479184;
        bh=r6SG7lpLI9I/NbwtRkLknIz0u9uOXQx48vgR4sPGnQg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=BsWXiXBNVIt0liZsYWa9pyaBtocrh/m98ikOb4r0RJCJyYIFERS4Lc8VIu7AMrtiK
         83GKyeBM+v25HaVoX78N0zAHxHIhyBjQp3j+Ny2KkEewkqWaRH9pU0+8FlxlKmwOoW
         ywtixPfBY7FmNS/i2TJefpiIczflsTSXX3xOTQ40cXJ8Zl9w89cz8V/JAA6n8u2RmL
         Xmc+yH8hbh3ajT9N2NCQJJ4NyPyJNcwWZAQOTO3bf+Xnjxwuovwe7+ymWxnickMZyx
         JH6UlnxsVB/n5Fz93iCfWlumDNxIEBknxlOmFSp8uCNCD94J3hQ0olk5HFGK1kbZPo
         aFvpK9BTJg48A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 16:59:44 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 16:59:33 +0300
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
Subject: [PATCH v1 0/5] tty: serial: meson: support ttyS devname
Date:   Tue, 4 Jul 2023 16:59:31 +0300
Message-ID: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178421 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;libera.irclog.whitequark.org:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/04 08:48:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/04 08:48:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
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

Links:
    [1]: https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03

Dmitry Rokosov (5):
  tty: serial: meson: use dev_err_probe
  tty: serial: meson: redesign the module to platform_driver
  tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs
  dt-bindings: serial: amlogic,meson-uart: support Amlogic A1
  arm64: dts: meson: a1: change uart compatible string

 .../bindings/serial/amlogic,meson-uart.yaml   |  2 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  4 +-
 drivers/tty/serial/meson_uart.c               | 83 ++++++++++---------
 3 files changed, 47 insertions(+), 42 deletions(-)

-- 
2.36.0

