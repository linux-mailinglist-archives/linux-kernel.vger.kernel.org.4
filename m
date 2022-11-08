Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC4620B13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKHIZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKHIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:25:41 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD91B27B20
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:25:39 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Nov 2022 17:25:38 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id C85522059027;
        Tue,  8 Nov 2022 17:25:38 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Nov 2022 17:25:38 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 89233B62A4;
        Tue,  8 Nov 2022 17:25:38 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/4] mmc: f-sdh30: Add reset control support
Date:   Tue,  8 Nov 2022 17:25:30 +0900
Message-Id: <20221108082533.21384-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset control support for F_SDH30 controller. This is optional.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 3f5977979cf2..7f4553b28180 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 #include "sdhci_f_sdh30.h"
@@ -21,6 +22,7 @@
 struct f_sdhost_priv {
 	struct clk *clk_iface;
 	struct clk *clk;
+	struct reset_control *rst;
 	u32 vendor_hs200;
 	struct device *dev;
 	bool enable_cmd_dat_delay;
@@ -150,6 +152,16 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(priv->clk);
 		if (ret)
 			goto err_clk;
+
+		priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
+		if (IS_ERR(priv->rst)) {
+			ret = PTR_ERR(priv->rst);
+			goto err_rst;
+		}
+
+		ret = reset_control_deassert(priv->rst);
+		if (ret)
+			goto err_rst;
 	}
 
 	/* init vendor specific regs */
@@ -175,6 +187,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_host:
+	reset_control_assert(priv->rst);
+err_rst:
 	clk_disable_unprepare(priv->clk);
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
@@ -191,8 +205,9 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
 			  0xffffffff);
 
-	clk_disable_unprepare(priv->clk_iface);
+	reset_control_assert(priv->rst);
 	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_iface);
 
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
-- 
2.25.1

