Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6A74DA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjGJPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjGJPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:49:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090E11F;
        Mon, 10 Jul 2023 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004181; x=1720540181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=REWyC/nAC6Z96ggpA1NLsyDE3cGETw1DuCTFixDA/T8=;
  b=UwygpstZm01bGkJjy4XU9BnFvg5PsxZxOMwSe9HDbbGLPoeppOUCS8tA
   y5w99YgV+9BUeGiEgqSsnfMTdlMJHQg0E8ooiQRulthMyD92Qey26oUR8
   rHFVIhnoE79E0VjI4vJumbFIwXseC85q7u4O1akMJqp6DgtWaF0ZYs3kI
   9q2wy9O0iJyTdPsA+ypVzqQEMl3KD4SB8RxKQKTdVLD/5gHO8eyrVQuuB
   0Kl85W4bPU4Gf4sKVoktwg62seIZK9WGFh1bNrr7osAaR+zVmD7x1gmSz
   ZC8iBtt/CAhvmvaa/B9LZbgUDbulqZeW1OiqteCcqchAWuI7W9I6peaOY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361842417"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361842417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720743949"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720743949"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 08:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36E48385; Mon, 10 Jul 2023 18:49:34 +0300 (EEST)
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
Subject: [PATCH v2 02/15] spi: Drop duplicate IDR allocation code in spi_register_controller()
Date:   Mon, 10 Jul 2023 18:49:19 +0300
Message-Id: <20230710154932.68377-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor spi_register_controller() to drop duplicate IDR allocation.
Instead of if-else-if branching use two sequential if:s, which allows
to re-use the logic of IDR allocation in all cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 50 ++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8f3282a71c63..6d74218cf38e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3081,6 +3081,20 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 	return 0;
 }
 
+/* Allocate dynamic bus number using Linux idr */
+static int spi_controller_id_alloc(struct spi_controller *ctlr, int start, int end)
+{
+	int id;
+
+	mutex_lock(&board_lock);
+	id = idr_alloc(&spi_master_idr, ctlr, start, end, GFP_KERNEL);
+	mutex_unlock(&board_lock);
+	if (WARN(id < 0, "couldn't get idr"))
+		return id == -ENOSPC ? -EBUSY : id;
+	ctlr->bus_num = id;
+	return 0;
+}
+
 /**
  * spi_register_controller - register SPI master or slave controller
  * @ctlr: initialized master, originally from spi_alloc_master() or
@@ -3108,8 +3122,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 {
 	struct device		*dev = ctlr->dev.parent;
 	struct boardinfo	*bi;
+	int			first_dynamic;
 	int			status;
-	int			id, first_dynamic;
 
 	if (!dev)
 		return -ENODEV;
@@ -3122,27 +3136,13 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
+	if (ctlr->bus_num < 0)
+		ctlr->bus_num = of_alias_get_id(ctlr->dev.of_node, "spi");
 	if (ctlr->bus_num >= 0) {
 		/* Devices with a fixed bus num must check-in with the num */
-		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
-			ctlr->bus_num + 1, GFP_KERNEL);
-		mutex_unlock(&board_lock);
-		if (WARN(id < 0, "couldn't get idr"))
-			return id == -ENOSPC ? -EBUSY : id;
-		ctlr->bus_num = id;
-	} else {
-		/* Allocate dynamic bus number using Linux idr */
-		id = of_alias_get_id(ctlr->dev.of_node, "spi");
-		if (id >= 0) {
-			ctlr->bus_num = id;
-			mutex_lock(&board_lock);
-			id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
-				       ctlr->bus_num + 1, GFP_KERNEL);
-			mutex_unlock(&board_lock);
-			if (WARN(id < 0, "couldn't get idr"))
-				return id == -ENOSPC ? -EBUSY : id;
-		}
+		status = spi_controller_id_alloc(ctlr, ctlr->bus_num, ctlr->bus_num + 1);
+		if (status)
+			return status;
 	}
 	if (ctlr->bus_num < 0) {
 		first_dynamic = of_alias_get_highest_id("spi");
@@ -3151,13 +3151,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 		else
 			first_dynamic++;
 
-		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, first_dynamic,
-			       0, GFP_KERNEL);
-		mutex_unlock(&board_lock);
-		if (WARN(id < 0, "couldn't get idr"))
-			return id;
-		ctlr->bus_num = id;
+		status = spi_controller_id_alloc(ctlr, first_dynamic, 0);
+		if (status)
+			return status;
 	}
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
-- 
2.40.0.1.gaa8946217a0b

