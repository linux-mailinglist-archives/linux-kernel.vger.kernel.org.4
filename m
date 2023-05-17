Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2970648F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEQJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjEQJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:50:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCBB4C3C;
        Wed, 17 May 2023 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684317052; x=1715853052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dp4AjByrGPPW2+s+Gu4zde9gjuLVVm2MN56x4f0uc3E=;
  b=2ap01Xs4Og0LcphINKfroNj4F6Ig0hCPNRVPokVwyffd5nS+aUsNR7L6
   kquJJtfFdam5h1BCLXvh9ZeI1dSbULlV10ImPtKsb1PWrcNwRdPFETBnp
   A7yMJTFI4vespT3DGSWZI8NeM/2u8Y+zhYlcdF1fo6SM9pZUETGeEa2CE
   iFp4+ElmMfSKSUqqhhpoeE3w1oLcF92IWLbhCGpuOMtayiEP4BmwBf3Rd
   4vLrIsCs9mQx5WPtjK9rawg2rgRYp/SyqykEqNfA0CuIR1VfoDOE+Pm+I
   u5M6zrWuholnQ6mbxch4oO0JAYOqzIcaryPChCOOkbU+Hz8kFyXeMJHMN
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="scan'208";a="211699133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 02:50:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 02:50:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 02:50:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <oder_chiou@realtek.com>,
        <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>,
        <festevam@gmail.com>, <nicoleotsuka@gmail.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <cezary.rojewski@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <vkoul@kernel.org>, <daniel.baluta@nxp.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jarkko.nikula@bitmer.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/2] ASoC: use pm.h instead of runtime_pm.h
Date:   Wed, 17 May 2023 12:49:03 +0300
Message-ID: <20230517094903.2895238-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517094903.2895238-1-claudiu.beznea@microchip.com>
References: <20230517094903.2895238-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include pm_runtime.h header in files where runtime PM support is
not implemented. Use pm.h instead as suspend to RAM specific
implementation is available.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/codecs/max98373-i2c.c | 2 +-
 sound/soc/qcom/lpass-sc7180.c   | 2 +-
 sound/soc/qcom/lpass-sc7280.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 3d6da4f133de..0fa5ceca62a2 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -9,7 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
-#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/cdev.h>
diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 41db6617e2ed..56db852f4eab 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 #include <dt-bindings/sound/sc7180-lpass.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
index d43f480cbae3..bcf18fe8e14d 100644
--- a/sound/soc/qcom/lpass-sc7280.c
+++ b/sound/soc/qcom/lpass-sc7280.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 
 #include <dt-bindings/sound/sc7180-lpass.h>
 
-- 
2.34.1

