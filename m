Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BBC70255F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbjEOGwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjEOGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:51:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE031BC2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133484; x=1715669484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NUsvy+Y8PVO2h/Op18ecWWhry3F8Mgpf7FkeQTkvn0=;
  b=oARujuJ+JNIYigcwMM9TinWyrrchY4iTywsHA4KrBm4aIDoWLarJoJL8
   1a/5vkkh6pg4i++D/eTSvah2MFVm9j9wciu4b9ZSmF/TQlW2YiFey+Nyy
   N1fUzfEFcX2eEDL+zmQYO8iySB0Nk/j7dFk5qgVRBWH/sSciWHiQZkFQt
   1amy+QAX9HYwJ6+Q2Ilc3AhiS+jOkSuXFagPQUm0qJoeGuF0mKnjyUIJp
   Y8AudIgok3E6qQX1kon7MNNuNKzF+wS8BjtfQxLHWWOGKcsBUv8HVilr8
   ArHL9GTYKZ3SfqYIIXr4W7IRDIu98FmebmZz/iagltB+QYRtZ/Tk+aDTw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966431"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966431"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908730"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908730"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 14/26] soundwire: intel_ace2x: add DAI registration
Date:   Mon, 15 May 2023 15:10:30 +0800
Message-Id: <20230515071042.2038-15-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The code is similar to the previous implementation, the only
difference is that the PDI descriptors are now in different areas.

Using common helpers proves tricky with multiple changed registers,
workarounds that are no longer necessary. It's simpler to duplicate
the intel_register_dai() function rather than try to add multiple
levels of abstraction and indirections.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 161 ++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 5deff32976f1..d6d5e6e070f4 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -116,10 +116,171 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	return ret;
 }
 
+/*
+ * DAI operations
+ */
+static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
+};
+
+static const struct snd_soc_component_driver dai_component = {
+	.name			= "soundwire",
+};
+
+/*
+ * PDI routines
+ */
+static void intel_pdi_init(struct sdw_intel *sdw,
+			   struct sdw_cdns_stream_config *config)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	int pcm_cap;
+
+	/* PCM Stream Capability */
+	pcm_cap = intel_readw(shim, SDW_SHIM2_PCMSCAP);
+
+	config->pcm_bd = FIELD_GET(SDW_SHIM2_PCMSCAP_BSS, pcm_cap);
+	config->pcm_in = FIELD_GET(SDW_SHIM2_PCMSCAP_ISS, pcm_cap);
+	config->pcm_out = FIELD_GET(SDW_SHIM2_PCMSCAP_ISS, pcm_cap);
+
+	dev_dbg(sdw->cdns.dev, "PCM cap bd:%d in:%d out:%d\n",
+		config->pcm_bd, config->pcm_in, config->pcm_out);
+}
+
+static int
+intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num)
+{
+	void __iomem *shim = sdw->link_res->shim;
+
+	/* zero based values for channel count in register */
+	return intel_readw(shim, SDW_SHIM2_PCMSYCHC(pdi_num)) + 1;
+}
+
+static void intel_pdi_get_ch_update(struct sdw_intel *sdw,
+				    struct sdw_cdns_pdi *pdi,
+				    unsigned int num_pdi,
+				    unsigned int *num_ch)
+{
+	int ch_count = 0;
+	int i;
+
+	for (i = 0; i < num_pdi; i++) {
+		pdi->ch_count = intel_pdi_get_ch_cap(sdw, pdi->num);
+		ch_count += pdi->ch_count;
+		pdi++;
+	}
+
+	*num_ch = ch_count;
+}
+
+static void intel_pdi_stream_ch_update(struct sdw_intel *sdw,
+				       struct sdw_cdns_streams *stream)
+{
+	intel_pdi_get_ch_update(sdw, stream->bd, stream->num_bd,
+				&stream->num_ch_bd);
+
+	intel_pdi_get_ch_update(sdw, stream->in, stream->num_in,
+				&stream->num_ch_in);
+
+	intel_pdi_get_ch_update(sdw, stream->out, stream->num_out,
+				&stream->num_ch_out);
+}
+
+static int intel_create_dai(struct sdw_cdns *cdns,
+			    struct snd_soc_dai_driver *dais,
+			    enum intel_pdi_type type,
+			    u32 num, u32 off, u32 max_ch)
+{
+	int i;
+
+	if (!num)
+		return 0;
+
+	for (i = off; i < (off + num); i++) {
+		dais[i].name = devm_kasprintf(cdns->dev, GFP_KERNEL,
+					      "SDW%d Pin%d",
+					      cdns->instance, i);
+		if (!dais[i].name)
+			return -ENOMEM;
+
+		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
+			dais[i].playback.channels_min = 1;
+			dais[i].playback.channels_max = max_ch;
+		}
+
+		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
+			dais[i].capture.channels_min = 1;
+			dais[i].capture.channels_max = max_ch;
+		}
+
+		dais[i].ops = &intel_pcm_dai_ops;
+	}
+
+	return 0;
+}
+
+static int intel_register_dai(struct sdw_intel *sdw)
+{
+	struct sdw_cdns_dai_runtime **dai_runtime_array;
+	struct sdw_cdns_stream_config config;
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_cdns_streams *stream;
+	struct snd_soc_dai_driver *dais;
+	int num_dai;
+	int ret;
+	int off = 0;
+
+	/* Read the PDI config and initialize cadence PDI */
+	intel_pdi_init(sdw, &config);
+	ret = sdw_cdns_pdi_init(cdns, config);
+	if (ret)
+		return ret;
+
+	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm);
+
+	/* DAIs are created based on total number of PDIs supported */
+	num_dai = cdns->pcm.num_pdi;
+
+	dai_runtime_array = devm_kcalloc(cdns->dev, num_dai,
+					 sizeof(struct sdw_cdns_dai_runtime *),
+					 GFP_KERNEL);
+	if (!dai_runtime_array)
+		return -ENOMEM;
+	cdns->dai_runtime_array = dai_runtime_array;
+
+	dais = devm_kcalloc(cdns->dev, num_dai, sizeof(*dais), GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+
+	/* Create PCM DAIs */
+	stream = &cdns->pcm;
+
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pcm.num_in,
+			       off, stream->num_ch_in);
+	if (ret)
+		return ret;
+
+	off += cdns->pcm.num_in;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns->pcm.num_out,
+			       off, stream->num_ch_out);
+	if (ret)
+		return ret;
+
+	off += cdns->pcm.num_out;
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pcm.num_bd,
+			       off, stream->num_ch_bd);
+	if (ret)
+		return ret;
+
+	return devm_snd_soc_register_component(cdns->dev, &dai_component,
+					       dais, num_dai);
+}
+
 const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.debugfs_init = intel_ace2x_debugfs_init,
 	.debugfs_exit = intel_ace2x_debugfs_exit,
 
+	.register_dai = intel_register_dai,
+
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
 };
-- 
2.25.1

