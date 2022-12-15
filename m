Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8B64DF21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLOQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:58:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F11034;
        Thu, 15 Dec 2022 08:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D071961E50;
        Thu, 15 Dec 2022 16:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BBC433EF;
        Thu, 15 Dec 2022 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123523;
        bh=Y7pEym60yvUxhYqNdXQuKZ6QP/KXbyEQrogMoUgmgms=;
        h=From:To:Cc:Subject:Date:From;
        b=r73QZ5ilKn5RDB1jKrdHIAWPvucaK7WeBsnh+6NUKFI+TsnpYYlcAPUUQQQ3dl0pt
         QdxLQGS93jvQ/QaSrrcYiYRmi8XJw2eR8zhTmPl7J7uGdRbf6SQVY8OV6X2+Y+NuiU
         j3wJ3bmDaFYKIMGRGQkobXX/D/dxI+zPgivWLJvjGRMxkwLUk/cUKhdo8d0aD6QijU
         PTW5aCsCqg1oVNEG6/JXCeCSnAvVwTMFW2+mhSKWLNSzhOuXedW0+JYMY19a4p8oBB
         CkFJGCsEsncOxsfIqtNa6Cm55EBsaaKZ3YLtQeZZfCgiUjLP8h8nqFJl7t8EjuqB+8
         TpcERSTWgEcTQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: fix compile testing imxrt1050
Date:   Thu, 15 Dec 2022 17:58:18 +0100
Message-Id: <20221215165836.2136448-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Randconfig testing revealed multiple issues with this driver:

ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-imxrt1050.o
ERROR: modpost: "imx_clk_hw_pllv3" [drivers/clk/imx/clk-imxrt1050.ko] undefined!
ERROR: modpost: "imx_clk_hw_pfd" [drivers/clk/imx/clk-imxrt1050.ko] undefined!

Export the necessary symbols from the core clk driver and add the
license and author tags. To find this type of problem more easily
in the future, also enable building on other platforms, as we do for
the other i.MX clk drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/imx/Kconfig         | 2 +-
 drivers/clk/imx/clk-imxrt1050.c | 4 ++++
 drivers/clk/imx/clk-pfd.c       | 2 ++
 drivers/clk/imx/clk-pllv3.c     | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 25785ec9c276..f6b82e0b9703 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -115,7 +115,7 @@ config CLK_IMX93
 
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
-	depends on SOC_IMXRT
+	depends on SOC_IMXRT || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MXRT1050 CCM Clock Driver
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index e972abd299a8..fd5c51fc92c0 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -167,3 +167,7 @@ static struct platform_driver imxrt1050_clk_driver = {
 	},
 };
 module_platform_driver(imxrt1050_clk_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Jesse Taube <Mr.Bossman075@gmail.com>");
+MODULE_AUTHOR("Giulio Benetti <giulio.benetti@benettiengineering.com>");
diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
index 5d2a9a3be95e..5cf0149dfa15 100644
--- a/drivers/clk/imx/clk-pfd.c
+++ b/drivers/clk/imx/clk-pfd.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -153,3 +154,4 @@ struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_pfd);
diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index eea32f87c60a..11fb238ee8f0 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -486,3 +487,4 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_pllv3);
-- 
2.35.1

