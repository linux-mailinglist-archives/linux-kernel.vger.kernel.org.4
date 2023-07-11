Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885474F708
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjGKRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjGKRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:21:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C01BD7;
        Tue, 11 Jul 2023 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689096046; x=1720632046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pAWPsjI4cTEbUbFXGBMVoie/XvBSHdTVWugoYwa5pwQ=;
  b=dEE0UP0Fej6NRF58dz6h5qF+0a1g+R7Gw+uMbSXfJRQ9jRCdGr/Kh8k8
   99mpfY/+G8WxCIVhUOo9/zNnsqrUTBYyn5T30NHf3wlWlEqVj9VvgDKFu
   wlMqUlBsILNxydiyf+kj4NUastzpYcIJuNC6QT4UruXkTKRyAZetwmoJ7
   iSYx7FPQAQl2IYw9nF+paTVpqw04QaiNxaDvleYUDz7qKETw6aMl0HQ85
   udiA9CvJwgPEOK41tdhhMyPxt6WlOrgdYy5UZRFb8dBI0m1ppLlt62VBQ
   EmNi6BO5J4NW54gFHkaGWquvA3HaBzus17IdczqOuF29VlpYmWsAWFnlb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362148758"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362148758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715240943"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715240943"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 10:18:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99EF06B9; Tue, 11 Jul 2023 20:17:59 +0300 (EEST)
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
Subject: [PATCH v3 09/14] spi: Use struct_size() helper
Date:   Tue, 11 Jul 2023 20:17:51 +0300
Message-Id: <20230711171756.86736-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
References: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/process/deprecated.rst suggests to use flexible array
members to provide a way to declare having a dynamically sized set of
trailing elements in a structure.This makes code robust agains bunch of
the issues described in the documentation, main of which is about the
correctness of the sizeof() calculation for this data structure.

Due to above, prefer struct_size() over open-coded versions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 21b77bdfac29..35fd61070d9b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -13,6 +13,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
+#include <linux/overflow.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/u64_stats_sync.h>
@@ -1081,6 +1082,8 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the spi message is processed
  * @prepared: spi_prepare_message was called for the this message
+ * @t: for use with spi_message_alloc() when message and transfers have
+ *	been allocated together
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1133,6 +1136,9 @@ struct spi_message {
 
 	/* List of spi_res reources when the spi message is processed */
 	struct list_head        resources;
+
+	/* For embedding transfers into the memory of the message */
+	struct spi_transfer	t[];
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
@@ -1193,16 +1199,13 @@ static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags
 {
 	struct spi_message *m;
 
-	m = kzalloc(sizeof(struct spi_message)
-			+ ntrans * sizeof(struct spi_transfer),
-			flags);
+	m = kzalloc(struct_size(m, t, ntrans), flags);
 	if (m) {
 		unsigned i;
-		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
 
 		spi_message_init_no_memset(m);
-		for (i = 0; i < ntrans; i++, t++)
-			spi_message_add_tail(t, m);
+		for (i = 0; i < ntrans; i++)
+			spi_message_add_tail(&m->t[i], m);
 	}
 	return m;
 }
-- 
2.40.0.1.gaa8946217a0b

