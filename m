Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBF5FA576
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJJURl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJJUQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:16:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B157549A;
        Mon, 10 Oct 2022 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665432950; x=1696968950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZ0nLr7k71p8hXdbh21/wdsvbcpSOALoNnQYnblRInI=;
  b=QMdDM4MN0XoV6egvQRACq/80cJ/PyPbPfMlWpZNGqPx5IAB4t3xCTUoV
   6tla+LNISnMpknpwsNnVYI/PqWTjbTPN1RmsRuzCsUMOTmvF00pOTH30Z
   GwvmsquN/8XHVja8LzA8U+gxcnbAtRmQ6yQhBA0zTAlr/UmLmTrjBakyy
   sWYOvJTshzzGuVbXBePVU2zS4aq0R+F3Fx0yJjYlffn0hfH+focFVcsxV
   Np+JEOA6GvVRH9YngbwsMz4bkf0cfjC9vznAxS50BkqDzfSq+ALF7nrdf
   InjqxR54tWphczuLU4urIiUdOcrmZxMgYP59TEl2v1oyGirjyES5ctjWX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366317955"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366317955"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 13:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="715240800"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="715240800"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Oct 2022 13:15:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 66097766; Mon, 10 Oct 2022 23:15:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 19/36] pinctrl: renesas: Add missed header(s)
Date:   Mon, 10 Oct 2022 23:14:35 +0300
Message-Id: <20221010201453.77401-20-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not imply that some of the generic headers may be always included.
Instead, include explicitly what we are direct user of.

While at it, sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 7 +++++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 4 +++-
 drivers/pinctrl/renesas/pinctrl.c       | 8 +++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index a43824fd9505..a08eee092430 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -8,16 +8,19 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
-#include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+
+#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/spinlock.h>
 
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index e8c18198bebd..061f16c77304 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -15,11 +15,13 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/spinlock.h>
+
+#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/spinlock.h>
 
 #include <dt-bindings/pinctrl/rzv2m-pinctrl.h>
 
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
index b438d24c13b5..b74147800319 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -12,14 +12,16 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 
 #include "core.h"
 #include "../core.h"
-- 
2.35.1

