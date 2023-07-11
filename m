Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0674F6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjGKRUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjGKRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:20:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91F1998;
        Tue, 11 Jul 2023 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689095994; x=1720631994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6xTQM/M83VGl5L40MPme6/MD9lIrLsXxW1pfo9MYv4=;
  b=JaStsnYzeTg9oBfhx467Zmd/FHYV1dzltl25Ux6hq1+gU5PSdnER42jw
   Mi7SZBFIV/rA3bO1h32I1eZrOly6nE6WhuxA3BTj3Fc07UONhBU8tgpOA
   8AkhXeQsLNNoS2p+6KCS1pQN0IHW4NnfL6IxMsb7ikBcec52R9a67gegq
   snxhkOVSbwYwkhLVn/eO53FqgP8dJSPSEuLVYRNiYwPhyn+GLmU1lMGd2
   2J7qFwXgg+NTm8dndbB1HshS6H9cN1HY8OG1eUxQpN08dlXdXaPhS13iM
   BL6g89tnh/ugOYxgfxM865lKrVD4xhKJxe6Pd743qh3qN7O4yBFmKf21z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362148714"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362148714"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715240870"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715240870"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 10:17:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C3475FC; Tue, 11 Jul 2023 20:17:59 +0300 (EEST)
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
Subject: [PATCH v3 05/14] spi: Kill spi_add_device_locked()
Date:   Tue, 11 Jul 2023 20:17:47 +0300
Message-Id: <20230711171756.86736-6-andriy.shevchenko@linux.intel.com>
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

Now, spi_add_device_locked() has just a line on top of __spi_add_device().
Besides that, it has a single caller. So, just kill it and embed its parts
into the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 876d40d2c708..57b5e4488416 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -708,14 +708,6 @@ int spi_add_device(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 
-static int spi_add_device_locked(struct spi_device *spi)
-{
-	struct spi_controller *ctlr = spi->controller;
-
-	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
-	return __spi_add_device(spi);
-}
-
 /**
  * spi_new_device - instantiate one new SPI device
  * @ctlr: Controller to which device is connected
@@ -2417,11 +2409,12 @@ static void of_register_spi_devices(struct spi_controller *ctlr) { }
 struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 					     u8 chip_select)
 {
+	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
 	int rc = 0;
 
 	/* Alloc an spi_device */
-	ancillary = spi_alloc_device(spi->controller);
+	ancillary = spi_alloc_device(ctlr);
 	if (!ancillary) {
 		rc = -ENOMEM;
 		goto err_out;
@@ -2436,8 +2429,10 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	ancillary->max_speed_hz = spi->max_speed_hz;
 	ancillary->mode = spi->mode;
 
+	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
+
 	/* Register the new device */
-	rc = spi_add_device_locked(ancillary);
+	rc = __spi_add_device(ancillary);
 	if (rc) {
 		dev_err(&spi->dev, "failed to register ancillary device\n");
 		goto err_out;
-- 
2.40.0.1.gaa8946217a0b

