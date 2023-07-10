Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5874DA48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjGJPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjGJPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:49:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6492C10D;
        Mon, 10 Jul 2023 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004184; x=1720540184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJa3Jmu6iVXPZMGevJvu2fkKY/Gm2mVbHm4RgDFco0c=;
  b=LInZBwE6tEjIur82JS/nzgbv26KmwM6gQWfbFQKHJOsA4wNR8QALYJZl
   Q6Avc5vn6FbysTPj0MEVXon6sFKiFlQ/qZ5tLclW+3LO0cdC367RBj2fy
   Cwg1EPn5oj6a6oqnBsg4FS2QgGLXvzYeA/qocHSId4B3bJtL5YilS33TQ
   ftYPvM58RfjdYXOxJkh2rnAi2zi28fq2kR8M/iQz5jZwDEpFnyqsDuysq
   oEx9d4VElghXmIN8A33hARLqTGhMWM6nvGXiBmjb1hrG1uzgWTBxSBvvA
   RxEtWevkBwG2SJBJAB6Uo+p8D3zPR0j+vla8cSI2r5C8e/0T3BFV1D2Zo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349185345"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349185345"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844921834"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844921834"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 08:49:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A18C4BD; Mon, 10 Jul 2023 18:49:34 +0300 (EEST)
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
Subject: [PATCH v2 04/15] spi: Replace open coded spi_controller_xfer_timeout()
Date:   Mon, 10 Jul 2023 18:49:21 +0300
Message-Id: <20230710154932.68377-5-andriy.shevchenko@linux.intel.com>
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

Since the new spi_controller_xfer_timeout() helper appeared,
we may replace open coded variant in spi_transfer_wait().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       | 25 ++-----------------------
 include/linux/spi/spi.h |  6 +++++-
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 125dea8fae00..c99ee4164f11 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1342,8 +1342,7 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 {
 	struct spi_statistics __percpu *statm = ctlr->pcpu_statistics;
 	struct spi_statistics __percpu *stats = msg->spi->pcpu_statistics;
-	u32 speed_hz = xfer->speed_hz;
-	unsigned long long ms;
+	unsigned long ms;
 
 	if (spi_controller_is_slave(ctlr)) {
 		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
@@ -1351,29 +1350,9 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 			return -EINTR;
 		}
 	} else {
-		if (!speed_hz)
-			speed_hz = 100000;
-
-		/*
-		 * For each byte we wait for 8 cycles of the SPI clock.
-		 * Since speed is defined in Hz and we want milliseconds,
-		 * use respective multiplier, but before the division,
-		 * otherwise we may get 0 for short transfers.
-		 */
-		ms = 8LL * MSEC_PER_SEC * xfer->len;
-		do_div(ms, speed_hz);
-
-		/*
-		 * Increase it twice and add 200 ms tolerance, use
-		 * predefined maximum in case of overflow.
-		 */
-		ms += ms + 200;
-		if (ms > UINT_MAX)
-			ms = UINT_MAX;
-
+		ms = spi_controller_xfer_timeout(ctlr, xfer);
 		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
 						 msecs_to_jiffies(ms));
-
 		if (ms == 0) {
 			SPI_STATISTICS_INCREMENT_FIELD(statm, timedout);
 			SPI_STATISTICS_INCREMENT_FIELD(stats, timedout);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 32c94eae8926..0ce1cb18a076 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1270,12 +1270,16 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
  * that it would take on a single data line and take twice this amount of time
  * with a minimum of 500ms to avoid false positives on loaded systems.
  *
+ * Assume speed to be 100 kHz if it's not defined at the time of invocation.
+ *
  * Returns: Transfer timeout value in milliseconds.
  */
 static inline unsigned int spi_controller_xfer_timeout(struct spi_controller *ctlr,
 						       struct spi_transfer *xfer)
 {
-	return max(xfer->len * 8 * 2 / (xfer->speed_hz / 1000), 500U);
+	u32 speed_hz = xfer->speed_hz ?: 100000;
+
+	return max(xfer->len * 8 * 2 / (speed_hz / 1000), 500U);
 }
 
 /*---------------------------------------------------------------------------*/
-- 
2.40.0.1.gaa8946217a0b

