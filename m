Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027B3625276
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiKKEZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiKKEZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105AB68AD8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140717; x=1699676717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sD0dT5NhS8PzyWlKcgoNPYtT3Av68O8HdUo5PuTklMM=;
  b=BpZzqFk5W3s9KrycLEpmD/g/7jS2TO7F8tj02bBpoL4mSRnt2EV1ZHN9
   V4sKnFneucGcg/tgs3WmArvjlVyzRhKKvbbERWKOU5vmzxX5W94GldNAI
   1spCkDKlI7PEQmVhKCESjNdBGbPjBDOHYzG+88Kt4cis+1rzHPGfqZ3Kq
   ojFULPctqawK/7LXxxfLp3PwYLZGBeBs1cxmKnTPKEEuNT8G6To17KcxL
   7Va2LEyi9WZc17d+nI3D/6GLfkzSZVxRJcOnpTVO5S/4AJ5yQliRQ2+5J
   5EgBVfF2zr9lr4UpNY2CvzP2OEf0NCxOirtFHyT5UiNWOF8axzObUz/ad
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816307"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816307"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440750"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440750"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:14 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 5/8] ASoC: SOF: Intel: hda: add callback to check SoundWire lcount information
Date:   Fri, 11 Nov 2022 12:26:50 +0800
Message-Id: <20221111042653.45520-6-yung-chuan.liao@linux.intel.com>
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

The number of links is stored in different registers depending on the
IP version, add sdw_check_lcount() callback. This callback only checks
that the number of links supported in hardware is compatible with the
number of links exposed in ACPI _DSD properties.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c  |  2 ++
 sound/soc/sof/intel/hda.c  | 39 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h  |  6 ++++++
 sound/soc/sof/intel/icl.c  |  1 +
 sound/soc/sof/intel/mtl.c  |  1 +
 sound/soc/sof/intel/shim.h |  1 +
 sound/soc/sof/intel/tgl.c  |  4 ++++
 7 files changed, 54 insertions(+)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index cbb6474d5c33..6b075bbe5bfb 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -457,6 +457,7 @@ const struct sof_intel_dsp_desc cnl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
@@ -491,6 +492,7 @@ const struct sof_intel_dsp_desc jsl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 2dc828866b5b..2f9d69e64091 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -238,10 +238,45 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+int hda_sdw_check_lcount_common(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	struct sdw_intel_ctx *ctx;
+	u32 caps;
+
+	hdev = sdev->pdata->hw_pdata;
+	ctx = hdev->sdw;
+
+	caps = snd_sof_dsp_read(sdev, HDA_DSP_BAR, ctx->shim_base + SDW_SHIM_LCAP);
+	caps &= SDW_SHIM_LCAP_LCOUNT_MASK;
+
+	/* Check HW supported vs property value */
+	if (caps < ctx->count) {
+		dev_err(sdev->dev,
+			"BIOS master count %d is larger than hardware capabilities %d\n",
+			ctx->count, caps);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hda_sdw_check_lcount(struct snd_sof_dev *sdev)
+{
+	const struct sof_intel_dsp_desc *chip;
+
+	chip = get_chip_info(sdev->pdata);
+	if (chip && chip->read_sdw_lcount)
+		return chip->read_sdw_lcount(sdev);
+
+	return 0;
+}
+
 int hda_sdw_startup(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hdev;
 	struct snd_sof_pdata *pdata = sdev->pdata;
+	int ret;
 
 	hdev = sdev->pdata->hw_pdata;
 
@@ -251,6 +286,10 @@ int hda_sdw_startup(struct snd_sof_dev *sdev)
 	if (pdata->machine && !pdata->machine->mach_params.link_mask)
 		return 0;
 
+	ret = hda_sdw_check_lcount(sdev);
+	if (ret < 0)
+		return ret;
+
 	return sdw_intel_startup(hdev->sdw);
 }
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 79fccd7b5bf7..022ce80968dd 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -795,6 +795,7 @@ int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
  */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
+int hda_sdw_check_lcount_common(struct snd_sof_dev *sdev);
 int hda_sdw_startup(struct snd_sof_dev *sdev);
 void hda_common_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable);
 void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
@@ -803,6 +804,11 @@ bool hda_common_check_sdw_irq(struct snd_sof_dev *sdev);
 
 #else
 
+static inline int hda_sdw_check_lcount_common(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
 static inline int hda_sdw_startup(struct snd_sof_dev *sdev)
 {
 	return 0;
diff --git a/sound/soc/sof/intel/icl.c b/sound/soc/sof/intel/icl.c
index f3aff23a13d2..435941a1692f 100644
--- a/sound/soc/sof/intel/icl.c
+++ b/sound/soc/sof/intel/icl.c
@@ -181,6 +181,7 @@ const struct sof_intel_dsp_desc icl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index a0839804a6da..904ae42534e1 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -654,6 +654,7 @@ const struct sof_intel_dsp_desc mtl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE_ACE,
 	.sdw_alh_base = SDW_ALH_BASE_ACE,
 	.d0i3_offset = MTL_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq = mtl_enable_sdw_irq,
 	.check_sdw_irq = mtl_dsp_check_sdw_irq,
 	.check_ipc_irq = mtl_dsp_check_ipc_irq,
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index 2e78f27c4207..48428ccbcfe0 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -185,6 +185,7 @@ struct sof_intel_dsp_desc {
 	u32 d0i3_offset;
 	u32 quirks;
 	enum sof_intel_hw_ip_version hw_ip_version;
+	int (*read_sdw_lcount)(struct snd_sof_dev *sdev);
 	void (*enable_sdw_irq)(struct snd_sof_dev *sdev, bool enable);
 	bool (*check_sdw_irq)(struct snd_sof_dev *sdev);
 	bool (*check_ipc_irq)(struct snd_sof_dev *sdev);
diff --git a/sound/soc/sof/intel/tgl.c b/sound/soc/sof/intel/tgl.c
index dda89c8ea820..30f2f49ee149 100644
--- a/sound/soc/sof/intel/tgl.c
+++ b/sound/soc/sof/intel/tgl.c
@@ -136,6 +136,7 @@ const struct sof_intel_dsp_desc tgl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
@@ -163,6 +164,7 @@ const struct sof_intel_dsp_desc tglh_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
@@ -190,6 +192,7 @@ const struct sof_intel_dsp_desc ehl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
@@ -217,6 +220,7 @@ const struct sof_intel_dsp_desc adls_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
 	.d0i3_offset = SOF_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_common,
 	.enable_sdw_irq	= hda_common_enable_sdw_irq,
 	.check_sdw_irq	= hda_common_check_sdw_irq,
 	.check_ipc_irq	= hda_dsp_check_ipc_irq,
-- 
2.25.1

