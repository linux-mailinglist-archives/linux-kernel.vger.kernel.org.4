Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC93706488
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEQJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEQJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:50:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697055A6;
        Wed, 17 May 2023 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684317023; x=1715853023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mtw2/tREMJ9jAsgNoVakn6fr09xbBwzqX6/cCqtFuL4=;
  b=EXRAhTb1Of5pRAoaQV1lJQpJXcry0kU02Dsd/vGn+She4uoirGPlpD5r
   lRWmvK1vu4m/C6DHt1XjiEwGlwI5IKpxkniF8kNTxbp1Y6QLOs2Lucy0j
   Y8AsNtaUX0wei4G2cI9JUfo0D7i8b0mDtltNCB0bvIQseTaDQ3Kwo17ko
   IZqMSPLzKUGNvGtgwEBbzdMjWUVofa3clCIPlPgKFjJfR3OPbvI/UW2Ma
   9mQCI6DhnvKe0wqwyw3iHEzEDGrPwWm7FNlGBrboKHLS5Bcqlu/FCFegm
   zBgE0iPXMAc63fX/+PK7wVbU0FME5YYsewhRcHQ7tyxswd1855RSy8MsJ
   w==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="scan'208";a="215854634"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 02:50:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 02:50:19 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 02:50:09 -0700
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
Subject: [PATCH v2 0/2] ASoC: do not include runtime_pm.h if not needed
Date:   Wed, 17 May 2023 12:49:01 +0300
Message-ID: <20230517094903.2895238-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

Series removes the pm_runtime.h inclusion in files where
APIs exported though pm_runtime.h are not used. In case
of files that make use of pm.h which comes form pm_runtime.h
added patch 2/2.

Changes were built with allmodconfig on ARM and x86_64 and checked
all the changed files were built at least once.

Thank you,
Claudiu Beznea

Changes in v2:
- removed cs35l45 handling
- changed a bit commit description
- added patch 2/2
- collected Jarkko Nikula's tag

Claudiu Beznea (2):
  ASoC: do not include pm_runtime.h if not used
  ASoC: use pm.h instead of runtime_pm.h

 sound/hda/hdac_regmap.c                                   | 1 -
 sound/pci/hda/hda_bind.c                                  | 1 -
 sound/soc/amd/acp/acp-pci.c                               | 1 -
 sound/soc/amd/acp/acp-platform.c                          | 1 -
 sound/soc/codecs/max98090.c                               | 1 -
 sound/soc/codecs/max98373-i2c.c                           | 2 +-
 sound/soc/codecs/pcm186x.c                                | 1 -
 sound/soc/codecs/rk3328_codec.c                           | 1 -
 sound/soc/codecs/rt5682-i2c.c                             | 1 -
 sound/soc/codecs/rt5682s.c                                | 1 -
 sound/soc/codecs/tas2562.c                                | 1 -
 sound/soc/codecs/tas5720.c                                | 1 -
 sound/soc/codecs/tas6424.c                                | 1 -
 sound/soc/codecs/wm_adsp.c                                | 1 -
 sound/soc/fsl/imx-audmix.c                                | 1 -
 sound/soc/intel/atom/sst/sst_acpi.c                       | 1 -
 sound/soc/intel/atom/sst/sst_ipc.c                        | 1 -
 sound/soc/intel/atom/sst/sst_loader.c                     | 1 -
 sound/soc/intel/atom/sst/sst_pci.c                        | 1 -
 sound/soc/intel/atom/sst/sst_stream.c                     | 1 -
 sound/soc/mediatek/mt8186/mt8186-afe-control.c            | 1 -
 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c | 1 -
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c  | 1 -
 sound/soc/mediatek/mt8192/mt8192-afe-control.c            | 2 --
 sound/soc/qcom/lpass-sc7180.c                             | 2 +-
 sound/soc/qcom/lpass-sc7280.c                             | 2 +-
 sound/soc/soc-compress.c                                  | 1 -
 sound/soc/soc-pcm.c                                       | 1 -
 sound/soc/sof/intel/hda-loader-skl.c                      | 1 -
 sound/soc/sof/intel/hda-stream.c                          | 1 -
 sound/soc/sof/intel/skl.c                                 | 1 -
 sound/soc/sof/mediatek/mt8186/mt8186-clk.c                | 1 -
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c                | 1 -
 sound/soc/tegra/tegra20_ac97.c                            | 1 -
 sound/soc/ti/omap-mcbsp-st.c                              | 1 -
 35 files changed, 3 insertions(+), 36 deletions(-)

-- 
2.34.1

