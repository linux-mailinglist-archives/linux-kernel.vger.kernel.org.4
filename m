Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADD474F6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjGKRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGKRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:20:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CC6173C;
        Tue, 11 Jul 2023 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689095990; x=1720631990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dWz/cu97liJBUQbHnYgLle48DwvZm+4+fW9Lp2y1SMU=;
  b=aNTsF+2FZbbDWFzDhzWVH71vtI4WgWBnhPzWa6GMiXDVmOaIz86IHHlX
   Hy2G7QA10iOgoxX2df1lOYiyE5SyLoC1b7KP4icycIsqTdKaDgvi0A8/H
   bB6U5jTPKbK56LY155YXUIlXkdFm9B7beuXTi6MpCVsRhpQ1NTbB24WmW
   YDSCkS2OCFMjhdijoX4inSvtvZfFBX2Tokk9A6acQkpOeEricI7O5LstN
   O5kh2VBdfaNM4jw6AyUBgGEcagDehNH9d7zPHt5eFjv+Hu2n7onrpeMEP
   KQg+MlFH8zQiLtQXeg4OdLZiWUBkVl67Gh92WrrLquxuC3U9jetKf19l7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362148707"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362148707"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715240814"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715240814"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 10:17:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F1E3A128; Tue, 11 Jul 2023 20:17:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 00/14] spi: Header and core clean up and refactoring
Date:   Tue, 11 Jul 2023 20:17:42 +0300
Message-Id: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups and refactorings of the SPI header and core parts
united in a single series. It also touches drivers under SPI subsystem
folder on the pure renaming purposes of some constants.

No functional change intended (with some subtle shortcuts which are
explained in the respective commit messages).

Changelog v3:
- dropped controversial used to be patches 3,4,8,10 (Mark)
- amended many commit messages (Mark)
- added tag to patch 1 (AngeloGioacchino)
- split used to be patch 2 to patches 2 & 3 for better review (Mark)
- rewritten used to be patch 5 to patches 4 & 5 (Mark, Sebastian)
- added new patch 7
- fixed typos and added tag to patch 12 (Serge)

v2: 20230710154932.68377-1-andriy.shevchenko@linux.intel.com

Changelog v2:
- added new patches 3,4,5,10,13,14
- massaged comment and kernel doc in patch 9
- split used to be patch 4 to patches 11,12
- covered a few things in SPI core in patch 15
- amended commit message for above (Mark)
- reshuffled patches in the series for better logical grouping

Andy Shevchenko (14):
  spi: Remove unneeded OF node NULL checks
  spi: Deduplicate IDR allocation code in spi_register_controller()
  spi: Refactor bus number assigning code in spi_register_controller()
  spi: Remove code duplication in spi_add_device*()
  spi: Kill spi_add_device_locked()
  spi: Use sysfs_emit() to instead of s*printf()
  spi: Use BITS_TO_BYTES()
  spi: Sort headers alphabetically
  spi: Use struct_size() helper
  spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
  spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
  spi: Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS
  spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
  spi: Fix spelling typos and acronyms capitalization

 drivers/spi/spi-amd.c             |   2 +-
 drivers/spi/spi-at91-usart.c      |   2 +-
 drivers/spi/spi-ath79.c           |   2 +-
 drivers/spi/spi-atmel.c           |   4 +-
 drivers/spi/spi-bitbang-txrx.h    |  16 +--
 drivers/spi/spi-bitbang.c         |   8 +-
 drivers/spi/spi-cavium-thunderx.c |   2 +-
 drivers/spi/spi-davinci.c         |   2 +-
 drivers/spi/spi-dw-core.c         |   2 +-
 drivers/spi/spi-falcon.c          |   2 +-
 drivers/spi/spi-fsl-lpspi.c       |   2 +-
 drivers/spi/spi-gpio.c            |  10 +-
 drivers/spi/spi-imx.c             |   2 +-
 drivers/spi/spi-lp8841-rtc.c      |  10 +-
 drivers/spi/spi-meson-spicc.c     |   2 +-
 drivers/spi/spi-mt65xx.c          |   2 +-
 drivers/spi/spi-mxs.c             |   2 +-
 drivers/spi/spi-omap-uwire.c      |   2 +-
 drivers/spi/spi-orion.c           |   2 +-
 drivers/spi/spi-pci1xxxx.c        |   2 +-
 drivers/spi/spi-pic32-sqi.c       |   2 +-
 drivers/spi/spi-pic32.c           |   2 +-
 drivers/spi/spi-qcom-qspi.c       |   2 +-
 drivers/spi/spi-rb4xx.c           |   2 +-
 drivers/spi/spi-rockchip-sfc.c    |   2 +-
 drivers/spi/spi-rockchip.c        |   2 +-
 drivers/spi/spi-sifive.c          |   2 +-
 drivers/spi/spi-slave-mt27xx.c    |   2 +-
 drivers/spi/spi-sprd-adi.c        |   2 +-
 drivers/spi/spi-stm32.c           |   2 +-
 drivers/spi/spi-ti-qspi.c         |   2 +-
 drivers/spi/spi-xcomm.c           |   2 +-
 drivers/spi/spi-xtensa-xtfpga.c   |   2 +-
 drivers/spi/spi.c                 | 211 +++++++++++++-----------------
 include/linux/spi/spi.h           | 173 ++++++++++++------------
 include/trace/events/spi.h        |   2 +-
 36 files changed, 238 insertions(+), 252 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

