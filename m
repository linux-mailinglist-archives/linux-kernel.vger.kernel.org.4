Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902B674D365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjGJK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjGJK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:27:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF85B8;
        Mon, 10 Jul 2023 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984877; x=1720520877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1YMEKoH26Jvs8dKIC6vdH9uSV/g2LDeyMP+ZqFMU56I=;
  b=h7ybhVYCq4AvpCWdmYKQb4kBn+J7jGqUqVbRr9PBch+k0VTXjX6UnlmK
   hphFepYNIa/eFLTkZ9BlMY+gcQFhDij//Nh2pefcSb2KZAYjkduWuySJo
   HRlP7wF/dM0XxMLl8IWoyqqmXp8K+Fr2siu2713El2EVVp9yKOR6UKvrS
   VGTOGWaCulWQYZoFaVpXMRpPbPV6pPN1vpZe1B0otTpve0c5rIn9wfoUZ
   6628ojS2bs70FsVVcHLa4++uIak2EXAn1AWEyO+mx6sWrAbwJQlJ/izm3
   H2isXuwUoZxbKpmddoERvFpFeQ83+pIKhvkd0AsDa7Z7mOLohhS6kpQYg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="367803738"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="367803738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755956011"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755956011"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2023 03:27:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EDFD31D9; Mon, 10 Jul 2023 13:27:52 +0300 (EEST)
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
Subject: [PATCH v1 1/8] spi: Remove unneeded OF node NULL checks
Date:   Mon, 10 Jul 2023 13:27:44 +0300
Message-Id: <20230710102751.83314-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
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

In the couple of places the NULL check of OF node is implied by the call
that takes it as a parameter. Drop the respective duplicate checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9291b2a0e887..8f3282a71c63 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2399,9 +2399,6 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 	struct spi_device *spi;
 	struct device_node *nc;
 
-	if (!ctlr->dev.of_node)
-		return;
-
 	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
 		if (of_node_test_and_set_flag(nc, OF_POPULATED))
 			continue;
@@ -3134,7 +3131,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (WARN(id < 0, "couldn't get idr"))
 			return id == -ENOSPC ? -EBUSY : id;
 		ctlr->bus_num = id;
-	} else if (ctlr->dev.of_node) {
+	} else {
 		/* Allocate dynamic bus number using Linux idr */
 		id = of_alias_get_id(ctlr->dev.of_node, "spi");
 		if (id >= 0) {
-- 
2.40.0.1.gaa8946217a0b

