Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC9696915
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBNQRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjBNQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:17:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002F20051;
        Tue, 14 Feb 2023 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676391421; x=1707927421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2i+DTZuHLMmNkyjv/Ro4aJ2pGv9HHR2Ky3DwJ9SA03Y=;
  b=BAOF8DByM65dVCgscQDeWoFfvvsvx33VLBu3SeeGivlDMAZwNf/HC3bs
   3j1/2Od3rbmRnWen6HTL2lko4zaeTobeNd9YA2ZqH5uuktAVIDf52pRvw
   CRpU6nhLxfmdTr0PqNXFKoVx+75uJo1Nm17OJj7Vyb7mQvthQyXXU9IXI
   ij/j/eSefAkK1OaeiaEZrAUvtCte/gYxe+91Ym7dGYxv7CMAg1wVwLweZ
   btCAhD4qz+irpvvW0Z4H+9YVIOdAYmzLSc0GuUTFFrZdMT3d7OX5HVP4d
   ylUY3oIT9g5jux3RY0+Itfcvb4RrYWBvsKD2mkg4gpDp+Aj3tgBtDW6lo
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,297,1669100400"; 
   d="scan'208";a="196891398"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 09:17:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 09:16:58 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 09:16:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start DMA after DAI
Date:   Tue, 14 Feb 2023 18:14:33 +0200
Message-ID: <20230214161435.1088246-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to start DMA component after DAI trigger. This is done
by filling the new struct snd_dmaengine_pcm_config::start_dma_last.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/sound/dmaengine_pcm.h         |  1 +
 include/sound/soc-component.h         |  2 ++
 sound/soc/soc-generic-dmaengine-pcm.c |  8 +++++---
 sound/soc/soc-pcm.c                   | 27 ++++++++++++++++++++++-----
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2df54cf02cb3..4e3dcb94576d 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -149,6 +149,7 @@ struct snd_dmaengine_pcm_config {
 
 	const struct snd_pcm_hardware *pcm_hardware;
 	unsigned int prealloc_buffer_size;
+	unsigned int start_dma_last;
 };
 
 int snd_dmaengine_pcm_register(struct device *dev,
diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 3203d35bc8c1..0814ed143864 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -190,6 +190,8 @@ struct snd_soc_component_driver {
 	bool use_dai_pcm_id;	/* use DAI link PCM ID as PCM device number */
 	int be_pcm_base;	/* base device ID for all BE PCMs */
 
+	unsigned int start_dma_last;
+
 #ifdef CONFIG_DEBUG_FS
 	const char *debugfs_prefix;
 #endif
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 3b99f619e37e..264e87af6b58 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -318,7 +318,7 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 	return 0;
 }
 
-static const struct snd_soc_component_driver dmaengine_pcm_component = {
+static struct snd_soc_component_driver dmaengine_pcm_component = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 	.open		= dmaengine_pcm_open,
@@ -329,7 +329,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.pcm_construct	= dmaengine_pcm_new,
 };
 
-static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
+static struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 	.open		= dmaengine_pcm_open,
@@ -425,7 +425,7 @@ static const struct snd_dmaengine_pcm_config snd_dmaengine_pcm_default_config =
 int snd_dmaengine_pcm_register(struct device *dev,
 	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
 {
-	const struct snd_soc_component_driver *driver;
+	struct snd_soc_component_driver *driver;
 	struct dmaengine_pcm *pcm;
 	int ret;
 
@@ -450,6 +450,8 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	else
 		driver = &dmaengine_pcm_component;
 
+	driver->start_dma_last = config->start_dma_last;
+
 	ret = snd_soc_component_initialize(&pcm->component, driver, dev);
 	if (ret)
 		goto err_free_dma;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 005b179a770a..ec429b93a4ee 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1088,22 +1088,39 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	int ret = -EINVAL, _ret = 0;
+	struct snd_soc_component *component;
+	int ret = -EINVAL, _ret = 0, start_dma_last = 0, i;
 	int rollback = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/* Do we need to start dma first? */
+		for_each_rtd_components(rtd, i, component) {
+			if (component->driver->start_dma_last) {
+				start_dma_last = 1;
+				break;
+			}
+		}
+
 		ret = snd_soc_link_trigger(substream, cmd, 0);
 		if (ret < 0)
 			goto start_err;
 
-		ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
-		if (ret < 0)
-			goto start_err;
+		if (start_dma_last) {
+			ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
+			if (ret < 0)
+				goto start_err;
+
+			ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
+		} else {
+			ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
+			if (ret < 0)
+				goto start_err;
 
-		ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
+			ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
+		}
 start_err:
 		if (ret < 0)
 			rollback = 1;
-- 
2.34.1

