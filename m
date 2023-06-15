Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083F7315D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbjFOKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbjFOKxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:53:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF61FE5;
        Thu, 15 Jun 2023 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686826433; x=1718362433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VPdNiKlMcAsdznlaYrLTBJ/HZaawdS7AROqbfq7YFK0=;
  b=yeEaKmfnqWtnvmbtgh7G4MbYs/lmUKBaLZM++HU5gPNrkp7ZdbPeCmFO
   yHvr4GLUGcGYngDtuwtuMCpucDsdwjRlUvb2oG90jYvmGR40ZVRLeW0LW
   Lm7WA89fGxGj1X32oxZ2e8RLSekiWytsRsleY4FiTEMx4BwOcUyxNPTwP
   Oepv7rViFfMSNmPBDlPXXm3Tr0napFm+EQMO153AChOaPpnpaJ0iy747k
   ix+toQkhujT+RMMNG8gp/qGPO8JkJHs6GyaSXRf/zdGcrVjp6Pv1ZqwMc
   oCLOi5dlpVHZZ+I2IAhhkdZB4E26saKeZslZka6msh9w8rKOqvthPGyz8
   g==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="218006652"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 03:53:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 03:53:51 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 03:53:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <andriy.shevchenko@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] pinctrl: check memory returned by devm_kasprintf()
Date:   Thu, 15 Jun 2023 13:53:30 +0300
Message-ID: <20230615105333.585304-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While browsing some code I noticed that there are places where pointer
returned by devm_kasprintf() or kasprintf() is not checked. Thus I've
tooked the chance and fixed this (by updating kmerr.cocci script,
changes published at [1]).

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/

Claudiu Beznea (3):
  pinctrl: mcp23s08: check return value of {devm_}kasprintf()
  pinctrl: microchip-sgpio: check return value of devm_kasprintf()
  pinctrl: at91-pio4: check return value of devm_kasprintf()

 drivers/pinctrl/pinctrl-at91-pio4.c       | 2 ++
 drivers/pinctrl/pinctrl-mcp23s08_spi.c    | 3 +++
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 3 +++
 3 files changed, 8 insertions(+)

-- 
2.34.1

