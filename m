Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235BF74DA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGJPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjGJPtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:49:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31048120;
        Mon, 10 Jul 2023 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004189; x=1720540189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NaAUtfuKUjWfIyo2AvU+b2/TN3c63zF3Fr8TWiuiUkI=;
  b=UEuBUyQIf112A0i0q6pGwKi1pkCsjIwGATrnpBMOAra8u0HNKs9vxoqZ
   4n79vyWu1/O+eYCzIehP1WTi+MX2+j6xWW1Nf4G98PFZA9SkC/klwMbda
   lG2D1fLKLGu7AcP8cs0veblCHVFYgTIUfPlarHX9FSe6/0PSci8E6Uw+D
   G45yI+K54YsQr362x06CLWgixx76+Aclk5uuPeTXCt0qrq2ICLdtLQiYk
   jYSFwv9oNJhkQYHSChY5nqBa2wjYYoMLtQME/YRWhMZIiea+af1aeFFPg
   9mdtJB/hHJLW7sa40HLacjQIZJaYDCypXpt8DhbCNKpPalSA2e6ncQBTc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349185443"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349185443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844921872"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844921872"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 08:49:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8BD3669A; Mon, 10 Jul 2023 18:49:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
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
        Serge Semin <fancer.lancer@gmail.com>,
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
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 07/15] spi: Sort headers alphabetically
Date:   Mon, 10 Jul 2023 18:49:24 +0300
Message-Id: <20230710154932.68377-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorting headers alphabetically helps locating duplicates, and
make it easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       | 42 ++++++++++++++++++++---------------------
 include/linux/spi/spi.h | 14 +++++++-------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cfb1c985d940..06a92a3a5746 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4,36 +4,36 @@
 // Copyright (C) 2005 David Brownell
 // Copyright (C) 2008 Secret Lab Technologies Ltd.
 
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/init.h>
+#include <linux/acpi.h>
 #include <linux/cache.h>
-#include <linux/dma-mapping.h>
+#include <linux/clk/clk-conf.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/gpio/consumer.h>
+#include <linux/highmem.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/clk/clk-conf.h>
-#include <linux/slab.h>
-#include <linux/mod_devicetable.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/spi-mem.h>
-#include <linux/gpio/consumer.h>
-#include <linux/pm_runtime.h>
+#include <linux/percpu.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/export.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/sched/rt.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 #include <uapi/linux/sched/types.h>
-#include <linux/delay.h>
-#include <linux/kthread.h>
-#include <linux/ioport.h>
-#include <linux/acpi.h>
-#include <linux/highmem.h>
-#include <linux/idr.h>
-#include <linux/platform_data/x86/apple.h>
-#include <linux/ptp_clock_kernel.h>
-#include <linux/percpu.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0ce1cb18a076..2026eae97329 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -6,19 +6,19 @@
 #ifndef __LINUX_SPI_H
 #define __LINUX_SPI_H
 
+#include <linux/acpi.h>
 #include <linux/bits.h>
+#include <linux/completion.h>
 #include <linux/device.h>
-#include <linux/mod_devicetable.h>
-#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
-#include <linux/completion.h>
+#include <linux/mod_devicetable.h>
 #include <linux/scatterlist.h>
-#include <linux/gpio/consumer.h>
-
-#include <uapi/linux/spi/spi.h>
-#include <linux/acpi.h>
+#include <linux/slab.h>
 #include <linux/u64_stats_sync.h>
 
+#include <uapi/linux/spi/spi.h>
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
-- 
2.40.0.1.gaa8946217a0b

