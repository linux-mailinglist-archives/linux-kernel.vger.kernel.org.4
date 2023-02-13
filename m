Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E447694C37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBMQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBMQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:16:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11186196BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676305012; x=1707841012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cZTTeKU937sx7b1HCCuAu24tBsbF1+KVsSvF5ZVAqfw=;
  b=lykMT1i2Dd0VjmMPj7kAnC0rAR/R7Mg9NpPch1aS5PADYN0+XYDAsxbO
   IqZxNqBImO0Yu+mcr8xmbLmY+ucL51jAlw9mFGJxIK/FrQGiAdFAMggpT
   KQ9eN7Sdfd5Jdh57ze6c372qlpZF20VMI2Rc8z2NqN21QtNsiL1pKMslp
   FVICWGdXV5NDDJ2H3ybSjp2oo6DH1FjjSWpoyMSs+nekqPZ9331Rk4WTd
   S1K5G3pZW5r4k9gnssENhjcMOyV25GLt1sam/HixxDkd9XMHMfrnZh/Qx
   VFd5toeRIq00zzz7ypDDExGVIg8pp3zNXHCVhK9nJw/2+10fPjOFs7y4d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310560334"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310560334"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 08:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="670874415"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="670874415"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2023 08:16:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D9BC61A6; Mon, 13 Feb 2023 18:17:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: soc-ac97: Convert to agnostic GPIO API
Date:   Mon, 13 Feb 2023 18:17:13 +0200
Message-Id: <20230213161713.1450-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio.h is going to be removed. In preparation of that convert
the driver to the agnostic API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/soc-ac97.c | 68 ++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 46 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 32c5be61e2ec..40051f513c6a 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -14,10 +14,9 @@
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/export.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/slab.h>
@@ -29,9 +28,9 @@ struct snd_ac97_reset_cfg {
 	struct pinctrl_state *pstate_reset;
 	struct pinctrl_state *pstate_warm_reset;
 	struct pinctrl_state *pstate_run;
-	int gpio_sdata;
-	int gpio_sync;
-	int gpio_reset;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *sdata_gpio;
+	struct gpio_desc *sync_gpio;
 };
 
 static struct snd_ac97_bus soc_ac97_bus = {
@@ -268,11 +267,11 @@ static void snd_soc_ac97_warm_reset(struct snd_ac97 *ac97)
 
 	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_warm_reset);
 
-	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 1);
+	gpiod_direction_output_raw(snd_ac97_rst_cfg.sync_gpio, 1);
 
 	udelay(10);
 
-	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 0);
+	gpiod_direction_output_raw(snd_ac97_rst_cfg.sync_gpio, 0);
 
 	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_run);
 	msleep(2);
@@ -284,13 +283,13 @@ static void snd_soc_ac97_reset(struct snd_ac97 *ac97)
 
 	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_reset);
 
-	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 0);
-	gpio_direction_output(snd_ac97_rst_cfg.gpio_sdata, 0);
-	gpio_direction_output(snd_ac97_rst_cfg.gpio_reset, 0);
+	gpiod_direction_output_raw(snd_ac97_rst_cfg.sync_gpio, 0);
+	gpiod_direction_output_raw(snd_ac97_rst_cfg.sdata_gpio, 0);
+	gpiod_direction_output_raw(snd_ac97_rst_cfg.reset_gpio, 0);
 
 	udelay(10);
 
-	gpio_direction_output(snd_ac97_rst_cfg.gpio_reset, 1);
+	gpiod_direction_output_raw(snd_ac97_rst_cfg.reset_gpio, 1);
 
 	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_run);
 	msleep(2);
@@ -301,8 +300,6 @@ static int snd_soc_ac97_parse_pinctl(struct device *dev,
 {
 	struct pinctrl *p;
 	struct pinctrl_state *state;
-	int gpio;
-	int ret;
 
 	p = devm_pinctrl_get(dev);
 	if (IS_ERR(p)) {
@@ -332,41 +329,20 @@ static int snd_soc_ac97_parse_pinctl(struct device *dev,
 	}
 	cfg->pstate_run = state;
 
-	gpio = of_get_named_gpio(dev->of_node, "ac97-gpios", 0);
-	if (gpio < 0) {
-		dev_err(dev, "Can't find ac97-sync gpio\n");
-		return gpio;
-	}
-	ret = devm_gpio_request(dev, gpio, "AC97 link sync");
-	if (ret) {
-		dev_err(dev, "Failed requesting ac97-sync gpio\n");
-		return ret;
-	}
-	cfg->gpio_sync = gpio;
+	cfg->sync_gpio = devm_gpiod_get_index(dev, "ac97", 0, GPIOD_ASIS);
+	if (IS_ERR(cfg->sync_gpio))
+		return dev_err_probe(dev, PTR_ERR(cfg->sync_gpio), "Can't find ac97-sync gpio\n");
+	gpiod_set_consumer_name(cfg->sync_gpio, "AC97 link sync");
 
-	gpio = of_get_named_gpio(dev->of_node, "ac97-gpios", 1);
-	if (gpio < 0) {
-		dev_err(dev, "Can't find ac97-sdata gpio %d\n", gpio);
-		return gpio;
-	}
-	ret = devm_gpio_request(dev, gpio, "AC97 link sdata");
-	if (ret) {
-		dev_err(dev, "Failed requesting ac97-sdata gpio\n");
-		return ret;
-	}
-	cfg->gpio_sdata = gpio;
+	cfg->sdata_gpio = devm_gpiod_get_index(dev, "ac97", 1, GPIOD_ASIS);
+	if (IS_ERR(cfg->sdata_gpio))
+		return dev_err_probe(dev, PTR_ERR(cfg->sync_gpio), "Can't find ac97-sdata gpio\n");
+	gpiod_set_consumer_name(cfg->sdata_gpio, "AC97 link sdata");
 
-	gpio = of_get_named_gpio(dev->of_node, "ac97-gpios", 2);
-	if (gpio < 0) {
-		dev_err(dev, "Can't find ac97-reset gpio\n");
-		return gpio;
-	}
-	ret = devm_gpio_request(dev, gpio, "AC97 link reset");
-	if (ret) {
-		dev_err(dev, "Failed requesting ac97-reset gpio\n");
-		return ret;
-	}
-	cfg->gpio_reset = gpio;
+	cfg->reset_gpio = devm_gpiod_get_index(dev, "ac97", 2, GPIOD_ASIS);
+	if (IS_ERR(cfg->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(cfg->sync_gpio), "Can't find ac97-reset gpio\n");
+	gpiod_set_consumer_name(cfg->reset_gpio, "AC97 link reset");
 
 	return 0;
 }
-- 
2.39.1

