Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA574F6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGKRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGKRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:20:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549501730;
        Tue, 11 Jul 2023 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689095987; x=1720631987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rn9d/T3W6Uq2IhVx3LkqBWZwSCJuFxg8vPiXigm9Nk4=;
  b=Y43VztpHyRl81FJroUoDegxhxOglgUQyWx5/v1ol5MFYrvBv9aWdJ68O
   dmSJzJZKkZX/p5sX3GOD2YEnywy+bc3cO/giMw5Jt5dna2jhJ7gt9yVZy
   GAfUWCM1RBZQLdIdmBO64RlJajXn56HGM+jLSVBJ8IbBfVZqGtG+O6tbM
   qWtanvTQitpqCPM2k6ocyVAKvYkem0I3r5b5cUsLz9FpFn0DDvqmrmKhj
   qTz0+wcRy1dlfZBzDqnwputQeaP+cy/ZnU6NfkzCq/gXY4iY5M3wzWgul
   1qb/aFRQN38MqcWQkKUajLCMhGWrWGI3YA2P5TRJnOL4hA7fs/b/JF7WQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362148710"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362148710"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715240845"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715240845"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 10:17:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3818F3E3; Tue, 11 Jul 2023 20:17:59 +0300 (EEST)
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
Subject: [PATCH v3 03/14] spi: Refactor bus number assigning code in spi_register_controller()
Date:   Tue, 11 Jul 2023 20:17:45 +0300
Message-Id: <20230711171756.86736-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
References: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
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

Instead of 'else' branching use two sequential if:s, which allows
to re-use the logic of IDR allocation in both cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d8064998aa27..6d74218cf38e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3122,8 +3122,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 {
 	struct device		*dev = ctlr->dev.parent;
 	struct boardinfo	*bi;
+	int			first_dynamic;
 	int			status;
-	int			id, first_dynamic;
 
 	if (!dev)
 		return -ENODEV;
@@ -3136,19 +3136,13 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
+	if (ctlr->bus_num < 0)
+		ctlr->bus_num = of_alias_get_id(ctlr->dev.of_node, "spi");
 	if (ctlr->bus_num >= 0) {
 		/* Devices with a fixed bus num must check-in with the num */
 		status = spi_controller_id_alloc(ctlr, ctlr->bus_num, ctlr->bus_num + 1);
 		if (status)
 			return status;
-	} else {
-		/* Allocate dynamic bus number using Linux idr */
-		id = of_alias_get_id(ctlr->dev.of_node, "spi");
-		if (id >= 0) {
-			status = spi_controller_id_alloc(ctlr, id, id + 1);
-			if (status)
-				return status;
-		}
 	}
 	if (ctlr->bus_num < 0) {
 		first_dynamic = of_alias_get_highest_id("spi");
-- 
2.40.0.1.gaa8946217a0b

