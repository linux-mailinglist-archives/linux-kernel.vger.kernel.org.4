Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD8646EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLHLkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLHLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:40:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF263D67;
        Thu,  8 Dec 2022 03:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670499602; x=1702035602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DadCGguRmCbiHLwC3f6DRh6AXTOiQ6/F7FUthwy8OGo=;
  b=N0m+PolguWprR3b1rhCtUx07ZE4uiN2NqM0kPugr/S/9wGHpfV0Onn58
   BNQ42AcEnrRfZW4bx2vyE3R9PRylKb3uMmSFtFtYUTfBBR5DD3EAp15/u
   VZB07GEwKG8S/KVjgQI1YKF130S++IQ3l0BW9+GdJst+2L/GzglstKOEj
   xlSjiVUF5IE8NFnZEEik/AmdXZpm6lhfxYqgNr4PlHBM4mW9VzxhuNIQp
   dlsa6cTx1oHc9swRBn9UEz4VicidMpV2SAPR/RsU316ALk1lWSdOjJbbc
   m2vJ+UENkZanblM8nI4EgUSbR12QiVjHa0nCG6dH6/gT2AuRZrKnE1klx
   A==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="127111667"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 04:40:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 04:39:59 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Dec 2022 04:39:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] clk: at91: mark ddr clocks as critical
Date:   Thu, 8 Dec 2022 13:45:12 +0200
Message-ID: <20221208114515.35179-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series marks DDR clocks of AT91 SoCs as critical and remove the
atmel-sdramc.c driver as this does only clock request and enable and
don't prevent any of DDR clock consumers do DDR clocks.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  clk: at91: mark ddr clocks as critical
  memory: atmel-sdramc: remove the driver
  clk: at91: do not compile dt-compat.c for sama7g5 and sam9x60

 drivers/clk/at91/Makefile         | 16 +++----
 drivers/clk/at91/at91rm9200.c     |  2 +-
 drivers/clk/at91/at91sam9260.c    |  2 +-
 drivers/clk/at91/at91sam9g45.c    | 10 +++-
 drivers/clk/at91/at91sam9n12.c    | 12 +++--
 drivers/clk/at91/at91sam9rl.c     |  2 +-
 drivers/clk/at91/at91sam9x5.c     | 17 +++++--
 drivers/clk/at91/clk-peripheral.c |  8 ++--
 drivers/clk/at91/clk-system.c     |  4 +-
 drivers/clk/at91/dt-compat.c      | 25 +++++++++-
 drivers/clk/at91/pmc.h            |  4 +-
 drivers/clk/at91/sam9x60.c        | 20 ++++++--
 drivers/clk/at91/sama5d2.c        | 22 +++++++--
 drivers/clk/at91/sama5d3.c        | 20 ++++++--
 drivers/clk/at91/sama5d4.c        | 22 +++++++--
 drivers/clk/at91/sama7g5.c        |  4 +-
 drivers/memory/Makefile           |  1 -
 drivers/memory/atmel-sdramc.c     | 76 -------------------------------
 18 files changed, 139 insertions(+), 128 deletions(-)
 delete mode 100644 drivers/memory/atmel-sdramc.c

-- 
2.34.1

