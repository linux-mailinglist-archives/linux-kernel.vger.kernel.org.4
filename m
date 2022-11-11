Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA2625270
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKKEZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiKKEZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039D682B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140709; x=1699676709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=depyS39p+nqbjkrSWPNdTKa3bhRfj4+k8n/5TB+rs4I=;
  b=LyGMIB6m9EKXNm4yQXorY5qxrf7IwR0UCveS6dQEARmn+k8nzZli0AwJ
   iLg6lUKiBetrRECHq9XVDXIkF8TSJPJ/PKBQGNvTG2VZfhq3cOwes+5mB
   SLf2wdocc2hN7ByVPRepyPU2DLdBRlz2Ns8oOWZOq0CbJkWCl/HC1kee3
   /I05YVObSWZtrgeitv1E92pcFtkOTC6U3aU/DwWEVv8zv5omUGR+cjZuz
   O0zOnVwZDqSN43OmRVlzaATkTkhq6j8kPExOb+VrxE0H9lujUGduoKlmD
   u00FnSIiSLBmS12NmS+ohzh0LV0uN+RV3Euvuv0tZEAxk0eoKGZ265WGk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816278"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440690"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440690"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:06 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/8] ASoC: SOF: Intel: hda: add per-chip enable_sdw_irq() callback
Date:   Fri, 11 Nov 2022 12:26:47 +0800
Message-Id: <20221111042653.45520-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Different generations of Intel hardware rely on different programming
sequences to enable SoundWire IP. In existing hardware, the SoundWire
interrupt is enabled with a register field in the DSP register
space. With HDaudio multi-link extensions registers, the SoundWire
interrupt will be enabled with a generic interrupt enable field in
LCTL, without any dependency on the DSP being enabled.

Add a per-chip callback following the example of the check_sdw_irq()
model already upstream.

Note that the callback is not populated yet for MeteorLake (MTL) since
the interrupts are already enabled in the init. A follow-up patch will
move the functionality to this callback after a couple of cleanups.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c  |  2 ++
 sound/soc/sof/intel/hda.c  | 20 +++++++++++++++++++-
 sound/soc/sof/intel/hda.h  |  6 ++++++
 sound/soc/sof/intel/icl.c  |  1 +
 sound/soc/sof/intel/shim.h |  1 +
 sound/soc/sof/intel/tgl.c  |  4 ++++
 6 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 0aaa44bd49eb..cbb6474d5c33 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -457,6 +457,7 @@ const struct sof_intel_dsp_desc cnl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
@@ -490,6 +491,7 @@ const struct sof_intel_dsp_desc jsl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 348fbfb6a2c2..2dc828866b5b 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -155,9 +155,27 @@ struct sdw_intel_ops sdw_callback = {
 	.free_stream = sdw_free_stream,
 };
 
+void hda_common_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable)
+{
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	if (!hdev->sdw)
+		return;
+
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC2,
+				HDA_DSP_REG_ADSPIC2_SNDW,
+				enable ? HDA_DSP_REG_ADSPIC2_SNDW : 0);
+}
+
 void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 {
-	sdw_intel_enable_irq(sdev->bar[HDA_DSP_BAR], enable);
+	const struct sof_intel_dsp_desc *chip;
+
+	chip = get_chip_info(sdev->pdata);
+	if (chip && chip->enable_sdw_irq)
+		chip->enable_sdw_irq(sdev, enable);
 }
 
 static int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index ea73fd17ae28..79fccd7b5bf7 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -294,6 +294,7 @@
 #define HDA_DSP_REG_ADSPIC2		(HDA_DSP_GEN_BASE + 0x10)
 #define HDA_DSP_REG_ADSPIS2		(HDA_DSP_GEN_BASE + 0x14)
 
+#define HDA_DSP_REG_ADSPIC2_SNDW	BIT(5)
 #define HDA_DSP_REG_ADSPIS2_SNDW	BIT(5)
 
 /* Intel HD Audio Inter-Processor Communication Registers */
@@ -795,6 +796,7 @@ int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
 int hda_sdw_startup(struct snd_sof_dev *sdev);
+void hda_common_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable);
 void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
 void hda_sdw_process_wakeen(struct snd_sof_dev *sdev);
 bool hda_common_check_sdw_irq(struct snd_sof_dev *sdev);
@@ -806,6 +808,10 @@ static inline int hda_sdw_startup(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+static inline void hda_common_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable)
+{
+}
+
 static inline void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 {
 }
diff --git a/sound/soc/sof/intel/icl.c b/sound/soc/sof/intel/icl.c
index 8dd51f489ba1..f3aff23a13d2 100644
--- a/sound/soc/sof/intel/icl.c
+++ b/sound/soc/sof/intel/icl.c
@@ -181,6 +181,7 @@ const struct sof_intel_dsp_desc icl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index 3e777c500a56..2e78f27c4207 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -185,6 +185,7 @@ struct sof_intel_dsp_desc {
 	u32 d0i3_offset;
 	u32 quirks;
 	enum sof_intel_hw_ip_version hw_ip_version;
+	void (*enable_sdw_irq)(struct snd_sof_dev *sdev, bool enable);
 	bool (*check_sdw_irq)(struct snd_sof_dev *sdev);
 	bool (*check_ipc_irq)(struct snd_sof_dev *sdev);
 	int (*power_down_dsp)(struct snd_sof_dev *sdev);
diff --git a/sound/soc/sof/intel/tgl.c b/sound/soc/sof/intel/tgl.c
index 946044f440c9..dda89c8ea820 100644
--- a/sound/soc/sof/intel/tgl.c
+++ b/sound/soc/sof/intel/tgl.c
@@ -136,6 +136,7 @@ const struct sof_intel_dsp_desc tgl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
@@ -162,6 +163,7 @@ const struct sof_intel_dsp_desc tglh_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
@@ -188,6 +190,7 @@ const struct sof_intel_dsp_desc ehl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
@@ -214,6 +217,7 @@ const struct sof_intel_dsp_desc adls_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
 	.cl_init = cl_dsp_init,
-- 
2.25.1

