Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB674D366
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjGJK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGJK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:27:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A9B2;
        Mon, 10 Jul 2023 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984876; x=1720520876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v/jR6yG2S/os1yevMEAtUPc5WvkJ6D/EUS+UHJf/Log=;
  b=gnwNJowsg/XnznKkEm7q0RRcrN9IYkac3N3CenpFws2wHK96TYnwxmWa
   nM1SlCG+U8CVnVacpfzENiTa+yr3snkVGIndR1S1cwgIzCiTP9MPamUpX
   2TtiRW/4g9e6f2bMQGkQhfzsO8VuVW5QyfHIFbI81HD8GEngXqQIqZs7G
   RW6SbHbnMR7+ccXKzIITDvNO6c1SddvRAr6toAW/33orhIvykHwhSabHe
   3e7TNowPyqyWsDvzfE71M1xwG5ncEHFI/qcSPyySR/0zMZHBAr3ECR/Lf
   +J+BpBKRTm/R1hYuJ0jvBu+Ykv5NmN0/oCtsnZt4TCGDOK5F60UbbsBnL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364345418"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364345418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865297521"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865297521"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 03:27:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DD3A91FC; Mon, 10 Jul 2023 13:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedTS.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v1 0/8] spi: Header and core clean up and refactoring
Date:   Mon, 10 Jul 2023 13:27:43 +0300
Message-Id: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups and refactorings of the SPI header and core parts
united in a single series.

Patches 1 & 2, 5 & 6 & 8 are dependent inside each group.

No functional change intended.

Andy Shevchenko (8):
  spi: Remove unneeded OF node NULL checks
  spi: Drop duplicate IDR allocation code in spi_register_controller()
  spi: Use sysfs_emit() to instead of s*printf()
  spi: Get rid of old SPI_MASTER_NO_.X and SPI_MASTER_MUST_.X
  spi: Sort headers alphabetically
  spi: Clean up headers
  spi: Fix spelling typos and acronyms capitalization
  spi: Use struct_size() helper

 drivers/spi/spi-at91-usart.c    |   2 +-
 drivers/spi/spi-atmel.c         |   2 +-
 drivers/spi/spi-bitbang-txrx.h  |  16 +--
 drivers/spi/spi-bitbang.c       |   2 +-
 drivers/spi/spi-davinci.c       |   2 +-
 drivers/spi/spi-fsl-lpspi.c     |   2 +-
 drivers/spi/spi-gpio.c          |   8 +-
 drivers/spi/spi-lp8841-rtc.c    |   8 +-
 drivers/spi/spi-meson-spicc.c   |   2 +-
 drivers/spi/spi-mt65xx.c        |   2 +-
 drivers/spi/spi-pci1xxxx.c      |   2 +-
 drivers/spi/spi-pic32.c         |   2 +-
 drivers/spi/spi-rb4xx.c         |   2 +-
 drivers/spi/spi-slave-mt27xx.c  |   2 +-
 drivers/spi/spi-stm32.c         |   2 +-
 drivers/spi/spi-xtensa-xtfpga.c |   2 +-
 drivers/spi/spi.c               | 102 ++++++++---------
 include/linux/spi/spi.h         | 188 ++++++++++++++++++--------------
 18 files changed, 183 insertions(+), 165 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

