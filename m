Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8D731407
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbjFOJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbjFOJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:33:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD6272C;
        Thu, 15 Jun 2023 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821630; x=1718357630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F2rUcbIxMw3hAWM1sE5Tf/q3XRs9zuBlCuzvXhNfqkM=;
  b=d1F/Oy8A1EfB0Mb4nHdX0ErgOwm76aZ0XSaeBsOnGd0BiQbYBozhgbx9
   BlTFya3vq2PV2IHlAqeZhsbE7Bg9zwM1llSBoVDvekRhWEHz15IpKWTXM
   hzgF5PlEFM5SZ410TIpwNDMXPQVnTHCb7OgvTtONhPSfbqtew0W3KIxJg
   PDCdVC32n6OKEfUi6RjgQlo+xwC+mZgZ8RIg7h+nBbjy+ZBVsywh05vKc
   l5orEnwa2OLUq0lfQf8MJE4WQhtgMt17UAU4QVNRoxjkwEjL0s3Pj6y7z
   b7sMy+cAni9s3Dp+4Mq8EG5wgyxdiUS5xBkB/lr6EqWcMN9OJseCvv3tl
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="217994275"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:33:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:33:48 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:33:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 00/11] clk: at91: add support for parent_data and parent_hw
Date:   Thu, 15 Jun 2023 12:32:16 +0300
Message-ID: <20230615093227.576102-1-claudiu.beznea@microchip.com>
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

Series adds support for parent data and parent_hw on AT91 clock drivers
used on SAMA7G5. As the drivers are shared with other AT91 SoC at the
moment the parent names support is preserved and will eventually be
removed when all the AT91 SoC clock drivers will be converted to use
parent_data, parent_hw. For the moment the series does the conversion
for SAMA7G5. Eventually, subsequent patches will adapt the other AT91
SoC clocks.

Series has been tested on SAM9X60, SAMA5D2 and SAMA7G5 SoCs.

Thank you,
Claudiu Beznea

PS: along with this I've added patch 11/11 that fixes a typo.

Claudiu Beznea (11):
  clk: at91: clk-main: add support for parent_data/parent_hw
  clk: at91: clk-generated: add support for parent_hw
  clk: at91: clk-master: add support for parent_hw
  clk: at91: clk-peripheral: add support for parent_hw
  clk: at91: clk-programmable: add support for parent_hw
  clk: at91: clk-system: add support for parent_hw
  clk: at91: clk-utmi: add support for parent_hw
  clk: at91: clk-sam9x60-pll: add support for parent_hw
  clk: at91: sckc: switch to parent_data/parent_hw
  clk: at91: sama7g5: switch to parent_hw and parent_data
  clk: at91: sama7g5: s/ep_chg_chg_id/ep_chg_id

 drivers/clk/at91/at91rm9200.c       |  14 +-
 drivers/clk/at91/at91sam9260.c      |  14 +-
 drivers/clk/at91/at91sam9g45.c      |  16 +-
 drivers/clk/at91/at91sam9n12.c      |  14 +-
 drivers/clk/at91/at91sam9rl.c       |  14 +-
 drivers/clk/at91/at91sam9x5.c       |  20 +-
 drivers/clk/at91/clk-generated.c    |  11 +-
 drivers/clk/at91/clk-main.c         |  32 +-
 drivers/clk/at91/clk-master.c       |  28 +-
 drivers/clk/at91/clk-peripheral.c   |  22 +-
 drivers/clk/at91/clk-programmable.c |  11 +-
 drivers/clk/at91/clk-sam9x60-pll.c  |  17 +-
 drivers/clk/at91/clk-system.c       |  12 +-
 drivers/clk/at91/clk-utmi.c         |  24 +-
 drivers/clk/at91/dt-compat.c        |  23 +-
 drivers/clk/at91/pmc.h              |  36 +-
 drivers/clk/at91/sam9x60.c          |  20 +-
 drivers/clk/at91/sama5d2.c          |  20 +-
 drivers/clk/at91/sama5d3.c          |  16 +-
 drivers/clk/at91/sama5d4.c          |  18 +-
 drivers/clk/at91/sama7g5.c          | 796 ++++++++++++++++------------
 drivers/clk/at91/sckc.c             |  75 ++-
 22 files changed, 730 insertions(+), 523 deletions(-)

-- 
2.34.1

